Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420CBC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1729F20693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1729F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskSS-0000bG-CF
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hskRz-0008WS-PY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hskRy-0003uU-M0
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hskRw-0003nx-8R; Wed, 31 Jul 2019 04:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 158568667D;
 Wed, 31 Jul 2019 08:59:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D41D60852;
 Wed, 31 Jul 2019 08:59:05 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-7-mreitz@redhat.com>
 <e21f44ce-89d9-d51b-b461-6f939a3f98e9@redhat.com>
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
Message-ID: <400fcddf-d1c4-c4bf-8536-403c02a9687b@redhat.com>
Date: Wed, 31 Jul 2019 10:59:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e21f44ce-89d9-d51b-b461-6f939a3f98e9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9reBMT8mlydtSQr5s4PNc7LMlXTlDtF08"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 31 Jul 2019 08:59:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 06/13] qcow2: Separate
 qcow2_check_read_snapshot_table()
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
--9reBMT8mlydtSQr5s4PNc7LMlXTlDtF08
Content-Type: multipart/mixed; boundary="WgdV6kKYcws8gbE2nvzCwxcFzQBDI7TbV";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <400fcddf-d1c4-c4bf-8536-403c02a9687b@redhat.com>
Subject: Re: [PATCH for-4.2 06/13] qcow2: Separate
 qcow2_check_read_snapshot_table()
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-7-mreitz@redhat.com>
 <e21f44ce-89d9-d51b-b461-6f939a3f98e9@redhat.com>
In-Reply-To: <e21f44ce-89d9-d51b-b461-6f939a3f98e9@redhat.com>

--WgdV6kKYcws8gbE2nvzCwxcFzQBDI7TbV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 20:53, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> Reading the snapshot table can fail.  That is a problem when we want t=
o
>> repair the image.
>>
>> Therefore, stop reading the snapshot table in qcow2_do_open() in check=

>> mode.  Instead, add a new function qcow2_check_read_snapshot_table()
>> that reads the snapshot table at a later point.  In the future, we wan=
t
>> to handle errors here and fix them.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.h          |  4 +++
>>  block/qcow2-snapshot.c | 58 ++++++++++++++++++++++++++++++++
>>  block/qcow2.c          | 76 ++++++++++++++++++++++++++++++++---------=
-
>>  3 files changed, 120 insertions(+), 18 deletions(-)
>>
>=20
>> +++ b/block/qcow2-snapshot.c
>> @@ -321,6 +321,64 @@ fail:
>>      return ret;
>>  }
>> =20
>> +int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs=
,
>> +                                                 BdrvCheckResult *res=
ult,
>> +                                                 BdrvCheckMode fix)
>> +{
>> +    BDRVQcow2State *s =3D bs->opaque;
>> +    Error *local_err =3D NULL;
>> +    int ret;
>> +    struct {
>> +        uint32_t nb_snapshots;
>> +        uint64_t snapshots_offset;
>> +    } QEMU_PACKED snapshot_table_pointer;
>> +
>> +    /* qcow2_do_open() discards this information in check mode */
>> +    ret =3D bdrv_pread(bs->file, 60, &snapshot_table_pointer,
>> +                     sizeof(snapshot_table_pointer));
>=20
> Should that '60' be a named constant or offsetof() expression?  (I know=
,
> you just copied this instance from elsewhere)

Well, I copied it from the specification. O:-)

You=E2=80=99re completely right.  It should be offsetof(QCowHeader, nb_sn=
apshots).

(I blame the fact that I had started writing the test by this point, so
I was already immersed in so many magic numbers.)

> Reviewed-by: Eric Blake <eblake@redhat.com>



--WgdV6kKYcws8gbE2nvzCwxcFzQBDI7TbV--

--9reBMT8mlydtSQr5s4PNc7LMlXTlDtF08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BWFcACgkQ9AfbAGHV
z0Dm1Qf/U710GfsHP0mjd1oUmma18oz9vTL5me/Yuw7J4vhwvggPBkwBohY5Fs2f
Qft7w/lhfLg/cMDcWZMIy+uLpsf6yWgqX1c6oNrSQUmscuWCsZ0Nb9Q/7I0IhqHQ
UreK46O47tG08n6rH0/Lb2+pNvJnM0Ei86NZkCeI8WQIJNSDfWOy2ugVzxMWo8bc
3/S7mgPEyQdeLRRcG2xSfgW4x83KZvlQB/FkcUZEHhwvtPmad3CkUmKcTUBabsNv
Bd3tpjHuvfHta9Ce+J5eXrAoVUi9am0NKCjrST8I1VI4Wm6xNd3pLkTVdvMgw9Ip
KEvBR2YUN78ENVxTVDjmqFps3Frapg==
=vzPq
-----END PGP SIGNATURE-----

--9reBMT8mlydtSQr5s4PNc7LMlXTlDtF08--

