Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615EC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A543206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A543206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWRe-0005nn-H1
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxWNw-0000XL-KA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxWNu-0007Zs-TW
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxWNr-0007Wd-ID; Tue, 13 Aug 2019 08:58:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2F0F314D66C;
 Tue, 13 Aug 2019 12:58:37 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AFD37F624;
 Tue, 13 Aug 2019 12:58:35 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-5-mreitz@redhat.com>
 <04db2aa5-f850-c6fa-0101-3e9cb8d34a6a@redhat.com>
 <9be593c8-332e-5f5b-899c-53737f05f878@redhat.com>
 <b4a780dc-4fc7-3f29-c634-627ab51e45b4@redhat.com>
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
Message-ID: <da3cee67-c0ac-37c2-c630-377c6ab9ac9a@redhat.com>
Date: Tue, 13 Aug 2019 14:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4a780dc-4fc7-3f29-c634-627ab51e45b4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cLKqEc6qPi0AMKrXvXKcAsARamp9hryDX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 13 Aug 2019 12:58:38 +0000 (UTC)
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
--cLKqEc6qPi0AMKrXvXKcAsARamp9hryDX
Content-Type: multipart/mixed; boundary="jVywyVPQAOq9Doxbdqq32bC7TaYSPqJGG";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <da3cee67-c0ac-37c2-c630-377c6ab9ac9a@redhat.com>
Subject: Re: [Qemu-block] [PATCH 4/7] vmdk: Reject invalid compressed writes
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-5-mreitz@redhat.com>
 <04db2aa5-f850-c6fa-0101-3e9cb8d34a6a@redhat.com>
 <9be593c8-332e-5f5b-899c-53737f05f878@redhat.com>
 <b4a780dc-4fc7-3f29-c634-627ab51e45b4@redhat.com>
In-Reply-To: <b4a780dc-4fc7-3f29-c634-627ab51e45b4@redhat.com>

--jVywyVPQAOq9Doxbdqq32bC7TaYSPqJGG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 23:16, John Snow wrote:
>=20
>=20
> On 8/12/19 5:03 PM, Max Reitz wrote:
>> On 12.08.19 22:26, John Snow wrote:
>>>
>>>
>>> On 7/25/19 11:57 AM, Max Reitz wrote:
>>>> Compressed writes generally have to write full clusters, not just in=

>>>> theory but also in practice when it comes to vmdk's streamOptimized
>>>> subformat.  It currently is just silently broken for writes with
>>>> non-zero in-cluster offsets:
>>>>
>>>> $ qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 1M=

>>>> $ qemu-io -c 'write 4k 4k' -c 'read 4k 4k' foo.vmdk
>>>> wrote 4096/4096 bytes at offset 4096
>>>> 4 KiB, 1 ops; 00.01 sec (443.724 KiB/sec and 110.9309 ops/sec)
>>>> read failed: Invalid argument
>>>>
>>>> (The technical reason is that vmdk_write_extent() just writes the
>>>> incomplete compressed data actually to offset 4k.  When reading the
>>>> data, vmdk_read_extent() looks at offset 0 and finds the compressed =
data
>>>> size to be 0, because that is what it reads from there.  This yields=
 an
>>>> error.)
>>>>
>>>> For incomplete writes with zero in-cluster offsets, the error path w=
hen
>>>> reading the rest of the cluster is a bit different, but the result i=
s
>>>> the same:
>>>>
>>>> $ qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 1M=

