Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F065C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD13A20897
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8ke1Rx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD13A20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFze9-0002uV-T6
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzc9-0000Dn-FT
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:54:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFzc7-0000n9-IG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:54:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id z4so2847232wrr.4
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nts6CdecWELGIuqRp/XjHQhxLkOqPmRK0NVbxxf8gkQ=;
 b=K8ke1Rx5lUJoJHPabumVLfckuYS2NZUWIMqDTwra4w6pOBUHGmG2HyGl4cLFVCA6py
 Lt8r82VhFtPqTkpq8MaSxEj8JdhxoE8daSVjH+vQgkb8myPUv6ZWV+DT2kcHg0iG3VRr
 dYPsDulorEuh7aCNq/9lvyNhzGMljgGNc9/Uw0NDNb3q5eVHVWLM0Ugt3VKW7Qsb8UAZ
 HueAdi8t7BfGbTwKl5o0VTK1HC/tWUiYQWRiIzrlGODiuDBquO85sLxpSinBOxQl/xaV
 zVvGWeZQLNXYVns8Qx+57DcE0LPmVSVIGCg32j7/jcxMgOuUBI3dlb/J6hoZRj/Mu0p1
 9pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nts6CdecWELGIuqRp/XjHQhxLkOqPmRK0NVbxxf8gkQ=;
 b=FaZxdIcQ2YaMZJj1LFTBbd6dYSp0VSfj4PiFFdblZKezJKxVQuIrB8IxXnGl+HikWF
 xagYBTbSQZiD5D0+cP/ncte1eGbpbDwI41wiDkdW5T34lWBv/WCyme8pjLSdxOxgoHGL
 KwYZh6c/2BhJor1Gp+hJShMJYY/Hty1OkxIf496vn4ZO8+rQvqV3nbM8jZdfooh5TWKg
 5tpPhxqU/hFMHmxyx/TNqfPZUOw0hqYURIczE337SldFSPDH7xmOyG4E+xSnrCN74bsn
 wlr6XQpv6S6TpBFhOLpTBli9GA9ccfUgXgjxocaN5HHlAwkSVMg2Jza7GnetMrUa8wuE
 Q9Rw==
X-Gm-Message-State: AOAM531Ju01eKMxEkMl33U7sZ4cptQqW9HoqNrQvCBiA9AifII57VTmo
 BsEtbV91JQUWJ3J0K9oHqBY=
X-Google-Smtp-Source: ABdhPJw9jQ3j3ngRgU2/bm+4aIexz3KjHQKaubdCQk7al3+mWnIl10CP6Vu6Ixh2fYNdJ3xfcxzIFg==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr3685174wrn.63.1599656053481;
 Wed, 09 Sep 2020 05:54:13 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b187sm3833764wmb.8.2020.09.09.05.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 05:54:12 -0700 (PDT)
Subject: Re: [PATCH] tests: fix output message formatting for crypto benchmarks
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200909121027.1040647-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fcbe2c05-b38c-4b12-32f1-c7ce9e7a29dd@amsat.org>
Date: Wed, 9 Sep 2020 14:54:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909121027.1040647-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:10 PM, Daniel P. Berrangé wrote:
> The output was changed from g_print to g_test_message in
> 
>   commit 24441f912e67233d9c52ce6b459ed75de2484525
>   Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>   Date:   Fri Aug 28 15:07:30 2020 +0400
> 
>     tests: do not print benchmark output to stdout
> 
>     As this makes the TAP output invalid. Use g_test_message().
> 
> The functions do not result in equivalent output. The g_print
> statements were putting all the information on a single line
> for ease of interpretation. The change to g_test_message split
> the output across many lines making it painful to read.
> 
> The opportunity is used to tweak the information printed to
> be more consistent across tests.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/benchmark-crypto-cipher.c | 12 ++++++++----
>  tests/benchmark-crypto-hash.c   |  4 +++-
>  tests/benchmark-crypto-hmac.c   |  7 +++----
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cipher.c
> index 1936aa4ae0..c04f0a0fba 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -70,8 +70,10 @@ static void test_cipher_speed(size_t chunk_size,
>      }
>      g_test_timer_elapsed();
>  
> -    g_test_message("Enc chunk %zu bytes ", chunk_size);
> -    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
> +    g_test_message("enc(%s-%s) chunk %zu bytes %.2f MB/sec ",
> +                   QCryptoCipherAlgorithm_str(alg),
> +                   QCryptoCipherMode_str(mode),
> +                   chunk_size, (double)total / MiB / g_test_timer_last());
>  
>      g_test_timer_start();
>      remain = total;
> @@ -85,8 +87,10 @@ static void test_cipher_speed(size_t chunk_size,
>      }
>      g_test_timer_elapsed();
>  
> -    g_test_message("Dec chunk %zu bytes ", chunk_size);
> -    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
> +    g_test_message("dec(%s-%s) chunk %zu bytes %.2f MB/sec ",
> +                   QCryptoCipherAlgorithm_str(alg),
> +                   QCryptoCipherMode_str(mode),
> +                   chunk_size, (double)total / MiB / g_test_timer_last());
>  
>      qcrypto_cipher_free(cipher);
>      g_free(plaintext);
> diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.c
> index 598111e75a..927b00bb4d 100644
> --- a/tests/benchmark-crypto-hash.c
> +++ b/tests/benchmark-crypto-hash.c
> @@ -48,7 +48,9 @@ static void test_hash_speed(const void *opaque)
>      }
>      g_test_timer_elapsed();
>  
> -    g_test_message("%.2f MB/sec ", (double)total / MiB / g_test_timer_last());
> +    g_test_message("hash(%s): chunk %zu bytes %.2f MB/sec",
> +                   QCryptoHashAlgorithm_str(opts->alg),
> +                   opts->chunk_size, total / g_test_timer_last());
>  
>      g_free(out);
>      g_free(in);
> diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.c
> index f9fa22df95..5cca636789 100644
> --- a/tests/benchmark-crypto-hmac.c
> +++ b/tests/benchmark-crypto-hmac.c
> @@ -55,10 +55,9 @@ static void test_hmac_speed(const void *opaque)
>      } while (g_test_timer_elapsed() < 5.0);
>  
>      total /= MiB;
> -    g_test_message("hmac(sha256): ");
> -    g_test_message("Testing chunk_size %zu bytes ", chunk_size);
> -    g_test_message("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
> -    g_test_message("%.2f MB/sec\n", total / g_test_timer_last());
> +    g_test_message("hmac(%s): chunk %zu bytes %.2f MB/sec",
> +                   QCryptoHashAlgorithm_str(QCRYPTO_HASH_ALG_SHA256),
> +                   chunk_size, total / g_test_timer_last());
>  
>      g_free(out);
>      g_free(in);
> 

