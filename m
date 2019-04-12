Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0458C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6D32171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9pI7yCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6D32171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3gc-0002uT-Rg
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:26:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hF3fm-0002Wz-UO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hF3fl-00006l-Fm
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:25:22 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hF3fk-00005o-IG; Fri, 12 Apr 2019 17:25:20 -0400
Received: by mail-lj1-x242.google.com with SMTP id r24so10166160ljg.3;
	Fri, 12 Apr 2019 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=v+dlaH22mcOQ+6MsKATDO01RNfc3AAh/8rBGTMkgIxk=;
	b=g9pI7yCkScHDGnUlBrdZbdkFkSch+HGcZ/87LOlm7qA0WdkP+yFGyVl7wKkfxKLwd0
	9RbBlQSTD+hqVBbVBRi1V1vPwtoa1BvJg7XhhWSxMWXXXctCUwvR66MfjlqkJTBzAZDK
	w+A5yp4QB+z8cgpXiXSV7eYU2N32G6NVL0jAGLMw1iy2ONk95QiMniLHcgUcUzYWOSjy
	rKBX0ts3SgkobzJ3aA+f5lTr3SMbR9kmDrSt0gWMgJxK2JmB4SCnw77uvHdcZ6c24wrF
	w2WXKCXI4/I8DwXOdT3e4bqulIne1/7ED0c9nPLuVqxJ0pFPdiTjuopKUdjGAjie4lJ7
	Juzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=v+dlaH22mcOQ+6MsKATDO01RNfc3AAh/8rBGTMkgIxk=;
	b=f2FP5E4NeqL8kxpSlzD3U53n7YQyAa5Jp184GR8lKgD4kHVGVNwG4t07ONsg4UyOTI
	hZMACdEf5odSIyEcQOmS94H/rv9xVt6oc47CbOmQ/ZRlhup4Qh/TSrjJGLgXU506t4Rp
	BvvMjeenkCEe1MQ4Q4IKnRLRfsyPvxshLNGcstOaxNoVl9hntMIfa59rN3FbF2W9KTuA
	ZsuVq/a1Dzl9gDicH/21Zo4haj0wrzC0eFpv8Y/00YSaKD4IfhzPlCy3Q5s46UHeTY+V
	gGlNljBt8sQ1Sg/UbOuvqZPcysemWlFQ9WAlZ8Kjbj3G9bHViNZn0AnASUdwYbFeLruQ
	iebw==
X-Gm-Message-State: APjAAAWl22o9sskz++RviEkq3bi5L3oJDruF8T8lcWfkOQCAtA8yCFao
	7EYJwMdW8j7NIclKKimu7KeTG7hSdLo+42WswbE=
X-Google-Smtp-Source: APXvYqwGVr/ZvsKOQb7qi7aEAuS6FdMCKsNfjDywX+dT693YZy114dojuKU5zdm8fcCpONdwPsCAyPElXfnmLAZ2DCg=
X-Received: by 2002:a2e:9843:: with SMTP id e3mr4014333ljj.28.1555104319148;
	Fri, 12 Apr 2019 14:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
	<CAKmqyKNVno+jR_PYxgnyqQOSQFCn_ai7GH+hYPgaO=fkqHDa6A@mail.gmail.com>
	<CANnJOVHprai3DLd=PunsVDGUwaGvvA4ynou5_LhyGVztTf-tNQ@mail.gmail.com>
In-Reply-To: <CANnJOVHprai3DLd=PunsVDGUwaGvvA4ynou5_LhyGVztTf-tNQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Apr 2019 14:23:42 -0700
Message-ID:
 <CAKmqyKOSujRkv+JkgmP79FHVPZabg0QTki3c+BeFMTZpMFSYxA@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412212342.AF6K2iKkCNSc4m55h9_hAIrFhhO7-memOMsEqlwxHg4@z>

On Fri, Apr 12, 2019 at 2:15 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Just to double check, nothing further on this is need from me, right? It is set to be merged onto the master branch once the 4.0 release is out?

Thanks for checking!

Yep you don't need to do anything, Palmer will merge it in the next
RISC-V PR after 4.0.

Alistair

>
> Jonathan
>
> On Wed, Apr 3, 2019 at 7:11 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Mon, Apr 1, 2019 at 1:39 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>> >
>> > The 'sfence.vma' instruction is privileged, and should only ever be allowed
>> > when executing in supervisor mode or higher.
>> >
>> > Jonathan
>> >
>> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> Alistair
>>
>> > ---
>> >  target/riscv/op_helper.c | 7 ++++---
>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> > index b7dc18a41e..644d0fb35f 100644
>> > --- a/target/riscv/op_helper.c
>> > +++ b/target/riscv/op_helper.c
>> > @@ -145,9 +145,10 @@ void helper_tlb_flush(CPURISCVState *env)
>> >  {
>> >      RISCVCPU *cpu = riscv_env_get_cpu(env);
>> >      CPUState *cs = CPU(cpu);
>> > -    if (env->priv == PRV_S &&
>> > -        env->priv_ver >= PRIV_VERSION_1_10_0 &&
>> > -        get_field(env->mstatus, MSTATUS_TVM)) {
>> > +    if (!(env->priv >= PRV_S) ||
>> > +        (env->priv == PRV_S &&
>> > +         env->priv_ver >= PRIV_VERSION_1_10_0 &&
>> > +         get_field(env->mstatus, MSTATUS_TVM))) {
>> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
>> >      } else {
>> >          tlb_flush(cs);
>> > --
>> > 2.20.1

