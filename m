Received: from eggs.gnu.org ([2001:4830:134:3::10]:37221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d35sJ-0004D2-Fz
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d35sI-0006CG-Cq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:11:47 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<1492957997-28587-2-git-send-email-lidongchen@tencent.com>
	<7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
	<7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
	<f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
	<1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4d38eb43-f61d-106a-ffd4-d4f0c76df71d@redhat.com>
Date: Tue, 25 Apr 2017 21:11:34 +0200
MIME-Version: 1.0
In-Reply-To: <1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="81HctBqA6wHRLOhoGllhmL36epaBA8j7J"
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, jemmy858585@gmail.com, Lidong Chen <lidongchen@tencent.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--81HctBqA6wHRLOhoGllhmL36epaBA8j7J
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, jemmy858585@gmail.com,
 Lidong Chen <lidongchen@tencent.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <4d38eb43-f61d-106a-ffd4-d4f0c76df71d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
 <1492957997-28587-2-git-send-email-lidongchen@tencent.com>
 <7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
 <7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
 <f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
 <1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
In-Reply-To: <1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.04.2017 17:53, Eric Blake wrote:
> On 04/24/2017 10:47 AM, Eric Blake wrote:
>> On 04/24/2017 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>>>>>  /*
>>>>> - * Returns true iff the first sector pointed to by 'buf' contains =
at
>>>>> least
>>>>> - * a non-NUL byte.
>>>>> + * Returns true if the first sector pointed to by 'buf' contains a=
t
>>>>> least
>>>>> + * a non-NULL byte.
>>>>
>>>> NACK to both changes.  'iff' is an English word that is shorthand fo=
r
>>>> "if and only if".  "NUL" means the one-byte character, while "NULL"
>>>> means the 8-byte (or 4-byte, on 32-bit platform) pointer value.
>>>
>>> I agree with Lidong shorthands are not obvious from non-native speake=
r.
>>>
>>> What about this?
>>>
>>>  * Returns true if (and only if) the first sector pointed to by 'buf'=

>>> contains
>>
>> That might be okay.

Might, yes, but we have it all over the code. I'm not particularly avid
to change this, because I am in fact one of the culprits (and I'm a
non-native speaker, but I do like to use LaTeX so I know my \iff).

(By the way, judging from the author's name of this line of code (which
is Thiemo Seufer), I'd wager he's not a native speaker either.)

>>>  * at least a non-null character.
>>
>> But that still doesn't make sense.  The character name is NUL, and
>> non-NULL refers to something that is a pointer, not a character.
>=20
> What's more, the NUL character can actually occupy more than one byte
> (think UTF-16, where it is the two-byte 0 value).  Referring to NUL byt=
e
> rather than NUL character (or even the 'zero byte') makes it obvious
> that this function is NOT encoding-sensitive, and doesn't start
> mis-behaving just because the data picks a multi-byte character encodin=
g.

Furthermore, this doesn't have anything to do with being a native
speaker or not: NUL is just the commonly used and probably standardized
abbreviation of a certain ASCII character (in any language). It's OK not
to know this, but I don't think it's OK to change the comment.

Max


--81HctBqA6wHRLOhoGllhmL36epaBA8j7J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj/n2YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AY28IAMO2eOa4FvrRrUG8onpcaQylB8z1+Qz6
CDz74pJC2cmJZe5t8jl7TPeAtMLg1J9j+NymPKFpRVGPc4JkLZz4aeJkB+JONdjK
H9IlkKICWgsLK8e7c6nJnbX5mr3YrkRwzsiG6nteat574/TFo9EtSz99xQHxsPj7
DZFEVHg3YGKVuRGFwfoje7DGF9MB7DqsKf4t2I2Y4n4xp3lAAPFQQSugwrqvvozF
VxmsFEMMbKmmqFeR4SoWk1vuoLjsf9QfvuAVfZazSwfHFWYll7JwVEIGoLSMqyjF
0OoTntYNjaAhnMruvCx8yKOFJGVakpTULeSZfRA4J90+inJCMatcHhQ=
=UAeJ
-----END PGP SIGNATURE-----

--81HctBqA6wHRLOhoGllhmL36epaBA8j7J--
