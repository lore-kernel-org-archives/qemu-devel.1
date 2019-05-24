Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CC9C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25BB20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25BB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9V5-0006RY-1M
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:40:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hU9TW-0005PM-Hk
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hU9TU-0003b5-MW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:39:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hU9TQ-0003Vj-ER; Fri, 24 May 2019 08:39:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A724330832C8;
	Fri, 24 May 2019 12:38:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-150.brq.redhat.com
	[10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 286FA6A96A;
	Fri, 24 May 2019 12:38:53 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190523170643.20794-1-jsnow@redhat.com>
	<20190523170643.20794-4-jsnow@redhat.com>
	<8a8882b0-b752-0106-88c3-818f42852eef@redhat.com>
	<b23e01b3-d076-0647-49ca-4554bc565336@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
	mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
	/PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
	U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
	mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
	awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
	AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
	CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
	B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
	2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
	AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
	8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
	4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
	BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
	xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
	W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
	DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
	64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
	ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
	sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
	alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
	/ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
	bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
	R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <3ae87c50-f4a6-ab80-f878-734d3ef61d2a@redhat.com>
Date: Fri, 24 May 2019 14:38:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b23e01b3-d076-0647-49ca-4554bc565336@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AMV3ZNIFX6JfTekoWqzf9kUI5pbZt89Bv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 24 May 2019 12:38:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 3/5] QEMUMachine: add events_wait method
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AMV3ZNIFX6JfTekoWqzf9kUI5pbZt89Bv
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
Message-ID: <3ae87c50-f4a6-ab80-f878-734d3ef61d2a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] QEMUMachine: add events_wait method
References: <20190523170643.20794-1-jsnow@redhat.com>
 <20190523170643.20794-4-jsnow@redhat.com>
 <8a8882b0-b752-0106-88c3-818f42852eef@redhat.com>
 <b23e01b3-d076-0647-49ca-4554bc565336@redhat.com>
In-Reply-To: <b23e01b3-d076-0647-49ca-4554bc565336@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.05.19 20:03, John Snow wrote:
>=20
>=20
> On 5/23/19 1:49 PM, Max Reitz wrote:
>> On 23.05.19 19:06, John Snow wrote:
>>> Instead of event_wait which looks for a single event, add an events_w=
ait
>>> which can look for any number of events simultaneously. However, it
>>> will still only return one at a time, whichever happens first.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  python/qemu/__init__.py | 69 +++++++++++++++++++++++++++++----------=
--
>>>  1 file changed, 49 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
>>> index 81d9657ec0..98ed8a2e28 100644
>>> --- a/python/qemu/__init__.py
>>> +++ b/python/qemu/__init__.py
>>> @@ -402,42 +402,71 @@ class QEMUMachine(object):
>>>          self._qmp.clear_events()
>>>          return events
>>> =20
>>> -    def event_wait(self, name, timeout=3D60.0, match=3DNone):
>>> +    @staticmethod
>>> +    def event_match(event, match=3DNone):
>>>          """
>>> -        Wait for specified timeout on named event in QMP; optionally=
 filter
>>> -        results by match.
>>> +        Check if an event matches optional match criteria.
>>> =20
>>> -        The 'match' is checked to be a recursive subset of the 'even=
t'; skips
>>> -        branch processing on match's value None
>>> -           {"foo": {"bar": 1}} matches {"foo": None}
>>> -           {"foo": {"bar": 1}} does not matches {"foo": {"baz": None=
}}
>>> +        The match criteria takes the form of a matching subdict. The=
 event is
>>> +        checked to be a superset of the subdict, recursively, with m=
atching
>>> +        values whenever those values are not None.
>>> +
>>> +        Examples, with the subdict queries on the left:
>>> +         - None matches any object.
>>> +         - {"foo": None} matches {"foo": {"bar": 1}}
>>> +         - {"foo": {"baz": None}} does not match {"foo": {"bar": 1}}=

>>
>> Pre-existing, but the difference between =E2=80=9Cbar=E2=80=9D and =E2=
=80=9Cbaz=E2=80=9D confused me
>> quite a bit.
>>
>> Also, I wonder...  {"foo": None} would not match {"foo": 1}, right?
>> Does that make sense?  Shouldn=E2=80=99t None be the wildcard here in =
general?
>> (Also pre-existing of course.)
>>
>> But this patch doesn=E2=80=99t make things worse, so:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> (I=E2=80=99d still like your opinion.)
>>
>=20
> I knew I was inviting trouble by trying to re-document this.
>=20
> The intention I had when writing the docs, which I think are wrong now,=

> was for {"foo": None} to match {"foo": 1}, but I think you're right tha=
t
> it won't because '1' isn't a dict, so it tests for equality instead.
>=20
> So I need to fix this one up a little bit, but I'll take the review as =
a
> sign that this approach seems workable.

I think the comment is technically completely correct.  It=E2=80=99s just=
 that
(1) it=E2=80=99s hard to discern =E2=80=9Cbar=E2=80=9D from =E2=80=9Cbaz=E2=
=80=9D, and (2) if {"foo": None}
intentionally does not match {"foo": 1}, we may want to document that,
because it isn=E2=80=99t intuitively clear from the description.  If it=E2=
=80=99s a bug,
the code should be fixed (and it should still be documented).

Max


--AMV3ZNIFX6JfTekoWqzf9kUI5pbZt89Bv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzn5dsACgkQ9AfbAGHV
z0A37Qf9FKTFbFXQ4ivXTF+kbmJ1XXCc2xWFz6m6XKOfqfy3QSrWEN0tB/KrHq5q
0JuZKF3NuJ45Erf+zkRRDNGIMlDA8B80Dkfc4/rehOjx4qXveTWbi0+Zo/ixgWYE
nbXJ+Ld3bu5xXH1QQ4nNS+r+xprbfxkr5h97RdlYFCK++LPp8Fq8EwjYkE1i1JZJ
QIH+gHTnr/lYcsHG/54I4K0Z5tKEyIKxyETpyKLQo6wO7t30jWHKEtcZqprhDxlW
HQEl8VWimy7IEJg7lYp2L5fNOLI7C++wLr5zRAWQ2OMVqbD1VEx0zgswtQQxDEAG
VB5xnU8vJZ9Ihv3uHup2a1mEstvhug==
=JZvB
-----END PGP SIGNATURE-----

--AMV3ZNIFX6JfTekoWqzf9kUI5pbZt89Bv--

