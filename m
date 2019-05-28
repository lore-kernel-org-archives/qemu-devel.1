Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94530C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5222081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5222081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVb4P-0002cH-KV
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:19:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVb3T-0002CK-7v
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVb3R-0001N8-IL
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVb3B-00010a-IF; Tue, 28 May 2019 08:17:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C56B3B554;
	Tue, 28 May 2019 12:17:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 354CC5D6A9;
	Tue, 28 May 2019 12:17:11 +0000 (UTC)
To: Sam Eiderman <shmuel.eiderman@oracle.com>
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
	<20190424074901.31430-3-shmuel.eiderman@oracle.com>
	<8a27479f-3948-df17-5abc-0c22811ae4b2@redhat.com>
	<AF0444E6-AE0A-4ADC-A1D5-487775E076A6@oracle.com>
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
Message-ID: <dd62f69d-8984-6f5e-0953-e312e469bc03@redhat.com>
Date: Tue, 28 May 2019 14:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AF0444E6-AE0A-4ADC-A1D5-487775E076A6@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RJ4tZbjlrxPNrnKHoEgR0ORfhGxyxMBuX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 28 May 2019 12:17:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] vmdk: Add read-only support for
 seSparse snapshots
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
Cc: fam@euphon.net, kwolf@redhat.com, eyal.moscovici@oracle.com,
	qemu-block@nongnu.org, arbel.moshe@oracle.com,
	qemu-devel@nongnu.org, liran.alon@oracle.com,
	Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RJ4tZbjlrxPNrnKHoEgR0ORfhGxyxMBuX
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <shmuel.eiderman@oracle.com>
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 arbel.moshe@oracle.com, Karl Heubaum <karl.heubaum@oracle.com>,
 eyal.moscovici@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Message-ID: <dd62f69d-8984-6f5e-0953-e312e469bc03@redhat.com>
Subject: Re: [PATCH 2/2] vmdk: Add read-only support for seSparse snapshots
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
 <20190424074901.31430-3-shmuel.eiderman@oracle.com>
 <8a27479f-3948-df17-5abc-0c22811ae4b2@redhat.com>
 <AF0444E6-AE0A-4ADC-A1D5-487775E076A6@oracle.com>
In-Reply-To: <AF0444E6-AE0A-4ADC-A1D5-487775E076A6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.05.19 09:57, Sam Eiderman wrote:
> Comments inline
>=20
>> On 27 May 2019, at 20:39, Max Reitz <mreitz@redhat.com
>> <mailto:mreitz@redhat.com>> wrote:
>>
>> On 24.04.19 09:49, Sam Eiderman wrote:

[...]

>>> @@ -498,10 +543,15 @@ static int vmdk_init_tables(BlockDriverState
>>> *bs, VmdkExtent *extent,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto fail_l1;
>>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>> =C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < extent->l1_size; i++) {
>>> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0le32_to_cpus(&extent->l1_=
table[i]);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (extent->sesparse) {
>>
>> Shouldn=E2=80=99t matter in practice, but I think evaluating extent->e=
ntry_size
>> would be more natural.
>=20
> I just wanted to make it more clear that we are dealing with the
> seSparse format.
> But maybe in this case I should evaluate extent->entry_size and add
> assert on
> extent->sesparse inside the uint64_t case?
> WDYT?

I think that this code works independently of whether it=E2=80=99s dealin=
g with
the seSparse format or something else.  All that matters is the L1 entry
size.  If some day there is another VMDK sub format that has 64-bit L1
entries, too, this code will be ready for it.

(It=E2=80=99s a different matter when interpreting e.g. L2 entries, becau=
se
their encoding may differ depending on the sub format.)

>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l=
e64_to_cpus((uint64_t *)extent->l1_table + i);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0l=
e32_to_cpus((uint32_t *)extent->l1_table + i);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>>

[...]

>>> + =C2=A0=C2=A0=C2=A0if (header->journal_header_offset !=3D 2) {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "Unsuppo=
rted journal header offset: %" PRIu64,
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->journal_header_offset);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOTSUP;
>>> + =C2=A0=C2=A0=C2=A0}
>>> +
>>> + =C2=A0=C2=A0=C2=A0if (header->journal_header_size !=3D 2) {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "Unsuppo=
rted journal header size: %" PRIu64,
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->journal_header_size);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOTSUP;
>>> + =C2=A0=C2=A0=C2=A0}
>>> +
>>> + =C2=A0=C2=A0=C2=A0if (header->journal_offset !=3D 2048) {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "Unsuppo=
rted journal offset: %" PRIu64,
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->journal_offset);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOTSUP;
>>> + =C2=A0=C2=A0=C2=A0}
>>> +
>>> + =C2=A0=C2=A0=C2=A0if (header->journal_size !=3D 2048) {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "Unsuppo=
rted journal size: %" PRIu64,
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->journal_size);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOTSUP;
>>> + =C2=A0=C2=A0=C2=A0}
>>> +
>>> + =C2=A0=C2=A0=C2=A0if (header->grain_dir_offset !=3D 4096) {
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, "Unsuppo=
rted grain directory offset: %" PRIu64,
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0header->grain_dir_offset);
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOTSUP;
>>> + =C2=A0=C2=A0=C2=A0}
>>
>> Do these values (metadata structure offsets and sizes) really matter?
>=20
> Not really, these are the values that I saw appear in 10MB, 150GB and 6=
TB
> snapshots, they never change.
> All of the checks in this function are just for =E2=80=9Cstrictness=E2=80=
=9D and can be
> removed.
> I just wanted to include them at least in the v1 series to make the
> format more
> clear and to not support vmdk's that give other values under the assump=
tion
> that the format might misbehave in other parts too.
> They can be removed (maybe I=E2=80=99ll keep the version check in any c=
ase) or we
> can keep them and remove them at any later point.
> WDYT?

