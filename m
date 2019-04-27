Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E23C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 18:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF662206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="apXjUghC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF662206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKRif-0001qN-0D
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 14:06:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48635)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hKRhE-0000x3-AG
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1hKRhD-0003oo-91
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:05:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:52079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1hKRhB-0003iH-6i; Sat, 27 Apr 2019 14:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1556388299;
	bh=jY88WQasQiPnj0WAm8vlInHUNvBM17XiJDolgz3lzUA=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=apXjUghCKcjdPbGK0Yd9Y9YHnx/YYONBiWYy+WUQ1U1Z6iWLg8m3U1vSWA5j2utkU
	3iN7kpifTj0qMV9j/owkIzYlYou0xtC8xtsu0FVaMOW6HB9sBp8gFboWsXf60Z3JtT
	kUsksViv/dwLuFt6e2f1Vh7qDwkcGujtGFpN1WSU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx003
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0Ma1Mt-1h4pwy0zgl-00Lkg0;
	Sat, 27 Apr 2019 20:04:59 +0200
To: Samuel Thibault <samuel.thibault@gnu.org>
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
	<20190427163007.5113-3-samuel.thibault@ens-lyon.org>
	<73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
	<20190427175708.76nq4w2mdexb4gkp@function>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <331bee21-743c-5eb8-9c6d-77a23b2dc607@gmx.com>
Date: Sat, 27 Apr 2019 20:05:32 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190427175708.76nq4w2mdexb4gkp@function>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb"
X-Provags-ID: V03:K1:CF8xvBWokTWujylVlNCGcNGTxJQc9NdY0c0SBd+QiMOgNLs2dmB
	4sE919UzPz1AQLxbtdn+JCipeJIDTZ6kgpyEp8F4vtCbRagW00SiPyKv7jcd5D5GZdLjf+w
	QgTYEGlzkDiN9ucASCNIN9LPgIhMR47bRnQtOk+qb3XKq2woaORz+73ihxYOoAzi9o3Ab3r
	WoUxboAXhobzXEqzXUZhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:84yRF+cmKZ4=:dxdIX1pqSNvHDtbq/iJgiO
	cOTVV0sjBak+PAtLya9stSfaYTf/VfCmgbgP4lNO2AUItgcTSGFJsaENMd9eZcrgfagd9dcNF
	AIhAdQpF0G/na8d3vgH0GL0QgyGFwi1J+zuh2ZDRJwxYHTl/XhnRhgNVGoYwF24RkfhkisSK1
	Pr+btZou/qZnvhjcOdS/RoM18PVv3k/soW08a2EozzzRraMn3dtAQJJs8x3c+Ix6zJ9E0koWm
	e0H4fXFE8U7bvkQBb9qLz2pdMrvENp2ydTYn2rVq2E/L0NWwG02EaqAhwLQaLPvXcmbDxnZZK
	OtT0voB8M0cFj1dYPi04iX7R+AAukyfvewgbI7zM86YfbV3XjDikGc/hy1/vXDzUgeALdL4a/
	SfRYCC3PJX1pjcHiqvNP8bATQnfvS5za+smpwgvkIiVoPu+PfPRwEww0H01P7Mu60M7kRp6C7
	4RJWyCbmOo5y97Z2I033lAMHeaE7XCfLHd5HImhrxLo2EyDNBMY8aRP2OKgd1aHe7U++K+2HT
	Rreg3N9xGurGWrWAScF1Vq/sezLCZdqT/I1Jow0kOBnfB1PWh0y03jgiOpKNc0YDTvAYUosIb
	8QS+YobPl70BzjrKyZShx/qk2jX6LOPZ0fEqWm2xt1LW1kgYU7usFiOCpg4yVPtokbHwpY1ys
	XGcBXNHlOhnuZfDL+xXHta4UotuejPlvz3tVJPK+dqTKDTkr+05nT4GiGwSiTvBqSy13vBUu4
	wndOhZrFCIjrRO+qcdyRkM0hXfrM6SqH1UBAwLQBUaPlE6CUuHc/C2Wi/dMHywJwTqwVwTtzQ
	I6usCoC6ffxyjnwd8URjJ8kPB9uXMl1yWUoD3yN5Iax+o0ZFCN86mWBgbK6Pgvn3gvM9c9cqP
	Ag7CZSrbtK49uTOaychFoTzu62v652DGTSifcCqZU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
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
Cc: kamil@netbsd.org, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427180532.qZqmx_24adqTFjG8fAcBZRZfC4Lbq_PlPLGFkW98Rsk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb
From: Kamil Rytarowski <n54@gmx.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: kamil@netbsd.org, qemu-devel@nongnu.org, kraxel@redhat.com
Message-ID: <331bee21-743c-5eb8-9c6d-77a23b2dc607@gmx.com>
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
 <20190427163007.5113-3-samuel.thibault@ens-lyon.org>
 <73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
 <20190427175708.76nq4w2mdexb4gkp@function>
