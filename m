Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A609C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2EC206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2EC206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nkC-0003Mo-Rn
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i9ngw-00089I-SJ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i9ngv-0000Pm-2F
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i9ngr-0000Mf-7g; Mon, 16 Sep 2019 05:53:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 802D4307D965;
 Mon, 16 Sep 2019 09:53:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85B7E10018FF;
 Mon, 16 Sep 2019 09:52:58 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
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
Message-ID: <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
Date: Mon, 16 Sep 2019 11:52:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LP96BdgDZ1ew2WAqPyU1Nd5Av9zLNJFUC"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 16 Sep 2019 09:53:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 28/42] stream: Deal with filters
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LP96BdgDZ1ew2WAqPyU1Nd5Av9zLNJFUC
Content-Type: multipart/mixed; boundary="a8xhoDHd6swaDSTR3pYA8M3ssPdJ8XXKr";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
Subject: Re: [PATCH v6 28/42] stream: Deal with filters
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190913141653.GH8312@dhcp-200-226.str.redhat.com>

--a8xhoDHd6swaDSTR3pYA8M3ssPdJ8XXKr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 16:16, Kevin Wolf wrote:
> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>> Because of the recent changes that make the stream job independent of
>> the base node and instead track the node above it, we have to split th=
at
>> "bottom" node into two cases: The bottom COW node, and the node direct=
ly
>> above the base node (which may be an R/W filter or the bottom COW node=
).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-core.json |  4 ++++
>>  block/stream.c       | 52 ++++++++++++++++++++++++++++---------------=
-
>>  blockdev.c           |  2 +-
>>  3 files changed, 38 insertions(+), 20 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 38c4dbd7c3..3c54717870 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2516,6 +2516,10 @@
>>  # On successful completion the image file is updated to drop the back=
ing file
>>  # and the BLOCK_JOB_COMPLETED event is emitted.
>>  #
>> +# In case @device is a filter node, block-stream modifies the first n=
on-filter
>> +# overlay node below it to point to base's backing node (or NULL if @=
base was
>> +# not specified) instead of modifying @device itself.
>> +#
>>  # @job-id: identifier for the newly-created block job. If
>>  #          omitted, the device name will be used. (Since 2.7)
>>  #
>> diff --git a/block/stream.c b/block/stream.c
>> index 4c8b89884a..bd4a351dae 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -31,7 +31,8 @@ enum {
>> =20
>>  typedef struct StreamBlockJob {
>>      BlockJob common;
>> -    BlockDriverState *bottom;
>> +    BlockDriverState *bottom_cow_node;
>> +    BlockDriverState *above_base;
>=20
> Confusing naming, especially because in commit you used above_base for
> what is bottom_cow_node here. Vladimir already suggested using
> base_overlay consistently, so we should do this here too (for
> bottom_cow_node). above_base can keep its name because the different
> above_base in commit is going to be renamed).

Sure.

>>      BlockdevOnError on_error;
>>      char *backing_file_str;
>>      bool bs_read_only;
>> @@ -54,7 +55,7 @@ static void stream_abort(Job *job)
>> =20
>>      if (s->chain_frozen) {
>>          BlockJob *bjob =3D &s->common;
>> -        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->bottom);
>> +        bdrv_unfreeze_chain(blk_bs(bjob->blk), s->above_base);
>>      }
>>  }
>> =20
>> @@ -63,14 +64,15 @@ static int stream_prepare(Job *job)
>>      StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.jo=
b);
>>      BlockJob *bjob =3D &s->common;
>>      BlockDriverState *bs =3D blk_bs(bjob->blk);
>> -    BlockDriverState *base =3D backing_bs(s->bottom);
>> +    BlockDriverState *unfiltered_bs =3D bdrv_skip_rw_filters(bs);
>> +    BlockDriverState *base =3D bdrv_filtered_bs(s->above_base);
>>      Error *local_err =3D NULL;
>>      int ret =3D 0;
>> =20
>> -    bdrv_unfreeze_chain(bs, s->bottom);
>> +    bdrv_unfreeze_chain(bs, s->above_base);
>>      s->chain_frozen =3D false;
>> =20
>> -    if (bs->backing) {
>> +    if (bdrv_filtered_cow_child(unfiltered_bs)) {
>>          const char *base_id =3D NULL, *base_fmt =3D NULL;
>>          if (base) {
>>              base_id =3D s->backing_file_str;
>> @@ -78,8 +80,8 @@ static int stream_prepare(Job *job)
>>                  base_fmt =3D base->drv->format_name;
>>              }
>>          }
>> -        bdrv_set_backing_hd(bs, base, &local_err);
>> -        ret =3D bdrv_change_backing_file(bs, base_id, base_fmt);
>> +        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>> +        ret =3D bdrv_change_backing_file(unfiltered_bs, base_id, base=
_fmt);
>>          if (local_err) {
>>              error_report_err(local_err);
>>              return -EPERM;
>> @@ -110,7 +112,8 @@ static int coroutine_fn stream_run(Job *job, Error=
 **errp)
>>      StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.jo=
b);
>>      BlockBackend *blk =3D s->common.blk;
>>      BlockDriverState *bs =3D blk_bs(blk);
>> -    bool enable_cor =3D !backing_bs(s->bottom);
>> +    BlockDriverState *unfiltered_bs =3D bdrv_skip_rw_filters(bs);
>> +    bool enable_cor =3D !bdrv_filtered_bs(s->above_base);
>>      int64_t len;
>>      int64_t offset =3D 0;
>>      uint64_t delay_ns =3D 0;
>> @@ -119,7 +122,7 @@ static int coroutine_fn stream_run(Job *job, Error=
 **errp)
>>      int64_t n =3D 0; /* bytes */
>>      void *buf;
>> =20
>> -    if (bs =3D=3D s->bottom) {
>> +    if (unfiltered_bs =3D=3D s->bottom_cow_node) {
>>          /* Nothing to stream */
>>          return 0;
>>      }
>> @@ -154,13 +157,14 @@ static int coroutine_fn stream_run(Job *job, Err=
or **errp)
>> =20
>>          copy =3D false;
>> =20
>> -        ret =3D bdrv_is_allocated(bs, offset, STREAM_BUFFER_SIZE, &n)=
;
>> +        ret =3D bdrv_is_allocated(unfiltered_bs, offset, STREAM_BUFFE=
R_SIZE, &n);
>>          if (ret =3D=3D 1) {
>>              /* Allocated in the top, no need to copy.  */
>>          } else if (ret >=3D 0) {
>>              /* Copy if allocated in the intermediate images.  Limit t=
o the
>>               * known-unallocated area [offset, offset+n*BDRV_SECTOR_S=
IZE).  */
>> -            ret =3D bdrv_is_allocated_above(backing_bs(bs), s->bottom=
, true,
>> +            ret =3D bdrv_is_allocated_above(bdrv_filtered_cow_bs(unfi=
ltered_bs),
>> +                                          s->bottom_cow_node, true,
>>                                            offset, n, &n);
>>              /* Finish early if end of backing file has been reached *=
/
>>              if (ret =3D=3D 0 && n =3D=3D 0) {
>> @@ -231,9 +235,16 @@ void stream_start(const char *job_id, BlockDriver=
State *bs,
>>      BlockDriverState *iter;
>>      bool bs_read_only;
>>      int basic_flags =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNC=
HANGED;
>> -    BlockDriverState *bottom =3D bdrv_find_overlay(bs, base);
>> +    BlockDriverState *bottom_cow_node =3D bdrv_find_overlay(bs, base)=
;
>> +    BlockDriverState *above_base;
>=20
> Do we need to check for bottom_cow_node =3D=3D NULL?
>=20
> I think you could get a bs that is a filter of bottom_cow_node, and the=
n
> bdrv_find_overlay() returns NULL and...

Ah, yes.  It isn=E2=80=99t even about the infinite loop, it=E2=80=99s jus=
t a case of
=E2=80=9CNothing to stream=E2=80=9D (if @bs is just a filter chain away f=
rom @base).

Also, I just noticed that bdrv_find_overlay() in the version of this
series won=E2=80=99t work if the BDS passed to it (@base here) is a filte=
r, so
that=E2=80=99s something else to be fixed.

>> -    if (bdrv_freeze_chain(bs, bottom, errp) < 0) {
>> +    /* Find the node directly above @base */
>> +    for (above_base =3D bottom_cow_node;
>> +         bdrv_filtered_bs(above_base) !=3D base;
>> +         above_base =3D bdrv_filtered_bs(above_base))
>> +    {}
>  =09
> ...bottom_cow_node =3D=3D NULL turns this into an endless loop.
>=20
>> +    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
>>          return;
>>      }
>=20
> Hm... This feels odd. There are two places where stopping to freeze the=

> chain would make obvious sense: At base, like we originally did; or at
> base_overlay, like we (intend to) do since commit c624b015, because we
> say that we don't actually mind if the user replaces the base image. I
> don't see how stopping at the first filter above base makes sense.
>=20
> So should this use bottom_cow_node/base_overlay instead of above_base?

I suppose I thought =E2=80=9CBetter be safe than sorry=E2=80=9D.

> You couldn't use StreamBlockJob.above_base any more then because it
> could change, but you also don't really need it anywhere. It's only use=
d
> for unfreezing (which would change) and for finding the base (you can
> still find bdrv_backing_chain_next(s->base_overlay)). I guess this woul=
d
> even be a code simplification.

Great, I=E2=80=99ll see to it.

>> @@ -261,16 +272,19 @@ void stream_start(const char *job_id, BlockDrive=
rState *bs,
>>       * disappear from the chain after this operation. The streaming j=
ob reads
>>       * every block only once, assuming that it doesn't change, so for=
bid writes
>>       * and resizes. Reassign the base node pointer because the backin=
g BS of the
>> -     * bottom node might change after the call to bdrv_reopen_set_rea=
d_only()
>> -     * due to parallel block jobs running.
>> +     * above_base node might change after the call to
>> +     * bdrv_reopen_set_read_only() due to parallel block jobs running=
=2E
>>       */
>> -    base =3D backing_bs(bottom);
>> -    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D ba=
cking_bs(iter)) {
>> +    base =3D bdrv_filtered_bs(above_base);
>=20
> We just calculated above_base such that it's the parent of base. Why
> would base not already have the value we're assigning it again here?

That=E2=80=99s no change to existing code, whose reasoning is explained i=
n the
comment above: bdrv_reopen_set_read_only() can yield, which might lead
to children of the bottom node changing.

If you feel like either that=E2=80=99s superfluous, or that if something =
like
that were to happen we=E2=80=99d have much bigger problems, be my guest t=
o drop
both.

But in this series I=E2=80=99d rather just not change it.

Max


--a8xhoDHd6swaDSTR3pYA8M3ssPdJ8XXKr--

--LP96BdgDZ1ew2WAqPyU1Nd5Av9zLNJFUC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1/W3cACgkQ9AfbAGHV
z0B3mgf/XRJuGDg7k+p4w1mIjQ6OBkw8O3vIMuODxlnyFiAv9Sm8XVcmNIZvoBql
RQRDDTBzEAYEMtzXQpfP0mHL/JySPTG5ryt24Ddllb/BoVg4vwO2WFlyCpRIWE0f
93xLeD6Y2lX2RpJNcBsqalnjHmGMw9cdzaJeoX0Tmuy+og/Ai4HZvSsW8I/QiFvC
sIByelEY5UtUmQy3j2XtxAnZ1yy4d2ua+PBFAC/dKl+34Ssgta1p5+SFIOrzRBwx
eZ5ubZYeho1d4rDyw6sRo+2B26MvKPFva3ZPVGDAU29XCtoTW4WKhncCufPYoxjC
18rOZa1/z568W1p9rYZ3w+1ga2VAqQ==
=gT82
-----END PGP SIGNATURE-----

--LP96BdgDZ1ew2WAqPyU1Nd5Av9zLNJFUC--

