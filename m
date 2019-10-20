Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DECA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 10:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDEA2190F
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MzoM4Bd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDEA2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iM8Bw-0004fw-Qt
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 06:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iM8Aq-0003iG-8G
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 06:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iM8Ao-0007ce-SU
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 06:10:56 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iM8An-0007bh-RY; Sun, 20 Oct 2019 06:10:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46wwWq6RhVz9sPL; Sun, 20 Oct 2019 21:10:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571566247;
 bh=7CBNMcBDnTXvffqhMk/9asi+7R3TiM4uROmh+pnwUxg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MzoM4Bd7b7ZV2oyQfYxCnBbiYbSy87fH3jdo7HpXygr718I6slayUPzk88C7HJaO7
 7BtVHN37x4kvdvAfJaQFxYN8itrZfzu3PpusQMszII08YvY51v49/XjFxztLEATs18
 k8epnODrCiZXHpAku5WAtzkY2hBWBj3c89W2WnMs=
Date: Sun, 20 Oct 2019 21:09:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 3/9] tests/acceptance: Send <carriage return> on
 serial lines
Message-ID: <20191020100906.GL1960@umbus.fritz.box>
References: <20191017165239.30159-1-f4bug@amsat.org>
 <20191017165239.30159-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c8JyeaiReRNoiMDS"
Content-Disposition: inline
In-Reply-To: <20191017165239.30159-4-f4bug@amsat.org>
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--c8JyeaiReRNoiMDS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 06:52:33PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Some firmwares don't parse the <Newline> control character and
> expect a <carriage return>.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 9ff2213874..bf9861296a 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -30,7 +30,7 @@ class BootLinuxConsole(Test):
>      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
> =20
>      def exec_command_and_wait_for_pattern(self, command, success_message=
):
> -        command +=3D '\n'
> +        command +=3D '\r\n'

I'm actually wondering if '\r' alone is really what we should be using
here.  Isn't that usually the character that actually pressing the
Enter key generates (on an old school tty)?  IIRC it's the thing on
the other side of the console that echoes back a \r and \n in order to
reposition the cursor on the next line.

>          self.vm.console_socket.sendall(command.encode())
>          wait_for_console_pattern(self, success_message)
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c8JyeaiReRNoiMDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2sMkIACgkQbDjKyiDZ
s5J5GxAA30cQi7XN06LXpQYJbWAm5iVryebzz4BEL6lB6W10jxg37SECNC5EwfTI
9WisKJWGEFornvmQliDhxVg7UqJePxvg/vMucGkIAZ55LrDwLfX9cy5TVocXiSPP
68WDUCsHZ8ax8IjTX9P7AQFKltKYzPA66GCuYtr/JJWzfbzgrSHLOvkj8IlOIN3e
zAh/rDu100QUrmAMajg9HEXU6xHy3iZi+h71y0yuuPG8AQcQW+29lLMOa+2NkmeU
34cBwVdPbzYweS7myPRTAE3fZ36EhK0HRYJonOhZILHp9LyeGm42dFerKisQ4gzM
8onHHYwZG8wjEhI15XboG34PN9teBbTIvaYLGdx8/3Kix9+kg0Qao9SFgqROP24E
eS6+2SYAjred20wpGbbY+YJr80dj83sNSrjYQpy6ujGLu/hLdzDE6GYU7X9w2Ex7
7ZJ4gHtBIJedNMmyGbkTBSigoYH4UudeDqTaPh5w4koRxZ6OceJ0UZpDBODasu+d
cMaIwkD++yM+8HTEcXfIuZkHmzIPvzfwc+rz9Il9cRCEL3deLcXMytTHa0mvZSn8
qObbVRDA/QL51pez124QaEBB/rG1XrCiLYijH9CoqTo6eaS6dReiX2q9NtDkgduq
thutXZ6IQgJhCG6dIKDTFOOoHlM39fin+odugKaLcmxyVtkgLKc=
=cEAB
-----END PGP SIGNATURE-----

--c8JyeaiReRNoiMDS--

