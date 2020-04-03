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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E41C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFA22073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0dc2Gn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFA22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHDH-0006Ay-A8
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jKHCb-0005TF-Em
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jKHCa-0008Pz-9Q
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:57:21 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jKHCX-0008Jw-9O; Fri, 03 Apr 2020 03:57:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id h11so2402873plk.7;
 Fri, 03 Apr 2020 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=sJuTAetJ5zqJTB5f1vOGq93xXDPF3SUA9mBpuG8J+/c=;
 b=E0dc2Gn3mukmvdwkAJab41wh3eahm7z8YeXf4fl2nnBUbYpGB+J1HgsYEVuBGiGkhQ
 1Ov53Dul9/XM61Tfi19QLzsrkWTMCmbXMc6RINJhlcDeszZvb4ENUnrxD09d9K0myzy/
 L5wD6m3+v/jxzAtR8jTyOIhQaMUdJ2NFTR3OFBQF7A0dZDvTBTGHLlhwAMgFqua1C9Fd
 sCjeyCAAu3MvoYBjy99/1tsjGU/bTivI88A+EdEdgjNInsXosf84huFKeaneFLNymvph
 C+Y4Fwf7jZGjG4RIPfSd6Vn51clo00FYOHzO2igpbfaa0ms/SkgwWqpMFdUfd6DQA/dy
 oM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=sJuTAetJ5zqJTB5f1vOGq93xXDPF3SUA9mBpuG8J+/c=;
 b=GrA7hiFJ26Tkh9F2Q/2NUnEcqo9j71husJlWdKUKXNN4f7oYHnbg0TpjUzTzlDXzBk
 2snLNSLCQ9ZtGGon2506yx1lLeHN5iw/GbVRhRmBNefDrH2nqW6EvhKkoUXObBCUrgLr
 chO04W+09oXJkXkhVRRZTJulQqNaR29PU4oe6Bo0JQjYOYUAPfGam2rE3/QycFqbmLRN
 fzt4Ti8j8LzA9rCJLrRyJJgIHaKhnvkWUOQbjpmeXPjWLATXWmR26sdQ3Zzrar9tanZO
 GEPxJJFBmoDf9DlfpobywOyOy96Oiczj6i2XRcVbJVmqgo+0pl+tQsci+gSaFydEKkZr
 ZC4w==
X-Gm-Message-State: AGi0Pub+JFb+NcqmlYuhacQdQpScsFrOia29eEkgTuvY4iaAenfJHFWJ
 uDtX+Fd8PrYHVFFGpdB3rVU=
X-Google-Smtp-Source: APiQypJx+Hx/Y42yN7+K1vBGFTQLgAzVTytzdmvEIpDxMn1HbrhCC77yrd/6xf5QTvdWexPSgvK2yA==
X-Received: by 2002:a17:902:720a:: with SMTP id
 ba10mr7090528plb.323.1585900635861; 
 Fri, 03 Apr 2020 00:57:15 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id 63sm5275949pfx.132.2020.04.03.00.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 00:57:15 -0700 (PDT)
Date: Fri, 03 Apr 2020 17:57:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] ppc/pnv: Add support for NMI interface
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-3-npiggin@gmail.com>
 <c1cdf2a2-afe9-8771-2c00-7e6a79d5e532@kaod.org>
In-Reply-To: <c1cdf2a2-afe9-8771-2c00-7e6a79d5e532@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585899319.9tofsl4fd9.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

C=C3=A9dric Le Goater's on March 26, 2020 2:38 am:
> [ Please use clg@kaod.org ! ]
>=20
> On 3/25/20 3:41 PM, Nicholas Piggin wrote:
>> This implements the NMI interface for the PNV machine, similarly to
>> commit 3431648272d ("spapr: Add support for new NMI interface") for
>> SPAPR.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> one minor comment,
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
>> ---
>>  hw/ppc/pnv.c | 30 +++++++++++++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index b75ad06390..671535ebe6 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -27,6 +27,7 @@
>>  #include "sysemu/runstate.h"
>>  #include "sysemu/cpus.h"
>>  #include "sysemu/device_tree.h"
>> +#include "sysemu/hw_accel.h"
>>  #include "target/ppc/cpu.h"
>>  #include "qemu/log.h"
>>  #include "hw/ppc/fdt.h"
>> @@ -34,6 +35,7 @@
>>  #include "hw/ppc/pnv.h"
>>  #include "hw/ppc/pnv_core.h"
>>  #include "hw/loader.h"
>> +#include "hw/nmi.h"
>>  #include "exec/address-spaces.h"
>>  #include "qapi/visitor.h"
>>  #include "monitor/monitor.h"
>> @@ -1955,10 +1957,35 @@ static void pnv_machine_set_hb(Object *obj, bool=
 value, Error **errp)
>>      }
>>  }
>>=20
>> +static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>> +{
>> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    cpu_synchronize_state(cs);
>> +    ppc_cpu_do_system_reset(cs);
>> +    /*
>> +     * SRR1[42:45] is set to 0100 which the ISA defines as implementati=
on
>=20
> I see 'System Reset' in ISA 3.0
>> +     * dependent. POWER processors use this for xscom triggered interru=
pts,
>> +     * which come from the BMC or NMI IPIs.
>> +     */
>> +    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
>=20
> So we could have used the skiboot SPR_SRR1_PM_WAKE_SRESET define ?=20

Ah, that's only for power-saving wakeup. But you got me to dig further
and I think I've got a few things wrong here.

The architectural power save wakeup due to sreset bit 43 needs to be
set, probably in excp_helper.c if (msr_pow) test.

    case POWERPC_EXCP_RESET:     /* System reset exception                 =
  */
        /* A power-saving exception sets ME, otherwise it is unchanged */
        if (msr_pow) {
            /* indicate that we resumed from power save mode */
            msr |=3D 0x10000;
            new_msr |=3D ((target_ulong)1 << MSR_ME);
        }

For non-power save wakeup, it's all implementation defined. POWER9 UM=20
has the table, but I got the damn bit wrong, I was probably looking in
the ISA table by mistake. It's bit 44 for that case. Linux doesn't tend=20
to care about that case, but it does care about the power save wakeup
case, so this patch seems to generally "work", but I'll have to fix it.

Thanks,
Nick
=

