Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22C12225A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5O8LLIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22C12225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT55C-0007L4-No
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 11:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT51t-0004EK-Bf
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT51q-0005dT-2k
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 11:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602775131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tnnq/TmyZkocbjqzCw6/g4s6h/5BocGDs43INf1pdnQ=;
 b=D5O8LLIxvODFj9iHp8QcCSzZwBU5IHNojfuoxUZS+dbPwXLuZKG/xmBanG4yWD0r69jTKN
 aNJZe40b8olv8iar0LDyDWKfPCJYMeYdt1RFSTxhlEIlJhQIBi3gvQeVb2FkxUm4PIQ8fg
 TevNqo5NBdM9XlCfnPaIl7Wwh0XxxEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Hl9K36XEOv-XxfntxJNPDg-1; Thu, 15 Oct 2020 11:18:49 -0400
X-MC-Unique: Hl9K36XEOv-XxfntxJNPDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D4D09CC04;
 Thu, 15 Oct 2020 15:18:48 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 873E05D9D5;
 Thu, 15 Oct 2020 15:18:43 +0000 (UTC)
Subject: Re: [PATCH v2 03/20] fuse: Implement standard FUSE operations
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20200922104932.46384-4-mreitz@redhat.com>
 <20201015094622.GC4610@merkur.fritz.box>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <34828933-5ac1-ba04-39e8-eeaef604f5b0@redhat.com>
Date: Thu, 15 Oct 2020 17:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015094622.GC4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IhNZOEfmf3g88IvMUeNqc7CvvCx2MHQoE"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhNZOEfmf3g88IvMUeNqc7CvvCx2MHQoE
Content-Type: multipart/mixed; boundary="0WAvOyHVe8O8NrUw4BofG8LaWzbC21ZVm"

