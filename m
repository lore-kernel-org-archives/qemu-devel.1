Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633A1206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfK94Kbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633A1206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5bhX-00030d-N3
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k5bgn-0002RT-4G; Tue, 11 Aug 2020 17:20:09 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k5bgl-0003OJ-HV; Tue, 11 Aug 2020 17:20:08 -0400
Received: by mail-oi1-x243.google.com with SMTP id j7so13591899oij.9;
 Tue, 11 Aug 2020 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=yVCa7nTlkdZVDElL8pNK99boT/0lkvSRbHCvDo9h4c4=;
 b=qfK94Kbp+0omRwH7MQbY2d/62XmQ8yLNAYmBQE/kiF0ucT0A1NunwFbyzaNUPgREln
 h8Aym02ie4Wg4qOW00s0PHTizOikKcWNvRqXIXzuNUkHnno8p8d8c8/0ic4waUv9uK1O
 Ao6UNNCACDPVwCol3NqaAY0jkJUz6uM9Uqld6IZaosg2ocmtWA8KhjOQ5K+bCzsydj1J
 35kR8YHeK0p5IbgcxWKtXQ7ppGY9JLHRSvFJsj5/bg/Ar58JVH+moa8+GgP2H4cD29zf
 IGTR2aOe3ogpG4uKKoyZWYnJm2917K0XM55v2MZfi4EDMknAxoHpxFDT5QDKpvvpsMeE
 OQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=yVCa7nTlkdZVDElL8pNK99boT/0lkvSRbHCvDo9h4c4=;
 b=dht6LGkQp0iTrsJOxRZBCWLYsmAPJIJ1/m3LWvA87Kf3DxgMgfgau2mEOmWa0CBmSl
 vBVF8ht+E/gjED9E1movVMmy4cZtXcjEIR50Lplp0cgEJ/8PIuy4rCPfrcJ1mMOt2Crp
 uZKhUexH6WLUuzdoQHUbDiL48AmZg5TCfSfzSe8+yuXUjeMuI58Y851U/W50kOmrR8Gy
 LPxMMdCnOJLYVK6zNapHAhnB2bwnNPuugua6Y2oZeY3Puq3BV2sDThHBrszXamrxLB/y
 FDviG908TOTNNTxxTbvDlTPJWrpb3q0KLMGFf3gnrjPARdK+0fGogkOx26IFPLF5CuyO
 YFaw==
X-Gm-Message-State: AOAM530bPD0XFrvgo2Ds+JN6vAcXcMlONg2PbDmf3j/BmWC0BntgGTxG
 BIyuaYPR5vUvflYEhtKgqQ==
X-Google-Smtp-Source: ABdhPJxhQS0Rqe7j4QxwwT0X2I+P+nnHjHGHJUGouUtl8s5T/VNoYm+Jre3QcI/OLOTEIyOLQe88zg==
X-Received: by 2002:aca:b742:: with SMTP id h63mr4962088oif.148.1597180805277; 
 Tue, 11 Aug 2020 14:20:05 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id a187sm4653049ooc.19.2020.08.11.14.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:20:04 -0700 (PDT)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:e89d:28cf:2a26:b7f3])
 by serve.minyard.net (Postfix) with ESMTPSA id CF52B18054F;
 Tue, 11 Aug 2020 21:20:02 +0000 (UTC)
Date: Tue, 11 Aug 2020 16:20:01 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 1/3] hw/i2c: Fix typo in description
Message-ID: <20200811212001.GS2842@minyard.net>
References: <20200811151643.21293-1-philmd@redhat.com>
 <20200811151643.21293-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811151643.21293-2-philmd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Cc: Corey Minyard <cminyard@mvista.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 05:16:41PM +0200, Philippe Mathieu-Daudé wrote:
> Remove the second 'and' introduced in commit 73d5f22ecb
> ("hw/i2c: Document the I2C qdev helpers").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Well, it seems rather obvious that this is correct :), so:

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> ---
>  include/hw/i2c/i2c.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index a9c030a512..f57808851e 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -102,7 +102,7 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>  I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
>  
>  /**
> - * Realize and and drop a reference an I2C slave device
> + * Realize and drop a reference an I2C slave device
>   * @dev: I2C slave device to realize
>   * @bus: I2C bus to put it on
>   * @addr: I2C address of the slave on the bus
> -- 
> 2.21.3
> 
> 

