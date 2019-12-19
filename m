Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D058C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7C5222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krzn6Lx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7C5222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjr6-0008OM-Ts
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihjqI-0007u0-F0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihjqE-0004no-LA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:39:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihjqE-0004n0-4O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576715937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RcoAKjktiTw5QjwfCFr4A5i7jtadNpTVHaL+2jmcmBk=;
 b=Krzn6Lx3C1mk2m6HbWmf3xULYp2Nm5locGQFi2SsOVNCM/YOwFSm31QcXVFeDMD/8DJeX+
 PSDswvilNADHpeidifUr+atm+xE6HdHGRm4kNcvBA5pDC0xkY3/8OonslYAlqY9eejdp2b
 5X7lGBejwYoWmOsGt8IIaxLIyp8siYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-D50PlsGJM0uduXUwJ1ViKw-1; Wed, 18 Dec 2019 19:38:51 -0500
X-MC-Unique: D50PlsGJM0uduXUwJ1ViKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F329710054E3;
 Thu, 19 Dec 2019 00:38:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B4B5D9E2;
 Thu, 19 Dec 2019 00:38:42 +0000 (UTC)
Date: Wed, 18 Dec 2019 19:38:39 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 2/4] Acceptance test: add "boot_linux" tests
Message-ID: <20191219003839.GB29918@localhost.localdomain>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-3-crosa@redhat.com>
 <8753cd80-283d-82c7-c35f-e995a0ed14d0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8753cd80-283d-82c7-c35f-e995a0ed14d0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 01:12:02AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Cleber,
>=20
> Few minor questions...
>=20
> On 12/19/19 12:24 AM, Cleber Rosa wrote:
> > This acceptance test, validates that a full blown Linux guest can
> > successfully boot in QEMU.  In this specific case, the guest chosen is
> > Fedora version 31.
> >=20
> >   * x86_64, pc and q35 machine types, with and without kvm as an
> >     accelerator
> >=20
> >   * aarch64 and virt machine type, with and without kvm as an
> >     accelerator
> >=20
> >   * ppc64 and pseries machine type
> >=20
> >   * s390x and s390-ccw-virtio machine type
> >=20
> > The Avocado vmimage utils library is used to download and cache the
> > Linux guest images, and from those images a snapshot image is created
> > and given to QEMU.  If a qemu-img binary is available in the build
> > directory, it's used to create the snapshot image, so that matching
> > qemu-system-* and qemu-img are used in the same test run.  If qemu-img
> > is not available in the build tree, one is attempted to be found
> > installed system-wide (in the $PATH).  If qemu-img is not found in the
> > build dir or in the $PATH, the test is canceled.
> >=20
> > The method for checking the successful boot is based on "cloudinit"
> > and its "phone home" feature.  The guest is given an ISO image with
> > the location of the phone home server, and the information to post
> > (the instance ID).  Upon receiving the correct information, from the
> > guest, the test is considered to have PASSed.
> >=20
> > This test is currently limited to user mode networking only, and
> > instructs the guest to connect to the "router" address that is hard
> > coded in QEMU.
> >=20
> > To create the cloudinit ISO image that will be used to configure the
> > guest, the pycdlib library is also required and has been added as
> > requirement to the virtual environment created by "check-venv".
> >=20
> > The console output is read by a separate thread, by means of the
> > Avocado datadrainer utility module.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   .travis.yml                    |   2 +-
> >   tests/acceptance/boot_linux.py | 180 ++++++++++++++++++++++++++++++++=
+
> >   tests/requirements.txt         |   3 +-
> >   3 files changed, 183 insertions(+), 2 deletions(-)
> >   create mode 100644 tests/acceptance/boot_linux.py
> >=20
> > diff --git a/.travis.yml b/.travis.yml
> > index 6cb8af6fa5..10c24330fd 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -264,7 +264,7 @@ matrix:
> >       # Acceptance (Functional) tests
> >       - env:
> > -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64=
-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
> > +        - CONFIG=3D"--python=3D/usr/bin/python3 --enable-tools --targe=
t-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-s=
oftmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,s=
parc-softmmu"
> >           - TEST_CMD=3D"make check-acceptance"
> >         after_failure:
> >           - cat tests/results/latest/job.log
> > diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_lin=
ux.py
> > new file mode 100644
> > index 0000000000..495ff2963c
> > --- /dev/null
> > +++ b/tests/acceptance/boot_linux.py
> > @@ -0,0 +1,180 @@
> > +# Functional test that boots a complete Linux system via a cloud image
> > +#
> > +# Copyright (c) 2018-2019 Red Hat, Inc.
> > +#
> > +# Author:
> > +#  Cleber Rosa <crosa@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +import os
> > +
> > +from avocado_qemu import Test, BLD_DIR
> > +
> > +from qemu.accel import kvm_available
> > +
> > +from avocado.utils import cloudinit
> > +from avocado.utils import network
> > +from avocado.utils import vmimage
> > +from avocado.utils import datadrainer
> > +
> > +
> > +KVM_NOT_AVAILABLE =3D "KVM accelerator does not seem to be available"
> > +
> > +
> > +class BootLinux(Test):
> > +    """
> > +    Boots a Linux system, checking for a successful initialization
> > +    """
> > +
> > +    timeout =3D 900
> > +    chksum =3D None
> > +
> > +    def setUp(self):
> > +        super(BootLinux, self).setUp()
> > +        self.prepare_boot()
> > +        self.vm.add_args('-smp', '2')
>=20
> Hmmm are we assuming everybody has multicore systems?
>

