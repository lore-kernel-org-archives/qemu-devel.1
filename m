Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6852ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACA82054F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACA82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzrL-0001Ky-2T
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNzly-0006PC-0h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNzlw-0004EV-KL
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNzlw-0004EC-4a
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:36:56 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4B06C056808
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 13:36:54 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g67so999216wmg.4
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qzemR98VM0iraa5w9nzXUv/tzcdkZPRDfo5s70/oLv4=;
 b=IlBIEjep36nGAqUXzS2AWCwnd3C1KI/X7rBFglBXIUNUGZKTacTK/Hr6whTwTyh/kk
 hI7jcCJqHLpAVTBhE3o7B4HKkXZ7J6qP7RX7qczd5n052VNFVVlWF7JQtHpHMVvowQVH
 wdQ5zfmM8Apye5KgDu40JzASjnW8CABEHfxAQCyNxWG6vvMhwZQUQPnOELLg2VyLYddu
 mQ7/yWWp5tPsjgpBm8i+pgy4TXGmOpF6vP4xtBn9aaWvzUsXa+Z4OT9RI9VQgga/R/Iy
 hcWn/cPgS0DX4ddZko/kmAK/eJYKA+G8q+Tp7DGrb2ujZJsmIXvXRspcJb+a+Dc7bCAm
 QINQ==
X-Gm-Message-State: APjAAAXGzDMyzWUkXHywaKSd+xrhMfkbKGs6BBZkwu9fJwTU+xF2zSSd
 5rPG4x9gq5xjfuvKK/KJamSESYNfMxfKPGVB/ibqpYhA3uB9lPUqnXizrxC/5temolr+ELNaiGJ
 ghKcMbpOXJhkncCs=
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr3684724wmd.10.1572010612974; 
 Fri, 25 Oct 2019 06:36:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwsgV4Tcnc9RcmhGFBrwWBlZjI2ryS+ynvQhpRSffZiCCmykX8KiVF+qU400UUeswcOfxlG+A==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr3684695wmd.10.1572010612691; 
 Fri, 25 Oct 2019 06:36:52 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id k24sm7611709wmi.1.2019.10.25.06.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2019 06:36:52 -0700 (PDT)
Subject: Re: [PATCH 2/4] tests: benchmark crypto with fixed data size, not
 time period
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20191017145654.11371-1-berrange@redhat.com>
 <20191017145654.11371-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c9bef40-7520-2cb5-409f-ea5317783c68@redhat.com>
Date: Fri, 25 Oct 2019 15:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017145654.11371-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 4:56 PM, Daniel P. Berrang=C3=A9 wrote:
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
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/benchmark-crypto-cipher.c | 26 ++++++++++++++------------
>   tests/benchmark-crypto-hash.c   | 17 +++++++++--------
>   2 files changed, 23 insertions(+), 20 deletions(-)
>=20
> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-c=
ipher.c
> index 3ca31a2779..d8db5504d4 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -21,11 +21,12 @@ static void test_cipher_speed(size_t chunk_size,
>   {
>       QCryptoCipher *cipher;
>       Error *err =3D NULL;
> -    double total =3D 0.0;
>       uint8_t *key =3D NULL, *iv =3D NULL;
>       uint8_t *plaintext =3D NULL, *ciphertext =3D NULL;
>       size_t nkey;
>       size_t niv;
> +    size_t total =3D 2 * GiB;

Can you use 'const size_t total'?.

> +    size_t remain;
>  =20
>       if (!qcrypto_cipher_supports(alg, mode)) {
>           return;
> @@ -58,33 +59,34 @@ static void test_cipher_speed(size_t chunk_size,
>                                         &err) =3D=3D 0);
>  =20
>       g_test_timer_start();
> -    do {
> +    remain =3D total;
> +    while (remain) {
>           g_assert(qcrypto_cipher_encrypt(cipher,
>                                           plaintext,
>                                           ciphertext,
>                                           chunk_size,
>                                           &err) =3D=3D 0);
> -        total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 1.0);
> +        remain -=3D chunk_size;
> +    }
> +    g_test_timer_elapsed();
>  =20
> -    total /=3D MiB;
>       g_print("Enc chunk %zu bytes ", chunk_size);
> -    g_print("%.2f MB/sec ", total / g_test_timer_last());
> +    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last())=
;
>  =20
> -    total =3D 0.0;
>       g_test_timer_start();
> -    do {
> +    remain =3D total;
> +    while (remain) {
>           g_assert(qcrypto_cipher_decrypt(cipher,
>                                           plaintext,
>                                           ciphertext,
>                                           chunk_size,
>                                           &err) =3D=3D 0);
> -        total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 1.0);
> +        remain -=3D chunk_size;
> +    }
> +    g_test_timer_elapsed();
>  =20
> -    total /=3D MiB;
>       g_print("Dec chunk %zu bytes ", chunk_size);
> -    g_print("%.2f MB/sec ", total / g_test_timer_last());
> +    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last())=
;
>  =20
>       qcrypto_cipher_free(cipher);
>       g_free(plaintext);
> diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-has=
h.c
> index 9b6f7a9155..67b7067223 100644
> --- a/tests/benchmark-crypto-hash.c
> +++ b/tests/benchmark-crypto-hash.c
> @@ -20,7 +20,8 @@ static void test_hash_speed(const void *opaque)
>       size_t chunk_size =3D (size_t)opaque;
>       uint8_t *in =3D NULL, *out =3D NULL;
>       size_t out_len =3D 0;
> -    double total =3D 0.0;
> +    size_t total =3D 2 * GiB;

Ditto: 'const size_t total'.

> +    size_t remain;
>       struct iovec iov;
>       int ret;
>  =20
> @@ -31,20 +32,20 @@ static void test_hash_speed(const void *opaque)
>       iov.iov_len =3D chunk_size;
>  =20
>       g_test_timer_start();
> -    do {
> +    remain =3D total;
> +    while (remain) {
>           ret =3D qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
>                                     &iov, 1, &out, &out_len,
>                                     NULL);
>           g_assert(ret =3D=3D 0);
>  =20
> -        total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 5.0);
> +        remain -=3D chunk_size;
> +    }
> +    g_test_timer_elapsed();
>  =20
> -    total /=3D MiB;
>       g_print("sha256: ");
> -    g_print("Testing chunk_size %zu bytes ", chunk_size);
> -    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last()=
);
> -    g_print("%.2f MB/sec\n", total / g_test_timer_last());
> +    g_print("Hash %zu GB chunk size %zu bytes ", total / GiB, chunk_si=
ze);
> +    g_print("%.2f MB/sec ", (double)total / MiB / g_test_timer_last())=
;
>  =20
>       g_free(out);
>       g_free(in);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

