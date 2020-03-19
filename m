Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD915C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD40620658
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdCCNUB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD40620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jExfT-0006yK-TD
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jExeQ-0005uT-VF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jExeP-0003VW-Fw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:04:06 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:36531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jExeP-0003Ub-Bo; Thu, 19 Mar 2020 12:04:05 -0400
Received: by mail-vk1-xa43.google.com with SMTP id m131so877492vkh.3;
 Thu, 19 Mar 2020 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rNeTc7+LguWbEoqJqBZhkOka9w7mm5csomo8qZK5kNQ=;
 b=PdCCNUB6nvAqTK2KoBVSyz2ULgpcaEWKZA9CjQH6oJYKchsNU0VIoZs8iMpvGiYjJf
 P2A25kghltHhLd1C6DQpN4QC2ChGHPButhj2x6fk2hhCpSM0+DU1V5NGrNvF2V++uMHa
 yUvWdsRbm7NmIXQUZ+dXkkNHLvPPCcxrD9P/8yrrajY/BVSjbQORreXwUep1z0iiTlD9
 PxSNv7ppz/ZxGAKZZZutzpiV3cBDtYrJQZobVCo4cNdMEUoUU6e83k6jDR2XFqhJidxY
 nJ0vWC46KZOukB+LSgelvgszyjVa6zoQpvimj29xiI/XEzD4Ay7IGrQaayq2c/m55pQE
 tKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rNeTc7+LguWbEoqJqBZhkOka9w7mm5csomo8qZK5kNQ=;
 b=DypgmTt6L5Ndfw67BrXvQYhrTKvAcKy1h3bFmyJZcu0+HbFWz2umHTOQIIQ94gTXZr
 F5hk/qnou6niA9t/54+BX05OUfmiydrD/TZeSMSZSfHQUmcajwJAXin3/2zqwinDAce6
 /PsHE3XMbF6KOYy8wSF0Q7ueTx9iCSNbBdIzSIPSwws00AGx95J7BJLx79Ov6LiKi3dQ
 pI9vetx0XQK2lezZLhOTQwqgQ9zSQwx1s9uBi7CDnAi7U8ts/KFnfb+rthis6+oGTQ20
 3Pl3AuzjB3pWULfRpcQ/hoTvtgO/oeJX0NJl6BTHlmukQmUcHzVwlbUjsThCLDAZvlqS
 Fczw==
X-Gm-Message-State: ANhLgQ0y4gLJ0s0URuS+ag98nH3mbS2lWfEA47Zfy8ei8aP+2lbej10D
 oVU4Y9HOpHfNduMR5AClYMKgsdsGi43PFA1Lw/M=
X-Google-Smtp-Source: ADFU+vucadsjIjGJrD5l90xeRzuoVRolnJrTxkawkPhrvMg2OG2HAx5GGI5921Ui/Y2UqrZK/dm7vXK8ZPERV9bvhlA=
X-Received: by 2002:a1f:a2d0:: with SMTP id l199mr2909026vke.77.1584633843171; 
 Thu, 19 Mar 2020 09:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <c827880a47774cd3a6bcd59b79657f380da11d5d.1583284602.git.alistair.francis@wdc.com>
 <mhng-a099dca3-c871-45d3-85c4-58dc12f3dd1a@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-a099dca3-c871-45d3-85c4-58dc12f3dd1a@palmerdabbelt-glaptop1>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2020 08:56:07 -0700
Message-ID: <CAKmqyKPE8GSfjR4qFB3BCYC+Rde1CKK3t1AgbKUiB5gZGgttrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Don't set write permissions on dirty
 PTEs
To: Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 9:52 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 03 Mar 2020 17:16:59 PST (-0800), Alistair Francis wrote:
> > The RISC-V spec specifies that when a write happens and the D bit is
> > clear the implementation will set the bit in the PTE. It does not
> > describe that the PTE being dirty means that we should provide write
> > access. This patch removes the write access granted to pages when the
> > dirty bit is set.
> >
> > Following the prot variable we can see that it affects all of these
> > functions:
> >  riscv_cpu_tlb_fill()
> >    tlb_set_page()
> >      tlb_set_page_with_attrs()
> >        address_space_translate_for_iotlb()
> >
> > Looking at the cputlb code (tlb_set_page_with_attrs() and
> > address_space_translate_for_iotlb()) it looks like the main affect of
> > setting write permissions is that the page can be marked as TLB_NOTDIRTY.
> >
> > I don't see any other impacts (related to the dirty bit) for giving a
> > page write permissions.
> >
> > Setting write permission on dirty PTEs results in userspace inside a
> > Hypervisor guest (VU) becoming corrupted. This appears to be because it
> > ends up with write permission in the second stage translation in cases
> > where we aren't doing a store.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  target/riscv/cpu_helper.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 5ea5d133aa..cc9f20b471 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -572,10 +572,8 @@ restart:
> >              if ((pte & PTE_X)) {
> >                  *prot |= PAGE_EXEC;
> >              }
> > -            /* add write permission on stores or if the page is already dirty,
> > -               so that we TLB miss on later writes to update the dirty bit */
> > -            if ((pte & PTE_W) &&
> > -                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
> > +            /* add write permission on stores */
> > +            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
> >                  *prot |= PAGE_WRITE;
> >              }
> >              return TRANSLATE_SUCCESS;
>
> I remember having seen this patch before and having some objections, but I feel
> like I mistakenly had this backwards before or something because it makes sense
> now.

Ha, we have come full circle because I think this is wrong.

This is an optimisation which from what I can tell (and talking to
Richard) is correct.

In saying that this patch is the only thing that I have found that
fixes Hypervisor guest userspace. It shouldn't be applied though.

Alistair

>
> Thanks!

