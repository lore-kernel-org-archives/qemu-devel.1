Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB8AC74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4632084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG2r1ZtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4632084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcXA-0002LI-AP
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlcX0-0001x5-CJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlcWz-0008LB-BL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:06:54 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hlcWz-0008Ij-3w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:06:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id e8so6573947otl.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0NTeAw455IiAkWw9aWmMtYBPnwbCpVek6mthoHIFr40=;
 b=KG2r1ZtT8Tqd08mLQomxcav0G7/fMR4o4kgpVADmxu3LHj+u+LojgriDq+lpOyavUq
 EbUe593ugI/a4YnaK9cDfqUrBm/k2ey0YUe58hzejrYRd2HF8ml+eWUwuVWufMwxzW8T
 gb2MigdyiKzUZgEBhtZTcfc8Cl1qscwsvbf11E4izXP7mIvDQ9Dw2Uxxc4r+SqSqG/NN
 4tpANkweFDxEg2iz0keZ3pF7Q1MySduWm7IkjXCaZbxowgpyuRkTG2qdHwWqBqF20Q+v
 jFf4E8IcRHNxkvlwf9sOPIoxYAodDlTBVcRMTpJaMvYyr9BJBhz3jIn5HvqbNgeKgGr6
 xEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0NTeAw455IiAkWw9aWmMtYBPnwbCpVek6mthoHIFr40=;
 b=RbTZMMDVomwQxnx+kjyDcHPG3U/+1Wc30+Mu0LsgxUZaO7BHjTsS70YrNMwStzjTJE
 tbzSz1dvf49ZRsecpYecnkH2HfvkrPXY7kyI8kw8CIeHpg+4QMjtmBTLBNH9iyQe8nas
 W3TEm2icoPf6o4IYNxbnI59LdVeH6wroL5B/vsDyn3H8Y/yO2oYCCwHHFtfgBVxZY9/p
 fcsDjEYpNbu3lcV0WGKbWz0MIpexv7IJDrZYi6fdjE7l+4PMN48PTdt2qc1Ca8KwZ1h8
 926K457AK8ZcA8u9FYRd6G90QJsxafysgRZWlhOVZzfb8JNy3iv3CkdV+4n92hHygwv4
 yb5Q==
X-Gm-Message-State: APjAAAXDuoGDxA1AgL6y3XZDKlG7NhlrXQXbk152zRuuOgnodA8hJbv1
 JFXdQwtsD2muRNE01Tw18g8GmaIjiTV+6hZyHA8=
X-Google-Smtp-Source: APXvYqw+Pl0hBlXvsP8UCKDdJO+Y7rNkCJJKXmot9wK6Yg4FJdI2q4weGX+7GavJ/9428LBuCLcDID/O46MR1dXTVUg=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr4317176otq.306.1562864811637; 
 Thu, 11 Jul 2019 10:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190709184823.4135-1-richard.henderson@linaro.org>
 <CAL1e-=j8J0WLUjhaOvecSU3VtRf5W+zP-Ydi_kZth4BYV_cXtg@mail.gmail.com>
 <d92c85b6-f7a4-71b8-9601-03d8975b5212@linaro.org>
In-Reply-To: <d92c85b6-f7a4-71b8-9601-03d8975b5212@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 11 Jul 2019 19:06:40 +0200
Message-ID: <CAL1e-=hmUUcztCMpEXAGk0AaqitARTJf2hxLgNybKO9o=ga=Wg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Fix output of extract2 opcodes
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 1:45 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/10/19 8:12 PM, Aleksandar Markovic wrote:
> > On Tue, Jul 9, 2019 at 8:56 PM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> The aarch64 argument ordering for the operands is big-endian,
> >> whereas the tcg argument ordering is little-endian.  Use REG0
> >> so that we honor the rZ constraints.
> >
> > Hello, Richard.
> >
> > If endian and rZ constraints are unrelated problems, then I think the
> > commit message
> > should be:
> >
> > "This patch fixes two problem:
> >
> > - endianness: the aarch64 argument ordering for the operands is
> > big-endian, whereas the tcg argument ordering is little-endian.
> >
> > - rZ constrains: REG0() macro should be applied to the affected
> > arguments."
>
> That's fair.
>
> > One could argue that in this case the patch this should be actually two patches.
> > This is better because of bisectability. The number of line in the
> > patch doesn't matter.
>
> Well, nothing between the faulty commit (Fixes: 464c2969d5d) and the second of
> the two prospective patches is really bisectable.  For the given test case, all
> points in between will fail at runtime, even if each point compiles.
>
> Therefore I don't see the point in separating the two changes.
>
> > Would you be so kind to consider my opinion?
>
> Yes.  Thanks for the expanded opinion.
>
> I plan to change the commit message to:
>
> ---
> tcg/aarch64: Fix output of extract2 opcodes
>
> This patch fixes two problems:
> (1) The inputs to the EXTR insn were reversed,
> (2) The input constraints use rZ, which means that we need to use
>     the REG0 macro in order to supply XZR for a constant 0 input.
>
> r-b, s-o-b, etc
> ---
>
> Does that seem sufficient to you?
>

It does. That's super. Thank you very much!

Yours,
Aleksandar

>
> r~

