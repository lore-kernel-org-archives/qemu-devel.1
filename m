Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21108C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF60E20989
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF60E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40661 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgZT-0003vD-4Q
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:11:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVgYK-0003Rt-Mz
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:10:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVgYI-0004Eo-N6
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVgYB-0002ki-Oh; Tue, 28 May 2019 14:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6CCC3019882;
	Tue, 28 May 2019 18:09:12 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E3EC1001943;
	Tue, 28 May 2019 18:09:11 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-4-mreitz@redhat.com>
	<5fd51d1a-c9a9-f310-a3a3-369b2c1c27d0@virtuozzo.com>
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
Message-ID: <283400db-a7bb-7952-d83a-c49a2936b01b@redhat.com>
Date: Tue, 28 May 2019 20:09:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5fd51d1a-c9a9-f310-a3a3-369b2c1c27d0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dcEu0WeGa6Y6fryT7soaSROlvsnLARiTB"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 28 May 2019 18:09:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 03/11] block: Storage child access
 function
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dcEu0WeGa6Y6fryT7soaSROlvsnLARiTB
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <283400db-a7bb-7952-d83a-c49a2936b01b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 03/11] block: Storage child access
 function
References: <20190410202033.28617-1-mreitz@redhat.com>
 <20190410202033.28617-4-mreitz@redhat.com>
 <5fd51d1a-c9a9-f310-a3a3-369b2c1c27d0@virtuozzo.com>
In-Reply-To: <5fd51d1a-c9a9-f310-a3a3-369b2c1c27d0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.05.19 12:41, Vladimir Sementsov-Ogievskiy wrote:
> 10.04.2019 23:20, Max Reitz wrote:
>> For completeness' sake, add a function for accessing a node's storage
>> child, too.  For filters, this is their filtered child; for non-filter=
s,
>> this is bs->file.
>>
>> Some places are deliberately left unconverted:
>> - BDS opening/closing functions where bs->file is handled specially
>>    (which is basically wrong, but at least simplifies probing)
>> - bdrv_co_block_status_from_file(), because its name implies that it
>>    points to ->file
>> - bdrv_snapshot_goto() in one places unrefs bs->file.  Such a
>>    modification is not covered by this patch and is therefore just
>>    safeguarded by an additional assert(), but otherwise kept as-is.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>

[...]

>> --- a/block/snapshot.c
>> +++ b/block/snapshot.c
>=20
> [..]
>=20
>> @@ -184,6 +186,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>>                          Error **errp)
>>   {
>>       BlockDriver *drv =3D bs->drv;
>> +    BlockDriverState *storage_bs;
>>       int ret, open_ret;
>>  =20
>>       if (!drv) {
>> @@ -204,39 +207,40 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>>           return ret;
>>       }
>>  =20
>> -    if (bs->file) {
>> -        BlockDriverState *file;
>> +    storage_bs =3D bdrv_storage_bs(bs);
>> +    if (storage_bs) {
>>           QDict *options =3D qdict_clone_shallow(bs->options);
>>           QDict *file_options;
>>           Error *local_err =3D NULL;
>>  =20
>> -        file =3D bs->file->bs;
>>           /* Prevent it from getting deleted when detached from bs */
>> -        bdrv_ref(file);
>> +        bdrv_ref(storage_bs);
>>  =20
>>           qdict_extract_subqdict(options, &file_options, "file.");
>>           qobject_unref(file_options);
>> -        qdict_put_str(options, "file", bdrv_get_node_name(file));
>> +        qdict_put_str(options, "file", bdrv_get_node_name(storage_bs)=
);
>>  =20
>>           if (drv->bdrv_close) {
>>               drv->bdrv_close(bs);
>>           }
>> +
>> +        assert(bs->file->bs =3D=3D storage_bs);
>=20
> Hmm, but what save us from this assertion fail for backing-filters? Bef=
ore your
> patch it was unreachable for them. Or what I miss?

Ha, good point.  I simply missed this point.  Yes, I need to check
whether storage_bs is bs->file or bs->backing and then take the
corresponding sub-QDict from bs->options.

Max

>>           bdrv_unref_child(bs, bs->file);
>>           bs->file =3D NULL;
>>  =20
>> -        ret =3D bdrv_snapshot_goto(file, snapshot_id, errp);
>> +        ret =3D bdrv_snapshot_goto(storage_bs, snapshot_id, errp);
>>           open_ret =3D drv->bdrv_open(bs, options, bs->open_flags, &lo=
cal_err);
>>           qobject_unref(options);
>>           if (open_ret < 0) {
>> -            bdrv_unref(file);
>> +            bdrv_unref(storage_bs);
>>               bs->drv =3D NULL;
>>               /* A bdrv_snapshot_goto() error takes precedence */
>>               error_propagate(errp, local_err);
>>               return ret < 0 ? ret : open_ret;
>>           }
>>  =20
>> -        assert(bs->file->bs =3D=3D file);
>> -        bdrv_unref(file);
>> +        assert(bs->file->bs =3D=3D storage_bs);
>> +        bdrv_unref(storage_bs);
>>           return ret;
>>       }
>>  =20
>=20
>=20
>=20



--dcEu0WeGa6Y6fryT7soaSROlvsnLARiTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzteUUACgkQ9AfbAGHV
z0CpWwgAuq0436qWbpi4UQBbSX/Xrfx67R2Vso6SZaloE8HoW28HUo2/4Jg2xpvZ
JThc8q+i7vfwMegkwM/Fp/PmOyR+E63hnz5kVewzYvA2gxxNBi498TAHVpJ/NbCd
xDNcsVKQQK8sPmRU7sv39Fl8glDB3VYyB4bpWZRelzTf53jfjP8YwAOIKaIdPT/u
8T7FKd9xbCQNNdbEjWX1Lo0uZMO24jVYbW5ak491Ns2IHIE9Vw5hOecQgue0HJKY
fRQSYKJYusuDj54rta8W1E9v1Jvmz7OKZ8F0mZYMX3fo7hR/CUqPIViov6wMKHx+
OVSP2GnuxNmMU4148O7M2PjdPjm9Nw==
=hNVS
-----END PGP SIGNATURE-----

--dcEu0WeGa6Y6fryT7soaSROlvsnLARiTB--

