Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC7C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C50207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="WHZfX4Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C50207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6nE-0008Sb-7c
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6kE-0006um-DQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:32:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6kC-0007m2-IQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:32:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so1523040wru.12
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=PvHAkugYI6mUFLhUjoi9PIM1Uw1E52iGTx5pkdOuhdI=;
 b=WHZfX4Lp0ofYlD6O6T+VXfHCPyRE/0RgMwHeDfW/UzeNmpaSuTCgvYSUg7RrFoR6xG
 M4JeIZYLc4tghvkoLJHMl22/6JdIcX2f3YEntm1AQKchIMXkPoIgTLsVOamLu00iKIkT
 E/DH2PSrjqzHWHmDdHVnDPZ6HGtb+bUl/B4/dK7tfTv2nzth+c1S4eGO99jSLwUanm5U
 VXIIQRDK/JXcbVliweqfSpbtUINDoqy394rfwRxQLlxLBVH3jF445TC8nRLMzkelxTcJ
 YFKH/9ln02USAf7sgIT2hrChiVbCLvQtnWx1NRveF5ySz8KbP3EMM4kjW/ruW9SrUm3/
 wVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PvHAkugYI6mUFLhUjoi9PIM1Uw1E52iGTx5pkdOuhdI=;
 b=lpldStcQEzE1CMt4fAMNfqF6jFJDXLZfLtfzWVbSPnowUQpiws9Xb5s4YNnm5oJHaO
 IRtmbCVT6ZsBWMm9Yt/UAu3AXUDSVefJaL5uPPgmzE9MbEjBVuWGqu1IJ+9QzvObHF0O
 wXt3KkGEAcHkHKr5Q5Kyq+jPP/fCM7UMniOniVtYxeRQI6qaY3t/SLz08iNIKmMpfkVq
 EKExglEDX5c0KUdDP0p0Bc/bSSZuB61LAyzCnmLc9aElWf5sf5HnGHjy5/REsu7yDANN
 jNnXYOXD3JlCnJlzcXA3dwrmmrGaNKBa7kPLu9VuvmLLE1oSbOAIfqzMV3JZaG3Xcfzn
 4syQ==
X-Gm-Message-State: AOAM530l5NFqpJgrkGX0QDH3SAUZS8ehJ+n9HqDp45k4KGUPuoYk2Nya
 s+SbNfy9tpnThw107VsGJZYThA==
X-Google-Smtp-Source: ABdhPJyGvY05N41u/VSfwBc8MdO5dX9xM3Tx1jwC44mLaMtXsPsARzJAcEITcX5pm/uozfdi9cl7jw==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr2578845wrv.195.1602066742984; 
 Wed, 07 Oct 2020 03:32:22 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id g14sm2320666wrx.22.2020.10.07.03.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:32:22 -0700 (PDT)
Date: Wed, 7 Oct 2020 11:32:20 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/2] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Message-ID: <20201007103220.z5pc5qjoyxbowyrb@xora-monster>
References: <20201007100732.4103790-1-graeme@nuviainc.com>
 <20201007100732.4103790-2-graeme@nuviainc.com>
 <c518a446-94ca-f21a-2e49-e2cd8171e581@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c518a446-94ca-f21a-2e49-e2cd8171e581@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 12:24:32PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/7/20 12:07 PM, Graeme Gregory wrote:
> > SMMUv3 has an error in a previous patch where an i was transposed to a 1
> > meaning interrupts would not have been correctly assigned to the SMMUv3
> > instance.
> > 
> > Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
> > Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> 
> Again, this fix is already in Peter's queue:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg732819.html
> 
> But if you repost, please collect the reviewer tags,
> so we don't have to review it again. This one has:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 

Ah I thought splitting the patch invalidated Eric's reviewed by?

This is a different fix to the one you are referring to, previous one
was in PCIe.

Apologies if I have missed an email from you but I have not received a
Reviewed by from you for the SMMUv3 IRQ fix.

Thanks

Graeme

> Thanks,
> 
> Phil.
> 
> > ---
> >  hw/arm/sbsa-ref.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index 9c3a893bed..65e64883b5 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -525,7 +525,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
> >      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> >      for (i = 0; i < NUM_SMMU_IRQS; i++) {
> >          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
> > -                           qdev_get_gpio_in(sms->gic, irq + 1));
> > +                           qdev_get_gpio_in(sms->gic, irq + i));
> >      }
> >  }
> >  
> > 

