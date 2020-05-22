Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0665320723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlOqIG9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0665320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbyDX-0006CV-Vr
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbyCl-0005kC-7f
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:18:39 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbyCj-0006Je-Mj
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:18:38 -0400
Received: by mail-pg1-x543.google.com with SMTP id n11so4313366pgl.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eUNLT/3R1QaeCnDHzeVImdBVpoowQAkH7ghp7vfSVoM=;
 b=jlOqIG9lCXGmSCe8gmhOiIQSYkxKPA3D1x3NabKFVFfbvwBEM59c3Xrxqy+4xPlUWj
 Cn0CsK00yuEIl1uou1Gsz0LICwG7sfsry5UIWjAYPoHrO71XEZp9cycib+ZY/nikwc2Y
 VxwparWnq5A72Wt5aezd16pHAGzRZGpE17x9sJEG+7G+BUSl1312iyHhWoShvZsZ/YXI
 k+SufJpqFm4vemfQJSR+n9CI0mBbSHZsGpDWENCHAhaHnqHoY8GXqhtI3m0wHeVmmj/d
 5Vopp4m80LyXzdeOEqsX/qSIYyHnPYHk7QL4tbh5uFvAuT/3EreQt42rKlvm/nex5gEF
 bKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eUNLT/3R1QaeCnDHzeVImdBVpoowQAkH7ghp7vfSVoM=;
 b=teKTtWUBwyZWhwYvXXvlHyaVKMcgwu+ypYWJfdGrue1ii2Z+rD6eSAwObOmfA/7clc
 bIHz4o3hgs7HxuSK1/VRdKGk+UePWYToVUL/MpRNwSmieuMbLf3w/kFWH7bLGiebKKv1
 DW1BiqeDVivvOa3HaiJNSO6oQCRWpC7E7+kD5qApIYvsBJeBpprxsljE+PKudE1AmCeU
 uT7oLZcv0g8DE8bktJeLhqiUjf/WPL3vtOQ0Z7tfWML6uV+HLqKbjUZy6BSqRxU8YJsf
 IcDKlHVUBpzlrmyp0B9rrlNS2gGye9+E1H0sMnc7G2sixu1tvHsr/qWL3y0JlRwFOA2t
 va8Q==
X-Gm-Message-State: AOAM531STkfmNUdCubGZxYKUWeUyFoUBG27agvjLPyGq3pkYFdT/5KlZ
 MOy9Xq67B/IjdyLkIXG69DdMpA==
X-Google-Smtp-Source: ABdhPJzTXjHrBKfc7D9GcUJWF/ojyeG+4U9RrTHhpW3Je7+tXeJylS+occniDS1pzsEQypI6sE6Scw==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr1913852pfa.250.1590117516107; 
 Thu, 21 May 2020 20:18:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a71sm5844900pje.0.2020.05.21.20.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:18:35 -0700 (PDT)
Subject: Re: [PATCH] minikconf: explicitly set encoding to UTF-8
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200521153616.307100-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <871ef430-567e-9ebb-9adb-54333e6f4742@linaro.org>
Date: Thu, 21 May 2020 20:18:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521153616.307100-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 8:36 AM, Stefan Hajnoczi wrote:
> QEMU currently only has ASCII Kconfig files but Linux actually uses
> UTF-8. Explicitly specify the encoding and that we're doing text file
> I/O.
> 
> It's unclear whether or not QEMU will ever need Unicode in its Kconfig
> files. If we start using the help text then it will become an issue
> sooner or later. Make this change now for consistency with Linux
> Kconfig.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/minikconf.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


