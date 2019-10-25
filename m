Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB9ECA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78254222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78254222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO046-0005Bj-MB
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iNzvZ-0006he-Am
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iNzvX-0000QD-NF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iNzvX-0000Pp-DA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:51 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C35985543
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:46:50 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id x9so1170011wrq.5
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=qWNR5mr8dRsrMOIhGWml5Gg5BK4sQFEPJ2Rmwcx1KsM=;
 b=pGmZzuB20mqK+vtoJ3/hcz44xfBgcgVOnRUGR7v/hiTkY+gmKxCmv5lQzEa77zhlxi
 W4YS0Qv9XH1s+GOzOamxCMiCMZdIlUZzwa9T6DrKUZlF9xuHahNUXUmqeXzebxzCMd9B
 Ss1AacAsRi8q9k+8TPzbBb7C4/QXh6myoxCV1o0F0QHr/MWT2ArBIgUKAJ4oezTx2qaJ
 2pOyZNAhofPGP1F2wKJZCywmE06bfQCRmcHSO8Z+jX4JG26EQMNQV84I7jEM9hV0KIqz
 1X20L5DkpkyDcte+/HAaQsEx+zFc8vrDzRMitCg9vpOWDRUhyZ/v/RlpwXk0cQq2kl6H
 hnzw==
X-Gm-Message-State: APjAAAUiJds2I11u1IQZK8Z4m8zXHKm3yqa62MMOtzOe4YzCexGhUdoW
 5qPcQg8xWWvt4FjA/hEtoYdUp3u4h/4uevFQdxKNgLkrgAKbgyk0KkhNZ4BBAT/ygItXeFTfbUR
 bOgMWM1R0KjvAJEQ=
X-Received: by 2002:a1c:4489:: with SMTP id r131mr3476191wma.132.1572011209074; 
 Fri, 25 Oct 2019 06:46:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCJVDDC++SsF2QTxeRduS2fhlFcH5AVIxzVuCNktHWDMhUrRBtCDNHj1mjK+jFt/M42uhNIg==
X-Received: by 2002:a1c:4489:: with SMTP id r131mr3476158wma.132.1572011208747; 
 Fri, 25 Oct 2019 06:46:48 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id v20sm1859388wml.26.2019.10.25.06.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 06:46:48 -0700 (PDT)
Date: Fri, 25 Oct 2019 15:46:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 2/4] tests: benchmark crypto with fixed data size, not
 time period
Message-ID: <20191025134646.tqtf4qgxdzw3tjov@steredhat>
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191017145654.11371-3-berrange@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 03:56:52PM +0100, Daniel P. Berrang=E9 wrote:
> Currently the crypto benchmarks are processing data in varying chunk
> sizes, over a fixed time period. This turns out to be a terrible idea
> because with small chunk sizes the overhead of checking the elapsed
> time on each loop iteration masks the true performance.
>=20
> Benchmarking over a fixed data size avoids the loop running any system
> calls which can interfere with the performance measurements.
>=20
> Before this change
>=20
> Enc chunk 512 bytes 2283.47 MB/sec Dec chunk 512 bytes 2236.23 MB/sec O=
K
> Enc chunk 4096 bytes 2744.97 MB/sec Dec chunk 4096 bytes 2614.71 MB/sec=
 OK
> Enc chunk 16384 bytes 2777.53 MB/sec Dec chunk 16384 bytes 2678.44 MB/s=
ec OK
> Enc chunk 65536 bytes 2809.34 MB/sec Dec chunk 65536 bytes 2699.47 MB/s=
ec OK
>=20
> After this change
>=20
> Enc chunk 512 bytes 2058.22 MB/sec Dec chunk 512 bytes 2030.11 MB/sec O=
K
> Enc chunk 4096 bytes 2699.27 MB/sec Dec chunk 4096 bytes 2573.78 MB/sec=
 OK
