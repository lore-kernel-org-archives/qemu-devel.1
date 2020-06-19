Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D4CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5DF20809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLb9sv46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5DF20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmG0W-0008D7-QI
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmFyK-00059h-9v
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:18:16 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:39391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmFyH-0001bq-GZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:18:15 -0400
Received: by mail-oi1-x232.google.com with SMTP id d67so8252064oig.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ruAogPAI5hhodelLxaMrVvdQh06qfaDcqOpLU4bnDhI=;
 b=tLb9sv46vJFHGoCKM4v0BXZI4LVIIg2wjiqFyhm4YjU6nL0lHkhPmTWrRKRanK49gJ
 dmSzCVWR5JizqI+Ry5HbcL25Ql5fC2fIieAqxVig8yhQQdTnzMmAYcNnbhxLGHxEc8bS
 sTg85qjkiyUP2fJx8VcHXYSi2dSLGjepY9I8Hb/HDLo+oX9Ey8R1EXxltobuZ/KGM117
 tCylnY/nV7PimAFxuFw3+cWXdSRXBITE9OjC7IAqKRd4FjSOe7aXgFYj5rU1GqiMBv2X
 g81Ckcj/2+srh7JOZiWMH1G67aZRNy66uCbnTFLQWV9z3qub05J83bAacALytGZ5VFVd
 UFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ruAogPAI5hhodelLxaMrVvdQh06qfaDcqOpLU4bnDhI=;
 b=iTk5G4FCfEBXUcRbNrtlsASbTPlg0Q5zRma/wBe1hIhmEbfpe7nKdpm5IG2c8rfIAL
 NQgtxN/Hik4jshz8GFCm3YCPUaDSSKJJybpF2pOF0xQszJwpb1sLKjW8YxbOMIFmqtEt
 PeBjt9aiXvbsxec7kxdWJwbdj01ECvwEKE5T/gWzc3wZS4rb+RT32TRYua+DoZDGDLbj
 BIK82caC8BkXEHkiAEPZ8PdmLqil881womFZaq1ZGAUaVDe8Jal0MMwEAOFikqiShx/J
 XS/G07hvTY03eHcsUxmCr2wu+Srtf6FlpzUEi+MNTxqYVQXB3QakCeXI04uemlWoevtH
 EIiQ==
X-Gm-Message-State: AOAM532nD0Yh0TUG7wEm+IIMbZS+VTmHrvaAMKz+MFR1s39dyz3WxkjO
 TOOPFo/SIZ3kKOIhpjvy09W5VuhX30J8eO6PSZ4+wsjlvRU=
X-Google-Smtp-Source: ABdhPJwI9N1hEqx0ad3/1IJ2uqe2iz3gMd9KVoZnpWAEwHHy19gAaXLptduvm6HKiQQuwryjwMk3OaHv2PY1HeDRdJg=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2705659oib.146.1592569092091; 
 Fri, 19 Jun 2020 05:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
In-Reply-To: <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 13:18:01 +0100
Message-ID: <CAFEAcA-=igrJfoiga7b7rcwZDj46nTNMiT2VEj11DKO7OiJpNA@mail.gmail.com>
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 19/06/20 07:46, Pavel Dovgalyuk wrote:
> > I think, that we need some efforts from target maintainers to remove all such calls.
>
> I'll take care of target/i386 (which does need one of the three
> gen_io_end calls that are left).

So why does it need it ? Why can't it just rely on "TB going to
end anyway which will clear the can_do_io flag" ?

> >> Q2: is it a requirement that after an insn which is a "known
> >> to be an I/O insn" one (like x86 in/out) and which is marked
> >> up with gen_io_start()/gen_io_end() that we also end the TB?
> >
> > It is a requirement for instructions that access virtual clock/icount
> > value (directly or not).
> >
> > There is also an assertion that can_do_io is enabled while generating an
> > interrupt. I believe, that it doesn't affect RR, but is useful for
> > deterministic icount mode.
>
> As I understand it, the definition of "I/O insn" is anything that can
> either:
>
> - affect the icount deadline (e.g. by setting or removing a
> QEMU_CLOCK_VIRTUAL timer)
>
> - interrupt the current translation block with cpu_loop_exit,
> cpu_restore_state or similar.

Right, but really what I'm interested in is what the
requirements are on translate.c code that emits one of these
insns. The exact definition of what an I/O insn seems
more straightforward (and you can always err on the safe side).

thanks
-- PMM

