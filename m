Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773BAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428BA20702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i297upVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428BA20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSs2-0005aI-Ix
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joSr3-0004Ld-Bt
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:27:53 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joSr1-0006M0-GR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:27:53 -0400
Received: by mail-ot1-x329.google.com with SMTP id t6so5403676otk.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yptTLr9wejHEbiD23kH0sq0IU4OsJFDPjWTxnOMHfXg=;
 b=i297upVYeNK5hZJ1EVfGifNhWAYngqwjWHbhebDNDl1Fw65EyO62uzgttBIYkeBY2A
 m9unEtqLcnSqHwr/15GvryOROP7zkUrVPDHt+B3vdBPPUTE3ekhco2GUF9WFYz27jZla
 GHk4uNi0wGR16iI2H6Mq1PPLuVS82mHxfaZAH/wdYndr9+ET5NnYx1oqfNKPMCtYfBdP
 QHQwwLWGaAtYWSXJFt54MxQaWNuKkFxO+h/8kY++EE5t53lOY13jbLXZUQibogGnnJBL
 EdAojzVStimJJZH8l0fC073Pk1QeuYz2LLFMIixq7f0olVCtHm6D1e8L18g+V1HDfSnw
 svMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yptTLr9wejHEbiD23kH0sq0IU4OsJFDPjWTxnOMHfXg=;
 b=frjyye4UhY0B3Ft9AKUGrsGOlaW0MJni0atuRdfm4lvlrtC+CIaDnuYgINlDURcxxt
 g8dig8ZGdGyYbIE/AWyc7mutHx0ilJevdz5DQYygoHlK5v6EK+sZP6q3mb/rR7W97J5P
 plscKuqRjbeCCK1Ap8RS4YNWQ9nEMlJnJPnhY8QKTHvU8U8QUo8SpVefLn/S1o9Ik/SS
 YM4G/LyYQxVHFCb/CZfVUwbVFbRcRuLp/OLUnR6FjPdU7FI4MHs0rk/iJQiV8lvbbb95
 9/meR/2TvZUutwLkBwnYd9x7hJ1a41X5ZuFo8VDLSV/9/j9c8s+2fFV6uNtovbDN2uhh
 Unwg==
X-Gm-Message-State: AOAM531Zn+YN/X7kaieRLJ9cGaMJVvZTw53rEswX4BTab5GRIS7HJ8tI
 AIq5abOePUAKO44hAlRQlkdIAE+ALCB27oLcmsKYUg==
X-Google-Smtp-Source: ABdhPJyFaomRN9phfVkayBgPACwLodbZktVREWcIAfMKujr9VrUgb9obwkzoomhuIfKTkv8XKlSA1TcMGJ8WQ+hFRss=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13134594oth.135.1593095270269; 
 Thu, 25 Jun 2020 07:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200624104935.61329-1-stefanha@redhat.com>
In-Reply-To: <20200624104935.61329-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 15:27:39 +0100
Message-ID: <CAFEAcA9MUona0iPuYV-e4hNVfqWk2mBgoj22bN4NbXfu7o_CwQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 at 11:49, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit d88d5a3806d78dcfca648c62dae9d88d3e803bd2:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-hw-2020062=
> 2' into staging (2020-06-23 13:55:52 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to db25d56c014aa1a96319c663e0a60346a223b31e:
>
>   trace/simple: Fix unauthorized enable (2020-06-24 11:21:00 +0100)
>
> ----------------------------------------------------------------
> Pull request
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

