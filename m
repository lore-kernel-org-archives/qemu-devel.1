Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 07:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E1C2071C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="US+Td759"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E1C2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcOmH-0001xm-B3
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 03:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcOlj-0001Tv-SB
 for qemu-devel@nongnu.org; Sat, 23 May 2020 03:40:31 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:37027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcOli-0006bz-O5
 for qemu-devel@nongnu.org; Sat, 23 May 2020 03:40:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id l25so11027264edj.4
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hlYL9T7F9kvacV1f/5nuEoE9+UWF48TmJmWOs/xVlcI=;
 b=US+Td759dc+jUUvYsv3qtCNPuUjNlp2eb6CRD+uzzGbR24wSlQkL28JU7iYwOYHXmC
 gYmmZaZy1ygyDAf00hXmljH+jcUfpdXaJJzov9h58VeT5F+ZkEVVo2NuOlR9S2QaSj1n
 V2ZWAKrwkHANvIMAU/mBNbPub3ezEOUxhrUeKtBaOjE7z2FOue7joyJPJQjpVbUr8kBC
 LKI5QdHPIjg0gz3HR2D5OIe/1f1CpiMW9/VMQ0vQMq+56b1bkGSaMbt4BckYbsY1dsEv
 i0XrWaGG7x4oGXTph8ZR0w1lhCcTDveFZmvPmYb2z3GDqFtwH40pyFfOEhoPFt/nhppT
 nKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hlYL9T7F9kvacV1f/5nuEoE9+UWF48TmJmWOs/xVlcI=;
 b=h55vsoznT+rtTpQhiyRVceeEAYr0SkmjFOKM4RayTM/8nWQJIWV/3LWtGYJXcjhNiK
 W3n3RwoyhMD7oupNVxou5TTgQiVDzyzpfNIC36UBlhA5K0Vf8gqy79TRg9+WQRD2jZK2
 wRpliJXeEcjz/2yfeEkMUAiltP3xWkLqmx0N+SQQXVtU+lxZ4Zhl72CzSz6m55Q/Y9Aw
 6A6nYqd+FctDFIYk/70iRCziuULApJiFu1EaLTDOU0DOonoUGMvoYBuQSlDnJNE3/9J7
 TC4qnnAbuj/fxr8OxBBotec3ffhYMG7URZtV2lqENpCcteUjm0MQQaZOOkHFGtenNUyV
 oiew==
X-Gm-Message-State: AOAM532iaXeyxEb+Gwfb3jOLEx9t2iY/XQwbnjph3u9RSteLHCxYO/g5
 2VY4nWhfySOxtkBhsSmJxeIsKpwTPMI=
X-Google-Smtp-Source: ABdhPJy/8Z9QFcAE2kNzHU/C2nBc6215WWDGKwzZlZv1V/cYHmIV8UrpmH0C42NqtNKF+aYpArgwBg==
X-Received: by 2002:a50:9f66:: with SMTP id b93mr5802786edf.376.1590219629108; 
 Sat, 23 May 2020 00:40:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b13sm9350890edw.50.2020.05.23.00.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 00:40:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E23B21FF7E;
 Sat, 23 May 2020 08:40:26 +0100 (BST)
References: <159017301531.7966.9120113243897778171.malonedeb@gac.canonical.com>
 <159019649466.20452.12164074661904513625.malone@soybean.canonical.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1880225 <1880225@bugs.launchpad.net>
Subject: Re: [Bug 1880225] Re: Emulation of some arm programs fail with
 "Assertion `have_guest_base' failed."
In-reply-to: <159019649466.20452.12164074661904513625.malone@soybean.canonical.com>
Date: Sat, 23 May 2020 08:40:26 +0100
Message-ID: <87lfljrted.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


Aleksandar Markovic <1880225@bugs.launchpad.net> writes:

> I just want to stress once again that the test was performed on a 32-bit
> Intel host.

Ahh - OK that makes sense. I'll see if I can replicate.


--=20
Alex Benn=C3=A9e

