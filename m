Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9DEC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74542071B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLr4uD0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74542071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCOu4-00019V-U1
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCOtW-0000c4-4M
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:05:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCOtU-0003Cf-Dp
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:05:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id g6so1705430pjl.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=mjEnAUmv9YinhkxK3wNqV4vPZMq4aV7GMpW66/cKzQY=;
 b=QLr4uD0F5Gj02xN22yUxI181FQCLwkHzAzvGfz1t2zRzvIMZMRPpuYS7cOth+WlJWY
 F6dfd+JwFKXveGqCZNaEK5D8Oe9RGHmwdAz2P8Cyr8DE7G2fsfDeK8LQC8DLIAg81JKU
 ZCDFhD0kfeDGBCzmgB93cXfHUBe97FiEDpiZbNwB0NwTNnIzPNYZN4T8ofTw0kaZNJi3
 Ht4lmx0IOc4++GZAxEukqfdW5MhT61ruddojPZLM5TeAe3fl0jAI70VrXlIKjSwlEcmP
 /hy7P0quAp+IxPPAKe+rafy7UUh0u6x/RrSRJEqyPEpJ55XyXmpCcbqLlsnbJ7eLxN9g
 t4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mjEnAUmv9YinhkxK3wNqV4vPZMq4aV7GMpW66/cKzQY=;
 b=abC5Q2VdbX3nwRiStj3HwZYgxFKMKq+Yv0VXpb6gns2erddLUNKqXn7HM6pXiPPMOb
 1c8m3GIoVUMMwR8QC+bZ2ECXpIyVmro+7yYPTcnAmrKx/rMRPApWV0djIna9xAAa4sDQ
 eKBkkawt0SsQFq+83sVk5P0ynC4vbhcFkRsNUP77ui+/7wGnopRQXMLwa5PX1czpSNuN
 Abc3a2RS/HyFeHObQUMr3S/9R5HCuUqA9PlISAAfu7Y5ohUnFSgSOSXXG1YTDpEExTxi
 GlRvU6cySONnc6Vt51NkRMIg2OsK4tCDdMzLWx3we5VuZQdkwMrYLIFlRTOp+fAqfF9b
 VD2A==
X-Gm-Message-State: AOAM533fQ/bsTRGbb5C4PWYqG0X8imVZrKvea+q+QAHeWaB7SUBU4gYk
 A3Ar9Rb3IFWfJCYfK61mO9JtmThecO7Akw==
X-Google-Smtp-Source: ABdhPJzTyF3Il42Ajz/CWOG32ozkisj1DwTIWcKj33lJ6ifxXeHkjM8DnpuLC8jTUJ5I1o0MOw9y1w==
X-Received: by 2002:a17:902:6a88:: with SMTP id
 n8mr5691976plk.261.1598799918494; 
 Sun, 30 Aug 2020 08:05:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gb17sm1332672pjb.15.2020.08.30.08.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 08:05:17 -0700 (PDT)
Subject: Re: [PATCH] target/hppa: Fix boot with old Linux installation CDs
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20200830132110.GA31329@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f021841f-74d7-92b7-8e13-79421806cbfa@linaro.org>
Date: Sun, 30 Aug 2020 08:05:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200830132110.GA31329@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 6:21 AM, Helge Deller wrote:
> The patch below modifies the qemu instruction decoder to ignore the
> 64-bit flag too - which is what real 32-bit hardware seems to do as
> well.  With this modification qemu now successfully boots those older
> images too.
> 
> I suggest to apply the patch below - even if it does not reflect what
> the SPEC says.  Instead it increases the compatibility to really
> existing hardware and seem to not create problems if we add real PA2.0
> support anytime later.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

