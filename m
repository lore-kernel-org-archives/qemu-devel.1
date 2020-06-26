Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF69AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776F320885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1PA7Do+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776F320885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowv4-0007GE-Nv
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jowVe-00010q-BA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 18:07:46 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b]:43074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jowVc-000195-Au
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 18:07:46 -0400
Received: by mail-il1-x12b.google.com with SMTP id i18so9775228ilk.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fHMa76Fw/WMBY897SgzH8A3qPbZJUmFRNNyDj8mx+Gk=;
 b=I1PA7Do+0YDv3JLgOOUG2Uug1M5T6H0dYXexdAIiGKdXerEegGwHhWy9j6pqnAuq1s
 +F+oA27AgeZxMbKpJFlntkMZCzDJqbUMsii1hERCttGZzf1GsBJyeiMMtURITvNFik7J
 MNgC+u3bq3pxJJhw0uRAzLsbp+y0Oj+bf9Ajy8KU3d4TKV6FQu9VWarey79RAevptDpL
 XH8vZ9VccexnVEqcMVwQPP7p5asby42Dw61HkaPhhxKjISWL32Fo1hdIHjNzV+e1HJpl
 lmByoZ4w9lBxQCgJdsd0m0RJzqOkD6p5GnBZA5i+gqwKgX/zVsf7ftsDyfTT3faKI8p1
 F1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fHMa76Fw/WMBY897SgzH8A3qPbZJUmFRNNyDj8mx+Gk=;
 b=HXx0lrrt6BlXEbiWljSRSfENqCjALbYjVQoB+DBUsFfgIFTDts/o1TEjv9wxM+qk2y
 JFUC1uDFbnxb7vmyNmhVxbpvUlxYMKxWIahmwTMFOwqvcGuJEgLr/0CsBW+YCfR77cbe
 oKl7g8f7meOm5E6U1WeTs+XRl3xZcN6XleAZU6Sa17RPJQKMpHxNka5RdmXeBVOreRSv
 cIReYp50yFQ8VEk2wgjyFmxax0ew1JbFASzFt1RS2AJG5/RcwFpL823lNz7fNiWnoRJE
 egP+WZKD81j2MceMUE67GNwduZTwYk1LPYP9eFZP9z7uP7Rn76KDN/g61BUhYM5sq6H9
 jo4Q==
X-Gm-Message-State: AOAM530GhaZjpDP1ISeX5G9nUVmuuFM0I5YWEogXwuySmGrDSrFsbuLl
 adLt5YXcZHFfLtM7bKqiVt8ymeLgSlbs0VwHhE4=
X-Google-Smtp-Source: ABdhPJxbG32ZIZog3lZdvuta4zZy0iX3FtJnPqMKUVTDw+ixtBJg30geQKTELhSV3F37VJ2KJczgPSLmSgpGt3cEWJE=
X-Received: by 2002:a92:1b4c:: with SMTP id b73mr5286969ilb.131.1593209262495; 
 Fri, 26 Jun 2020 15:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
 <20200626214410.3613258-3-alistair.francis@wdc.com>
 <76226AC1-ADD7-4A58-A44E-B69050DF4932@jrtc27.com>
In-Reply-To: <76226AC1-ADD7-4A58-A44E-B69050DF4932@jrtc27.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2020 14:58:04 -0700
Message-ID: <CAKmqyKMTZ7Jt66VrPf-daKCZ4xNtuxZFEw9=kC5ytdkPpzO0xw@mail.gmail.com>
Subject: Re: [PULL 02/63] riscv: plic: Add a couple of mising
 sifive_plic_update calls
To: Jessica Clarke <jrtc27@jrtc27.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 3:01 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 26 Jun 2020, at 22:43, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > From: Jessica Clarke <jrtc27@jrtc27.com>
> >
> > Claiming an interrupt and changing the source priority both potentially
> > affect whether an interrupt is pending, thus we must re-compute xEIP.
> > Note that we don't put the sifive_plic_update inside sifive_plic_claim
> > so that the logging of a claim (and the resulting IRQ) happens before
> > the state update, making the causal effect clear, and that we drop the
> > explicit call to sifive_plic_print_state when claiming since
> > sifive_plic_update already does that automatically at the end for us.
> >
> > This can result in both spurious interrupt storms if you fail to
> > complete an IRQ before enabling interrupts (and no other actions occur
> > that result in a call to sifive_plic_update), but also more importantly
> > lost interrupts if a disabled interrupt is pending and then becomes
> > enabled.
> >
> > Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Message-id: 20200618210649.22451-1-jrtc27@jrtc27.com
> > Message-Id: <20200618210649.22451-1-jrtc27@jrtc27.com>
>
> Something went a bit weird here.

Argh! Patches seems to apply two Message-id tags and I forgot to
remove them from these two.

I don't think this is a blocker though. Let me know if you or Peter
thinks it is and I can send a v2.

Alistair

>
> Jess
>

