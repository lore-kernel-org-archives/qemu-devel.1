Received: from eggs.gnu.org ([2001:4830:134:3::10]:40502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMEvl-00063Q-30
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMEve-0006xl-Je
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:19:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMEve-0006nQ-Ag
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:19:10 -0500
Date: Mon, 12 Nov 2018 16:18:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181112161829.GU3602@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
	<f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [QEMU PATCH v2 0/2]: KVM: i386: Add support for
 save and restore nested state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, rth@twiddle.net

On Sun, Nov 04, 2018 at 11:19:57PM +0100, Paolo Bonzini wrote:
> On 02/11/2018 17:54, Daniel P. Berrang=C3=A9 wrote:
> > We have usually followed a rule that new machine types must not
> > affect runability of a VM on a host. IOW new machine types should
> > not introduce dependancies on specific kernels, or hardware features
> > such as CPU flags.
>=20
> > Anything that requires a new kernel feature thus ought to be an
> > opt-in config tunable on the CLI, separate from machine type
> > choice.
>=20
> Unless someone tinkered with the module parameters, they could not even
> use nested virtualization before 4.20.  So for everyone else, "-cpu
> ...,+vmx" does count as an "opt-in config tunable on the CLI" that
> requires 4.20.
>
> For those that did tinker with module parameters, we can grandfather in
> the old machine types, so that they can use nested virtualization with
> no live migration support.  For those that did not, however, I don't
> think it makes sense to say "oh by the way I really want to be able to
> migrate this VM" on the command line, or even worse on the monitor.

IIUC, 4.20 is only required from POV of migration state. Is it thus
possible to just register a migration blocker if QEMU is launched
on a host with kernel < 4.20.

Migration has always been busted historically, so those people using
nested VMX already won't be hurt by not having ability to live migrate
their VM, but could otherwise continue using them without being forced
to upgrade their kernel to fix a feature they're not even using.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
