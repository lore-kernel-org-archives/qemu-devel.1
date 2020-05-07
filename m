Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB727C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 04:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858E3207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 04:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="Rr4t2ifX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858E3207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYYe-0005Jp-Jb
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 00:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jWYY5-0004tA-Ay
 for qemu-devel@nongnu.org; Thu, 07 May 2020 00:54:17 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jWYY4-0006Fz-8k
 for qemu-devel@nongnu.org; Thu, 07 May 2020 00:54:17 -0400
Received: by mail-qk1-x743.google.com with SMTP id s9so4743001qkm.6
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 21:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=wpuwABheavrXnYDU5P7Wl+Jqup4AHIK2T/DX6ud3zMU=;
 b=Rr4t2ifXdKG+JOd00zU+QS0HG0iNs0f1Tfnm5EEzJhtkncDjCxZHg84CqrVu6GztPs
 K0Ajuf2jiKdZleygCrTdGQXuPhuS/DZON0jqpmRvYThwTwfbUBdZpCKEgah6GVIZtwWf
 qLzVUkD5lDZk1pDNuWdm5z2G3mrxO1bSwPOvCBx4+HrzAj1F78qhs1ZRl+8a/X5jfiYt
 faqO84F2CWo0xEjmwXQIPJEnbNJv0u5qnhFvs1a1khRgOaG1eCTTPWWPjkrpw9t//RGc
 r+KS6+4Zzavboj9a/HzVr02GysnpHmMOBk9vPKwBIeASC6tLBxzsCNceUeWd+AOCgogI
 XAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wpuwABheavrXnYDU5P7Wl+Jqup4AHIK2T/DX6ud3zMU=;
 b=i+UFhonAxUKktqZub+ItB+uwG9KyMiT5E8/9Xpm4PW/mTPc8MC+jCkHIlk6R/FDQ4I
 YHnuGmDFbwKiRiQnWcLH4f8Mv1YBlTyH32+kJbUtyCQ0Mk62AOqhnxM5STEeEsTEWH5x
 Rn9b7oDDR7Wj6+VodIdGCwqAkFL4Oogy8AtJJZch3hO+hIiPL8+WAfdU/9Ua06B+5/CK
 0cTexiyR/0rtebKfbkNaqz1MntgLx3RiBVM8BW1jka/hXwsXdtcJ3ZVtWb+B8zprlziQ
 9LhN3m6PB6798+cxxmYGfM7qw4DL+jqiGOOtle2OWTAg8f+0p+6b24QxRN6ChRAU5vgW
 Xq1g==
X-Gm-Message-State: AGi0Pua0nlM0zLwaGqZlg1e2QnbnhNEMsi5DxfNZcV0nWWwRWS4mqOw5
 IY/BxsM4F5sPPNEGD5qbEBo+gw==
X-Google-Smtp-Source: APiQypJpihLiNggGTPkCHIPIIYVrWd5Fg8Lns1tWgZrhH6C3Y0RICjB3Q6sbAE2h0uQF3g25M5HIUg==
X-Received: by 2002:a05:620a:13f2:: with SMTP id
 h18mr12177079qkl.37.1588827254786; 
 Wed, 06 May 2020 21:54:14 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id o14sm3442035qkj.27.2020.05.06.21.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 21:54:13 -0700 (PDT)
Date: Thu, 7 May 2020 00:54:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3] tests/qht-bench: Fix Clang
 'implicit-int-float-conversion' warning
Message-ID: <20200507045413.GA59851@sff>
References: <20200504144352.23021-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504144352.23021-1-philmd@redhat.com>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::743;
 envelope-from=cota@braap.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 16:43:52 +0200, Philippe Mathieu-Daudé wrote:
> When building with Clang 10 on Fedora 32, we get:
> 
>   tests/qht-bench.c:287:29: error: implicit conversion from 'unsigned long' to 'double' changes value from 18446744073709551615 to 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
(snip)
> @@ -284,7 +285,7 @@ static void do_threshold(double rate, uint64_t *threshold)
>      if (rate == 1.0) {
>          *threshold = UINT64_MAX;
>      } else {
> -        *threshold = rate * UINT64_MAX;
> +        *threshold = rate * nextafter(0x1p64, 0.0);

Reviewed-by: Emilio G. Cota <cota@braap.org>

Please consider mentioning 25f74087c69 in the commit log -- it clearly
describes the problem.

Thanks,

		Emilio

