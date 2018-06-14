Received: from eggs.gnu.org ([2001:4830:134:3::10]:51796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTUQb-0006CQ-NE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTUQX-0001vT-PI
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTUQX-0001vN-KG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:44:45 -0400
Date: Thu, 14 Jun 2018 16:44:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614154441.GC18967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180614081800.GH6355@redhat.com>
	<2219a7fd-b496-6653-b79a-c20136727f98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2219a7fd-b496-6653-b79a-c20136727f98@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Thu, Jun 14, 2018 at 05:40:41PM +0200, Paolo Bonzini wrote:
> On 14/06/2018 10:18, Daniel P. Berrang=C3=A9 wrote:
> > I don't think
> > the -realtime flag should ever have been introduced, and we certainly
> > shouldn't add more stuff under it.
> >=20
> > "-realtime" is referring to a very specific use case, while the
> > properties listed under it are all general purpose features. Real
> > time guests just happen to be one possible use case, but it is
> > valid to use them for non-real time guests.
> >=20
> > IOW, I think we should just have this as an option under -cpu or
> > some other *functionally* named option, not a option named after
> > a specific usage scenario.
>=20
> "-cpu" is certainly wrong for KVM_CAP_X86_DISABLE_EXITS. "-cpu" is a
> device option, while this is about host behavior.  "-realtime"'s name i=
s
> awful, but I still think it's the best place for this option.  Maybe we
> could call it "-realtime power-mgmt=3D{host|guest}".

If none of the existing ones are a suitable fit, then we should just
introduce a new CLI arg instead stuffing it into somewhere odd.

IOW, why not just "--power-mgmt host|guest"

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
