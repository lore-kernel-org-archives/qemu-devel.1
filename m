Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF0C5B576
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8128D208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 22:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="clLTmbve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8128D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgcg1-0001sO-T5
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 18:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <n54@gmx.com>) id 1hgceU-0001EQ-WA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1hgceT-00028T-MB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:13:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:56601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1hgceS-00022e-Pj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 18:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1561673627;
 bh=HWRUdA72madAHPiulRa9Xp/gQ7lUzgT7ewhgBlm2jFI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=clLTmbvelO3lGOLSs3OzcOumXk+ZhxhKMgD1oV8PXAhrDQ66xRCcEKf0jVKybb9+z
 H8IZHDQnQMGsIv/Z9kdFCtW639lwDEkrFUy5tRSh49nUW4TYKtBccdx5dRzqtd/GH/
 o15oWLmT4f/+xV7qQawDL4SeWe/sSgazn2Z5+BwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1hckch0uTi-00514L; Thu, 27
 Jun 2019 23:47:17 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <62d7304c-0d3c-9c34-4934-d11393477ec5@gmx.com>
Date: Thu, 27 Jun 2019 23:47:44 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190627110201.1999-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tQKONh1Iwost6NgNwE91eo3fOg1NWsQMO"
X-Provags-ID: V03:K1:IxnCKi5HnfRkJNL2h3o3zZ81RCC9R+lsSbc7wMVfgjxNp8ZkmHb
 Ovmis14ojTFGwqRsAmeI8A35AZal9lR2z6TEsMkNIuRbd34AkUArEsUW52Y71bWaRaa09P0
 izY+pdI0FRoPrGWcTt0mK6RVZqNzCecA3mEgs9/JTrqUy03EOxs0Na6Mp3UvkvWXku50E3X
 unwH/5Rkw6/NnXIckfOPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Eo33oMxXcEQ=:kTGGb+hDtwbUmZ7XI8dKvZ
 Lt0ffPimXYRdud1ouLcK4Q3bmsq3/HmjAD77GxUFTkCnTcXrqJLlE7el35HmGV40YFvmSCABC
 +wAy/ReKlEWtK0tDH/RbIoifJ8/3wavp1Dh/MnQsNFHCdQ6utrWIE8jgE+jcjFXNMXckhYF2Y
 myoXS4qvTKjfkdlaITx/kdXe+H9NOxCR/1+8+cmaWbX24QqmNu63xNr1rpb48lKUNmgSjeiwx
 9v9nEpN/7K9T9jwwhZ1ab1hp0k+Q1VDirLYqBvfdYpLlNH3VoNHkGFfNPo/cJA5+ykbjib/xh
 HIwdlcXvMwdGBCsQod+CCBz+yn335e9bVL4I0e4jT7vls/dNdxt4AH+IeERN0kYA4SPArfP4g
 e7pYMEmWl9uQBuXMk9cUx/P9zt1ZhX3NqiZEzy9oyT7JxXY0kSwPS2sGcWj/orVlOd1ssDZVI
 P4Xb8FiD2kAb9ie2NsWgNptMVZpjwdqUmb07OK2e+JcessaRqBBIStBrnsLcq9OQr6ZNKYh0N
 swMUpRoieA7mDf9Fv1kMzF/2RRuPB1+ucfAMLohEgZtbilHU5mAbRPfLIGVssbbp1Kj1LjElE
 J3WDTVdMEYrmM46zhIv9vWK5bcnVmCvz823wX/+VHHyhuhmOqM2yx9GTGxPEnoLNc6uHZz+Fz
 DbE5laqEgzxF69Ri9zB9aTFm0zqtGr1ifSvogIBcwgfluKdHqVvi1UDoW72Vt7IDzsPtwGbuY
 GF5+gEJPKtRRfssO1ljM1NXfUMhwc996cjrUKxaBmnHLOxmEpwwPKrI7utcekEFO+86XCn9tf
 i50Q8aJ08FOZ/be4TuGbDJYXFkWHic9d4ZM2K4ID7B/OgvCBes5wEnfDUk1TZm6ibh5ihoj4u
 6b0s7xjEEmgYYSWN/E30yGT6gu6HSBRyNgq8lutVLhgxTTQNWwN2OEECFeYJaHwMq/cmio3r5
 qp1Pyjm+v9eOxCuBbHtobpj+LdoADHIc/Bf0hJ6XZnfP5Xe1OQEOuKdZ4HwK9V0Hc8cKHc2Io
 LaFpMsP7t05YKWbv9k3A15Sg4A2KnELuaZFfaLTWQSgvLkCpRSMbVUMiFbk62qvpnA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
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
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tQKONh1Iwost6NgNwE91eo3fOg1NWsQMO
Content-Type: multipart/mixed; boundary="kapnZ16q717Bc1bs68WjTIyBssVgReSU3";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <62d7304c-0d3c-9c34-4934-d11393477ec5@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
In-Reply-To: <20190627110201.1999-2-f4bug@amsat.org>

--kapnZ16q717Bc1bs68WjTIyBssVgReSU3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.06.2019 13:01, Philippe Mathieu-Daud=C3=A9 wrote:
> +        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> +                    '7020-40p/P12H0456.IMG')
> +        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_has=
h)
> +        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archi=
ve/'
> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0=
=2Efs')
> +        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> +        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_=
hash)
> +
> +        self.vm.set_machine('40p')
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', bios_path,
> +                         '-fda', drive_path)
> +        self.vm.launch()
> +        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PS=
T 2007'

Is there a specific reason to use NetBSD 4.0? It's a very old release,
the newest one is 8.1.


--kapnZ16q717Bc1bs68WjTIyBssVgReSU3--

--tQKONh1Iwost6NgNwE91eo3fOg1NWsQMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl0VOYAACgkQS7MI6bAu
dmzxABAArZSNpRu7c4Uz2EfcM5rwZsAUgZeMz2PjXjnqpyUUHxTtBmg+bjrA6FGz
vP8DV6Lbj9nCfGH7hEvlBqZHLzlEw/+isy9rnGBYXXRaAKPX6W3yUF/nEF8M8PEd
FzhMUfhEus7esTmGZJqP7EqnSI31Xh3iw2A8X3CF/zXBUtLwWO2599h86z2IU7mN
eJaPM4wlZKtTMS01PRBodBk/jnIIHv9fK+RUQ6xz2SIHws8asUi+ACXQ+CqhYS9Z
QfZmqPuJKBETxYbK3MHkqgijzSPa1fSkJuQu5BOHcG6PuJvgM9vnYnLDTc28EhGm
Q/xiXC5dT+Rm0at8Yla0yLMiX9rahCMHRaSV3YHudi7LWMJTKB9I6Fl42TkqFEgE
YJ+G2Iy9kXgZelDqKjxCoGhWhfr697fUA9kXV6Bth/V2b24d1ULuZy1E+fM3LeQ1
a6GPBWoNM9D3LqFxcwgYKBYeWvXBVNeWH9gvBREXCDmJ2mcT7K/zU/8Q7sqSiY6X
+fmLcnzzBqrCJ4f5cqyr/E6Vg/xEp9s0spQ3ECgAkrZLEWpHUzR96fx/rMZoUbOH
O9Q/2j3C6wqMvWABDF7mjvPVmbBo4GzLgx2IOc+ZmcgrsUz+A6enGbmBGql3ugJQ
lomyuDsF6nlX0QuRMmJKtkwMO4rK6oeZQcu4Ua7aomRp7gxbrYc=
=LhTi
-----END PGP SIGNATURE-----

--tQKONh1Iwost6NgNwE91eo3fOg1NWsQMO--

