Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E97C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 06:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4410621670
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 06:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fJai8FWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4410621670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjeOU-00057h-8c
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 02:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47289)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <n54@gmx.com>) id 1hjeMj-0004ac-7R
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 02:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1hjeMh-0000Gf-Bd
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 02:40:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:43083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1hjeMf-0000Ed-Mn
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 02:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1562395164;
 bh=sTUdg5vW3cqIf70SECYZ8XO7Ja41IJlLLVsOTJvNUoo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=fJai8FWMO1RRan8zWWstEmcaoZq0RRcdiIDN67qVkLYcdN/4MFart8tcB4dNe+Mjv
 a192iTh5a+sVqUJOee6JJb9tihRdGayfK9AwK710ltJM/fkZSmAoh0pS06l0XTEYwD
 7M3lv07QS9tn+aWMqgAscwX4VSebWkmpaCoYM2mY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MEFqW-1hhVh62aBE-00FQZB; Sat, 06
 Jul 2019 08:39:24 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
 <62d7304c-0d3c-9c34-4934-d11393477ec5@gmx.com>
 <3a22cfdb-2968-83a5-5ffd-064e808d2f7d@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <57258ea8-4355-e53e-87b9-e54f76cc43da@gmx.com>
Date: Sat, 6 Jul 2019 08:39:38 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3a22cfdb-2968-83a5-5ffd-064e808d2f7d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pjVCDhqmGA0GyRj2NonzC81e2qXRrIg3I"
X-Provags-ID: V03:K1:6RBFVevIriEfrR9ezSgsNXxhB1fmbU9syBEplvcx79pRQsVpT7/
 qXw25JxQjcA+vkpzVA+KDgDFDuv0n0UPinJGM7EeN+k4xVYHBVSNzkoImt4WkksZ/vMuzxf
 uB7SPnkfJu/CiQkAaj1CUd7bUJu3yJticMz1qH3dLNhAsL0sUXGBSfNhjzes8aQyCTOQrmX
 +/hcg9OrFvR4XjK6dZ47g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9eil9hqIlns=:mNNmDB7JnzRjRAiIi1mEwe
 t2+13arTYPdjEwKLnltPgQa6pw5BSu+Tw+rsrAIlhVp/Lyf9tHwKmxwrpFpEWPR3duKXmjJQB
 Sd0se4JNDiTQFLVq2TFAHPP6LOfsmC8YR1KBWB6yxCphtx+RrvWxwSVcCCUQuRqNbU6t7hpzQ
 32Y0XCedZ5OxHNFWLiPh6ysMJQbRhH42y+YvEPB5VGsc9GWtYrw5ThQgfk/vfPXHv48mwgz5N
 O37O9LTSGtHSLdfTI6uM956yDfCttVMbsNGBu9vCEcLjQyoY0qymdJN/+anbIpi5XjHbp17X/
 fiHc2f9S8amtwSGorbTKuoDL3HSHRLm/bo74yzOBX9+nbyoNha/5NYppBB67tds8jDV3QSg7Q
 gIHBk6gZoqhBdc8DPs7ie83ykR/RD0pmIw+dNa6RbSygbfqw0SdP6F1HOEK5ufoZL3LM0hy1/
 kb2ksVQHQawUw0yPDqDRUoGK3wfP6LdakfWEmpn2dtVntm3GtDBfY9O9vCuUnMYKfYx5ocoyV
 IDJvc2/IqP1BNGn8SK6gJWPa0AUfYUBZkq5ywaM9IP+AtPcWnC9wwHhbzOBZVSJnojeDh9XMN
 AdMM3CVNwLnXONr9GrPAGkcmXXoqc6mqH/HwnRyz9d25zTBfTWbLila8sClHpVgJ2xPL6W7sC
 QB0WbYUSbWexTV3E+VKY8Ogb+msMaFuYVl+m8uFyaimpuh8g6Anbv+/BCLj+t47gAwyHj5Jqj
 REbtDvCZ39AK9dh34EMXakV/wIL4K2Nd9loQ0Gz1xgoV0gcV/90eP/+jRyi57AyiEQUtDn6ID
 iQM6B8u+PdUV6drUriOfskzkKAX9Pf7X7jB+2+PpVcGKQBOD6NMUuXxAsF0wgDOEzlWl9dyYd
 Uvf18yPCCishBqPtMkrPtFDlQOjMEL7VO6gIk/CMdOm8lW7gqsaM4L3nN8CWkOtTvpLPBKNwN
 4UK4V09laVAYfFEbJ6eWew79TMwnNRODZn6/cVyfiHG91stMXPR1ZN9KO/kACqp5G8uVfVEZU
 WjWAyoDJehicf4Ap7x+MTN4YQqS1GAX8+xQB3T/R1eYUMb4fEktZNrhC4FC9V2jhWw==
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pjVCDhqmGA0GyRj2NonzC81e2qXRrIg3I
Content-Type: multipart/mixed; boundary="icOcndHsjW941fTsIj8la8gRBn2oextxr";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <huth@tuxfamily.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <57258ea8-4355-e53e-87b9-e54f76cc43da@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/acceptance: Add test that runs
 NetBSD installer on PRep/40p
