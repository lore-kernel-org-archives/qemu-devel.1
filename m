Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC90AC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5F220870
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5F220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGODO-00078T-MT
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:33:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGO4B-0000Dk-O7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGO47-0005Ki-GL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hGO44-0005DC-5m; Tue, 16 Apr 2019 09:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7658A307CB3F;
	Tue, 16 Apr 2019 13:23:44 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D06171001F41;
	Tue, 16 Apr 2019 13:23:40 +0000 (UTC)
Date: Tue, 16 Apr 2019 14:23:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <20190416132337.GN31311@redhat.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 16 Apr 2019 13:23:49 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"palmer@sifive.com" <palmer@sifive.com>,
	"qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416132337.Lh2RdTJ6xqmh48NVp9VhHmRe9sPBB93lMee9Gr3JlAQ@z>

On Wed, Apr 10, 2019 at 11:10:25PM +0000, Alistair Francis wrote:
> If a user specifies a CPU that we don't understand then we want to fall
> back to a CPU generated from the ISA string.
> 
> At the moment the generated CPU is assumed to be a privledge spec
> version 1.10 CPU with an MMU. This can be changed in the future.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>  - Ensure a minimal length so we don't run off the end of the string.
>  - Don't parse the rv32/rv64 in the loop
>  target/riscv/cpu.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/cpu.h |   2 +
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..27be9e412a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -19,6 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "qapi/error.h"
> @@ -103,6 +104,99 @@ static void set_resetvec(CPURISCVState *env, int resetvec)
>  #endif
>  }
>  
> +static void riscv_generate_cpu_init(Object *obj)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    CPURISCVState *env = &cpu->env;
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> +    const char *riscv_cpu = mcc->isa_str;
> +    target_ulong target_misa = 0;
> +    target_ulong rvxlen = 0;
> +    int i;
> +    bool valid = false;
> +
> +    /*
> +     * We need at least 5 charecters for the string to be valid. Check that
> +     * now so we can be lazier later.
> +     */
> +    if (strlen(riscv_cpu) < 5) {
> +        error_report("'%s' does not appear to be a valid RISC-V ISA string",
> +                     riscv_cpu);
> +        exit(1);
> +    }
> +
> +    if (riscv_cpu[0] == 'r' && riscv_cpu[1] == 'v') {
> +        /* Starts with "rv" */
> +        if (riscv_cpu[2] == '3' && riscv_cpu[3] == '2') {
> +            valid = true;
> +            rvxlen = RV32;
> +        }
> +        if (riscv_cpu[2] == '6' && riscv_cpu[3] == '4') {
> +            valid = true;
> +            rvxlen = RV64;
> +        }
> +    }
> +
> +    if (!valid) {
> +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> +                     riscv_cpu);
> +        exit(1);
> +    }
> +
> +    for (i = 4; i < strlen(riscv_cpu); i++) {
> +        switch (riscv_cpu[i]) {
> +        case 'i':
> +            if (target_misa & RVE) {
> +                error_report("I and E extensions are incompatible");
> +                exit(1);
> +            }
> +            target_misa |= RVI;
> +            continue;
> +        case 'e':
> +            if (target_misa & RVI) {
> +                error_report("I and E extensions are incompatible");
> +                exit(1);
> +            }
> +            target_misa |= RVE;
> +            continue;
> +        case 'g':
> +            target_misa |= RVI | RVM | RVA | RVF | RVD;
> +            continue;
> +        case 'm':
> +            target_misa |= RVM;
> +            continue;
> +        case 'a':
> +            target_misa |= RVA;
> +            continue;
> +        case 'f':
> +            target_misa |= RVF;
> +            continue;
> +        case 'd':
> +            target_misa |= RVD;
> +            continue;
> +        case 'c':
> +            target_misa |= RVC;
> +            continue;
> +        case 's':
> +            target_misa |= RVS;
> +            continue;
> +        case 'u':
> +            target_misa |= RVU;
> +            continue;
> +        default:
> +            warn_report("QEMU does not support the %c extension",
> +                        riscv_cpu[i]);
> +            continue;
> +        }
> +    }
> +
> +    set_misa(env, rvxlen | target_misa);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_MMU);
> +    set_feature(env, RISCV_FEATURE_PMP);
> +}

This whole approach feels undesirable to me, as it is quite different to
way CPUs are represented in the other architectures in QEMU and as a result
does not fit in the QAPI commands we've been building in QEMU for dealing
with CPU model representation. This will make for increased maint burden
in both QEMU and apps managing QEMU

IIUC, this code is taking an arbitrary CPU model string and looking
at individual characters in that string & turning on individual features
according to what characters it sees. There's several problems with this

 - There's no way to enumerate valid CPU model names

 - There can be many different names that all result
   in the same CPU model. eg "fdcs", "scdf", a"ffddccss"
   all result in the same features getting enabled
   by this loop above.

 - There's no way to check compatibility between CPUs

 - There will be no way to version the CPUs if we need
   to tie them to machine types for back compatibility.

If we have a base CPU model, with a bunch of features that can optionally
be enabled, then IMHO we should represent that the same way was we do
on x86, whre we have a CPU model name, and then a comma sepaprated list
of features.

If on the other hand we don't want to support the combinatorial matrix
of all possible feature flags, then we should just list all the expected
named CPU models that are required explicitly.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

