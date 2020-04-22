Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6CC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785220787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULXrX9ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jREoL-0002Bn-Mk
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jREnU-0001H3-Pj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jREnS-0006qg-US
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:48:11 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jREnO-0006dG-4p; Wed, 22 Apr 2020 08:48:06 -0400
Received: by mail-lf1-x141.google.com with SMTP id r17so1556988lff.2;
 Wed, 22 Apr 2020 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+kmyptpxbUuU4GRghYpX15dLM0lMSpZ2ih8UKXX09Dk=;
 b=ULXrX9ugJjUVXu6tUZeclDGc3HkcqciiWXEzYBfNs2Ygb6P8Z+WGOcwcpSOIQLp7D3
 jsD5cunRUs0NF5JgmE0YIB+tS13blrwK8C+IJM9mBkExXUZl2mRQs5c7q106tsp85SUW
 PIhdw9ezD5O6TFuiG3PHMD10iNyWwANHjNMRfEilvgEkLf16DITwVoKNr+zFntwzXtlb
 dGu/LgOD+7Glgke7KPIxwDSubVQrHRDqwHIkRNo994y44v16TT5LisH9nOx+XBocbsuI
 i+BrEcRj2bnXwCSced14rsJbz/+WDVeCnJcQCkyYfSZ/MPsCpZ5TRanc9OoGRj6Y/4z0
 u8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+kmyptpxbUuU4GRghYpX15dLM0lMSpZ2ih8UKXX09Dk=;
 b=jbxROuEPOk1XWkSQD9yMlt0DAnlKsgG9kdD3VCsHh9FlLeCi1YQVQnUJ5aT9LAMUlB
 0PbdckMp+F9awZ594UeRo8duklXwz+rZqKrBtNYInsVPC5noihD04Q2WRDdPfV89VAjS
 lTfIVGSwkM/JEJTaHMX4EeU8nf4bXvfR4qXO0Wzhql0qg9ig02zZF2Q6kiIMaGZ5qPrw
 xlGpNBs5gE6HbZkkCqrVqmn0KZpIVhdZJZjl60z4VvM5x21AxxCb1TQmlZ0HSgO1+L1T
 Afqdb+SZ/716+Bouzejq8VE8r60EXqr3YUg+mos0Fq3ZsG306EUUaFzppaBImNU1GhAF
 0lww==
X-Gm-Message-State: AGi0PuZ4qildRYFJURPqgKCbOcAzjuhOfXelL3BWrGOldI3up2K2MNu9
 sSCsIyNPQa8uBxs43Mg0GSU=
X-Google-Smtp-Source: APiQypJg+cepf+oeYWKqDZ2mQLSTLtX3tU7xZHF5Y/u4g0MVhvZchrbb6mwjqp0vdjinvFvql8TNrQ==
X-Received: by 2002:ac2:420c:: with SMTP id y12mr17186443lfh.26.1587559683117; 
 Wed, 22 Apr 2020 05:48:03 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l4sm3491696ljc.107.2020.04.22.05.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 05:48:02 -0700 (PDT)
Date: Wed, 22 Apr 2020 14:49:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0?] target/arm: Fix ID_MMFR4 value on AArch64 'max'
 CPU
Message-ID: <20200422124913.GJ2669@toto>
References: <20200422124501.28015-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422124501.28015-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 01:45:01PM +0100, Peter Maydell wrote:
> In commit 41a4bf1feab098da4cd the added code to set the CNP
> field in ID_MMFR4 for the AArch64 'max' CPU had a typo
> where it used the wrong variable name, resulting in ID_MMFR4
> fields AC2, XNX and LSM being wrong. Fix the typo.
> 
> Fixes: 41a4bf1feab098da4cd
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> maybe 5.0 just because it's so trivial. I dunno...
> 
> There's also an error where we use the uint32_t u variable
> to update the 64-bit ID_AA64DFR0 register, but that's harmless
> because as it happens the top 32 bits of that register are
> all zeroes anyway, so we can just fix that in 5.1.
> 
>  target/arm/cpu64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 62d36f9e8d3..95d0c8c101a 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -705,7 +705,7 @@ static void aarch64_max_initfn(Object *obj)
>          u = cpu->isar.id_mmfr4;
>          u = FIELD_DP32(u, ID_MMFR4, HPDS, 1); /* AA32HPD */
>          u = FIELD_DP32(u, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> -        u = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
> +        u = FIELD_DP32(u, ID_MMFR4, CNP, 1); /* TTCNP */
>          cpu->isar.id_mmfr4 = u;
>  
>          u = cpu->isar.id_aa64dfr0;
> -- 
> 2.20.1
> 
> 

