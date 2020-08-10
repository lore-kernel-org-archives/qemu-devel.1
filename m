Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A0F206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLUw3/Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A0F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57KQ-00084o-Jx
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 08:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k57Je-0007eO-4g
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 08:54:14 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k57Jb-0004Tc-Qz
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 08:54:13 -0400
Received: by mail-lf1-x143.google.com with SMTP id s9so4637759lfs.4
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V9lfqtPXn/Klbkr6sATvtRAnWIj7bpo8+I+wOWnWJIU=;
 b=uLUw3/MiZkqMw49zc/MQ6noid3Bkk9FxQqvfIwC7wx8ULmBWQExo2PmhkZ0Agz43XM
 7uoQGS0hA10LHUfV8nsyorVQCViWVt//64oqax2zA5v+TI81+oRSYn1uzhuLV/QoBcCV
 0YlqlGl/rX4sEsoAIkuX6n5QwdRkppar261UWvub1tYcxLx4d8dwpRRioVClYqtSeaFD
 4+TQ0NICO0hqvWAV9L3vwZ5WpqYIcGNOmEw7NxIkCgVA4q5Yc4pS42DM+rsEyU93iiNV
 WL4A5RoTb3RtWL0kNDNOCbQM+NNTXzR+BLz/O+Tb3nbBAS4tMSgTkzALTEZ+bXkL5sgA
 64rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V9lfqtPXn/Klbkr6sATvtRAnWIj7bpo8+I+wOWnWJIU=;
 b=iOOVBLgOf9fM9seiRb4IL7UVkDRKwaCG3xT5Zp3LpNZtoFp7IPjACAFsfOh3wuDLPy
 HDZPlp1KCkorJUgtr302PSa2ThT/6PVW4B5YuQgAZ6FPv+kTw46rZWECjyS8qLBCAWzU
 ZlKW49icmwgspYjY8c2za6pTvOk9fS7HpQPBFqGMhettwdnO3GB3372ntd9cPIqIHhy6
 Fmz7VymsuF69N0yxwohB7j8udzxfOolNUxLy6TrM+RuHTsmMiZ/cFxBARJ1ek+7Gy31E
 +OK5JHtY8aejlJfer0yWPDteMoaohl4REyf0RMzpC06ggQcttVy8JHxx8bjvWyHYecE2
 bnnQ==
X-Gm-Message-State: AOAM5316AppBx4yXmGCuBvOWYo4n0/DKDjV2fYX+JTM5dTI0wEt66dJS
 bxLWIrknyhRZYmAtGbTHOP3AvcqYbFYAXgD7WAT19g==
X-Google-Smtp-Source: ABdhPJyMlJbtarrDlvkWfrJspvoe328GUUr9bQ49oYEVrTn01V/66MTyNjACXRUARIBXOUIQPAu0NYVWvywOC/rInFs=
X-Received: by 2002:ac2:5550:: with SMTP id l16mr455902lfk.187.1597064047289; 
 Mon, 10 Aug 2020 05:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200805181303.7822-1-robert.foley@linaro.org>
 <20200805181303.7822-2-robert.foley@linaro.org>
 <ca24d2c5-2c5e-eace-4cf2-90011e684485@linaro.org>
 <4e678ed7-fc36-7918-ce9e-7a7e309c56df@redhat.com>
 <CAEyhzFvveC=nhpo4uyJ_89J8Wi4+9NEc2T2Mk9mg6Y9ZMQjNSA@mail.gmail.com>
 <CAEyhzFvh79ViuXYLYyihTBS3d5dviGpOXjntAt95yyuwE+HwLA@mail.gmail.com>
 <CAEyhzFsMgQWr=sOM43-w3jwSgNyUiKMRKFGdRGRqxM5=offsGA@mail.gmail.com>
 <e1cad321-b24d-dd72-cd9c-541940a8d8d6@redhat.com>
In-Reply-To: <e1cad321-b24d-dd72-cd9c-541940a8d8d6@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 10 Aug 2020 08:54:30 -0400
Message-ID: <CAEyhzFv3b-6=y-sChks6fCuMaKdoZoVnT-QNhUY0LmOMy--M_Q@mail.gmail.com>
Subject: Re: [PATCH v1 01/21] accel/tcg: Change interrupt/exception handling
 to remove implied BQL
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Aug 2020 at 08:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > We are thinking that 2) would be a good option.
>
> Yes, it is.  The only slight complication is that you'd have both
> ->do_interrupt and ->do_interrupt_locked so you probably should add some
> consistency check, for example
>
>     /*
>      * cc->do_interrupt_locked should only be needed if
>      * the class uses cpu_common_do_interrupt.
>      */
>     assert(cc->do_interrupt == cpu_common_do_interrupt ||
>            !cc->do_interrupt_locked);
>
> Therefore, a variant is to add ->do_interrupt_locked to ARMCPUClass and
> CRISCPUClass (target/avr/helper.c can just call
> avr_cpu_do_interrupt_locked, because that's the only value that
> cc->do_interrupt can have).  Then ARM and CRIS can have a do_interrupt
> like you wrote above:
>
> void arm_do_interrupt(CPUState *cs)
> {
>     ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
>     qemu_mutex_lock_iothread();
>     acc->do_interrupt_locked(cpu);
>     qemu_mutex_unlock_iothread();
> }
>
> with a small duplication between ARM and CRIS but on the other hand a
> simpler definition of the common CPUClass.


Thanks for all the details! It sounds like a good approach and we will
move forward with it.

Thanks & Regards,
-Rob

>
> Paolo
>

