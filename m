Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F72C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F293C20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPMGQDH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F293C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIBE-0000zk-7Y
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmIAD-0008Sp-SX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:38:41 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmIAC-0001AD-7V
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:38:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id g7so7403829oti.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ca+3ihsEpy5+fO8WuuhHBOaZ37RpKSlN3VR/yeF8GA=;
 b=zPMGQDH1Nzdde0mKOpGg9q7K7HA7OwcTw0WVJiFdscBQzmUvV0ighc/b+ADAV1c0tY
 F3oLX3rPna6WWi7+K2VVwGqMgUiSiLRnQXFIslBWCy5xNzHCt+n0vGkC4bY2r4NgYkFU
 pcwLrzFzR80eHE25PtcA/VAzBTHeDlZdBguiGPDTKYKthTlXvApa/UJPa2LyG/eufKr9
 EObEP1qGGW8d+210qVS1m9LJzgJKEvnnGzxt30Ogc+0WiEMDk93yo1vLIzzqcprzab6C
 ny/+Q+9gSXClxwJSqiVo1uVxQ4T/Jo0Ptn1OUEyEvXqzNcUHehbofUXwkAqE/e5ulWnj
 Gsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ca+3ihsEpy5+fO8WuuhHBOaZ37RpKSlN3VR/yeF8GA=;
 b=AtFJ+SXCRHzFn9avqAdPeuWemmHEKVAuvuHiHCMnbRVN6dgUHYuFxuz5vu70Qbx062
 uYPM606XJRn06AOHQOuPj5P12hRPO39GioIXDXeLmTN1EFaV5JTZI534Ig/+IafwrUgB
 yD0Ea2PDkYg+oy4Db5rXW2mP9i9TwLBLtFPFAEsgZ3LzIOdXy31OLhcux5T9ozKkaIFz
 WY7fk4dY9AffpDEM4s8n8ibGnCfvTJY+vNzCj1bXUEuusaqG8SVJtvf2a92fgw/O11f+
 I7bBPDkF8HMOzjiH0EgpWNYkby7F8jgXHx8++SH+/odoCzHb0AHuzXl0+j5UinOkG1gW
 5jTg==
X-Gm-Message-State: AOAM532nsfiq0mr/HCb/4ABmktdf9lz+yop3xHq0fbjxTczpw3Lv/qgv
 XqVAJvYYnRRW86QjF1Ojjh4WG/vfkEaWjY28tR/XgQ==
X-Google-Smtp-Source: ABdhPJw9Mju4Hesg8oNIJ631wFZ1IFA2fYMbX7zBspGt1FEClOT9l6g+BcK736INIebpsTuGNOtEptZzAiQQ8UK0eBs=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr3225296oto.91.1592577519078; 
 Fri, 19 Jun 2020 07:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 15:38:28 +0100
Message-ID: <CAFEAcA-YS92VA+QXzVyBTQhzskER09Cpp5p9ugi4FbbBPTEoBA@mail.gmail.com>
Subject: Re: [PATCH v7 00/42] target/arm: Implement ARMv8.5-MemTag, system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 6 was back in March:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg03790.html
>
> Version 7 is a rebase on master, which now contains all prereqs.

I'm now done with my review pass on this version of the patchset.

thanks
-- PMM

