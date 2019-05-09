Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC692C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF6221019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G4LOoSY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF6221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58371 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmkM-0001cc-Px
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:22:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50553)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hOmQP-00017M-9q
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hOmQN-0006Bx-QM
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:01:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:51215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1hOmQM-00069r-S6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1557421256;
	bh=UaaR2XHEjAgofrU4SY9cqTiNUO3OlUB+Zp8FArS3luU=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=G4LOoSY4xdSStLGPAIOAq2secxPQGPDmyQwjKH8FRzv4V+/wp1r7hgu+ECOzNr3+c
	03xgDfFJHOWShnSKK0FY4j8KX0Sx2rdRJkkngY9s0sA+g8bkX9NMh0t6WRavYrisaK
	ROEfq5fTcArrG+HMFISAXnHLtlCUqsZX7zCKsjdI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx102
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0Ldbqw-1gz6a20hve-00ikmn;
	Thu, 09 May 2019 19:00:56 +0200
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-12-kraxel@redhat.com>
	<461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
	<20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
	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
	4XSbcg==
Message-ID: <411bde53-b574-97a9-edf6-4516a88ae00a@gmx.com>
Date: Thu, 9 May 2019 19:01:39 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Cj71KibBLvEEalKQuIAIY8sg6m9CI5kR"
X-Provags-ID: V03:K1:tzNFe+KqnUYadl6MuJfwHPlSOFZTLYccM6/ec9fSs2Oh6ejgsvd
	iD8ag/CVtCUToX7UbEtcHSQTXXzAMYub34lqjP8YFMtrxpxImCNEMgpkwbH8F1cjhkODVuk
	kVkCPxuZAQL57MyzgiJszCsFqHoW7sJ2k4QDqqa89bNxkCZBrPkCaZP+2Naib0wI35IMpjm
	EQ+4zlc5Xd1rJC++SDr2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r8uBXtrg8b4=:LJ/6OWp+Wdx02DZKUB4sID
	rND4nJiu7LydbPuO2L2Nhb8JZaMn2eexAl0FKedUexbZjVk9apGkYxi7ImirE1ylw3vhym1XI
	19XvUk3rAQZHIvylfaU3oAkwjzRK7E6ca45JcQOYQjKKYgYHqJQlf1mNwM6teguHjiifeM76w
	GoAluBOoxQnCcajvHsTnNEMPBuSrS4zUTL7XxUz8UcMBNyOsRerdKHWRD1MaCdGkrLwQWb4WV
	ZWOTnyQYh1uzGpiirg9ZtC9tArvEF0LcKbtK1mTXC6JbOtdHqhQKHmbEGgnNMS9Y7Z1IrOSW2
	hBA0nh3mr6eEptiH+VeMQKXYoG5KDDuZPtzLlBc9697sK/TBnve81e4NRIKBSkINk8pK70+xR
	WsQ9yE1FA6rm+6/nN6BqCoM+FwN2r6aYl9bO5GUrOcMSriXWXlXVNhyjBZuYOynQFQM17GyBo
	n8aezKCy+UZf14mRNC5gEaQ8IYIFSvrXVPGkG5UipaFDBN3H9ukBP0bloPibQAWH1b6aSUw01
	0nwQ1fVRRvUj7Vce5KkCj3w1JvHNLv22WsD0hq3fmQ0nh3zWMvHCyIX1G+ogKsF5KRAdgclB5
	d2qo92PGdR28h5Qv4GpZaGi+m5k5OWtjq/uT21U0pVzs6LR/0xMfUBFYSg/iGhr2Vk/a/FGNQ
	pEi5rVtd+K+0RI9K0/wAfQoz8SPZFI8whbciVg4fhWLZqxS4HXEzHrZQmK6huvjq3Pl4c7uKJ
	/dpsK+/SfsJuwBGGCz5sjodgk9RJDG41FZEfj2VBhaC29asQAnV4fcPOHBjm8iiGzOEsaNtle
	y/hM8x0aDWtRtcJn7sp6SZ3CNiz2feIB4fD+zEgjkj1h+4mP7nclSrhgws4x4oOE3eOq3+f2t
	1yMde81KxYvU9h0+cCHD4lKzde/tnEJ+UJzeWkjyo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Cj71KibBLvEEalKQuIAIY8sg6m9CI5kR
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Message-ID: <411bde53-b574-97a9-edf6-4516a88ae00a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall, using
 serial console
