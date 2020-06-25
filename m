Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2F0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0D220724
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zElPG+VR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0D220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRiY-0006ex-Ua
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRR1-00046O-LU
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRQy-0003Qo-VE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id 64so5124205oti.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yrWXjVl/PZyY4oGQHClj812uTU/ZYTzk0wUcgSc8Ht8=;
 b=zElPG+VRjjY9hucyR7GHlcSDv5Chp9WiJhn//8BI4jvNuGOwzHaSAGeBhY6olK9ikP
 43Ir7RwMn00lcvox4Qpxt52fmm/Cxms1X6crNrKqqSEIohckIid3W6T2vSAXc5eHGnUa
 xShRh/3nyMv+wwl7Bpu1Sh945JmvPUfmbs/5zpdr61crU++H2E0xyY8NN6uErAIchDFv
 TX3ci+/L2Q8PA8/cOTl1ijDxA+GD1URUpJIAwG+fHfmsQrOrRdjdvukQr7+ABmPAuXkm
 g5pHR6JI9VlbIs/WgOpegW6TiQygQbvPYv6oL7SyEZf/qBwFhCUoOpDFxFZCIMZg/uQ6
 9r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yrWXjVl/PZyY4oGQHClj812uTU/ZYTzk0wUcgSc8Ht8=;
 b=f6jqqgR7yZz91duk8blbFJF8oEz36X12cvnEOO9ZXPvWsSVSkvGDWrKdxZo35UAEw5
 iofG5rlFMIz16ggAv/wIzhGmbU3izBUdA38qvw0mZGVqscTtVSp/+aMWzjCaLUjTagPW
 nMZLTnMsw8zmo2uiyNK4EnUUm+0bvZYUxdXMA4LKPFKowGexhXVhtm3HI+Cf6tzHdEc/
 5nIQDX4vtYN78Xm/lnOoT0uE0ENduG6YS5YGzAva8gihRf/ps6gpQcLVPwUaNSq1Y9wP
 WzXgZkMa+heIUZzlDTCsSiyerbxikpglby6Wz9h08SJxchJcmWGzvFBvpl5b6HWjEMeU
 QCDg==
X-Gm-Message-State: AOAM5304z2QvSER30fUcUbjQzL0TOI8d70Mfv+/95eiGsiNnAHUknqdP
 t42SZ+79aK/loYs0T2jlWdpFIa1EiWaWCmEtdJBQrw==
X-Google-Smtp-Source: ABdhPJwZewCZTz1O4iTMwG/WjOy0Su8KgM9ZhBKjoHYXGwxkRKKMW2QNqdhaMQoe7+PbMkat5pVLlsGGOvBjmWuRNYU=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr25382789otn.221.1593089810954; 
 Thu, 25 Jun 2020 05:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-42-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 13:56:40 +0100
Message-ID: <CAFEAcA9FH4MbkGuvDqu6qMjUTLcgF4TdB1=X9BqksrLcbfjkpQ@mail.gmail.com>
Subject: Re: [PATCH v8 41/45] target/arm: Always pass cacheattr to
 get_phys_addr
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We need to check the memattr of a page in order to determine
> whether it is Tagged for MTE.  Between Stage1 and Stage2,
> this becomes simpler if we always collect this data, instead
> of occasionally being presented with NULL.
>
> Use the nonnull attribute to allow the compiler to check that
> all pointer arguments are non-null.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

