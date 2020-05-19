Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C661C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 00:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0622620674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 00:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXEuH3Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0622620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaqbN-0003sg-5y
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 20:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jaqaq-0003Td-Sa
 for qemu-devel@nongnu.org; Mon, 18 May 2020 20:58:52 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131]:35561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jaqaq-0000H4-6n
 for qemu-devel@nongnu.org; Mon, 18 May 2020 20:58:52 -0400
Received: by mail-il1-x131.google.com with SMTP id a14so6442718ilk.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 17:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cfZmxZ+groUUVJ1iCLl8NYHviHaY+ORM+bSc64TkRps=;
 b=WXEuH3HqTBUCDqOXlQgui9ewQhxIOv6q9Tydu6HPeytqzxhgsjYy2p0swer9TPpstt
 2D+vOa0JAYwxev0gNsYL9+LEDzADBenX/PS2MirjNuDnOzSnFxYUkRHRhQhSWQTpcspa
 Y/uyOO3Px94R3wJZj51Ar6e5zvKKrqgjHqDkVknQ/65Ztzxox3EjanCH4B30JxSzumkn
 V5jub3xWFqkANoKzSxT9s1Q8ipAv+WHxVJNNvdlhFIUGyn/+I+XgXXVaYUwGiAgXViXC
 g0G8H8xdoBz/YrSjf0+jd37tpj1+x1vPt3JGhA4q81UiGI9bUUtvp5TpSApyTZNkdica
 BGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cfZmxZ+groUUVJ1iCLl8NYHviHaY+ORM+bSc64TkRps=;
 b=SB2G4DJei2bAj8F20D4Nzj/zr10Gnw+nWovtdvxKs74tQZhJ2FI6STgfGvaGQ2akz7
 fNO/0eCZmu1ABBvTGDIeV/Ddnn4QYbLuMyMqRD/TlnRAfq9S5S9VpQ1jZR8SqX24G1gk
 A8z2N2iX1gSSb4W0/F0wY7Rnpb4TuMaapLxG1awrx+m4mPFCly0Q6RdGllbodl6kp4P/
 S/HjHxRFsYL+BxSDUbQcVyG3JRWL+AghNXiG+lY874LjVHCK54sVaIbfwVx9Pgl6rlQE
 XGbEvkomkHuWXUcEQ7OlZTK0KcUnHBNivquUNNoVKgZFlt4/jMiAjIHE8ZB0MEiewTSK
 LcAw==
X-Gm-Message-State: AOAM532+fMSrVHCoSSnU63UDLPRj2VzZ19oMjFU227FYrUqItC47uOFY
 bscdEZsxafeor0ocmx9Rw2Eg5d1eUjMnwlvfYA0=
X-Google-Smtp-Source: ABdhPJxIxuNhZrYxsJ+rS7EW0gx8gel+ruFQESl8pk6xzzeb7zosq7VTf1QgW+HDlMvyYOC7LpY1BP4p/oRtSG+/FN8=
X-Received: by 2002:a05:6e02:1147:: with SMTP id
 o7mr18972384ill.51.1589849930951; 
 Mon, 18 May 2020 17:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <1588417318-5055-1-git-send-email-raphael.norwitz@nutanix.com>
 <CAJ+F1CKgxZPjm0C9mV8Y7S6vLY+m+6oTJpgJj3ieUuerGcDESQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CKgxZPjm0C9mV8Y7S6vLY+m+6oTJpgJj3ieUuerGcDESQ@mail.gmail.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 18 May 2020 20:58:39 -0400
Message-ID: <CAFubqFuHb_SG5YMcXw2-XJGEAvmn__8j37O83AgxYc5Ewsi31Q@mail.gmail.com>
Subject: Re: checkpatch error checking target arch in libvhost-user
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x131.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Can we make it a run-time value instead?

It's definitely possible, but will require a bit of refactoring. How
about for now I set a reasonable maximum which is supported by all
platforms (32)? That still increases it a lot from 8, and we can
figure out how best increase it even more for other target
architectures later.

