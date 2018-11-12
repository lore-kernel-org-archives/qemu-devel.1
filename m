Received: from eggs.gnu.org ([2001:4830:134:3::10]:55779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMFQa-0000P3-FS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gMFQX-0001io-6M
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gMFQW-0001i5-VX
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:51:05 -0500
Date: Mon, 12 Nov 2018 16:50:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181112165053.GF2293@work-vm>
References: <CALMp9eQ5zWxb2N9fyYz=WcQshwk0L6qQ4D6L6+p_dzMo4H=txA@mail.gmail.com>
	<20181102034649.43559-1-liran.alon@oracle.com>
	<12c26c34-8dd1-a442-7826-86b93ff978f8@redhat.com>
	<20181102165409.GF21191@redhat.com>
	<f58da4e8-aa40-2659-8db6-42c2b47f5b2f@redhat.com>
	<20181112161829.GU3602@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181112161829.GU3602@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Liran Alon <liran.alon@oracle.com>, jmattson@google.com, ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Sun, Nov 04, 2018 at 11:19:57PM +0100, Paolo Bonzini wrote:
> > On 02/11/2018 17:54, Daniel P. Berrang=E9 wrote:
> > > We have usually followed a rule that new machine types must not
> > > affect runability of a VM on a host. IOW new machine types should
> > > not introduce dependancies on specific kernels, or hardware feature=
s
> > > such as CPU flags.
> >=20
> > > Anything that requires a new kernel feature thus ought to be an
> > > opt-in config tunable on the CLI, separate from machine type
> > > choice.
> >=20
> > Unless someone tinkered with the module parameters, they could not ev=
en
> > use nested virtualization before 4.20.  So for everyone else, "-cpu
> > ...,+vmx" does count as an "opt-in config tunable on the CLI" that
> > requires 4.20.
> >
> > For those that did tinker with module parameters, we can grandfather =
in
> > the old machine types, so that they can use nested virtualization wit=
h
> > no live migration support.  For those that did not, however, I don't
> > think it makes sense to say "oh by the way I really want to be able t=
o
> > migrate this VM" on the command line, or even worse on the monitor.
>=20
> IIUC, 4.20 is only required from POV of migration state. Is it thus
> possible to just register a migration blocker if QEMU is launched
> on a host with kernel < 4.20.
>=20
> Migration has always been busted historically, so those people using
> nested VMX already won't be hurt by not having ability to live migrate
> their VM, but could otherwise continue using them without being forced
> to upgrade their kernel to fix a feature they're not even using.

Yes, although I am a bit worried we might have a population of users
that:
   a) Have enabled nesting
   b) Run VMs with vmx enabled
   c) Don't normally actually run nested guests
   d) Currently happily migrate.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
