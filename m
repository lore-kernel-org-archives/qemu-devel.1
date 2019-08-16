Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E8C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EF7206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EF7206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hygdi-0002LM-Te
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hygcx-0001qu-GA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hygcw-0002Gh-9q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hygct-0002EP-1w; Fri, 16 Aug 2019 14:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E1C4308212F;
 Fri, 16 Aug 2019 18:06:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D585117AD8;
 Fri, 16 Aug 2019 18:06:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-10-mreitz@redhat.com>
 <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
 <ed6e288d-aee0-5829-e11d-3c8fb704142d@redhat.com>
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
Message-ID: <0d6956bb-0281-da6b-2dc1-720787f7180c@redhat.com>
Date: Fri, 16 Aug 2019 20:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ed6e288d-aee0-5829-e11d-3c8fb704142d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z2KOWSETeJGDazJwA2HBhRGFSxSx6o5XC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 16 Aug 2019 18:06:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 09/13] qcow2: Fix overly long
 snapshot tables
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z2KOWSETeJGDazJwA2HBhRGFSxSx6o5XC
Content-Type: multipart/mixed; boundary="q28kXjND9zcAUiCKIxtk2bSlF4ChJX90B";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <0d6956bb-0281-da6b-2dc1-720787f7180c@redhat.com>
Subject: Re: [PATCH for-4.2 09/13] qcow2: Fix overly long snapshot tables
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-10-mreitz@redhat.com>
 <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
 <ed6e288d-aee0-5829-e11d-3c8fb704142d@redhat.com>
In-Reply-To: <ed6e288d-aee0-5829-e11d-3c8fb704142d@redhat.com>

--q28kXjND9zcAUiCKIxtk2bSlF4ChJX90B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.07.19 11:22, Max Reitz wrote:
> On 30.07.19 21:08, Eric Blake wrote:
>> On 7/30/19 12:25 PM, Max Reitz wrote:
>>> We currently refuse to open qcow2 images with overly long snapshot
>>> tables.  This patch makes qemu-img check -r all drop all offending
>>> entries past what we deem acceptable.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block/qcow2-snapshot.c | 89 +++++++++++++++++++++++++++++++++++++---=
--
>>>  1 file changed, 79 insertions(+), 10 deletions(-)
>>
>> I'm less sure about this one.  8/13 should have no semantic effect (if=

>> the user _depended_ on that much extra data, they should have set an
>> incompatible feature flag bit, at which point we'd leave their data
>> alone because we don't recognize the feature bit; so it is safe to
>> assume the user did not depend on the data and that we can thus nuke i=
t
>> with impunity).  But here, we are throwing away the user's internal
>> snapshots, and not even giving them a say in which ones to throw away
>> (more likely, by trimming from the end, we are destroying the most
>> recent snapshots in favor of the older ones - but I could argue that
>> throwing away the oldest also has its uses).
>=20
> First, I don=E2=80=99t think there really is a legitimate use case for =
having an
> overly long snapshot table.  In fact, I think our limit is too high as
> it is and we just introduced it this way because we didn=E2=80=99t have=
 any
> repair functionality, and so just had to pick some limit that nobody
> could ever reasonably reach.
>=20
> (As the test shows, you need more than 500 snapshots with 64 kB names
> and ID strings, and 1 kB of extra data to reach this limit.)
>=20
> So the only likely cause to reach this number of snapshots is
> corruption.  OK, so maybe we don=E2=80=99t need to be able to fix it, t=
hen,
> because the image is corrupted anyway.
>=20
> But I think we do want to be able to fix it, because otherwise you just=

> can=E2=80=99t open the image at all and thus not even read the active l=
ayer.
>=20
>=20
> This gets me to: Second, it doesn=E2=80=99t make things worse.  Right n=
ow, we
> just refuse to open such images in all cases.  I=E2=80=99d personally p=
refer
> discarding some data on my image over losing it all.
>=20
>=20
> And third, I wonder what interface you have in mind.  I think adding an=

> interface to qemu-img check to properly address this problem (letting
> the user discard individual snapshots) is hard.  I could imagine two th=
ings:
>=20
> (A) Making qemu-img snapshot sometimes set BDRV_O_CHECK, too, or
> something.  For qemu-img snapshot -d, you don=E2=80=99t need to read th=
e whole
> table into memory, and thus we don=E2=80=99t need to impose any limit. =
 But that
> seems pretty hackish to me.
>=20
> (B) Maybe the proper solution would be to add an interactive interface
> to bdrv_check().  I can imagine that in the future, we may get more
> cases where we want interaction with the user on what data to delete an=
d
> so on.  But that's hard...  (I=E2=80=99ll try.  Good thing stdio is alr=
eady the
> standard interface in bdrv_check(), so I won=E2=80=99t have to feel bad=
 if I go
> down that route even further.)

After some fiddling around, I don=E2=80=99t think this is worth it.  As I=
 said,
this is an extremely rare case anyway, so the main goal should be to
just being able to access the active layer to copy at least that data
off the image.

The other side is that this would introduce quite complex code that
basically cannot be tested reasonably.  I=E2=80=99d rather not do that.

Max


--q28kXjND9zcAUiCKIxtk2bSlF4ChJX90B--

--Z2KOWSETeJGDazJwA2HBhRGFSxSx6o5XC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1W8L4ACgkQ9AfbAGHV
z0CKQwf9GRzcGeT/Xky0YmwwvQY60i4gi1W3CnCfsAcKmnoCbRCF3BWuFd9svBXi
KCDoGfC+aHcQ+Mh7mbKqdVTfj36t63RbpP5m0r3APwZz6Cdd6U4Ii7crAEAyuCvV
I2D0vcN/ik+uqkoWgcNSYrHThkC6ney25S4IdyapjGR+7SEddbKL5zMjtARPqBYr
rvUH7eiC6WgygVOWDiA1hw+6EezTRD8saZh2mDgipn51u1NsMukP1uXOwff8gcBr
tghrwWtWE0Y6hfj6x3h3eqXslHK+QJZ6NuywmiR5Ow8D6dNjIWcIGfm2GecXnYqb
N8D7PaOv3MPmwl7mjP4CPNlnrzSL2g==
=zTCi
-----END PGP SIGNATURE-----

--Z2KOWSETeJGDazJwA2HBhRGFSxSx6o5XC--

