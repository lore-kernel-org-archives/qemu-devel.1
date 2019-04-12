Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD6C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC89C218C3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4r36inl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC89C218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3cV-0001ys-2L
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:21:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hF3bZ-0001eN-ET
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hF3bX-000510-KG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:21:01 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:44452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hF3bX-0004tn-00; Fri, 12 Apr 2019 17:20:59 -0400
Received: by mail-lf1-x143.google.com with SMTP id h18so8498220lfj.11;
	Fri, 12 Apr 2019 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BmwYvs4+Fla/bP5JLFDK1SGk/3ecE+2Wi3asA+VVRrA=;
	b=t4r36inlekl8Pc2Q/gB6uQxwDb3xAoYJU89/TOJG3VwXMdOOGIWlQJzIfmoE4Agc/i
	hnv1mzUokl4E3h2EwRcj9+vWf6g1X1SmQjxtGWi7mThcb8n6J6PzAIgKTCc8iHQb0TBB
	Y85kOIHBkGuvvNci7cEr+xYCWrALKLXdHw2/EDPr5JoN5lcU4edCV4M3iMMB0JdeZI7J
	shZlwd+eOWNBujlV1ERwT8I+PUgQgSMfGSAHWRb02F4n1J5pFlLOViIubXTPUlq2Cmos
	6c+yj198i6kYAUN4qVKZhLBHaZOxE3BvMuGz8osY+kfUCT73Q7C4DxmIWTds9HKD3cSA
	1tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BmwYvs4+Fla/bP5JLFDK1SGk/3ecE+2Wi3asA+VVRrA=;
	b=OZLsyqz/sE+a2cl1hLnHTW0O/LTq3zu4fRh8TJUcRTSbWGRweLTSIvMs+ZavDDSZqR
	OmhvZGVyPA0/2gMH/J1DT2GWNpjOIkUQAYyi6Dq4qrjq+PzXS6u9eXvsThz4QUZs2OJ/
	5plZP9eHpFBz787t5FROE03OYbwOCIGWQIihDctqtNpdGFh/6H8n1fLg2di14LV6qQqn
	IM11JCoPZPj5K9iknC39l0V0Zft4pa/e1KTyWV0qIlOszbvfQb7IFw6qn2k8PiVa659E
	+2VvQ6MGF/MfSHNfc7MTVtpUYLFbSMaY21lsPMh915QB56Va2eesTdChXwwatCXwmzoz
	6a7w==
X-Gm-Message-State: APjAAAXSKO5rlH+/KVofWEKVNbNb2fq5iwxvLs7ZdiD8YIdN+Lwa/q2y
	0Qxb8LN5JuOAfUmcfkhDZDGgqsIP5nwrcQ+ylew=
X-Google-Smtp-Source: APXvYqzyPyFB4w0JRrpV5casLsnKsiPM8cFP0u3dbeq/s45/40dWR5ZC7Wm4WKn/oxlEUpHtG7D/r5ML525bjOG5fd0=
X-Received: by 2002:ac2:420b:: with SMTP id y11mr32636569lfh.104.1555104054275;
	Fri, 12 Apr 2019 14:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
	<20190411141848.119ee969@redhat.com>
	<CAKmqyKOQ9a5Q8c83ufCgQgsa_RdQv01dDFCLFGmiSC8mkTw0LQ@mail.gmail.com>
	<20190412103558.7be8383d@redhat.com>
In-Reply-To: <20190412103558.7be8383d@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Apr 2019 14:19:16 -0700
Message-ID:
 <CAKmqyKOFs8Pv4np+BXyVYGRFwLKn9N-H7q=7JN+nBprAjHBYCQ@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"palmer@sifive.com" <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412211916.5KOb3fbJ3DgVAK30BI61gwvIOd-8XzSki3i14sBT7lY@z>

