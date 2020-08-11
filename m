Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3B1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EAA206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bITdAiXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EAA206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5PrV-0005As-TV
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 04:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5Pqp-0004aG-RA
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:41:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k5Pqn-0003YV-Qt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:41:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id f7so10685225wrw.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PNxZJ++l5B9qISNQ0yTWxJkw7ibHoA6AzoD+QmJosb4=;
 b=bITdAiXN4MH9156lfhY9T1YYb/+1KE1divomPo4fX6vfCua9yQDz1ZRmsq3wC2bGVQ
 Sc1YSG1E4irCAKwp5UxripgHteRSzYxYS2CExo1PfQmnMCiS88iWZAbULOo3mOnfKRBk
 foGnhsR8QC/FqklLkGop+Z5v070Lzg5289ZnpurosvuA5SzpCijUK7MENBgjJdK8VZPr
 cz2Yy6QQwxzpBjwR0SeSWQyO7l5WXlH+wGQGEiU7wTWI5lCgNZMV/VV8E91En4MP+GY3
 j1pm0RTDCxd1C18jUdsVfL2r7c/x1mbsFh/OGzJtOoyWTV06rarcZH8do2LxqsEFk9qO
 +b4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PNxZJ++l5B9qISNQ0yTWxJkw7ibHoA6AzoD+QmJosb4=;
 b=kQecFD436RBMxDn2RdDGG/faC09/Om0pnDmqH/4b5j8iqIWOuRsJnjLbS2KOLVL+7H
 wqdqixV1JY3M3Cb2LbZBbp1yeNGz1/BRlCv9KdxmWrZkOyitZ7txjomQWclbqtNFDt5l
 sUqb6JqwHj1UFhRxMiED2oU4oSFrIv5QP+7IdAy87kcBKMR5SGHATqcvLFsf43+/U5jm
 bgGYi7Ohf+KvcX2U6iBj4BvmpueDw+qxfl9tF2ngf2L/wMl8yFfZYzY9dqI0ztmqEi+q
 sorb3qvVhL7pBWMFLi1M9z8z++l4AVlSglqhaxwZOP9ASP6qJ5gl38ABcR+BH3V0xax5
 WwRg==
X-Gm-Message-State: AOAM532lQ5BPOLX6tEHbe3fUmujphMw2+OnYgAMefXMoXFq/Fv3EaBUw
 t18ibNDpWogGJQKcu9k1dJDQ7DVIsks=
X-Google-Smtp-Source: ABdhPJwxgYJkxEqoWdCsXNP3FZfi0wFEcUrXShB60X/IZDoK9FS1VNeMxNsVEbFN6GovnMKOyk33Bw==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr27847709wrq.261.1597135299844; 
 Tue, 11 Aug 2020 01:41:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l11sm3831567wme.11.2020.08.11.01.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 01:41:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EF7F71FF7E;
 Tue, 11 Aug 2020 09:41:37 +0100 (BST)
References: <159670025270.3099.13280483088179052036.malonedeb@gac.canonical.com>
 <159710866585.21858.2925254319092162760.malone@chaenomeles.canonical.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1890545 <1890545@bugs.launchpad.net>
Subject: Re: [Bug 1890545] Re: (ARM64) qemu-x86_64+schroot(Debian bullseye)
 can't run chrome and can't load HTML
In-reply-to: <159710866585.21858.2925254319092162760.malone@chaenomeles.canonical.com>
Date: Tue, 11 Aug 2020 09:41:37 +0100
Message-ID: <874kp9377i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Tony.LI <1890545@bugs.launchpad.net> writes:

> Hi,Alex.May be you are right.I don't understand what you want to express.
> I don't know what causes traps.
> Is it caused by software, or qemu executes CPU-sensitive instruction simu=
lation.

Does it work if you run:

  taskset 1 qemu-x86_64 google-chrome

--=20
Alex Benn=C3=A9e

