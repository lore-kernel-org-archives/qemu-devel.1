Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6640AC46460
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2510C20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 19:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bXdpXbBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2510C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOoOf-00089e-TE
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 15:08:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50049)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOoNp-0007qh-VQ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOoNp-0001Du-0x
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:07:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:43127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hOoNo-0001Dk-MS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 15:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557428783;
	bh=S85LzAoN57n9d6zwX8Fu8gq/h6tvzAhzgkUPPMXZMog=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=bXdpXbBOMdettQLhstwJIgJbxcWgfPI8cJyfZxprBO42LV/5Va/D8Dtji96sQrfWT
	BvbZnH1GJrVOyZ0n2RcpfGYhQpi038t/vqiZ2i0BF5rpxoiodKYxFidXGl5mzA8rOo
	TlzAm8/J9mjz1ade1dddMpHLdJcTSKOCbGgsVdNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
	[212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbEp-1hYOsP2rUR-009k60;
	Thu, 09 May 2019 21:06:22 +0200
To: Richard Henderson <richard.henderson@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-12-kraxel@redhat.com>
	<461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
	<20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
	<d4939e4c-4e31-4330-0180-8c3c73378d24@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
	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
	4XSbcg==
Message-ID: <229e601e-3b39-be2f-f6a0-59e3c959209e@gmx.com>
Date: Thu, 9 May 2019 21:07:07 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <d4939e4c-4e31-4330-0180-8c3c73378d24@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="THGesaAxzFOiKi1EEmHafLFPTqirUWZmo"
X-Provags-ID: V03:K1:1Wy7Ne72XWwc3RNJWZaGf0mu9xop/PRrYGnBJpORt8l7vAc8BGB
	q3/MvUcvH3oY6Qgm/IeuGGzWgMRaY3Si5saEYjwK4QIfzkoj4hPzjWrWhg4OYjEOKD/bgZs
	YBGd28L9xkBtIHPMc6rmpodSkB6zOnk3dkR2EFzjiftICABBQyK6l++uYe7cl8mS5G4mgr/
	zseQBsCQfZ9nguew2wPsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W3mXVA6gdrc=:S3sZYXN4KS/7KBgFflqNxa
	FhULH06IuTy7b7YNYYgo93lYY8q5bB+Ofo7dtLt0FOj9qGGXlTgHp6j5JrhqO2evKTTu+4y41
	LJ0C41JPW+17tipnm2yn64mxczkAkPsCbZf0T3QaqE0DRNenLiMA50UqNRp34j33g3PYmIO0r
	ARxoAZwkqKYbiRt3l/fSiCGlgVvKJue5AviTe1gcR502YASyH7g6FHxulAaC3BrM0YVj6q3zU
	hqDQwooFiUuQubZ9YK6KNlDmpCeB53FGry5GgB9BFcIWKuNtpl6n6Q6dDdqUwpsnOJ0t0KFG+
	dY3kyc3Y0ZfU1O9gi9Xp3j67lt1B1IJMCsGj4LmVYvEJEB+EW1ay+7UCbknRlyHOJa8Ib1HqJ
	iPy3CmunyzTvYryIWihn+p0zkgqhZU0JfamT82CjZKZg/Ju49DBKtcAS4IN9e9CLJyYqcL/HD
	rg/VdZ5WK3XxYElbj/q4fMsrX1tGYHh2D2EFdbMODfp2HVRXafTDTH4+wGgXd6WO1PbxW7GQZ
	39M8bnlDNi31xiUVV3qHxXLPqwCLkHSouiLmBVnu44HU7BKtjE10rqUcIEzZbR+lkPMiu84Ek
	6QoQpiHCixSNw41tg33r2I8JhVWMDmeAiBFDjdLelPo5zqhRRHIrsYhbAnftDqtK/qnCn2Icf
	6iaYFIBtxQUYfeiiy3OuLdOYdaBQEZOQXZ5WhTB4n4H0rR4IvqpQW3JWwaqiA8E1eOI4Pwv7d
	ts+kP2gi6uTIYsruoGVDirdKESjK6urX9tuZH/SP2cpstrm1nD9XE/qy/ukHcCNQaRRW1H7IW
	F2z+4jOSL2g55xUSybT5DaTMYNfmcTZQeePDGUIZlJJqRGukexcS4zotfSJODMe6BUQ4yj+2S
	+Cpv53jsq/B51eeVp27INBaANn1c9/lsBLGg4cKTw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--THGesaAxzFOiKi1EEmHafLFPTqirUWZmo
From: Kamil Rytarowski <n54@gmx.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Message-ID: <229e601e-3b39-be2f-f6a0-59e3c959209e@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall, using
 serial console
References: <20190508085645.11595-1-kraxel@redhat.com>
 <20190508085645.11595-12-kraxel@redhat.com>
 <461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
 <20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
 <d4939e4c-4e31-4330-0180-8c3c73378d24@linaro.org>
In-Reply-To: <d4939e4c-4e31-4330-0180-8c3c73378d24@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.05.2019 18:39, Richard Henderson wrote:
> On 5/8/19 11:47 PM, Gerd Hoffmann wrote:
>> So, from looking at the patch it seems you need two mappings of the sa=
me
>> page, one writable and one executable.
>>
>> Or, maybe it is also possible with one mapping which is writable first=

>> when you fill it with code, then gets flipped over to executable when
>> you are done with the initialization and want use it.
>>
>> Is that correct?
>=20
> That's certainly the way I read that patch.
>=20
>> I suspect supporting that in tcg isn't exactly trivial.
>=20
> It shouldn't be too hard, if required.  All of the writing to the buffe=
r is
> isolated to a couple of inline functions.
>=20
> I do wonder if using paxctl -m as a part of the build process for affec=
ted *BSD
> isn't just as easy?
>=20

paxctl(8) is available only for NetBSD.

paxctl(8) is the last resort solution and shall be avoided due to a
security risk.

Only few exceptions shall be allowed to switch mapping protection or
request RWX mappings (mainly JIT and a process running under a debugger).=


>=20
> r~
>=20



--THGesaAxzFOiKi1EEmHafLFPTqirUWZmo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzUelwACgkQS7MI6bAu
dmxcNA//fU6Tyq0AYUy7nzZV2BhwexUwYF3K/B3t53S+MafEVweloZdEqOrV7QFg
bZ4JWfi1AiQauuvITK3l2csjj83DjWVXdNy5tBf0hPxiCKZ71S6RVEzxxp/TqfQx
Ddqf51fJBGR1exuoo6X/FQUCXFAgrq8atXZKstWbhduk2iRHcRTIogHU4C/fuDgf
oNycH/Wv5sulomEzIDX0KlU7Xb2T24Fx13j/9afY/AodRc2AzJty3i80IRhnGz49
hhBAwdINoLRrtGIxEQlBRwIBdRON1KwMwN59FY5bBwlO+srMwNFCN3JicFizsn5O
bSIdX3ggcIu1vln6rfB2FQGkHesZRccLaorwlldatAAXcu6Kx8LkTKlnQWvoYJnO
RcrfbHY3Z75PeXVPVCJcFkDOXSoYaOaRm7xE8QoXIzZ/Vvwhy4CbOA/X5rA/akjc
KZq5O8SKKAvh/Uwh4TmXyIwD0nZgLwikTc07Wp96q11jPVAHXuzoujWbj3cbhQ8i
XAod8xN/aTf+gbF1mApZ+bchm0bopDTR5UC96nBnQ8O009ATRPUBJU5+xBCNaGp5
ycyMg1oUyQIotmBS1guNmkS8zA7o5F7lnlgg9v1Bo/6ACOxozlNy5Nk3M4wWKRhW
iqJQWszlKhDKndXxYdjjTug7r3pzl7Zhxe4qzeHT1WmXD9kWX8c=
=vCyU
-----END PGP SIGNATURE-----

--THGesaAxzFOiKi1EEmHafLFPTqirUWZmo--