--0WAvOyHVe8O8NrUw4BofG8LaWzbC21ZVm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 11:46, Kevin Wolf wrote:
> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>> This makes the export actually useful instead of only producing errors
>> whenever it is accessed.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/export/fuse.c | 226 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 226 insertions(+)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 75f11d2514..8fc667231d 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -32,6 +32,10 @@
>>  #include <fuse_lowlevel.h>
>> =20
>> =20
>> +/* Prevent overly long bounce buffer allocations */
>> +#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * =
1024))
>> +
>> +
>>  typedef struct FuseExport {
>>      BlockExport common;
>> =20
>> @@ -241,7 +245,229 @@ static bool is_regular_file(const char *path, Erro=
r **errp)
>>      return true;
>>  }
>> =20
>> +
>> +/**
>> + * Let clients look up files.  Always return ENOENT because we only
>> + * care about the mountpoint itself.
>> + */
>> +static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *=
name)
>> +{
>> +    fuse_reply_err(req, ENOENT);
>> +}
>> +
>> +/**
>> + * Let clients get file attributes (i.e., stat() the file).
>> + */
>> +static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
>> +                         struct fuse_file_info *fi)
>> +{
>> +    struct stat statbuf;
>> +    int64_t length, allocated_blocks;
>> +    time_t now =3D time(NULL);
>> +    ImageInfo *info =3D NULL;
>> +    FuseExport *exp =3D fuse_req_userdata(req);
>> +    mode_t mode;
>> +    Error *local_error =3D NULL;
>> +
>> +    length =3D blk_getlength(exp->common.blk);
>> +    if (length < 0) {
>> +        fuse_reply_err(req, -length);
>> +        return;
>> +    }
>> +
>> +    bdrv_query_image_info(blk_bs(exp->common.blk), &info, &local_error)=
;
>> +    if (local_error) {
>> +        allocated_blocks =3D DIV_ROUND_UP(length, 512);
>> +    } else {
>> +        allocated_blocks =3D DIV_ROUND_UP(info->actual_size, 512);
>> +    }
>> +
>> +    qapi_free_ImageInfo(info);
>> +    error_free(local_error);
>> +    local_error =3D NULL;
>=20
> If you only use info->actual_size, why not directly call
> bdrv_get_allocated_file_size()?

=F0=9F=A4=94

Sometimes one doesn=E2=80=99t think of the simplest things.

>> +
>> +    mode =3D S_IFREG | S_IRUSR;
>> +    if (exp->writable) {
>> +        mode |=3D S_IWUSR;
>> +    }
>> +
>> +    statbuf =3D (struct stat) {
>> +        .st_ino     =3D inode,
>> +        .st_mode    =3D mode,
>> +        .st_nlink   =3D 1,
>> +        .st_uid     =3D getuid(),
>> +        .st_gid     =3D getgid(),
>> +        .st_size    =3D length,
>> +        .st_blksize =3D blk_bs(exp->common.blk)->bl.request_alignment,
>> +        .st_blocks  =3D allocated_blocks,
>> +        .st_atime   =3D now,
>> +        .st_mtime   =3D now,
>> +        .st_ctime   =3D now,
>> +    };
>> +
>> +    fuse_reply_attr(req, &statbuf, 1.);
>> +}
>> +
>> +static int fuse_do_truncate(const FuseExport *exp, int64_t size,
>> +                            PreallocMode prealloc)
>> +{
>> +    uint64_t blk_perm, blk_shared_perm;
>> +    int ret;
>> +
>> +    blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
>> +
>> +    ret =3D blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
>> +                       blk_shared_perm, NULL);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    ret =3D blk_truncate(exp->common.blk, size, true, prealloc, 0, NULL=
);
>> +
>> +    /* Must succeed, because we are only giving up the RESIZE permissio=
n */
>> +    blk_set_perm(exp->common.blk, blk_perm, blk_shared_perm, &error_abo=
rt);
>> +
>> +    return ret;
>> +}
>> +
>> +/**
>> + * Let clients set file attributes.  Only resizing is supported.
>> + */
>> +static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat =
*statbuf,
>> +                         int to_set, struct fuse_file_info *fi)
>> +{
>> +    FuseExport *exp =3D fuse_req_userdata(req);
>> +    int ret;
>> +
>> +    if (!exp->writable) {
>> +        fuse_reply_err(req, EACCES);
>> +        return;
>> +    }
>> +
>> +    if (to_set & ~FUSE_SET_ATTR_SIZE) {
>> +        fuse_reply_err(req, ENOTSUP);
>> +        return;
>> +    }
>> +
>> +    ret =3D fuse_do_truncate(exp, statbuf->st_size, PREALLOC_MODE_OFF);
>> +    if (ret < 0) {
>> +        fuse_reply_err(req, -ret);
>> +        return;
>> +    }
>> +
>> +    fuse_getattr(req, inode, fi);
>> +}
>> +
>> +/**
>> + * Let clients open a file (i.e., the exported image).
>> + */
>> +static void fuse_open(fuse_req_t req, fuse_ino_t inode,
>> +                      struct fuse_file_info *fi)
>> +{
>> +    fuse_reply_open(req, fi);
>> +}
>> +
>> +/**
>> + * Handle client reads from the exported image.
>> + */
>> +static void fuse_read(fuse_req_t req, fuse_ino_t inode,
>> +                      size_t size, off_t offset, struct fuse_file_info =
*fi)
>> +{
>> +    FuseExport *exp =3D fuse_req_userdata(req);
>> +    int64_t length;
>> +    void *buf;
>> +    int ret;
>> +
>> +    /**
>> +     * Clients will expect short reads at EOF, so we have to limit
>> +     * offset+size to the image length.
>> +     */
>> +    length =3D blk_getlength(exp->common.blk);
>> +    if (length < 0) {
>> +        fuse_reply_err(req, -length);
>> +        return;
>> +    }
>> +
>> +    size =3D MIN(size, FUSE_MAX_BOUNCE_BYTES);
>=20
> "Read should send exactly the number of bytes requested except on EOF or
> error, otherwise the rest of the data will be substituted with zeroes."

:(

> Do we corrupt huge reads with this, so that read() succeeds, but the
> buffer is zeroed above 64M instead of containing the correct data? Maybe
> we should return an error instead?

Hm.  It looks like there is a max_read option obeyed by the kernel
driver, and it appears it=E2=80=99s set by implementing .init() and setting
fuse_conn_info.max_read (also, =E2=80=9Cfor the time being=E2=80=9D it has =
to also set
in the mount options passed to fuse_session_new()).

I=E2=80=99m not sure whether that does anything, though.  It appears that
whenever I do a cached read, it caps out at 128k (which is what
cuse_prep_data() in libfuse sets; though increasing that number there
doesn=E2=80=99t change anything, so I think that=E2=80=99s just a coinciden=
ce), and with
O_DIRECT, it caps out at 1M.

But at least that would be grounds to return an error for >64M requests.
 (Limiting max_read to 64k does limit all read requests to 64k.)

Further investigation is needed.

> (It's kind of sad that we need a bounce buffer from which data is later
> copied instead of being provided the right memory by the kernel.)

Yes, it is.

>> +    if (offset + size > length) {
>> +        size =3D length - offset;
>> +    }
>> +
>> +    buf =3D qemu_try_blockalign(blk_bs(exp->common.blk), size);
>> +    if (!buf) {
>> +        fuse_reply_err(req, ENOMEM);
>> +        return;
>> +    }
>> +
>> +    ret =3D blk_pread(exp->common.blk, offset, buf, size);
>> +    if (ret >=3D 0) {
>> +        fuse_reply_buf(req, buf, size);
>> +    } else {
>> +        fuse_reply_err(req, -ret);
>> +    }
>> +
>> +    qemu_vfree(buf);
>> +}
>> +
>> +/**
>> + * Handle client writes to the exported image.
>> + */
>> +static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *bu=
f,
>> +                       size_t size, off_t offset, struct fuse_file_info=
 *fi)
