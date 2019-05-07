Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72D0C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3DE2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3DE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49724 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO32r-00085K-EB
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:34:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO31V-0007Sj-SY
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO31U-0007WX-Cb
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hO31T-0007TV-4E
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A2FD8DA32
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 16:32:52 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46717608CA;
	Tue,  7 May 2019 16:32:51 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
	<20190430150556.GA2423@redhat.com>
	<87sgtqejn9.fsf@dusky.pond.sub.org>
	<20190507093954.GG27205@redhat.com>
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
Message-ID: <f30e9f99-5d9a-5d78-754e-a2acaa799edc@redhat.com>
Date: Tue, 7 May 2019 11:32:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507093954.GG27205@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UQKcByfhHcueS163WN5LX93pMGgq6jaIz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 16:32:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints;
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
--UQKcByfhHcueS163WN5LX93pMGgq6jaIz
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f30e9f99-5d9a-5d78-754e-a2acaa799edc@redhat.com>
Subject: Re: [Qemu-devel] QMP; unsigned 64-bit ints; JSON standards compliance
References: <20190430131919.GN6818@redhat.com> <20190430144546.GA3065@work-vm>
 <20190430150556.GA2423@redhat.com> <87sgtqejn9.fsf@dusky.pond.sub.org>
 <20190507093954.GG27205@redhat.com>
In-Reply-To: <20190507093954.GG27205@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/7/19 4:39 AM, Daniel P. Berrang=C3=A9 wrote:

>> JSON is terrible at interoperability, so good luck with that.
>>
>> If you reduce your order to "the commonly used JSON libraries we know"=
,
>> we can talk.
>=20
> I don't particularly want us to rely on semantics of small known set
> of JSON libs. I really do want us to do something that is capable of
> working with any JSON impl that exists in any programming language.
>=20
> My suggested option 2 & 3 at least would manage that I believe, as
> any credible JSON impl will be able to represent 32-bit integers
> or strings without loosing data.
>=20
> Option 1 would not cope as some impls can't even cope with
> signed 64-bit ints.
>=20
>>>>> I can think of some options:
>>>>>
>>>>>   1. Encode unsigned 64-bit integers as signed 64-bit integers.
>>>>>
>>>>>      This follows the example that most C libraries map JSON ints
>>>>>      to 'long long int'. This is still relying on undefined
>>>>>      behaviour as apps don't need to support > 2^53-1.
>>>>>
>>>>>      Apps would need to cast back to 'unsigned long long' for
>>>>>      those QMP fields they know are supposed to be unsigned.
>>
>> Ugly.  It's also what we did until v2.10, August 2017.  QMP's input
>> direction still does it, for backward compatibility.

Having qemu accept signed ints in place of large unsigned values is easy
enough. But you are right that it loses precision when doubles are
involved on the receiving end, and we cross the 2^53 barrier.

>>
>>>>>
>>>>>
>>>>>   2. Encode all 64-bit integers as a pair of 32-bit integers.
>>>>>    =20
>>>>>      This is fully compliant with the JSON spec as each half
>>>>>      is fully within the declared limits. App has to split or
>>>>>      assemble the 2 pieces from/to a signed/unsigned 64-bit
>>>>>      int as needed.
>>
>> Differently ugly.

Particularly ugly as we turn 1<<55 from:

"value":36028797018963968

into

"value":[8388608,0]

and now both qemu and the client end have to agree that an array of two
integers is a valid replacement for any larger 64-bit quantity
(presumably, we'd always accept the array form even for small integer
values, but only produce the array form for large values).  And while it
manages just fine for uint64_t values, what rules would you place on
int64_t values? That the resulting 2-integer array is combined with the
first number as a 2's-complement signed value, and the second being a
32-bit unsigned value?

>>
>>>>>
>>>>>
>>>>>   3. Encode all 64-bit integers as strings
>>>>>
>>>>>      The application has todo all parsing/formatting client
>>>>>      side.
>>
>> Yet another ugly.

But less so than option 2.

"value":36028797018963968

vs.

"value":"36028797018963968"

is at least tolerable.

>>
>>>>>
>>>>>
>>>>> None of these changes are backwards compatible, so I doubt we could=
 make
>>>>> the change transparently in QMP.  Instead we would have to have a
>>>>> QMP greeting message capability where the client can request enable=
ment
>>>>> of the enhanced integer handling.
>>
>> We might be able to do option 1 without capability negotiation.  v2.10=
's
>> change from option 1 to what we have now produced zero complaints.
>>
>> On the other hand, we made that change for a reason, so we may want a
>> "send large integers as negative integers" capability regardless.
>>
>>>>>
>>>>> Any of the three options above would likely work for libvirt, but I=

>>>>> would have a slight preference for either 2 or 3, so that we become=

>>>>> 100% standards compliant.

