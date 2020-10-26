Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE9EC388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCB120809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtNSOkru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCB120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9Bc-0001Dx-JP
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX9AG-00006z-Hf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:32:25 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:38394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX9AA-0001M4-FS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:32:22 -0400
Received: by mail-ej1-x633.google.com with SMTP id ce10so15668029ejc.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/MbgA/GutTytjvUkcaNGnlkvO1dB3IyusxNF+lx4/cU=;
 b=DtNSOkruBJd83xbkjbqxTdjZnW7WZV5SzBP26HneGGwJtFk1z2M6Jku6jxpbUb1taq
 FHmtAeXX2nI7DX3JGzbbRVZNnO9IJzLs4oCTOyMOycZ9sMZaEu06cUW4GIB+VsIicqSX
 +vy/+qEefnnFc4OrCwUSnRnc1B1/EwbrawLbbZHuQ3Rl0/zvoZt85q9wKmJEmRe4ENRk
 /9kXjyXoZJzc6iBEr8b17nkr5UC+aXoRJ0tHdleWjinisxgcg7VWqQgE6rL7p5xlgluQ
 YIne/ZwmLWn8+a+1H+xVkxARo1RPkUBICh2hF005Clssf5AsL7JzVhRsIeDaPLYwYdHD
 cC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/MbgA/GutTytjvUkcaNGnlkvO1dB3IyusxNF+lx4/cU=;
 b=KY5PEM6UQfvedrsC0mClVELZdyw+1yETLdxhvAZRhyHcbOqWWONuMP7SBbRK410WzB
 wym/PzlP0XcmMqBzVre4/ZIKz5gz3xyrAGoOFzHAzYiiakgZeQHOcO7uXyzB1nTQHByt
 0hnVu4XovVzjbQCSPwJiZ9bK74WGnWJozS2PQ6x5GpCs2aRBeRzdegJ90MTJWbwwio/H
 PL7rEVsrvE4Vh2CdTfGtjsl3m9azNS979ddRkVEytuA5SK2FUI3yVsNfFl+fiXfavjNV
 4ej1uOqBYy9ply1PqywhxqP9i4GbDVjd3Y6eKPuHkE91ZJLLe9DQEOdnfNo2TN3Qrl6G
 uvVA==
X-Gm-Message-State: AOAM5316wV2qdl5NWq8YSvzxAiSrUBadABqAsNk4dLRs/RKSvCn8Mf1i
 MRUrPWTk+QH7p3UyCMU+hAMJ330e4mS4h3YEI081dA==
X-Google-Smtp-Source: ABdhPJzmaxAbeJnVH8qufm+FA+c0egwknncB7zTLR2nOTRyVLCgzetrWXqKESxIjqwZKyw5lcF3YbcFg2yDZAz7vxz8=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr17118329ejk.407.1603744335970; 
 Mon, 26 Oct 2020 13:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-nwJRgoraR9HFoDpW-tgGER6CAaY0s5gyR8BGDH3aHxA@mail.gmail.com>
In-Reply-To: <CAE2XoE-nwJRgoraR9HFoDpW-tgGER6CAaY0s5gyR8BGDH3aHxA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 20:32:04 +0000
Message-ID: <CAFEAcA-4-z7U6-8HLPUWkWKn76iKLxZ_zq3Xw_1=2DrGEkHF1Q@mail.gmail.com>
Subject: Re: How about using a bot to guard the pull request can be apply?
 like rust compiler does.
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 20:14, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <lu=
oyonggang@gmail.com> wrote:
>
> Peter can @bots try to apply pull request, if pull request apply and all =
ci tests passed, then the bot automatically merge the pull request and push=
 to the mirrors.

This is somewhere on my list of nice-to-have-in-future
improvements to our process. You'd need to have a human
in the loop because there are things we want to review
which the CI does not catch (mostly "does this look
sensible", "is this a request from a new submitter whose
work needs a second lookthrough") but that could be done
with some similar thing to the r=3Dwhoever comments some
other projects use. Then you could have "as long as 1
(or 2 during releases) senior maintainer acks the pullreq
it goes in" rules.

But right at the moment that's half a dozen steps in the
future and we need to get the basic CI stuff working
before we start looking at changing the workflow for
submaintainers.

thanks
-- PMM

