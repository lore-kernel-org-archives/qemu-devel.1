Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C54CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B25222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZM04pFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B25222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTcg-0002ll-Vh
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLTZz-0000Ih-Uh
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLTZy-0002cz-MX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:50:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLTZy-0002cf-Eb
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:50:10 -0400
Received: by mail-oi1-x241.google.com with SMTP id d140so1127036oib.5
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lkCsWf/uuu/qdKFvNKTwUrfpKbLIs7U3HQYRpVg9+tQ=;
 b=rZM04pFYiuq2groX3GfVdEVnB04jSJNV6+w+DP8I6nkCluaf/2n+cFemCQeKR8uR4e
 0h2nxKA2dMxHOx0jVBdvMLI5HwzsSqKYvmyWL2+jZwyF3H2EGh4UnOraG4OSDOEyqvEO
 VfBbjEs6z8VHLDTT5pDOwD/GAIaWBiV8BmfFhxPmpTHZPLt8OS8AetbpiR/f8Q/gLlrg
 TbT2b9oRGbLHs59MivZkrlPmetzVj3PmstAMBzNB3UMyvn39GKX/fOzqZEC9Z/P2oSkO
 wAC+Coi0bI4vgLjFKpph6Y15jG3lhE4gm163Es/H1VSJCauXPo3BWphewOpwCv2YXyR1
 0vUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lkCsWf/uuu/qdKFvNKTwUrfpKbLIs7U3HQYRpVg9+tQ=;
 b=BrHNkuJKTn2rzK2EpKsZwPdcilO0nJKNdc/7nPyiGCBVH7dPtYluiMy5iziwqxzzT4
 Tb5wXPte6ud+01+micibnTm5lleIWI0UOAhFhyV0hvi6uQv+H3gUDbsyXK/jqzwlrjTz
 EgqZX9O6wMi/b4lMnzzbdD+1b8DnNsml5mfNJYehGQ7cUKaI8FTSZb3usllLfaXwUNnr
 WaYVeI9ALPJkzDopK2uFHeRG7Y2+YaYEqTlH/VMgS5YfgnDVuU2Qrj32Z6ih83hiDUJ0
 W/0ru2th162sYd1jVOloLSeEuZvgev1aMuOwrjuoCqNhkgp08Wd99miW2lXO9pDyXRcS
 P1mg==
X-Gm-Message-State: APjAAAVU5UWDo/HYdzoSYcxZeLIARQRpSpIk7Pp4XjFNnfkttiQZcSed
 p4Fo8QLZ53xjtSy8XounCtdTdjk0UVZA4ZxtG+E/1A==
X-Google-Smtp-Source: APXvYqzS07+ooCAxIz4mPlsSu9feik5VL9XlkTEITNSgMiJGqyiOvi4/xNVY1xEWkWdU9UM+W2q1ttL6Kc7ZVjxJO98=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr8517084oiy.170.1571410209515; 
 Fri, 18 Oct 2019 07:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191017185110.539-1-richard.henderson@linaro.org>
 <20191017185110.539-18-richard.henderson@linaro.org>
 <CAFEAcA8h9CN_qarQdfXRonE8KYO2=s+Jh_o+LFs9qk9M20pweA@mail.gmail.com>
 <16af4176-3acd-14bf-5399-31e5bb882120@linaro.org>
In-Reply-To: <16af4176-3acd-14bf-5399-31e5bb882120@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 15:49:58 +0100
Message-ID: <CAFEAcA-Fwx8+miMAHrRT2xwA9U6v3BbSMAt3YUQCOzba3wUEVA@mail.gmail.com>
Subject: Re: [PATCH v7 17/20] target/arm: Rebuild hflags at MSR writes
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 15:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/18/19 5:32 AM, Peter Maydell wrote:
> > On Thu, 17 Oct 2019 at 19:51, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > Why only rebuild hflags if !ARM_CP_SUPPRESS_TB_END ?
> > For instance on the Xscale CPUs we set SUPPRESS_TB_END for the SCTLR,
> > but some of the SCTLR bits are cached in hflags, right? Do we somehow
> > arrange to rebuild the hflags when the TB does eventually end ?
>
> No, we don't.  I assumed that all registers which change TB flags would in fact
> end the TB.
>
> Why did we suppress tb end for Xscale?

The comment in helper.c explains:
            /* Normally we would always end the TB on an SCTLR write, but Linux
             * arch/arm/mach-pxa/sleep.S expects two instructions following
             * an MMU enable to execute from cache.  Imitate this behaviour.
             */

This refers to an older version of the kernel code than the current one:
https://elixir.bootlin.com/linux/v2.6.11/source/arch/arm/mach-pxa/sleep.S#L166
which assumed that the two insns after the SCTLR write that enables
the MMU run from cache and so don't need to actually be accessible
via the addresses that the pre-MMU-enable code runs from.
This bit of kernel magic eventually went away with commit 4f5ad99bb5331c57
(kernel v2.6.39) which converted the PXA to use the generic suspend/resume
support, which presumably handles the enable-the-MMU transition in a more
sensible fashion where the address it's executing from is valid
both before and after the MMU is enabled.

thanks
-- PMM

