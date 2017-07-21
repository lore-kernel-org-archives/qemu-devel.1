Received: from eggs.gnu.org ([2001:4830:134:3::10]:57632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYUz6-00042C-LZ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYUz2-0004OZ-J2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dYUz2-0004OE-9j
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:16:32 -0400
Date: Fri, 21 Jul 2017 11:16:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170721101623.GI17693@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
	<20170721094955.GH17693@redhat.com>
	<20170721121048.44d617ea@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170721121048.44d617ea@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Programmingkid <programmingkidx@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>

On Fri, Jul 21, 2017 at 12:10:48PM +0200, Igor Mammedov wrote:
> On Fri, 21 Jul 2017 10:49:55 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
> > On Fri, Jul 21, 2017 at 11:32:11AM +0200, Igor Mammedov wrote:
> > > w2k used to boot on QEMU until we bumped revision of FADT to rev3
> > > (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.)
> > > 
> > > Considering that w2k is ancient and long time EOLed, leave default
> > > rev3 but make pc-i440fx-2.9 and older machine types to force rev1
> > > so old setups won't break (w2k could boot).  
> > 
> > There needs to be a machine type property added to control this
> > feature. When provisioning new VMs, management apps need to be
> > able to set the property explicitly - having them rely on picking
> > particular machine type name+versions is not viable, because
> > downstream vendors replace the machine types with their own
> > names + versions.
> having property doesn't really help here and we don't do it for every
> compat tweak /ex: save_tsc_khz, linuxboot_dma_enabled/.

If those compat tweaks affect compatibility with particular guest
OS then they should definitely be exposed as properties too.

> Management would not benefit much from having property vs machine version
> as it would have to encode somewhere that for w2k it should set
> some machine property or pick a particular machine type.

It *would* be a significant benefit - property names are stable, machine
type versions are not stable becasue downstream vendors change them.

> Also with new machine type deprecation policy we would be able
> easily to phase out rev1 support along with 2.9 machine,
> but if you expose property then removing it would break
> CLI not only for 2.9 but possible later machines if it's set there.

We have the freedom to deprecate properties too if they become a significant
burden.  If removing machine types prevents us running certain guest OS,
because we don't have a property to override, that would be a mark against
removing the machine types at all IMHO. 

> So I'm against adding properties/CLI options for unless we have to in this
> case, and I'm not convinced that w2k deserves it.

w2k is just one OS that we happen to know of that breaks - who knows how
many others suffer the same fate. So making decisions based on whether
you care about a specific OS is flawed IMHO.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
