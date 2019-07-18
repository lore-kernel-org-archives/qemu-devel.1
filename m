Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21134C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D040420659
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 02:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJB1g6D6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D040420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnw79-0003xg-4E
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 22:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnw6x-0003Us-Bl
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnw6v-0004fk-AJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 22:25:35 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnw6t-0004e9-Bb; Wed, 17 Jul 2019 22:25:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id g2so11829661pfq.0;
 Wed, 17 Jul 2019 19:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=jpRLIB5bbcxlc12lCFKBhRwuCEYasQr0dYctopZI8zk=;
 b=QJB1g6D6u38IvHWE25IC4NwUgxlsI2iX6eBUfgy44EquGeEm9XyWBfTuqzwxg6T2hN
 Z4aGOlDh5xk5LgMTa1Hj5dLjZKaZpvxZK6nITXeG0EFCWOp1ofgDhKgtNlN8QDwSCQCm
 vlC0li5l/FAtEhMfQIlwBPkhD79COJj5jVSZr8iitJIeSGEva4fUTXkMUEkjNdPB89l5
 klXJCtdurKoMPFqt5A19pKoX4icTivWxhHZcB0Of63AkEQ7RGKok5Qv4Xz/5fqoKxs5/
 WH+isLD370FoUqdbSQ2itgrR3kQszA4SZCBM33FjuP03QZ1WixmTRq3eybV6M0pZM31s
 YsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=jpRLIB5bbcxlc12lCFKBhRwuCEYasQr0dYctopZI8zk=;
 b=cfqZaIs7jfjrlNFQSA00/8/kz53IL0bhrlO/z9q72oGMh6fInqICCabMw1kxV9GfIC
 EGvhEuTG1X2R8tIaVGIefocxK+lYhzsxBqpAn8yTXtHnJ/q4bP9OHljKybrdDFTynI/p
 eFg4+FZmP/fyQgoOKuAMR/8mJVqkaihnBQxGu6fVS8PW6diGwBo5M4FA0TCGNpBqXfuQ
 UVbBxi/WieihAkZdh8RiUZDF/xy1GEwAaL7X5PNpvbvjYawj74oERYS7H3f2wILCf0w3
 8exYTujG23CsnYL21/lD2jGMIVg6gvTaU2EMW0eIBcPuwUbj13jL/KI2uloPW5Iulpug
 tGnw==
X-Gm-Message-State: APjAAAXMvaTX3+pqWiqatzxcq9mHWnvIf6JA/gySoaXxh+R5BkOPV1WI
 OISoyXdDCf26P6bMVdybfH8=
X-Google-Smtp-Source: APXvYqyxlwUT/FbslywFMbiKGTBleanwUSgfsvdVTcHMvDnHfmkHp0FA2JN/aYwCsAhJLgGc2mfm1g==
X-Received: by 2002:a63:d555:: with SMTP id v21mr23296134pgi.179.1563416730135; 
 Wed, 17 Jul 2019 19:25:30 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id 4sm30414416pfc.92.2019.07.17.19.25.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 19:25:29 -0700 (PDT)
Date: Thu, 18 Jul 2019 12:25:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kurz <groug@kaod.org>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-5-npiggin@gmail.com>
 <20190717193027.0fce5b06@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190717193027.0fce5b06@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563416658.j7i8htfx03.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v5 4/4] spapr: Implement H_JOIN
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz's on July 18, 2019 3:30 am:
> On Wed, 17 Jul 2019 15:39:52 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>> This has been useful to modify and test the Linux pseries suspend
>> code but it requires modification to the guest to call it (due to
>> being gated by other unimplemented features). It is not otherwise
>> used by Linux yet, but work is slowly progressing there.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> Changes since v4:
>> - Style
>>=20
>>  hw/ppc/spapr.c       |  1 +
>>  hw/ppc/spapr_hcall.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 13c423347e..59cd24f9c3 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1066,6 +1066,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr=
, void *fdt)
>>      add_str(hypertas, "hcall-tce");
>>      add_str(hypertas, "hcall-vio");
>>      add_str(hypertas, "hcall-splpar");
>> +    add_str(hypertas, "hcall-join");
>>      add_str(hypertas, "hcall-bulk");
>>      add_str(hypertas, "hcall-set-mode");
>>      add_str(hypertas, "hcall-sprg0");
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 5e655172b2..57c1ee0fe1 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1069,6 +1069,48 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>>      return H_SUCCESS;
>>  }
>> =20
>> +static target_ulong h_join(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +    CPUState *cs;
>> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>> +    bool last_unjoined =3D true;
>> +
>> +    if (env->msr & (1ULL << MSR_EE)) {
>> +        return H_BAD_MODE;
>> +    }
>> +
>> +    if (spapr_cpu->prod) {
>> +        spapr_cpu->prod =3D false;
>> +        return H_SUCCESS;
>> +    }
>> +
>=20
> PAPR says that H_JOIN "performs the equivalent of a H_CONFER (proc=3Dself=
)",
> unless called by the last unjoined thread, in which case H_CONTINUE
> should be returned. It thus seems that the spapr_cpu->prod check should
> be done after the loop below otherwise if the last active thread was
> just prodded (can happen?), it won't return the expected value, and...

Good lawyering, I would say you are right.

>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *c =3D POWERPC_CPU(cs);
>> +        CPUPPCState *e =3D &c->env;
>> +        if (c =3D=3D cpu) {
>> +            continue;
>> +        }
>> +
>> +        /* Don't have a way to indicate joined, so use halted && MSR[EE=
]=3D0 */
>> +        if (!cs->halted || (e->msr & (1ULL << MSR_EE))) {
>> +            last_unjoined =3D false;
>> +            break;
>> +        }
>> +    }
>> +    if (last_unjoined) {
>> +        return H_CONTINUE;
>> +    }
>> +
>> +    cs =3D CPU(cpu);
>> +    cs->halted =3D 1;
>> +    cs->exception_index =3D EXCP_HALTED;
>> +    cs->exit_request =3D 1;
>> +
>> +    return H_SUCCESS;
>=20
> ... then, you can maybe factor out this code to an h_confer_self()
> helper to be called by h_join() and h_confer() ?

I'll take a look.

Thanks,
Nick
=

