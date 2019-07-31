Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17962C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17A720693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17A720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hskOI-0006Pd-Ve
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hskNr-0005rU-OV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hskNq-0000YW-C2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 04:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hskNn-0000WC-5O; Wed, 31 Jul 2019 04:54:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 717023082141;
 Wed, 31 Jul 2019 08:54:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-44.ams2.redhat.com
 [10.36.117.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E17BA6012A;
 Wed, 31 Jul 2019 08:54:48 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-3-mreitz@redhat.com>
 <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
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
Message-ID: <60b73760-9ffd-aedf-afc0-9c58c804236c@redhat.com>
Date: Wed, 31 Jul 2019 10:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mlDAKq0YSqucVBDOLCWWAJIfmlYvkO8OH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 31 Jul 2019 08:54:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 02/13] qcow2: Keep unknown extra
 snapshot data
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
--mlDAKq0YSqucVBDOLCWWAJIfmlYvkO8OH
Content-Type: multipart/mixed; boundary="x3igIX339uJ0FKqGlQnio1ArvjV0Brws0";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <60b73760-9ffd-aedf-afc0-9c58c804236c@redhat.com>
Subject: Re: [PATCH for-4.2 02/13] qcow2: Keep unknown extra snapshot data
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-3-mreitz@redhat.com>
 <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
In-Reply-To: <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>

--x3igIX339uJ0FKqGlQnio1ArvjV0Brws0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 19:56, Eric Blake wrote:
> On 7/30/19 12:24 PM, Max Reitz wrote:
>> The qcow2 specification says to ignore unknown extra data fields in
>> snapshot table entries.  Currently, we discard it whenever we update t=
he
>> image, which is a bit different from "ignore".
>>
>> This patch makes the qcow2 driver keep all unknown extra data fields
>> when updating an image's snapshot table.
>=20
> The cover letter questioned whether we want this, but I think we do.
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.h          |  5 ++++
>>  block/qcow2-snapshot.c | 59 +++++++++++++++++++++++++++++++++++------=
-
>>  2 files changed, 55 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 175708cee0..290a48b77e 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -61,6 +61,9 @@
>>   * space for snapshot names and IDs */
>>  #define QCOW_MAX_SNAPSHOTS_SIZE (1024 * QCOW_MAX_SNAPSHOTS)
>> =20
>> +/* Maximum amount of extra data per snapshot table entry to accept */=

