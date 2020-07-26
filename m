Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11992C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA742206D8
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTSuA5zD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA742206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzjM1-0006W2-3a
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzjLK-00065q-E0
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 12:17:42 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:37357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzjLI-0000ct-IM
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 12:17:42 -0400
Received: by mail-oi1-x22f.google.com with SMTP id 12so12365443oir.4
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2020 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OBlBLghW3qI3JvxPRXUa0eaOravA6TXqXpnWDb4qK7I=;
 b=WTSuA5zDEmqevRlmroavDfHZ0ZIr11Fkx8SM7Ihu1js/oVJ/8rnwIPt+3CarW4bUyx
 tmCbXONTc169rIKi3d2rO2ImawESwAxeS5K7lGseYwWAa5a357OAw4yRagCxqHdiqgQl
 jn6hWDJDlOH7HL5x3tMA0a7HSWySi9BCYPMMDa9qxV21y/CXSeCJ0/Pt8Kr1GLOSD1dQ
 lXCEvTwRzmKhplTQ0J2/nfdFB84kcnOhkibxUPSK/q0bn+T/C+2URisSt/UFKSuXRp5v
 nF6E23JTnjnUsUuil+kchiztCZizRO/AkaWZ1SKo10S+M+G6zpD8ALCPFwXy6iTYmsBR
 pcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OBlBLghW3qI3JvxPRXUa0eaOravA6TXqXpnWDb4qK7I=;
 b=BfNkgAlFj2kKQ1Qm7qJANR6qzzkWVXJffykhnn8RUt+Oy3D5KUSiE3zJ2S5zVgB2SP
 6PrRCqR8FrY0wGtcgRCifGZXzfVbLhopRfkvZIBBOQbPIzWSJ0y4hr/S5dkox7KMbPdN
 9tFo5evx6AIa4q7i+CwIbpKPHH5vdaFpUGn55tXY7ky21aC7tM87IyjL71czCJ/OEEuz
 ILz4P/Q+epjrwLxlURE6TP4Cs2EclZtkvTAHChfJqGwPm2JDHaElSWQebgKnSKpPaIp1
 IFEFH9NGDpI29ZEwKdwHK5VG1XrQKRdzz/eJ8SskiIh41xLi5MKZTjlj5m/oDSMVAPsy
 LHdQ==
X-Gm-Message-State: AOAM5317Y/wwLSc72INRDUM8WZsqQTOrWpq41pzIwdXjj9W05k5o56AM
 hAnDJ9vy0RKVDe+aX6r0RKdMthvTX27DAf13vmKcFw==
X-Google-Smtp-Source: ABdhPJzwdIku5iyW+H3eoK2HobSE44twryRaxBhHIkkklG3w3DG99uze0XYFNuBlz1EKd/KGyyMAkfBvb9qxLPpz/XA=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr15438154oib.163.1595780258096; 
 Sun, 26 Jul 2020 09:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200725002228.2629410-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200725002228.2629410-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Jul 2020 17:17:27 +0100
Message-ID: <CAFEAcA_xUF3-XhECxTjJJVp=fza8icJEa=ej26pJu2DcdGCQ-A@mail.gmail.com>
Subject: Re: [PULL v1 0/3] Merge tpm 2020/07/24 v1
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
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

On Sat, 25 Jul 2020 at 01:22, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This series of patches corrects bad error reporting due to erroneous
> or missing TPM related command line parameters.
>
>   Regards,
>     Stefan
>
> The following changes since commit 7adfbea8fd1efce36019a0c2f198ca73be9d3f18:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-for-5.1-pull-request' into staging (2020-07-24 10:52:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-07-24-1
>
> for you to fetch changes up to 88f830745721ba8c9e9d2831c01045a6f130c1a6:
>
>   tpm_emulator: Report an error if chardev is missing (2020-07-24 12:44:13 -0400)
>
> ----------------------------------------------------------------
> Markus Armbruster (2):
>       Revert "tpm: Clean up error reporting in tpm_init_tpmdev()"
>       tpm: Improve help on TPM types when none are available
>
> Stefan Berger (1):
>       tpm_emulator: Report an error if chardev is missing


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