On Fri, Apr 12, 2019 at 1:36 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 11 Apr 2019 13:42:20 -0700
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Thu, Apr 11, 2019 at 5:18 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Wed, 10 Apr 2019 23:10:25 +0000
> > > Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > >
> > > > If a user specifies a CPU that we don't understand then we want to fall
> > > > back to a CPU generated from the ISA string.
> > > It might look like a nice thing to do at the beginning, but
> > > fallbacks become a source of pain in future and get in the way
> > > of refactorings if there is a promise to maintain defaults (fallbacks)
> > > stable.
> > >
> > > I suggest do not fallback to anything, just fail cleanly
> > > with informative error telling users what is wrong and let user
> > > fix their invalid CLI in the first place.
> >
> > Maybe fall back isn't the right word then, as this is the goal of this
> > series. Here is what I want to happen:
> >
> > User runs QEMU RISC-V without -cpu option:
> >     The user gets a CPU that supports "standard" ISA extensions, as
> > what happens now
> >
> > User runs QEMU RISC-V with a CPU model that is hard coded in cpu.h
> > (such as TYPE_RISCV_CPU_SIFIVE_U54):
> >     The user gets a CPU that matches that hard coded CPU string/init
> >
> > User runs QEMU RISC-V with a RISC-V ISA string that isn't hardcoded
> > (for example rv64gcsuh):
> >     QEMU will dynamically create a CPU based on the specified bit
> > length (rv32/rv64) and the ISA extensions supported
> >     The goal of this is to allow new extensions to be enabled and
> > disabled as required. For example when we add a new extension maybe we
> > don't want it on by default but we want an option to enable it. Or
> > maybe a user wants to test their code on a model without compressed
> > instruction (c extension) support.
>
> From commit message I"g read it as fallback, so as far as user gets
> deterministic (always the same) CPU according to what they asked on CLI
> it's fine. In that case commit message probably should be rephrased.
>
> more bellow
> > Alistair
> >
> > >
> > >
> > > > At the moment the generated CPU is assumed to be a privledge spec
> > > > version 1.10 CPU with an MMU. This can be changed in the future.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > > v3:
> > > >  - Ensure a minimal length so we don't run off the end of the string.
> > > >  - Don't parse the rv32/rv64 in the loop
> > > >  target/riscv/cpu.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-
> > > >  target/riscv/cpu.h |   2 +
> > > >  2 files changed, 102 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > index d61bce6d55..27be9e412a 100644
> > > > --- a/target/riscv/cpu.c
> > > > +++ b/target/riscv/cpu.c
> > > > @@ -19,6 +19,7 @@
> > > >
> > > >  #include "qemu/osdep.h"
> > > >  #include "qemu/log.h"
> > > > +#include "qemu/error-report.h"
> > > >  #include "cpu.h"
> > > >  #include "exec/exec-all.h"
> > > >  #include "qapi/error.h"
> > > > @@ -103,6 +104,99 @@ static void set_resetvec(CPURISCVState *env, int resetvec)
> > > >  #endif
> > > >  }
> > > >
> > > > +static void riscv_generate_cpu_init(Object *obj)
> > > > +{
> > > > +    RISCVCPU *cpu = RISCV_CPU(obj);
> > > > +    CPURISCVState *env = &cpu->env;
> > > > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> > > > +    const char *riscv_cpu = mcc->isa_str;
> > > > +    target_ulong target_misa = 0;
> > > > +    target_ulong rvxlen = 0;
> > > > +    int i;
> > > > +    bool valid = false;
> > > > +
> > > > +    /*
> > > > +     * We need at least 5 charecters for the string to be valid. Check that
> > > > +     * now so we can be lazier later.
> > > > +     */
> > > > +    if (strlen(riscv_cpu) < 5) {
> > > > +        error_report("'%s' does not appear to be a valid RISC-V ISA string",
> > > > +                     riscv_cpu);
> > > > +        exit(1);
>
> if it's programming error it should be assert
> but in general instance_init()  should never fail.

We are checking for a user specified CPU string, not a programming
error so an assert() isn't correct here.

If *init() can't fail how should this be handled?

>
> the same applies to errors or warnings within this function.
>
> > > > +    }
> > > > +
> > > > +    if (riscv_cpu[0] == 'r' && riscv_cpu[1] == 'v') {
> > > > +        /* Starts with "rv" */
> > > > +        if (riscv_cpu[2] == '3' && riscv_cpu[3] == '2') {
> > > > +            valid = true;
> > > > +            rvxlen = RV32;
> > > > +        }
> > > > +        if (riscv_cpu[2] == '6' && riscv_cpu[3] == '4') {
> > > > +            valid = true;
> > > > +            rvxlen = RV64;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    if (!valid) {
> > > > +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> > > > +                     riscv_cpu);
> > > > +        exit(1);
> > > > +    }
> > > > +
> > > > +    for (i = 4; i < strlen(riscv_cpu); i++) {
> > > > +        switch (riscv_cpu[i]) {
> > > > +        case 'i':
> > > > +            if (target_misa & RVE) {
> > > > +                error_report("I and E extensions are incompatible");
> > > > +                exit(1);
> > > > +            }
> > > > +            target_misa |= RVI;
> > > > +            continue;
> > > > +        case 'e':
> > > > +            if (target_misa & RVI) {
> > > > +                error_report("I and E extensions are incompatible");
> > > > +                exit(1);
> > > > +            }
> > > > +            target_misa |= RVE;
> > > > +            continue;
> > > > +        case 'g':
> > > > +            target_misa |= RVI | RVM | RVA | RVF | RVD;
> > > > +            continue;
> > > > +        case 'm':
> > > > +            target_misa |= RVM;
> > > > +            continue;
> > > > +        case 'a':
> > > > +            target_misa |= RVA;
> > > > +            continue;
> > > > +        case 'f':
> > > > +            target_misa |= RVF;
> > > > +            continue;
> > > > +        case 'd':
> > > > +            target_misa |= RVD;
> > > > +            continue;
> > > > +        case 'c':
> > > > +            target_misa |= RVC;
> > > > +            continue;
> > > > +        case 's':
> > > > +            target_misa |= RVS;
> > > > +            continue;
> > > > +        case 'u':
> > > > +            target_misa |= RVU;
> > > > +            continue;
> > > > +        default:
> > > > +            warn_report("QEMU does not support the %c extension",
> > > > +                        riscv_cpu[i]);
> that's what looks to me like fallback, and what makes
> CPU features for this CPU type non deterministic.

What do you mean? QEMU will always parse the specified CPU string and
create a CPU based on the features specified by the user. For each
version of QEMU it will always result in the same outcome for the same
user supplied command line argument.

Newer QEMU versions will support more features though, so they will
accept different options.

> I'm not sure what you are trying to achieve here, but it look like
> you are trying to verify MachineClass field in object constructor
> along with other things.

I'm just trying to parse the -cpu string option.

>
> I'd put all MachineClass checks in class_init and abort on error
> since invalid mcc->isa_str is codding error.

No, it's a user error.

Alistair

> If you can make some checks compile time it would be even better.
>
>
> > > > +            continue;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    set_misa(env, rvxlen | target_misa);
> > > > +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> > > > +    set_resetvec(env, DEFAULT_RSTVEC);
> > > > +    set_feature(env, RISCV_FEATURE_MMU);
> > > > +    set_feature(env, RISCV_FEATURE_PMP);
> > > > +}
> > > > +
> > > >  static void riscv_any_cpu_init(Object *obj)
> > > >  {
> > > >      CPURISCVState *env = &RISCV_CPU(obj)->env;
> > > > @@ -178,6 +272,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
> > > >  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> > > >  {
> > > >      ObjectClass *oc;
> > > > +    RISCVCPUClass *mcc;
> > > >      char *typename;
> > > >      char **cpuname;
> > > >
> > > > @@ -188,7 +283,10 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> > > >      g_free(typename);
> > > >      if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
> > > >          object_class_is_abstract(oc)) {
> > > > -        return NULL;
> > > > +        /* No CPU found, try the generic CPU and pass in the ISA string */
> > > > +        oc = object_class_by_name(TYPE_RISCV_CPU_GEN);
> > > > +        mcc = RISCV_CPU_CLASS(oc);
> > > > +        mcc->isa_str = g_strdup(cpu_model);
> > > >      }
> > > >      return oc;
> > > >  }
> > > > @@ -440,6 +538,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
> > > >          .class_init = riscv_cpu_class_init,
> > > >      },
> > > >      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
> > > > +    DEFINE_CPU(TYPE_RISCV_CPU_GEN,              riscv_generate_cpu_init),
> > > >  #if defined(TARGET_RISCV32)
> > > >      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
> > > >      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init),
> > > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > > index 20bce8742e..453108a855 100644
> > > > --- a/target/riscv/cpu.h
> > > > +++ b/target/riscv/cpu.h
> > > > @@ -48,6 +48,7 @@
> > > >  #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
> > > >
> > > >  #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
> > > > +#define TYPE_RISCV_CPU_GEN              RISCV_CPU_TYPE_NAME("rv*")
> > > >  #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
> > > >  #define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
> > > >  #define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
> > > > @@ -211,6 +212,7 @@ typedef struct RISCVCPUClass {
> > > >      /*< public >*/
> > > >      DeviceRealize parent_realize;
> > > >      void (*parent_reset)(CPUState *cpu);
> > > > +    const char *isa_str;
> > > >  } RISCVCPUClass;
> > > >
> > > >  /**
> > >
>