>> +#define QCOW_MAX_SNAPSHOT_EXTRA_DATA 1024
>> +
>>  /* Bitmap header extension constraints */
>>  #define QCOW2_MAX_BITMAPS 65535
>>  #define QCOW2_MAX_BITMAP_DIRECTORY_SIZE (1024 * QCOW2_MAX_BITMAPS)
>> @@ -178,6 +181,8 @@ typedef struct QCowSnapshot {
>>      uint32_t date_sec;
>>      uint32_t date_nsec;
>>      uint64_t vm_clock_nsec;
>> +    uint32_t extra_data_size;
>> +    void *unknown_extra_data; /* Extra data past QCowSnapshotExtraDat=
a */
>=20
> Is char* going to be any easier to use than void*?
>=20
>> +++ b/block/qcow2-snapshot.c
>=20
>> @@ -80,30 +80,52 @@ int qcow2_read_snapshots(BlockDriverState *bs, Err=
or **errp)
>=20
>> +
>> +        /* Read known extra data */
>>          ret =3D bdrv_pread(bs->file, offset, &extra,
>> -                         MIN(sizeof(extra), extra_data_size));
>> +                         MIN(sizeof(extra), sn->extra_data_size));
>>          if (ret < 0) {
>>              error_setg_errno(errp, -ret, "Failed to read snapshot tab=
le");
>>              goto fail;
>>          }
>> -        offset +=3D extra_data_size;
>> +        offset +=3D MIN(sizeof(extra), sn->extra_data_size);
>> =20
>> -        if (extra_data_size >=3D 8) {
>> +        if (sn->extra_data_size >=3D 8) {
>=20
> While touching this, is it worth spelling it:
> if (sn->extra_data_size >=3D sizeof(extra.vm_state_size_large)) {
>=20
>>              sn->vm_state_size =3D be64_to_cpu(extra.vm_state_size_lar=
ge);
>>          }
>> =20
>> -        if (extra_data_size >=3D 16) {
>> +        if (sn->extra_data_size >=3D 16) {
>=20
> and a similar use of sizeof() instead of hard-coded 16 here?

Well, the most verbose spelling would be offsetof() + sizeof() both
times.  Hm.  I=E2=80=99ll see how it looks.  I think it is obvious enough=
 what
it means as it is, and the full offsetof() + sizeof() might actually be
less obvious just because it=E2=80=99s longer and thus takes longer to re=
ad.

>>              sn->disk_size =3D be64_to_cpu(extra.disk_size);
>>          } else {
>>              sn->disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
>>          }
>> =20
>> +        if (sn->extra_data_size > sizeof(extra)) {
>> +            /* Store unknown extra data */
>> +            size_t unknown_extra_data_size =3D
>> +                sn->extra_data_size - sizeof(extra);
>> +
>> +            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_si=
ze);
>> +            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_da=
ta,
>> +                             unknown_extra_data_size);
>=20
> We're doing two separate bdrv_pread()s. Would it be better to do a
> single bdrv_preadv into a vector composed of &extra and
> &unknown_extra_data, for less I/O?  (Then again, this micro-optimizatio=
n
> is probably in the noise in the long run)

Interesting idea, we could even add the ID and name string into that
vector.  But I=E2=80=99m not sure whether it=E2=80=99s really useful.

(I=E2=80=99ll take a look anyway, because it sounds interesting.)

>> +            if (ret < 0) {
>> +                error_setg_errno(errp, -ret, "Failed to read snapshot=
 table");
>> +                goto fail;
>> +            }
>> +            offset +=3D unknown_extra_data_size;
>> +        }
>> +
>>          /* Read snapshot ID */
>>          sn->id_str =3D g_malloc(id_str_size + 1);
>>          ret =3D bdrv_pread(bs->file, offset, sn->id_str, id_str_size)=
;
>> @@ -161,7 +183,7 @@ static int qcow2_write_snapshots(BlockDriverState =
*bs)
>>          sn =3D s->snapshots + i;
>>          offset =3D ROUND_UP(offset, 8);
>>          offset +=3D sizeof(h);
>> -        offset +=3D sizeof(extra);
>> +        offset +=3D MAX(sizeof(extra), sn->extra_data_size);
>>          offset +=3D strlen(sn->id_str);
>>          offset +=3D strlen(sn->name);
>> =20
>> @@ -208,7 +230,8 @@ static int qcow2_write_snapshots(BlockDriverState =
*bs)
>>          h.date_sec =3D cpu_to_be32(sn->date_sec);
>>          h.date_nsec =3D cpu_to_be32(sn->date_nsec);
>>          h.vm_clock_nsec =3D cpu_to_be64(sn->vm_clock_nsec);
>> -        h.extra_data_size =3D cpu_to_be32(sizeof(extra));
>> +        h.extra_data_size =3D cpu_to_be32(MAX(sizeof(extra),
>> +                                            sn->extra_data_size));
>> =20
>>          memset(&extra, 0, sizeof(extra));
>>          extra.vm_state_size_large =3D cpu_to_be64(sn->vm_state_size);=

>> @@ -233,6 +256,22 @@ static int qcow2_write_snapshots(BlockDriverState=
 *bs)
>>          }
>>          offset +=3D sizeof(extra);
>> =20
>> +        if (sn->extra_data_size > sizeof(extra)) {
>> +            size_t unknown_extra_data_size =3D
>> +                sn->extra_data_size - sizeof(extra);
>> +
>> +            /* qcow2_read_snapshots() ensures no unbounded allocation=
 */
>> +            assert(unknown_extra_data_size <=3D INT_MAX);
>=20
> Should we make this tighter:
>  assert(unknown_extra_data_size < QCOW_MAX_SNAPSHOT_EXTRA_DATA);
> or even
>  assert(unknown_extra_data_size <=3D
>         QCOW_MAX_SNAPSHOT_EXTRA_DATA - sizeof(extra));

Hm, I wanted to signal that it can fit into the int taken by
bdrv_pwrite().  But then I should use BDRV_REQUEST_MAX_BYTES, actually.

I=E2=80=99m not sure.  It doesn=E2=80=99t really matter that it=E2=80=99s=
 less than
QCOW_MAX_SNAPSHOT_EXTRA_DATA here.  What does matter is that it doesn=E2=80=
=99t
exceed BDRV_REQUEST_MAX_BYTES.

>> +            assert(sn->unknown_extra_data);
>> +
>> +            ret =3D bdrv_pwrite(bs->file, offset, sn->unknown_extra_d=
ata,
>> +                              unknown_extra_data_size);
>> +            if (ret < 0) {
>> +                goto fail;
>> +            }
>> +            offset +=3D unknown_extra_data_size;
>> +        }
>> +
>>          ret =3D bdrv_pwrite(bs->file, offset, sn->id_str, id_str_size=
);
>>          if (ret < 0) {
>>              goto fail;
>> @@ -375,6 +414,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QE=
MUSnapshotInfo *sn_info)
>>      sn->date_sec =3D sn_info->date_sec;
>>      sn->date_nsec =3D sn_info->date_nsec;
>>      sn->vm_clock_nsec =3D sn_info->vm_clock_nsec;
>> +    sn->extra_data_size =3D sizeof(QCowSnapshotExtraData);
>> =20
>>      /* Allocate the L1 table of the snapshot and copy the current one=
 there. */
>>      l1_table_offset =3D qcow2_alloc_clusters(bs, s->l1_size * sizeof(=
uint64_t));
>> @@ -646,6 +686,7 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
>>       * The snapshot is now unused, clean up. If we fail after this po=
int, we
>>       * won't recover but just leak clusters.
>>       */
>> +    g_free(sn.unknown_extra_data);
>>      g_free(sn.id_str);
>>      g_free(sn.name);
>> =20
>>
>=20
> Tweaks to assertions are minor enough that I'm okay with:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for reviewing!

Max


--x3igIX339uJ0FKqGlQnio1ArvjV0Brws0--

--mlDAKq0YSqucVBDOLCWWAJIfmlYvkO8OH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1BV1YACgkQ9AfbAGHV
z0BX+gf8DfOWC9C+W+kwwzG46YeJ4FBXholwptfgEF873Irg3M9BbPwSBpVt54Hq
rxLfVVeL6kv/BHpj5RQ/sJOS/B39ad+Y/+9tMAgdbla21gxOlNchSMQn8WZ0jRrB
aJnGHg3dXXKVDCBThw3xYaOX2FvX13016ZQLhIvTAGeXS+aq9nZZLF2YTFeGaQeY
W4w3LHH6bwWqrOsgNWnOhuDBj+5hsCGcH8C8EcV8q/po3goTNQmrIC/pz6qnzXzt
62+fFZzb9GSXL1WpFnDggEFVFGfRIOMLHDSoYOXaya+16jW8cbfRDViDl1xCQuNJ
L63D5yWUo0w40ZGk6YMdu350Jn272g==
=3IIg
-----END PGP SIGNATURE-----

--mlDAKq0YSqucVBDOLCWWAJIfmlYvkO8OH--