In-Reply-To: <20190427175708.76nq4w2mdexb4gkp@function>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2019 19:57, Samuel Thibault wrote:
> Kamil Rytarowski, le sam. 27 avril 2019 19:36:40 +0200, a ecrit:
>> On 27.04.2019 18:30, Samuel Thibault wrote:
>>> E.g. BSD and Solaris even use locale-specific encoding there.
>>>
>>> We thus have to go through the native multibyte representation and us=
e
>>> mbtowc/wctomb to make a proper conversion.
>>>
>>> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>
>> Both patches work for me on NetBSD/amd64 8.99.37 for qemu-system-x86_6=
4.
>> Borders are printed correctly.
>>
>> Regarding the patch I'm not sure whether to use MB_LEN_MAX or MB_CUR_M=
AX?
>=20
> I don't know if qemu can afford VLA?
>=20

It's better to avoid VLA and pick MB_LEN_MAX.

>> I'm also unsure whether to reset conversion state between a multibyte
>> character and wide character, with: `mbtowc(NULL, 0, 0);`. It's
>> recommended to use in code examples examples. I think it doesn't make
>> any harm to use it.
>=20
> Mmm, better yet, we should actually use mbrtowc and wcrtomb. I have
> fixed this in my tree.
>=20

This is even better.

>> I'm not sure if this is related, but "qemu-system-hppa -curses" is
>> broken for me. I didn't use it in the past as it just recently acquire=
d
>> NetBSD guest support.
>>
>> (lldb) bt
>> libcurses.so.7`mvwadd_wchnstr(win=3D0x0000000000000000, y=3D<unavailab=
le>,
>> x=3D<unavailable>, wchstr=3D0x00007f7fffffe020, n=3D0) at add_wchstr.c=
:123
>>   * frame #2: 0x000000000078629e
>> qemu-system-hppa`curses_update(dcl=3D0x00007f7ff7bd8bc0, x=3D0, y=3D0,=
 w=3D79,
>> h=3D24) at curses.c:86:9
>>     frame #3: 0x0000000000753dae
>> qemu-system-hppa`dpy_text_update(con=3D0x00007f7ff7bae580, x=3D0, y=3D=
0, w=3D79,
>=20
>> (lldb) p screenpad
>> (WINDOW *) $2 =3D 0x0000000000000000
>=20
> I don't think this is related at all, screenpad management is another
> matter.
>=20

OK! I will treat it as an independent issue and try to address it.

> Samuel
>=20



--4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlzEme0MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs/T0P/2Lasgx+NsnT1qP86Bh2fydL9xkFBnln7CxoERe6
QGTSsZpeAXmHsnrLO8N3fGMSg5lZ2XirFPImikYRFLLbEx/coj84hj+NEGP0mk8q
PArk+lTNVDkHtkHgvMr5ieBfk0CcI6yChP1Z8qPBhbuZlBONOSw2/idOSKLaa/q2
OS8eFzKupFyHFKZG3JziSAJU9ShFR7w82ENj3MKV8+SOB8iimdGriKqmL+Z8dktu
Sa+7a54KpgW7ZCJQwFsYn+ClfuoTi1qcTTnL06LIwhIvTDIQPPYtvlzNdlA9F/PF
oPCRcptXKcEwL+1TxnhC7rDP1ageFWouHWJX58FpRmX2FUBNLScAS7cebbU8nb71
0yZPw9Why18uZq8wbUqHQrPy72Eo/8PBz+j+8OhBMmny1kZp3ouLAK3z/Z/G1LQX
O4KxigY291pNlz0RxVxHm2GnogbdrYkRriMRYwNt7PVgjkkcHEePiQjHXl5dmVBI
Flh7Z674cNHDd/dDuWXmQM9LN4CqN+SH1jYk8lc34qPcjMAoIF2sJCSgfnD4Drnz
6Pc/KCj4IXIMd0liLkcjw2IGHyZVpp4f4+6Z3ugnhKUYWjELs75fZCqVNCR073kV
SV/jMS2cuqmjEO8XIe6hwGtVrQcc0YgFDEDo04CzuekzSJPgpp5xUFZCZKbJ+UrW
T65r
=7iq5
-----END PGP SIGNATURE-----

--4f07vlMXqZ0yimzlM1zmTIzaDzdSDtzOb--

