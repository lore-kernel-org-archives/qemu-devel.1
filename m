Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A67BC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341F42146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWetlA44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341F42146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDA7g-0000v3-CI
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA4K-0006hC-2d
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDA4H-0004nh-VE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:23:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDA4H-0004nV-PN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:23:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id o18so7678112wrv.13
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F9C2a5AjczBBRjASG6ypOWQueZFPTCuTyzHg5GZ65ZA=;
 b=qWetlA44kfvxD6MpBzFl9u0ohKThz8NfyGpPiYnMnHfIcinfm8wHVff1WDPQLQDAgD
 K/pDcLFlyZZGugWNTHz3xGFSLXH6iKCpPRqmoADfbynFxf6tAVs9iRkjSzCtJLsaxh6+
 xNetePQptJbCCJNZGkLZ0yAZV9dnNhiWMqwFgHivrIPvrAOY2ff9kHD6LRaDHev+XNNq
 bn6wWj8L2403lVAesUjnLPwF3vZXBxn50FyPY8yGfShSGZtkZzvbIuPXkgqdzKrR4/YQ
 noaRuJcG++FgrDQEn2Hf7u9lO8LQ908WpOoAvRN9Q29X8bZ7wN0WoaNZJDM78tZ0M1pP
 zDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F9C2a5AjczBBRjASG6ypOWQueZFPTCuTyzHg5GZ65ZA=;
 b=Sz+uNUBG9frfIN/yhSWCwnYu5TZjqTssacLCH6KH/+LUhQ7Bz429rEB0UdeM7oWyjN
 +HZ6KqXNP+BgMOQvJT5MbdWipg4FUzY4duT621pr84/cknTxFz/x754jS/8hbN87zUI5
 3ZTU3tBXkw78x5AfrLPK7WLhNhaMVpbCydX//FW3IWo6ZxlCkeaGUtX/VvKWBjbkFrmP
 Vn5VWb16kfXQWFMptWH8+9BOjZ11PKorhS7mwc7Imbn1vL/F/O7L5TJMwI50xGKJrw0u
 AcZEm0XFsxozBoPosdpTp41tFJckMBTBMwCFnQr2RZOqAUoz9jLAsCsAJ2/FTgapf/z7
 Nb3Q==
X-Gm-Message-State: APjAAAXkHbMSmC3Ln6Ik0jXlkRkLtbKYEzRatBxNtY62yI5ZHUz6L5bF
 Bbecd4ReRftE/DwWdUaDpnCCCuZkb64QEw==
X-Google-Smtp-Source: APXvYqzWtMVeVXY/blLAaa8ciguHXsUfrjSNVCaZWYXNM2Rs5ouuQEdx0x886syS4a74g2fvxsih4w==
X-Received: by 2002:a05:6000:1184:: with SMTP id
 g4mr10247587wrx.361.1569428584563; 
 Wed, 25 Sep 2019 09:23:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm6973412wrw.83.2019.09.25.09.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:23:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B43D1FF87;
 Wed, 25 Sep 2019 17:23:03 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-15-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 14/16] cputlb: Remove tb_invalidate_phys_page_range
 is_cpu_write_access
In-reply-to: <20190923230004.9231-15-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:23:03 +0100
Message-ID: <87lfuc9wgo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> All callers pass false to this argument.  Remove it and pass the
> constant on to tb_invalidate_phys_page_range__locked.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.h | 3 +--
>  accel/tcg/translate-all.c | 6 ++----
>  exec.c                    | 4 ++--
>  3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
> index 64f5fd9a05..31f2117188 100644
> --- a/accel/tcg/translate-all.h
> +++ b/accel/tcg/translate-all.h
> @@ -28,8 +28,7 @@ struct page_collection *page_collection_lock(tb_page_ad=
dr_t start,
>  void page_collection_unlock(struct page_collection *set);
>  void tb_invalidate_phys_page_fast(struct page_collection *pages,
>                                    tb_page_addr_t start, int len);
> -void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end,
> -                                   int is_cpu_write_access);
> +void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end);
>  void tb_check_watchpoint(CPUState *cpu);
>
>  #ifdef CONFIG_USER_ONLY
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 5d1e08b169..de4b697163 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1983,8 +1983,7 @@ tb_invalidate_phys_page_range__locked(struct page_c=
ollection *pages,
>   *
>   * Called with mmap_lock held for user-mode emulation
>   */
> -void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end,
> -                                   int is_cpu_write_access)
> +void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t =
end)
>  {
>      struct page_collection *pages;
>      PageDesc *p;
> @@ -1996,8 +1995,7 @@ void tb_invalidate_phys_page_range(tb_page_addr_t s=
tart, tb_page_addr_t end,
>          return;
>      }
>      pages =3D page_collection_lock(start, end);
> -    tb_invalidate_phys_page_range__locked(pages, p, start, end,
> -                                          is_cpu_write_access);
> +    tb_invalidate_phys_page_range__locked(pages, p, start, end, 0);
>      page_collection_unlock(pages);
>  }
>
> diff --git a/exec.c b/exec.c
> index 7d835b1a2b..b3df826039 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1012,7 +1012,7 @@ const char *parse_cpu_option(const char *cpu_option)
>  void tb_invalidate_phys_addr(target_ulong addr)
>  {
>      mmap_lock();
> -    tb_invalidate_phys_page_range(addr, addr + 1, 0);
> +    tb_invalidate_phys_page_range(addr, addr + 1);
>      mmap_unlock();
>  }
>
> @@ -1039,7 +1039,7 @@ void tb_invalidate_phys_addr(AddressSpace *as, hwad=
dr addr, MemTxAttrs attrs)
>          return;
>      }
>      ram_addr =3D memory_region_get_ram_addr(mr) + addr;
> -    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1, 0);
> +    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
>      rcu_read_unlock();
>  }


--
Alex Benn=C3=A9e

