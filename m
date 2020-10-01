Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A345C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6A9208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xzKEtjzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6A9208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1yl-0004KL-Fa
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1ms-00078z-Th
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:50:34 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:33007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1mh-00078K-Nd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:50:34 -0400
Received: by mail-oo1-xc41.google.com with SMTP id m25so1661752oou.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cQ1LtbrCrzKkyxOxiIY6SBElAhyOQ1SCrJJLn6exorU=;
 b=xzKEtjzRzN5g1Usj+XQ9VxO/FhVL40P1FsPjxlmU8/Q9iRBEec+gL/iofmjyFW9Oho
 K4+OjXs9VIh7h6XOTEchueM96ESRS1y2aXtQJsQgnV87WZB3Sl6WrTJPAKHvrVCTLOjR
 EwBgd5FqlAlmwcE+5nv+DRw3bmAKDGDkt0cpkdpIgVXDf7ETQuWKlB180fPbiixmEiKc
 dh8FgvV0fg/PyGMd7O+RIs8Dx3VKqRXxMWZSxn6+Qy5DjU+/UjoiXpsKnle6sYPvaCoL
 uok5GsjncPr8+NEK4sMY6MWBPgm2Kf6FxVRZrXy8p1+Ifb3Us/CY+TXJcmi57jLxN/Nj
 SsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cQ1LtbrCrzKkyxOxiIY6SBElAhyOQ1SCrJJLn6exorU=;
 b=G9E+aLu8mV0KNGjZBZR6DpsLuY32byOkZorhAOoClkdddEPUo3zfixlJsLzjA/YTcC
 HE8ZWHWkf/01SE5nlvhvc377D0hnHqt4WweGuJeg+F6v3+zQoQIlRJsllghAdPzJ0Wa/
 dGP4NgxMJClQMJLTiKV8BkXdNCMCqG6b/di9w8jQruyF47WD+I/75GNs6Ka9hOc+TM20
 r1lDGiM4edW3yD0wr/1LyLXTPCA42yB3bPEuPDT/o+ScJk7RYOKm+G4hG9q+CIIB4Tkx
 GZ2ObhOiVBB5myfVrih2ju8JsG3A2PZftzoQzVW7fo7jV2tbUYNVGeFEzC9NMXkOlWN4
 aXow==
X-Gm-Message-State: AOAM532/tsvamf68OsbhuqRjJpR4dwn1EPbsfIOJzA7cnUwKcfO616kT
 Zc6wjei4OkBsijrs0s6ReEz0cw==
X-Google-Smtp-Source: ABdhPJyb2LovTOR8SHKm7a/HCrHPP9vLFbniKTZI/wkiDJ52R8KmEtli1ehSag8sYU0OtuFDNzD2xg==
X-Received: by 2002:a4a:d128:: with SMTP id n8mr6373529oor.31.1601571020437;
 Thu, 01 Oct 2020 09:50:20 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id h28sm1319594ote.28.2020.10.01.09.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:50:19 -0700 (PDT)
Subject: Re: [PATCH v1 19/20] s390x/tcg: We support Vector enhancements
 facility
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8751bc04-f8b7-af8a-6ed0-242b4ab7ab7d@linaro.org>
Date: Thu, 1 Oct 2020 11:50:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/gen-features.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


