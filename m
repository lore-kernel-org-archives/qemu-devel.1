Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E1C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4A72076E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgpiUYak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4A72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTW8-0001P5-Du
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPT7z-00034S-Rp
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:14:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPT7x-0004qC-15
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:14:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id d4so72875wmd.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=a+zcxgT0E/eSH6JMLqdnD3ozLr+S0HFu0zYdvnRIirA=;
 b=pgpiUYakXtMnettlRlyp8IDgevZ7a7FS+6dOeKkJIUSt7b2oXlzOOJUpKnpFhyXY2M
 OD+ZHB2m07mkYaL1hIjO3xjL66ZA4SAzFk1BCvtOoTE47uwfCtVY6rWkff1/6JYTIyVY
 W24ZJlb/W4ZPSikk9RZldyhgdlqd7vyrWIIhNA9pbIw7bT3kFTMhODqRzlxazLL67zAo
 LcvhvdgiXpI15Fn2H8oGP7p+Oc9MT7dPnPw3/MIhMqzzdhvjwGyThWdh3ATezNDtk1Xe
 p0w14lmbf1nFVuo0bgjWd/TrgcApuVsd8fJzQDE7YsZHqi0OMDuG1pWGdcqctPWzSLSH
 nrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=a+zcxgT0E/eSH6JMLqdnD3ozLr+S0HFu0zYdvnRIirA=;
 b=Zah+MHXz2Bvxlp8AyaStaWqWeQnOIZAeunZf6x8yWROuQsKDV1r+8pMBbL1uZ2zdon
 Wf98APt8sEzq2hXKTmg2CnrGPUkXNuiaUXBWbiaci1jYhDqiLfSqzwUDOHXzcTp8HID7
 wjoEonqIBiG8C0RmDRowUruEL8OjjP5ed7KQk3Onir2VbLYzDReWDvMuPJcBmKsrkzZs
 99yCEExuqmhERolk4fhTdy8htE1DPDb2LQKg7qe1rpFllzzDSGBmUn7t2IfQA94swfm7
 8pxFjkPhrreoYfzFhfK6soYZplV16w7L7BwAUhs+xwNx/IsbbajxVQ5qi5z1byvzut2S
 k5IQ==
X-Gm-Message-State: AOAM533EtL+Ck+XyTmZ3C7OvZS20jA/mVM06+DG6MVwPayH41bVg5CDz
 XssBlLFSDo3sirL/zHaH9uNMnQ==
X-Google-Smtp-Source: ABdhPJwYbm0A6wH4Pf3Hjl9Dht9no+bQVg7fNyBtgXQfyvxZp9HgvAv1dODN2knVi09vBWoNVhpoGw==
X-Received: by 2002:a1c:bcd5:: with SMTP id m204mr171538wmf.26.1601914455109; 
 Mon, 05 Oct 2020 09:14:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t124sm66603wmg.31.2020.10.05.09.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:14:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC6671FF7E;
 Mon,  5 Oct 2020 17:14:09 +0100 (BST)
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
 <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
In-reply-to: <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
Date: Mon, 05 Oct 2020 17:14:09 +0100
Message-ID: <87eemc3b1q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Julian
 Brown <julian@codesourcery.com>, Sandra Loosemore <sandra@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>,
 Thomas Schwinge <thomas@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> On Sun, 4 Oct 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> There is a number of contributors from this domain,
>> add its own entry to the gitdm domain map.
>
> At some point the main branding will be Siemens; not sure how you want to=
=20
> handle that.

We've already done something similar with WaveComp who have rolled up
the various mips and imgtec contributions into
contrib/gitdm/group-map-wavecomp.

It's really up to you and which corporate entity would like internet
bragging points. The only Siemens contributor I could find is Jan Kiszka
but he has contributed a fair amount ;-)

--=20
Alex Benn=C3=A9e

