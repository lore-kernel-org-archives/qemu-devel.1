Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6833C32756
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868BC21743
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfaN0EC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868BC21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjGw-0008Dg-Rz
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hvjGY-0007kQ-4h
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hvjGW-0003mg-0s
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:19:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hvjGQ-0003kz-Dr; Thu, 08 Aug 2019 10:19:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so25930736otq.12;
 Thu, 08 Aug 2019 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jsFUs6K0zG+KDJOHz22gh70VBT5Y02ynQTJTLc1Ukak=;
 b=sfaN0EC7a9EO+kLhc/cyC1bYm1LdlG1+jPYulfG7KkFCi3qdPoYFnEs8N2knN1tC0x
 ZSkrutzxNznCQXhXVcykjkf8rzQEXsdDWvikVLAcdTMErji6H1Ia+ZqxOgi61hYzaC+7
 jlf53amoTE6/sjBO0+7/foluBgUhT3kXgBru53j1P2VuYkJk4nfquTDEcL4H7EWFw1et
 nMFct2gwUtVHlxCizeYqRcCfiJyrlj1X2mdGHj0Imu/T26F5OBTDQbMu9Ds+RGJMcikM
 v0UX5XiHUL5hfWU9d1SLvslF6aESaZjHcCvULtFxhB0Ny2bBzIubvD0q14Q8kSKCAQTt
 UkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jsFUs6K0zG+KDJOHz22gh70VBT5Y02ynQTJTLc1Ukak=;
 b=ZpAwn7JVM3wFhlQv1TfvKLhQ3xtdjG9nfB1XciwgLbM2lmUBkgYjugMaPDuXXToqve
 vpWPZITQiF91ZM8JeFuRd966ES6pKKARIn6FZmkKE4uB8yswLWJZ3cf0t4ertiO1ahKE
 rgdyqvZnLxVth6LxLhM26rtBdnPs3wDUuVrjJoIEDEAdb0s7tLYxcSw2Q+wvNvOZtroR
 /0pC2Hb0qApdQ76n3PcbCO8hmbMLMOvGS0hlo4q+CV3Rf3tb4gHBb672QDw09s2HwhpA
 9Vmrgi5tBAW+5PVAoxdep2PFdHEXP80CyVsvf+EFYGDfMZS8h9tmTRWkxD+4J5nCv/Bz
 QWCg==
X-Gm-Message-State: APjAAAUSYheTZWDvBsSmBqv24tMQSKZ5nPV/NZ2r/3b8FzenmrVRMhPV
 iK9sMyUjZGjb8w9L+rDuSeHTxinjGiS2Ra7MrH4=
X-Google-Smtp-Source: APXvYqxVPlswE15IIn5Mcr0/7UCby3Wj+fcOg4OmOi9K0fiq/wQHPOfcPclS2ugQY1WBFtYPOmVTONjwpTz6K2BrWls=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr13830926oti.341.1565273973643; 
 Thu, 08 Aug 2019 07:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAL1e-=jceerbvam57mmXoKWHzepB-qUFL08gBEnSws_ohewLzw@mail.gmail.com>
 <CAEiOBXVDg-oaqWDpzFrsPjzt8jdmLt7DskG4=zXwYVUb+5=tfg@mail.gmail.com>
In-Reply-To: <CAEiOBXVDg-oaqWDpzFrsPjzt8jdmLt7DskG4=zXwYVUb+5=tfg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 8 Aug 2019 16:19:22 +0200
Message-ID: <CAL1e-=iKYyWRkrOgEQ0ji67W1cfYc6iH-fPsF1wpYS84M46NNw@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 3:48 PM Chih-Min Chao <chihmin.chao@sifive.com>
wrote:

>
>
> On Thu, Aug 8, 2019 at 7:29 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>> On Thu, Aug 8, 2019 at 11:52 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>>
>> > Hi all,
>> >
>> >     My workmate  and I have been working on Vector & Dsp extension, and
>> > I'd like to share develop status  with folks.
>> >
>> >     The spec references for  Vector extension is riscv-v-spec-0.7.1, and
>> > riscv-p-spec-0.5 for DSP extension.
>>
>>
>> Hello, Liu.
>>
>> I will not answer your questions directly, however I want to bring to you
>> and others another perspective on this situation.
>>
>> First, please provide the link to the specifications. Via Google, I found
>> that "riscv-v-spec-0.7.1" is titled "Working draft of the proposed RISC-V
>> V
>> vector extension". I could not find "riscv-p-spec-0.5".
>>
>> I am not sure what the QEMU policy towards "working draft proposal" type
>> of
>> specification is. Peter, can you perhaps clarify that or any other related
>> issue?
>>
>
> Hi Aleksandar,
>
> As for riscv-v-spec 0.7.1, it is first stable spec for target software
> development
> though the name is working draft.
>

Hello, Chih-Min.

Too many unclear points here.

What does this sentence mean? What is "stable"? Is that the same as
"final"? If the document is stable, why the title "draft/proposal"? Can a
"draft" be stable? Can you, or anybody else, guarantee that the final
version of this document will not affect QEMU implementation, if it is done
by the current document? If not, why would you like QEMU upstream to
support something not fully specified? Why has the final document not been
released, if the situation is stable?.....

Yours,
Aleksandar

  The architecture skeleton is fix and most of
> work are focusing the issues related to micro-architecture implementation
> complexity.
> Sifive has released an open source implementation on spike simulation and
> Imperas also
> provides another implementation with its binary simulator.  I think it is
> worth to include the extension
> in Qemu at this moment.
>
> As for riscv-p-spec-0.5, I think Andes has fully supported this extension
> and should release more
> detailed spec in the near future (described Riscv Technical Update
> 2019/06).
> They have implement lots of DSP kernel based on this extension and also
> provided impressed
> performance result.  It is also worth to be reviewed (at least [RFC]) if
> the detailed  spec is public.
>
>
> ref:
>      1.
> https://content.riscv.org/wp-content/uploads/2019/06/17.40-Vector_RISCV-20190611-Vectors.pdf
>      2.
> https://content.riscv.org/wp-content/uploads/2019/06/17.20-P-ext-RVW-Zurich-20190611.pdf
>      3.
> https://content.riscv.org/wp-content/uploads/2019/06/10.05-TechCommitteeUpdate-June-2019-Copy.pdf
>
>
> chihmin
>
>
> I would advice some caution in these cases. The major issue is backward
>> compatibility, but there are other issues too. Let's say, fairness. If we
>> let emulation of a component based on a "working draft proposal" be
>> integrated into QEMU, this will set a precedent, and many other developer
>> would rightfully ask for their contributions based on drafts to be
>> integrated into QEMU. Our policy should be as equal as possible to all
>> contribution, large or small, riscv or alpha, cpu or device, tcg or kvm -
>> in my honest opinion. QEMU upstream should not be a collecting place for
>> all imaginable experimentations, certain criteria on what is appropriate
>> for upstreaming exist and must continue to exist.
>>
>> Yours,
>> Aleksandar
>>
>>
>>
>>
>> > The code of vector extension is
>> > ready and under testing,  the first patch will be sent about two weeks
>> > later. After that we will forward working on DSP extension, and send the
>> > first patch in middle  October.
>> >
>> >      Could the maintainers  tell me whether the specs referenced are
>> > appropriate? Is anyone working on these extensions?  I'd like to get
>> > your status, and maybe discuss questions and work togather.
>> >
>> > Best Regards
>> >
>> > LIU Zhiwei
>> >
>> >
>> >
>> >
>>
>
