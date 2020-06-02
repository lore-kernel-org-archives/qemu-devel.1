Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AFF20671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boYq3m8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AFF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxN1-0004hD-GR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxMP-00049l-Cw
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:13:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:40571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxMO-0004i0-10
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:13:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id t16so753639plo.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gOfNfr4/NHG9KND+o0a1b/Gj7rxxI014ehcAKIZjcMs=;
 b=boYq3m8nCPLXRifOJ1WwC2ljtjG6XWKE9h/sumj5nnr2ZW1l0SiqOafj5cYF2Lboe1
 3TiPzISIdIUiIbN1PwvKO6DPPaJqH3n8ZqM0otGLILLBsCJT7Gx3ZEiZcr3jviJacz7l
 0FkDeOykZ7wY/QSQWdRCFx8CN3xIlbGrZAkEgA7c4UpY4wpMKsE4V9l02Sl1tkEOpqEl
 +1kmL50irun4eCx+oCmipk16bgrdKsn7Se7+wel4a5oo3H6m/6PcBX1wR9gdg8evRo9G
 kZ0WVVXFcqmAnfYIvjwHeti39vGIfpNvRFzHXUXwTmclBuIQpYNbnfPAJ+qc0PURoGKC
 P3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gOfNfr4/NHG9KND+o0a1b/Gj7rxxI014ehcAKIZjcMs=;
 b=nkbpkkYUDft7QuuW3jO0kvYym36qCQXiupHB4znvQBW13fiqS88WZklbh3BWOjz+yM
 rog7cUfoU8W8rstpP4LG+asFzGR5yrxHIVWxB9m06M+ujMWfuca9gxs8d6RXP/xHTeVy
 l3jX6yumVsyqu5b8QqJJZ99A86rB7pbFgsJU2LQUcAo5fdttiyXgkPpDssJUSX8cb6Yk
 6Nb4LIMV+EvGr0QjdJvN1jmf+diTSEOY5bh0qqfWCi5Lh+U7gdCO+rHtbfmi8in3ESYB
 pmrMxkRoiUwo1tX54UFEQYK1AdgAg0HLJdW4+ERR0d/2tk4Qmn+4fI4ta9J42Od3LqAF
 whBA==
X-Gm-Message-State: AOAM531M4rp91d1MyIVqOkEVNEF40S8sqy55FM7719IrA0fuX3b0sNll
 3li/FUhGE8xex9UCyKpJzIGO4Q==
X-Google-Smtp-Source: ABdhPJzy5GxChjWEy3NR09rs23TaguUIEtLZW0NK73L6fQJahVPYQn+4SBYsycjw6w7PkoFOLWkAbg==
X-Received: by 2002:a17:90a:218c:: with SMTP id
 q12mr2692924pjc.116.1591067582586; 
 Mon, 01 Jun 2020 20:13:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id hb3sm729170pjb.57.2020.06.01.20.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:13:01 -0700 (PDT)
Subject: Re: [RFC v2 07/18] target/i386: sev: Remove redundant policy field
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-8-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cad6754f-1014-3d77-fd21-113c4f73409b@linaro.org>
Date: Mon, 1 Jun 2020 20:13:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
> SEVState::policy is set from the final value of the policy field in the
> parameter structure for the KVM_SEV_LAUNCH_START ioctl().  But, AFAICT
> that ioctl() won't ever change it from the original supplied value which
> comes from SevGuestState::policy.
> 
> So, remove this field and just use SevGuestState::policy directly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


