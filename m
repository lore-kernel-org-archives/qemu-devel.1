Received: from eggs.gnu.org ([2001:4830:134:3::10]:36045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dQx7c-0002XL-I0
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dQx7Z-0003Au-Dk
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:42:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34026
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dQx7Z-00039i-5r
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:42:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5UEdKK3079648
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 10:42:07 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bdr311gyh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 10:42:07 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 30 Jun 2017 15:42:04 +0100
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
	<20170607095127.GB2099@work-vm>
	<8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
	<f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
	<00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 30 Jun 2017 16:41:31 +0200
MIME-Version: 1.0
In-Reply-To: <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="baCoH4v81PUxO4qqCeOQJMrnnHJlFvoId"
Message-Id: <2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--baCoH4v81PUxO4qqCeOQJMrnnHJlFvoId
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Jason J . Herne" <jjherne@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Message-ID: <2791f136-d531-464c-8c44-7006ff7a658f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed equal
 checks
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
 <20170606165510.33057-2-pasic@linux.vnet.ibm.com>
 <20170607095127.GB2099@work-vm>
 <8c0f9dac-ceef-fe88-8147-3cf043f7e109@linux.vnet.ibm.com>
 <f8f8bc90-56df-9885-83cd-2283e38c5462@linux.vnet.ibm.com>
 <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
In-Reply-To: <00b260fd-14f6-d716-daab-7d0172be1c07@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/29/2017 09:04 PM, Eric Blake wrote:
> On 06/14/2017 08:51 AM, Halil Pasic wrote:
>=20
> [apologies for the delayed response, and also adding Markus]
>=20

No problem. Many thanks for the effort. I see I've ended up with a
lengthy email. A disclaimer before I start: No strong opinions here.
Things have been working reasonably well for years and I respect that.
Nevertheless I like conceptual clarity, and because of this, I ended up
doing discussion without considering the expected cost/benefit ration. If=

I think about it that way it probably ain't wort it. So I'm OK with
concluding the discussion with that argument at any time -- just tell ;).=



>>>
>>> One reason I choose error_report_err is to be consistent about hint
>>> reporting (the other one is that was what Connie suggested). I do
>>> not understand why do we omit hints if QMP, but I figured that's
>>> our policy. So the hint I'm adding must not be printed in QMP
>>> context -- because that's our policy. I was pretty sure what I
>>> want to do is add a hint (and not make a very long 'core' error
>>> message).
>>>
>>> Can you (or somebody else)  explain why are hints dropped in QMP
>>> context?
>>>
>>> Don't misunderstand I'm open towards your proposal, it's just
>>> that:
>>> 1) I would like to understand.
>>> 2) I would like to get the very same result as produced by
>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg01472.htm=
l=20
>>>
>>> Regards,
>>> Halil
>>>
>>>
>>
>> ping.
>>
>> I would like to do a v2, but I want this sorted out first.
>>
>> 'This' basically boils down to the question and
>> 'Why aren't hints reported in QMP context?'
>=20
> QMP is supposed to be machine-parseable.  Hints are supposed to be
> human-readable. If you have a machine managing the monitor, the hint
> adds nothing but bandwidth consumption, because machine should not be
> parsing the human portion of the error message in the first place (as i=
t
> is, libvirt already just logs the human-readable portion of a message,
> and bases its actions solely on the machine-stable portions of an error=

> reply: namely, whether an error was sent at all, and occasionally, what=

> error class was used for that error - there's no guarantee a human will=

> be reading the log, though).


Seems I've made wrong assumptions about error messages (in QEMU) up until=

now. If I understand you correctly, in QEMU error messages are part of
the API (but hints are not). Thus if one changes a typo in an error
message (like here
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06732.html) the
one is strictly speaking breaking API backward compatibility.  Is that
really the way we want to have things?

=46rom prior experiences I'm more used to think about error messages as
something meant for human consumption, and expressing things expected to
be relevant for some kind of client code in a different way (optimized
for machine consumption).

If however the error message ain't part of the machine relevant portion,
then the same argument applies as to the 'hint', and I don't see the
reason for handling hints differently. Do you agree with my
argumentation?

Let us also examine some comments in qapi/error.h:

/*
 * Just like error_setg(), except you get to specify the error class.
 * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
 * strongly discouraged.
 */
#define error_set(errp, err_class, fmt, ...)

This probably means client code (e.g. libvirt) is in general not meant
to make decision based on the type of the error that occurred (e.g. what
went wrong).

