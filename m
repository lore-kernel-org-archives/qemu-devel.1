Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F941C7618A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D3720838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By9wl9u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D3720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmuMO-00046I-6s
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 02:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42305)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hmuME-0003fd-7N
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hmuMD-0002gO-9T
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:21:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hmuM6-0002bT-AT; Mon, 15 Jul 2019 02:20:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id s1so883053pgr.2;
 Sun, 14 Jul 2019 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=eZg7ZrLtYWslDxuPFhpIqd4M6gwZHOXSSdnLe/ew7vY=;
 b=By9wl9u0QYnK8kJWxmFJLX87L41lMo0fGH14cq6R0CXbBaU1MkrGEJ+jjvK42KP39Y
 dXaZpplnImU2N1Xe4i3yXi+PMaXkogCBMnREnrAy4Y/iCrrfVTr35ouwsz1EJVEsWxc/
 qU8rcM5VJeWXEXON1gTbf5AZIrM3ubNc08BtwcobHo7JLPEdD+h3n0Qswi1Lgm5ZyG1F
 nHYAcgy7+t6Bbtmmr5NTQaJ6WZYP5zNGzlnUlRG3X/ycTKwiqUorjlpAUF0PRFkBh9Gx
 LZZHsWXueOk1Pf2xGiNfPnGlDCyIsXgSDg6eGfL9aTMooqpce3BhMUYRH/1nqwsHiMrG
 n0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=eZg7ZrLtYWslDxuPFhpIqd4M6gwZHOXSSdnLe/ew7vY=;
 b=U2GAwdvVjCQ3nfZZkQstu5do7DJjawy6hraUOrHyJR7CG4p8f104l79axa9ZWoGucq
 F/0lr6lWz9XH6ZkVx8AEyaAz+B4o4MhcWe9V4C+NiBTdc72oTqIS+yYBQ/SyR0oGmOjV
 bBErOT7Z+2s2WPqn5kUwrEIBBOKShfSiYuZ7ndOzeaTdY1lT2b9P/kddaSHxvWJxsgDO
 xvd5b/XeWB0yl5emfuDmVAbeg/ZJbtLATH9ckrClWqHPUTU/lz0gpvx4Soagfl0bZABX
 UnUnE4n8qA9k59w0LXAWQTggFmYwZW+PRyTEMRTOJw3RasjbZ026vFanzreFIizHU7jP
 nmrw==
X-Gm-Message-State: APjAAAXsPPBFEczs+5qdEeaz+SSRZzTp6sQnPerIv/8t806eU7txaSKj
 FGDwgh0ztjRdfsM2nCTaVJHBL1x7
X-Google-Smtp-Source: APXvYqzjYfcp4TgsMTTYFHMX/3ZwXv+IvYR026qvOlbENQVDy6KT8OQBlvzkyJabDxQNU48bDrjGAw==
X-Received: by 2002:a17:90a:cb97:: with SMTP id
 a23mr26854886pju.67.1563171656829; 
 Sun, 14 Jul 2019 23:20:56 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id m20sm3392023pff.79.2019.07.14.23.20.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 23:20:56 -0700 (PDT)
Message-ID: <a5a7ebddcb737793aa7d6ba84db93b44e00cf7ac.camel@gmail.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Jul 2019 16:20:51 +1000
In-Reply-To: <20190715061925.28030-1-rashmica.g@gmail.com>
References: <20190715061925.28030-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 0/2] Add Aspeed GPIO controller model
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, clg@kaod.org,
 qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doh! Forgot the v2 tag!

On Mon, 2019-07-15 at 16:19 +1000, Rashmica Gupta wrote:
> Rebased on Peter's target-arm.next branch.
> 
> v2: Addressed Andrew's feedback, added debounce regs, renamed get/set
> to
> read/write to minimise confusion with a 'set' of registers.
> 
> Rashmica Gupta (2):
>   hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
>   aspeed: add a GPIO controller to the SoC
> 
>  hw/arm/aspeed_soc.c           |  17 +
>  hw/gpio/Makefile.objs         |   1 +
>  hw/gpio/aspeed_gpio.c         | 891
> ++++++++++++++++++++++++++++++++++
>  include/hw/arm/aspeed_soc.h   |   3 +
>  include/hw/gpio/aspeed_gpio.h |  92 ++++
>  5 files changed, 1004 insertions(+)
>  create mode 100644 hw/gpio/aspeed_gpio.c
>  create mode 100644 include/hw/gpio/aspeed_gpio.h
> 


