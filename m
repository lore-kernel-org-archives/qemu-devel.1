Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86994C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AA6206CA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5mAIGev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AA6206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRDq-0000Xu-TT
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYRC0-0007dx-4p
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:59:32 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYRBy-0007Yn-9K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:59:31 -0400
Received: by mail-ej1-x641.google.com with SMTP id p5so7796880ejj.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a9Olk69kd9olSMNi8iFn2MguyMxXwYzFphZwaA8YtR8=;
 b=O5mAIGevogIfTQJ920yOfE2FXgMi3866MDuX60ARYFN4RpcrI1nWKsrODemTdyQZNX
 jJSQw9vE7/W7et8VoUnzRHqv/Xjj5SmJYTV+cSaKRTdDjnYIkDXl6yQsjISJouC9X+J1
 /IUXNbVcAwLCyMSDEifxnVElHq0BDl584dDLHwKtVDMecsJymEE23+zEVmrqYfqzSdQy
 rdsTgutlFtjT69SMietgouyNwOnxBX3BwdcYIRFzsHx60W+hnb5xJe8kLxG3gk9i3Mbx
 4lF5xWS+zDKJiPY2Oq1uQujZpqXKDESbY3b6PO5NAfP7I8KJeYo2UVPkAQz33nmPCBOp
 RkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a9Olk69kd9olSMNi8iFn2MguyMxXwYzFphZwaA8YtR8=;
 b=T5zOfLiIyU1vqD4/mnyRcHxweKBL98ip+2W8dFhQE/8tnGwZ0vYQNUohKbi3IwHn6u
 1YMumEgpvTGzRLZrbV2zQUhmEAIJz0jXhOEgv2OR4iCBLF5hSWbZpQVa3l0XFfTX1ym1
 yKPbGX4NShUXNHx9kn40/JTFM2dZnzotq8gWcZkW9B+5yi4WV8gKr5Dt1nBzf+qEzovx
 91nkyGwYQkhHtvNbsV5D2LRSYPzlQTIUTRwM3sBpvpZLm6odSsbr+HHbogG2WJSGAKwu
 MXhjPGlCd97iz3N171z28dIq1CL8xO7wEjPXj6AnD2+jBjxUAgpHb/wE3o+XID43RM4Z
 tCBA==
X-Gm-Message-State: AOAM533Ui8zK/kyqx4d5HmFP4v5/7BpTCnik9XhZjL8CtyNGm9wM8bxu
 bGT+hAd2F9sd/9fV5M6MtsHSu0ItdiOyV1iQzCKY5g==
X-Google-Smtp-Source: ABdhPJyIvCqWQ0H2/0fqxyg/m/hzjoyN8CFx0eZUr2icFMriOx4Y4QF/B4XITXG2NHmNbXXWVu7gw9uLgu4RC5ouHQM=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr1598461ejd.250.1604051968829; 
 Fri, 30 Oct 2020 02:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201029203850.434351-1-ehabkost@redhat.com>
In-Reply-To: <20201029203850.434351-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 09:59:17 +0000
Message-ID: <CAFEAcA86QMsVvPg6wPO5f6ybe2-28-WkDfLLokCt9VktY8e8YA@mail.gmail.com>
Subject: Re: [PATCH for-5.2] util/cutils: Fix bounds check at freq_to_str()
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Luc Michel <luc@lmichel.fr>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 at 20:38, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Fix bounds check for idx at freq_to_str(), to actually ensure idx
> never goes beyond the last element of the suffixes array.
>
> Reported-by: Coverity (CID 1435957: OVERRUN)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>

Personally I preferred the other option (remove the
idx check from the while loop and assert that idx
is in bounds after the loop)...

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

thanks
-- PMM

