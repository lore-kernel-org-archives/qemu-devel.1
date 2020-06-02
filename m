Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2C6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483A420671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7ntDC8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483A420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxFc-0007AD-Gy
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxEi-0005wZ-IG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:05:08 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:39088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxEg-0003Q1-Rh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:05:08 -0400
Received: by mail-pg1-x52a.google.com with SMTP id w20so4413414pga.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q79/v9H68cK5C7XX/viEJpmvLwAnEc6hXS/nhR9uUF8=;
 b=x7ntDC8Ib5bkOenoqR8y3uyp5xoI3xwAzgNK0yIr4WUIwyXXdCOMGsaq119eKu7gAK
 OVKkVVcj1ZpPLVwwN7/Or0qn4avipMUJ1QdlkG3zRanX0P3hPjCDX+mxkGiz/k9SxhVu
 BViti91rShW/ARbvD9553W/nKmRUZeWFC7W9tiDUZcGjcjw0Ru3OcN027qHBPyqMD4ng
 FrSg0NhQ2Y6RaZixzctKEHMm/P7jw7FG8QEckdn2w+EXHG0RREyc1s2s6f1RdnM9kdyf
 acWYWihWVu1CNRU/UYPbZGJ9Ltf0RZIkmp9fFu54s5n5acgQzcQ/QNdl7EuRWujztzgT
 Tn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q79/v9H68cK5C7XX/viEJpmvLwAnEc6hXS/nhR9uUF8=;
 b=gid67qDK2phKaQ4O+zolytmykOz8m9oSn4nCSp8dePaKn6xVm9WQx3Tn+O36RsCjm8
 dcy7EyVx/1+3ezMPfE8Enx8WrUbMCo60vQLhFCfQ/Ni2bKfEvLkotY+bar4XTS2R/LDx
 XITdwuDyQ8NAWpX4DtX1oVp7AiKQP8KGMLMkRJA/euD/xCrsAm/HoauU0a6Spjs2QuH6
 iokSeEMQlsh+QrbxdELeaiv26LWDak0amTVgOiJhu82Bltw/gSvQ0xC8tPV3Q9aYG4uC
 5JR/hUNJ+cPrWhBVf5sigkIckl2Qd9+HdKIEMnTTDu47TmlcUo479S4MvOOtrE1uWRig
 wm/Q==
X-Gm-Message-State: AOAM530ZjUenzTtDAaj6F0M/uA51Tpgo3JqFhBuyzUSwONKE7cALJMgv
 aGhc3NSmbbmiYEli6RT/nUZKIw==
X-Google-Smtp-Source: ABdhPJzxyp0zM22v1JilGfXzqa6umsvBbwONRFIsa9RFtgb+wH8jU90xAfGAOoORAvgHwo2B4ELLLw==
X-Received: by 2002:a63:565b:: with SMTP id g27mr20998356pgm.166.1591067105385; 
 Mon, 01 Jun 2020 20:05:05 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm691624pgv.5.2020.06.01.20.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:05:04 -0700 (PDT)
Subject: Re: [RFC v2 02/18] target/i386: sev: Move local structure definitions
 into .c file
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-3-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <871c356b-5652-71e0-1f2a-72f75c4743e2@linaro.org>
Date: Mon, 1 Jun 2020 20:05:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> Neither QSevGuestInfo nor SEVState (not to be confused with SevState) is
> used anywhere outside target/i386/sev.c, so they might as well live in
> there rather than in a (somewhat) exposed header.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c      | 44 ++++++++++++++++++++++++++++++++++++++++++
>  target/i386/sev_i386.h | 44 ------------------------------------------
>  2 files changed, 44 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


