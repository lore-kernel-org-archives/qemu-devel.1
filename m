Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D98C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC21A21019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fV+46R+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC21A21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOGft-0006vU-28
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 03:07:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48643)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOGew-0006Zv-9Z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOGev-0001BJ-0C
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:06:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:40943)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOGeu-000198-Ly; Wed, 08 May 2019 03:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557299158;
	bh=BXqA63O2tsMR0stFvXKRYR5TteyQf26EoJYlrZdu/Wo=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=fV+46R+VcJuzettywwi91Wo5BLO8Y9GXqdHMQrSOvVU1lc8hPn7wAMT2XzvxM3czj
	qqvsl/YHBvDY1OJCD+40VwbZfqZqfsQ/px4VBwO5mcOkJzIopQOP3vI3G+DZujk2ti
	59WZkAva/CNTY0a6ueq4E4WXqIsf0bvhApOGfcTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
	[212.227.17.174]) with ESMTPSA (Nemesis) id 1N17YY-1ghwXn4BSM-012W6S;
	Wed, 08 May 2019 09:05:58 +0200
To: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>,
	Kamil Rytarowski <kamil@netbsd.org>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
	<f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
	<0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
	<13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
	<c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <d24f9f08-4feb-1372-844e-ff58e0d2dce4@gmx.com>
Date: Wed, 8 May 2019 09:06:10 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S2U4EKDvkuPkjNoAo8ktBuGascpNEiYNl"
X-Provags-ID: V03:K1:m8yID5DxNd0UjYU522UaDIBBjotfJsL1AUdYLmUpEGQYNjhZ/2G
	P0OVyywReKlSAaaUq3pdDQyYgb5TQdEkcJvyrNMxpnr2kfQSnOTsJnJsTHRpRAIdqoEj5Sl
	WxVvlxBfIyMmOXla127EtqOa19D8hVdBwz9yEW+rI/APA3IrfA7IAhF/IMB54tYvmGHSCDd
	fc19Qf3QtlSAu7uvnYVFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nduTQTkLNh8=:9MgeDD1dJZDI1yqdwejMVZ
	BXSzsLOgmaN7qXhnKcdom0dTzIcd+yw9O0XhpMNrfK6BurVeWrCTH4RWUYa2uxjbIWmy4Ubcz
	8zoPPd1gSjTbhiHUcyJevJVgjizTTN1rO5dVc1h2/Xv3b6z3353Cx0/9iNl634wT8Ffyj6w2m
	1CjnPBLJCHokYemtlg3Re8pLz+bbVcpCrSOhERkowuLmozGswG1AzH93DErIWAwHwQcxm7KlD
	49r1k87txqRv91P9zJOirq0zN0lBk7ulD/dlGUAx+G8wpsCVU3SYgosuEyPZZqbWzjslZvVsP
	DBrEMn13VVZvhHl6OEtbI3dOugVJnq/Z86cKVF02ZFXluRmx7qqjeKefwIhqqymhdedbmzbzP
	TgrqOTVsWz5FK8/ahPDv5rJAkoi0Vds+ySvcVP93H80dOvxAQRWOdbzjd5YrZwVuYJiXdPluZ
	2IcnCVyM8Fy+Bjs6SBdHo2bhxcGr/fRzDAWm7zLBtwCfA+Um/xmmDMeCBG8Y+IygocQFH2+QG
	3fjRau3m8uA8FTVNg7eMMQ9pGuo4JsLwujhHYhLXI4mguomEsEvjiUWSFtreg9YKsK45ZeBSS
	F75cvShtl8GOswbJcm+mmCxnd1+xRHYvNzadSmbSgPgfvMpWQao6I/oYy8VKaBy377BVF/aWW
	z12BH7/jcASTy37Y7GJtVdVCSsl2YYQNx6Pam173tIVWDe4RIaH37AVe5yTI/70BJUwpDzRIS
	AZCjlAdUP1x2dqjeke8PPuX1+PI5U0ba31aT9WDZk5jXA/wXK+US3zgusns535SN7wSGSmRLJ
	j8Xl6mZeUutvDu4hj34nzwaj+eqkkaUw/j2YS8f+kz8S4CLojrPVrIM50ihKGDxF4A9Q2QdY/
	pJbk2sR2ue6GDUUvwRibkz64SF05mIBQiE8xaWL8I=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Update *BSD images with gnu-sed and bash
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S2U4EKDvkuPkjNoAo8ktBuGascpNEiYNl
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Kamil Rytarowski <kamil@netbsd.org>
Cc: Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <d24f9f08-4feb-1372-844e-ff58e0d2dce4@gmx.com>
Subject: Re: Update *BSD images with gnu-sed and bash
References: <20190424103747.10173-1-thuth@redhat.com>
 <20190424103747.10173-5-thuth@redhat.com>
 <f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
 <0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
 <13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
 <c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
