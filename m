Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530EDC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDB72072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbZwAzTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDB72072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTpHZ-0000Iu-4e
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jTpEp-0005oT-DS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jTpEo-0002AS-Vi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:07:07 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jTpEm-00028t-Vk; Wed, 29 Apr 2020 12:07:05 -0400
Received: by mail-il1-x142.google.com with SMTP id w6so2972200ilg.1;
 Wed, 29 Apr 2020 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=By8vJ3Se9uJnG/uF04QE1RtDo2xNPt4ah4xNj06+pUM=;
 b=BbZwAzTPocYmzps8Zbm/6XCqg0dFTGl58Set36poQl1l6LMOfgvNXsPu0eHyd8l+kL
 6JEO8CMpB9mb7kE4H2z9QUTgzBl827IoFmoLLgEEojSKEBVxs+5/7kt8UsEvlNim3aut
 0JosHRInaCxuPOWm6htRDiG0TdGCrRXwT+peDYO4g1bC30u4bvh/ldWPrV6gNO6jiQaQ
 Reu5c0N0wxo8KSGRQDJzLX3XM7rb9HP1d9so5FALC84V246Vy3vN46pXpbownqe05B7S
 SlyivIPe09K53W1qHtlm5qs9ctuV8ljUasZ5Ji+tpbeI1EeULuwRhqEjjpWTnI+QglU3
 SWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=By8vJ3Se9uJnG/uF04QE1RtDo2xNPt4ah4xNj06+pUM=;
 b=dpIZ//rEzdylI9RdxrP2PoA3dGGnzb4jkqztoJJbNopBvh7FjKv8F12mAz62Unbdqx
 +sGpPv3dO2Ug4BiAwmwCa6qaiB2NH/5A8/+WtogDS1JQ5FNAlBWWZ/TzGcZu2ffkTRuR
 rg37PJSPntlwfeIYWxxEc2nckcwUCcDaK90OFxF+FyDLffpOhxu2MNjy7ohBupgoiayQ
 tj25XXX8E3kDgRT9eq+TZTU46OOJNiBRSSn7CZ+IUROdVbVV7DHPEZcJ0ckahJvpHV9u
 cUDlTVA++Zl8B2X9X346mI6QNjfrqoxtruCQIJdRHzQCbmGvOzOWdG9RJ2r5rZm5mXNU
 EAvw==
X-Gm-Message-State: AGi0PuYZ8hmEw3k0y/wSX6UYuwG0JPhrCit2kR3nMGp1PoG6dcqRyNbT
 Yk1mXVfRn358pNWU/KAzMA3zt7va/Bxli4TbV8Y=
X-Google-Smtp-Source: APiQypLmANJ3mNBSvp7P/ValGWdY4qorLYAFYeQt7nET4Gu6OjkSshysJCOX9i7ITHRGfE+26mjbOh4PhUv8B2f8o00=
X-Received: by 2002:a05:6e02:66c:: with SMTP id
 l12mr19481532ilt.289.1588176422073; 
 Wed, 29 Apr 2020 09:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
In-Reply-To: <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Wed, 29 Apr 2020 17:06:50 +0100
Message-ID: <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=josemartins90@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> If the Hypervisor sets the V* interrupts why does it then want to
> receive the interrupt itself?

I don't think this is a question of whether there is a use case for it
or not (I agree with you, of the top of my head I don't see why would
you forward v* interrupts to the hypervisor). However,  from what I
can understand,  the spec allows for it. If you don't set the
corresponding bits in hideleg, v* interrupts should be forwarded to HS
(as I said, they are guaranteed not to be forwarded to m mode because
these bits must be hardwired in mideleg). Otherwise, there would be no
purpose for the hideleg register, as v* interrupts bits are the only
ones that can be written in it (am I missing something?).

> Isn't hs_sie only ever accessed if riscv_cpu_virt_enabled(env)?
> Doesn't this just set hs_sie to always be 1?

I don't understand if you don't agree that hs_sie should be always set
when riscv_cpu_virt_enabled(env), or if you agree with it and don't
see the need for the hs_sie variable at all. If it is the latter, I
agree with you. So the patch would become:

Signed-off-by: Jose Martins <josemartins90@gmail.com>
---
 target/riscv/cpu_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3ba9efb02..a85eadb4fb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -41,10 +41,8 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)

     target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
-    target_ulong hs_mstatus_sie = get_field(env->mstatus_hs, MSTATUS_SIE);

-    target_ulong pending = env->mip & env->mie &
-                               ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    target_ulong pending = env->mip & env->mie;
     target_ulong vspending = (env->mip & env->mie &
                               (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));

@@ -52,11 +50,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
                           (env->priv == PRV_M && mstatus_mie);
     target_ulong sie    = env->priv < PRV_S ||
                           (env->priv == PRV_S && mstatus_sie);
-    target_ulong hs_sie = env->priv < PRV_S ||
-                          (env->priv == PRV_S && hs_mstatus_sie);

     if (riscv_cpu_virt_enabled(env)) {
-        target_ulong pending_hs_irq = pending & -hs_sie;
+        target_ulong pending_hs_irq = pending & ~env->hideleg;

         if (pending_hs_irq) {
             riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
-- 
2.17.1

Jose

