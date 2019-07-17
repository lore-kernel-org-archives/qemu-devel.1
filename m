Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE10AC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EC221743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNJwWicR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EC221743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnhld-0006ht-PI
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnhlR-0006Ce-Qh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnhlQ-0005zB-Ss
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:06:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnhlQ-0005yA-NJ; Wed, 17 Jul 2019 07:06:24 -0400
Received: by mail-pl1-x643.google.com with SMTP id w24so11793164plp.2;
 Wed, 17 Jul 2019 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=o0Xh8kZHauQoOYIufF9WWsu7sLPA6sIblOAB2jivTHw=;
 b=RNJwWicRzGUbIzLyu5lBZeLEgddMsnh0XeoK7jUQItsNprHZEnSNjUVTZJLykxBU0r
 5nZSwDeTvUul/jLDOZ5XL6cjJh8FOSADfFPRTVRX5g+7VHvFYU5kQrb0LAyyXZoR5/rA
 ECg71YzyJ4Y+xJHyhl4e+DoKWffjd/M4XR/H/MqBzXugXth1g0rd3D8yHpcvL+zNsCup
 KY0OJ9FFPMHvLpi7ZRbDlAvgHuPDcxi1gktuOVuJ+qAMPk+xttb+wHWTC+huDowcH40C
 ris0QvAYX5Ad1YkkUp/1v1RbvumQhGq/T5CcVm1SlQJuJdEmw0fvZQwjMtnGI7o3gBU1
 YFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=o0Xh8kZHauQoOYIufF9WWsu7sLPA6sIblOAB2jivTHw=;
 b=rHRNrRBRArFv4HeFjuCx8NwRkLroX68UBcIWlnBZM6CRsXMF+5WC6ouW4m4nApmmYU
 r4tYIraIojnhWswlsqjIP/A2K5sqnZOX/rNWU1hECfiDQlNCiiRbIyOfePpI0ps8cGtR
 QU9r1UvwkxVP8W1FtAJG+TGeoVFKzV3s0zbxqOPG8YCh2ufHQ/rhwy82itK3a9ezlKCc
 +nlvcdipaPKQgJ1zPkUJCnvwzsgourZHMvVp0Tjvyc3Wbt6u78s2Mbzir70xbY+Q/xUc
 jA078Y6Z2Bb1Y3H4gor3s5G2EIX3BvpqvnIz59ZRgyJ0B6Hh/Ao38x8sWPvCfVhUtueU
 1R5Q==
X-Gm-Message-State: APjAAAVDfOd1ofjWvM3xa5PuaWQ6Z/ViR2pOXkm/1dHbw5xR5LEoxnfG
 U8bmLMYYpSFXi9kix6TEKI0=
X-Google-Smtp-Source: APXvYqwAEBZ5fYr0lEhhGox6U3AVmb0bCoYeRNipBn8EriVpsCSgJX1qCJ9edQgHQGA26F+CFMxy2A==
X-Received: by 2002:a17:902:2868:: with SMTP id
 e95mr39686997plb.319.1563361583094; 
 Wed, 17 Jul 2019 04:06:23 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id l1sm32781018pfl.9.2019.07.17.04.06.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 04:06:22 -0700 (PDT)
Date: Wed, 17 Jul 2019 21:06:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>
References: <20190717053952.13729-1-npiggin@gmail.com>
 <20190717053952.13729-3-npiggin@gmail.com>
 <dcb80cc9-b282-dd27-5e09-1f96751be689@kaod.org>
In-Reply-To: <dcb80cc9-b282-dd27-5e09-1f96751be689@kaod.org>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563361544.3f08c6nyb2.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v5 2/4] spapr: Implement H_PROD
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

C=C3=A9dric Le Goater's on July 17, 2019 8:16 pm:
> On 17/07/2019 07:39, Nicholas Piggin wrote:
>> H_PROD is added, and H_CEDE is modified to test the prod bit
>> according to PAPR.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr_hcall.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index e615881ac4..8b208ab259 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1050,14 +1050,41 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spap=
rMachineState *spapr,
>>  {
>>      CPUPPCState *env =3D &cpu->env;
>>      CPUState *cs =3D CPU(cpu);
>> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>> =20
>>      env->msr |=3D (1ULL << MSR_EE);
>>      hreg_compute_hflags(env);
>> +
>> +    if (spapr_cpu->prod) {
>> +        spapr_cpu->prod =3D false;
>> +        return H_SUCCESS;
>> +    }
>> +
>>      if (!cpu_has_work(cs)) {
>>          cs->halted =3D 1;
>>          cs->exception_index =3D EXCP_HLT;
>>          cs->exit_request =3D 1;
>>      }
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +static target_ulong h_prod(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    target_long target =3D args[0];
>> +    CPUState *cs;
>> +    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
>=20
> shouldn't we grab the SpaprCpuState of 'target' instead ? =20

Yes we should, good catch.

Thanks,
Nick
=

