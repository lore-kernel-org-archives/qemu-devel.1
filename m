Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F03C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD37214F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8JnNZP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD37214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKkEr-0006Yc-Ni
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKkDw-00060x-E3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:28:57 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKkDt-0007lo-2Z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:28:55 -0400
Received: by mail-ed1-x541.google.com with SMTP id c8so16585950edv.5
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uPP8WZD/RMQ9e3FFKH8qZw2tibrgnBZ6EEKKxOlhgV0=;
 b=V8JnNZP129zwrHZP+W2CtdPX8h5ZrLbrpKCftCkiqLNprs41cY6JEp2JCQEJf9vMzR
 Ufs9goKOjJ9ctlLYpYWP4bA/BvajoDXHVCQIImBKYbdJ46s925+3vo6CXGkN9WjQ7w+p
 phAZtD7e4u1Wpus7tlDnu2kHXwuFTYy/uxTwa9/UekkgdPv3L8CFgwsrbbCJ1KhNE5K9
 B4V4kfo0hAm8F6F1GCvIiJBkJM7x0GpbN11u3P3rKNjIubBRN4HeXttBLesXab3ToBWC
 wAfXDgdVun9lSh3eu2TlRH76SuN+upo3Ro9sh9ep5UdER+jSkBWB9CFGTP21v6ZfRcC6
 Nh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uPP8WZD/RMQ9e3FFKH8qZw2tibrgnBZ6EEKKxOlhgV0=;
 b=Mki0PCG6/H60ZHwBN2Bm0fvpXX6K24B+XGJvE9+CikL50FQy56m9qoZZkc61yTOr/6
 /mKLaZo8cdj0vq7AGbQzuTJ9eTw/FVQnO3agLc0i3GKEgvChSe8vjAQZGfiAhfAEG9pt
 daCuCMqVcPl+iUHMeRoBaRj6zFnNVBe2hRYV9upRX8mxsRCv4JOt8zl66AmJSOsJt/RK
 EJuqgE4vCCs3HHesHpJ+sjzbnNCaPkjuIQ/ql62sqKrmhPvot5juniEcu8uhTblqhEyE
 6QVrTDihF9LVQtL+YPGWM/f/yRuMj2cHm2VzjjCqzxqe6Mivtviii98zvijzgCsJcdcA
 THcQ==
X-Gm-Message-State: AOAM532f3mWY4vUeJG5mxY9oIoaXa+3rcCTZwoKp/Ne1mpVLlBjAaar4
 slQBG7pbHvc6dW3HSSPzDJvyCg/2IR5A3tmmnPwa7w==
X-Google-Smtp-Source: ABdhPJzBeEM5vnoUKZWG6d8gbJ3mQ5uPUHv2SHRytaoqgsHkaVyp89uHH/rXyU2cJwUjP1gxLWsLa5EoIotZthKMO+0=
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr4744384edq.52.1600788530421; 
 Tue, 22 Sep 2020 08:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-9-peter.maydell@linaro.org>
 <87wo19c3rr.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo19c3rr.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 16:28:39 +0100
Message-ID: <CAFEAcA_Ndu6RnNmcwp-pb6YdDqx1h2OTRdjK6EoGuLjRu6AbHw@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] scripts/qapi/parser.py: improve doc comment
 indent handling
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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

On Fri, 4 Sep 2020 at 10:03, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Make the handling of indentation in doc comments more sophisticated,
> > so that when we see a section like:
> >
> > Notes: some text
> >        some more text
> >           indented line 3
> >
> > we save it for the doc-comment processing code as:
> >
> > some text
> > some more text
> >    indented line 3
> >
> > and when we see a section with the heading on its own line:
> >
> > Notes:
> >
> > some text
> > some more text
> >    indented text
> >
> > we also accept that and save it in the same form.
> >
> > The exception is that we always retain indentation as-is for Examples
> > sections, because these are literal text.
>
> Does docs/devel/qapi-code-gen.txt need an update?  Hmm, looks like you
> leave it to [PATCH 15] docs/devel/qapi-code-gen.txt: Update to new rST
> backend conventions.  Acceptable.  Mentioning it in the commit message
> now may make sense.

I've decided to pull the bits of patch 15 which document the
new indent rules into this patch, in the optimistic hope that
if the patchseries is OK up to this point but needs another
review round for subsequent parts we might be able to commit
this patch to master and stop further inadvertent breaches
of the new indent rules being committed. (Another couple have
already appeared in master since v5, so v6 will again start
with a patch fixing them up.)

thanks
-- PMM

