Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D48C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4441F20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsdGyXlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4441F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngHx-00066r-Jk
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jngHN-0005a3-1u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:35:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jngHL-0007uU-0t
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:35:48 -0400
Received: by mail-ot1-x342.google.com with SMTP id v13so16070241otp.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bIkwkdvNiJAf0orWIsRcV+UMCPxDrTLTXZw1i+6s9m8=;
 b=jsdGyXlM+aozS095vIDQ9z3AsMIz2IuqvFkoRBLOHjAs2YFVra9Obs8pqRn/1N2kCA
 /UZQ7+V2uZ9q7LDElnCRdouBeEBcxeCj4bzwVos11VvG207PKfFJbefraEv3BipqzY3q
 tWDJkaCMD6OcUQvVGA5GzhKADn2+ZDRzPaLePVEUBD+kwzV5wMYjlCLh7PbyBlRu6k9Y
 YXvLk5zhMtILKsspnH/JLKcR/3VQTlmXU0pJAmwAd7jc+1ln4dh2iUddq7nhXCIKwmqP
 gFJWd7icMnFwhFl03riL14MKEQ6Ppz5PAmGOAccGXXyXXO43aKVvnxHwlWJO/1GQxIkX
 ifeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bIkwkdvNiJAf0orWIsRcV+UMCPxDrTLTXZw1i+6s9m8=;
 b=kwc/eVMNDLFPC8v4x3sN+yzXB1GJGvmOfSVc239AHtR/ldLawuwvKmfVWhbiSONKiq
 jBZhXMLU6+1X8K83UGYgOGsSqp8GVEFedSRtF5vvqCp25di/yyqVAthiS1mzaYVEgKB8
 yYHnKP8/sXJzzrI4BqqAELr3fE7sZIVa74VS6NX900c9y2wWE3o68MJVELVl7xrlGqQR
 rrewC7Jec7qrJx8kCVQNtTwvLlQs+O0ajqkHH/0WftLWHl9YZov2KNckj/wECPh+Ma1n
 KxVMQS5HJ9D/rckbxmmI5op374rvtUCCl0GlXnMkcy2rKTkmc96OHvj+muCGiRmGoRoQ
 YbHw==
X-Gm-Message-State: AOAM530FPDwCbyLbyogGS5IqOBVWXPpGwabXZPRdX8VUUpTkLrcFFROB
 UI/x3a+2KDb8YidGPN8eY/0iK0vEHaHcSpfu6WnO2g==
X-Google-Smtp-Source: ABdhPJxjoO2Hzb/jopFLxXuQ0nZMHBSKzskC5XtkO6vOi0BpS60Ao3jg0qwxazSMsE6nux1hmiAl5J7DDyRBznGuwEU=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr16897084otn.221.1592908545318; 
 Tue, 23 Jun 2020 03:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200623090622.30365-1-philmd@redhat.com>
In-Reply-To: <20200623090622.30365-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 11:35:34 +0100
Message-ID: <CAFEAcA-HJ0Zd5Ad0EO3SeOue5NWyg=FSVwUquOQKweYtiBkJLQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] target/arm: Fix using pmu=on on KVM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Andrew Jones <drjones@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 10:06, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since v2:
> - include Drew test fix (addressed Peter review comments)
> - addressed Drew review comments
> - collected R-b/A-b
>
> Andrew Jones (1):
>   tests/qtest/arm-cpu-features: Add feature setting tests
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   target/arm: Check supported KVM features globally (not per vCPU)

Applied to target-arm.next, thanks. I dropped the Analyzed-by
tag from one patch because I think we ought to stick to a
standard set of reviewed-by/signed-off-by/acked-by tags.

-- PMM

