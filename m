Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020ABC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEA8206DA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zK5yRIX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEA8206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2aOX-000285-Rq
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2aNt-0001fj-VK
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:20:09 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2aNq-0003CQ-4W
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 09:20:09 -0400
Received: by mail-ot1-x32b.google.com with SMTP id x24so3739267otp.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NJJXAqX3bHwhqwhRGQ74eSY9vcW2UJrHtd3NvbJSr3o=;
 b=zK5yRIX0xyYGPMYRVx2KX6Bsvi8DgINNIFVdG118wlm0AFDSTsPB6rbGs7jpvVVtDK
 CUf5omu+/WMgtXlL5IiFGOSTwh3eAjorvzjRIRDPfl3xfWJntGDi/jt2CcCtvjLIne+q
 s5V2Ge3OwMNeVTCCaQu9tTAD/W2QLhoSc2IIn0EYgenoInbzUqg1Zl7FFvgr6/Q9uXiA
 q8GnIEvoLaOr0xZItjgnV4WG7ngB213x48LuWIiw/dgWDVyicPQvBU9OC43FYp8C4Zom
 EgL9S58heFWK8cyBza0UtZdDTWuPsFNAryBB7uzYikwh6VQiDowEnphxA57/zEcDry7t
 nQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NJJXAqX3bHwhqwhRGQ74eSY9vcW2UJrHtd3NvbJSr3o=;
 b=gjmEIX2bGyATjtOZq6Ons23lcI6zsj86/ZDXotnWtBu1/UBZX45YsKq/AgMsTzYSOi
 rrd0OnZMCHvVW+TTm4IdyVwpVJVDlC8H9jk+UYTSefxRXORI9bYiy7yXWlCs9/B022hQ
 KJPj77z/GA3/nUfOX/MQvjYWjz/HXgSs7VeBCm2W2irsYNtaYe7+2lOLTmJPOQJdCWzF
 60mq8CxQyQaomAdkQVK7efS05g/EbVzq+iuOhfaNWAbfyGg4rzYyy4+STEMe6bE9G5qN
 oDKR959l6TB/PiZ6dToJtlmfhEhUEdYUG2JbQf5OJwjjnr7qgiyyd86ACR4Vhuqdtfxc
 Fx+A==
X-Gm-Message-State: AOAM533WOEbbvY3p6exCklWbc/sSwAHRmMyhmrq06ESqTJJH66t7HSiK
 qEDXBBwMAmbcb3zI5EjRI53cnGpJt12I5AgfRqOwgw==
X-Google-Smtp-Source: ABdhPJzjitH1/Q9/jI4CamEJ/GDWKTXLwcmzz6e8YzPRgolsEjrigEjdQN1mpmOIDaMotTCQ3byLaW2CEl4ZT7gCncQ=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr13499973otb.91.1596460804632; 
 Mon, 03 Aug 2020 06:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200803091042.2920218-1-armbru@redhat.com>
In-Reply-To: <20200803091042.2920218-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Aug 2020 14:19:53 +0100
Message-ID: <CAFEAcA_HrUzPJ3ip+=-2GECU257TffWGLM-tguYzGoLg8YMyow@mail.gmail.com>
Subject: Re: [PULL 0/3] QAPI patches patches for 2020-08-03
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Mon, 3 Aug 2020 at 10:10, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit d74824cf7c8b352f9045e949dc636c7207a41eee:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200731' into staging (2020-07-31 10:28:13 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-08-03
>
> for you to fetch changes up to f7160f32186b4ae1e1327e3bd05060fffec8f9ae:
>
>   schemas: Add vim modeline (2020-08-03 08:28:08 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2020-08-03


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

