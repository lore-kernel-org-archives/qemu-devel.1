Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FD3207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqdHZN3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEWH-0005he-RK
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jmETk-000364-7g
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:42:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jmETi-0001U8-6E
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:42:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id j198so8549936wmj.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=BFR8jLnFKKzeoiedj3QuphMlqG56YWoxLvBPjARRM6s=;
 b=cqdHZN3lGUoim3IIaQwimQW5V78VYIck3tvM6ETOkgSzqun5sM8fyS13Xgy0ejB+7v
 zMPeHCkhKMhMvTH6XofFMiO6a4p0p6q6T7H37uwpepmVm5femEPCBcIpyYH/uXuexJrT
 CrKtWn4FJMCb4M2vn9B0RUlonng5wZzhrdETTnUJRYV+PArYJKHp2Hnt5CPVc3/zpxWH
 WHZCEuZhasY36RAP+QbNybnUUMkIke77udyXXcr5TfjaX50E17QiQ5CAtfSrywoDMidf
 Xa1sP/dx3TIbbXqgeYvKjmpP7FVobUzSgIXjb65c5+J0H5OlTNiWNVinkhg8ReP8eud5
 n8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=BFR8jLnFKKzeoiedj3QuphMlqG56YWoxLvBPjARRM6s=;
 b=uDGmMAaO1YqFuD7zCl4yehc6oZ12kAtDFweawzHyjdq+SD5zYO2xLPB3fGC8PBSs5g
 XelVecU6jk8UTyj9XofDQNC820lj8MUP+7RQryF4ILZveizSapl/Q5GQw1kMdDUFg+UD
 L3oeN2uhu3IsWzjcG7rTzSdYSqvXs0WWYbbmNMSR444aJS/ZkbHJdi8iPDIGckZwtBbZ
 xVoWQUhOdzKMoustyrcIr2jzfsH/ynWiRIgXJIUVrq7Zv0/tmHCyqY41RqN8QkU8mfpi
 qdWAqOdd8sFaS1o4BlcE8vm9dRqQoLhLzbGPHiJgzBdbWlTChdRVOSplovxZlCMm5dHf
 Jo2Q==
X-Gm-Message-State: AOAM53217Xsumw8BXs7mnV7S0B8uPLVvLLgK2azA7t0Y/tl3/yq4cSxG
 WZg5NMeCgXqO4DkcPCEgH4s=
X-Google-Smtp-Source: ABdhPJwaMMa/gMidMkxVhqK2lMz2pHCDECZBsvrFXbGWiBgBbPmK/XjcBpmTcn0NiMim+ey/IktetQ==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr3057725wmh.1.1592563352358;
 Fri, 19 Jun 2020 03:42:32 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.187])
 by smtp.gmail.com with ESMTPSA id i8sm6717120wru.30.2020.06.19.03.42.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jun 2020 03:42:31 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>,
	<qemu-devel@nongnu.org>
References: <20200619103115.254127-1-anthony.perard@citrix.com>
In-Reply-To: <20200619103115.254127-1-anthony.perard@citrix.com>
Subject: RE: [PATCH] xen: Actually fix build without passthrough
Date: Fri, 19 Jun 2020 11:42:30 +0100
Message-ID: <00aa01d64626$55eec020$01cc4060$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJ4Bmae6BJqEg639TdZnK5dfFEOPaecP7gQ
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 19 June 2020 11:31
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Anthony PERARD <anthony.perard@citrix.com>; Stefano
> Stabellini <sstabellini@kernel.org>; Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> Subject: [PATCH] xen: Actually fix build without passthrough
> 
> Fix typo.
> 
> Fixes: acd0c9416d48 ("xen: fix build without pci passthrough")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Acked-by: Paul Durrant <paul@xen.org>

> ---
>  hw/xen/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 3fc715e5954d..502b32d877a0 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -4,4 +4,4 @@ common-obj-y += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-bus.o xen-b
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt_load_rom.o
> -obj-$(call $(lnot, $(CONFIG_XEN_PCI_PASSTHROUGH))) += xen_pt_stub.o
> +obj-$(call lnot,$(CONFIG_XEN_PCI_PASSTHROUGH)) += xen_pt_stub.o
> --
> Anthony PERARD



