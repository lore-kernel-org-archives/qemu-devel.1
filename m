Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB564C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768D520B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDX+f7EZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768D520B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlqM6-0000e0-Pp
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jlqLU-00008X-RE; Thu, 18 Jun 2020 04:56:29 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jlqLT-0005IL-Ax; Thu, 18 Jun 2020 04:56:28 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a80so2752077ybg.1;
 Thu, 18 Jun 2020 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GaaKiFRWVgX3m5d9C4sK5TZmSi+TDccHMDDNXZY9sZ8=;
 b=tDX+f7EZvLXoVd67ZNT9A10Rb9u5Fa9VpTvqdZmkBn37baqmsjl9Z/tU0Iht+G/PX0
 8AIRoGrihWJt/dDYlDgCjVXfX2uNpX2CPyuLGzATKEF2t98XLba06X+9QY0KiHBC6T3s
 NhunrFnmXqvepcdq2XCFX2IMtXLg4koDvuwO0bRQ9lQ+X3lcbryr0hVuuKmj5ujBSJkY
 eIkzHh4cP14+5+YysdrUEIJ9z4oWFCCAmccpt92gYymtAx4vb0LB4Ne2klHGut5HRCnB
 r0LtLUXdN87PwKtHkpSKJXudEmJMSkkzhFnMNo7Y5X77q3K3qeqEbDM2p0OZSRckXqAQ
 aByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GaaKiFRWVgX3m5d9C4sK5TZmSi+TDccHMDDNXZY9sZ8=;
 b=gUxeu3R79/bm2bpwaqJcD8e1xy8TlYgHLf+ypbxuTb/BLugB0N6kSyX3b97003tZqc
 1pm8c7WF000D4dNffW41qz09PkOFmR8gUMhGHh2z37N1guzJexkDX7pirPDL6iFuV77t
 VbbfjVFPp8QmMmaUP9BDpHatT2jq8rM/vI0w3YpfNv6nX1Dsmdg9z+qCoqd1kJIdZ1fO
 gKpZRGzKzdnDOaFpbQF7qdYIxyz6d66hl9Qjfz4YVxiqqmi6pqOjvblyL27SMBgx/Cw8
 zKuwEaY/EZYvpdJ6SgoYmRWQjDdcUnGg4uV8TF7O+xUVqsWQsDiOfKxSlLnkSnwGNc5x
 CBGw==
X-Gm-Message-State: AOAM5338TLx0uMrnT6sUQ5yCeZUXD8VZsTVzNZDkL+da5t3de1ak28vL
 evNkL2SVXVGOvKvMPNlzkvjxMTHpB3CXUdQ7c1o=
X-Google-Smtp-Source: ABdhPJzO73BncriSdDqmCUiIpVzAKrTKGGuGhlSWy8UmeGP5Xchi9AOlHaINfMZgnAiRjXPfXY9pXtQWgVB5MI2rFYQ=
X-Received: by 2002:a25:7a06:: with SMTP id v6mr5023524ybc.152.1592470585931; 
 Thu, 18 Jun 2020 01:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200616192700.1900260-1-atish.patra@wdc.com>
In-Reply-To: <20200616192700.1900260-1-atish.patra@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 18 Jun 2020 16:56:14 +0800
Message-ID: <CAEUhbmVRN2Ze=jNqFSJbZgO0_ggyX6B-1UydPJB1sZVdAokrxQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add OpenSBI dynamic firmware support
To: Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 3:29 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> This series adds support OpenSBI dynamic firmware support to Qemu.
> Qemu loader passes the information about the DT and next stage (i.e. kernel
> or U-boot) via "a2" register. It allows the user to build bigger OS images
> without worrying about overwriting DT. It also unifies the reset vector code

I am not sure in what situation overwriting DT could happen. Could you
please elaborate?

> in rom and dt placement. Now, the DT is copied directly in DRAM instead of ROM.
>
> The changes have been verified on following qemu machines.
>
> 64bit:
>  - spike, sifive_u, virt
> 32bit:
>  - virt

Any test instructions?

>
> I have also verified fw_jump on all the above platforms to ensure that this
> series doesn't break the existing setup.
>

Regards,
Bin

