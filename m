Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F07C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E8C22D2B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roRondsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E8C22D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42xh-0002zu-R5
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k42ww-0002VC-9I
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:02:22 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:42796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k42wt-00022L-P8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:02:21 -0400
Received: by mail-ot1-x32a.google.com with SMTP id v21so1638288otj.9
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ppo/29vO7eIVLIqzbsiEq9lWEyg21xLKfEF6AGTj1uk=;
 b=roRondsWm8UBkPjPeLypR7un54C3gSw5dNRCmxUf23pkIGafu/ANd6ckSVWBkCRy6p
 GyXydOL/7/hz1nbWnXGzVSScEulX/j/Ql4N2Zky7BNlAH2DnxXpPE/4lmuRh3lbfeuIA
 rfteRkTTXhSyuDpja0N/bzfFgZIAScVm5YJA6YFgKzCYebhVWOU6cwBf4eOaSCvZFaUn
 4sUPUoLIG+ISW2NyGkjshbcguXp1sywBe58Hg8jadSD5UJhE/rl3H0oiFUtCq1OoJlbN
 /k6GJW8vJ3o5zrwh/tzQZtYcSth7LMdPHKAy8XQrIRFXMhko96hWtJJ2uYEjNDlwOwMc
 AI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ppo/29vO7eIVLIqzbsiEq9lWEyg21xLKfEF6AGTj1uk=;
 b=OSYswAKgjSBnWftPW6G4FtOLHxYC+aAJp82li+AWmN19Uv4ppqysi7s5/pIvsNtqJz
 c6pZN/cMkNpAwtlW7RYHz8hoNNVq29aT7epg1c4y3YRK02b7EYyuau7jAWIrcZc1itQV
 2D4ZQLPvfLNRUPsv4VoLm0xKnIBcbxGnh9TfM3G0d6157W1TAvR4nqG6BNeWkbm3LkcY
 BjXeOupLShl42Tv94N80kCxyya8fFOyluT7mAL0QLAWSRjI7fGS8gNtbnaTzM49anCw6
 W61uazATB/VKprXdikUkvPpLAOS4NkMR6qcMQheS4PkNOb00cXTe24ViTtmmA9u/d1+3
 WPLw==
X-Gm-Message-State: AOAM531L33G0GFUXhYhxcjfwmRB3ITf2G2pdshEZqiUl9IoX93c35f0Y
 2vCHQfulKuz2PRMoMyKuuVVZwMu17pbUQZaiiBKq1Q==
X-Google-Smtp-Source: ABdhPJxuku6qEaPRvpu1AnkdSIslyxX3w3Zw9WMZtfhEpXiLP+nLbuc75b5t9irD4l7FtGZ3vzWufYJsap78wOLgsR8=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr5570952otq.221.1596808936319; 
 Fri, 07 Aug 2020 07:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
 <87ft8yd0ht.fsf@dusky.pond.sub.org>
In-Reply-To: <87ft8yd0ht.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 15:02:05 +0100
Message-ID: <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32a.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 at 14:55, Markus Armbruster <armbru@redhat.com> wrote:
> I'm notoriously conservative in my choice of tools, and GNU Make is a
> much better tool than some people give it credit for, but I've long felt
> we've pushed it beyond its limits.

The thing is, it feels somewhat like we're already pushing Meson beyond
*its* limits instead... (it can't do everything we want it to, we've
already had to get at least one new feature added upstream for our benefit,
and in other places we're having to change our existing conventions
to placate Meson). This would be an easier sell if it was "this is all
straightforward and Meson has all the functionality we need".

I admit that I'm partly feeling a bit more conservative about tooling
right now because we just switched the docs to Sphinx and Sphinx has
turned out to have some annoying problems we didn't foresee. So taking
another tool from the Python universe isn't hugely appealing.

(This is not a 'nak'; I'm just expressing my unease.)

thanks
-- PMM

