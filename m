Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBC5C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349E920872
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JIkR4/HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349E920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGdCe-0008US-F2
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 01:33:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGdBT-0007vs-Oq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGdBR-0002fI-V8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:35 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGdBQ-0002cq-3o
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:32:33 -0400
Received: by mail-pg1-x541.google.com with SMTP id q1so11432420pgv.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=8DKfZxjPpW90tslKeQhaX6xpSd5ENiccbyes80uD3MI=;
	b=JIkR4/HMC0fzWasOAhzM23Xy1Wx8mq9EVrcBNzv82iyt8u6lOhDsgDM9xkP3phykVG
	g3ZzKwozAVSy5rDF+TpeUi1vfqgCl4EYa5BWS9PPrzOSma8rSHuRWf6LWhJJycrd4k+H
	GO7/1GPU3GX3Kcpvc4UbThjJPjXedKckKlLLSsOHphsW64wtE6LMB2T54yb2D2vDjxZD
	VSSdVMv0LsEUUv0bxfPGlCzVo+Se4YMChpd0KUV+mRp1MUUD4k1nL3Unn639s0jLLiJK
	fJalj6K3eSsZZFRWGQXxOEeAL+EQgPuTzMV6b1Q97fzWsfS41v0YpPiJ2zc352nArWk5
	74Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8DKfZxjPpW90tslKeQhaX6xpSd5ENiccbyes80uD3MI=;
	b=VjIcwfAihVxi56ocSxxn/ICdcsBYNe3zI2No2KAWFVm+MQqheMiqiBdirWe/cuhEO/
	E6h83cw+tM0r+aCTVafYR2Iuxj7Vt3kXO6uJDj5LgbwY+7wlvlBCw9vYX1NrJt7hBj64
	zH40/VR7xjuIR1reMoH3iC4Dx77Mp9i58sYGGnS0636F/WLnzfujB4QnaagHtxc/MZCm
	kZstgmo9KJHpH3P7/KkX/Ow2bn4osGIj58Kzohb6rLT2gN5RYHWokvTGSnUAulCq8zwe
	t0zDBaNmath0VVVPC4k0fFjTRqTMM66+AiwYh8/HKVZW4i34gOXRQY61vcZIL6gGvZGx
	zNew==
X-Gm-Message-State: APjAAAW/CmCDE+KNlDhIV+M9EQPbyIUUuWuWMK02j8F0L4GMXd10rGnR
	ggvEf61TVMz13np3290Cq26gQaCBVl4=
X-Google-Smtp-Source: APXvYqzLIyE9uhWt37O9rQgxQ7/JOggfU1vtYGblXAj9DxR1CfPtnePtIJabhWAnWp3+AqP7BXuUbw==
X-Received: by 2002:a62:1193:: with SMTP id 19mr85443594pfr.82.1555479148646; 
	Tue, 16 Apr 2019 22:32:28 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	d129sm84513383pfa.142.2019.04.16.22.32.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 22:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 19:32:24 -1000
Message-Id: <20190417053225.27505-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 0/1] util/path: Do not cache all filenames at
 startup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417053224.S4CwpOzMeFBlbJs2mWjFKBsf09QFPrlKGfKtQgDFxZg@z>

This is a third variant attempting to fix the problem of
the -L interp_prefix handling not coping well pointing to
a full chroot.

Previous versions include:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06592.html
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07304.html

Both of the other versions keep an open file descriptor to
the directory that is interp_prefix.  While this seems to be
efficient, they also leak a file descriptor into the guest.
This has follow-on effects on the emulation, causing failures
e.g. within the LTP testsuite.

This version uses only string manipulation and access(2).

A plausible criticism of this is the mutex and the cache.
Are they really needed?  I have no idea.  I can imagine
removing that is actually more efficient, not needing a
lock around a shared data structure.

Comments?


r~


Richard Henderson (1):
  util/path: Do not cache all filenames at startup

 util/path.c | 211 ++++++++++++++--------------------------------------
 1 file changed, 57 insertions(+), 154 deletions(-)

-- 
2.17.1


