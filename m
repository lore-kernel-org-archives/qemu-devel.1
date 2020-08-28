Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C954DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9305820848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="IgL70+wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9305820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdOe-0006dQ-Pr
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kBdNm-00064p-3a
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:21:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kBdNk-0000t7-DB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:21:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id w5so324150wrp.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HY2nAYSnjnPijvGELfAuvz60krWapW0OG8bbFERkYDM=;
 b=IgL70+wSWfd+FjC42IV6fT75SwVaftU9TtybrOfiMn0pNyvE8JAOIe8P/qm8SKu3WF
 su0bhS4/1ZSNcCksoRhnm9ib2EI6qqsDTf8NCv4eQqdLKFGT0zdXDDa9hxgmYaE6XXuX
 mj0AE0qAZhgTmS+ZNJJirV61MbXAdLjys1QWDfEFrhktU7+jD5/BvN/JDD6IPdtul6Lo
 t25g44f1gdOAdpszUiu76dPeIJLynp+I6GMub1hCbWfkk9ge+5rt9UXqfTvUl2sxTWmi
 jRC+uMDazpkZNiZJE5UBcuSEUArVn+eVcZtBqpci+8AMLEGSzkPCvWKAvKciRnJyOBf4
 OXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HY2nAYSnjnPijvGELfAuvz60krWapW0OG8bbFERkYDM=;
 b=X6/spou8MLEpS+gs+gxFz73/IZNUp8Ba8kRhEYnYO8JrTVCAFnZ+u2+8n2k5RfChB5
 3/LlKicaQAQx56E7d2AZ9DjiLWc6k1taUUBDvoki3LWLbxmjC+QRlQE3YG/zDqQdsE3d
 51Yt6/q051SgETn3at50mARuwPZ57ssKlVQJ1g47rPGt9IWpjqBrHUilEoctqURJeyra
 XyFy/ry/Gy9tDR7hZgHG3jpnU+LksToSDPZ0cvj2S02NWb0IUJc1tbN/uqTkxk1ryqLu
 NE+aZ7nloNYvoCDYZyDMSSEp1fdO3GCIhktDrpkOrtkIoRc2sDU2qtV5NIXQMrKmOstn
 oPoQ==
X-Gm-Message-State: AOAM5302+KX1R/k4jvweYj1caHaIt9DYhkvrI+mBL5d2HICPnGJeYAWq
 pGs9OAVA4viJL99p39Oynf8caA==
X-Google-Smtp-Source: ABdhPJytE72nzLEXfXNyeADjz+uMoqRugxF1ZrWxB/xztq3BfZUI20e+9c9FKYwwB4pdP8W23zQxwA==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr1368838wrv.280.1598617282753; 
 Fri, 28 Aug 2020 05:21:22 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id 128sm1916186wmz.43.2020.08.28.05.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 05:21:22 -0700 (PDT)
Date: Fri, 28 Aug 2020 13:21:20 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Graeme Gregory <graeme@nuviainc.com>
Subject: Re: [PATCH v2 0/2] Add an embedded controller to sbsa-ref machine
Message-ID: <20200828122120.GZ1191@vanye>
References: <20200826141952.136164-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826141952.136164-1-graeme@nuviainc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 15:19:50 +0100, Graeme Gregory wrote:
> This series is to an add embedded controller to the sbsa-ref machine
> so that PSCI can communicate platform power states to the platform
> which in this case is QEMU.
> 
> v1->v2
>  - broke out the EC itself as hw/misc/sbsa_ec.c as seperate patch
>  - applied review comments to date

For the series:
Reviewed-by: Leif Lindholm <leif@nuviainc.com>
Tested-by: Leif Lindholm <leif@nuviainc.com>

Thanks!

