Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23DCC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7FA206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJCBE3Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7FA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxSv-0001O9-SV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyxSH-0000m3-QF
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:09:41 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyxSG-0006uc-7Z
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:09:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id c25so6910178otf.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pf32PZHwbkGJ++SA36ZGp4vhRgp3xAk7ye74M190BWQ=;
 b=WJCBE3RngW1ZZGm45D6GnogkZORpAeQ0GxIa07hDqu8KgTVpQT7TplcpKMDTiiJ+Yr
 ZpX2HytlcaGxzk/rzseKs6PoZXy6pUoLG5WOC/1zEXoJB0aeAcJTVXvVtVHe9U8j64CS
 OlAd8y+0wTFYzTLH8zISlWXpq1yRgm49X4nzeOua9JIs6qpwqSExz8sN0/Oc+Y8Bx2ID
 o7t+GJ4/HLgp7pEGvprpt02f+6RAqwo4vELB8mA/xKRquNi8zhCQ3vitI70E3+FUKoRU
 8suGPV4ioJ9K9Fz4Y5cFJsYVg6yWy0Roqkz4F3U4FpL5x+JVooztwznve7tBSbR0PRJc
 awRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pf32PZHwbkGJ++SA36ZGp4vhRgp3xAk7ye74M190BWQ=;
 b=cp4s1XWJBjPTvuORvPaLFyptw3LkPZplLHtRApRu2myCZnonnojNIl83fZAOI8pvBB
 fW3/LiY1FE7rT9zA5m6xBsR4+J4uUI+GBnpN0Hg0eJDpgBlujbV6zvpeODO90bO6Vz3j
 FOu+1ZWGPnBKUnlOjcG5QKQUM309Kc+LdaNDVo1QTQw1n2dnlKTDYr6KA8S+HcL8vpZz
 DKCE8Y82im9Xql+EnvT6/bP23Cq2bgudsZtu6gwUkXvmWffKXwBiJGb3ixPVEzRaa0Ti
 Jwyph5P0YmoyllwaH8dwBZf7MSoeyHwPCneUDyuA3+K+qr+lIk6d63p4TQc4s9SSVk2k
 O0Rg==
X-Gm-Message-State: AOAM533PUbJS9exxVeYHp9rTgGWvfFDMgtrEceITHYKh41uMnbzR2wXk
 RISoE98jm4kZABIFIU1kEPU75iJMAqR2sJ6Tws0Ndw==
X-Google-Smtp-Source: ABdhPJw1UBu6GWk5gj9siNwjPxjYqkY78gUGZ9cR8JDkdrEM18fbGxfxUsukVWZQwpl/5WhYqERDMHUdrdzcwh/+IkA=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr8661396ota.91.1595596178472; 
 Fri, 24 Jul 2020 06:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200622113146.33421-1-gengdongjiu@huawei.com>
 <CAFEAcA-NDpWCfqQybu=6svi-ZR=MBBxSKz4dRikDXwW8fftsaA@mail.gmail.com>
 <20200724085448-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200724085448-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 14:09:27 +0100
Message-ID: <CAFEAcA_Gk4o5tB27fo93HaxXO1xxk5joZZyHxFBvLFrPhD2qBA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Assert that we don't run out of the preallocated
 memory
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 13:55, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 23, 2020 at 06:50:06PM +0100, Peter Maydell wrote:
> > On Mon, 22 Jun 2020 at 12:30, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> > >
> > > data_length is a constant value, so we use assert instead of
> > > condition check.
> > >
> > > Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> > > ---
> > > 1. Address Peter and Michael's comments to use assert instead of if().
> > > https://lore.kernel.org/qemu-devel/ca79ea28-9ea9-18a5-99ad-25c3eb744721@huawei.com/
> >
> > Oops, looks like we forgot about this patch -- Michael, are you
> > taking it through your tree or should I take it via target-arm ?
> >
> > thanks
> > -- PMM
>
> Feel free to merge pls.
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