/*
[..]
 * human-readable error message is made from printf-style @fmt, ...
 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.
[..]
 */
#define error_setg(errp, fmt, ...)=20

=46rom this it seems to me error message is intended for human-consumptio=
n.

/*
 * Append a printf-style human-readable explanation to an existing error.=

 * @errp may be NULL, but not &error_fatal or &error_abort.
 * Trivially the case if you call it only after error_setg() or
 * error_propagate().
 * May be called multiple times.  The resulting hint should end with a
 * newline.
 */
void error_append_hint(Error **errp, const char *fmt, ...)

=46rom this, I would say: The 'hint' is about why something went wrong. T=
he
'message' is about what problem in particular or in general was
encountered (in general, the requested operation failed/can not be
performed; the caller knows what operation was attempted) and should be
considered debugging aid (along with the bits supposed to answer the
question 'where'). This debugging aid, however, can be very useful to the=

end user if seeking a workaround, and the error_class is for providing
client code with additional information beyond 'something went wrong'.

Whether the message is supposed to be only about 'in particular' is a
tricky one, and should probably depend on the contract: if the client
code is supposed tell us which high level operation failed then I guess
just 'in particular' is good, if however the client code is expected to
just log errors and proceed without providing any extra context then I
guess the message is both about 'in general' in particular. I think
error_prepend is used to provide the 'extra context' and shows in the
direction of the later, but I'm not sure (e.g. whether is it OK ton not
include any information about what where we trying to accomplish in the
message when an error is created).


>=20
> There's also the question of whether the hints are even useful (telling=

> the user to do something differently doesn't help if it wasn't the user=
,
> but libvirt, that was doing things wrong to cause the error in the firs=
t
> place).
>=20

To me this translates to the following question. Is it reasonable to
assume that we are interested in what went wrong (error message).


> So while those points may or may not be the original rationale for why
> hints are not used in QMP, but it is an explanation that works for me
> now.  Markus may also have an opinion on the matter.
>=20
>> and 'Why is this
>> case special (a hint should be reported
>> even in QMP context?'
>=20
> If something absolutely must be reported, then it is not a hint, and
> shouldn't be using the hint mechanism.
>=20

I find it hard to formulate criteria for 'must be reported'. I'm afraid
this is backwards logic: since the hint may not be reported everything
that needs to be reported is not a hint. This is a valid approach of
course, but then I think some modifications to the comments in error.h
would not hurt. And maybe something with verbose would be more
expressive name.

I hope all this makes some sense and ain't pure waste of time...

Regards,
Halil


--baCoH4v81PUxO4qqCeOQJMrnnHJlFvoId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJZVmM4AAoJEA0vhuyXGx0A8BoP/jF9dcLyra0YhFowB2SvVvbt
swiAYqdgbtOoAySEVyoDVtHizwcDS2C95Zj9EQFj2BwXyH0ojs9W8wk8HLKK49Sj
Wq4VPzNfTePnKHRZeTqdhtgejbo0dBH7YKmyYWBssDW7iwCj62pnPGIvlJ5D0uet
LpyBza5LwAjvAK3opw1hBy/4qqAzuvdhQpsVZA3Z4Ijvjk8gp8RYwMay+1n7mP5t
zZaCfr7xGZpnUUzayUY+BuHkxdjSNEV0KESp8+yDEbu4pEP9uBPLA4NmzgLKadqK
J5hXe4rAQv5JM9VobaK2tfjXqinwukCms/2frGVOrtOxMoM3gvZIDBwI0qYn9Xu1
lv6SsASlU+HxzWUI+aj3AXq1cN+5VHcdjpkW9Bc9gYd6UVC2DfjXJKt+697KGfTz
5NQfFG97jC2t93gSTvv3jA6/2VlR8EYo9cq2KJtciSVtTPaoAjFUe2LvL7zMLnB/
bTJYHsiXXir9gCln3K/FD748nHfvQgq+7VFMWngWE16OVVndEZF6N2oV4EL8teBa
EwqMUUdFl78yLpjuEbAoJpGQWcPgPtkQBs64Hv/sTvG8VgQYWczkRXDfdlfG1s7N
Lez86A3hObrr7Huh+woJI/2KC4olLcAvMIsHy2zALU1X9lHTrLELgB9m+Z8FnbyL
V4vpahaybevPCwC0SFbu
=/S0g
-----END PGP SIGNATURE-----

--baCoH4v81PUxO4qqCeOQJMrnnHJlFvoId--
