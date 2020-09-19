Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A6C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 00:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE59D21D20
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 00:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUdj6Lz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE59D21D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJR1Z-0006gl-0x
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 20:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kJQzY-0005U0-NS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 20:44:42 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kJQzW-0001Ch-6e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 20:44:40 -0400
Received: by mail-io1-xd44.google.com with SMTP id d190so9014971iof.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O8xsVXnMB9n3UYN0HRcrAh4xExkf0s2jhjzx80O73V4=;
 b=jUdj6Lz9C1fcPSyqIsaTdGgxlsTQ4Xms5boxMZDSBe98K74hUCeIEVlHke353vTOqE
 37tzJdr1S62SxduLP1cMHbph8fHQMNQVK2rbxqxLixmxFiAM99rU25HkXEJZDIoCxxRs
 8NxHnb0zlgFemaJ5uHDJJwxyV5DQnxik0I3UHV9p6yFkllGjb5xstyqjv1HI2pLigyty
 0au04eqMQ9oSed6CsSkkc/W+11pZKhV1qjNJqVtodeyHHo5PSis5U+HzCB9JjnlChzx1
 bW3tjYUOJAUlXz4EKnC7sTP2XiKUqY6oNmK7hNhxUn5OPUWJ0TGye27kABJgpO3K/8+u
 Z8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O8xsVXnMB9n3UYN0HRcrAh4xExkf0s2jhjzx80O73V4=;
 b=a7WC2q8WJswPDCYBzaWDbkPF7OyAcSEsP1JqctKD9jM6eGdrbPKum6QLzuH5d6Cgyn
 qNO6swEw3NJuQP8kBnoQ45iQNV/D+Ialcr2+AHu8LHltbiQtzl+KuVI4fIuESgmyTi8h
 8rkbMFEkCl3Thd3gmGVhTqhjalPhBQEwZ9Hse1k7mJaY4+/xGtqEKDRyhqeIYsDvtJap
 siRCenO0PEbmlzipvYHzcSdlAOQ/+pVuWrXlhOuttS5o58VvjG/3IyfAV3lGYmKn9GSn
 zzxto5zilsRsN44mtQW79tdK2+SFAGbtWWQq06/xxbi8pc1SN7APTpWmzeuMQEw1vYYf
 cCyA==
X-Gm-Message-State: AOAM533nBx0O/4s80sRTN+xv2euXocfmuUJwAMXkbqiaZMmi+kseXVCv
 uEhgDposL88ZUREjfdtCBpKQ3xgn4LCH8mqrGQI=
X-Google-Smtp-Source: ABdhPJw6LLB1Wth0SWIRXqw1IOxSmaSV39FKg9s0if2vxcmkccnpDlrQn+o48AxMxDL3ozwxMvUkQC1V0d3u6IJxFAw=
X-Received: by 2002:a5d:9483:: with SMTP id v3mr1001139ioj.84.1600476276146;
 Fri, 18 Sep 2020 17:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-4-git-send-email-chenhc@lemote.com>
 <1c19dd56-7d76-3dc8-c881-f0631e5e5352@linaro.org>
In-Reply-To: <1c19dd56-7d76-3dc8-c881-f0631e5e5352@linaro.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sat, 19 Sep 2020 08:44:23 +0800
Message-ID: <CAAhV-H57HH9EjP9+VDZx_6p-bA6Lkh+w05JPfo1RmeptRw7eJA@mail.gmail.com>
Subject: Re: [PATCH V9 3/6] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Richard,

On Wed, Sep 16, 2020 at 11:15 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/15/20 7:12 PM, Huacai Chen wrote:
> > +    case OPC_GSLQ:
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_gpr(t0, rt);
> > +        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
> > +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> > +                            ctx->default_tcg_memop_mask);
> > +        gen_store_gpr(t0, lsq_rt1);
>
> If rs == rt, this will compute the wrong address for the second load.
>
> Either avoid storing t0 back to rt until both loads are complete, or retain the
> address temporary and simply add 8 between the two loads.
OK, this will be improved in V10.

>
>
> r~

