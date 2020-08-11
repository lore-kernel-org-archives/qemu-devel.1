Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DD6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE8920756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQe9biTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE8920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VEI-0004O7-Lo
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5VDD-00033G-6A
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:25:11 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5VDA-0002Ve-GV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:25:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id u24so12345822oiv.7
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EHU3mg0vjZh22bC+wrsmWihZjV6fh0tyvMV7eWQstWw=;
 b=zQe9biTZ/wCDEy4wTnyjBEqQy6MUKPeQ7nninZPemcEGC561SYaHphXJ6NglXICca+
 APxJOR/xwoANoSfANjCQWSUaJZOW/+cvsyQay1bKB/xRtQd9S1uRHHGoc8McrmS6Qemk
 LowkBkJbltLtcAqbGeW02QB67MOWnFCttU1yHDkH8n+w0j/d/rYhJjoI+MtQfJ+dEGNJ
 /8CRb07u9AfT7XzQTbsl+5JUpc5aWiecqY1MMNVZqxcBDqtThZ0SWcseNyEl5W/oj8Fb
 jnSmbskBjWKhR+60Petm/WsbrGRIZ5Kdq6QoQaKAIUuT3lrgVVfY2x4ijCDW+0YQdtNa
 CmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EHU3mg0vjZh22bC+wrsmWihZjV6fh0tyvMV7eWQstWw=;
 b=e0PwTg7cGdh5A6Lx0xpNGyGTVS9KB7m5zh6g9NYvD9wCEhhv7z91RXI1JLCiwYgzj+
 HwMQ25VKO8og6caBppueq5sI42Yn3VXL2cU/WHQL01Mq4ote2KIvy8JqnzgG5vO6VOPf
 5G+3awwd364LJX7Ogpf8tY9wHFFCDnNImc/t/eFWakSwkkMWwCJUWEm7L2Lcuadjn9WT
 QZlmpecZr84pfwA3dCTvRXqlqNsizO4CLmo7WAMmNqL4LMgYq/DB3Yn5BLgjyWn/wYMS
 Zp7ooebLBVZkZV9Ktw5bmFX85jAYQUsBZqF8/U4n7H21N+ZJu+xE1uTrD/r53T53P8Cn
 Wl3g==
X-Gm-Message-State: AOAM531MCv4t5yLLLudJr4T60BpiMGewytbAsJO8kepNO8h70srT9AYh
 bJn+EcLUNzS3aT0XFwsNS7e8GwtubiS6V1vltaeWfQ==
X-Google-Smtp-Source: ABdhPJxqGZtqUg/qfiXeMIqf0Yc7RbzOoMhX38c+iDRExIWWqqJZ28IdGArFcVJ9qm0XG70fn+0wRl6c7ht8KNcj+eE=
X-Received: by 2002:aca:5703:: with SMTP id l3mr3460996oib.48.1597155906487;
 Tue, 11 Aug 2020 07:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200811012759.16329-1-gromero@linux.ibm.com>
 <CAFEAcA9U9Q9QCm+Pk+ktnxxRGrC3F3UdQwp-bvGBZ6x2EY1oMw@mail.gmail.com>
 <3c978275-f4b4-5032-6f79-6e08a1ff3fe3@linux.vnet.ibm.com>
In-Reply-To: <3c978275-f4b4-5032-6f79-6e08a1ff3fe3@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2020 15:24:55 +0100
Message-ID: <CAFEAcA80NQXiHaNcsJqkH4aoeH-G=0dbpwanjjPjfS-Mqs-DHA@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Integrate icount to purr, vtb, and tbu40
To: Gustavo Romero <gromero@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 at 14:33, Gustavo Romero <gromero@linux.vnet.ibm.com> wrote:
> On 8/11/20 6:31 AM, Peter Maydell wrote:
> > You don't want to call gen_io_end; you just need to ensure that
> > you end the TB immediately after this insn. See
> > docs/devel/tcg-icount.rst.
>
> I understand that to ensure that TB ends immediately after these
> instructions (I understood you meant all the cases, not just the
> spr_read_purr case, right?), the instructions should be a branch
> or change CPU state in a way that cannot be deduced at translation
> time, and I don't know how to ensure that in these cases, they
> are neither, specially for the read access, which doesn't change
> any CPU state specifically afaics.

No, you have that the wrong way around. *If* an instruction
is a branch or a state-changing one, *then* it must end
the TB. That doesn't mean that *only* those kinds of insn
can end the TB -- other things also can end a TB. (It also
doesn't mean that a branch etc will automatically end the
TB -- it means that if you're writing the bit of target
code that generates code for a branch/etc then you must
specifically ensure that you end the TB.)

> If I remove the gen_io_end() from all these cases the VM gets
> stuck at apparently random points of execution (I'm digging
> into details right now trying to understand why).

Probably because you're not ending the TB after the insn.

PowerPC seems to be doing something slightly weird in this area --
it classifies "stop translation" as a kind of exception
(POWERPC_EXCP_STOP) rather than just using the common-code
is_jmp machinery and setting it to DISAS_EXIT. So you'll
need a ppc expert to say what the right thing is, but my
guess is you want to call gen_stop_exception() -- compare
gen_darn().

thanks
-- PMM

