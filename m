Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA0C433E8
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00FF1206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fktfSZai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FF1206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzLlx-0007is-8y
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 11:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLl3-0006tm-0Y
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:06:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jzLl1-0000Z6-1P
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 11:06:40 -0400
Received: by mail-ot1-x344.google.com with SMTP id a26so400071otf.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XttOHD7A3DU9UnjTX4sQKU0XSSsO6qOpX3u6elnBRko=;
 b=fktfSZai1mwBY5mtwk5ddn7KR6t6ruLpeKaJOO9OENIIn7+JpaQXbkQGFSUdEOmj1g
 xeTM4nDPCffVe+idQSNwuQerU0zGp3jWPso/MzMc3T21lZeKT/t/y3izJQP8PC7eu6iC
 w9iHHnHMNi+RNSaaPksCNbfx59lXAlRfWNohxaVzLcxiflqhq01kbqA26bDh/1h4Roi/
 r1g1Amdbc7xAP1WwZfdPl9ncuO4H8U+WcKuPUBIS1G+Lvz5FScBYGOPw8wWAcdBw2Rx6
 RamdnOeEG02Ci92iWFWr1tr/sF88srfOvsKrs4PkkBqK4qaQYNg/q5FQR9P3x2D6f2tI
 rsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XttOHD7A3DU9UnjTX4sQKU0XSSsO6qOpX3u6elnBRko=;
 b=c8yq410gVcl8g8gOfy4E8ZhyijOk2zurvEt/nb6pMzXaxSr4BAs4kSOXOWhws/W5mS
 4cXFwWENia61a8MTF38OppvOh7OXhyM3UowOqTbDdV10xJ1uMkliW2pN6+7HR0UGzxSJ
 QpVtuP7ZUiZkV6QGtMDliE90cIf2K27QgZkwt0Ou1dUWIH1Wzr1hhqUUftXLDtoqYVs3
 h/Gzh5Y56IxJuuM7tEkxIaJg2HUYsUgQLloEPIym/gV3v6lqJBxquJyp6jKvGuCxTeFG
 0W6U0oysvmzW+wvMJGz+zbO2U+e6zqObpuLpvdC4fP9huCtMXiiRN68O4wcB0ltPcM0O
 KCcw==
X-Gm-Message-State: AOAM533kLbXGECs9h5Ht/z6WyM9/bvIJZEj4S95DwXY2Ka1ZKOWJmEnQ
 hqRFQATW15UJ1XkyEwTlObimOy310zrqvjGPGd6pfA==
X-Google-Smtp-Source: ABdhPJwR+Dk4vJ/9wC11WXJRDChrhJkYyEjcYRxKpawV+PfgobvQ7MYoPnpxZ6zi97Ud4oGVXPN+2nChrNuS86kAqx8=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr14318006otj.127.1595689597812; 
 Sat, 25 Jul 2020 08:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595581140.git.zong.li@sifive.com>
 <56c2770fc75e1e0c833248ea5d9faa038b69e328.1595581140.git.zong.li@sifive.com>
 <CAEUhbmX-va3wLY_aU7QYXE0ke0sn-4mfenz5Mszy+2k9NMib9A@mail.gmail.com>
In-Reply-To: <CAEUhbmX-va3wLY_aU7QYXE0ke0sn-4mfenz5Mszy+2k9NMib9A@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Sat, 25 Jul 2020 23:06:27 +0800
Message-ID: <CANXhq0oDTLKQ-2c90h9J0G2Pj58=na2goby4u9Z3mctZRzwYOg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] target/riscv/pmp.c: Fix the index offset on RV64
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=zong.li@sifive.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 24, 2020 at 5:22 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Zong,
>
> On Fri, Jul 24, 2020 at 5:08 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
> > entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
> > implementation, the second parameter of pmp_write_cfg is
> > "reg_index * sizeof(target_ulong)", and we get the the result
> > which is started from 16 if reg_index is 2, but we expect that
> > it should be started from 8. Separate the implementation for
> > RV32 and RV64 respectively.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  target/riscv/pmp.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 2a2b9f5363..e0161d6aab 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -310,6 +310,10 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
> >      int i;
> >      uint8_t cfg_val;
> >
> > +#if defined(TARGET_RISCV64)
> > +    reg_index >>= 1;
> > +#endif
> > +
> >      trace_pmpcfg_csr_write(env->mhartid, reg_index, val);
> >
> >      if ((reg_index & 1) && (sizeof(target_ulong) == 8)) {
> > @@ -335,6 +339,10 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
> >      target_ulong cfg_val = 0;
> >      target_ulong val = 0;
> >
> > +#if defined(TARGET_RISCV64)
> > +    reg_index >>= 1;
> > +#endif
> > +
> >      for (i = 0; i < sizeof(target_ulong); i++) {
> >          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
> >          cfg_val |= (val << (i * 8));
> > --
>
> It seems you missed to address my review comments in v3? reg_index
> should be shifted after we call the trace function.
>

Sorry for that, there was something wrong in my local tree, I have
been posting the 5th version patches, and hope it picks the suggestion
already. Thanks.

> Regards,
> Bin

