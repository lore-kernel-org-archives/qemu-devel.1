Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375412071A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOEmhBTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375412071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlbyY-0005bO-Fg
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlbxu-0004zF-FT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:35:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlbxs-0005XT-M1
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 13:35:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so2671413wmh.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0rUoKcgqEoiNF5/lDcrgF9QShYREa0ia3WvSmaKqQLM=;
 b=iOEmhBTKNKy4AfxFcFG7Es2UP6Tnn3yxm6CaaR2s4Gn7Hft4EynZ3GdHu6FNnvjMqW
 fqeBRurzXTuVO2oj6l1knt3T/PfphMED8MPB4u5x9OKCZ58w0zSJrcAdEJRkliSYW4u1
 8x+Jqs9YSXucpb2OWmzRse7ALt7ti/hUy3UIKqNfbja3Z45BxLiqqvefJJeu1klOSrdF
 Br9gCm5Nb+KfXhnZGGKJ0aN3r7vYBuPYrzfeQM8vt1zmLm5uiooAK6Va9Otk3kyG3oFI
 Ev7E4mGK6RQq94f5mGwzJ7IQt5r1bRTF3EQuVGboTw0qh9oqn3Z6oxvO6shM+H4Wa5IN
 c9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0rUoKcgqEoiNF5/lDcrgF9QShYREa0ia3WvSmaKqQLM=;
 b=NSj/j4153ds8dx7HFP9aPWPTToOf1wWcr66sHvd0z0pYoOXhAl0yeUFhr1fj+alr69
 YW7qjaHHeGOOn3KtBTmwljr7GtAorg/tDsUM/NLrS+n7uOXdMwmtYMQaSUs/b8K0PosM
 1sxC3eW52h9QM+uxJiJH/oVIdhNzXP1VHcILoyQP+OsNDPcPo6U+58GhJZo+7lKdelwT
 MXiZsxUnZTXTid8CMA2NvP5F/GPlFZQEX8trJsWRscWpRt26B0vg0vSnlqPwZQfpyeDA
 ZERggFIpY7yQMDe8Z4Tof4gMGcwN+QTPz4LlX4Y7+3IJzr56dA8pCkGA5iiICwAMf8+7
 g3fA==
X-Gm-Message-State: AOAM5329WaqiTdC8NCmj601GHF4mzLc5F5KHqtfGjRuuHP0y4FAEWj9f
 AubErOZu1OHM54by9ZSZBob5EA==
X-Google-Smtp-Source: ABdhPJzPV5ChbY8Ghowj+6oidqQbVij8DZri9dtXIyJURBTU6YdgUejHjEUqed28je7tPkCVd0Yc+g==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr9581539wmh.1.1592415307085;
 Wed, 17 Jun 2020 10:35:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm355523wrx.8.2020.06.17.10.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 10:35:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D03851FF7E;
 Wed, 17 Jun 2020 18:35:04 +0100 (BST)
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <20200616231204.8850-4-ahmedkhaledkaraman@gmail.com>
 <871rmdyjbh.fsf@linaro.org>
 <CALTWKrVovkoQvNFxYac2eOV7Cf+K_RA+1-Gn=3AnL8dJLemTyQ@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [PATCH 3/3] scripts/performance: Add perf_top_25.py script
In-reply-to: <CALTWKrVovkoQvNFxYac2eOV7Cf+K_RA+1-Gn=3AnL8dJLemTyQ@mail.gmail.com>
Date: Wed, 17 Jun 2020 18:35:04 +0100
Message-ID: <877dw5wq7r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, ehabkost@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, crosa@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> On Wed, Jun 17, 2020 at 2:21 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
>> > +
>> > +# Run perf repcord and report
>> > +os.system('sudo perf record {} {} 2> /dev/null \
>> > +            && sudo perf report --stdio > tmp.perf.data'
>> > +          .format(qemu_path, executable))
>>
>> Why sudo?
>
> This is the default requirement by perf. You can modify the
> kernel.perf_event_paranoid setting to run without root privileges.

Right - which I do as a developer. It would be rude to sudo things if
you don't need to because then you end up running your potentially
un-trusted application with root privileges.

Could we either probe for the requirement or require an explicit sudo
flag which we can prompt for if it fails?

>
>> Also redirecting just stderr? why?
>
> Perf, as well as Valgrind, print their output on stderr not stdout.

Right so I think a bit of splitting apart and use of subprocess can make
this cleaner and not involve quite so much being done with shell
redirection in one invocation.

>
>> I think you could separate the steps (as well as use the subprocess
>> api).
>
> Noted!
>
>> Again os.unlink()
>
> Noted!


--=20
Alex Benn=C3=A9e

