Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72448C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEDF20781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqHXuvYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEDF20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4ZN-00052O-9k
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jo4YH-0004W4-Li
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:30:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jo4YE-0002F6-SE
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:30:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id g18so2117239wrm.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=d+a2gUl07F0ZUgzubj1rIDmfWgWm8vAiCo/wzafStfg=;
 b=uqHXuvYP10Vfc0poUxXhoAxEgjcIOEKhkTloMAvbcLBCZNNqTkYtQMPApfgO18u3cB
 /CjHFcGhlH+WNzJ3gTBlXdS3cPgBlS5znOzL0sFYoI1hpB+nruuUTli5CY1+Wqj9cE4l
 dGsUywTZtDFutOSW/aUsKBBfda+WAVvTuGjwoQCthysU8PAMstXG20v6Qi7Y758jkNzY
 SkK1ylLYAY2UZbAgwnodHtBMDNBrVObeYksrROuZ5N1k10QiQs45SMGqb6YUsWIWszUh
 0KgEZlsC4evnsw7QLCNOUs2i7fLJZIjQ0Kpa33u8xYDgfk0M5g+ye5AzynukYUjfcEW6
 Bkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=d+a2gUl07F0ZUgzubj1rIDmfWgWm8vAiCo/wzafStfg=;
 b=IbT1SC8pv5IWo9fuAejBciJOKMrscUQuVf7W2pliCYMVUFEBb1m5FeO5WSEKv4oe69
 K6Swf+mzM3gGAYOOJh8AMcZq3mcAg7nNjp89akXmi/iLRLlHfALCi17FadIWWrqlcZPO
 rdSF/pJgP4J+zGmGKsc+PdSqAuzosAL+YLoImx3kcqfQHXgmafJnk2LTQO95jW8kHWUU
 ZTuVUp7wn1YMBPrBblMwSHqpTKpmdSY4MvlbzI+U/5YAyofsu60zRKURDQ8JqAfLZzD3
 0DJLk84Kthh6LKfWxtIzzLOKC58TrWRfJ5bpuIj+g1D2aUbwcCWKnPMe8BlrA5jpqrNs
 zXSg==
X-Gm-Message-State: AOAM532xY02jl6a7QejoUrYTmEgiEIZGFKq55z7lzPQoq4ec8xloKGqK
 HaAzytiy1MhTmY682PVUDWg=
X-Google-Smtp-Source: ABdhPJwdWkiuvxZQhBc8cWxD+knonuDTYnM/NcsBtM505tCqOyS8b6fo/jwqWpAgEy4bxAdZstRHzA==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr25769251wrm.282.1593001849266; 
 Wed, 24 Jun 2020 05:30:49 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id f14sm9612823wro.90.2020.06.24.05.30.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 05:30:48 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Jason Andryuk'" <jandryuk@gmail.com>,
 "'Stefano Stabellini'" <sstabellini@kernel.org>,
 "'Anthony Perard'" <anthony.perard@citrix.com>,
 <xen-devel@lists.xenproject.org>
References: <20200624121939.10282-1-jandryuk@gmail.com>
In-Reply-To: <20200624121939.10282-1-jandryuk@gmail.com>
Subject: RE: [PATCH] xen: Fix xen-legacy-backend qdev types
Date: Wed, 24 Jun 2020 13:30:47 +0100
Message-ID: <000a01d64a23$4a595e90$df0c1bb0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJVIeVpfNhOuJ/7wV1uDlt3SOiQn6fqAo/Q
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Jason Andryuk <jandryuk@gmail.com>
> Sent: 24 June 2020 13:20
> To: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul
> Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> Cc: Jason Andryuk <jandryuk@gmail.com>; qemu-devel@nongnu.org
> Subject: [PATCH] xen: Fix xen-legacy-backend qdev types
> 
> xen-sysdev is a TYPE_SYS_BUS_DEVICE.  bus_type should not be changed so
> that it can plug into the System bus.  Otherwise this assert triggers:
> qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> failed.
> 
> TYPE_XENBACKEND attaches to TYPE_XENSYSBUS, so its class_init needs to
> be set accordingly to attach the qdev.  Otherwise the following assert
> triggers:
> qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> failed.
> 
> TYPE_XENBACKEND is not a subclass of XEN_XENSYSDEV, so it's parent
> is just TYPE_DEVICE.  Change that.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Clearly we raced. This patch and my patch #1 are identical so I'm happy to give my ack to this.

  Paul

> ---
>  hw/xen/xen-legacy-backend.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
> index 2335ee2e65..c5c75c0064 100644
> --- a/hw/xen/xen-legacy-backend.c
> +++ b/hw/xen/xen-legacy-backend.c
> @@ -789,11 +789,12 @@ static void xendev_class_init(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      /* xen-backend devices can be plugged/unplugged dynamically */
>      dc->user_creatable = true;
> +    dc->bus_type = TYPE_XENSYSBUS;
>  }
> 
>  static const TypeInfo xendev_type_info = {
>      .name          = TYPE_XENBACKEND,
> -    .parent        = TYPE_XENSYSDEV,
> +    .parent        = TYPE_DEVICE,
>      .class_init    = xendev_class_init,
>      .instance_size = sizeof(struct XenLegacyDevice),
>  };
> @@ -824,7 +825,6 @@ static void xen_sysdev_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
> 
>      device_class_set_props(dc, xen_sysdev_properties);
> -    dc->bus_type = TYPE_XENSYSBUS;
>  }
> 
>  static const TypeInfo xensysdev_info = {
> --
> 2.25.1



