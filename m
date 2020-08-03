Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42454C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 21:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBB322BF3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 21:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfc5AYyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBB322BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hlm-0007by-5n
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 17:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2hkx-0007Bu-2p
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 17:12:27 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:45046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2hkt-000878-SR
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 17:12:26 -0400
Received: by mail-oi1-x22e.google.com with SMTP id h3so10930699oie.11
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=RMsJXaJ7+FhERoMLJmMypLyAS3tmTW/EWrvMaCIqDnQ=;
 b=rfc5AYyxc6bFjPCyKvrm/ma0lSWqQvUijepsgSl7p8NwNWR6fp77loT7ODOVQp0QMM
 ohv3/NMUNSjtpisho3pjqA+gRsWVBsISQRz9pFvrZvn2VFjQ8neMJOCbtJb1TFPcmKOi
 YQuljL27V/CwcrnNOkUD2X+Z6MGtmwHnmFUKkT1UUUS/5lQyv2/z9rtHPN/Rs/JBokeh
 vVYpZ+IOOSqCnwvzR5Wnx4tbqRTaXPXk+DvGLUO/oWaaGFTuZ/nLEzIRRfTSNS8vmmWT
 dsP4aYxYuEKgKryeE1CsLaSJdIPjl2QXth5Xi4erCMZ5jmB/6jtGSy46DLP5YgiHwDdM
 jG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=RMsJXaJ7+FhERoMLJmMypLyAS3tmTW/EWrvMaCIqDnQ=;
 b=E0EkF71jAD1qwLfxkm9SG8r+cb9ZYPFowwRRfBC/KL6/JKUpGcNoYlCCKx7AQktmjx
 uiJPwb9wnZ6vFwtQaFnl/zkf1q5VI+oljWoHSp3xog3rqUfG/crqYQRU1M8Lx5BiXcXb
 YN37hcgvru4ZOY9gMrdK9w3ne3uhRtUyDDM7n57r12Q35+GnMcQfpsH8h9X5pQ4wgJwe
 rAToHNaIDNyFPpUUmWGZsGvpfniv0Eoq+PJ2FrPypGNH6LX5GQ4yFoXl7HPw3DvROFwA
 isdRxah83dF/dsKvk7LxnG1U7aol+2gAIDrjca1kycQ73u9l9rZ34dnGLbAYoD0q+0bN
 yrzA==
X-Gm-Message-State: AOAM530bbUw8aHJE1CNX022KJ7agnKkvOYAcav4qb1qr3H3Xok9g+96V
 hEnFY2Dw+76QIjiU+bopVFy1PXwkPhCkLFARt/IU5+kIAfw=
X-Google-Smtp-Source: ABdhPJxyg7ON1HG5gzed/FESS8U8hWSU3rY70qIUlew/nIT6h2nMuX56fx9Pwk6oEBfTtIkja4B6PJ7ifSKAA+zpI3I=
X-Received: by 2002:aca:5703:: with SMTP id l3mr125446oib.48.1596489141823;
 Mon, 03 Aug 2020 14:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200803193359.12936-1-peter.maydell@linaro.org>
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 22:12:10 +0100
Message-ID: <CAFEAcA-pfcrukAENd-ao=-4YLzKqYSpd6O_OTdj8+gKJLMpupQ@mail.gmail.com>
Subject: Re: [PULL 0/8] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22e.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Aug 2020 at 20:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Handful of bugfixes for rc2. None of these are particularly critical
> or exciting.
>
> -- PMM
>
> The following changes since commit 45a150aa2b3492acf6691c7bdbeb25a8545d8345:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-08-03' into staging (2020-08-03 15:13:49 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200803
>
> for you to fetch changes up to 13557fd392890cbd985bceba7f717e01efd674b8:
>
>   hw/timer/imx_epit: Avoid assertion when CR.SWR is written (2020-08-03 17:56:11 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/timer/imx_epit: Avoid assertion when CR.SWR is written
>  * netduino2, netduinoplus2, microbit: set system_clock_scale so that
>    SysTick running on the CPU clock works
>  * target/arm: Avoid maybe-uninitialized warning with gcc 4.9
>  * target/arm: Fix AddPAC error indication
>  * Make AIRCR.SYSRESETREQ actually reset the system for the
>    microbit, mps2-*, musca-*, netduino* boards
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

