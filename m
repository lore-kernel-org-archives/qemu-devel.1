Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34985C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046C62075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE8ThPpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046C62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEa7-0001nK-8s
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhEWw-0007uh-Ns
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:45:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhEWv-0003jN-8L
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:45:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so10227232wrw.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tL5J6Hd3JvlTt0aX0ePnrWzaiIT3jWKWAlVfhYKG2DY=;
 b=eE8ThPpNrDTqi+g9ih+FvKZm+V+p1bWySbjsISUr9jkVN7u+48g720ae/W/rLRTg7T
 GUBo0kX43LZkHhGd6NQdm7TPMzSsSUluJ2wEqbkuZYGKTS9xpMbFxc/L98VrKIX8yIu9
 VmN0W79jy5k2yQ97ki6K3Km3oNKamSrwFhKkw2SnA8BcdB6LUm7Ao3HIT1eKNY48IrWr
 hLYOAx1jprmjeNXtc+7x7qA0sjWs05uNuRwNrKVRWzcwoG4JVVjf/lNAItNM5BpAgv5u
 HhKBL9yPDBoOSd+If+Tk6EJmU9isqrCBU/4v5ggg5pZJAp20TAGV6ic47ufcicG9zP4t
 4M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tL5J6Hd3JvlTt0aX0ePnrWzaiIT3jWKWAlVfhYKG2DY=;
 b=uab69HEA05A+DSb5f2pRBdZVoCdSX+r83AeQTfJGMpxujk0nksKfp7tCM6JgMauk2/
 FMCDUsZAbnbrBdxXHd+mBLTgCixFbsizL69IL7ek9L0gGTQVrCFfkBFYCo3OHYcJH+N8
 +EonoTfLxRJhbPitNoHv7D3m+Xu1zAGa4pFsDoVz4+qyLW9XhkmrRBUdkrF9wEgvOJDB
 3hQ9AEJLcGHIOJQEJF/m9gBwtuL5AsozfMOQgNEuZ5angmoR6BLdVnYs1bLsjrrR2tSM
 uV72MOuwP5HhnTbntBU3oVa90i4zFvw7PLLCo2yrY1n0slrmUXphelER7oblH1AknkZY
 vjxg==
X-Gm-Message-State: AOAM532nFKwYQZUiJQ0lct9OJPFiFB6QMsFK9MjIlFWXboViD1oAyfJm
 jrOmrjCjFao6tmKmuLKBx5xCJUy0
X-Google-Smtp-Source: ABdhPJxKKko1vzqQYnsv6qG+H0S0kCakoFt4TllzuheAsRPMSBjXgDYYHeD37NUPM09oQR91xexxEA==
X-Received: by 2002:adf:f812:: with SMTP id s18mr9714436wrp.28.1591371911163; 
 Fri, 05 Jun 2020 08:45:11 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 23sm11349607wmg.10.2020.06.05.08.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 08:45:10 -0700 (PDT)
Subject: Re: [PATCH 01/10] hw/intc: RX62N interrupt controller (ICUa)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
 <20200531162427.57410-2-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8085c267-affa-ceab-1e90-a36643424835@amsat.org>
Date: Fri, 5 Jun 2020 17:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200531162427.57410-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 6:24 PM, Yoshinori Sato wrote:
> This implementation supported only ICUa.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/intc/rx_icu.h |  56 ++++++
>  hw/intc/rx_icu.c         | 379 +++++++++++++++++++++++++++++++++++++++
>  hw/intc/Makefile.objs    |   1 +
>  3 files changed, 436 insertions(+)
>  create mode 100644 include/hw/intc/rx_icu.h
>  create mode 100644 hw/intc/rx_icu.c

Good news, no logical change with the version I sent:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708323.html