I=E2=80=99d remove them.  Because this patch only adds read-only support,=
 there
is no danger of corrupting data.  The worst that can happen is reading
wrong data from some file that with these checks we just wouldn=E2=80=99t=
 read
at all.

>>> + =C2=A0=C2=A0=C2=A0/* in sectors */
>>> + =C2=A0=C2=A0=C2=A0grain_table_coverage =3D ((header->grain_table_si=
ze *
>>
>> Hm, if header->grain_table_size is measured in sectors, it=E2=80=99d p=
robably be
>> better to rename it to grain_table_sectors or something.
>>
>> (=E2=80=9Csize=E2=80=9D is usually in bytes; sometimes it=E2=80=99s th=
e number of entries, but
>> that=E2=80=99s already kind of weird, I think)
>=20
> grain_table_sectors is not a good name since it is not the number of se=
ctors
> a grain table uses but the number of sectors it covers.

I meant renaming header->grain_table_size to
header->grain_table_sectors.  grain_table_coverage seems good to me.

But from your answer about the volatile header it appears like
header->grain_table_size might be the official name.  If so, I guess
it=E2=80=99ll be fine as it is.

> grain_table_coverage_sectors is a better name but a bit too long.
> I can change grain_table_* to gt_* and grain_dir_* to gd_* but they see=
m too
> similar and confusing.
> WDYT?
>=20
>>
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BDRV_SECTOR_SIZE / sizeof(uint64_t)) *
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0header->grain_size);
>>> + =C2=A0=C2=A0=C2=A0needed_grain_tables =3D header->capacity / grain_=
table_coverage;
>>> + =C2=A0=C2=A0=C2=A0needed_grain_dir_size =3D DIV_ROUND_UP(needed_gra=
in_tables *
>>> sizeof(uint64_t),
>>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0BDRV_SECTOR_SIZE);
>>> + =C2=A0=C2=A0=C2=A0needed_grain_dir_size =3D ROUND_UP(needed_grain_d=
ir_size, 2048);
>>> +
>>> + =C2=A0=C2=A0=C2=A0if (header->grain_dir_size !=3D needed_grain_dir_=
size) {
>>
>> Wouldn=E2=80=99t it suffice to check that header->grain_dir_size >=3D
>> needed_grain_dir_size? =C2=A0(The ROUND_UP() would become unnecessary,=
 then.)
>>
>> (And also, maybe s/grain_dir_size/grain_dir_sectors/)
>=20
> This is how VMware works - they round up the size to 2048 sectors for t=
he
> needed_grain_dir_sectors - so I just make sure the math adds up.
> As said before, all of these checks are just for =E2=80=9Cstrictness=E2=
=80=9D.

The thing is, I don=E2=80=99t know whether this is part of the specificat=
ion of
seSparse or just part of VMware=E2=80=99s implementation.  When qemu incr=
eases
the qcow2 L1 table size, it has a specific algorithm for that
(current size * 1.5).  But that doesn=E2=80=99t make it part of the qcow2=

specification, any size is fine.  Similarly, I can imagine that VMware
simply chose to increase the L1 size in units of 1 MB (so it doesn=E2=80=99=
t
need to be grown very often), but that it can work with any size.

Max


--RJ4tZbjlrxPNrnKHoEgR0ORfhGxyxMBuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlztJsYACgkQ9AfbAGHV
z0CCYwf/ffOYU9Y79d6IZeJvAxIJNVht1cYELdj1wegKEgnDVl4HdVfS69LFHCm6
fRE8O+bW1+b0O6MxSvQq5FGOVHgcQVO9VdB2BPZgAOl/r/TNJk5qynExzAt4dNLb
mjsswjau+khNsWX4zzTBoKQ3SYaXvZ92cV3+8Za+lhKuA0J9/7wfsSXdTyF8o4yW
GaCW7UiJdv4mn2HiJBO9WswS87H/cwKClS0vRuf5S9P0J/8Uc6e0rJZUPqtgUaJM
Wkk4Ewg/W+QEeenWrRQ+Zx5KTijR+BZCHcWqQGOn8RItYH3z6uxVVEWXhcL07/mN
3ZUj54/gdLXB4nR4a2ic2ccHMiOTLw==
=0fb7
-----END PGP SIGNATURE-----

--RJ4tZbjlrxPNrnKHoEgR0ORfhGxyxMBuX--

