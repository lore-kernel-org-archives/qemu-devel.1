Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E6924653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 22:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQXE2SmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E6924653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu21b-0003PZ-Q2
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 17:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iu1z4-0000mY-Hw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iu1z3-0002lL-C8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 17:26:54 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iu1yz-0002ju-Vd; Tue, 21 Jan 2020 17:26:50 -0500
Received: by mail-lj1-x242.google.com with SMTP id r19so4569374ljg.3;
 Tue, 21 Jan 2020 14:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tf4XlMCh7aLMtR4GfauP7A7AA6YoJOiQgwtPCS9IMv8=;
 b=MQXE2SmB8oKwtxd/jHfzAdTTk+oVXBzndZB2ZP/g5iPhvHopwJr9S9RcLLXDXSDH3E
 kBb6POzU8UP6Mj6wC2NFKLIDzZ/c+lOtpPE8X7yrsp+YfLzBFE4UkbCaJVzI5Q4zylXO
 jl8+jX6uwi/K8KLmYeoQK84MzUNF/u/AgVHgV8o5F3j7VBwdGphoVyCw4pSq9V0d70AO
 5dVdYwwTRaLWdoFy20mOJsKWMeGpZqW/QBFzJZk71XTIvh1jjJH8BiEKEIeSML5gmCH+
 oCCW5Y/g31r3MBJZ6iXOQur/qIjo4m72+fPldF3QZdmzsKj9DKRLqFCVecY+kTyGM4f4
 CIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tf4XlMCh7aLMtR4GfauP7A7AA6YoJOiQgwtPCS9IMv8=;
 b=LsOKnyLPpr3Yt12I5OuD5tnQkgrD2eDGVX0jatyMBrRY6JYUvUnCmPI/ohnEexxJqM
 VA/UEjjmHTxFlE82Ow8sDdT/FwXwQfMBtI8EIhG/1eps8bYrG0PPd44Zw9AJb794YQc3
 C5IMUV10xi0C4bkZryma0MyRCV3eJVjQTwmBsAs3GPDRqsL1rgFFZHMwCOfQZ3nG+b3D
 0tSjIFj6Ju0b/vJzUbb+vP2FLD+tMBvg8hA/dRXCb+zXZSRdBtqOuxrBU7bn7OvgHn3T
 B73odBH9HBHqh5irbjv4FzYUFRGPQ1kQDbuKVRiLEkB/xeHCqoBB3Ns/Ou9Ewd8zP0aQ
 WTbw==
X-Gm-Message-State: APjAAAX7kTqT2i4yzBjzREO9b92Oj++4c71hln4LuBzw6LpW7wdbi0nl
 dQcUtvlg6gvZ9ZlsyO1L5t6j3ANdeRGk3EaXUfY=
X-Google-Smtp-Source: APXvYqyDUd8sAPXNj3FGAE8GQmSvMpk7/qXLc+wT7lBD3J0Dl8WjXKEwHaFIp2vZjLUvoQyWFuN8nPekMt/a9ATPpbg=
X-Received: by 2002:a2e:8946:: with SMTP id b6mr3692728ljk.1.1579645608770;
 Tue, 21 Jan 2020 14:26:48 -0800 (PST)
MIME-Version: 1.0
References: <CANnJOVHdcb2wuTZ9U5ziJsuPVin8pae9gUZjh=VH5WJ_5Yn+rw@mail.gmail.com>
 <mhng-4545b3da-b9ba-4fa2-91e8-b0d7e66329d8@palmer-si-x1c4>
 <CANnJOVFZmmwvpdvLfr8r3VK1pudV_rmh3-iq_sgLZNsjkwQ_2A@mail.gmail.com>
In-Reply-To: <CANnJOVFZmmwvpdvLfr8r3VK1pudV_rmh3-iq_sgLZNsjkwQ_2A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Jan 2020 08:26:21 +1000
Message-ID: <CAKmqyKPchQA2C1WzhWD1ErwrT1h48i0eqSD-5ab9b3FvTU=sOg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
To: Jonathan Behrens <jonathan@fintelia.io>,
 Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 11:05 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> I was just doubling checking the status of this patch because it conflicts with the "RISC-V TIME CSR for privileged mode" PR that was just sent out, and it seems this never got merged? In any case, perhaps these changes should be rolled into that patch?

I think this should be merged first. @Palmer Dabbelt  can you merge this?

Alistair

>
> On Wed, Aug 21, 2019 at 1:37 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 14 Aug 2019 20:19:39 PDT (-0700), jonathan@fintelia.io wrote:
>> > Ping! What is the status of this patch?
>>
>> Sorry, I must have lost track of it.  I've added it to my patch queue.
>>
>> >
>> > On Wed, Jul 3, 2019 at 2:02 PM Jonathan Behrens <jonathan@fintelia.io>
>> > wrote:
>> >
>> >> Bin, that proposal proved to be somewhat more controversial than I was
>> >> expecting, since it was different than how currently available hardware
>> >> worked. This option seemed much more likely to be accepted in the short
>> >> term.
>> >>
>> >> Jonathan
>> >>
>> >> On Mon, Jul 1, 2019 at 9:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>> >>
>> >>> On Tue, Jul 2, 2019 at 8:20 AM Alistair Francis <alistair23@gmail.com>
>> >>> wrote:
>> >>> >
>> >>> > On Mon, Jul 1, 2019 at 8:56 AM <jonathan@fintelia.io> wrote:
>> >>> > >
>> >>> > > From: Jonathan Behrens <jonathan@fintelia.io>
>> >>> > >
>> >>> > > QEMU currently always triggers an illegal instruction exception when
>> >>> > > code attempts to read the time CSR. This is valid behavor, but only if
>> >>> > > the TM bit in mcounteren is hardwired to zero. This change also
>> >>> > > corrects mcounteren and scounteren CSRs to be 32-bits on both 32-bit
>> >>> > > and 64-bit targets.
>> >>> > >
>> >>> > > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
>> >>> >
>> >>> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> >>> >
>> >>>
>> >>> I am a little bit lost here. I think we agreed to allow directly read
>> >>> to time CSR when mcounteren.TM is set, no?
>> >>>
>> >>> Regards,
>> >>> Bin
>> >>>
>> >>

