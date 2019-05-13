Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E2C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B945A2084F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B945A2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQCz5-0006gV-WB
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:35:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQCuv-0003oo-Rn
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQCg4-0003LM-65
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hQCg3-0003IG-SY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67108C057E37
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 15:15:42 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A1975D720;
	Mon, 13 May 2019 15:15:38 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com> <875zql3ylk.fsf@dusky.pond.sub.org>
	<20190513120856.GH15029@redhat.com> <87ef525uls.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <a3378e24-f13f-b51f-7180-8e0bf4661e10@redhat.com>
Date: Mon, 13 May 2019 10:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ef525uls.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ku0DiIj6AIe5ahLp0cG5PKBOTOjPtHXDS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 13 May 2019 15:15:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [libvirt]  QMP; unsigned 64-bit ints;
 JSON standards compliance
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
Cc: libvir-list@redhat.com, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ku0DiIj6AIe5ahLp0cG5PKBOTOjPtHXDS
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a3378e24-f13f-b51f-7180-8e0bf4661e10@redhat.com>
Subject: Re: [libvirt] [Qemu-devel] QMP; unsigned 64-bit ints; JSON standards
 compliance
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
 <20190430150556.GA2423@redhat.com> <87sgtqejn9.fsf@dusky.pond.sub.org>
 <20190507093954.GG27205@redhat.com> <875zql3ylk.fsf@dusky.pond.sub.org>
 <20190513120856.GH15029@redhat.com> <87ef525uls.fsf@dusky.pond.sub.org>
In-Reply-To: <87ef525uls.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/13/19 8:53 AM, Markus Armbruster wrote:

>> We have a few options
>>
>>  1. Use string format for values > 2^53-1, int format below that
>>  2. Use string format for all fields which are 64-bit ints whether
>>     signed or unsigned
>>  3. Use string format for all fields which are integers, even 32-bit
>>     ones
>>
>> I would probably suggest option 2. It would make the QEMU impl quite
>> easy IIUC, we we'd just change the QAPI visitor's impl for the int64
>> and uint64 fields to use string format (when the right capability is
>> negotiated by QMP).
>>
>> I include 3 only for completeness - I don't think there's a hugely
>> compelling reason to mess with 32-bit ints.
>=20
> Agree.

Other than if we ever change the type of a QMP integer. Right now, if we
widen from 'int32' to 'int' (aka 'int64'), it is invisible to clients;
but once we start stringizing 64-bit numbers (at client request) but NOT
32-bit numbers, then changing a type from 32 to 64 bits (or the
converse) becomes an API change to clients. Introspection will at least
let a client know which form to expect, but it does mean we have to be
more aware of typing issues going forward.

>=20
>> Option 1 is the bare minimum needed to ensure precision, but to me
>> it feels a bit dirty to say a given field will have different encoding=

>> depending on the value. If apps need to deal with string encoding, the=
y
>> might as well just use it for all values in a given field.
>=20
> I guess that depends on what this interoperability capability does for
> QMP *input*.

"Be liberal in what you accept, strict in what you produce" - that
argues we should accept both forms on input (it's easy enough to ALWAYS
permit a string in place of an integer, and to take an in-range integer
even when we would in turn output it as a string).

>=20
> For *output*, QEMU has to encode a number either as JSON number or as
> JSON string

For output, we should document that whatever capability the client
passes in at initial connect controls the behavior of all future integer
outputs (and if no capability is negotiated, we output all integers as
integers, even if it risks overflowing the client's JSON parser).

>=20
> For *input*, QEMU could accept either.  Or it could accept only the
> encoding it produces on output.
>=20
> Got a preference?
>=20

My ramblings above argue to teach the parser to always allow both
integer and string forms regardless of width, to output 32-bit integers
as integers, and to output 64-bit integers as string-only (if capability
is negotiated) or as integer-only (if in back-compat mode).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ku0DiIj6AIe5ahLp0cG5PKBOTOjPtHXDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzZihkACgkQp6FrSiUn
Q2ru4Qf/ZlJzSLs7XDQqiubaWvDAvCXCpXfQt3FRuM/8flj+CvtMHgZgOJ1LndC7
+mCAmV1y9gSdPDFHn2OBSV6XlylZu9QlbHgfh+TXHZnDNmgZRGnyv1m2AqUKDdTN
2uu10i77gDJHG+GtwH2Wf/WPOu212++DbycyE2iFmeImrzDUWgsp9yj/KNsUS4JE
RL7E2RGIrX29iSHRUBSpUMjQssM3MQIBvJzK22O/EMD2rD0EIhccIn929gBdat+i
YjRRU/KTs0iKCGKDG7WEPs8FZotqfzQBRauGEwFsrazlr/7ZFm3H8Kg8GIjaVGnv
4kOzyHNdkj69cKI4AB3U60zqrCisdQ==
=F2mw
-----END PGP SIGNATURE-----

--ku0DiIj6AIe5ahLp0cG5PKBOTOjPtHXDS--

