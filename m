Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4287C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B1720EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDWLpd/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B1720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVvOi-0008Ka-4n
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVvMq-0006Tr-Hd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:36:20 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVvMo-00024a-61
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:36:20 -0400
Received: by mail-ed1-x542.google.com with SMTP id o18so1216788edq.4
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jfXHH5WuqJm+72/h8E93hQ4Ys/i5xCqPEgRGw9GYTnI=;
 b=fDWLpd/nAqfyreCQzwVUXf2WOmv/qPLmzP77ulIhc+NjSgFsUV3zysfltr1haBwty3
 hMqS3MphPUl/2zuVg9jhTV9wWUj0QDnabVn/C9/DQqM3ajBREyB+uz2s3fVhbXyqjXrt
 UqC8QngT3Wq5KQ7Ypnt9gPrQjIxRIKyuRZgvYc/l38LANdEY2XnZhizbC27jdCuyU2Fq
 xK8KQEfix1spJt/ZY1l7FosvjBcs19ExVSxCJ62FCTvsA8VcoEwifdCx7/C7u2Xifo98
 cjgGxoToALtIjtH9/NwKqjU+kff2FAKJaVKBvAFZfoJqvNUCk0mWlnJsQXA1t4v6Qm9C
 8dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jfXHH5WuqJm+72/h8E93hQ4Ys/i5xCqPEgRGw9GYTnI=;
 b=Mw7rWgRDrT4QLurL35BnPRMuAVy9kdFwLrbgL0Vd/UJJL8fzjfdYRyB2Q9O0xlFPnz
 DneuWTJpDVoD2OTbeUjFUA4PuHaDfvp40ZaoONy1UZd/lpaGNO5Yh8ifOCU/8+k27OKY
 t5j0SCQoI1V+T94l+tMerXSRo0vFeTt01liMiKEvV3d3jd4f+84k0DgbSn8huls468Jc
 ZX5MCIpEKFvaSuwec/D+4Qvw08s/ha5YCKqV3DmJr2Nhz6Ufo5QAIB7P+dQNw49pEq3F
 jlA5XA9E46ybQWzH5Ck5xGURIp/hgOWnbVt2WXd+A2M8jEuFY/Z8Upk4RKR8FnY54FYW
 crAQ==
X-Gm-Message-State: AOAM533UOVLYSLBS4GBYMV92V7zUfipb7QULG0DA/0FyVT11ltBpqePO
 tKHzL6piRCZzvf6q9Ikd/yTKAARg1efFBuqOGxsQQQ==
X-Google-Smtp-Source: ABdhPJylhrISR29vZ52L+gYRFEtEies0qFQu33TsTrk9ls2T3xhhLlBmhieqwVfJ/4rkUIHm8uuVtB4nrAjYqnAFEps=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr1684811edq.146.1603452976330; 
 Fri, 23 Oct 2020 04:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201023071022.24916-1-kraxel@redhat.com>
In-Reply-To: <20201023071022.24916-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2020 12:36:05 +0100
Message-ID: <CAFEAcA-gEeHUJtuF9CX4XhXh6dnANNut-TJWz0nM8obAmMa3yA@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm/virt: add usb support
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 08:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Bring new microvm goodies to arm virt too.  Wire up
> -machine usb=on, add sysbus-xhci in case it is enabled.

So my question here is the usual one -- why can't we
just use a PCI USB controller ?

thanks
-- PMM

