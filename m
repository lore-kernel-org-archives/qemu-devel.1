Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928AAC83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614B5206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqOmYo2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614B5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSdN-0006ta-IK
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTSZM-0001vn-2G
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTSZD-0001gX-7w
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jTSZC-0001fd-Hg
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id j4so33494206otr.11
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=flpQKJYfY4iUD2dDeTZMCKPErH9CMN9MNsuZ9OMb6ic=;
 b=UqOmYo2+0RAeM7+neaQXKlhMZE1vovZbhjhE5GIxwZdy0ypYSbUydQTfnwe/B2ipPT
 Y3k/+oSGW0KFZUh/Wdo96lTNtiB2K8030d9Pr3XTePDYJaxm3IFk7aBQq5ZR801U+OPL
 uM0ai3yz1TzI292GjmWDWA575ZCd2PT45dQqN59N+YV5dKsdN2//+5R6ltrwX5dq0ApK
 MtxVIt2ncYQFb3+LP/RmTIEaSAzOl7HnwAG70x+pIHrELZKL1lg1rQO6GVyLmIzozb1O
 +PeI3bVhLGkNbHrvNZbiGI/BOcOjcULP3mfBN88Kckaps487adUGzIqmeOBXKZV8z+C4
 pEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=flpQKJYfY4iUD2dDeTZMCKPErH9CMN9MNsuZ9OMb6ic=;
 b=kXHxf5VNVdv5Gwo10OrQVEDMvJ9VTnHPeG/JkOnf70xV4D3yC3NKpBmJaHFq5GCtyJ
 mKFNv8eeWEHPROOZS88vv1v7eRq/xtIdplc6SfYdYoDb9JZLepaJKwiRwIMuevaiNzDL
 1vNwVhIOvK7/qEuclIrlQOzT9uSWbTkDowAEvapRa1VxZhEQDeq13Fdu6vfkU1LgOAgc
 BkLby37C6LqfRXOjJh7tmFJ23DczzAzOQ4W+lXEbBqZhXcu7lfeKlQs5wu+cNrovSUxu
 xbxtxqdclOTknaPSgdUNU1AIYtaYoh2a0KC7yY6x9bJkvtoglQrUsjJthFlUAuXySwbA
 3owA==
X-Gm-Message-State: AGi0PuY3LFbgiijIDUxJxHAVu35zG/k/BjBlsmRYju6MP/IHfFUa2jYp
 tfbBugwmphhP1L43sdvUAdSbuJLf5zjhV0JDqQK0yA==
X-Google-Smtp-Source: APiQypLe6n1BK0pmwz2Td5azVaKGPMka80l1d5nA8SC4/+/xmQJ33i5aVmIeuzLC5Ty7BLQN66evUXvt5L32/UafTUA=
X-Received: by 2002:aca:c751:: with SMTP id x78mr3447296oif.163.1588089276802; 
 Tue, 28 Apr 2020 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200428155005.25537-1-f4bug@amsat.org>
In-Reply-To: <20200428155005.25537-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2020 16:54:25 +0100
Message-ID: <CAFEAcA_WPpXTLpfHuqoZcy2yeNmiOwtMwwQDZsUT-XdbqzhPpQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Use correct variable for setting 'max'
 cpu's MIDR_EL1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 at 16:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:

Looks like you forgot to edit the commit message subject line.

> MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.
>
> This fixes when compiling with -Werror=3Dconversion:
>
>   target/arm/cpu64.c: In function =E2=80=98aarch64_max_initfn=E2=80=99:
>   target/arm/cpu64.c:628:21: error: conversion from =E2=80=98uint64_t=E2=
=80=99 {aka =E2=80=98long unsigned int=E2=80=99} to =E2=80=98uint32_t=E2=80=
=99 {aka =E2=80=98unsigned int=E2=80=99} may change value [-Werror=3Dconver=
sion]
>     628 |         cpu->midr =3D t;
>         |                     ^
>
> Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I suppose cp15.c0_cpuid register in target/arm/cpu.h as uint32_t is OK.

Yes, that's a 32-bit aarch32 system register.

>
> Since v1: Follow Laurent and Peter suggestion.
> ---
>  target/arm/cpu.h | 3 ++-
>  target/arm/cpu.c | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8b9f2961ba..4d1be56df9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -894,7 +894,7 @@ struct ARMCPU {
>          uint64_t id_aa64dfr0;
>          uint64_t id_aa64dfr1;
>      } isar;
> -    uint32_t midr;
> +    uint64_t midr;
>      uint32_t revidr;
>      uint32_t reset_fpsid;
>      uint32_t ctr;
> @@ -1685,6 +1685,7 @@ FIELD(MIDR_EL1, PARTNUM, 4, 12)
>  FIELD(MIDR_EL1, ARCHITECTURE, 16, 4)
>  FIELD(MIDR_EL1, VARIANT, 20, 4)
>  FIELD(MIDR_EL1, IMPLEMENTER, 24, 8)
> +FIELD(MIDR_EL1, RESERVED, 32, 32)
>
>  FIELD(ID_ISAR0, SWAP, 0, 4)
>  FIELD(ID_ISAR0, BITCOUNT, 4, 4)
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index a79f233b17..aaa48e06ac 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1182,6 +1182,8 @@ void arm_cpu_post_init(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
>
> +    assert(FIELD_EX64(cpu->midr, MIDR_EL1, RESERVED) =3D=3D 0);

I wouldn't bother with the assert; we don't generally do that
kind of check on ID register values.

> +
>      /* M profile implies PMSA. We have to do this here rather than
>       * in realize with the other feature-implication checks because
>       * we look at the PMSA bit to see if we should add some properties.
> @@ -2757,7 +2759,7 @@ static const ARMCPUInfo arm_cpus[] =3D {
>  static Property arm_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, fal=
se),
>      DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
> -    DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
> +    DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID=
),
> --
> 2.21.1

Otherwise looks good.

-- PMM

