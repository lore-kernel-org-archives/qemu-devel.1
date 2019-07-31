Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D99C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CAA20693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 09:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CAA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskpF-00025m-CG
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 05:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hskoo-0001bw-0M
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hskom-0000OJ-O1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 05:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hskok-0000NC-5Z; Wed, 31 Jul 2019 05:22:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A83B308FE8F;
 Wed, 31 Jul 2019 09:22:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5658600CC;
 Wed, 31 Jul 2019 09:22:39 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-10-mreitz@redhat.com>
 <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
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
Message-ID: <ed6e288d-aee0-5829-e11d-3c8fb704142d@redhat.com>
Date: Wed, 31 Jul 2019 11:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jeSGoyWKMbC5mIT0PX57BF9PorApu6XbP"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 31 Jul 2019 09:22:41 +0000 (UTC)
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
--jeSGoyWKMbC5mIT0PX57BF9PorApu6XbP
Content-Type: multipart/mixed; boundary="ATEqAlnHgRUthi4cGvrVD90qcgezRXPDR";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ed6e288d-aee0-5829-e11d-3c8fb704142d@redhat.com>
Subject: Re: [PATCH for-4.2 09/13] qcow2: Fix overly long snapshot tables
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-10-mreitz@redhat.com>
 <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>
In-Reply-To: <43850eef-932e-6f28-6346-15cd91e5ebbb@redhat.com>

--ATEqAlnHgRUthi4cGvrVD90qcgezRXPDR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 21:08, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> We currently refuse to open qcow2 images with overly long snapshot
>> tables.  This patch makes qemu-img check -r all drop all offending
>> entries past what we deem acceptable.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-snapshot.c | 89 +++++++++++++++++++++++++++++++++++++----=
-
>>  1 file changed, 79 insertions(+), 10 deletions(-)
>=20
> I'm less sure about this one.  8/13 should have no semantic effect (if
> the user _depended_ on that much extra data, they should have set an
> incompatible feature flag bit, at which point we'd leave their data
> alone because we don't recognize the feature bit; so it is safe to
> assume the user did not depend on the data and that we can thus nuke it=

> with impunity).  But here, we are throwing away the user's internal
> snapshots, and not even giving them a say in which ones to throw away
> (more likely, by trimming from the end, we are destroying the most
> recent snapshots in favor of the older ones - but I could argue that
> throwing away the oldest also has its uses).

First, I don=E2=80=99t think there really is a legitimate use case for ha=
ving an
overly long snapshot table.  In fact, I think our limit is too high as
it is and we just introduced it this way because we didn=E2=80=99t have a=
ny
repair functionality, and so just had to pick some limit that nobody
could ever reasonably reach.

(As the test shows, you need more than 500 snapshots with 64 kB names
and ID strings, and 1 kB of extra data to reach this limit.)

So the only likely cause to reach this number of snapshots is
corruption.  OK, so maybe we don=E2=80=99t need to be able to fix it, the=
n,
because the image is corrupted anyway.

But I think we do want to be able to fix it, because otherwise you just
can=E2=80=99t open the image at all and thus not even read the active lay=
er.


This gets me to: Second, it doesn=E2=80=99t make things worse.  Right now=
, we
just refuse to open such images in all cases.  I=E2=80=99d personally pre=
fer
discarding some data on my image over losing it all.


And third, I wonder what interface you have in mind.  I think adding an
interface to qemu-img check to properly address this problem (letting
the user discard individual snapshots) is hard.  I could imagine two thin=
gs:

(A) Making qemu-img snapshot sometimes set BDRV_O_CHECK, too, or
something.  For qemu-img snapshot -d, you don=E2=80=99t need to read the =
whole
table into memory, and thus we don=E2=80=99t need to impose any limit.  B=
ut that
seems pretty hackish to me.

(B) Maybe the proper solution would be to add an interactive interface
to bdrv_check().  I can imagine that in the future, we may get more
cases where we want interaction with the user on what data to delete and
so on.  But that's hard...  (I=E2=80=99ll try.  Good thing stdio is alrea=
dy the
standard interface in bdrv_check(), so I won=E2=80=99t have to feel bad i=
f I go
down that route even further.)

Max

>> @@ -417,7 +461,32 @@ int coroutine_fn qcow2_check_read_snapshot_table(=
BlockDriverState *bs,
>> =20
>>          return ret;
>>      }
>> -    result->corruptions +=3D extra_data_dropped;
>> +    result->corruptions +=3D nb_clusters_reduced + extra_data_dropped=
;
>> +
>> +    if (nb_clusters_reduced) {
>> +        /*
>> +         * Update image header now, because:
>> +         * (1) qcow2_check_refcounts() relies on s->nb_snapshots to b=
e
>> +         *     the same as what the image header says,
>> +         * (2) this leaks clusters, but qcow2_check_refcounts() will
>> +         *     fix that.
>> +         */
>> +        assert(fix & BDRV_FIX_ERRORS);
>> +
>> +        snapshot_table_pointer.nb_snapshots =3D cpu_to_be32(s->nb_sna=
pshots);
>> +        ret =3D bdrv_pwrite_sync(bs->file, 60,
>=20
> That '60' needs a name; it keeps popping up.
>=20
> If we like the patch, I didn't spot major coding problems.  But because=

> I'm not sure we want this patch, I'll skip R-b for now.
>=20



--ATEqAlnHgRUthi4cGvrVD90qcgezRXPDR--

--jeSGoyWKMbC5mIT0PX57BF9PorApu6XbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BXd0ACgkQ9AfbAGHV
z0BGJQf+NldmOZXpL//K3GP2wkqLOFtxj9LzWRagB7yZ+qLtdHU5Ii2c2qcwn4/U
wt/twSCu4dw2l5GDqqsOOxaE7/fdfrdiQnLJ/9IrBwhXSxq2GlQfV985ajUya25A
OYpV94rSxfGWvQi5qOAjICZpnvEqeA5/hSK3qwEpWVb5D75HAw2YaUvniNnKiqY0
fbF0sRkjUpkX7XUAh9Vnf3TlN803hrLh9uye97vpM3ycQXDYGXx+YfTiQ+yVYcIz
2o5wb7wjIGUEYu7FPQ35zKLRWsUTJXRrTKJ5FIAyj+Ow9KLban1KlZOW0ot10i9I
Y/1iNWxNdKPI7kyxwkPV5NVAvkb2nA==
=RPKm
-----END PGP SIGNATURE-----

--jeSGoyWKMbC5mIT0PX57BF9PorApu6XbP--