In-Reply-To: <c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.2019 12:12, Thomas Huth wrote:
> On 26/04/2019 18.43, Laszlo Ersek wrote:
>> On 04/25/19 08:00, Thomas Huth wrote:
>>> On 24/04/2019 23.29, Wainer dos Santos Moschetta wrote:
>>>> Hello Thomas,
>>>>
>>>> On 04/24/2019 07:37 AM, Thomas Huth wrote:
>>>>> We are going to enable the qemu-iotests during "make check" again,
>>>>> and for running the iotests, we need bash and gnu-sed.
>>>> [...]
>>>> It needs to get the Freebsd image [1] updated too, in order to `make=

>>>> BUILD_TARGET=3Dcheck vm-build-freebsd` passes. Here it failed with:
>>>> ---
>>>> env: bash: No such file or directory
>>>> gmake: *** [/var/tmp/qemu-test.6OlDFH/tests/Makefile.include:1101:
>>>> check-tests/qemu-iotests-quick.sh] Error 1
>>>> gmake: *** Waiting for unfinished jobs....
>>>> ---
>>>>
>>>> I'm not sure about the netbsd and openbsd images, they might need ba=
sh
>>>> and gnu-sed as well.
>>>
>>> D'oh! Does anybody know what are the correct steps to update these im=
ages?
>>
>> (1) make the OPENBSD subsystem maintainer care
>>
>> (2) update <https://wiki.qemu.org/Hosts/BSD>
>>
>> (3) download the image from download.patchew.org, boot it and update i=
t
>>
>> (4) upload the image to download.patchew.org
>>
>> (5) update the "tests/vm/openbsd" script in the QEMU tree in sync
>> (checksums, commands etc)
>=20
>  Ed, Li-Wen,
>=20
> any chance you could help with updating the FreeBSD image and the
> tests/vm/freebsd script, so that we get more test covarage here?
>=20
>  Kamil,
>=20
> could you maybe help with the NetBSD image and the tests/vm/netbsd scri=
pt?
>=20

Please be more specific what am I expected to do.

>  Brad,
>=20
> could you please help with the OpenBSD image and the tests/vm/openbsd
> script?
>=20
> I think it would also be good to update the images to the latest
> released versions, too...
>=20
> And IIRC, there was also a thread recently that it would also be good t=
o
> have the "xz" tool in all of these images, too...
>=20
>  Thanks,
>   Thomas
>=20



--S2U4EKDvkuPkjNoAo8ktBuGascpNEiYNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzSf+MMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsnHgP+wSU57t13fmAeTE9RXaR91NtZaO606m9Ksmkr+ag
Np6GpyHMjLexhjhpaSJyDXGqNoIujF4WAwsZO8YYV19p5XEn7XgyB4BFz3nkNBZg
pEcVDa0MyeeM33fZbbHeGkUHkTErPzwoSZoDqgjESaB85t/4xTgwcz5Q6Gt89vlc
la24JeDqx8eirnIW2l9aHrLqaka05UmACQ2cV4OXLLWrElkW19/VmO7WgkUpfLMA
jtL13ezSt6LPgb+n30RRblPZAk1kq8VdElY4WNUs65KbagQLD/AY7H+DpIuh/pHP
TvhHAxFZGGaW0Tv/7G7idtMhyREJru1OuNlX0OPraWPItVRUkIv3N4dV3x9cxKdC
aTbg9F8FEMO3QO5gFsAmp59o6ERVxLprTRrcaOKLO5IL/lrFxoBsronlnSSrTuWZ
NDefAl/74Doa1Oifi6Zq8tMDvONdIqIciSq8djjykb0GCEC7S3EkoEMZ8jBDJeet
jw0zHaWguk5Mdi3tOLdw748zdRPbUwQM5Aa2YvB8o4DbdVCmBS2HHzR4Eh1o3um5
56PeZpTT4tJbPXodqSdBfM6+h3T9ALYPi1z1AFDa7rKWSAK/+vQUmmQzWd8NoPST
NWoMgELhrBOz9MslNNlilRJOQeivDrpSnuQy/z61ifokEL9pYl2NPD/+Ak4eSUFg
fTcP
=S+eX
-----END PGP SIGNATURE-----

--S2U4EKDvkuPkjNoAo8ktBuGascpNEiYNl--

