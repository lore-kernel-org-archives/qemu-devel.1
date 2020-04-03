Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8675BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F34A2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 13:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+snF9FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F34A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKM8v-0007VS-HU
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 09:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jKM80-0006sa-Oh
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jKM7z-0001BJ-1u
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 09:12:56 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jKM7w-00010p-EF; Fri, 03 Apr 2020 09:12:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id 22so3444656pfa.9;
 Fri, 03 Apr 2020 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=dUXqULEwWnQ5kJLds2Ke+YiiqXZE3O4cLsDuyGKIOqs=;
 b=U+snF9FPGkDkhANqtLkD8bzXiGm1cIEx4W198D82lWh3VblAWcUrhSnmhnUFrYAcV6
 GWrMIPxUMLpKyY7AH0L0HtFUET+OmnWvve9Oikf9pdHGToc0LiOCq/MSpECcHSm1NIqn
 utUmtxQiOJ4RuYmZAH2Nd3jNdWKUotGn9OwaXAblYCeFd8EhKczAKpDMwnn0Cve865EJ
 z9MFLPPiCbxj+NRg6nKtQ/m2Y7p8noTH1pSeRwPSIfwKgqEGHT7wk05X/6nPw+wNiyoF
 OLd54oq/WdGkH8dsrG1w0+1L9JWUxVFY9VRyi1+5jFafgsfdX2h2v88BLK5AraV1cQhQ
 HxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=dUXqULEwWnQ5kJLds2Ke+YiiqXZE3O4cLsDuyGKIOqs=;
 b=eDQ4NgmvZlBZo0ovPVKKKgIzqb7tfp2XvTkSj4yOdxVGuxEWEpaXkULWeHLCCBXEwh
 P2wc442EW8ua9/DkoorPqVtBRMXLBkJNurN8nFZmRxppVrLYSyOvyODy0nfbduXFsgOM
 qSkI1dL7Or/Ax+mSp3dZtX8kN9ISayG+UG/jHWNFsQMLCwTGus9qJk3q8+d6yw45e7lC
 faBg8rt/D0mN5+kW52EpMIAR8MrsnOEFADNZcLLBvFR+VfeKPPIdorl9vUSWo0s9dlt1
 9h0bZC8NqF11SndXX7xmwWyaWNALCEy5MKWfI6R4vVBxeg9dZEhqembdz4cbjAPk2ejp
 7qBw==
X-Gm-Message-State: AGi0PuaKY7RUbVFy3G64c2wzrGYhFgAHUGU1stpbxj01Fwq830iMujrx
 ywcuR82DQfVdTIysFKuoTNE=
X-Google-Smtp-Source: APiQypLLSM4penPCT48jUs/qzbdf40wsrk5FPZi2rBAqQqAs6CccFSdkCNjveVo59c7fBPDnx29vwA==
X-Received: by 2002:a63:784f:: with SMTP id t76mr8586063pgc.204.1585919571145; 
 Fri, 03 Apr 2020 06:12:51 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id w205sm5788322pfc.75.2020.04.03.06.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 06:12:50 -0700 (PDT)
Date: Fri, 03 Apr 2020 23:12:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
 <c1cdf2a2-afe9-8771-2c00-7e6a79d5e532@kaod.org>
 <1585899319.9tofsl4fd9.astroid@bobo.none>
In-Reply-To: <1585899319.9tofsl4fd9.astroid@bobo.none>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585915002.kqdz9mya1i.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nicholas Piggin's on April 3, 2020 5:57 pm:
> C=C3=A9dric Le Goater's on March 26, 2020 2:38 am:
>> [ Please use clg@kaod.org ! ]
>>=20
>> On 3/25/20 3:41 PM, Nicholas Piggin wrote:
>>> This implements the NMI interface for the PNV machine, similarly to
>>> commit 3431648272d ("spapr: Add support for new NMI interface") for
>>> SPAPR.
>>>=20
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>=20
>> one minor comment,
>>=20
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>=20
>>> ---
>>>  hw/ppc/pnv.c | 30 +++++++++++++++++++++++++++++-
>>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index b75ad06390..671535ebe6 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -27,6 +27,7 @@
>>>  #include "sysemu/runstate.h"
>>>  #include "sysemu/cpus.h"
>>>  #include "sysemu/device_tree.h"
>>> +#include "sysemu/hw_accel.h"
>>>  #include "target/ppc/cpu.h"
>>>  #include "qemu/log.h"
>>>  #include "hw/ppc/fdt.h"
>>> @@ -34,6 +35,7 @@
>>>  #include "hw/ppc/pnv.h"
>>>  #include "hw/ppc/pnv_core.h"
>>>  #include "hw/loader.h"
>>> +#include "hw/nmi.h"
>>>  #include "exec/address-spaces.h"
>>>  #include "qapi/visitor.h"
>>>  #include "monitor/monitor.h"
>>> @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, boo=
l value, Error **errp)
>>>      }
>>>  }
>>>=20
>>> +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>>> +{
>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>>> +    CPUPPCState *env =3D &cpu->env;
>>> +
>>> +    cpu_synchronize_state(cs);
>>> +    ppc_cpu_do_system_reset(cs);
>>> +    /*
>>> +     * SRR1[42:45] is set to 0100 which the ISA defines as implementat=
ion
>>=20
>> I see 'System Reset' in ISA 3.0
>>> +     * dependent. POWER processors use this for xscom triggered interr=
upts,
>>> +     * which come from the BMC or NMI IPIs.
>>> +     */
>>> +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
>>=20
>> So we could have used the skiboot SPR_SRR1_PM_WAKE_SRESET define ?=20
>=20
> Ah, that's only for power-saving wakeup. But you got me to dig further
> and I think I've got a few things wrong here.
>=20
> The architectural power save wakeup due to sreset bit 43 needs to be
> set, probably in excp_helper.c if (msr_pow) test.
>=20
>     case POWERPC_EXCP_RESET:     /* System reset exception               =
    */
>         /* A power-saving exception sets ME, otherwise it is unchanged */
>         if (msr_pow) {
>             /* indicate that we resumed from power save mode */
>             msr |=3D 0x10000;
>             new_msr |=3D ((target_ulong)1 << MSR_ME);
>         }

Sorry I'm wrong, that's the old MSR_POW thing I guess G5 had it.

'stop' state wakeup is powerpc_reset_wakeup of course, which seems to
do the right thing with SRR1.

Something like this patch should fix this issue in the ppc-5.1 branch.
This appears to do the right thing with SRR1 in testing with Linux.

---
 hw/ppc/pnv.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ac83b8698b..596ccfd99e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1964,12 +1964,21 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run=
_on_cpu_data arg)
=20
     cpu_synchronize_state(cs);
     ppc_cpu_do_system_reset(cs);
-    /*
-     * SRR1[42:45] is set to 0100 which the ISA defines as implementation
-     * dependent. POWER processors use this for xscom triggered interrupts=
,
-     * which come from the BMC or NMI IPIs.
-     */
-    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
+    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
+        /* system reset caused wake from power saving state */
+        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
+            warn_report("ppc_cpu_do_system_reset does not set system reset=
 wakeup reason");
+            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
+        }
+    } else {
+        /*
+	 * For non-powersave wakeup system resets, SRR1[42:45] are defined to
+	 * be implementation dependent. Set to 0b0010, which POWER9 UM defines
+	 * to be interrupt caused by SCOM, which can come from the BMC or NMI
+	 * IPIs.
+         */
+        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
+    }
 }
=20
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
--=20
2.23.0

=

