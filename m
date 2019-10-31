Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5533CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99CC20862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MGaw+0/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99CC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7y5-0003IE-UL
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iQ7al-0004KX-JN
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iQ7ak-0007s3-JB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:22:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:55473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iQ7ak-0007oH-0X
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1572517321;
 bh=MBpZsDbr6CMTuPXYeTqS2HrZyxcbDGg4MkSQ2BX52Ho=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=MGaw+0/e+Od9m2fFLY1unlUcl3/kwQKo6nltOkwG4Dl7jzKllIuPt9BLqda0pzol2
 g9u+hzbgc9+a7UJlLQKAu3NpH5x44FGyxBm66NTXWX9w8YQJjMS9SNRRru4eE/HAG3
 QnRS/j/cT1rx8qzDr1SAxo95eVFfBPOguI9GGgXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1HZi-1iNNlT2O78-002s7G; Thu, 31
 Oct 2019 11:22:01 +0100
Subject: Re: [PATCH v6 3/4] tests/vm: use console_consume for netbsd
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20191031085306.28888-1-kraxel@redhat.com>
 <20191031085306.28888-4-kraxel@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <6999581f-907c-ccea-5b55-b7be826a9fe9@gmx.com>
Date: Thu, 31 Oct 2019 11:22:02 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191031085306.28888-4-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kGQcZ0gQ2yst3H3dgVoxmnETGbaAOUuQi"
X-Provags-ID: V03:K1:B1jnGq5xzsStpIYGcmYKcQySV5g8k7iDwZJUgY97+nP+gYQoZwC
 bbQ62jSDJYl5aiT9Ym1cEoeK2MKiPOinRC94sb48OlCFWDfB+8aHCqrh7k8HuOtX8YvPfGW
 KeTVTUU+zx/M6d2N4phnpCQ1VgnZxf00ez3zHq5qf/4bi19ipS3lNqbZi2fBiJZgBArSyCn
 KSGIuVse7Nvo8Jtt9Bxuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w2QFWesqMOM=:9hIHnqaROeigLaiOGjBoVR
 qnbRoTUw+0ggxRBKeLr1T3OBggpST74MSrYc5uz8gy5FoJmep3fEP07BljKDNHm1O0TEETlac
 OevLGPKPxhNKBtJ+Q+akiFxUON1alaPbGe4JWb4nEEwnAoQVGQL7dOHzVBjMzCqxwGB+Ekwyt
 Xw01jHz2gBynhQI8hb13m43v1kNiZVJvC7iw4XgYsBGLiLoUSWMXvqS9z2namWcqIVe8xXXh5
 3baT2lUTfjRawwMJ7nDI6YoM7fbxd0BHGGNKkh4gvZyuUMXJ2VbNb1OV2igLmekTlEgYxCB+5
 QHrGesQsyZvuNH7ezLry1am6LQaAO8Gq5p2jPUxBbApeG86S6g1mwa6NbLCW+C+T7glRnQJn9
 klrsxsKm1QdQR67ycKvrKHHsSLn9RpnUMpIYtU1JeDJCU8U20/44X/cYTjZQ8TmeldWW+gcLE
 3iNPPtQDhKuTqqnpINMCo54OLe0jdo/VdsFNmmq6O9KeUuyO2yS/MH/MNhG7yiaqvja1ATaGI
 wA5AoBsGmWTOPwwtr/VLRBmPeYiU0zneS1PKIrcgDe6Mvwd5QRt3kuUftt+yYiLMSIW2d4PTJ
 o7bx5pxj36O04umspn7F3lXvBM4HrI/5gyVkQUtEjbKkzBafTIhasewkjkF0WK/mbn06uACCM
 lQ/tNXpBY0210T5XEDCBvqXR7a5ZBCYcZIrblcD4ZV+F+1LP/EdSQsgKyGiA1rigKl1QD+4YJ
 0LtSbh76VB5Bpq/fr93j1WWDTugOTa56dICWwyZiAOyOOsm/Qk+lpMeq5165tIyWAkjyq/fW5
 29DxL3KHNcRZ9ntR0PZaUVEMCUBRINWOMnlFAN+ipuNBFtq2JqXv9+isRRO9Cvbe8hJ+Y/dfG
 Us+hDB9ceF9hTMDaZysaaXFmvtsra6Hn2S+Lg2SuoKL4bpaJX+0SVdkOeRymy+yOufdA98jGT
 Cgxoe2+q2aisqyw5lvKiTjIQ0zU8Mxh0r/DfYmalqTT0mSBoc51FpAHu9dWh+Qey8Ezqb4WdC
 /Mk72ZIGG2i5PcyUYtZSjc7nC+59y4+2z5zDqb8A8edQ/YsujtRCVNqP0P8BNwywxKXrIh35O
 BJUEoTmzao4WkMBeTMQtQTGj/LvGcPOJCZnoCIUi6XrhmKuhp9Xg8qX8Xi4t8PjKQqVIOUnyJ
 8WsgoCNFCZGY84ms79PeuHjHmEZrFdMCSL+snxn5AmkmM4cxnj7309nOPmRpk6ruCHHFkLL5s
 nB5lRsc73/cIiQ33rSZrEjTEAsqmzp3l7T6YGVg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.20
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kGQcZ0gQ2yst3H3dgVoxmnETGbaAOUuQi
Content-Type: multipart/mixed; boundary="iASDxKRqztJqpMd1ZeQJ4tSfPzKa3ORRo"

