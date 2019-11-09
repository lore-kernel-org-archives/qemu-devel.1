Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB60C17441
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 01:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6743921019
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 01:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPEUsd3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6743921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTFVr-0005wk-KT
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 20:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1iTFUv-0005Iz-8s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 20:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1iTFUu-0007vk-22
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 20:25:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1iTFUt-0007uw-R0; Fri, 08 Nov 2019 20:25:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id b3so8958514wrs.13;
 Fri, 08 Nov 2019 17:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ceKV9Tu/BH2YZe3Lb3SDCMtApqlpLDwm1J/JrqSvcAE=;
 b=VPEUsd3R99h7D4dDX+o1zjJMqQANEGqWlWawK8YTWvBTIyIvdMBLdc+CmpsbKMT/cU
 Do3TD7qFp0iZeBWeTvQXIIA2XN/U79HFJc/jzh9fWXI8IaqfkCkBivQdNk6qDmK85ZSu
 X/kxcjPfa4QcppcsV56FdEhlQ64KhShrDilau3wrQ6/uWjpYpjc3h/Fzx8/fFuhDi7n+
 VFwixgutdgyx1afJjLl1KxqgwVHcHKO7/uErjvBrmt4Mf8va6AtoM4oqIy+P9afBOhKn
 5gv/Cv9HGVqcYcTZs5ybfmbmoOKC47pc/b4u1ikDwmZntU8nnuVcc6Al5t0Sw/cOlSqS
 FZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ceKV9Tu/BH2YZe3Lb3SDCMtApqlpLDwm1J/JrqSvcAE=;
 b=qxWZ9jhqghKrdQ2MDB6qhvD+agSRw0/r8xa/dMFWk4bNm0ghU47xDSPqlfb8EHiII6
 hQNZQgLcE3zJXd+48TgM5u+VHPX3th2SaKf11/ox1SfIBWJjGem/UBGr711q4sXTokot
 fv+HIlodfXfnJWTOoGxC1luoZ2gxI/GyswY0YsVx5+/momjUFI/M9uT6Rq+0sONqZlcB
 fUMo7dTdQHaY8BCyL7BDEAfZQ3itqM+Hqv1azxAJl8JmCWd9NkvH0PMz33G97FxypG1K
 dqztJeY4cqX34soiSQi5KQ31q//fquUIVGW/5SqOFAswE6Fapa6RfF6LfblFfzOWi57a
 QbYw==
X-Gm-Message-State: APjAAAVlTaYYeHdPfbPjpRnkWAM4BicuATNjxI2YHS8JEQbZwbtoTC2U
 vFKYjilMAgaXT8MsQOCt6z0=
X-Google-Smtp-Source: APXvYqzW97BsU30yGCQaFVeVjW2Eusmo5F4HHLzMGA8ogmlPbkNrajXO43xBNaMF6Sj+r5z7QRkaSA==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr8956035wrp.273.1573262702585; 
 Fri, 08 Nov 2019 17:25:02 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id 16sm10827998wmf.0.2019.11.08.17.25.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Nov 2019 17:25:01 -0800 (PST)
Date: Sat, 9 Nov 2019 01:25:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/2] replace sysconf(_SC_PAGESIZE) with
 qemu_real_host_page_size
Message-ID: <20191109012501.rb3jn37urqrrspdf@master>
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015031350.4345-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 jasowang@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 11:13:48AM +0800, Wei Yang wrote:
>This is a following up patch to cleanup page size, suggested by
>"Dr. David Alan Gilbert" <dgilbert@redhat.com>.
>
>Patch 2 does the job, while during the cleanup I found test-mmap.c has quite a
>lot code style problem. To make the code looks good, patch 1 is introduced to
>make checkpatch.pl happy a little.

Does this patch set look good?

>
>Wei Yang (2):
>  tests/tcg/multiarch: fix code style in function main of test-mmap.c
>  core: replace sysconf(_SC_PAGESIZE) with qemu_real_host_page_size
>
> block/file-posix.c              |  2 +-
> net/l2tpv3.c                    |  2 +-
> tests/tcg/multiarch/test-mmap.c | 67 ++++++++++++++++++---------------
> 3 files changed, 38 insertions(+), 33 deletions(-)
>
>-- 
>2.17.1
>

-- 
Wei Yang
Help you, Help me

