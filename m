Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C5AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA562078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYWfKeQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA562078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbFi-0002Im-GK
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVbEu-0001b1-SY
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:34:33 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:41724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVbEt-0001wc-PC
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:34:32 -0400
Received: by mail-ot1-x336.google.com with SMTP id c3so8847067otp.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=UDuSnb0oOHsX+ZkN1PziXzQgxMLwjMDQ68kWWxsheK8=;
 b=TYWfKeQa9nHV0zzMjDZT1rOkPkln7cmSfcjWAY+Q4SiKQEvoA6l5tGC2E2nh2J3VY2
 W0CN8zWwj04jR+4vX456Yn9q8J2tZNtstQ2SB8o2IHuEG+B9/+xymcs68ZeUKR2CfSIQ
 xQl99mI2nKY/y9PX0l+8jwc7M9AyRLg1E+Zvht2TD43QQ9VG9j20JjjBJHYKnTMEgbQd
 vhCixE7Q+fE2qAW14AQZmLnR5UyAjXUzrll5qwBEzDyj+S2peXz7lKWA8zB3NR6HH/Hw
 XNBz8ZonaeMUzlWovNoZ+0klwvqcXDds3G0zPAjaxqplUEwOjDxta9BVDf7BNY3tNnWg
 M6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=UDuSnb0oOHsX+ZkN1PziXzQgxMLwjMDQ68kWWxsheK8=;
 b=L8XdFhvOCrmaGq5+aPHkN/xnSbX5IS1cdnR5GFGN8Fv4VG09V5z9liSZn0X3HyHsAG
 iJoX/wQI1VJruOGSPu+3bsiktEIQcQDo1e5VZColRCWqyMY8J5uLWGA+2Idl4KtusxOx
 ncyX7T0iC2Um1BigFjGwOw5J3TfnpVzgFBI9e0t2LFF+iGvXx+srNClfmXyreAu2ugTj
 p/FMBclQ/akFUYremuoLzpRRaNhE02MPhEV0dI6OaBMBZXpxZ9rhsQlxidoQjoKs6eJq
 f/YATc2rTBF19Ep5J7lu04g1X/oBAiNvv8Wnwz+rBLZ06zL30LW8VH62QJkvOx8n/i8C
 SigA==
X-Gm-Message-State: AGi0PuaWDEYRD3vHJAAkXuD/aD1qvnIEhv328PBqePEvlZd2Fol5WdKT
 LlXEKc/kjhI3pvbVbUhWLWMF3TYLe/pbLlyxu/HN1zgf
X-Google-Smtp-Source: APiQypIBdW9xUhj7M500jv0oiin3f45TYSFONp89fRkS+4yOwDyzF8zm5ngEI1Yy/banifn5zbdNU+QI4CtMlm8Hoqg=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr14488109otb.135.1588599269686; 
 Mon, 04 May 2020 06:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200504123309.3808-1-peter.maydell@linaro.org>
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 14:34:18 +0100
Message-ID: <CAFEAcA8xJqf+mFsPbXA3=_E1QjOtrwKjTcJEtd13Cjo+C_SULA@mail.gmail.com>
Subject: Re: [PULL 00/39] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 13:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Most of this is the Neon decodetree patches, followed by Edgar's versal cleanups.
>
> thanks
> -- PMM
>
>
> The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2020-05-03 14:12:56 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200504
>
> for you to fetch changes up to 9aefc6cf9b73f66062d2f914a0136756e7a28211:
>
>   target/arm: Move gen_ function typedefs to translate.h (2020-05-04 12:59:26 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Start of conversion of Neon insns to decodetree
>  * versal board: support SD and RTC
>  * Implement ARMv8.2-TTS2UXN
>  * Make VQDMULL undefined when U=1
>  * Some minor code cleanups


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

