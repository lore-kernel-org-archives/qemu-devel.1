Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5F720672
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 01:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2tns8fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5F720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXxU2-00031D-RV
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 20:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iXxSx-0002Lp-QX
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iXxSw-0006UE-NU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 20:10:31 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:43274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iXxSw-0006U5-Jk; Thu, 21 Nov 2019 20:10:30 -0500
Received: by mail-yw1-xc41.google.com with SMTP id g77so1934533ywb.10;
 Thu, 21 Nov 2019 17:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=HT7ZTxGge82f0fLPI2qCbPMK27JnbPnTLJT9zIitDPI=;
 b=s2tns8fjEB0QCxXWKrb7aX66pryhl+m8PJUs42NYJeaU2z4OT52tCpevhxSYCfy/dK
 pnWPEnRz9w+P9qAVnIEp1MXVFyaf0XbYbR//7e0DgxFk8+MjrxLAaND6GvcoWBkP/O5I
 4ZXo2OVmrcoTv8Tg14gYc9Mmr5CdHDZytEpC2uSA2P6WzXRewKSF70iX9BzP91ISr5Af
 qJha6rsm1sOtqFVfohlCa8xx5g7p6FN7I3++zDzzmj6k7bTu6shgYGf+rJm7bzhgr7Xe
 njdYHp0TDIRLK3dvjFuQ82BhLKQzotFpkuzLSkd+5yFAXZHVEffb9N7Ndy6WNXuvCgz8
 exKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=HT7ZTxGge82f0fLPI2qCbPMK27JnbPnTLJT9zIitDPI=;
 b=GwMRZOLBzzYYrwVDLTnllJuC2nzdhDNIroMDMIvO7ktd+rxHJRlbMFlNEZ70PQHuOM
 XSdmLPs3ngi2VkcPVrzh9a/BBjJD+vhxLT1WluizBkZkhBWT4bH/uRTkfAHlBSxCKUES
 RL56JxI31vIsC3490PPbB5nR543AYdwHCWddhatJ+5AaS+37WnIQhSyXtfjmdzFU5f0l
 CL8m3Voi3/6Fdq5idBLA4ewp33BmhY4unkZuacRW1AHTjDgT4wpBO8CFtVeNjmB58sGa
 Zl0w0RSXY0KC3AcyfQcAKAtP98fwL5C9WWqoFX7jyoXZe2L7nOsCm4Wky+7PuOtntba6
 Cfbg==
X-Gm-Message-State: APjAAAUODqNwWF+6KFgVfsA0a+K8UVTbCEM3iaeN9bSddyLoVWa0vqQJ
 0Hc2Rf7lUeyC/GSmRjRohR9mU0/2hc9ZeNWJXcU=
X-Google-Smtp-Source: APXvYqwOcGtiowgZebPyxqzpj8LMKbFluuCSNtfHGUuPA7F0VSzyOkWI6xRTAljsigPQ7SkJ7al9vqqMFk9BfsR/FaQ=
X-Received: by 2002:a81:7ad8:: with SMTP id v207mr7791161ywc.140.1574385029718; 
 Thu, 21 Nov 2019 17:10:29 -0800 (PST)
MIME-Version: 1.0
References: <1573916930-19068-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1573916930-19068-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 22 Nov 2019 09:10:18 +0800
Message-ID: <CAEUhbmUuCOzd_Y6ip_oh13gt83rM8EffdXWRCa=KybOjAvEN-A@mail.gmail.com>
Subject: Re: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
To: Alistair Francis <Alistair.Francis@wdc.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Sagar Karandikar <sagark@eecs.berkeley.edu>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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

On Sat, Nov 16, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present the board serial number is hard-coded to 1, and passed
> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> the serial number to generate a unique MAC address for the on-chip
> ethernet controller. When multiple QEMU 'sifive_u' instances are
> created and connected to the same subnet, they all have the same
> MAC address hence it creates a unusable network.
>
> A new "serial" property is introduced to specify the board serial
> number. When not given, the default serial number 1 is used.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
>

ping?

