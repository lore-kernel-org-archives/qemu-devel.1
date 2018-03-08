Received: from eggs.gnu.org ([2001:4830:134:3::10]:57904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etxlZ-00053Z-4Y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etxlW-0000IW-1X
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:47:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etxlV-0000IJ-Qo
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:47:33 -0500
Date: Thu, 8 Mar 2018 15:47:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308154730.GZ4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, kraxel@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Thu, Mar 08, 2018 at 12:10:30PM +0100, Laszlo Ersek wrote:
> (
> Ard, the thread starts here:
> 
> http://mid.mail-archive.com/20180307144951.d75lo5rgzi2vf27z@eukaryote
> )
> 
> On 03/07/18 15:49, Kashyap Chamarthy wrote:
> > Problem background
> > ------------------
> > 
> > The various OVMF binary file names and paths are slightly different[+]
> > for each Linux distribution.  And each high-level management tool
> > (libguestfs, oVirt, `virt-manager` and OpenStack Nova) is inventing its
> > own approach to detect and configure the said OVMF files.  This email
> > thread is about arriving at some common understanding to make this a bit
> > more "unified" by addressing these needs in QEMU and libvirt.
> 
> I've read Dan's message <20180307151836.GK20201@redhat.com> and Gerd's
> messages <20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>,
> <20180308074507.nwho4tddsoxb3b7v@sirius.home.kraxel.org>.
> 
> Those seem to cover everything, I don't have anything to add wrt.
> purpose, use case, flexibility etc.
> 
> I suggest (or agree) that the property list be composed of free-form
> name=value pairs (at least conceptually). I understand Gerd is proposing
> a QAPI schema for this, so maybe do { property_name : "foo",
> property_value : "bar" }, or similar. The registry of properties (names,
> possible values, meanings) should be kept separate (although possibly
> still under QEMU).
> 
> For OVMF (x86), I guess the initial set of properties should come from
> the "-D FOO[=BAR]" build flags that OVMF currently supports. (The list
> might grow or change incompatibly over time, so this is just a raw
> starter idea.)

I really don't want to see us using firmware implementation specific
property names in these files. It means libvirt will require knowledge
of what each different firmware's property names mean.

We need to have some core standardized set of property names that can
be provided by any firmware implementation using the same terminology.

If we want to /also/ provide some extra firmeware-specific property
names that would be ok for informative purposes, but when lbivirt is
picking which firmware file to use, it would only ever look at the
standardized property names/values.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
