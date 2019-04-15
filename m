Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D09C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A996A20656
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A996A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46729 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFx92-0008QC-SG
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 04:39:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hFx8H-00088V-7i
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hFx8F-0006f7-Dj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:38:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hFx8E-0006eW-TF; Mon, 15 Apr 2019 04:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C486330247;
	Mon, 15 Apr 2019 08:38:24 +0000 (UTC)
Received: from Igors-MacBook-Pro.local (ovpn-112-37.ams2.redhat.com
	[10.36.112.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F99C608C0;
	Mon, 15 Apr 2019 08:38:22 +0000 (UTC)
Date: Mon, 15 Apr 2019 10:38:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Message-ID: <20190415103815.35f45e99@Igors-MacBook-Pro.local>
In-Reply-To: <CAKmqyKOFs8Pv4np+BXyVYGRFwLKn9N-H7q=7JN+nBprAjHBYCQ@mail.gmail.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
	<20190411141848.119ee969@redhat.com>
	<CAKmqyKOQ9a5Q8c83ufCgQgsa_RdQv01dDFCLFGmiSC8mkTw0LQ@mail.gmail.com>
	<20190412103558.7be8383d@redhat.com>
	<CAKmqyKOFs8Pv4np+BXyVYGRFwLKn9N-H7q=7JN+nBprAjHBYCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 15 Apr 2019 08:38:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Message-ID: <20190415083815.xM850qJC0LiHXdbKKCpVYGw_Y_OBh3twG_MtF88qeMs@z>

On Fri, 12 Apr 2019 14:19:16 -0700
Alistair Francis <alistair23@gmail.com> wrote:

> On Fri, Apr 12, 2019 at 1:36 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Thu, 11 Apr 2019 13:42:20 -0700
> > Alistair Francis <alistair23@gmail.com> wrote:
> >
> > > On Thu, Apr 11, 2019 at 5:18 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > > >
> > > > On Wed, 10 Apr 2019 23:10:25 +0000
> > > > Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > > >
> > > > > If a user specifies a CPU that we don't understand then we want to fall
> > > > > back to a CPU generated from the ISA string.
> > > > It might look like a nice thing to do at the beginning, but
> > > > fallbacks become a source of pain in future and get in the way
> > > > of refactorings if there is a promise to maintain defaults (fallbacks)
> > > > stable.
> > > >
> > > > I suggest do not fallback to anything, just fail cleanly
> > > > with informative error telling users what is wrong and let user
> > > > fix their invalid CLI in the first place.
> > >
> > > Maybe fall back isn't the right word then, as this is the goal of this
> > > series. Here is what I want to happen:
> > >
> > > User runs QEMU RISC-V without -cpu option:
> > >     The user gets a CPU that supports "standard" ISA extensions, as
> > > what happens now
> > >
> > > User runs QEMU RISC-V with a CPU model that is hard coded in cpu.h
> > > (such as TYPE_RISCV_CPU_SIFIVE_U54):
> > >     The user gets a CPU that matches that hard coded CPU string/init
> > >
> > > User runs QEMU RISC-V with a RISC-V ISA string that isn't hardcoded
> > > (for example rv64gcsuh):
> > >     QEMU will dynamically create a CPU based on the specified bit
> > > length (rv32/rv64) and the ISA extensions supported
> > >     The goal of this is to allow new extensions to be enabled and
> > > disabled as required. For example when we add a new extension maybe we
> > > don't want it on by default but we want an option to enable it. Or
> > > maybe a user wants to test their code on a model without compressed
> > > instruction (c extension) support.
> >
> > From commit message I"g read it as fallback, so as far as user gets
> > deterministic (always the same) CPU according to what they asked on CLI
> > it's fine. In that case commit message probably should be rephrased.
> >
> > more bellow
> > > Alistair
> > >
> > > >
> > > >
> > > > > At the moment the generated CPU is assumed to be a privledge spec
> > > > > version 1.10 CPU with an MMU. This can be changed in the future.
> > > > >
> > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > ---
> > > > > v3:
> > > > >  - Ensure a minimal length so we don't run off the end of the string.
> > > > >  - Don't parse the rv32/rv64 in the loop
> > > > >  target/riscv/cpu.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-
> > > > >  target/riscv/cpu.h |   2 +
> > > > >  2 files changed, 102 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > > index d61bce6d55..27be9e412a 100644
> > > > > --- a/target/riscv/cpu.c
> > > > > +++ b/target/riscv/cpu.c
> > > > > @@ -19,6 +19,7 @@
> > > > >
> > > > >  #include "qemu/osdep.h"
> > > > >  #include "qemu/log.h"
> > > > > +#include "qemu/error-report.h"
> > > > >  #include "cpu.h"
> > > > >  #include "exec/exec-all.h"
> > > > >  #include "qapi/error.h"
> > > > > @@ -103,6 +104,99 @@ static void set_resetvec(CPURISCVState *env, int resetvec)
> > > > >  #endif
> > > > >  }
> > > > >
> > > > > +static void riscv_generate_cpu_init(Object *obj)
> > > > > +{
> > > > > +    RISCVCPU *cpu = RISCV_CPU(obj);
> > > > > +    CPURISCVState *env = &cpu->env;
> > > > > +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> > > > > +    const char *riscv_cpu = mcc->isa_str;
> > > > > +    target_ulong target_misa = 0;
> > > > > +    target_ulong rvxlen = 0;
> > > > > +    int i;
> > > > > +    bool valid = false;
> > > > > +
> > > > > +    /*
> > > > > +     * We need at least 5 charecters for the string to be valid. Check that
> > > > > +     * now so we can be lazier later.
> > > > > +     */
> > > > > +    if (strlen(riscv_cpu) < 5) {
> > > > > +        error_report("'%s' does not appear to be a valid RISC-V ISA string",
> > > > > +                     riscv_cpu);
> > > > > +        exit(1);
> >
> > if it's programming error it should be assert
> > but in general instance_init()  should never fail.
> 
> We are checking for a user specified CPU string, not a programming
> error so an assert() isn't correct here.
> 
> If *init() can't fail how should this be handled?
typical flow for device object is

 object_new(foo) -> foo_init_fn()
 set properties on foo
 set 'realize' property to 'true' -> foo_realize_fn()

all checks should be performed in realize() or during property setting.

> > the same applies to errors or warnings within this function.
> >
> > > > > +    }
> > > > > +
> > > > > +    if (riscv_cpu[0] == 'r' && riscv_cpu[1] == 'v') {
> > > > > +        /* Starts with "rv" */
> > > > > +        if (riscv_cpu[2] == '3' && riscv_cpu[3] == '2') {
> > > > > +            valid = true;
> > > > > +            rvxlen = RV32;
> > > > > +        }
> > > > > +        if (riscv_cpu[2] == '6' && riscv_cpu[3] == '4') {
> > > > > +            valid = true;
> > > > > +            rvxlen = RV64;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    if (!valid) {
> > > > > +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> > > > > +                     riscv_cpu);
> > > > > +        exit(1);
> > > > > +    }
> > > > > +
> > > > > +    for (i = 4; i < strlen(riscv_cpu); i++) {
> > > > > +        switch (riscv_cpu[i]) {
> > > > > +        case 'i':
> > > > > +            if (target_misa & RVE) {
> > > > > +                error_report("I and E extensions are incompatible");
> > > > > +                exit(1);
> > > > > +            }
> > > > > +            target_misa |= RVI;
> > > > > +            continue;
> > > > > +        case 'e':
> > > > > +            if (target_misa & RVI) {
> > > > > +                error_report("I and E extensions are incompatible");
> > > > > +                exit(1);
> > > > > +            }
> > > > > +            target_misa |= RVE;
> > > > > +            continue;
> > > > > +        case 'g':
> > > > > +            target_misa |= RVI | RVM | RVA | RVF | RVD;
> > > > > +            continue;
> > > > > +        case 'm':
> > > > > +            target_misa |= RVM;
> > > > > +            continue;
> > > > > +        case 'a':
> > > > > +            target_misa |= RVA;
> > > > > +            continue;
> > > > > +        case 'f':
> > > > > +            target_misa |= RVF;
> > > > > +            continue;
> > > > > +        case 'd':
> > > > > +            target_misa |= RVD;
> > > > > +            continue;
> > > > > +        case 'c':
> > > > > +            target_misa |= RVC;
> > > > > +            continue;
> > > > > +        case 's':
> > > > > +            target_misa |= RVS;
> > > > > +            continue;
> > > > > +        case 'u':
> > > > > +            target_misa |= RVU;
> > > > > +            continue;
> > > > > +        default:
> > > > > +            warn_report("QEMU does not support the %c extension",
> > > > > +                        riscv_cpu[i]);
> > that's what looks to me like fallback, and what makes
> > CPU features for this CPU type non deterministic.
> 
> What do you mean? QEMU will always parse the specified CPU string and
> create a CPU based on the features specified by the user. For each
> version of QEMU it will always result in the same outcome for the same
> user supplied command line argument.

I've meant that here you would print warning and happily continue parsing
user input ignoring input error. One should error out instead and make
user fix error.

> 
> Newer QEMU versions will support more features though, so they will
> accept different options.
> 
> > I'm not sure what you are trying to achieve here, but it look like
> > you are trying to verify MachineClass field in object constructor
> > along with other things.
> 
> I'm just trying to parse the -cpu string option.
> 
> >
> > I'd put all MachineClass checks in class_init and abort on error
> > since invalid mcc->isa_str is codding error.
> 
> No, it's a user error.

Parsing -cpu by assigning to class members user input looks unusual.

We had a custom parsing for x86 & sparc cpus, but that was factored out
into compat utilities and we shouldn't do it anywhere else without very
compelling reason.

Currently it's preferred to use canonical form for cpu properties, like:

  -cpu foo,prop1=x,prop2=y,...

and let the generic parser to do the job. For it to work you would need
to create a property per a cpu feature.

This way it will work fine with -cpu and -device/device_add without any
custom parsing involved.

> Alistair
> 
> > If you can make some checks compile time it would be even better.
> >
> >
> > > > > +            continue;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    set_misa(env, rvxlen | target_misa);
> > > > > +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> > > > > +    set_resetvec(env, DEFAULT_RSTVEC);
> > > > > +    set_feature(env, RISCV_FEATURE_MMU);
> > > > > +    set_feature(env, RISCV_FEATURE_PMP);
> > > > > +}
> > > > > +
> > > > >  static void riscv_any_cpu_init(Object *obj)
> > > > >  {
> > > > >      CPURISCVState *env = &RISCV_CPU(obj)->env;
> > > > > @@ -178,6 +272,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
> > > > >  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> > > > >  {
> > > > >      ObjectClass *oc;
> > > > > +    RISCVCPUClass *mcc;
> > > > >      char *typename;
> > > > >      char **cpuname;
> > > > >
> > > > > @@ -188,7 +283,10 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> > > > >      g_free(typename);
> > > > >      if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
> > > > >          object_class_is_abstract(oc)) {
> > > > > -        return NULL;
> > > > > +        /* No CPU found, try the generic CPU and pass in the ISA string */
> > > > > +        oc = object_class_by_name(TYPE_RISCV_CPU_GEN);
> > > > > +        mcc = RISCV_CPU_CLASS(oc);
> > > > > +        mcc->isa_str = g_strdup(cpu_model);
> > > > >      }
> > > > >      return oc;
> > > > >  }
> > > > > @@ -440,6 +538,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
> > > > >          .class_init = riscv_cpu_class_init,
> > > > >      },
> > > > >      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
> > > > > +    DEFINE_CPU(TYPE_RISCV_CPU_GEN,              riscv_generate_cpu_init),
> > > > >  #if defined(TARGET_RISCV32)
> > > > >      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
> > > > >      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init),
> > > > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > > > index 20bce8742e..453108a855 100644
> > > > > --- a/target/riscv/cpu.h
> > > > > +++ b/target/riscv/cpu.h
> > > > > @@ -48,6 +48,7 @@
> > > > >  #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
> > > > >
> > > > >  #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
> > > > > +#define TYPE_RISCV_CPU_GEN              RISCV_CPU_TYPE_NAME("rv*")
> > > > >  #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
> > > > >  #define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
> > > > >  #define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
> > > > > @@ -211,6 +212,7 @@ typedef struct RISCVCPUClass {
> > > > >      /*< public >*/
> > > > >      DeviceRealize parent_realize;
> > > > >      void (*parent_reset)(CPUState *cpu);
> > > > > +    const char *isa_str;
> > > > >  } RISCVCPUClass;
> > > > >
> > > > >  /**
> > > >
> >