References: <20190627110201.1999-1-f4bug@amsat.org>
 <20190627110201.1999-2-f4bug@amsat.org>
 <62d7304c-0d3c-9c34-4934-d11393477ec5@gmx.com>
 <3a22cfdb-2968-83a5-5ffd-064e808d2f7d@redhat.com>
In-Reply-To: <3a22cfdb-2968-83a5-5ffd-064e808d2f7d@redhat.com>

--icOcndHsjW941fTsIj8la8gRBn2oextxr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.2019 20:00, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Kamil,
>=20
> On 6/27/19 11:47 PM, Kamil Rytarowski wrote:
>> On 27.06.2019 13:01, Philippe Mathieu-Daud=C3=A9 wrote:
>>> +        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
>>> +                    '7020-40p/P12H0456.IMG')
>>> +        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>>> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_h=
ash)
>>> +        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-arc=
hive/'
>>> +                     'NetBSD-4.0/prep/installation/floppy/generic_co=
m0.fs')
>>> +        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>>> +        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddriv=
e_hash)
>>> +
>>> +        self.vm.set_machine('40p')
>>> +        self.vm.set_console()
>>> +        self.vm.add_args('-bios', bios_path,
>>> +                         '-fda', drive_path)
>>> +        self.vm.launch()
>>> +        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 =
PST 2007'
>>
>> Is there a specific reason to use NetBSD 4.0? It's a very old release,=

>> the newest one is 8.1.
>=20
> The goal of these integration tests is to verify a specific
> configuration that worked in the past still works with today codebase.
>=20
> It is particularly useful for machines that have not a big quantity of
> users.
>=20
> This test does not intent to test NetBSD, but that the PReP/40p machine=

> is still working, as it used to work in the post saved in the commit
> description:
>=20
> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
>=20
> So this test is useful to avoid the PReP machine code to bitrot.
>=20
> I'd like to know what other from the QEMU community think/expect about
> these tests.
>=20

This is understood and appreciated as NetBSD still formally supports the
prep port.

> FWIW I tested newer versions and they don't boot.
>=20

This is what I wanted to know, whether this was an accident in using an
older version or not. I will try to report it to other developers and
maybe someone could debug and fix it.

> Regards,
>=20
> Phil.
>=20



--icOcndHsjW941fTsIj8la8gRBn2oextxr--

--pjVCDhqmGA0GyRj2NonzC81e2qXRrIg3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl0gQioACgkQS7MI6bAu
dmzqvw/5AWxd5x+Ql1OaQ/yDdnEEiodcw0EFbCXxtVfUswRm+ALgkAeyq56y5C9m
l9uhjirWphhrIKU2h8wp229rBvXODLgoNB8RIBBbbkpPFtHN4UzjinQlfvhkSK9W
QxkY4cQmbisP/FNQ7Jf5vgopc4GFfG8SADSal2pLNEPHgBBWiloiTE7qa0ZsD6vg
2YwddhgIAUlwENuqJCAh2uT/WgSYqlaOoloiWkPKNH/fqorw+m9EH33UyrgPfb22
EYurku57jlMWjRW3tnguhyD4y4rIutzOgCkyF03VfipJh//jLmu/TS5dlprVrUt0
05v6Auh15PQTkdIVI3yEDfe9JzYJmOgYDCF1VeU3U/Pd7RdW3PvC2Ckiqdx2A11d
8j/4wSzBLWLz2/7mZhn+1QAWskj+mKAwXZljj8zgckbKXsLWnXmfJqbx0tgQkj4M
kQGMlFiiVm2JjKC2dv6F/KaPXwJsLr1apcZD2gQ146ydP2sUnMBTNMz4Ua9XWhTj
DKYZNBIq8mAKVl5vugaZKRFCwbbMOzk7k4NKq60GzzBN+voTI9MVY43BvejghQI9
mQwYar8pKo+6pELGZQ+ZG09MZxJR06j0wfPsmFppoJZW69i0WcWZKreTwWSwmVa9
e7LQZzznRsTcPAwP7dM6sCeqySBI3NvslXB812GF83OK04NcmVM=
=PgKs
-----END PGP SIGNATURE-----

--pjVCDhqmGA0GyRj2NonzC81e2qXRrIg3I--

