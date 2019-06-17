Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B1C31E58
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB0E2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 10:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mV9uNmiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB0E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcojo-0005mH-4S
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 06:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcoi0-0004r3-G6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcohu-0002fJ-Co
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:17:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcohu-0002dM-4V
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 06:17:46 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so5945361wme.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=U2LUWpqa0Y74pWJqAauN12bqJvcWstdQ7/a5GJqc8WM=;
 b=mV9uNmiWN+W5/5G87kCf3uUloBmYsm1DdFEFqZmNPE22Qco7eXtX95WaU/LjbZ8t1F
 vgY1bk51A4jb3TRdv3YXT+TyJgveXjdSrlGRAqKC0iGUEm6jBcs64qQ8whGh+irNsV0O
 pCAwTg4YNs6TrCt836efyblqnvzCxp4Un7ODUP7C1EmwGWdIjx+f49+rabomokwk/z9L
 HwPlfy6NubRTpJk6PWaHoOhJFelQ3z514zh+ZeXfdid14eRAXDEJ1NhkK4AI7+tfW76Y
 8Tht31FX7NBOxjtEp1cCQXmLP/sKcwYSedMClpoF10JE8r8jNoZUL7kJPrXZgpztYiDC
 8gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=U2LUWpqa0Y74pWJqAauN12bqJvcWstdQ7/a5GJqc8WM=;
 b=He5cOquo+sJKDrmuNi2hieX5JqSc/W58knVEwUKoLk+kpJ5YfVryD2Xz7OW1/yGBtr
 Bsj6uCoRIdkBrifRd6HEMNcRJo0OjPuWjhoqaftncgTQB+tQUnnbqwtdw6wxQTgoDnxk
 wW9v+xglsXDbAVzGngU6eStWAs5IWcgT8/CNTmxqh1f5cxnrjPWEFkDmE/4Gmt8+I0BC
 jldoeIHu0vO3gGd1jJYYMMZKOjVwaLvI1sGECwn7BvtkfJoO9Y6Z+E9REkr76OGuFXsF
 IPrSZ7kxike0HsFAwaD3Hc1Uew8ekhDoEamsBD32TjJvHmw9HrrT4QDaUmjhDiyVfmUW
 /ZFQ==
X-Gm-Message-State: APjAAAVfv1iPF9zSMGp0F1ZHnZLB30j0TejdAOPnca4/RvJNt5AS60Y6
 tADme7yObU+A1EswWQfBSMA5t5yLQPU=
X-Google-Smtp-Source: APXvYqz11kAjqNxBJLzDWPRUPi4glXCIxnSdGE4zWKxKGqqljWxIDxBOi+FW1LA8W+MWvDtSPjd2xQ==
X-Received: by 2002:a1c:5546:: with SMTP id j67mr19225812wmb.80.1560766662969; 
 Mon, 17 Jun 2019 03:17:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y184sm9273955wmg.14.2019.06.17.03.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 03:17:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E4401FF87
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 11:17:42 +0100 (BST)
References: <20190614135332.12777-1-vandersonmr2@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190614135332.12777-1-vandersonmr2@gmail.com>
Date: Mon, 17 Jun 2019 11:17:42 +0100
Message-ID: <87h88objnd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Did you explicitly set the patch prefix to qemu-devel? You don't need
to, they are added by the mailing list software.

--
Alex Benn=C3=A9e

