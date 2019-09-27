Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5785EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 18:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A5E20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 18:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niXB+sJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A5E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDub3-0008Sf-2T
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 14:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuWc-0005B3-7L
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuWa-0003Rv-SH
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:59:25 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDuWa-0003Qy-Ej
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:59:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id q15so1376351pll.11
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4IkoeGE3RkRSGDtkffBePDzsAeTQ6Bh16Tv8e3ftKOM=;
 b=niXB+sJt2E5GsMCVWVMDBU8hcNQeGDPIZ/5LNU3X0Ch8P++MDVY92vtMo1t5wqG3ey
 1wJ3xzR3MPctcNFMYKw6KAydo1lsv3zbWqmSjSPCIJJVv37tiQ7LKYn7K7I03YEOaEFf
 /1LzGp0nR4XiCsBJaBBG82EazDRluXjHuw8do33gJ5A+6Mx69rD8/kJfYn5GTRCiQQ/X
 ZFuTOVeL0mYpIDFi9X3oLLa0TdH/k9zLiPYBk3snDNudip9FBsrG54FchBgQXA3AJNdi
 rdxyk+t2oD69BJJSkQELUKOygzv9H5FjaqLJJe/CSdXcJfwuhQPq6gbnI0CixzudV68J
 iasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4IkoeGE3RkRSGDtkffBePDzsAeTQ6Bh16Tv8e3ftKOM=;
 b=QCss+PR6w1YihLx/ovvXMsp2EYwiMNHrXxx/KSs1RTSd3fzEH/iZb0iWr40B8svepZ
 P4GaJmZCz+ExzIpWBHu1CkTz5dMTuR3zM44SLhrBgiKibNJ7xxU/yR/ovnbjlq7Ftted
 J5I7eXEHaLefabJazw475AbbtPE2vlsIujsH+2xPeVGYrVBrcXbsC5r9kGkZG5IYQ4NL
 nlC78CG1L20dB7ZjvpMm2KnQ8/UGK/AtVh4WEoX3z7RVRLt2G+Blpls8opDsv7TNhpiI
 8z7nQBDMDZffHlH/Iakjhilrcr3cSJezYjcts6kgyjFvAnq/Nk5bYDmUp7lKtZT3gxQu
 1vBw==
X-Gm-Message-State: APjAAAVADjbERcN6Bn8lMkWatVki7aBnHNaCFWWtLqfcBgvXseD7RVzt
 9PlX1vW+RRLfc3Ul2JQkGF5LoQ==
X-Google-Smtp-Source: APXvYqxisdHkm2/Cn/0LmEVIuu2qPsAdTKovb9RTn+wcpjMNpPBESyNbrfEyu+Xpwa/RycZyGHz7Zg==
X-Received: by 2002:a17:902:690c:: with SMTP id
 j12mr6145992plk.83.1569607163433; 
 Fri, 27 Sep 2019 10:59:23 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id 8sm14077598pjt.14.2019.09.27.10.59.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 10:59:22 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] s390x/mmu: DAT table definition overhaul
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190927095831.23543-1-david@redhat.com>
 <20190927095831.23543-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <74e9a0ee-bb6a-36e5-a910-75a9f0b23b10@linaro.org>
Date: Fri, 27 Sep 2019 10:59:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927095831.23543-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 2:58 AM, David Hildenbrand wrote:
> Let's use consitent names for the region/section/page table entries and
> for the macros to extract relevant parts from virtual address. Make them
> match the definitions in the PoP - e.g., how the relevant bits are actually
> called.
> 
> Introduce defines for all bits declared in the PoP. This will come in
> handy in follow-up patches.
> 
> Add a note where additional information about s390x and the used
> definitions can be found.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h        | 81 +++++++++++++++++++++++++++++----------
>  target/s390x/mem_helper.c | 12 +++---
>  target/s390x/mmu_helper.c | 37 ++++++++++--------
>  3 files changed, 87 insertions(+), 43 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

