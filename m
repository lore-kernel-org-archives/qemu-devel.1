Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F26FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8AF2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbHKnJCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8AF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXkt-00047V-4n
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXkG-0003QK-Nq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:41:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXkE-0003yu-LJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:41:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so2669891wrw.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TgKp+m0vuLnmTO1hIBS7T5D4GwBj6mcQ/XuopOnJHRg=;
 b=xbHKnJCQG0nbDoxAt6Bu3CZthoV/gdgN0ELOlP7MvVh46buPVH94HxYpoNW+5LRRef
 TZuaOBQ1gyDRtlh0WQMZfP7bgkRwSdd9rRy7ugmP8DoD5Z4Hn7S4M5DQaycx5ZCMqgGo
 +TPU9CHGY30ET4S+tko9HVzMfl3ZvNkd0oL2IGuuYeNhehztsQ3BnUJ8cw8/HpkdBP/b
 iCOy8WLw309WtnV6vBwQBFIzukBbiD8aVavmBOLHOmL1b5jQW1sZTPPCa7beITglVYd7
 vZXgBus39CKq2CuUatrqGs87J9X6oOiozmJLGwDGk43qv8N4ruq/VyvuwRYxNN7Kk+VN
 PfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TgKp+m0vuLnmTO1hIBS7T5D4GwBj6mcQ/XuopOnJHRg=;
 b=I6q0/MxKrdUVIxPp5SX+eJpE5KEQ0UzCttWv70gQw2pVJrGwJ4BcQPT7bD2/nQzBYk
 vfAV735Zj/BvfuH7EUvCvbLV+YQG+39PGxFgrEt3pHraezEhCNMUmKix8y6nQShDg/Mk
 6RuZhcmBXfo2X/RG2XK5VV2JOCOXIPmId9xlUcyZtAiYXhnY86//zvAbqMdjV9AgGQ1m
 vcpIB4PCEqz6cczh5W3MGoKBKePzsyPkr8/QS5m33Z4zBac0BQS/qchl2gyK8airHwVz
 f4PkrTJ0Y/MxXIHFuZpnx8mEPDYozDPxhPP8ohaa/f8+aghacNd9xBu4U+R8EntRToOo
 DQMg==
X-Gm-Message-State: AOAM5313tbUr/UQubqRIbkDCSDuOvwyEj+3n8ukz/ZSo+rACZyCQH9gO
 2Y8QRsO4at2K7gMrvXsS6jsJMw==
X-Google-Smtp-Source: ABdhPJzf83CPnM6GoC7zZFexE4B3DqHG/uTEdqGw2ash4WflK8q2kZdP7OEXtB9c58vTbxtr8zy7Eg==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr62650828wrp.268.1594305708446; 
 Thu, 09 Jul 2020 07:41:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm7056689wrb.78.2020.07.09.07.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:41:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A34861FF7E;
 Thu,  9 Jul 2020 15:41:45 +0100 (BST)
References: <CALTWKrUE3r4+BMKQY1YX6zMOriKcd_5QNyqGBk5Z_S5ZZPs+4w@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#3] QEMU 5.0 and
 5.1-pre-soft-freeze Dissect Comparison
In-reply-to: <CALTWKrUE3r4+BMKQY1YX6zMOriKcd_5QNyqGBk5Z_S5ZZPs+4w@mail.gmail.com>
Date: Thu, 09 Jul 2020 15:41:45 +0100
Message-ID: <87eepkn42e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, luoyonggang@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:

> Hi,
>
> The third report of the TCG Continuous Benchmarking series utilizes
> the tools presented in the previous report for comparing the
> performance of 17 different targets across two versions of QEMU. The
> two versions addressed are 5.0 and 5.1-pre-soft-freeze (current state
> of QEMU).
>
> After summarizing the results, the report utilizes the KCachegrind
> tool and dives into the analysis of why all three PowerPC targets
> (ppc, ppc64, ppc64le) had a performance degradation between the two
> QEMU versions.

It's an interesting degradation especially as you would think that a
change in the softfloat implementation should hit everyone in the same
way.

We actually have a tool for benchmarking the softfloat implementation
itself called fp-bench. You can find it in tests/fp. I would be curious
to see if you saw a drop in performance in the following:

  ./fp-bench -p double -o cmp

>
> Report link:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-5.0-and-5.1-=
pre-soft-freeze-Dissect-Comparison/

If you identify a drop in performance due to a commit linking to it from
the report wouldn't be a bad idea so those that want to quickly
replicate the test can do before/after runs.

>
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> Report 2 - Dissecting QEMU Into Three Main Parts:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
>
> Best regards,
> Ahmed Karaman


--=20
Alex Benn=C3=A9e

