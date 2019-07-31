Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC672C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43EE20693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43EE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskQF-0007a9-WE
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hskPq-00072e-Cc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hskPp-0001qN-CD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hskPm-0001nn-W9; Wed, 31 Jul 2019 04:56:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4617FC03BC91;
 Wed, 31 Jul 2019 08:56:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BACA7600CC;
 Wed, 31 Jul 2019 08:56:52 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-6-mreitz@redhat.com>
 <4027fac6-1faa-6eae-e66e-0f6edaf653b6@redhat.com>
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
Message-ID: <efb03488-366e-8c92-e36a-32effdc1d66f@redhat.com>
Date: Wed, 31 Jul 2019 10:56:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4027fac6-1faa-6eae-e66e-0f6edaf653b6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WSXBnIW8PB7srR7yBGlnaFVMlCjAdVRLz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 31 Jul 2019 08:56:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 05/13] qcow2: Write v3-compliant
 snapshot list on upgrade
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
--WSXBnIW8PB7srR7yBGlnaFVMlCjAdVRLz
Content-Type: multipart/mixed; boundary="w0LSom7Ph3RHF2kv1mVjmA3uXwZ9Z2YGZ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <efb03488-366e-8c92-e36a-32effdc1d66f@redhat.com>
Subject: Re: [PATCH for-4.2 05/13] qcow2: Write v3-compliant snapshot list on
 upgrade
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-6-mreitz@redhat.com>
 <4027fac6-1faa-6eae-e66e-0f6edaf653b6@redhat.com>
In-Reply-To: <4027fac6-1faa-6eae-e66e-0f6edaf653b6@redhat.com>

--w0LSom7Ph3RHF2kv1mVjmA3uXwZ9Z2YGZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 20:10, Eric Blake wrote:
> On 7/30/19 12:25 PM, Max Reitz wrote:
>> qcow2 v3 requires every snapshot table entry to have two extra data
>> fields: The 64-bit VM state size, and the virtual disk size.  Both are=

>> optional for v2 images, so they may not be present.
>>
>> qcow2_upgrade() therefore should update the snapshot table to ensure a=
ll
>> entries have these extra data fields.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1727347
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>=20
>> +
>> +    /*
>> +     * In v2, snapshots do not need to have extra data.  v3 requires
>> +     * the 64-bit VM state size and the virtual disk size to be
>> +     * present.
>> +     * qcow2_write_snapshots() will always write the list in the
>> +     * v3-compliant format.
>> +     */
>> +    need_snapshot_update =3D false;
>> +    for (i =3D 0; i < s->nb_snapshots; i++) {
>> +        if (s->snapshots[i].extra_data_size < 16) {
>=20
> s/16/sizeof(extra)/ looks a bit nicer, but doesn't change semantics.

Hm, but it=E2=80=99s not quite right.  I mean, right now it is, but if we=
 were
to add a new field to snapshot metadata, it wouldn=E2=80=99t be.  It shou=
ld be 16.

I can make it something like sizeof(extra.vm_state_size_large) +
sizeof(extra.disk_size), though.

Max

> Reviewed-by: Eric Blake <eblake@redhat.com>



--w0LSom7Ph3RHF2kv1mVjmA3uXwZ9Z2YGZ--

--WSXBnIW8PB7srR7yBGlnaFVMlCjAdVRLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BV9IACgkQ9AfbAGHV
z0B04ggAuqkjXUn+KxdeVCNAQvf0WeQmQtQf//HXxJuIhUTKt4Dnj+4zFsvtshmN
noZ1iwfFjBqYWYFDr72oFQzvlLK+wDNYOhpxR3dK0fgdeaLa69F5kFMVeMAMOAZw
89dRzjqDiOQ0uBMNgIUONwp0ij2ndbGaVU4sgud4vEb7CeUGzN0UtgI6k27Icd0d
j8IFp2ZPvQujymKXbERh9HTGncgfsRpdDvuGl2PDKFoTr2rpKSXt7uUMyoR5CICu
jGFmbj6/cvFYmOpkeuk915VQaN8CCf5Wdb+SOI9tnbwIZEpV9yRyg1UjIh661Rlj
p50aWL1noFFmtoh8LuhKsoFVjNLszg==
=3kPG
-----END PGP SIGNATURE-----

--WSXBnIW8PB7srR7yBGlnaFVMlCjAdVRLz--

