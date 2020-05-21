Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD12CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5822078B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6MLhezb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5822078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblZc-00032S-Lz
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jblYW-0001iI-KK
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:48:17 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jblYV-0008PW-6z
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:48:16 -0400
Received: by mail-oi1-x243.google.com with SMTP id r25so6255965oij.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k/2Bugscbmu0KKP2zc3iHcD/jL3Uk0EeKwAfwUYJ6es=;
 b=s6MLhezb6WbSCsX6Lc7AW0kVfbDDzngOo4uF3n49v2P44zVvrK1fFQILtAi3lSoTNP
 FGrcMnuZnWubBnMp42Wfis4NN1bqmy04xgfIH8tDPQQJtrlJQ96HWTc6nxYaE6XMqgN3
 G5f1Ec8Kybs+8zVsLMLVpoXsEYF/1/UGrbYX1KmQ52lv8Ey7crvnkhiTv5BHvfWczrjd
 xOj29IhplSCGpeIiHNNKeMyaYbPXCn6FRVRwWQ73TyuiymbP12fbn0V8b9dAh/RJnUa+
 v4e4fqqWuXbEjun7kkwB58IPMBgn6ElT2zhXfRhkRlZLwVjeDb0TszirJnvDLF7fh5MG
 uOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k/2Bugscbmu0KKP2zc3iHcD/jL3Uk0EeKwAfwUYJ6es=;
 b=TaBsO6Qf6eIy7JD5gI2Vrd55VzV3X03OQnftluztloY9G70gtM3SeCI/iqNBE+xfku
 rE6YcB4IgeoN6ajbTUr0iEzQkhJK7HUbzQU7Kc0QVSxLROINd9T1QxPl+x7L//jT39ka
 jGwG5MilEV/d2Gcwnu5t8I6ueibixXQvmZqd8obP0TEc1AriPCMBAKb7gDFGP19qG22r
 RfkW2/q2r/KjXWbDTSxgGdwWIp1QGEGRRUI0GIWbpRJygCnnQwP70SHo/suLsEm5TsHg
 DSpc46cRzp8AF6rN4BaZmdf5osSqJQxklI20CUnMFEn1aY3oVkBCU18nftK1a2eC/b7Y
 Q4NQ==
X-Gm-Message-State: AOAM5326nVdKuxSq2tPJ+smvw25wekYzLKTEAL4Ia4qhM91JEYNb69Bk
 uWkUe1rcjY5xHrmT1kTviVbsoSeiJf2L2YnzdPGd4w==
X-Google-Smtp-Source: ABdhPJwilx/Y565ErybSvA4OBX9tuGzgINSzjPgUQdEq3kxmkPcj8d2/8SP2Ac3KaEsUQpB0ISy9fk1hLABjEk9vqE4=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr6434465oih.146.1590068893762; 
 Thu, 21 May 2020 06:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200519175707.815782-1-eblake@redhat.com>
In-Reply-To: <20200519175707.815782-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 14:48:02 +0100
Message-ID: <CAFEAcA-QS1wrHmAPp=PL_16L8Sx2-PXp9oNqhLow4PYfy0MAuQ@mail.gmail.com>
Subject: Re: [PULL v3 0/7] bitmaps patches for 2020-05-18
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Tue, 19 May 2020 at 18:58, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit f2465433b43fb87766d79f42191607dac4aed5b4:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-05-19 13:42:58 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-18-v3
>
> for you to fetch changes up to 3b51ab4bf0f49a01cc2db7b954e0669e081719b5:
>
>   qemu-img: Add bitmap sub-command (2020-05-19 12:53:22 -0500)
>
> v3: actually commit the cvtnum changes that I thought were in v2
> v2: resolve semantic conflict with commit 43d589b0, only sending changed patch
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-05-18
>
> - update bitmaps maintainers
> - add 'qemu-img bitmap' subcommand
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

