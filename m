Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54681C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2401A2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jsh2EkVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2401A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXSm-0008HV-D9
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtXN8-0006wy-Q7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:17:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtXN6-0001tw-S5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:17:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id a21so1786104otq.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zxGK37NzPSfncdak5WpAZKiTh8SZRZCRr6jp4IZyh9g=;
 b=Jsh2EkVmNovcrYAM7TJ5ZjHXmN/jqXECaZXxcniTIh64jDUGflDUIPWZ90LUDQePIT
 IzYMlI/illDwDf66wJrZ8XXqQbhSVP+waexjfdk2H9WHTuZIBjxdgz66MGw7N1FR4Ryj
 U9ZRRiTrifIwqES1AhAFUOfq6d8j9p5qb6L0aYtgwEKh1FWg6NpRbfSvmQTH7fR1kqLg
 aNW0TwDn6YqL6iMLXrIPOFKtMeTgDSYZ4cLayNJrp5ExpdnfHcKfsgI4KItJdOdkXx5/
 rzn+dVCSnDAJ7kxez5FM7vbnOpNZmI+0f3FgnCm2F0GDFqEUrY8p2uRU+884N98qbsUd
 H7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zxGK37NzPSfncdak5WpAZKiTh8SZRZCRr6jp4IZyh9g=;
 b=uPh7+r1ZeVa7U6yttIKGpsPQIQSakt7av3+GGAHl3tsgxL4sR0v2q+Qn9gZx9f1JCm
 3yJJXtb2dyYfBpNQSHr7geLG0srzAkn2NInybyDJ5tc08GHbSlfTgxFKhpnSaRwFq0u0
 KSLZtJ030ddU9JdybxPlrmKFRkn//7EyB/f+9T/4EjJqN6GRTer0ZzaqUUeYVkgET3F4
 0ncsZCm7PedEmx/XsH0lHo0YnfLOcZB9FlWjRFqiCWMxozC8uDTBQX+OR7DTvDUWcuM+
 BTuc2FImSUD02di4Akpvppdwwn2T8VpYChzzN1Qdv7Uq+QD4wta0XP+VzeGSq/jPy9hu
 dhxg==
X-Gm-Message-State: AOAM531b+9cL+Sv8XZo3cJ+x/GoaK6+26wJVR1DEXGAqR1Y2N8wQ55ls
 Sd3VgvzFfmBsaquM1a5bsPlpEq+0a8CMcFMeykpqeBc8
X-Google-Smtp-Source: ABdhPJzigK2bMoVLRUCelTwxKgG9d68E6675gr6ATqxa1nKS6mznAOQGpRy3FtN2qZ+BVfFUS1+p1KldQYtrfeG0uow=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr46470169otk.221.1594304275463; 
 Thu, 09 Jul 2020 07:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200707152616.1917154-1-aaron@os.amperecomputing.com>
In-Reply-To: <20200707152616.1917154-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 15:17:44 +0100
Message-ID: <CAFEAcA_7+9TfeAeLYnpfF91zaGmk23p0S_0AgrDiPQ+rR1-EnA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Don't do raw writes for PMINTENCLR
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 16:26, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> Raw writes to this register when in KVM mode can cause interrupts to be
> raised (even when the PMU is disabled). Because the underlying state is
> already aliased to PMINTENSET (which already provides raw write
> functions), we can safely disable raw accesses to PMINTENCLR entirely.
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dc9c29f998..c69a2baf1d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2269,13 +2269,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .resetvalue = 0x0 },
>      { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_tpm,
> -      .type = ARM_CP_ALIAS | ARM_CP_IO,
> +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
>        .writefn = pmintenclr_write, },
>      { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
>        .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_tpm,
> -      .type = ARM_CP_ALIAS | ARM_CP_IO,
> +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
>        .writefn = pmintenclr_write },
>      { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
> --
> 2.17.1

Applied to target-arm.next, thanks. (Annoyingly I have forgotten
what the test case was and now can't repro it, but this fix
looks right.)

-- PMM

