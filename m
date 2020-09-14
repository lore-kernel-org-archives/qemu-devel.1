Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BEBC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25D8208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pri0/Nm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25D8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoMJ-0005zs-Sz
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHoLh-0005Oj-QO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:16:49 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHoLg-0007Rc-4j
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:16:49 -0400
Received: by mail-ed1-x541.google.com with SMTP id b12so17523774edz.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eZODd7CHTsqOjDvsLrCZkBD5wNp5PDRol4DS/R3i15A=;
 b=pri0/Nm5gB/E+oQrAudSZV3NMCJBHkL6vTX3hsPIXtdyByosIrSjLBoE4Cs24hjy0b
 YuKCiOXYMWwAdRgxGZFJ4Cjx88dRj9B0OT1rN61rUtUuJ894DuxRHiEnahxrniLAChNR
 BA61u9E5nFPi4dFod7sW1ks15HDCKMvE7ZNSM+kJ2sgLpFuXvq68xIQe85LZ7czu9IPF
 vR47lvzBfudhACo5k2Ctf6GO9NpOwFu/jc79IQ+yWMwx8KaO6Q6AxPjh6Tkc+ky8Bsom
 EbSjm+OEn9nvCujLsDN6GNugK4wBt1nN/z4LqLXRB2wkRB4FuoRIGmDTewG+XWQDvOKM
 11mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZODd7CHTsqOjDvsLrCZkBD5wNp5PDRol4DS/R3i15A=;
 b=XG7u8LMXYEv2u8yvnjZehZHhJXS7IEasxrpEI9BS855UC58gWHHFJB916cup5sxCfR
 xbV9QDE6UrF/aWrxbBsartF/MWPazEnwJC4V5KspdS8l/7WtgIGzNzlDaZ8s1GALV+gK
 1BeSdlvnegDJk4+9LXH26KUsBKB7gzbB/7kKRFErmGunJr+2XcYr3sL4Tr+1uwo63iZ1
 FGEONxlge5mby1rv0IzFlqDDqJJpjRv/EPaiSluMOstcUWHVkui8WZrUISZdESBRHuXO
 D0gKefpzlWC1r2+//AtOKHkOoc+5dxaFG1NhRTIVYs0W5nQWDY3Zs62bKUwBTzrHMDtd
 h8tg==
X-Gm-Message-State: AOAM5303SBCWQGZIFGVlYZ6PKU+LbqoXsRg8BEH8FGfqxD5p0qK3a6Wq
 V/mbtnt0I4jXAs4gEEInNPYv+n9HI1LA8/rFSnOVOozdLccnWQ==
X-Google-Smtp-Source: ABdhPJwK6mgqjtvr/x0D2wM1wZbzdJpfwaoyuzhLHy1JEsQvuo4AkQkBZ/CP+QnVzyPgXgqXTO+mBxCuynxYn/6ljPs=
X-Received: by 2002:a05:6402:1495:: with SMTP id
 e21mr16772074edv.146.1600089406231; 
 Mon, 14 Sep 2020 06:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
In-Reply-To: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 14:16:35 +0100
Message-ID: <CAFEAcA8gYXDJKMS3nUSW96hhwmC37=QX1EhVfWj7j0smKGvXgA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: francisco.iglesias@xilinx.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 at 01:33, Vikram Garhwal <fnu.vikram@xilinx.com> wrote:
> Vikram Garhwal (4):
>   hw/net/can: Introduce Xilinx ZynqMP CAN controller
>   xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
>   tests/qtest: Introduce tests for Xilinx ZynqMP CAN controller
>   MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN controller

Applied to target-arm.next, thanks. (I had to make some
minor fixups to convert the makefile changes to the new
meson build system.)

-- PMM

