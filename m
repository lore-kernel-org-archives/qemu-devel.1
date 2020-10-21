Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC2FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3CB223FB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3raUR92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3CB223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVKTU-0005JZ-2F
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 16:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVKSV-0004ps-PO; Wed, 21 Oct 2020 16:11:43 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:33319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVKSS-0001EF-Oc; Wed, 21 Oct 2020 16:11:43 -0400
Received: by mail-il1-x142.google.com with SMTP id j8so3753810ilk.0;
 Wed, 21 Oct 2020 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=93q7BQqx5rUbCi70bvvfoPbKm2H2zHdRENnENNFvy5s=;
 b=D3raUR92l8bVNU2JsLy6zNZLVMSVFg8e4Ket9thTArbcxd7Z4CEYy0DbDqAiCdLo2x
 XfJQMzbJ5m0r2PHUUOC24MSnQRGvZpwgt6oOce6WbTUvE2oY6EpZbEfSdPKw6Aufksjt
 TxcMzHxNIs9rce9wyA047i/EWnTsYoaUog/8RCpovnpkb3pBVBnUF+IGbbhPVqjjSmdJ
 xfuBsBrdPk3PG/8SenRE+jrrsptnzTBnFc0HEIixJXo+1he9hlTerNQ/ClbjXkAt9U/p
 GkPc1RD2pnWPP5sk4SOf7f6Z5fHwPV0kX/AlqG2f4Kgdj00CxN/WjEJCztFp9dR/kd2K
 TQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=93q7BQqx5rUbCi70bvvfoPbKm2H2zHdRENnENNFvy5s=;
 b=YXvmkqVWTBGqrM9fEjfvtJU+7XYoZrTfPt4mugq8CLf/XeBiPqgvJ5SI+l+zWPzHwH
 ntkEkAVCUb3UuaVyEfUnkC6pMFtT9caP5cNDbaoC3ZNQ15mdpqHE8kPp9619Ci48ce0R
 NoCilYs9mZx+QTtgiHrkz57pkgb0wSywBdP9SXR8akkd3E7CFobwjYvXyKOo/AuCWQnJ
 JMm9Exw7QWLfdzGDBZ7MxDXRJSgGgSJOkR0649U2AJOFfY4lxjhGyg5Hi9eXkZi8kc6f
 ULaEMuNSC/DqlhAVLxCHpLuyHMDtIa/1JorFM3giaTLtfBrQBCYxKhS9jpDxK9ADfS+0
 5saQ==
X-Gm-Message-State: AOAM533dG2qFS/K8h9oyJkiLJZKUnLFPXu0jmYSvJFiJ196uCv6W4pXB
 cMhu7Ov35RlJ1BwCNkKAo80OsrJzUM3JaUAyu2o=
X-Google-Smtp-Source: ABdhPJwjROsPed2/X+rDU/kuJEv3Vl84ovNtdKKx8rrmYOMF5WuvvN1L0J5iIoQrJECKYyM/ab464UEKrC7ozsMdiEs=
X-Received: by 2002:a05:6e02:c:: with SMTP id
 h12mr3906995ilr.177.1603311098965; 
 Wed, 21 Oct 2020 13:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201014101728.848-1-jiangyifei@huawei.com>
 <ee4b99ec-5842-6638-ecff-54096ec0b0e8@linaro.org>
 <cd12acc6aa7b4f1d84859f14200cf75d@huawei.com>
In-Reply-To: <cd12acc6aa7b4f1d84859f14200cf75d@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Oct 2020 12:59:54 -0700
Message-ID: <CAKmqyKMQ+Kood7dO=esi9J5eTVYZPPq2QiVzSgHfEHta_cpZ+g@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: raise exception to HS-mode at
 get_physical_address
To: Jiangyifei <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 yinyipeng <yinyipeng1@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "Wubin \(H\)" <wu.wubin@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 6:59 PM Jiangyifei <jiangyifei@huawei.com> wrote:
>
>
> > -----Original Message-----
> > From: Richard Henderson [mailto:richard.henderson@linaro.org]
> > Sent: Thursday, October 15, 2020 4:22 AM
> > To: Jiangyifei <jiangyifei@huawei.com>; qemu-devel@nongnu.org;
> > qemu-riscv@nongnu.org
> > Cc: palmer@dabbelt.com; Alistair.Francis@wdc.com;
> > sagark@eecs.berkeley.edu; kbastian@mail.uni-paderborn.de; Zhangxiaofeng
> > (F) <victor.zhangxiaofeng@huawei.com>; Wubin (H) <wu.wubin@huawei.com>;
> > Zhanghailiang <zhang.zhanghailiang@huawei.com>; dengkai (A)
> > <dengkai1@huawei.com>; yinyipeng <yinyipeng1@huawei.com>
> > Subject: Re: [PATCH V3] target/riscv: raise exception to HS-mode at
> > get_physical_address
> >
> > On 10/14/20 3:17 AM, Yifei Jiang wrote:
> > > +                if (fault_pte_addr) {
> > > +                    *fault_pte_addr = (base + idx * ptesize) >> 2;
> >
> > The shift is wrong.  It should be exactly like...
> >
>
> We have tested in the VM migration.
>
> fault_pte_addr will eventually be assigned to htval register.
>
> Description of htval register according to the specification:
> When a guest-page-fault trap is taken into HS-mode, htval is written with either zero
> or the guest physical address that faulted, shifted right by 2 bits.

Yep, I agree that the shift is correct, it's what we do when we set
guest_phys_fault_addr in other places.

It is a little confusing that we shift it in get_physical_address(),
instead of when guest_phys_fault_addr is set. In this case you are
setting guest_phys_fault_addr directly when calling
get_physical_address(... &env->guest_phys_fault_addr ...).

I have added this comment to make sure it's clear and applied it, I
hope that's ok.

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 4ea9510c07..4652082df1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -318,6 +318,7 @@ void riscv_cpu_set_mode(CPURISCVState *env,
target_ulong newpriv)
  * @addr: The virtual address to be translated
  * @fault_pte_addr: If not NULL, this will be set to fault pte address
  *                  when a error occurs on pte address translation.
+ *                  This will already be shifted to match htval.
  * @access_type: The type of MMU access
  * @mmu_idx: Indicates current privilege level
  * @first_stage: Are we in first stage translation?

Alistair

>
> In addition, fault_pte_addr is named after env->guest_phys_fault_addr, which makes
> sense in a sense.
>
> Yifei
>
> > > +                }
> > > +                return TRANSLATE_G_STAGE_FAIL;
> > >              }
> > >
> > >              pte_addr = vbase + idx * ptesize;
> >
> > ... this.
> >
> >
> > r~

