Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED911C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7486206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0c7cnGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7486206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieY1P-00067c-SY
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 00:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ieY0k-0005il-VL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ieY0i-0003Kf-VJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:24:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ieY0i-0003KF-BA
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575955475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1M5JxM8W/Ld/ma1Amz6PBZp79TW4Xva/X4358a+o5q0=;
 b=U0c7cnGor9DNQ0njLndLfh0JUnqxbngTCqJoF51wBHvAmyf01wLPqMB96Wp8aTdStBUiWb
 bIuz5m0r27uFStxW91c7V0xnyRdWGWt7mk7Qm4QuTP8H/hg30Wfnff7bL4AqDqzjtwhq5h
 rq/mudERX1TkoIK+KD8hogW9/axFX8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-HyKjSv1HN7idN5JEcJZufA-1; Tue, 10 Dec 2019 00:24:33 -0500
X-MC-Unique: HyKjSv1HN7idN5JEcJZufA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802EB107ACC4
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 05:24:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-99.rdu2.redhat.com
 [10.10.125.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2D819C5B;
 Tue, 10 Dec 2019 05:24:26 +0000 (UTC)
Date: Tue, 10 Dec 2019 00:24:25 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 2/2] tests/acceptance: Makes linux_initrd and
 empty_cpu_model use QEMUMachine
Message-ID: <20191210052425.GH31990@localhost.localdomain>
References: <20191112135801.854-1-wainersm@redhat.com>
 <20191112135801.854-3-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191112135801.854-3-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bygAmIonOAIqBxQB"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bygAmIonOAIqBxQB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 08:58:01AM -0500, Wainer dos Santos Moschetta wrote=
:
> On linux_initrd and empty_cpu_model tests the same effect of
> calling QEMU through run() to inspect the terminated process is
> achieved with a sequence of set_qmp_monitor() / launch() / wait()
> commands on an QEMUMachine object. This patch changes those
> tests to use QEMUMachine instead, so they follow the same pattern
> to launch QEMU found on other acceptance tests.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/acceptance/empty_cpu_model.py | 13 +++++++------
>  tests/acceptance/linux_initrd.py    | 13 +++++++------
>  2 files changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/tests/acceptance/empty_cpu_model.py b/tests/acceptance/empty=
_cpu_model.py
> index 3f4f663582..8c20a4ef4a 100644
> --- a/tests/acceptance/empty_cpu_model.py
> +++ b/tests/acceptance/empty_cpu_model.py
> @@ -7,13 +7,14 @@
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> -import subprocess
>  from avocado_qemu import Test
> =20
>  class EmptyCPUModel(Test):
>      def test(self):
> -        cmd =3D [self.qemu_bin, '-S', '-display', 'none', '-machine', 'n=
one', '-cpu', '']
> -        r =3D subprocess.run(cmd, stderr=3Dsubprocess.PIPE, stdout=3Dsub=
process.PIPE)
> -        self.assertEquals(r.returncode, 1, "QEMU exit code should be 1")
> -        self.assertEquals(r.stdout, b'', "QEMU stdout should be empty")
> -        self.assertNotEquals(r.stderr, b'', "QEMU stderr shouldn't be em=
pty")
> +        self.vm.add_args('-S', '-display', 'none', '-machine', 'none',
> +                         '-cpu', '')
> +        self.vm.set_qmp_monitor(disabled=3DTrue)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should =
be 1")
> +        self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empt=
y')
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_in=
itrd.py
> index c61d9826a4..158ec4d46c 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -10,7 +10,6 @@
> =20
>  import logging
>  import tempfile
> -from avocado.utils.process import run
> =20
>  from avocado_qemu import Test
> =20
> @@ -41,13 +40,15 @@ class LinuxInitrd(Test):
>              initrd.seek(max_size)
>              initrd.write(b'\0')
>              initrd.flush()
> -            cmd =3D "%s -kernel %s -initrd %s -m 4096" % (
> -                  self.qemu_bin, kernel_path, initrd.name)
> -            res =3D run(cmd, ignore_status=3DTrue)
> -            self.assertEqual(res.exit_status, 1)
> +            self.vm.add_args('-kernel', kernel_path, '-initrd', initrd.n=
ame,
> +                             '-m', '4096')
> +            self.vm.set_qmp_monitor(disabled=3DTrue)

Like I've said on the previous patch, I'd personally go with
`enabled=3DTrue` as the default method signature, so this would become
`enabled=3DFalse`, or simply:

   self.vm.set_qmp_monitor(False)

But either way,

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--bygAmIonOAIqBxQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3vLAUACgkQZX6NM6Xy
CfOgdRAAmo3+38teWugLl+kpCu363nay11Fk/v2atb4Lrmuu66ML+kjZiYyqTiM9
1Z9fCkTsNFy6fpcv7k+l2Dn0oaSd5nEvZxs2cpkhBOBvOFF1gRncRs78dpdvME2/
SnPivGKsTReWLVtDHJIH/0QwgHJ9zVaqUZ/uZ67ULfVH/4NwfHTf29ODa+utTedr
IOrAH6sVyVcESGTamLzLoYW5bLr/Ntf85yqtoPUbrckN51bg9d4TyAsTAjoUM3MK
oRG46ew6xqF3QiKppNmfcgRgxiQwiV/9C3A+MMazFpMp5CA7XiTadt89SbZ3vgNa
QNqtB+gTnUGn9TDxE8T5argIan/pLYQZkKmBrLsSewd/CJ82RZPPSQFhaDzkmvMS
1gQTRec01UALGN+urqg253OlnBURDW9OizmMjhoMPSIDGimrED8Ii9wvIrCG9oCs
Gi4GYbNhy4TN/h18ABD1ToQBDWwa45jsRpGcgtZcEKPzQeRSpn0CYjD3ElAjuhv1
V9dsiZdHLfF7qwpl+TU98CyhqCyNB6xIwPLfN0s8p8J3UHSsXusEcLZkPOEUqnpB
UhgI+xPymewZkx6g1SCE/jgKYikl06sBZWh5Vn1ofNTCH5BRVOZwtmnve0AYuzK3
MJkeo9EyTCaguAJA2EHTCrNvzyKyg7UOf7kcNinbKhgNqoncVSs=
=mGOe
-----END PGP SIGNATURE-----

--bygAmIonOAIqBxQB--


