Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349D2C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B5A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B5A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxHUx-00035f-2Y
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 17:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39730)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxHTr-0002VA-W4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxHTq-0000XI-Mj
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxHTn-0000Uh-Nr; Mon, 12 Aug 2019 17:03:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 007E93001834;
 Mon, 12 Aug 2019 21:03:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81F37D1FE;
 Mon, 12 Aug 2019 21:03:43 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-5-mreitz@redhat.com>
 <04db2aa5-f850-c6fa-0101-3e9cb8d34a6a@redhat.com>
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
Message-ID: <9be593c8-332e-5f5b-899c-53737f05f878@redhat.com>
Date: Mon, 12 Aug 2019 23:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <04db2aa5-f850-c6fa-0101-3e9cb8d34a6a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A0DkRO5IV5DlIK9soEpjLwAOTwzizorpZ"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 12 Aug 2019 21:03:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/7] vmdk: Reject invalid
 compressed writes
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
--A0DkRO5IV5DlIK9soEpjLwAOTwzizorpZ
Content-Type: multipart/mixed; boundary="pEYXEQ8rb1ZBhcH5G3L2O1Rld60125eM9";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9be593c8-332e-5f5b-899c-53737f05f878@redhat.com>
Subject: Re: [Qemu-block] [PATCH 4/7] vmdk: Reject invalid compressed writes
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-5-mreitz@redhat.com>
 <04db2aa5-f850-c6fa-0101-3e9cb8d34a6a@redhat.com>
In-Reply-To: <04db2aa5-f850-c6fa-0101-3e9cb8d34a6a@redhat.com>

--pEYXEQ8rb1ZBhcH5G3L2O1Rld60125eM9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 22:26, John Snow wrote:
>=20
>=20
> On 7/25/19 11:57 AM, Max Reitz wrote:
>> Compressed writes generally have to write full clusters, not just in
>> theory but also in practice when it comes to vmdk's streamOptimized
>> subformat.  It currently is just silently broken for writes with
>> non-zero in-cluster offsets:
>>
>> $ qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 1M
>> $ qemu-io -c 'write 4k 4k' -c 'read 4k 4k' foo.vmdk
>> wrote 4096/4096 bytes at offset 4096
>> 4 KiB, 1 ops; 00.01 sec (443.724 KiB/sec and 110.9309 ops/sec)
>> read failed: Invalid argument
>>
>> (The technical reason is that vmdk_write_extent() just writes the
>> incomplete compressed data actually to offset 4k.  When reading the
>> data, vmdk_read_extent() looks at offset 0 and finds the compressed da=
ta
>> size to be 0, because that is what it reads from there.  This yields a=
n
>> error.)
>>
>> For incomplete writes with zero in-cluster offsets, the error path whe=
n
>> reading the rest of the cluster is a bit different, but the result is
>> the same:
>>
>> $ qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 1M
>> $ qemu-io -c 'write 0k 4k' -c 'read 4k 4k' foo.vmdk
>> wrote 4096/4096 bytes at offset 0
>> 4 KiB, 1 ops; 00.01 sec (362.641 KiB/sec and 90.6603 ops/sec)
>> read failed: Invalid argument
>>
>> (Here, vmdk_read_extent() finds the data and then sees that the
>> uncompressed data is short.)
>>
>> It is better to reject invalid writes than to make the user believe th=
ey
>> might have succeeded and then fail when trying to read it back.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/vmdk.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index db6acfc31e..641acacfe0 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -1731,6 +1731,16 @@ static int vmdk_write_extent(VmdkExtent *extent=
, int64_t cluster_offset,
>>      if (extent->compressed) {
>>          void *compressed_data;
>> =20
>> +        /* Only whole clusters */
>> +        if (offset_in_cluster ||
>> +            n_bytes > (extent->cluster_sectors * SECTOR_SIZE) ||
>> +            (n_bytes < (extent->cluster_sectors * SECTOR_SIZE) &&
>> +             offset + n_bytes !=3D extent->end_sector * SECTOR_SIZE))=

>> +        {
>> +            ret =3D -EINVAL;
>> +            goto out;
>> +        }
>> +
>>          if (!extent->has_marker) {
>>              ret =3D -EINVAL;
>>              goto out;
>>
>=20
> What does this look like from a guest's perspective? Is there something=

> that enforces the alignment in the graph for us?
>=20
> Or is it the case that indeed guests (or users via qemu-io) can request=

> invalid writes and we will halt the VM in those cases (in preference to=

> corrupting the disk)?

Have you ever tried using a streamOptimized VMDK disk with a guest?

I haven=E2=80=99t, but I know that it won=E2=80=99t work. O:-)  If you tr=
y to write to
an already allocated cluster, you=E2=80=99ll get an EIO and an error mess=
age via
error_report() (=E2=80=9CCould not write to allocated cluster for
streamOptimized=E2=80=9D).  So really, the only use of streamOptimized is=
 as a
qemu-img convert source/target, or as a backup/mirror target.  (Just
like compressed clusters in qcow2 images.)

I suppose if I introduced streamOptimized support today, I wouldn=E2=80=99=
t just
forward vmdk_co_pwritev_compressed() to vmdk_co_pwritev(), but instead
make vmdk_co_pwritev_compressed() only work on streamOptimized images,
and vmdk_co_pwritev() only on everything else.  Then it would be more cle=
ar.

Hm.  In fact, that=E2=80=99s a bug, isn=E2=80=99t it?  vmdk will accept c=
ompressed
writes for any subformat, even if it doesn=E2=80=99t support compression.=
  So if
you use -c and convert to vmdk, it will succeed, but the result won=E2=80=
=99t be
compressed,

It=E2=80=99s also a bit weird to accept normal writes for streamOptimized=
, but
I=E2=80=99m not sure whether that=E2=80=99s really a bug?  In any case, c=
hanging this
behavior would not be backwards-compatible...  Should we deprecate
normal writes to streamOptimized?

Max


--pEYXEQ8rb1ZBhcH5G3L2O1Rld60125eM9--

--A0DkRO5IV5DlIK9soEpjLwAOTwzizorpZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1R1C0ACgkQ9AfbAGHV
z0CzoggAjJO0tsPlvgRrbbwLFk0j9l4KoTPXiHaURrswh+9KUdld+neVv7/o0vcj
KOwJtx4ZBdjAzQbyAqQCzNDFaAkXCl5uGrfoJ+NCoPrP0bATtv/jap86h0XDFVOl
kxtCZWu9abL+FC3AiFVU7j1sVv7gMkKvgjBfjyKu2Zz5rkg0tJZSvxA/5jilX6EP
19zBdtT7H/qMzzSdY1WjbohcT7Trt4n3desOs+HR2clGtKm596LAqX3k0JYxkF1/
S5gVZyI99n1XhXbE98vHkiLDsckFfIdChSAcbuAu/25eyvm8SvA2AoGTyXScvpRt
NDsy9oaLSL8L5esJO+K5mDh3xmrhug==
=3Kdy
-----END PGP SIGNATURE-----

--A0DkRO5IV5DlIK9soEpjLwAOTwzizorpZ--