Not really, but isn't it possible to have virtual CPUs > actual CPUs?
IMO testing with smp > 1 is a better test than with smp =3D=3D 1.

> > +        self.vm.add_args('-m', '2048')
>=20
> We should not fail the test if this condition is not possible.
>

You mean from the host side, right?  I have doubts about what to do
here, in the sense that we can't easily and reliably set aside memory
in the system to run qemu.  We could of course check the amount of
physical or free memory in the system at the test start time, but
there would still be somewhat of a race condition.

Also, with tests running in parallel (ie, avocado nrun
tests/acceptance/), this would be even trickier...

> > +        self.vm.add_args('-drive', 'file=3D%s' % self.boot.path)
> > +        self.prepare_cloudinit()
> > +
> > +    def prepare_boot(self):
> > +        self.log.info('Downloading/preparing boot image')
> > +        # Fedora 31 only provides ppc64le images
> > +        image_arch =3D self.arch
> > +        if image_arch =3D=3D 'ppc64':
> > +            image_arch =3D 'ppc64le'
> > +        # If qemu-img has been built, use it, otherwise the system wid=
e one
> > +        # will be used.  If none is available, the test will cancel.
> > +        qemu_img =3D os.path.join(BLD_DIR, 'qemu-img')
> > +        if os.path.exists(qemu_img):
> > +            vmimage.QEMU_IMG =3D qemu_img
> > +        try:
> > +            self.boot =3D vmimage.get(
> > +                'fedora', arch=3Dimage_arch, version=3D'31',
> > +                checksum=3Dself.chksum,
> > +                algorithm=3D'sha256',
> > +                cache_dir=3Dself.cache_dirs[0],
> > +                snapshot_dir=3Dself.workdir)
> > +        except:
> > +            self.cancel('Failed to download/prepare boot image')
> > +
> > +    def prepare_cloudinit(self):
> > +        self.log.info('Preparing cloudinit image')
> > +        try:
> > +            cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.is=
o')
> > +            self.phone_home_port =3D network.find_free_port()
> > +            cloudinit.iso(cloudinit_iso, self.name,
> > +                          username=3D'root',
> > +                          password=3D'password',
> > +                          # QEMU's hard coded usermode router address
> > +                          phone_home_host=3D'10.0.2.2',
> > +                          phone_home_port=3Dself.phone_home_port)
> > +            self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % clou=
dinit_iso)
> > +        except Exception:
> > +            self.cancel('Failed to prepared cloudinit image')
> > +
> > +    def launch_and_wait(self):
> > +        self.vm.set_console()
> > +        self.vm.launch()
> > +        console_drainer =3D datadrainer.LineLogger(self.vm.console_soc=
ket.fileno(),
> > +                                                 logger=3Dself.log.get=
Child('console'))
> > +        console_drainer.start()
> > +        self.log.info('VM launched, waiting for boot confirmation from=
 guest')
> > +        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port=
), self.name)
> > +
> > +
> > +class BootLinuxX8664(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:x86_64
> > +    """
> > +
> > +    chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc02695=
4f3c5c27a0'
> > +
> > +    def test_pc(self):
>=20
> I'd name this test_pc_i440fx_tcg, but are you sure the default is tcg?
>

Even if there's no matching machine type named "pc-i440fx"?

> > +        """
> > +        :avocado: tags=3Dmachine:pc
> > +        """
> > +        self.launch_and_wait()
> > +
> > +    def test_kvm_pc(self):
>=20
> This test_pc_i440fx_kvm
>

Ditto.

> > +        """
> > +        :avocado: tags=3Dmachine:pc
> > +        :avocado: tags=3Daccel:kvm
> > +        """
> > +        if not kvm_available(self.arch, self.qemu_bin):
> > +            self.cancel(KVM_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.launch_and_wait()
> > +
> > +    def test_q35(self):
>=20
> This one test_pc_q35_tcg
>

Both *pc* and *q35*?  I'm missing something here.  +1 for the explicit
"tcg" along with an also explicit check for the availability of the
tcg accel.

> > +        """
> > +        :avocado: tags=3Dmachine:q35
> > +        """
> > +        self.launch_and_wait()
> > +
> > +    def test_kvm_q35(self):
>=20
> Here test_pc_q35_kvm.
>

I don't get the "pc" part here.

> > +        """
> > +        :avocado: tags=3Dmachine:q35
> > +        :avocado: tags=3Daccel:kvm
> > +        """
> > +        if not kvm_available(self.arch, self.qemu_bin):
> > +            self.cancel(KVM_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.launch_and_wait()
> > +
> > +
> > +class BootLinuxAarch64(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:aarch64
> > +    :avocado: tags=3Dmachine:virt
> > +    """
> > +
> > +    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c99=
7fdf16fe49'
> > +
> > +    def test_virt(self):
>=20
> We have other 'virt' machines:
>=20
> $ git grep '"virt"'
> hw/arm/virt.c:83:            mc->alias =3D "virt"; \
> hw/riscv/virt.c:613:    .name       =3D MACHINE_TYPE_NAME("virt"),
> hw/xtensa/virt.c:135:DEFINE_MACHINE("virt", xtensa_virt_machine_init)
>=20
> Maybe rename test_aarch64_virt_tcg?
>

The "test name", or "test ID" includes the class name, so that already
makes it clear (IMO) that this test is about the "virt" machine type
for the "aarch64" arch.

> > +        self.vm.add_args('-cpu', 'cortex-a53')
> > +        self.vm.add_args('-bios',
> > +                         os.path.join(BLD_DIR, 'pc-bios',
> > +                                      'edk2-aarch64-code.fd'))
> > +        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
> > +        self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/=
dev/urandom')
> > +        self.launch_and_wait()
> > +
> > +    def test_kvm_virt(self):
> > +        """
> > +        :avocado: tags=3Daccel:kvm
> > +        """
> > +        if not kvm_available(self.arch, self.qemu_bin):
> > +            self.cancel(KVM_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.test_virt()
> > +
> > +
> > +class BootLinuxPPC64(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:ppc64
> > +    """
> > +
> > +    chksum =3D '7c3528b85a3df4b2306e892199a9e1e43f991c506f2cc390dc4efa=
2026ad2f58'
> > +
> > +    def test_pseries(self):
>=20
> Rename as test_ppc64el_pseries_tcg?
>

Same here (class name contains the arch).

- Cleber.

> > +        """
> > +        :avocado: tags=3Dmachine:pseries
> > +        """
> > +        self.launch_and_wait()
> > +
> > +
> > +class BootLinuxS390X(BootLinux):
> > +    """
> > +    :avocado: tags=3Darch:s390x
> > +    """
> > +
> > +    chksum =3D '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982f=
dcaf5a122d'
> > +
> > +    def test_s390_ccw_virtio(self):
> > +        """
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        """
> > +        self.launch_and_wait()
> > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > index a2a587223a..0192c352cd 100644
> > --- a/tests/requirements.txt
> > +++ b/tests/requirements.txt
> > @@ -1,4 +1,5 @@
> >   # Add Python module requirements, one per line, to be installed
> >   # in the tests/venv Python virtual environment. For more info,
> >   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> > -avocado-framework=3D=3D72.0
> > +avocado-framework=3D=3D73.0
> > +pycdlib=3D=3D1.8.0
> >=20
>=20
>=20

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl36xo0ACgkQZX6NM6Xy
CfNo4g/9EwYMQlfL25WtVpKaiOQTnq2ZmhJq9GZo4c8+/rxWDw9izGQxFvdzJ3LY
G/bqhdgvIbIjClcLzJ4rmzGd+5S7wSA0GGvxiAKJyxwaIsydvpolEvq4i2JPP8D0
AdWJB1gwwgfZCO5ah0QtWTNdi7iXDRthxX+uXX6wWYWnLCvcet7jXlRSjlhmYW6y
5WUi0NT6fGbiTCK57iIafx18YWnMSo2ZQpSn45BS5L3yXEclN7Z/dGION4fD9iFZ
ztjHsfA2jzybk+2zrk4QHe9jZdvS4OEJLtPT4oF11JDMDvmp5oKGsmW8k1w+eWVd
0T09bj1I3NwGlVjTitmFqZqq9g94SfYjyKaPWvVtR9xqlJHLcw6D+i5B8pTvWK/Q
5HOVg5EK/bkLtbT8RX2U/K2+fQD52fdSceTPUXZXPlpoNbi4vhTLeD4wJeAJrn/A
Wwv0G1dTC61p66RrtmsuLoXZCTTQOf9ghQMZo0FP6iT9p66NWShV9isklrE3qWa6
s0V3En0cTQSB8ES4tmnrGsPuRvk5eC/I2bmWv9MMsH19mhOOSMB0fX6snhu0KSWV
N2hvjQOc5oHKtJ++ZA6ogstHhG+KLTjlNXIF2ikLGjFIX3fiAN35Y6GyGzmRkmhI
lk+HImRtbaSSTO7en0eRIidwJ+TOp/q+G0JMqLhSXrYlrYZUFeM=
=kiJY
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--