>>>> $ qemu-io -c 'write 0k 4k' -c 'read 4k 4k' foo.vmdk
>>>> wrote 4096/4096 bytes at offset 0
>>>> 4 KiB, 1 ops; 00.01 sec (362.641 KiB/sec and 90.6603 ops/sec)
>>>> read failed: Invalid argument
>>>>
>>>> (Here, vmdk_read_extent() finds the data and then sees that the
>>>> uncompressed data is short.)
>>>>
>>>> It is better to reject invalid writes than to make the user believe =
they
>>>> might have succeeded and then fail when trying to read it back.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  block/vmdk.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/block/vmdk.c b/block/vmdk.c
>>>> index db6acfc31e..641acacfe0 100644
>>>> --- a/block/vmdk.c
>>>> +++ b/block/vmdk.c
>>>> @@ -1731,6 +1731,16 @@ static int vmdk_write_extent(VmdkExtent *exte=
nt, int64_t cluster_offset,
>>>>      if (extent->compressed) {
>>>>          void *compressed_data;
>>>> =20
>>>> +        /* Only whole clusters */
>>>> +        if (offset_in_cluster ||
>>>> +            n_bytes > (extent->cluster_sectors * SECTOR_SIZE) ||
>>>> +            (n_bytes < (extent->cluster_sectors * SECTOR_SIZE) &&
>>>> +             offset + n_bytes !=3D extent->end_sector * SECTOR_SIZE=
))
>>>> +        {
>>>> +            ret =3D -EINVAL;
>>>> +            goto out;
>>>> +        }
>>>> +
>>>>          if (!extent->has_marker) {
>>>>              ret =3D -EINVAL;
>>>>              goto out;
>>>>
>>>
>>> What does this look like from a guest's perspective? Is there somethi=
ng
>>> that enforces the alignment in the graph for us?
>>>
>>> Or is it the case that indeed guests (or users via qemu-io) can reque=
st
>>> invalid writes and we will halt the VM in those cases (in preference =
to
>>> corrupting the disk)?
>>
>> Have you ever tried using a streamOptimized VMDK disk with a guest?
>>
>=20
> Nope! It's why I'm asking. I have no idea what the whole picture before=

> and after is.
>=20
>> I haven=E2=80=99t, but I know that it won=E2=80=99t work. O:-)  If you=
 try to write to
>> an already allocated cluster, you=E2=80=99ll get an EIO and an error m=
essage via
>> error_report() (=E2=80=9CCould not write to allocated cluster for
>> streamOptimized=E2=80=9D).  So really, the only use of streamOptimized=
 is as a
>> qemu-img convert source/target, or as a backup/mirror target.  (Just
>> like compressed clusters in qcow2 images.)
>>
>=20
> OK, makes sense. Someone's going to try to use it in cases where it
> doesn't make sense though, for sure.
>=20
>> I suppose if I introduced streamOptimized support today, I wouldn=E2=80=
=99t just
>> forward vmdk_co_pwritev_compressed() to vmdk_co_pwritev(), but instead=

>> make vmdk_co_pwritev_compressed() only work on streamOptimized images,=

>> and vmdk_co_pwritev() only on everything else.  Then it would be more =
clear.
>>
>> Hm.  In fact, that=E2=80=99s a bug, isn=E2=80=99t it?  vmdk will accep=
t compressed
>> writes for any subformat, even if it doesn=E2=80=99t support compressi=
on.  So if
>> you use -c and convert to vmdk, it will succeed, but the result won=E2=
=80=99t be
>> compressed,
>>
>> It=E2=80=99s also a bit weird to accept normal writes for streamOptimi=
zed, but
>> I=E2=80=99m not sure whether that=E2=80=99s really a bug?  In any case=
, changing this
>> behavior would not be backwards-compatible...  Should we deprecate
>> normal writes to streamOptimized?
>>
>=20
> If it's supposed to be the case that streamOptimized *only* gets
> compressed, aligned writes -- it probably is a bug to do normal,
> uncompressed writes, isn't it? Does that produce a usable image?

Well, all writes are silently done as compressed writes.  (With the
alignment requirements added in this patch.)  The image is useful, as
long as you only full clusters, and you may only write to each cluster
once...

>> Max
>>
>=20
> Anyway, I'm fine with this patch because things aren't any worse, and
> our support for non-native formats has always been kind of best-attempt=
=2E
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks. :-)

Max


--jVywyVPQAOq9Doxbdqq32bC7TaYSPqJGG--

--cLKqEc6qPi0AMKrXvXKcAsARamp9hryDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1Ss/kACgkQ9AfbAGHV
z0Cz3AgAk5hrmgWS/mLLjFbVMSsRoQwgFhsqZFJVgTb3/0HcHFtrQSaH+1SUPzAg
RsGvc7NneeMWesY8srKSG/Dflki4kB41UJX/TEXgjapZAg19I/q0xzhwzeIvpvfr
a6POX0Ol6WhBy8eD+UICKEGf8S8IUcQrYT2Ss96e18sgsRLy4wiVRHB5n1u/qm50
HDmMhG2dGfenCCvNfXQW+eVlIM3VuIAgLVOjOnFB9qpZtQFDOivdgjFv4RFpvfla
/zO5dopXDWPEzAA9v6TzDYUj0AnnsJmJqkA6Kpxo91NI/1Oe8KcHZRlOp0QLoDVY
D27JhTHlIT/NgZRvDcHN7aU1p6eBQQ==
=eKj8
-----END PGP SIGNATURE-----

--cLKqEc6qPi0AMKrXvXKcAsARamp9hryDX--

