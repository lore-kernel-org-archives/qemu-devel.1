Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5FBC33CB7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AACE206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 11:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mS7IRlhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AACE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixUm4-0003T8-7D
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 06:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixUl7-0002vo-CS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixUl6-0006XE-7S
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:46:49 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:47097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixUl6-0006Uk-3P
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 06:46:48 -0500
Received: by mail-ot1-x344.google.com with SMTP id g64so6223835otb.13
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 03:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nxE7I2q7oMc15JA9EunFii/Bfqy68AgCeeWNgJrZRAs=;
 b=mS7IRlhMcSfEGsXgNHG38wF9aQeBggyahhUBLAvmc5oWfJqIDfg/rdHkE4ujqO9Kmh
 AGj2qRyxlQYjCSTo9lexfROhEgLLNNlcw/FrtMExQ/eQX8eIXSPqJI7h1OsU8WkkaQbb
 ZFPqUMjMBNRM6ax+gDI/sFP2d8bBQlmrWKuFbPniVkeoBp4pcgbiUOAsKev1wy+XVb8C
 j5gvZwSaxurdEAfbUKGPf8qIGikWR58wMqgbbl4fx4ux8ssbl2ulQ2vcxlpvQXmc12+x
 iVOBCPSSCtbVV3bXa/qGHp0vqP+rV7yjcxhTCqbf4nMqVltRWnkivVUMC1L/s3T4lOmK
 9Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nxE7I2q7oMc15JA9EunFii/Bfqy68AgCeeWNgJrZRAs=;
 b=UU+Sq3zS93c4gLNyS0CYRAdGesceB9EGtGn8JvDnOY+hWPw4hYNGBDOdmPeCS45keB
 jWdcA3TkaChn7sNgWfkIoj2ENMxWG8A6tlSJPhe1MQRsEjCWP4kclCcLxK/ojgn4Toqr
 moKwbb1tnynIeAPx9lxL/6XarYIYXUFtOjR19287RbNqxfT5+hAIioZ4Wb9OEtMYYYjR
 yjtwoRTJ58rhaJb4OoNcMo5LdL4qWy4EmHiQ93ioInkWfkaOdtTkisOTRhLQcO01AjR8
 nHSYCBJiyrOWw/51JE3v4+N76xAi41ZKOgYaG/YE2nEGfqLolp++YHaI6kMa2qi0V6CH
 ZHsw==
X-Gm-Message-State: APjAAAX3jsHwggxawQiNNfrC5C3N0x21vulqLWxjhCP8UGgDxWWDPE1R
 te3MWCviTO1FPFOXXCDKJ6k/Wq8IvftoyV+a3ko/Zg==
X-Google-Smtp-Source: APXvYqygIY04x84omihxZ8Pt+RMkKXMrjz02YQb6Q7qoNJrXgaHN9wVW3JY7+/7n8uyzh0oiLUPdgFOENA9XaaTVqOc=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr7340701otq.135.1580471206990; 
 Fri, 31 Jan 2020 03:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20200120101023.16030-1-drjones@redhat.com>
 <a978727290d97ee9b91719ed6173f892991e62b5.camel@redhat.com>
In-Reply-To: <a978727290d97ee9b91719ed6173f892991e62b5.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 11:46:36 +0000
Message-ID: <CAFEAcA9k0-d44+ABPJRpnOVeFbbW3SUO3ZMhd0FF663hht+_3g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] target/arm/kvm: Adjust virtual time
To: Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Andrew Jones <drjones@redhat.com>, bijan.mottahedeh@oracle.com,
 Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 at 11:40, Andrea Bolognani <abologna@redhat.com> wrote:
>
> On Mon, 2020-01-20 at 11:10 +0100, Andrew Jones wrote:
> > v3:
> >  - Added a target/arm/kvm_arm.h comment cleanup patch (1/6)
> >  - Minor refactoring of assert_has_feature_enabled/disabled in 4/6,
> >    kept Richard's r-b.
> >  - Rewrote kvm-no-adjvtime documentation in 6/6.
> >  - Reworked approach in 5/6 to properly deal with migration and to
> >    track running vs. !running, rather than running vs. paused states.
>
> Probably too late since Peter already queued the series, but FWIW
>
>   Tested-by: Andrea Bolognani <abologna@redhat.com>

Yeah, the commits hit master yesterday evening -- but the
testing is useful and appreciated even if we didn't manage
to get your tag into git...

thanks
-- PMM

