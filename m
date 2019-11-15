Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE7CC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B9B2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2Zwq6bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVat9-0006J0-6t
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVanp-0000KG-J8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVano-0003Qy-C1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:34:17 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVano-0003Qr-49
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 07:34:16 -0500
Received: by mail-oi1-x242.google.com with SMTP id x4so508611oie.9
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SJJTS0yn2SzMU9d/U32LoplYPG4IeTJT1EFwP24QH68=;
 b=G2Zwq6bFTk9Pg1SDQFt03tgbp/8HP23R964fhdwzIYGZ5uhRwbnLUFXyHMV8hOE/sx
 GaSQzZjoAohOziL39IXg80O2pgjSJPqUr+DniU5hKGCblbnVKWHq9Uzto8JZTbYadyMn
 j8ELLi5Dk39cwhPy8nr5ijPXQfsk4xof8FY36CZu/9D7T2EPxVhUT70HyNSZ3/vbDWL4
 KrxHBcyq1/M8GFNjhryKt3LdFRUTtXGciFGQuHpzFMq+stlq89yOcC/ef9a/nnAawRx7
 MKUeEqB2S4RthN3GkAeCERMrsfP/gD9x+llH6pPIEMEnGyhBxDgB7yXQVskbpI1Tq9SW
 BWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SJJTS0yn2SzMU9d/U32LoplYPG4IeTJT1EFwP24QH68=;
 b=plD6qVTcj6YkaPk2g+Hf3Tp4BdYpSPDksDfPCph1oPDwZn3velUgXdi7zeTN/zFB3K
 q57y/zGX2drINxlI+7ONFW6G881x98axJeJ7S0GHv8QL49LhBRfGNuHCrGjfYUH4ZqgJ
 8L5iIElNIMagQQZj6iuhVqIo8G3AFbuwKQqxaKLtk+vtyfbOPa86/NV6G9TrwJyGxWAp
 0lwfuM7cQlInRDxAVAIvJkm3JVmHIX4NuTQLeJTzG/tQgJPD5rh/RvpYhti/qss/RtUV
 hUPiYqjQphrrZh5eT6aRracDTfsEDusaVzv1/YPiM7t+YlCIObdxUi0QuSzi46H0KjAT
 GG7g==
X-Gm-Message-State: APjAAAUVG/st7EeZe1WgOBB/vQ88T9tiuZdfNW022uhGHsbqVFffxAMw
 LGRnZglkc9T1s7boscEt1p+Rwg82dOQJwOMNNkcARg==
X-Google-Smtp-Source: APXvYqyK5/jCgix7uj8q9hQmllGYjLkGC3cjmuj6ReJKHWEPM9kN25l0Xwr+PiSZm/wePAO068qXPS+XZiXRnYhnCoM=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr7787822oij.163.1573821255158; 
 Fri, 15 Nov 2019 04:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20191115044104.4197-1-palmer@dabbelt.com>
In-Reply-To: <20191115044104.4197-1-palmer@dabbelt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2019 12:34:04 +0000
Message-ID: <CAFEAcA-DPTHcLMKa7TZrftSV00nAjt+AxqPWV81-mXHxf+PJ2g@mail.gmail.com>
Subject: Re: [PULL] RISC-V Fixes for 4.2-rc2
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 at 04:41, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> The following changes since commit aa464db69b40b4b695be31085e6d2f1e90956c89:
>
>   Update version for v4.2.0-rc1 release (2019-11-12 18:40:02 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-rc2
>
> for you to fetch changes up to 6911fde41006b2afe3510755c4cff259ca56c1d9:
>
>   riscv/virt: Increase flash size (2019-11-14 09:53:28 -0800)
>
> ----------------------------------------------------------------
> RISC-V Fixes for 4.2-rc2
>
> This contains a handful of patches that I'd like to target for 4.2:
>
> * OpenSBI upgrade to 0.5
> * Increase in the flash size of the virt board.
> * A non-functional cleanup.
> * A cleanup to our MIP handling that avoids atomics.
>
> This passes "make check" and boots OpenEmbedded for me.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