References: <20190508085645.11595-1-kraxel@redhat.com>
 <20190508085645.11595-12-kraxel@redhat.com>
 <461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
 <20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
In-Reply-To: <20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.05.2019 08:47, Gerd Hoffmann wrote:
>   Hi,
>=20
>> I recommend to add one extra step into generated image:
>>
>> echo security.pax.mprotect.enabled=3D0 >> /etc/sysctl.conf
>=20
> Done.
>=20

Thanks! Once there will be PaX MPROTECT support in qemu, we can and
should drop it.

>> Alternatively (and preferably) enhance qemu to handle RWX allocation f=
or
>> JIT on NetBSD.
>>
>> Example in libffi.
>>
>> https://github.com/libffi/libffi/commit/2bfcd29955c02b67fa10a68cc4200f=
6838181e0f
>=20
> So, from looking at the patch it seems you need two mappings of the sam=
e
> page, one writable and one executable.
> > Or, maybe it is also possible with one mapping which is writable firs=
t
> when you fill it with code, then gets flipped over to executable when
> you are done with the initialization and want use it.
>=20
> Is that correct?
>=20

If we need RWX in the same time we need double mapping (RW and RX). This
has been done in libffi.

If we can switch between RW and RX it's sufficient to use a single
mapping, however there is need to allocate a memory region with mmap(2)
using the PROT_MPROTECT() macro.

Example from the LLVM code:

https://github.com/llvm-mirror/llvm/blob/90dd07f5c5946a3d9d6861effe329162=
0c88c06f/lib/Support/Unix/Memory.inc#L99

> I suspect supporting that in tcg isn't exactly trivial.
> Does OpenBSD work the same way btw?
>=20

No. OpenBSD does not implement escape API.

There is need to pass "-z wxneeded" to the linker flags, but I'm not the
right person to test this or write a patch.

https://man.openbsd.org/ld

FreeBSD does not support W^X.

> cheers,
>   Gerd
>=20



--5Cj71KibBLvEEalKQuIAIY8sg6m9CI5kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzUXPoACgkQS7MI6bAu
dmxethAArf0pz191LeK7D7L2UNeLPZjyFch3mVIgymcrZcoHf4r1mvz01jI4T7Bv
Ynf5FaJcneZ5PaYqjTUouRvZlYNiTSmWYo+iE43Mg/zCBbeWoKkuCLq1GKEMM53H
/zH3N2gfyU0x4sQZFrh/+AFfjolIWZbTA4Y+6Q7PyWdN5v+F0ZsNtxDln/16he6d
W6GvKO1m7juJYzjPIgmtC0m3+VdoO5qiZ/zSpiD4u6K1ZpM41toPiLESmD1qQxgp
ws3b/aSlw8pZbM5K9VSdVjF4MWPCAwCzsy7XbGtMQZScKPAc7lNslInsgzlZMYfU
pCYU/c6VdlExaENngb7sp08D1DqGp4KeC4Tvg2m9IawCOL1vBzXrqk8B8s80icfa
GeDE6zz7GMMm5ZfuMcGcBaWjxnvJS2deoQpoyvDJx3deKNdA4EmrFiyRezlxqYPn
kjqZKqBLIXUUdZhS2ywWqHjDpCDTv/odDbrhtCslNIS1qvcQVaH7mH1cR7L52VSv
r5KA+vOZzGoho0CC9dORK4C6J770KlgnTGNe0Bxdziq+2xy4Qazdzph9mCUBFCAp
AYQ8EQEiORyPfH6hk5zZouggxZbCLiBNMNz+4zCSK8BZuIynbgpKBgE51LkGSiMO
BDVQ5fN1H4YWg8W4dhG37j9C6ghMvY8B0+yY74AVvGLTKh54dao=
=JxNF
-----END PGP SIGNATURE-----

--5Cj71KibBLvEEalKQuIAIY8sg6m9CI5kR--

