Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A989C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B0B24353
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 08:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B0B24353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWczx-0003Dh-3w
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 04:34:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hWcyr-0002eR-OS
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hWcyq-0000SR-HB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 04:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hWcyo-0000Lz-00; Fri, 31 May 2019 04:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AC043007148;
	Fri, 31 May 2019 08:33:36 +0000 (UTC)
Received: from localhost (ovpn-117-228.ams2.redhat.com [10.36.117.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 745C96FC1F;
	Fri, 31 May 2019 08:33:35 +0000 (UTC)
Date: Fri, 31 May 2019 09:33:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190531083334.GA29868@stefanha-x1.localdomain>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
	<20190528084544.183558-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20190528084544.183558-2-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 31 May 2019 08:33:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] util/iov: introduce
 qemu_iovec_init_extended
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2019 at 11:45:43AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> diff --git a/util/iov.c b/util/iov.c
> index 74e6ca8ed7..6bfd609998 100644
> --- a/util/iov.c
> +++ b/util/iov.c
> @@ -353,6 +353,95 @@ void qemu_iovec_concat(QEMUIOVector *dst,
>      qemu_iovec_concat_iov(dst, src->iov, src->niov, soffset, sbytes);
>  }
> =20
> +/*
> + * qiov_find_iov
> + *
> + * Return iov, where byte at @offset (in @qiov) is.
> + * Update @offset to be offset inside that iov to the smae byte.

s/smae/same/

> + */
> +static struct iovec *qiov_find_iov(QEMUIOVector *qiov, size_t *offset)
> +{
> +    struct iovec *iov =3D qiov->iov;
> +
> +    assert(*offset < qiov->size);
> +
> +    while (*offset >=3D iov->iov_len) {
> +        *offset -=3D iov->iov_len;
> +        iov++;
> +    }
> +
> +    return iov;
> +}
> +
> +/*
> + * qiov_slice
> + *
> + * Fund subarray of iovec's, containing requested range. @head would

s/Fund/Find/

> + * be offset in first iov (retruned by the function), @tail would be

s/retruned/returned/

> + * count of extra bytes in last iov (returned iov + @niov - 1).
> + */
> +static struct iovec *qiov_slice(QEMUIOVector *qiov,
> +                                size_t offset, size_t len,
> +                                size_t *head, size_t *tail, int *niov)
> +{
> +    struct iovec *iov =3D qiov_find_iov(qiov, &offset), *end_iov;
> +    size_t end_offset;
> +
> +    assert(offset + len <=3D qiov->size);

offset has already been modified by qiov_find_iov() in iov's
initializer so this comparison is meaningless.  Fix:

  struct iovec *iov;
  struct iovec *end_iov;
  size_t end_offset;

  assert(offset + len <=3D qiov->size);

  iov =3D qiov_find_iov(qiov, &offset);

Perhaps qiov_find_iov() shouldn't reuse the offset argument for two
different things (the offset from the beginning of qiov and the offset
=66rom the beginning of the returned iovec).  This would eliminate this
class of bugs.

> +
> +    end_offset =3D iov->iov_len;
> +    end_iov =3D iov + 1;
> +
> +    while (end_offset - offset < len) {
> +        end_offset +=3D end_iov->iov_len;
> +        end_iov++;
> +    }

Hmm...this looks like qiov_find_iov().  Can this function be implemented
in less code using two calls to qiov_find_iov() to find the first and
last iovecs?

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzw5t4ACgkQnKSrs4Gr
c8iUvggApvor9mAqXU+kXo6qk5M0+azv71i+M/J84MdWUJAJMlcCpHYOIzxZjf+S
cJduNY6ACc4W2aYUMU9zT77jG05pfoRwrv959XoL06oZpm0g7XQwIWEzEu9moyI5
Y0Y0A7PSqvekrX6PLytxWf7ZJqQqsZZE0OT5XOC+433hQGEenNkAM61cGjZAdqSc
GIl2h4cfI7berGLBMw8ZGedfwMX0ljzvip8NZEN9FMyZlxb1ZKmYCqzCDPwnbnTv
VY6vwpfWd3qWqkv8p6uIAgN5qHq+KtAGYs8ccp9O+o6ojgbilU6G2pwJBicFoHbS
lJGf1n4HpMFSO+6sPop9zbwZ2ZNofw==
=ka0H
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

