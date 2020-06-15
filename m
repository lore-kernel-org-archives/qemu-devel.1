Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A632F2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWIGTMdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A632F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkooH-0006Ho-WD
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkon0-0005MH-TB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:04:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkomy-0008Rv-2f
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:04:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id n6so13046503otl.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JguV7BhL78zJ/2cdSQDchhaNUbr/PRxGfGj+dwMzKjk=;
 b=aWIGTMdPUOntIKTS12QO93f6m/5v9V45LSVHh7mM3TU1kyFP2B+qy4iAY/oal7qTkj
 1dSfEyT+YCSrWzDZHrsnLBEv+LUNlPbNvHKd5DyRqvPjwnKruIBwo13ClcS3MDF4zHeK
 E/P9tMnOHuqVNTthBkOtPwk56eXzbJDmwDC8G+fn6o0oif3x2F1w0+WLRazTIARzfLIu
 lmkufGK1RbSAbi+0vqTPoq2tMNlO95C7yW5d7BDNJHum7zVtrf/cY/s2GE0Gp0/2vJO/
 pcIuCvxdsof0vl2+w8LQyGEMLlz/uTk/preQ7ZBugVTSaMObs6hASkSWVhkVDuEZX39T
 D/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JguV7BhL78zJ/2cdSQDchhaNUbr/PRxGfGj+dwMzKjk=;
 b=V2RskSXVftT26a8gERZ25LSbcZWOsciCB0T6LZvIeLVMZlH2qBAO9D1kQF3pqDXtIc
 or+ZV7G8ZUZKg674GbE+YZWEo9OB588+X/B4Rde41ME3tQJzcL3dpvvwWBqrwtxZzYTU
 2USA+c7Sn8qum30MCITQajLNk+yAgWQ6Uuf8uhHloULB7p30TwSh2n2wmTcHBdMhHqss
 ktjHEMGCBHFyjccRfaVAWoBx6MJaI8i1epz/9PF2KSvl/fFZjarN3jMgl3GLub6CpAs1
 XdbJNPYNfx0Ck4T39hvCncqUPGKu9HjkvON9fcLlH8zs9geQsqPRoXpvafXZuA2DMMxB
 pxmA==
X-Gm-Message-State: AOAM531u+lZYMJcpevdozojZ/bDG9okQjCwOvT3R2uRRvs/YKAPGrvYK
 I3CV1f/GckRMMiUb7RXjO4lWbVGXeqF/48gd7hQKNA==
X-Google-Smtp-Source: ABdhPJxJiEIiI2dw4iNXqVocOCb8KggO6za+dyemGYNIHTx8IZS27yfFLEEAvsij28i4HExHDECgt3pdXWTNoc1MMps=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr20366752otn.221.1592226274970; 
 Mon, 15 Jun 2020 06:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591272275.git.jcd@tribudubois.net>
In-Reply-To: <cover.1591272275.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 14:04:23 +0100
Message-ID: <CAFEAcA_zXdpCNnR-v3FQU1zKb6qYm5v1tAsNm__yiC1tqPWyzA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] hw/net/imx_fec: improve the imx fec emulator
To: Jean-Christophe Dubois <jcd@tribudubois.net>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 13:39, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> This series of path makes various improvement to the i.MX FEC ethernet
> emulator.
>
>  * PATCH 1: Convert the Ethernet emulator debug output to trace event
>  * PATCH 2: Allow Ethernet PHY to be at any position on the MDIO bus
>  * PATCH 3: Improve the i.MX FEC related PHY emulator by using standard
>             header symbols instead of hardcoded values.
>
> Jean-Christophe Dubois (3):
>   hw/net/imx_fec: Convert debug fprintf() to trace events
>   hw/net/imx_fec: Allow phy not to be the first device on the mii bus.
>   hw/net/imx_fec: improve PHY implementation.

Hi; I've applied patch 1 to target-arm.next and left review comments
for patches 2 and 3.

thanks
-- PMM

