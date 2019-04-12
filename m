Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45142C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE9F2184B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE9F2184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErgF-0002SB-5g
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:37:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hErfQ-00025V-LU
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hErfO-0004gt-1a
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:36:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hErfK-0004dB-4L; Fri, 12 Apr 2019 04:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E3F4308620A;
	Fri, 12 Apr 2019 08:36:04 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 914CC60FCD;
	Fri, 12 Apr 2019 08:36:02 +0000 (UTC)
Date: Fri, 12 Apr 2019 10:35:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alistair Francis <alistair23@gmail.com>
Message-ID: <20190412103558.7be8383d@redhat.com>
In-Reply-To: <CAKmqyKOQ9a5Q8c83ufCgQgsa_RdQv01dDFCLFGmiSC8mkTw0LQ@mail.gmail.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
	<20190411141848.119ee969@redhat.com>
	<CAKmqyKOQ9a5Q8c83ufCgQgsa_RdQv01dDFCLFGmiSC8mkTw0LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 08:36:04 +0000 (UTC)
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
Message-ID: <20190412083558.1-effL0YJ1qVgfPwvcp_OBG4ry52TTj6_SiEDuJFnmo@z>

On Thu, 11 Apr 2019 13:42:20 -0700
Alistair Francis <alistair23@gmail.com> wrote:

> On Thu, Apr 11, 2019 at 5:18 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Wed, 10 Apr 2019 23:10:25 +0000
> > Alistair Francis <Alistair.Francis@wdc.com> wrote:
> > =20
> > > If a user specifies a CPU that we don't understand then we want to fa=
ll
> > > back to a CPU generated from the ISA string. =20
> > It might look like a nice thing to do at the beginning, but
> > fallbacks become a source of pain in future and get in the way
> > of refactorings if there is a promise to maintain defaults (fallbacks)
> > stable.
> >
> > I suggest do not fallback to anything, just fail cleanly
> > with informative error telling users what is wrong and let user
> > fix their invalid CLI in the first place. =20
>=20
> Maybe fall back isn't the right word then, as this is the goal of this
> series. Here is what I want to happen:
>=20
> User runs QEMU RISC-V without -cpu option:
>     The user gets a CPU that supports "standard" ISA extensions, as
> what happens now
>=20
> User runs QEMU RISC-V with a CPU model that is hard coded in cpu.h
> (such as TYPE_RISCV_CPU_SIFIVE_U54):
>     The user gets a CPU that matches that hard coded CPU string/init
>=20
> User runs QEMU RISC-V with a RISC-V ISA string that isn't hardcoded
> (for example rv64gcsuh):
>     QEMU will dynamically create a CPU based on the specified bit
> length (rv32/rv64) and the ISA extensions supported
>     The goal of this is to allow new extensions to be enabled and
> disabled as required. For example when we add a new extension maybe we
> don't want it on by default but we want an option to enable it. Or
> maybe a user wants to test their code on a model without compressed
> instruction (c extension) support.

=46rom commit message I"g read it as fallback, so as far as user gets
deterministic (always the same) CPU according to what they asked on CLI
it's fine. In that case commit message probably should be rephrased.

more bellow
> Alistair
>=20
> >
> > =20
> > > At the moment the generated CPU is assumed to be a privledge spec
> > > version 1.10 CPU with an MMU. This can be changed in the future.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > > v3:
> > >  - Ensure a minimal length so we don't run off the end of the string.
> > >  - Don't parse the rv32/rv64 in the loop
> > >  target/riscv/cpu.c | 101 +++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  target/riscv/cpu.h |   2 +
> > >  2 files changed, 102 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index d61bce6d55..27be9e412a 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -19,6 +19,7 @@
> > >
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/log.h"
> > > +#include "qemu/error-report.h"
> > >  #include "cpu.h"
> > >  #include "exec/exec-all.h"
> > >  #include "qapi/error.h"
> > > @@ -103,6 +104,99 @@ static void set_resetvec(CPURISCVState *env, int=
 resetvec)
