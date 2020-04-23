Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F9C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE02D2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8bmsmsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE02D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRa3N-0006em-K3
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jRa2W-00067w-6x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jRa2V-0004io-P9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:29:08 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jRa2U-0004fj-9Z; Thu, 23 Apr 2020 07:29:06 -0400
Received: by mail-il1-x143.google.com with SMTP id e8so5167931ilm.7;
 Thu, 23 Apr 2020 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=thB3w1ixla7DrH8KN7vrIT+t8tEKP02uV4Dq0E7b1Os=;
 b=s8bmsmsFWa0OElWpyFiyIzggeOz1/LYfWHhSVv/ggdsa0p6hvJgoPQZpomLUTBu9gw
 bB5NSJxIkXWbQqtcUg01YBrLtr+e/7/jNOGH0QF/e4HrAKquvIluxr0aMmjqNeJiNRtz
 hP/vabaUK5WVflm0jocSZXcpgeXJofesXyIn0AqDDZGj++PtFR3IzLjy8laeXVRIyNQj
 L743MDMIYfektkMIY7TB4XnJ6/M9lnU1nyAM7tRURdtYk/kKS6qLi+feeTfv/mgtbv05
 RUgh6KwsMeZj3h9rV1QkqmVI+N/onUbvuy+7cXsQLwyq6uKCvy/RRAOLCHp3XOhtMAmt
 Vk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=thB3w1ixla7DrH8KN7vrIT+t8tEKP02uV4Dq0E7b1Os=;
 b=ok1SIHx0UwTJQGa046LkYE0UDgQ/5gr5jx/ht2h7DHaN3a98FdE/xru+l8NUIA7Gju
 6m208oo3TWwmz67x3KJJa6hollX7hieq5xcZgS6crAAKa+9OPOHzc+/SCtsAv15qlIZF
 K2cdKNZjjvTGmnWeZqF3gdB/DpnrBiIEf3OMZauHFyaqict2pgm/OVOLxAZ+DuaY5exB
 rV+eCLaYS0wENLzvjTxxXFi9nPabbBFYr9cRchQMg9znRZtNNxSsxbpkJ/m2w634e6dY
 D+p4OiRu/sW1Uw7D7sXNHWWRDofg2fo6p4cOiUsOsC8KPaXTeyXTHTFNdkoEUF0DryXp
 GFJA==
X-Gm-Message-State: AGi0PuaHo/VHUCc1hbIOUmcbLeIEBtcePJmhH10gAChLXYm4SjWQVphf
 a8sBATV2pBRH4GuWOWbaQNNoHQ3YCGI6tFxQ1Uc=
X-Google-Smtp-Source: APiQypImg7eFCaFY8TaMaRljB8ulcjMj4Rj4YOvwi5ESEYcUG0oNu3JVZQoid4yuOT1dWf8DXsq4qFzYlKtoA6+GvjA=
X-Received: by 2002:a05:6e02:60f:: with SMTP id
 t15mr2972734ils.241.1587641344384; 
 Thu, 23 Apr 2020 04:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200423110915.10527-1-peter.maydell@linaro.org>
In-Reply-To: <20200423110915.10527-1-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 23 Apr 2020 13:29:05 +0200
Message-ID: <CABoDooNC7Lpjg=QGkxLKGcrDJfQGsiLF_=qy3K+A5=emr2B07A@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 ID_AA64DFR0
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 1:09 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In aarch64_max_initfn() we update both 32-bit and 64-bit ID
> registers.  The intended pattern is that for 64-bit ID registers we
> use FIELD_DP64 and the uint64_t 't' register, while 32-bit ID
> registers use FIELD_DP32 and the uint32_t 'u' register.  For
> ID_AA64DFR0 we accidentally used 'u', meaning that the top 32 bits of
> this 64-bit ID register would end up always zero.  Luckily at the
> moment that's what they should be anyway, so this bug has no visible
> effects.
>
> Use the right-sized variable.
>
> Fixes: 3bec78447a958d481991
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  target/arm/cpu64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 95d0c8c101a..4c7105ea1a1 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -708,9 +708,9 @@ static void aarch64_max_initfn(Object *obj)
>          u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
>          cpu->isar.id_mmfr4 = u;
>
> -        u = cpu->isar.id_aa64dfr0;
> -        u = FIELD_DP64(u, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
> -        cpu->isar.id_aa64dfr0 = u;
> +        t = cpu->isar.id_aa64dfr0;
> +        t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 5); /* v8.4-PMU */
> +        cpu->isar.id_aa64dfr0 = t;
>
>          u = cpu->isar.id_dfr0;
>          u = FIELD_DP32(u, ID_DFR0, PERFMON, 5); /* v8.4-PMU */
> --
> 2.20.1
>
>

