Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D520C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 22:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DE7206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 22:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5obWugs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DE7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7RWZ-0004co-WD
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 18:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7RVu-0004DO-SA
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 18:52:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7RVt-0007cw-Bx
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 18:52:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id x25so7295823pff.4
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 15:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QArN0Up87kEc8l036DttB3nDRVoRjRbOVHFK0bE7Nf0=;
 b=L5obWugsSdGcmBBFLflTfcRklJQo6iuv7H4j9MM7OgnUjbhBqIGBQC7/yqk4dl6pTC
 5jwXuDbNqdeAjXS7FuY7MoHlJ4rbRYZ4myP0qKS7kJaTfidSBiH9q8jABaUl60VtX3XJ
 YcizcSrhuXeKjdjjSSK+ipJzMmStgmCAk/TKI7l+mD9Ne3WcG8bK5v5hV/LvL0jwsDQe
 /cDNmdng2uX/SJAOfHc5Aw3OGI/KG/iHq5LsRChft+lVCfgB/+JHpVOCPYBv280RxHmu
 30sLUTKZp7r6rZB9oITy/9/Nc6frwLw4OMYiljajohn83fA3/9DdBheovYBqHXJLq4fw
 86Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QArN0Up87kEc8l036DttB3nDRVoRjRbOVHFK0bE7Nf0=;
 b=dMbvZL898nwiT1rbgGDCe8fbNMOxxvpZHAl59KExIDaxamjYmH0vMi4hgZDxAUhLr+
 I9iynq/DJqejg77XIg9CY+iMRDvI6kIg9VNycTr+2CadtchYf+1sgre+Jkpu6xyPmUcI
 3De2r6VgYXXzu8+lgvQL8FZUTXLhpdWFUFO8P88hKJKB81lOL9daSlMH7fEyc7Er/zzl
 fnoma4z5+26/GLNhZBFIgCY4jckXrClNC4b6LriI2znOukGqftVB5ingTkRz96nP84kh
 xcMwnIZNi2/FLefn4BEK3lGn8T16mlpO6ihNHp2KXHW2ML7By/2MqOEZF2LoOlcpwyn6
 Z5dQ==
X-Gm-Message-State: AOAM532rt30xnBRpzG0mCXZMH4/cHG4AM3KPP8F6m9ViYWTse2DH0UFq
 BpLOjlrUC5P6D5IA5ZX+sTVz4g==
X-Google-Smtp-Source: ABdhPJzJvEZI+xaLG+llznUjqUvYpJjtqvj0WbWhoAQgNMb3gCBTHmyR2rbtwhTx2ibf2BA5DRQSiA==
X-Received: by 2002:a63:5b5d:: with SMTP id l29mr8241618pgm.206.1597618347288; 
 Sun, 16 Aug 2020 15:52:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l62sm14982384pjb.7.2020.08.16.15.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 15:52:26 -0700 (PDT)
Subject: Re: [PATCH v4] qapi/opts-visitor: Fixed fallthrough compiler warning
To: Rohit Shinde <rohit.shinde12194@gmail.com>
References: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
 <9abbbc9d-b5d5-fdd1-e6ff-c89071189f7f@linaro.org>
 <CA+Ai=tB3QW7+vt4qSrfSBornPmPJ+1rVajvvXf=p4kg3FG2+ZA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <125714a6-e441-629f-e9ab-d04ce8b0d94e@linaro.org>
Date: Sun, 16 Aug 2020 15:52:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tB3QW7+vt4qSrfSBornPmPJ+1rVajvvXf=p4kg3FG2+ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/20 9:55 AM, Rohit Shinde wrote:
> Hey Richard,
> 
>  1. So I should fork off the master again?

Yes.

There need to be special circumstances for not posting a patch set relative to
master, and even then your cover letter would need to detail against what base
the patch set applies.

>  2. I just checked and my version of the code doesn't contain that line, so I
>     am unsure on how that line got there. I was trying to fix the compiler
>     warnings. Could you please guide me on how I create the next version of a
>     patch?

That makes no sense at all.  The line was added at the same time as the code
above it, in d8754f40acb.

There should be nothing to fix.


r~

