Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF56C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0192E2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RA0HHkxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0192E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF42r-0000sw-VZ
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:49:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hF41q-0000YE-PI
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hF41p-0005Ov-OU
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:48:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hF41p-0005Nm-Dw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:48:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id c207so5748618pfc.7
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=F3UZY2ASwvRN9UNuEcMbeX1oR/oKjU39wUXoZeThpzc=;
	b=RA0HHkxU/SlzzDwixC942C95EeXwXOhOznrwbLOPWZYgXQWpwr23tW/TqpT8SM4LGK
	oOLR3keqZojMSJ/6PKoiLWyttmAr9ku/rsbiFaiNOiT8IQmcJYmc3BlIcZIfIRgZ9J/F
	BNBUIDyXWhaKGvTzlug28zJrsrWK9OXLn2J1DaHpjBEtiBWsHTMeFt9X2BPtgGTOehQf
	usXYzAOjzUykCSHXRNl3kE/PsTLspjjLZyFsURan0vsstX6rEn/qdcsYZ6M4qh5Mkopl
	yWTsHRlG5vWXf/dAOe2Z77adoXMPofaMe0sklL4yc1RV8xriqZnug/Qtoz2F5kUcD8yl
	Y0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=F3UZY2ASwvRN9UNuEcMbeX1oR/oKjU39wUXoZeThpzc=;
	b=N/5cmJ1gtxlNHq66f0sShqPXop6/1I4bexVbY1ZixkiZi91A+V18sEo3YGaWayZD1W
	0BKi3Sj/JYeHJy2AV2vUA2BrGbJI9aYLQ5HsSb+zTp9ERwExWNSgfsi9hmuTKoMf055S
	HrZQgVCcgjMdBPr/IgJ3XTTjo4NxTgFYmuhz8qidOmIQcJrhkKMrFljjFtIitxiQ78AR
	7F+i6Spgz5GPUsW63J827UVpOUfE8NWBF8ibPJBHHpcFGiRZr3t/k3liPBiETAkq+RtM
	OYBkKCOLIKaKc8UhcYqCZWlYpe415oVWS/bm/HTrHaPBT4/MC9XmQcxfvurSyZ5AXQBn
	PbBA==
X-Gm-Message-State: APjAAAU3YIzh7Kyg+5PbWwFsWLf19sjDE+/NtTeD6FFwqU9RH8boE2ZY
	61UaKHLDFO8f9fOYrvIBci8jPw==
X-Google-Smtp-Source: APXvYqztZdvFNG6IcLSBN/1w1RJGJreSsDoA8dH4o52q+TBt/V8NbQx6msbUEKjSZVvEnUHLIpEW/Q==
X-Received: by 2002:a63:1d5b:: with SMTP id d27mr54566323pgm.386.1555105687724;
	Fri, 12 Apr 2019 14:48:07 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	j19sm33087955pfr.155.2019.04.12.14.48.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:48:06 -0700 (PDT)
Date: Fri, 12 Apr 2019 14:48:06 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 14:45:46 PDT (-0700)
In-Reply-To: <CAKmqyKOSujRkv+JkgmP79FHVPZabg0QTki3c+BeFMTZpMFSYxA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-fe62b897-1d18-47aa-8dc1-ab08cad65092@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Do not allow sfence.vma from
 user mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	fintelia@gmail.com, qemu-devel@nongnu.org,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412214806.Cruh9p3wx0Ekn08bZHU6kIp9WQNjJ33-M1mthmkiKXA@z>

I actually missed this.  I just added it to for-next on 
github.com/palmer-dabbelt.

Thanks for the ping!

On Fri, 12 Apr 2019 14:23:42 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Apr 12, 2019 at 2:15 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>
>> Just to double check, nothing further on this is need from me, right? It is set to be merged onto the master branch once the 4.0 release is out?
>
> Thanks for checking!
>
> Yep you don't need to do anything, Palmer will merge it in the next
> RISC-V PR after 4.0.
>
> Alistair
>
>>
>> Jonathan
>>
>> On Wed, Apr 3, 2019 at 7:11 PM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Mon, Apr 1, 2019 at 1:39 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>> >
>>> > The 'sfence.vma' instruction is privileged, and should only ever be allowed
>>> > when executing in supervisor mode or higher.
>>> >
>>> > Jonathan
>>> >
>>> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
>>>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Alistair
>>>
>>> > ---
>>> >  target/riscv/op_helper.c | 7 ++++---
>>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>>> > index b7dc18a41e..644d0fb35f 100644
>>> > --- a/target/riscv/op_helper.c
>>> > +++ b/target/riscv/op_helper.c
>>> > @@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
>>> >  {
>>> >      RISCVCPU *cpu = riscv_env_get_cpu(env);
>>> >      CPUState *cs = CPU(cpu);
>>> > -    if (env->priv == PRV_S &&
>>> > -        env->priv_ver >= PRIV_VERSION_1_10_0 &&
>>> > -        get_field(env->mstatus, MSTATUS_TVM)) {
>>> > +    if (!(env->priv >= PRV_S) ||
>>> > +        (env->priv == PRV_S &&
>>> > +         env->priv_ver >= PRIV_VERSION_1_10_0 &&
>>> > +         get_field(env->mstatus, MSTATUS_TVM))) {
>>> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>>> >      } else {
>>> >          tlb_flush(cs);
>>> > --
>>> > 2.20.1

