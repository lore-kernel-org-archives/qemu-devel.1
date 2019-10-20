Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EADACA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 10:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF40E2190F
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 10:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GEaMEhJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF40E2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM8Bv-0004fJ-Vo
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 06:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iM8Aq-0003iH-9w
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 06:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iM8Ao-0007ck-T8
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 06:10:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56317 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iM8Ao-0007bf-0f; Sun, 20 Oct 2019 06:10:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wwWq5gNtz9sNx; Sun, 20 Oct 2019 21:10:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571566247;
 bh=2YXatt6ot3iZMM7LgBVM3r1kf0X9/TfpQ6UpJVhcDh0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GEaMEhJxI6zHqDOVnMdxV1k8IXe4DWch0XW9FWIIJ6C282ZvyQ5fkbCHsjJ8QWzvM
 tj3QcV8YlaOw3rOSfvECNLgW4jycmRYMGe1WNriaHystOWulVR3LEotLWY4DEXAWFr
 Yfs0tOQ5qkIORCxBh2k9yiXCg1xwhCA+kERetnKg=
Date: Sun, 20 Oct 2019 21:10:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 4/9] tests/acceptance: Refactor
 exec_command_and_wait_for_pattern()
Message-ID: <20191020101003.GM1960@umbus.fritz.box>
References: <20191017165239.30159-1-f4bug@amsat.org>
 <20191017165239.30159-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LJm8egi4vkexsie5"
Content-Disposition: inline
In-Reply-To: <20191017165239.30159-5-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LJm8egi4vkexsie5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 06:52:34PM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> The same utility method is already present in two different test
> files,

This patch only appears to remove it from one, though.

> so let's consolidate it into a single utility function.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++++++++
>  tests/acceptance/boot_linux_console.py    | 12 ++++--------
>  2 files changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 39f72945cd..4d7d6b640a 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -80,6 +80,25 @@ def wait_for_console_pattern(test, success_message,
>              test.fail(fail)
> =20
> =20
> +def exec_command_and_wait_for_pattern(test, command,
> +                                      success_message, failure_message):
> +    """
> +    Send a command to a console (appending CRLF characters), then wait
> +    for success_message to appear on the console, while logging the.
> +    content. Mark the test as failed if failure_message is found instead.
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param command: the command to send
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    """
> +    command +=3D '\r\n'
> +    self.vm.console_socket.sendall(command.encode())
> +    wait_for_console_pattern(self, success_message)
> +
> +
>  class Test(avocado.Test):
>      def setUp(self):
>          self._vms =3D {}
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index bf9861296a..cc4d9be625 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -14,6 +14,7 @@ import gzip
>  import shutil
> =20
>  from avocado_qemu import Test
> +from avocado_qemu import exec_command_and_wait_for_pattern
>  from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import process
>  from avocado.utils import archive
> @@ -29,11 +30,6 @@ class BootLinuxConsole(Test):
> =20
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> =20
> -    def exec_command_and_wait_for_pattern(self, command, success_message=
):
> -        command +=3D '\r\n'
> -        self.vm.console_socket.sendall(command.encode())
> -        wait_for_console_pattern(self, success_message)
> -
>      def extract_from_deb(self, deb, path):
>          """
>          Extracts a file from a deb package into the test workdir
> @@ -162,11 +158,11 @@ class BootLinuxConsole(Test):
>          self.vm.launch()
>          wait_for_console_pattern(self, 'Boot successful.')
> =20
> -        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
>                                                 'BogoMIPS')
> -        self.exec_command_and_wait_for_pattern('uname -a',
> +        exec_command_and_wait_for_pattern(self, 'uname -a',
>                                                 'Debian')
> -        self.exec_command_and_wait_for_pattern('reboot',
> +        exec_command_and_wait_for_pattern(self, 'reboot',
>                                                 'reboot: Restarting syste=
m')
> =20
>      def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LJm8egi4vkexsie5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2sMnsACgkQbDjKyiDZ
s5Ltiw/+PjAqa5sQdB5douDB04XnNNAG17m5cHcqx6AVEfzhsuGqPBP9ZWxY6GB9
GF7oh+haidAI9wbBGvuuTgDpY7LT2gg7svU8HBwo58BLbxrMuF2ErqtBsP7KvgUn
nFl9Sg1zvwWsKIXmMEQEbeQZ2l/SrmNRneISQ73fcv85pl/6alU+BySKIS7btSrl
WuKM7TOjBv5/wDGFXfK6c6aOIbR82urL1YIWFyqJnuiXa4hODneG16s4GLqjpm6Q
38dnJwLuQ/tGhl5JBP58Bvc1d/K1iV4bWP+fbozCFLsO7jLB9WnepvSW4G2m+sHi
b/tKn9SPFV8V29SQeJlyz68KoYMGMoN4Q/Rgje7v6HlZkq0FU9OlsrM087qbmghT
y4+7YlgabNiIOioChrnOmAux1PE8o3YzE2yWHq2AZk/dUQuSaA/OPrCDYHo44Dqy
ePhql17aspTN1pWwDZ076GvmphicTu9WizHR58/iffORRHI44vim7MdpogyJYm7+
6yf9KmDyhpPbEaTidNFQEkH6GzNkLTghUd084i/57yOe8u4kchPpdq8nMDiCeIPP
f7aUouduNaEEL85UV7dcfaUIsYzrOSo297xVoBPZoxdWMlFVSrYy7ntiZfPUVXPW
s+SakMsQg6odScVis0hPpz9sW/kvBW+day6xuetSAgPqa87YJZQ=
=G2Me
-----END PGP SIGNATURE-----

--LJm8egi4vkexsie5--

