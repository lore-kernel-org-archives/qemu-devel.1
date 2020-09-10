Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A11C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA973206B8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owKF8j/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA973206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK1m-0001OB-P2
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGJvy-0006gC-W6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:36:07 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:37707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGJvu-0003bK-5B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:36:06 -0400
Received: by mail-ej1-x629.google.com with SMTP id nw23so7958987ejb.4
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=04+xVqSGcUiX75AMsbiZHzufhmG03CHuVknTWVvnvog=;
 b=owKF8j/RxgtsGB0neTVpmMqFGC6xlOGJfYL3iCuHT2xY89632LhHd90ZzdL3qU2PN8
 sUSwyPnuI7QPEtNaJMHryMrBENMCyGhmSbFoVF9gK3YfeiRh1a2ms8VM6P9uFHWRGzBd
 r4rE+BJfIs3torl76VUxuI9KkbUSHnxwzIoeIKLjMgexQA3zKJurAdyrBHHxSlpTzIDZ
 45z4FtxgIC7HTlJGTYZ3x2aJrU1sc0ostbRNisVfONbRmxzDZpRuNyE5SYv3W31ztfjF
 F/JRNF3gcGnVaEnh/kqxL3SEO0x4UNLLypqosCab7FPoIam6g02kZ4MNvyJDqtb2slsO
 4IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=04+xVqSGcUiX75AMsbiZHzufhmG03CHuVknTWVvnvog=;
 b=KTuoUHly7/mV9qYkSLLOPfcIpyPo/423hSlmbvhWs3fYtaTO6uAKjCKckLeYhuKYaM
 vdEa9+krrU2flJUuEP3luyUeZOMqQu+jMf6xF9xwp0u+7qDlo8kIriU5n9G93DFe4wLc
 hWhriFCgqpwrtY1KiXGGeh/l+u1JyDWI42aLuKkzRVZDQo6EuPTchdbbpB4A0xKRV78O
 XADhUrFV1BIDw0nY4yiJKgvYu4X+lNKl2FmwFGNmbzuKA38pwnZs5i92+6C85RZWNA73
 fp0Gf81VNWCg8J3/t5Q1ATTF3aibRTGj7HoEmmlRptIXxVq62/0ZOiiOEtDiahSamQkL
 kK4Q==
X-Gm-Message-State: AOAM530AdsTwh5uDniyNsMolgSBcHQ0M/BApOGPb93t/X2xGYeRADK3d
 0VWeCidAmxbHL2r1O9ulc0XywTpZQ4gxJI4RvDYBkA==
X-Google-Smtp-Source: ABdhPJzLMvz7CH8X6UvvBF4TiYTwIpF7FdDLAz2Nb23ew2/HiUhY0aMZVPq+15P0nkx01hpJqN2bZo3qTU/ijMwSrmk=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr8118845ejb.4.1599734157992; 
 Thu, 10 Sep 2020 03:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <2764135.D4k31Gy3CM@silver> <2421928.3WNMogbLRJ@silver>
 <20200910093910.GG1083348@redhat.com> <4878996.4JzhbN1UZ4@silver>
In-Reply-To: <4878996.4JzhbN1UZ4@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 11:35:46 +0100
Message-ID: <CAFEAcA_CPNppKwwJSu4O6U6qF-rfHR2NtG=hWBFatZmD4aiMdg@mail.gmail.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 11:14, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> For developers it is actually the complete opposite on Mac: you start to
> install things from somewhere, then you need to install something from
> somewhere else, manually build & install stuff, and you end up in conflicts
> and misbehaviours all over the place.

This has not been my experience -- homebrew has everything, and
it doesn't have problems like this.

> The way to go for devs on Mac is: 3rd party libs should not be installed into
> global space, rather be built & linked either as dynamic frameworks (including
> assets) or as static libs. Then apps always run with the precise version and
> flags of libs they were tested with and never conflict with another app's
> version/config of libs.

Does Apple (or anybody else) provide a framework for doing this
so that developers of individual applications can just say "my
app needs libs X, Y, Z" and they don't have to mess around
finding, figuring out how to compile, and shipping the sources of
libs X, Y, Z? If there's a better mechanism than Homebrew for this
that's great, but at the moment what you seem to be saying is
"you should do a lot more work to manually set something up where
you ship the sources to all your dependencies and then build them
all". There's no way we're ever going to do that, it is just
way too much work for very little gain.

thanks
-- PMM

