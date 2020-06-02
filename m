Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8689C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7566520671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFaDyC9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7566520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxIA-0001Cm-LY
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxH2-0000dF-Ti
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:07:32 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:55477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxH2-0003pt-1G
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:07:32 -0400
Received: by mail-pj1-x1036.google.com with SMTP id fs4so689437pjb.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dA2hMTzLI2RiavnaymrbP0LC+zeelSfH6iYBBbIldTI=;
 b=BFaDyC9aO+HrAZirnXV3Q/cek0ShMpf9u3NfXeXEKy5zzgErEyG/Yk5yXhWNRM0ebW
 Kf+GffLb+65t6NLuJ0p7Kaa5wx78TrbVOps9oSOkDOTInJdoVo7M0u9JsUEA8vKq6p24
 RDmjVo8Szy3XGaG227/MmkJsa7hZ5pVr1AdFw/8tgJ2gvN1bUfmM6YBkLIOAmfEXcFLm
 xsdfgHyOxZ0eVJ6BT5LhEf44oN9GhGrvO8gz1tiDAT7+l1i1MTlx+EQ7hPP6MoZsqOB/
 YwQbdKV5PyMNLkawFbloeoNq6dPwnjygHvMmtJB8zRYMvq+8As4fNMvpoZSnWxBuFnv7
 nhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dA2hMTzLI2RiavnaymrbP0LC+zeelSfH6iYBBbIldTI=;
 b=bHgrD4ldxyyVE8H5gXyUWSwDxLKTVgMuU0nn9+FxZ80yRpICIsC00aqovIAUxDEKH5
 4/r5OGKS1Kks8H7Wrcn4Thw3iUdQ6stGSK7b+Q4jPoiRAwe29uXUltUUB+i5fIJccxZR
 l5cd7UhwV5RcNW3kSTS9pvUgRqNIR5PHhPUfCjIiLnEbI4VsAGl36Aa8oVFIkU1EKE8a
 d5wb2X0B/pomB0PUB6DXPYzLxSbmdcyvAr5ElTdJ9fEzhXdOInmREXMZPIq7CizP8mFa
 /pPZpyBcIWng+b/e58FIoJA2nsv9y5JiJoRLbhX1/Ek01Re9tqC1FXCgJjvSN0vaXPr9
 nvMg==
X-Gm-Message-State: AOAM531uhWVzUhzq6X6E8dxzvjzfwsfz8QlWmqmJGT2I9sXMTf+9M9CO
 4vtKABudURuC93QHTdjiAtYEdA==
X-Google-Smtp-Source: ABdhPJwtA0mWYYf/q4GRy+YMdTvRVgTk9rzVjQFFBiSTWOgIuNrhGFnowhWRlchx8yFawb+JLhgE6w==
X-Received: by 2002:a17:902:7c8e:: with SMTP id
 y14mr11665811pll.312.1591067250649; 
 Mon, 01 Jun 2020 20:07:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id ep10sm706673pjb.25.2020.06.01.20.07.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:07:30 -0700 (PDT)
Subject: Re: [RFC v2 04/18] target/i386: sev: Embed SEVState in SevGuestState
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-5-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10ae7ddc-1305-4455-7146-d97e2091de86@linaro.org>
Date: Mon, 1 Jun 2020 20:07:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
> Currently SevGuestState contains only configuration information.  For
> runtime state another non-QOM struct SEVState is allocated separately.
> 
> Simplify things by instead embedding the SEVState structure in
> SevGuestState.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 54 +++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


