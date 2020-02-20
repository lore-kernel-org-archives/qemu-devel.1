Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D0C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D693B206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkyS8/xp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D693B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4rtL-0004qA-19
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 14:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j4rse-000482-1l
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 14:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j4rsb-0006YO-P4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 14:53:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j4rsb-0006Xn-IT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 14:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582228379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JkuBRkLESFQZs8D8htw11pdaZEirNZsVNsN7xtQWTxM=;
 b=DkyS8/xpkgQkqxomFrdSrbbss+Of0oNucIoufSlnFLzFcIBzpDCKN/dbBodO8HadiLfQ7c
 7MGi9JwaHS/03+mFPALtelsPAwbtqDUd4vRqW7IuA+jnRJknxxrvMYvQL0j4t+WYqvpQ3U
 3fIkym20+LUKvzbqvY4VWNhavDgB4zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-YnsFgNJLNUKPLMh_lgr87w-1; Thu, 20 Feb 2020 14:52:52 -0500
X-MC-Unique: YnsFgNJLNUKPLMh_lgr87w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C9C5925A0;
 Thu, 20 Feb 2020 19:52:51 +0000 (UTC)
Received: from dhcp-17-202.bos.redhat.com (dhcp-17-202.bos.redhat.com
 [10.18.17.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03DB290F73;
 Thu, 20 Feb 2020 19:52:47 +0000 (UTC)
Date: Thu, 20 Feb 2020 14:52:45 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Drew Jones <drjones@redhat.com>
Subject: Re: [PATCH v9 2/3] Acceptance test: add "boot_linux" tests
Message-ID: <20200220195245.GA14444@dhcp-17-202.bos.redhat.com>
References: <20200220020652.16276-1-crosa@redhat.com>
 <20200220020652.16276-3-crosa@redhat.com>
 <4fe4f011-1d4a-aaea-2536-223194dacd8c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4fe4f011-1d4a-aaea-2536-223194dacd8c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 01:49:40PM -0300, Wainer dos Santos Moschetta wrote=
:
> On 2/19/20 11:06 PM, Cleber Rosa wrote:
> > +
> > +    def test_virt_tcg(self):
> > +        """
> > +        :avocado: tags=3Daccel:tcg
> > +        :avocado: tags=3Dcpu:cortex-a53
> > +        """
> > +        if not tcg_available(self.qemu_bin):
> > +            self.cancel(TCG_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "tcg")
> > +        self.vm.add_args('-cpu', 'cortex-a53')
> > +        self.add_common_args()
> > +        self.launch_and_wait()
> > +
> > +    def test_virt_kvm(self):
> > +        """
> > +        :avocado: tags=3Daccel:kvm
> > +        :avocado: tags=3Dcpu:host
> > +        """
> > +        if not kvm_available(self.arch, self.qemu_bin):
> > +            self.cancel(KVM_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "kvm")
> > +        self.vm.add_args("-cpu", "host")
> > +        self.add_common_args()
> > +        self.launch_and_wait()
>=20
>=20
> For aarch64 tests it seems '-cpu max' is the best choice. See in
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg672755.html
>=20
>

+drew

Thanks for pointing that out.  There's one thing, though, which I can
not agree on.  And I know that Drew is an expert on the matter, which
makes it harder to disagree on... but, I've got results which clearly
indicate that *not using* the gic-version machine parameter still gets
me KVM:

./tests/venv/bin/avocado run tests/acceptance/boot_linux.py:BootLinuxAarch6=
4.test_virt_kvm
JOB ID     : 21a394b884b474ceee0a045b3e74f98da0aee023
JOB LOG    : /home/cleber/avocado/job-results/job-2020-02-20T14.28-21a394b/=
job.log
 (1/1) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_kvm: PASS =
(35.10 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 0
JOB TIME   : 35.87 s

VM launch command:
   aarch64-softmmu/qemu-system-aarch64
   -display none
   -vga none
   -chardev socket,id=3Dmon,path=3D/var/tmp/tmpntz_r_h7/qemu-18331-monitor.=
sock
   -mon chardev=3Dmon,mode=3Dcontrol
   -machine virt
   -chardev socket,id=3Dconsole,path=3D/var/tmp/tmpntz_r_h7/qemu-18331-cons=
ole.sock,server,nowait
   -serial chardev:console
   -smp 2
   -m 1024
   -drive file=3D/var/tmp/avocado_u9jm04di/avocado_job_28oth9kk/1-tests_acc=
eptance_boot_linux.py_BootLinuxAarch64.test_virt_kvm/Fedora-Cloud-Base-31-1=
.9.aarch64-05265df5.qcow2 -drive file=3D/var/tmp/avocado_u9jm04di/avocado_j=
ob_28oth9kk/1-tests_acceptance_boot_linux.py_BootLinuxAarch64.test_virt_kvm=
/cloudinit.iso,format=3Draw
   -accel kvm
   -cpu host
   -bios /home/cleber/build/qemu/pc-bios/edk2-aarch64-code.fd
   -device virtio-rng-pci,rng=3Drng0
   -object rng-random,id=3Drng0,filename=3D/dev/urandom

Guest boot messages shows:
[    1.538955] systemd[1]: Detected virtualization kvm.
[    1.539828] systemd[1]: Detected architecture arm64.

This is in contrast with:

./tests/venv/bin/avocado run tests/acceptance/boot_linux.py:BootLinuxAarch6=
4.test_virt_tcg=20
JOB ID     : 90b9412f700e52428b59e97719496c30b4f54435
JOB LOG    : /home/cleber/avocado/job-results/job-2020-02-20T14.32-90b9412/=
job.log
 (1/1) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg: PASS =
(581.14 s)
RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 0
JOB TIME   : 581.93 s

VM launch command:
   aarch64-softmmu/qemu-system-aarch64
   -display none
   -vga none
   -chardev socket,id=3Dmon,path=3D/var/tmp/tmpa6i4livg/qemu-18498-monitor.=
sock
   -mon chardev=3Dmon,mode=3Dcontrol
   -machine virt
   -chardev socket,id=3Dconsole,path=3D/var/tmp/tmpa6i4livg/qemu-18498-cons=
ole.sock,server,nowait
   -serial chardev:console
   -smp 2
   -m 1024
   -drive file=3D/var/tmp/avocado_slcj2x9e/avocado_job_x5u__309/1-tests_acc=
eptance_boot_linux.py_BootLinuxAarch64.test_virt_tcg/Fedora-Cloud-Base-31-1=
.9.aarch64-5b006a2f.qcow2 -drive file=3D/var/tmp/avocado_slcj2x9e/avocado_j=
ob_x5u__309/1-tests_acceptance_boot_linux.py_BootLinuxAarch64.test_virt_tcg=
/cloudinit.iso,format=3Draw
   -accel tcg
   -cpu cortex-a53
   -bios /home/cleber/build/qemu/pc-bios/edk2-aarch64-code.fd
   -device virtio-rng-pci,rng=3Drng0
   -object rng-random,id=3Drng0,filename=3D/dev/urandom'

Guest boot messages shows:
[   28.606310] systemd[1]: Detected virtualization qemu.
[   28.607861] systemd[1]: Detected architecture arm64.

And with regards to the CPU type, IIRC, "max" will fallback to the
best CPU on TCG mode.  As a general best practice in testing, I'd
rather not have this dynamic aspect where we can avoid it.  Looks like
with TCG we can set it to one CPU and validate that the guests work on
that configuration.

IIUC, by using either "-cpu host" or "-cpu max" for KVM, we may end up
having the same test PASS or FAIL because of the (dynamic) host CPU.
That's not ideal for testing purposes, but given it's outside of our
control, do best we can do is keep track of the host CPU (via Avocado's
sysinfo collection).

Also, I've used the same CPU model that has been used on
boot_linux_console.py:BootLinuxConsole.test_aarch64_virt, which may be
a plus.

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
> > +    def test_pseries_tcg(self):
> > +        """
> > +        :avocado: tags=3Dmachine:pseries
> > +        :avocado: tags=3Daccel:tcg
> > +        """
> > +        if not tcg_available(self.qemu_bin):
> > +            self.cancel(TCG_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "tcg")
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
> > +    def test_s390_ccw_virtio_tcg(self):
> > +        """
> > +        :avocado: tags=3Dmachine:s390-ccw-virtio
> > +        :avocado: tags=3Daccel:tcg
> > +        """
> > +        if not tcg_available(self.qemu_bin):
> > +            self.cancel(TCG_NOT_AVAILABLE)
> > +        self.vm.add_args("-accel", "tcg")
> > +        self.launch_and_wait()
> > diff --git a/tests/requirements.txt b/tests/requirements.txt
> > index a2a587223a..a3b5fe4159 100644
> > --- a/tests/requirements.txt
> > +++ b/tests/requirements.txt
> > @@ -1,4 +1,5 @@
> >   # Add Python module requirements, one per line, to be installed
> >   # in the tests/venv Python virtual environment. For more info,
> >   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> > -avocado-framework=3D=3D72.0
> > +avocado-framework=3D=3D74.0
> > +pycdlib=3D=3D1.9.0
>=20
>=20
> Tested on x86_64 machine, the tests behave correctly with following
> configurations:
>=20
> 1. ---target-list=3Dx86_64-softmmu --disable-tcg
>=20
> 2. ---target-list=3Dx86_64-softmmu --disable-kvm
>=20
> 3. --target-list=3Dx86_64-softmmu,aarch64-softmmu,ppc64-softmmu,s390x-sof=
tmmu
>=20
> But failed if:
>=20
> 3. ---target-list=3Dx86_64-softmmu --disable-tools.
>=20
> And the error message is:
>=20
> (01/32) tests/acceptance/boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg:
> ERROR: Command 'qemu-img' could not be found in any of the PATH dirs:
> ['/usr/bin', '/usr/sbin', '/usr/lib64/ccache', '/bin', '/root/bin', '/sbi=
n',
> '/usr/local/sbin', '/usr/local/bin', '/usr/libexec'] (1.58 s)

This is what I call comprehensive testing! Thanks!

It looks like I was not paying that much attention to what happens during
the "self.boot.path" attribute access, and had left it "unprotected" in
the QEMU command line arguments assignment.  But there's where a lazy
snapshot image creation is attempted.

I've adjusted the code and will have that on a v10.

>=20
> Thanks!
>=20
> - Wainer
>=20
>=20

Thanks a lot for the review!
- Cleber.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5O44kACgkQZX6NM6Xy
CfO1dw/7BYkh8oQ+TnRvluyn5RS/hk9TBNG13uC3bRlSCjeyuhV2UZ/tzXn1AsOF
bfUvlEhbsN5E7TRHR+tUFfyC/Z/+WcXNrOHTNopSFi6j5sPC1nPKrpVpSdVUCS6o
ENSDuc/7WKqInxlGNL3NncaNh/OvlfaZgNHjtBzbphaTGNqAWjS2IwXN1VtYs2/i
8IPIUZyAOQaLPOMqyH7HFqvb9fxKWcy2UXJxq+rdXRO3TgjCcg4lkN51RHx7hCRH
1BYAPB6d2r5rQ74GPp6zAg5E/KQClGUyQCjmzoDCk71GIOUWNZhSYQ6gOnmU/Cq+
p8COrZiuCCFB5AUu+tYTiFHrVvLvoCi/n2ed1Jz6WQd6uUDDORJwcwPR62qdNR4u
B0HCebYobIsmZdbQRMkqzvQ0KCOknmVe4qnTSbjDssM/eZzyZMZspgRzRGv+MVQG
dPrt3f5qXWQc5D8QvPamJlVI09WUlDhqWqGSpUcz+H2lV/jF3TQ/sttCxtcymXKS
obbrswNgOK18o2OrphvZG6RhIPDTPgn4lKw1QkxOEGoBq0g0xCezZJMBmzc+4QEy
abhk9H+mFw+DR4USuoS9kJueKn+YqKios/mnsFM5x3+NDqr3Xwrcj/4uqhQKKBhT
KvIDlf8IxrFOy+5AMRJVy6aZW2Ecc1mE3QSF12VKas/2OOTTPyU=
=ylE2
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


