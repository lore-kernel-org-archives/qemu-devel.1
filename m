Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BBC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F2F206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IGV/cukg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F2F206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOS9v-00077f-9H
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 15:23:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37542)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOS8u-0006kA-JR
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOS8o-0005Jw-Ff
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:22:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:52029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOS8i-0005Ba-SY; Wed, 08 May 2019 15:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557343300;
	bh=PWzLj7SY0HC0MKM3lnm67fMKbfUOWLwCoHUFKw6/mUY=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=IGV/cukg0qd8qtULN/f+4L+IHj4cyNJkdnYvgqMJbFwPeYjG7etirHUh8azokRCn7
	pE9DE0eLi3+awJwCgNzQ0DopQIWr51hKDDbO8NYKVe3e+2I/SKn67amqIHH2LOuM9L
	sSOqwi3PO7GijfGIajuxKJVmMo3tikKVP6ci9Ttk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx103
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0Lt1yI-1giGsw0CFO-012WLd;
	Wed, 08 May 2019 21:21:40 +0200
To: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>,
	Kamil Rytarowski <kamil@netbsd.org>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
	<f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
	<0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
	<13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
	<c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
	<d24f9f08-4feb-1372-844e-ff58e0d2dce4@gmx.com>
	<d65f9f6e-6761-6882-3be7-c9c65c68de3b@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <139756cd-3df0-43a6-770a-5a1273e667d5@gmx.com>
Date: Wed, 8 May 2019 21:21:58 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d65f9f6e-6761-6882-3be7-c9c65c68de3b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yil10c0523foGA5vRGKiX6fSx1iOpydXj"
X-Provags-ID: V03:K1:E4uAdldVtrof04/mKuvzlRu1kkJb/TQbihlTFkcYcJ8J9PTOZtL
	/+NymnD9l5ON/C5Jlj6uMFYwBPbTvpRC2aKjiFcy6pFDxuxfILDC3R6/m6m8VKEeg6T9Qbe
	opqDp1oW4CM6nqQrPukEUxIAieMZT7sEla6aILxF+zqFTwZSHU/+M7dlLov6vja+It55aQj
	G8cGTXnH3smAdyICXycCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UWWdBYzIE9k=:1h1BuJlWd+rsz5ZosgGVwB
	mRMdQPTEzwSf3w+8kP7CNb6I+NczBNOjCaMkCRkhU3glLtvEd9EokDfWWY1x6zWJb0PfHvTaY
	2prdSVgyHoBQxliq+P0qL3QFiSurtl0JPDhZbOL0r8v2wBobGmwNTfqeBfWQsUgeTOqkvY00/
	+FN8kQ4Y0pBU/clrUXIBJkuAfK+AkJ9Z3Y/Ql8JnYZV+aqE+xPytx1HZqOYOrO4KL7N8ZIREq
	KcYUVrJIqZrCcr5SKQBLQBwRf++pAu99bg5Q1xOixrQnH32MJhrJHoBv/nxuDRnN+9RGdclfd
	b7UZhP9W7EIAbOgg1xG6UDVOb/gM41vzfbVXhc0yJCBtLRWbU7C2cRiCDJbdEDnAUw/IPkf99
	ZDWgZIl1nuh7nUmO7xckhY4OFAZ9D2lUioRMt5uzs4ZG7Knpg63QCZN4VibAF4ONnWob3Tjw4
	DOWekRrgaKAmCshvljdMukWo8JXpialpEecSGYxa9APsjN7URjhp3g8wohqs0vwenlcO3P+Nk
	A9ouywRtUW6nxvHwR2pce7D7cZ9NilSC6lpSHLVtWMI67kvN8LMkIwy5V52O5cLGCWz1NRRdC
	ZtKRQujdmHS2kwAiw/01n2WMXNfqOqAG8uLkuN6FGPfJSk9TC2741IAmxLWdH8tYHkVITqkQh
	zzORIAJwlwUdbKVhhfuGlZi+8CsZVNlP/Z7TDfxe1pU9zkntgBfLUdXW6oTUJUuzvrUzuAyPV
	7/y9BLfB5Z8HzRcy8emaiKlzymellJHxT3To1BNmyL0zdWPzkxrCu7Yb1htvQqiYMDEy9Y2tf
	Z/pg+JDnuK2kMN8/jR+Ikv7H547eaRgQ1As9mU36R0A4XRGVdGxyGs0y5yjyWNZKpOgzpO+BG
	pYlMYtHNyYodsqAP2YilSN3u2cLQrqcJcwvr0fq48=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
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
	qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yil10c0523foGA5vRGKiX6fSx1iOpydXj
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>,
 Kamil Rytarowski <kamil@netbsd.org>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <139756cd-3df0-43a6-770a-5a1273e667d5@gmx.com>
