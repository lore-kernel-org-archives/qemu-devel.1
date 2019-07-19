Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05158C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04A12186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04A12186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUy1-0006oz-3A
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hoUxq-0006ID-RB
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hoUxl-0002Mn-Cr
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hoUxM-0000cc-8u; Fri, 19 Jul 2019 11:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0165830BD1CC;
 Fri, 19 Jul 2019 15:34:47 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E3A26E6B;
 Fri, 19 Jul 2019 15:34:41 +0000 (UTC)
Date: Fri, 19 Jul 2019 16:34:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190719153440.GB24412@stefanha-x1.localdomain>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-5-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20190719133530.28688-5-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 15:34:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/14] block/io_uring: implements
 interfaces for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefan@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 07:05:20PM +0530, Aarushi Mehta wrote:
> diff --git a/block.c b/block.c
> index 29e931e217..4aa3500ad8 100644
> --- a/block.c
> +++ b/block.c
> @@ -844,6 +844,28 @@ static BlockdevDetectZeroesOptions bdrv_parse_detect=
_zeroes(QemuOpts *opts,
>      return detect_zeroes;
>  }
> =20
> +/**
> + * Set flags for aio engine

Other parse_*() functions are more specific about which type of flags
are produced:

s/flags/open flags/

> + *
> + * Return 0 on success, -1 if the engine specifies is invalid

s/specifies/specified/

> + */
> +int bdrv_parse_aio(const char *mode, int *flags)
> +{
> +    if (!strcmp(mode, "threads")) {
> +        /* do nothing, default */
> +    } else if (!strcmp(mode, "native")) {
> +        *flags |=3D BDRV_O_NATIVE_AIO;
> +#ifdef CONFIG_LINUX_IO_URING
> +    } else if (!strcmp(mode, "io_uring")) {
> +        *flags |=3D BDRV_O_IO_URING;
> +#endif
> +    } else {
> +        return -1;
> +    }
> +
> +    return 0;
> +}

Can you move this change to the patch that uses bdrv_parse_aio()?  I
don't see any callers in this patch.

> +        if (ret < 0) {
> +            if (ret =3D=3D -EINTR) {
> +                luring_resubmit(s, luringcb);
> +                continue;
> +            }
> +        } else if (!luringcb->qiov) {
> +            goto end;
> +        } else if (total_bytes =3D=3D luringcb->qiov->size) {
> +                ret =3D 0;

Indentation is off here.

> +static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *=
s,
> +                            uint64_t offset, int type)
> +{
> +    struct io_uring_sqe *sqes =3D &luringcb->sqeq;
> +
> +    switch (type) {
> +    case QEMU_AIO_WRITE:
> +        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
> +                             luringcb->qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_READ:
> +        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
> +                            luringcb->qiov->niov, offset);
> +        break;
> +    case QEMU_AIO_FLUSH:
> +        io_uring_prep_fsync(sqes, fd, 0);

In QEMU QEMU_AIO_FLUSH is fdatasync so the IORING_FSYNC_DATASYNC flag
can be used for a slightly cheaper fsync operation.

> +        break;
> +    default:
> +        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
> +                        __func__, type);
> +        abort();
> +    }
> +    io_uring_sqe_set_data(sqes, luringcb);
> +
> +    QSIMPLEQ_INSERT_TAIL(&s->io_q.sq_overflow, luringcb, next);

Now that we use sq_overflow unconditionally it can be renamed to
submit_queue, making the code easier to understand.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0x4xAACgkQnKSrs4Gr
c8g6wQgAia00NAcMIHGybMrn8RmcEf37QecA3wgxA8Ixawwufy/ViGxJ6cBdshnI
vfHO5Bh8VAilrX4Urr3LxkPMZ5YpMKAnEMAWdEhU87APboyphDncp0qkf7WxAALp
0mpOeS+3WKJWLsET89vzVuEiTGcRg9ysCAiSvM3JVl0HbyF1JTCCg8xpuZIkktzY
W5z4N//YOxb1MOfZwjIwbtubUgL7/Y23TwlFNWWrbyDSaz/ZHM5gv9aTWF2Q1w1q
KxOwNAIpXQH4XeVLtpR/+aNMt89NEP2tOk3YaMDIbTFmHSZ0+H5P2pB0iKvxC9UK
gMr76O9ob7CULWZVA4U1fDaUpE9qAQ==
=v5XU
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--

