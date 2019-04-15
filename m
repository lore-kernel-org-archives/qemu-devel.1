Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6150C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0872075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 05:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqEElDQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0872075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFtqQ-0004Tv-Is
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 01:07:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hFtpX-0004Cg-8x
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hFtpV-0006VD-SV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 01:06:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hFtpV-0006RX-Fs; Mon, 15 Apr 2019 01:06:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id y6so7923032pll.13;
	Sun, 14 Apr 2019 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:subject:to:cc:references:in-reply-to:mime-version
	:user-agent:message-id:content-transfer-encoding;
	bh=/PXdlD6LlihKJWpN5uO3CysyQ31m/ZkV0ZtyZibddQQ=;
	b=YqEElDQu0Ekpz+QNy6lrcOzlzeOI5YTvnlM9EPuZy8Zba6tb4zPXz+B06i2hZozOn3
	Kcom11IbplzkxU2TLIV8F+4pjaBuENSJLKQWM0QyB36fCEeX2MSbbrZkTCGgsktE9Nvl
	hoWEYnTDTX7ZLxctASMdcegBCaTxVPkmvJsg4QbcMoLwWVhHOIGfrnguMMZS3n9D73SN
	Kq8BvDQlnmkI3yC1Eu11kgkWVLdApQP5XJnrUl3NJTgBSyNHgOprAVEFagf80J3eH9aG
	JYOzKmmbTyrZK3iKv8HAbdXUnRXwIGgZhRU7tpt0uTYr5SJUBmP1mikkG/Prgul4o6CV
	frbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
	:mime-version:user-agent:message-id:content-transfer-encoding;
	bh=/PXdlD6LlihKJWpN5uO3CysyQ31m/ZkV0ZtyZibddQQ=;
	b=iI/Ptk+d/PmL+GehMyA1+ONfUVCKPij9qh8VPdzlpmnoYSWIPLkTeJaLvoMP9GS7D5
	78bINcGrov3ZmtzO6sXoMqpKGOsYqCInEXu3lJljag0GG+LAqO0R7yCPkxJN6L6iNNaH
	Z/NgAj1KXdTg5eMWmB95QDwbKyR/7sGxjNuRFgygwWClNA6AlYcaSof+DLnjGs7uS/ac
	Bt64RvnLev4NSlBfkTZiu5UMz1HTDNoESld1IETg3g5v8BCscuQmU8qGIFQrmlH5i5YE
	+FpG7+u84I9fToQsrKKOppog5i/VuBSkUoEQ5UkaatdR3sEetWxfF3sCTHiN5F0a2VDX
	XmpQ==
X-Gm-Message-State: APjAAAX0MSEJo++hE+F5sEfWuV3w0ctp1sHq5LMI0KdgHLRqcApm+8qM
	DHkSKsTG7ltuV9QHtcWebeQ=
X-Google-Smtp-Source: APXvYqwUrWI4IkX9QB8JUP3Ge5+RLOuxepcstrkIwxu1I/N33Ir+csx0OdXrewrPjQb4yCYmVCLESA==
X-Received: by 2002:a17:902:b713:: with SMTP id
	d19mr73785372pls.54.1555304810862; 
	Sun, 14 Apr 2019 22:06:50 -0700 (PDT)
Received: from localhost ([115.64.117.196]) by smtp.gmail.com with ESMTPSA id
	g4sm21504176pfc.75.2019.04.14.22.06.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 14 Apr 2019 22:06:50 -0700 (PDT)
Date: Mon, 15 Apr 2019 15:06:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190412093603.18232-1-npiggin@gmail.com>
	<20190415041359.GE32705@umbus.fritz.box>
In-Reply-To: <20190415041359.GE32705@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555302690.7m52mtdllv.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v2] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415050643.3laHVK-67sRS1iupTzSoQzPGOz8GGTdE2WoR-HGE124@z>

