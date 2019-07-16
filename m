Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5006C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1ED120880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKLuT42T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ED120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKeb-0007Pa-0X
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnKeQ-00070I-C8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnKeP-0000pB-86
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:25:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnKeO-0000oK-RI; Tue, 16 Jul 2019 06:25:37 -0400
Received: by mail-pf1-x444.google.com with SMTP id f17so4909604pfn.6;
 Tue, 16 Jul 2019 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=Tc6Idvwui/7wmFfw9jkBeUnqWHmPxtueUDA7u++3TPE=;
 b=TKLuT42ToE72u2uDb3MnjqpqBaXQn+MSbxpj6YobeYi/2OfCxEQMvvE874Lc5TrTbA
 +wgXcb6WfVZ4y4HXbnHqG0m+Yf1YcoQ/56M0ly4a9+Iy0QjY5ro+8aQCHyRlmGzE5/Lx
 OIcBFyWzxEtJNl2nHewhAho+/eun3UALNXnfv0jguOzMUc2DuOEahvnRvDND+DrNFtwm
 E4xt/6zAe9NHc1yUTZO9xVe2PtOUCsrl5sKDhEqVjf8H/O8pWlESNR+3RJ7jf9rFy6l+
 n/q1XyrfB2/l7WOF4xmDdXRCNVMGDXl3NpMOrHZfa66gjxmxcNsH5MOXI7VlJyPDqvDA
 PkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=Tc6Idvwui/7wmFfw9jkBeUnqWHmPxtueUDA7u++3TPE=;
 b=Vry07ev1AM8QhB9J8It8Wgn/8Qo7Pwkkql/i8MGn1Wbxq/xhGfkNmNyKGkFFvhNCmy
 5h5vmZ87zljwFZX8f2Bqyw9b8d4/KA7QACVLBQsq1qlNkCIuCtYGklBfjglSnzL/rRhd
 tR5pJw/jJLc6hWYIjrtKSEn2/8dbjtQVaqu4EiCLmLzr6zdAki/qXVsTbTqWFx1PfRUo
 GInhsRrRdmyjYJte6YO5Rx3Hd5JWtVlx9/0rj3OacnXfamW0hPX1rOPdkOPh90ZzwSfp
 abcckvPqWcmTv4dBbpKhmLhw5ZOzgQmGjkNXp0B/lvqQI/8T+Ptr6vAvG+Ev2nt68Obe
 Q0Pw==
X-Gm-Message-State: APjAAAUM1eRYF0u0HQneakoBGfbTh34rKw4/yp0Fe8EgnVIYfcHZfly2
 qos060anSvNfeuzf3CTQ+7Q=
X-Google-Smtp-Source: APXvYqw0iil28kMsDC/bFh+qrvmsb/AFq66UrgWoVUYR9J7DwUu0vEtllt5VLukX905QsKjTVwQjgg==
X-Received: by 2002:a63:1310:: with SMTP id i16mr32092228pgl.187.1563272735437; 
 Tue, 16 Jul 2019 03:25:35 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id s20sm22702272pfe.169.2019.07.16.03.25.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 03:25:34 -0700 (PDT)
Date: Tue, 16 Jul 2019 20:25:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-4-npiggin@gmail.com>
 <20190716082549.GE7525@umbus.fritz.box>
In-Reply-To: <20190716082549.GE7525@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563270152.eyfvtns0jc.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v4 3/5] spapr: Implement H_CONFER
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
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson's on July 16, 2019 6:25 pm:
> On Tue, Jul 16, 2019 at 12:47:24PM +1000, Nicholas Piggin wrote:
>> This does not do directed yielding and is not quite as strict as PAPR
>> specifies in terms of precise dispatch behaviour. This generally will
>> mean suboptimal performance, rather than guest misbehaviour. Linux
>> does not rely on exact dispatch behaviour.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  hw/ppc/spapr_hcall.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>=20
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 8b208ab259..28d58113be 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1069,6 +1069,53 @@ static target_ulong h_cede(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
>>      return H_SUCCESS;
>>  }
>> =20
>> +static target_ulong h_confer(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> +                           target_ulong opcode, target_ulong *args)
>> +{
>> +    target_long target =3D args[0];
>> +    uint32_t dispatch =3D args[1];
>> +    PowerPCCPU *target_cpu =3D spapr_find_cpu(target);
>> +    CPUState *target_cs =3D CPU(target_cpu);
>> +    CPUState *cs =3D CPU(cpu);
>> +    SpaprCpuState *spapr_cpu;
>> +
>> +    /*
>> +     * This does not do a targeted yield or confer, but check the param=
eter
>> +     * anyway. -1 means confer to all/any other CPUs.
>> +     */
>> +    if (target !=3D -1 && !target_cs) {
>> +        return H_PARAMETER;
>> +    }
>=20
> Should we return an error if a targeted yield is attempted, rather
> than pretend we've done it?

I don't think so, because we do _some_ kind of yield for the directed
case which is probably better than nothing, and Linux won't fall back.

PAPR is much more strict about dispatching. The H_CONFERing vCPU must=20
not run until the target(s) has been dispatched (if runnable), for
example. So we don't really implement it to the letter, we just do
"some kind of yield, whatever generic tcg code has implemented".

For single threaded tcg it seems a signifcant complication to the
round robin algorithm to add a directed yield, yet simply yielding
to the next vCPU is a good idea here because useful work will get
done including by the lock holder before we run again.

If multi threaded tcg performance with lot of vCPUs and lock contention
starts becoming more important I guess directed yielding might be
something to look at.

Thanks,
Nick
=

