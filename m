Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D49C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4482082C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Coy/J89m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4482082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrW0-0000nI-4L
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53080)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcrSa-0007S6-Uh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcrSV-0003nZ-TJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:14:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcrSU-0003gm-4y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:14:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so9204717wme.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PPmM+9GV0E/DlmZo9iVCSMR70e4fhaHBCAhnWkxZgjo=;
 b=Coy/J89m3I3fRB+ougfX2sZI7dqM5soFsG2sWeUXEgIqMAHrGAu2ol1Fx9w5zEqmvk
 va82F//oCkbFYYRIK2gFDZm7Og8oQO+/OlfjcN1+zprUFclQNQGJYBpxiY+yvBg6JVwe
 TbBbyNJVcuy77FnqhVyiSSHOB++vMv4I94xFW2kF7KrToteHKAUSQXBOUh1J5Z1gyLFf
 ShPeZ7zZLK8jgDD2cbD3i/7ZJRG9hPpoj4yhSBYs4A+KdsAPpB8OPTGhNC8SFVcg0dFR
 bl48/8Hsy2wtoWN1PJgPuwv7Y76MqelBlMDW9sglA5jWnR8AHciBJ8LXuTYgG5gSN8pL
 eVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PPmM+9GV0E/DlmZo9iVCSMR70e4fhaHBCAhnWkxZgjo=;
 b=Iqk3u9Dbphu+6Y3NC6MvKXpXl2dDyYHbRveggozgXMJUmjLu1tLqcT6Y19wMoJbuHG
 7vnQmtB7pO4GMOaK4BkOrM1s9WcC9zu79clcVyInMp2Ceay0D6JUZtjPNiYTdYFoSulq
 byUh+BPncC2qLJFyKmqBEdYO4eVFMiqoTPevz8lVl1rjzwyqTrSm1t/6xvMwEMNkTNCI
 dI6ZVUZ+u2lWpkPw6eEjW53L1YABHohxSXiqcnDbIBQYEEd8VZ938+3TU8eh3zbOl+am
 aq9tZRNRc11LtpLQ47I5ws1nnEkY0OyIjVbIwy6mhiNsGQvYXFVSaGgJKqY8dvDBiWQf
 r2hw==
X-Gm-Message-State: APjAAAX2tbVzp72RuBCKEYgAmLXMLlXuENvCjE3HKSiSLEiWLsnyR4Td
 cYoRzFuEIeM8lsrQ/GAlzg1MvNv922Y=
X-Google-Smtp-Source: APXvYqy9kWTSjb4YL9layrlRwQoPNznNchmsKbY3jY3IVsuSA2p6bSX1utaDxAJmHHyWcTtElcTsSw==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr17946733wmk.99.1560777239926; 
 Mon, 17 Jun 2019 06:13:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 11sm14198054wmd.23.2019.06.17.06.13.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 06:13:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D591A1FF87
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 14:13:58 +0100 (BST)
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190614135332.12777-1-vandersonmr2@gmail.com>
Date: Mon, 17 Jun 2019 14:13:58 +0100
Message-ID: <87zhmg9wx5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 0/3] Collecting TB Execution Frequency
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


vandersonmr <vandersonmr2@gmail.com> writes:

> This is the first series of patches related to the TCGCodeQuality GSoC pr=
oject
> More at https://wiki.qemu.org/Features/TCGCodeQuality
>
> It adds an option to instrument TBs and collects their execution frequenc=
y.
> The execution frequency is then store/accumulated in an auxiliary structu=
re
> every time a tb_flush or a read happens.
>
> [Qemu-Devel][PATCH 1/3] Adding an optional tb execution counter.
> [Qemu-Devel][PATCH 2/3] Saving counters between tb_flush events.
> [Qemu-Devel][PATCH 3/3] Adding command line option to linux-user.

One more thing:

  https://app.shippable.com/github/stsquad/qemu/runs/866/summary/console

The use of:

  uint64_t exec_freq;

breaks 32 bit builds as we violate ATOMIC_REG_SIZE. Maybe we can get
away with uint32_t? I guess we need more of an idea of the range of
these counters are likely to hit (and maybe detect overflow in the
helper?).

--
Alex Benn=C3=A9e