David Gibson's on April 15, 2019 2:13 pm:
> On Fri, Apr 12, 2019 at 07:36:03PM +1000, Nicholas Piggin wrote:
>> These implementations have a few deficiencies that are noted, but are
>> good enough for Linux to use.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>=20
>> Cleaned up checkpatch warnings, sorry I didn't realise that exists.
>>=20
>>  hw/ppc/spapr_hcall.c | 88 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 8a736797b9..e985bb694d 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1065,6 +1065,90 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>>      return H_SUCCESS;
>>  }
>> =20
>> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +    CPUState *cs =3D CPU(cpu);
>> +
>> +    if (env->msr & (1ULL << MSR_EE)) {
>> +        return H_BAD_MODE;
>> +    }
>> +
>> +    /*
>> +     * This should check for single-threaded mode. In practice, Linux
>> +     * does not try to H_JOIN all CPUs.
>> +     */
>> +
>> +    cs->halted =3D 1;
>> +    cs->exception_index =3D EXCP_HALTED;
>> +    cs->exit_request =3D 1;
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    target_long target =3D args[0];
>> +    CPUState *cs =3D CPU(cpu);
>> +
>> +    /*
>> +     * This does not do a targeted yield or confer, but check the param=
eter
>> +     * anyway. -1 means confer to all/any other CPUs.
>> +     */
>> +    if (target !=3D -1 && !CPU(spapr_find_cpu(target))) {
>> +        return H_PARAMETER;
>> +    }
>> +
>> +    /*
>> +     * H_CONFER with target =3D=3D this is not exactly the same as H_JO=
IN
>> +     * according to PAPR (e.g., MSR[EE] check and single threaded check
>> +     * is not done in this case), but unlikely to matter.
>> +     */
>> +    if (cpu =3D=3D spapr_find_cpu(target)) {
>> +        return h_join(cpu, spapr, opcode, args);
>> +    }
>> +
>> +    /*
>> +     * This does not implement the dispatch sequence check that PAPR ca=
lls for,
>> +     * but PAPR also specifies a stronger implementation where the targ=
et must
>> +     * be run (or EE, or H_PROD) before H_CONFER returns. Without such =
a hard
>> +     * scheduling requirement implemented, there is no correctness reas=
on to
>> +     * implement the dispatch sequence check.
>> +     */
>> +    cs->exception_index =3D EXCP_YIELD;
>> +    cpu_loop_exit(cs);
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +/*
>> + * H_PROD and H_CONFER are specified to only modify GPR r3, which is no=
t
>> + * achievable running under KVM,
>=20
> Uh.. why not?

sc 1 handler kills ctr and cr0, but I misread the spec, they are not
specified to modify _only_ GPR r3, but rather the only GPR modified
is r3. cr0 and ctr still in the kill set.

>> although KVM already implements H_CONFER
>> + * this way.
>=20
> And this seems to contradict the above.

I just meat it already is implemented with those clobbers, but as
above that's not a problem. I'll take the comment out.

>> + */
>> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    target_long target =3D args[0];
>> +    CPUState *cs;
>> +
>> +    /*
>> +     * Should set the prod flag in the VPA.
>=20
> So.. why doesn't it?

It needs to be cleared at all vCPU dispatch points to SPEC, not just
when calling H_CEDE as Ben's patch had. I think complexity would be
significant for questionable benefit. Like the dispatch sequence, it
seems like the test is trying to cover some race condition for the
client but does not really do it well (and for Linux not necessary).

prod bit is cleared after vCPU returns from preemption, so it can=20
clear at any time and you can't rely on it, unless you look at=20
dispatch sequence numbers to decipher if it was reset or not.

KVM does implement something like the prodded flag as Ben's patch did
but that's not to spec AFAIKS.

>=20
>> +     */
>> +
>> +    cs =3D CPU(spapr_find_cpu(target));
>> +    if (!cs) {
>> +        return H_PARAMETER;
>> +    }
>> +
>> +    cs->halted =3D 0;
>> +    qemu_cpu_kick(cs);
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>>  static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>                             target_ulong opcode, target_ulong *args)
>>  {
>> @@ -1860,6 +1944,10 @@ static void hypercall_register_types(void)
>>      /* hcall-splpar */
>>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>>      spapr_register_hypercall(H_CEDE, h_cede);
>> +    spapr_register_hypercall(H_CONFER, h_confer);
>> +    spapr_register_hypercall(H_JOIN, h_join);
>=20
> I don't see any sign that H_JOIN is implemented in KVM, although
> H_CONFER and H_PROD certainly are.

H_JOIN is not.

>> +    spapr_register_hypercall(H_PROD, h_prod);
>> +
>>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
>> =20
>>      /* processor register resource access h-calls */
>=20
> Don't we also need to add something to hypertas-calls to advertise the
> availability of these calls to the guest?

hcall-splpar is for H_CONFER and H_PROD, H_JOIN also wants
hcall-join actually, good point. I could split the patch up and add
H_CONFER and H_PROD first.

Thanks,
Nick

=

