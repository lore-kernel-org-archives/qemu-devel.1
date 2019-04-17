Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1ECC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D72206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EldfGUzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D72206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGich-0006q3-7a
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 07:21:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGibr-0006OZ-U4
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npiggin@gmail.com>) id 1hGibq-00088Y-OJ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:20:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <npiggin@gmail.com>)
	id 1hGibq-00084J-Dj; Wed, 17 Apr 2019 07:20:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id y3so11853031pgk.12;
	Wed, 17 Apr 2019 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:subject:to:cc:references:in-reply-to:mime-version
	:user-agent:message-id:content-transfer-encoding;
	bh=OtoJ0Mr6JiD/+VQ0vGVyovOhsl9CF0B/feiY9pLeJz0=;
	b=EldfGUzUC1QMJ7RndTCSL0TVEbjINwpisyxUnHt5hAKAXM4SqgL9t1yLXpHqepUNBn
	E+v9jDvUBPmrROAjzTjXhtNCx9KoIWuT20B6Rieh83otW5vr9EYJxzq2x6vqSq5l5fCM
	3K3jzhW4hCyiT+oLrzqSTQEiny5uTVz/c/vasSs144AwIRyAnZ2NMfD52isKk0W6T4pa
	TVjEYgqoZ1XeAn9gHQSrquavGUu8S7cxRHiupRYmyLRAAJh75jdDDVkqSnV6Z2V+H48W
	USBzf68rG66uZMdILpjMBoKKYVDYEGG2q5UBqYzuPe1PghY8Z+gwGw76hxXgYEttIljo
	PCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
	:mime-version:user-agent:message-id:content-transfer-encoding;
	bh=OtoJ0Mr6JiD/+VQ0vGVyovOhsl9CF0B/feiY9pLeJz0=;
	b=GJS2BHjRwBqefqqzUhfTItiI8sztIyTd7VWDPP+WkF0BlSzFNmyHgquvICxMMOUFNY
	qbgDfxk/cMubWkOTnI43yjySx0OKutk5nXtA7/ieX3TR57qNqq00MY5LleKhM/KxkMUn
	8uwS9vdeMw7zoYuSnn7QLMAAVNv/xe/6hdu0uYXjnGrEveEOcbPfEz8breP7IIBgK0cM
	rAjm1x598RBR/9kbQDIyDtWcFbpQHHd1TrLSyhAtx2KHh4CsOAr25GfXfEj4EvdoW8/E
	yH+OSYIplkpoEeb/DJ9VE5F+LbD0ymn/404g95zZxkRDwCNpuiIjEPaQWBAleyRryDw1
	G/Yw==
X-Gm-Message-State: APjAAAVV8r6jY3Jch2Xsp9wA4Ui1twIoRjwyw0URVxt5HRgc/pC9KwD9
	4o29uyfUbFONyDsMxlvgRGo=
X-Google-Smtp-Source: APXvYqzz1TI/I021sYV9QFUyW6nAybeLdO6PmxvibmLuBNnENdWAVgaEtdVl6HV9OYj5Vh0GP+a1dQ==
X-Received: by 2002:aa7:920b:: with SMTP id 11mr88810655pfo.3.1555500008059;
	Wed, 17 Apr 2019 04:20:08 -0700 (PDT)
Received: from localhost (61-68-209-100.tpgi.com.au. [61.68.209.100])
	by smtp.gmail.com with ESMTPSA id
	b63sm159387366pfj.54.2019.04.17.04.20.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 04:20:06 -0700 (PDT)
Date: Wed, 17 Apr 2019 21:20:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
In-Reply-To: <20190417015934.GH32705@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555498879.055yucy998.astroid@bobo.none>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v3] spapr: add splpar hcalls H_PROD,
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
Message-ID: <20190417112000.zucNNqTYvazRwe8rZFfEt1WwLm7G54mOveHr6-pALTo@z>

David Gibson's on April 17, 2019 11:59 am:
> On Tue, Apr 16, 2019 at 02:55:52PM +1000, Nicholas Piggin wrote:
>> These implementations have a few deficiencies that are noted, but are
>> good enough for Linux to use.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>=20
>> v3: Removed wrong comment about GPR3, drop H_JOIN for now (at least unti=
l
>> it is tested some more in Linux/KVM), and expand the comment about not
>> prod bit.
>>=20
>>  hw/ppc/spapr_hcall.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 71 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 8a736797b9..8892ad008b 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1065,6 +1065,74 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>>      return H_SUCCESS;
>>  }
>> =20
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
>> +     * PAPR calls for waiting until proded in this case (or presumably
>> +     * an external interrupt if MSR[EE]=3D1, without dispatch sequence =
count
>> +     * check.
>=20
> Is this comment complete?  It's missing a closing parenthesis at the
> very least.

Needs closing parenthesis after EE=3D1 AFAIKS. Good catch.
=20
>> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    target_long target =3D args[0];
>> +    CPUState *cs;
>> +
>> +    /*
>> +     * PAPR specifies there should be a prod flag should be associated =
with
>> +     * a vCPU, which gets set here, tested by H_CEDE, and cleared any t=
ime
>> +     * the vCPU is dispatched, including via preemption.
>> +     *
>> +     * We don't implement this because it is not used by Linux. The bit=
 would
>> +     * be difficult or impossible to use properly because preemption ca=
n not
>> +     * be prevented so dispatch sequence count would have to somehow be=
 used
>> +     * to detect it.
>=20
> Hm.  AFAIK the dispatch sequence count only exists with KVM, so I
> don't see how testing it would fit with a userspace implementation of PRO=
D.

Right, I think even if you did have it, the prod bit really doesn't
offer much value. You could perhaps enter CEDE without hard disabling
interrupts race-free, something like --

  do {
    seq =3D dispatch_seq;
    if (work_pending)
      return;
  } while (seq !=3D dispatch_seq);
  hcall(H_CEDE);

  vs

  work_pending =3D 1;
  hcall(H_PROD);

But Linux certainly doesn't do anything like this, and after the
barriers needed and added complexity to work out the idle state on
the producer side, it's unlikely to be worthwhile (and either way
dwarfed by the hcall cost).

Buut... in theory it does not conform to PAPR exactly. We would need
to clear it on all guest dispatch, and also implement the dispatch
counter if we are worried about this.

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
>> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
>>      /* hcall-splpar */
>>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
>>      spapr_register_hypercall(H_CEDE, h_cede);
>> +    spapr_register_hypercall(H_CONFER, h_confer);
>> +    spapr_register_hypercall(H_PROD, h_prod);
>> +
>>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);
>=20
> You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
> they enabled by default, or is that an intentional change?

Oh, it was not intentional, I must not understand how this works. Why
is this no longer enabling the those hcalls?

Thanks,
Nick

=