> Enc chunk 16384 bytes 2748.52 MB/sec Dec chunk 16384 bytes 2653.76 MB/s=
ec OK
> Enc chunk 65536 bytes 2814.08 MB/sec Dec chunk 65536 bytes 2712.74 MB/s=
ec OK
>=20
> The actual crypto performance hasn't changed, which shows how
> significant the mis-measurement has been for small data sizes.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  tests/benchmark-crypto-cipher.c | 26 ++++++++++++++------------
>  tests/benchmark-crypto-hash.c   | 17 +++++++++--------
>  2 files changed, 23 insertions(+), 20 deletions(-)
>=20
> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-c=
ipher.c
> index 3ca31a2779..d8db5504d4 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -21,11 +21,12 @@ static void test_cipher_speed(size_t chunk_size,
>  {
>      QCryptoCipher *cipher;
>      Error *err =3D NULL;
> -    double total =3D 0.0;
>      uint8_t *key =3D NULL, *iv =3D NULL;
>      uint8_t *plaintext =3D NULL, *ciphertext =3D NULL;
>      size_t nkey;
>      size_t niv;
> +    size_t total =3D 2 * GiB;
> +    size_t remain;
> =20
>      if (!qcrypto_cipher_supports(alg, mode)) {
>          return;
> @@ -58,33 +59,34 @@ static void test_cipher_speed(size_t chunk_size,
>                                        &err) =3D=3D 0);
> =20
>      g_test_timer_start();
> -    do {
> +    remain =3D total;
> +    while (remain) {
>          g_assert(qcrypto_cipher_encrypt(cipher,
>                                          plaintext,
>                                          ciphertext,
>                                          chunk_size,
>                                          &err) =3D=3D 0);
> -        total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 1.0);
> +        remain -=3D chunk_size;
> +    }
> +    g_test_timer_elapsed();
> =20
> -    total /=3D MiB;
>      g_print("Enc chunk %zu bytes ", chunk_size);
> -    g_print("%.2f MB/sec ", total / g_test_timer_last());
> +    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last())=
;
> =20
> -    total =3D 0.0;
>      g_test_timer_start();
> -    do {
> +    remain =3D total;
> +    while (remain) {
>          g_assert(qcrypto_cipher_decrypt(cipher,
>                                          plaintext,
>                                          ciphertext,
>                                          chunk_size,
>                                          &err) =3D=3D 0);
> -        total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 1.0);
> +        remain -=3D chunk_size;

Are we sure that total is a multiple of chunk_size?
Maybe I would have increased 'done' and checked (done <=3D total),
but maybe it doesn't matter since I think that chunk_size will always
be a power of two.

> +    }
> +    g_test_timer_elapsed();
> =20
> -    total /=3D MiB;
>      g_print("Dec chunk %zu bytes ", chunk_size);
> -    g_print("%.2f MB/sec ", total / g_test_timer_last());
> +    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last())=
;
> =20
>      qcrypto_cipher_free(cipher);
>      g_free(plaintext);
> diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-has=
h.c
> index 9b6f7a9155..67b7067223 100644
> --- a/tests/benchmark-crypto-hash.c
> +++ b/tests/benchmark-crypto-hash.c
> @@ -20,7 +20,8 @@ static void test_hash_speed(const void *opaque)
>      size_t chunk_size =3D (size_t)opaque;
>      uint8_t *in =3D NULL, *out =3D NULL;
>      size_t out_len =3D 0;
> -    double total =3D 0.0;
> +    size_t total =3D 2 * GiB;
> +    size_t remain;
>      struct iovec iov;
>      int ret;
> =20
> @@ -31,20 +32,20 @@ static void test_hash_speed(const void *opaque)
>      iov.iov_len =3D chunk_size;
> =20
>      g_test_timer_start();
> -    do {
> +    remain =3D total;
> +    while (remain) {
>          ret =3D qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
>                                    &iov, 1, &out, &out_len,
>                                    NULL);
>          g_assert(ret =3D=3D 0);
> =20
> -        total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 5.0);
> +        remain -=3D chunk_size;
> +    }
> +    g_test_timer_elapsed();
> =20
> -    total /=3D MiB;
>      g_print("sha256: ");
> -    g_print("Testing chunk_size %zu bytes ", chunk_size);
> -    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last()=
);
> -    g_print("%.2f MB/sec\n", total / g_test_timer_last());
> +    g_print("Hash %zu GB chunk size %zu bytes ", total / GiB, chunk_si=
ze);
> +    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last())=
;
> =20
>      g_free(out);
>      g_free(in);

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