--iASDxKRqztJqpMd1ZeQJ4tSfPzKa3ORRo
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Thank you for this work. I hope it will be fine now.

On 31.10.2019 09:53, Gerd Hoffmann wrote:
> Use new helper to read all pending console output,
> not just a single char.  Unblocks installer boot.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/netbsd | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 5e04dcd9b1..d1bccccfd0 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):
>          for char in list("5consdev com0\n"):
>              time.sleep(0.2)
>              self.console_send(char)
> -            self.console_wait("")
> +            self.console_consume()
>          self.console_wait_send("> ", "boot\n")
> =20
>          self.console_wait_send("Terminal type",            "xterm\n")
>=20



--iASDxKRqztJqpMd1ZeQJ4tSfPzKa3ORRo--

--kGQcZ0gQ2yst3H3dgVoxmnETGbaAOUuQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl26tcoACgkQS7MI6bAu
dmxJhA/+Ly9mAoeQUM2EHW7MjOzpmVbGV2hd03tvbsyhnzniosd8o+YTTP/hM3tx
LoSannzVLxN3757cyDmG5+HqNJsvvsqCh8qhT4JGJoXVnqiEM+z5NTsjTybi2iZk
stdI7OnZqm1HjY538LyHcWTCWILdpEC4PDUDzMpBQJUiLWO5lnYOpQvjfN65rRE4
rsjjf9hV5St2va+Xlb0/G0WemAD1AjU87EMx0O0krLLXuuXO0mTEb8VepBjBjdn5
I54CPWF4054vsecNCYcCGh+YPJroIXC/28ehG2YrAVGTKsoZTaV8KGWtWmaCEIqb
W9Yx27Z3x4F0cRT+Br6TwNiTA3xBfa2Cjs78yHlfPiViddEhMCXLvme6jQoxTY3K
suIAH12j7VZPyZkoRLaB0MrGaZ3jFT2MujkRBm/REGUWGJLKFDXft02P5F8w5D45
Gr9na5LoL50DhWVsb1vQGJ9dsHcBJ4BYcZwuBvHwAYDyKZ28wB7rM4BHIRjTWk+Q
ynqzwRjrsxM0UNVnL7pRZcM6VFpSR+YLNfnzVXe+8H7vHnvN7esiKtuRPYz9vSy1
/ccbXH3rHBkBr48+TG75ly5IElPgmW7sSHwcK9A4qFtzvYxgutDeh46td7bnJ8A3
UbYIXTJLrrgjwyo2DW1ZI5tYVcxfB2H33eUaWf14VFqfD1khxIg=
=E8dq
-----END PGP SIGNATURE-----

--kGQcZ0gQ2yst3H3dgVoxmnETGbaAOUuQi--

