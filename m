Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD514C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC05206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+uSEJQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC05206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5uA8-0002zt-NO
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i5u91-0002F9-41
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i5u90-0007Bw-63
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:57:59 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i5u8z-0007AI-UP; Thu, 05 Sep 2019 11:57:58 -0400
Received: by mail-ed1-x541.google.com with SMTP id y91so3167775ede.9;
 Thu, 05 Sep 2019 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Wd40yZu6lvsfzccaHEwmbvmzMCtec0A/aKX7+yHvOxQ=;
 b=J+uSEJQ3L1lWJSluGo82vXR92aCMhkvvfZV4DsvUnS5K19A7eWtyt80TNytc2Ec+dN
 Zv/HPzO6ZHOUcEFCL+T9EDsgfMbJEf3ymT7nUIhmNEsxP9+V7oL/yrgBamyPQ61lfLtj
 GQePGfHUlNnCOokeRba/pThyTASMgsInvCXx7C+YTo5jCcPp/+KOGfhK2EiELWQsF3HI
 lpoST27ZTiWtdwdLURK8KzvIjgcCnafvaaKU6um/lfaihePiTwoSYsJfR01BBxbTpibq
 e26KHb1unNKqATSRtdBjpBXQpOt6NrwNl+GHz+YJjwkdbCYQekTKt0GArLgIxAlwQtm2
 SL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Wd40yZu6lvsfzccaHEwmbvmzMCtec0A/aKX7+yHvOxQ=;
 b=SGtCEeA9GIacSmMDyHe+dZIv3FY1eDxTNlNOcdkQBJaVqRdJvBdLV2AbyVPu7tV+pZ
 5wdi+QoXdFdkxlIKXYl61SP/m4H12GiPqbXD0xTN2eSB3q5KhCacO8kBoc9LOzyqkB/Z
 MBpkdzCQIPgDmnNX+lCcse1UAHwLJuX9v/vaQRdO2Dyag7C/ZkJFwxtmAdkfJuANjZFY
 yASRCMAYYesrer2rw337Z2xfjLNsSMYjfw0XBPbLAUK/VbLXpFg5/O7A/xk0JZr/oRvn
 PiWQYgFrTltw4QmNJCCQlkR8XrDEJbPk2x56oAhTKM/4P2Uh+k5llSx0jkdvnSIUJWFM
 1/ow==
X-Gm-Message-State: APjAAAWAVNTRrc6YS/bwjG87yK4ETgXDOfsGsfS35lTCwHE4q3m8oqiG
 Bsq/p1i9/D88sdu//pVFkHZVkSu7wXziUyERqy0=
X-Google-Smtp-Source: APXvYqwd8gJMv95XDGZkksRcjS1MBHaNxI8g1ocHrlzP7b60LCU8DOTUe/7liNrcD9xnSIbVxrtqJZZ51qtpzb9zj8I=
X-Received: by 2002:a05:6402:1490:: with SMTP id
 e16mr4517226edv.15.1567699076910; 
 Thu, 05 Sep 2019 08:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <1567698916-28260-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1567698916-28260-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 5 Sep 2019 23:57:44 +0800
Message-ID: <CAEUhbmX-czUP9e9CcN69kjkw2VZJaRcEc+F0SVbRXYkaecv9MQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v2] riscv: sifive_test: Add reset
 functionality
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

Hi Palmer,

On Thu, Sep 5, 2019 at 11:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> This adds a reset opcode for sifive_test device to trigger a system
> reset for testing purpose.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> ---
>
> Changes in v2:
> - fix build error in the "for-master" branch of Palmer's RISC-V repo
>   that was rebased on QEMU master
>
>  hw/riscv/sifive_test.c         | 4 ++++
>  include/hw/riscv/sifive_test.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>

Please drop the already applied v1 patch in your "for-master" branch
and apply this v2.

After you rebased the "for-master' branch, this patch no longer build
any more due to changes in QEMU master.

Regards,
Bin