> > >  #endif
> > >  }
> > >
> > > +static void riscv_generate_cpu_init(Object *obj)
> > > +{
> > > +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> > > +    CPURISCVState *env =3D &cpu->env;
> > > +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> > > +    const char *riscv_cpu =3D mcc->isa_str;
> > > +    target_ulong target_misa =3D 0;
> > > +    target_ulong rvxlen =3D 0;
> > > +    int i;
> > > +    bool valid =3D false;
> > > +
> > > +    /*
> > > +     * We need at least 5 charecters for the string to be valid. Che=
ck that
> > > +     * now so we can be lazier later.
> > > +     */
> > > +    if (strlen(riscv_cpu) < 5) {
> > > +        error_report("'%s' does not appear to be a valid RISC-V ISA =
string",
> > > +                     riscv_cpu);
> > > +        exit(1);

if it's programming error it should be assert
but in general instance_init()  should never fail.

the same applies to errors or warnings within this function.

> > > +    }
> > > +
> > > +    if (riscv_cpu[0] =3D=3D 'r' && riscv_cpu[1] =3D=3D 'v') {
> > > +        /* Starts with "rv" */
> > > +        if (riscv_cpu[2] =3D=3D '3' && riscv_cpu[3] =3D=3D '2') {
> > > +            valid =3D true;
> > > +            rvxlen =3D RV32;
> > > +        }
> > > +        if (riscv_cpu[2] =3D=3D '6' && riscv_cpu[3] =3D=3D '4') {
> > > +            valid =3D true;
> > > +            rvxlen =3D RV64;
> > > +        }
> > > +    }
> > > +
> > > +    if (!valid) {
> > > +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> > > +                     riscv_cpu);
> > > +        exit(1);
> > > +    }
> > > +
> > > +    for (i =3D 4; i < strlen(riscv_cpu); i++) {
> > > +        switch (riscv_cpu[i]) {
> > > +        case 'i':
> > > +            if (target_misa & RVE) {
> > > +                error_report("I and E extensions are incompatible");
> > > +                exit(1);
> > > +            }
> > > +            target_misa |=3D RVI;
> > > +            continue;
> > > +        case 'e':
> > > +            if (target_misa & RVI) {
> > > +                error_report("I and E extensions are incompatible");
> > > +                exit(1);
> > > +            }
> > > +            target_misa |=3D RVE;
> > > +            continue;
> > > +        case 'g':
> > > +            target_misa |=3D RVI | RVM | RVA | RVF | RVD;
> > > +            continue;
> > > +        case 'm':
> > > +            target_misa |=3D RVM;
> > > +            continue;
> > > +        case 'a':
> > > +            target_misa |=3D RVA;
> > > +            continue;
> > > +        case 'f':
> > > +            target_misa |=3D RVF;
> > > +            continue;
> > > +        case 'd':
> > > +            target_misa |=3D RVD;
> > > +            continue;
> > > +        case 'c':
> > > +            target_misa |=3D RVC;
> > > +            continue;
> > > +        case 's':
> > > +            target_misa |=3D RVS;
> > > +            continue;
> > > +        case 'u':
> > > +            target_misa |=3D RVU;
> > > +            continue;
> > > +        default:
> > > +            warn_report("QEMU does not support the %c extension",
> > > +                        riscv_cpu[i]);
that's what looks to me like fallback, and what makes
CPU features for this CPU type non deterministic.
I'm not sure what you are trying to achieve here, but it look like
you are trying to verify MachineClass field in object constructor
along with other things.

I'd put all MachineClass checks in class_init and abort on error
since invalid mcc->isa_str is codding error.
If you can make some checks compile time it would be even better.


> > > +            continue;
> > > +        }
> > > +    }
> > > +
> > > +    set_misa(env, rvxlen | target_misa);
> > > +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> > > +    set_resetvec(env, DEFAULT_RSTVEC);
> > > +    set_feature(env, RISCV_FEATURE_MMU);
> > > +    set_feature(env, RISCV_FEATURE_PMP);
> > > +}
> > > +
> > >  static void riscv_any_cpu_init(Object *obj)
> > >  {
> > >      CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> > > @@ -178,6 +272,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
> > >  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
> > >  {
> > >      ObjectClass *oc;
> > > +    RISCVCPUClass *mcc;
> > >      char *typename;
> > >      char **cpuname;
> > >
> > > @@ -188,7 +283,10 @@ static ObjectClass *riscv_cpu_class_by_name(cons=
t char *cpu_model)
> > >      g_free(typename);
> > >      if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
> > >          object_class_is_abstract(oc)) {
> > > -        return NULL;
> > > +        /* No CPU found, try the generic CPU and pass in the ISA str=
ing */
> > > +        oc =3D object_class_by_name(TYPE_RISCV_CPU_GEN);
> > > +        mcc =3D RISCV_CPU_CLASS(oc);
> > > +        mcc->isa_str =3D g_strdup(cpu_model);
> > >      }
> > >      return oc;
> > >  }
> > > @@ -440,6 +538,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
> > >          .class_init =3D riscv_cpu_class_init,
> > >      },
> > >      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
> > > +    DEFINE_CPU(TYPE_RISCV_CPU_GEN,              riscv_generate_cpu_i=
nit),
> > >  #if defined(TARGET_RISCV32)
> > >      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_=
cpu_init),
> > >      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_=
cpu_init),
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index 20bce8742e..453108a855 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -48,6 +48,7 @@
> > >  #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
> > >
> > >  #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
> > > +#define TYPE_RISCV_CPU_GEN              RISCV_CPU_TYPE_NAME("rv*")
> > >  #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcs=
u-v1.9.1")
> > >  #define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcs=
u-v1.10.0")
> > >  #define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32ima=
cu-nommu")
> > > @@ -211,6 +212,7 @@ typedef struct RISCVCPUClass {
> > >      /*< public >*/
> > >      DeviceRealize parent_realize;
> > >      void (*parent_reset)(CPUState *cpu);
> > > +    const char *isa_str;
> > >  } RISCVCPUClass;
> > >
> > >  /** =20
> > =20