If we're going to negotiate something, I'd lean towards option 3
(anywhere the introspection states that we accept 'int64' or similar, it
is also appropriate to send a string value in its place). We'd also have
to decide if we want to allow "0xabcd", or strictly insist on 43981,
when stringizing an integer.  And while qemu should accept a string or a
number on input, we'd still have to decide/document whether it's
response to the client capability negotiation is to output a string
always, or only for values larger than the 2^53 threshold.

>>
>> There's no such thing.  You mean "we maximize interoperability with
>> common implementations of JSON".
>=20
> s/common/any/
>=20
>> Let's talk implementation for a bit.
>>
>> Encoding and decoding integers in funny ways should be fairly easy in
>> the QObject visitors.  The generated QMP marshallers all use them.
>> Trouble is a few commands still bypass the generated marshallers, and
>> mess with the QObject themselves:
>>
>> * query-qmp-schema: minor hack explained in qmp_query_qmp_schema()'s
>>   comment.  Should be harmless.
>>
>> * netdev_add: not QAPIfied.  Eric's patches to QAPIfy it got stuck
>>   because they reject some abuses like passing numbers and bools as
>>   strings.
>>
>> * device_add: not QAPIfied.  We're not sure QAPIfication is feasible.
>>
>> netdev_add and device_add both use qemu_opts_from_qdict().  Perhaps we=

>> could hack that to mirror what the QObject visitor do.
>>
>> Else, we might have to do it in the JSON parser.  Should be possible,
>> but I'd rather not.
>>
>>>> My preference would be 3 with the strings defined as being
>>>> %x lower case hex formated with a 0x prefix and no longer than 18 ch=
aracters
>>>> ("0x" + 16 nybbles). Zero padding allowed but not required.
>>>> It's readable and unambiguous when dealing with addresses; I don't w=
ant
>>>> to have to start decoding (2) by hand when debugging.
>>>
>>> Yep, that's a good point about readability.
>>
>> QMP sending all integers in decimal is inconvenient for some values,
>> such as addresses.  QMP sending all (large) integers in hexadecimal
>> would be inconvenient for other values.
>>
>> Let's keep it simple & stupid.  If you want sophistication, JSON is th=
e
>> wrong choice.

JSON requires decimal-only, but I'm okay if we state that when
negotiating the alternative representation, that we output hex-only.
(JSON5 adds hex support among other things, but it is not an RFC
standard, and even fewer libraries exist that parse JSON5 in addition to
straight JSON).

>>
>>
>> Option 1 feels simplest.
>=20
> But will still fail with any JSON impl that uses double precision float=
ing
> point for integers as it will loose precision.
>=20
>> Option 2 feels ugliest.  Less simple, more interoperable than option 1=
=2E
>=20
> If we assume any JSON impl can do 32-bit integers without loss of
> precision, then I think we can say it is guaranteed portable, but
> it is certainly horrible / ugly.
>=20
>> Option 3 is like option 2, just not quite as ugly.
>=20
> I think option 3 can be guaranteed to be loss-less with /any/ JSON impl=

> that exists, since you're delegating all string -> int conversion to
> the application code taking the JSON parser/formatter out of the equati=
on.
>=20
> This is close to the approach libvirt takes with YAJL parser today. YAJ=
L
> parses as a int64 and we then ignore its result, and re-parse the strin=
g
> again in libvirt as uint64. When generating json we format as uint64
> in libvirt and ignore YAJLs formatting for int64.
>=20
>> Can we agree to eliminate option 2 from the race?
>=20
> I'm fine with eliminating option 2.

Same here.

>=20
> I guess I'd have a preference for option 3 given that it has better
> interoperability

Likewise - if we're going to bother with a capability that changes
output and allows the input validators to accept more forms, I'd prefer
a string form with correct sign over a negative integer that depends on
64-bit 2's-complement arithmetic to intepret correctly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--UQKcByfhHcueS163WN5LX93pMGgq6jaIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzRszEACgkQp6FrSiUn
Q2rXcgf+LyzkAtI/D32wZZiSiVGy3KUDXDwxJLh4Ci1WdvNpWTQ1bgWqqE2tE8Xz
oBCHD/OyIt5DYU6Lpn+d39fFwG7iPz/e2fl+m/mP06b5KHSpn/IRS+xp6qA46t2S
kPmQ+aZBqEscCjOjOESGwgrVDHcqHwId9HWHBFf5aICubBuXPmzCX4v0tE5g6rqR
+Q7Vru2fhTyP+oYNYD/RzB7hoFf63iZg+aoZOt+5xxr0GoewHhYzm8skzjgA/q3B
/C0vCvLNDpga+6V0ZMf0rvIsr/OEc3SNNFWuzgF+xX7rFBhCXwtseae4hqlXNLBl
HK78wyTe3LvPFKpITOLjdz0Hqhy13A==
=YqMo
-----END PGP SIGNATURE-----

--UQKcByfhHcueS163WN5LX93pMGgq6jaIz--