Subject: Re: [Qemu-devel] Update *BSD images with gnu-sed and bash
References: <20190424103747.10173-1-thuth@redhat.com>
 <20190424103747.10173-5-thuth@redhat.com>
 <f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
 <0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
 <13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
 <c6080cb1-b48f-028f-e774-ca0e7b94369d@redhat.com>
 <d24f9f08-4feb-1372-844e-ff58e0d2dce4@gmx.com>
 <d65f9f6e-6761-6882-3be7-c9c65c68de3b@redhat.com>
In-Reply-To: <d65f9f6e-6761-6882-3be7-c9c65c68de3b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2019 10:07, Thomas Huth wrote:
> On 08/05/2019 09.06, Kamil Rytarowski wrote:
>> On 06.05.2019 12:12, Thomas Huth wrote:
> [...]
>>>  Kamil,
>>>
>>> could you maybe help with the NetBSD image and the tests/vm/netbsd sc=
ript?
>>>
>>
>> Please be more specific what am I expected to do.
>=20
> We have some VMs (including NetBSD) available that are used during
> Peter's regression tests when somebody sends him a PULL requests. You
> can run them also locally with:
>=20
>  make BUILD_TARGET=3Dcheck vm-build-netbsd
>=20
> From time to time, we've got to update these images, either to a newer
> version or to add some missing packages (like bash and gnu-sed in this
> case).

The process has been documented on wiki.

https://wiki.qemu.org/Hosts/BSD#NetBSD

> However, many people (including me) don't have a clue about the various=

> *BSD flavours, so also no clue about how to update these images easily.=

> That's why I was hoping you could help here.
>=20
> But looks like Gerd is already working on a way to generate these image=
s
> in a more automated way, so let's hope that he'll find some spare time
> to finish that work soon.
>=20

I recommend to upgrade to 8.0.

One extra step is to disable PaX MPROTECT (tcg violates W^X):

This should be addressed in qemu with an extension flag to
mmap(2)/mremap(2). I still have this on my TODO list.

sysctl -w security.pax.mprotect.enabled=3D1

NetBSD 9.0 will be released sooner than later and soon after that
NetBSD-7.x will be EOL.

>  Thomas
>=20



--Yil10c0523foGA5vRGKiX6fSx1iOpydXj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzTLFYMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsa2MP/A7DwvME0D7EAW7ULRKhruhb53yhQLo5JFnsiTia
kT43fiuVHaqL0d5cp7/NIMQaE6WOHURzTWnB6O9MdXSYck6bqEM5kODj6z/nFQ5q
bYRd3bQgZGzkYF86wCN/sKudFdZK2cuTLE+gbTw72rLDKl/Y/9AsOPAkvgiVrdRQ
HyA3M6A7lNm47NryMrhGmREN1ZuKDnm5LVEK8e1kdoJsWDOkapezs8KrRMxd+PD6
36zGd3mW+S8tJggfQDM9w0jcBcBmKYpP5dh74OVfJOT5rIFxQWNTd4oOrbqTdFKm
G9iIC8eN95he3Ig9GBeev8Lm0OX9K+26bxYLhcSPjPz+lIml7qPCpVGv0gZ3McHY
IeITtQKNKzMWFOSXcCNxKFlemFplqI4OhUY7eAPGxqb87lDvzeYk6ncu/sm/6+Ur
Ok5SBuSXNmx5PiLNY5cPu38K+aLk+Ansjo8bdwdPPuYqbOZW1q1OyuGXGSswErNr
7Nw7BfpFLlPAZqVSZQicIzvGVUvHl+WDXgYpLwkYWCVNI1qLCZVZ3qxu4beelriI
8ERJALwuE7TYr7LeV4YzJP5xynWIm6pfJNdkqs6acWu0b+6Grio4ODfWx6V8sY8j
UpptzXUhfwGge2ptsPKYY14Qdp+acWDUL7rd95hy3pAfbix+UBKs29Gwdp36C47/
1H5y
=KKJv
-----END PGP SIGNATURE-----

--Yil10c0523foGA5vRGKiX6fSx1iOpydXj--

