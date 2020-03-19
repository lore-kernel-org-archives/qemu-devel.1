Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E220C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 04:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A186206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 04:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="aBUpXOD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A186206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEnBV-0000ZX-9R
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 00:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1jEnAl-00007l-Gt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 00:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1jEnAk-0003Sh-0t
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 00:52:47 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1jEnAj-0003IO-Ei
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 00:52:45 -0400
Received: by mail-pf1-x442.google.com with SMTP id u68so752209pfb.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=ore1/QJ3+QFXuCPS5FSIlGtwUDNBh9zR2ouiJLI85iU=;
 b=aBUpXOD0CUH0ufEHl5Zj2Fn5BFIwhYh3ql1wLDbf0mo5eTmzl0ffi9hO57erDNjbVm
 FXveC+hqpm6+1GKPIRIZihOQ+zq8iDpl2y7nwDG8PweUTadccTNykgRhFTQ7NMzq8zi+
 w6nlHuPRKt5qbAsPdzjSWeM6CdbuHtRlB6LCRGXL8g86ElSDAes1O/y2S2/XxsT+tW1s
 lyiXviCQOv3lRrbrAsFgx8eRUrJYiYZ+8EHOuawFY++LOMp389XdOFyGnCOy0fpXDdqE
 +ybUYErjXF6kCrIBNeaZgl70Mj0i1qTrioCPnhS65UD3Vc00e0DKrbrq83D6oaZV5pZz
 BU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=ore1/QJ3+QFXuCPS5FSIlGtwUDNBh9zR2ouiJLI85iU=;
 b=hpyikIinckfCv1uVTwVr5VFvmvFhMHuGpYHc5ISsfYs9dyWgoUSv6YhkDx43lH45Dn
 7Wv4o7Rx+8vhcog547lhDAB+lJkejk+0aosZclVg+ynB//Ofe+pOLwwmlPbxd5hpkq0B
 STuRhYDrMayuz1yFvhw21yC4JefLgM+KkwHbKUcKORzz6Qp07rsj+3466sWc4PEzBBoL
 i9ri6A8teLry9Rxih9qRm8+5zCBJb4k31R3B9c+/wyJV9IkusQstR0jcKaTRBedM9uqp
 Hyo8pmOp4htG3qzF8++dSm4GsIFUqqiKCGkCMnnbPianxab/Kot3H3BAzYvs6pbOMQvZ
 Bf0Q==
X-Gm-Message-State: ANhLgQ1i5Y9rh5lN3d0SPK9BhvPnoJE3KszZ0B7oLmrNcHzoKknjhyCJ
 7Vi5N1nGV4bdgmG6bfmFRdeUpq881Lc=
X-Google-Smtp-Source: ADFU+vvw6GVf6HshBpOlFe068chBQpx2wKy+VD9gkJ8SLx0nt1/ato24DQ/wW46RusjNScAWPNvtqQ==
X-Received: by 2002:a63:48e:: with SMTP id 136mr1372326pge.169.1584593563769; 
 Wed, 18 Mar 2020 21:52:43 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id a19sm615566pfk.110.2020.03.18.21.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 21:52:43 -0700 (PDT)
Date: Wed, 18 Mar 2020 21:52:43 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Mar 2020 21:52:28 PDT (-0700)
Subject: Re: [PATCH v1 1/1] target/riscv: Don't set write permissions on dirty
 PTEs
In-Reply-To: <c827880a47774cd3a6bcd59b79657f380da11d5d.1583284602.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-a099dca3-c871-45d3-85c4-58dc12f3dd1a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Mar 2020 17:16:59 PST (-0800), Alistair Francis wrote:
> The RISC-V spec specifies that when a write happens and the D bit is
> clear the implementation will set the bit in the PTE. It does not
> describe that the PTE being dirty means that we should provide write
> access. This patch removes the write access granted to pages when the
> dirty bit is set.
>
> Following the prot variable we can see that it affects all of these
> functions:
>  riscv_cpu_tlb_fill()
>    tlb_set_page()
>      tlb_set_page_with_attrs()
>        address_space_translate_for_iotlb()
>
> Looking at the cputlb code (tlb_set_page_with_attrs() and
> address_space_translate_for_iotlb()) it looks like the main affect of
> setting write permissions is that the page can be marked as TLB_NOTDIRTY.
>
> I don't see any other impacts (related to the dirty bit) for giving a
> page write permissions.
>
> Setting write permission on dirty PTEs results in userspace inside a
> Hypervisor guest (VU) becoming corrupted. This appears to be because it
> ends up with write permission in the second stage translation in cases
> where we aren't doing a store.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  target/riscv/cpu_helper.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 5ea5d133aa..cc9f20b471 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -572,10 +572,8 @@ restart:
>              if ((pte & PTE_X)) {
>                  *prot |= PAGE_EXEC;
>              }
> -            /* add write permission on stores or if the page is already dirty,
> -               so that we TLB miss on later writes to update the dirty bit */
> -            if ((pte & PTE_W) &&
> -                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
> +            /* add write permission on stores */
> +            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
>                  *prot |= PAGE_WRITE;
>              }
>              return TRANSLATE_SUCCESS;

I remember having seen this patch before and having some objections, but I feel
like I mistakenly had this backwards before or something because it makes sense
now.

Thanks!