>> +{
>> +    FuseExport *exp =3D fuse_req_userdata(req);
>> +    int64_t length;
>> +    int ret;
>> +
>> +    if (!exp->writable) {
>> +        fuse_reply_err(req, EACCES);
>> +        return;
>> +    }
>> +
>> +    /**
>> +     * Clients will expect short writes at EOF, so we have to limit
>> +     * offset+size to the image length.
>> +     */
>> +    length =3D blk_getlength(exp->common.blk);
>> +    if (length < 0) {
>> +        fuse_reply_err(req, -length);
>> +        return;
>> +    }
>> +
>> +    size =3D MIN(size, BDRV_REQUEST_MAX_BYTES);
>=20
> We're only supposed to do short writes on EOF, so this has a similar
> problem as in fuse_read, except that BDRV_REQUEST_MAX_BYTES is much
> higher and it's not specified what the resulting misbehaviour could be
> (possibly the kernel not retrying write for the rest of the buffer?)

As for reading above, we can (and should) probably set max_write.

>> +    if (offset + size > length) {
>> +        size =3D length - offset;
>> +    }
>> +
>> +    ret =3D blk_pwrite(exp->common.blk, offset, buf, size, 0);
>> +    if (ret >=3D 0) {
>> +        fuse_reply_write(req, size);
>> +    } else {
>> +        fuse_reply_err(req, -ret);
>> +    }
>> +}
>> +
>> +/**
>> + * Let clients flush the exported image.
>> + */
>> +static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
>> +                       struct fuse_file_info *fi)
>> +{
>> +    FuseExport *exp =3D fuse_req_userdata(req);
>> +    int ret;
>> +
>> +    ret =3D blk_flush(exp->common.blk);
>> +    fuse_reply_err(req, ret < 0 ? -ret : 0);
>> +}
>=20
> This seems to be an implementation for .fsync rather than for .flush.

Wouldn=E2=80=99t fsync entail a drain?

Or is it the opposite, flush should just drain and not invoke
blk_flush()?  (Sorry, this all gets me confused every time.)

(Though I do think .fsync should both flush and drain.)

> Hmm, or maybe actually for both? We usually do bdrv_flush() during
> close, so it would be consistent to do the same here. It's our last
> chance to report an error to the user before the file is closed.

I don=E2=80=99t understand what you mean.  What is =E2=80=9Cthe same=E2=80=
=9D?  Closing the
image?  Or indeed having .flush() be implemented with blk_flush()?

Do you mean that other parties may do the same as qemu does, i.e. flush
files before they are closed, which is why we should anticipate the same
and give users a chance to see errors?

Max


--0WAvOyHVe8O8NrUw4BofG8LaWzbC21ZVm--

--IhNZOEfmf3g88IvMUeNqc7CvvCx2MHQoE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IaFEACgkQ9AfbAGHV
z0AFYAf/VkOFgKgu35KDU7qPYQyyf5HvNwlthiS3sNFbzAw6Y6Yzh4X1+qADMh8J
oHGLFoECmqtae1b2EfvjhiAhyXc/8hu5bZG2+VIKe9vtKKuSXphnhzc52TnEfwbP
PDsjnATLx07rB7p0eaw4+CjleTrQwwXQOMj43ZzIuZMfIL2J12xbsjFCEstX06EU
6sR4YJMWM89M+egN6gYWVvJysdfW3j8QqHSzUVaeX2zckddQgNzVn7X+Nq64o1rK
1Eyp2sOWNErHOQgJAMr3+1QsV3xl9cXm3FKDJ8M8oK+wDV/bX6mLt3plIZFa/blH
9aiC02izXHF6NyCuX+z3cDTG97gxcQ==
=IkX2
-----END PGP SIGNATURE-----

--IhNZOEfmf3g88IvMUeNqc7CvvCx2MHQoE--


