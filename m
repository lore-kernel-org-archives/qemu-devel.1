Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F221C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CB120644
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKnBWZ65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CB120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJgDq-0002Jm-6L
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 11:23:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJgCQ-0001Mm-Pr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfyq-0000pV-RU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:08:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfyq-0000mH-JS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:08:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id w15so747290wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=a1bW0YfDvyiOU+XTEQwTwqgGChlogjSKSUy2zTYBGkY=;
	b=mKnBWZ650P0axDfjfYVcmOomAeVLNsXOHTaHjiyb8wtNG/6yXYB+9fpW1Rp6ofCBK1
	o61C9Y1vzHbr7gnQRJ6Z+1c0kGIm8/fA+bBcwCQqNmCVHi9MGp+6Zcffcqz8jN996HRG
	GtoGqN7PuXOdlwiwQ5+inyw3ldnB6QclQnzw8rErX+u2T9MYk38wquVCg1MBLJYLUiUn
	Hwe07j7ghtSZySK+LRX2whjIgDQX1y4FKod3VoizcoWlM9YM0uJfQb1cWUoWTKptqxCJ
	FTc3b+v4OZXYzSKnmt5eYejprIZ3GnZaQzXIh6o5QWRzSs1WFujUExh1YWSy7p6CYITi
	xRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=a1bW0YfDvyiOU+XTEQwTwqgGChlogjSKSUy2zTYBGkY=;
	b=AvafMcc3squh7upcrPcH28guC4DCf/V3WweKBXbRqio6pFZmRyd5YvWNMy7j93v2td
	nnX+GGPuu3jGlZvx+lKSruKcxAwy1vSmf2KUu0IfKYlXh/n5XysS6KdFpli3l50+0ron
	lnPLdonJr5fMibNCjtGF8q513jZx6dlxkjs6Zfg2L1CmX+M0Elu5J0VIuJRe53/xNndd
	htcPk9ltmsNyY860/o1hz3LPONZp7BmBz7i9UmZeDFeOwgsEp9zMZIkrcUifiVhN3lpM
	YfVI+h2IKgkyHrEpOQodtQIhzcZ3PVBIJcUcr7P2qRyYlZ255A9XhWcu8DCAwCYA2RG+
	/8nw==
X-Gm-Message-State: APjAAAXuVjCPr6jXt/UNQ2VyF6+svlX7N6ow/f7PEM9SwFux4uVLTC0g
	CLtQ+2Ql3MbDO2L5LggMFekljA==
X-Google-Smtp-Source: APXvYqyYSJQD6EEAfDOy/9GQMDRS+J/f49Imkc9/tswIdSGnSHQS2bsIBtQDzQ3Q8n9+21aGheqF3Q==
X-Received: by 2002:a05:600c:2206:: with SMTP id
	z6mr3942970wml.36.1556204886501; 
	Thu, 25 Apr 2019 08:08:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	v16sm17809566wru.76.2019.04.25.08.08.05
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 08:08:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 364D81FF87;
	Thu, 25 Apr 2019 16:08:05 +0100 (BST)
References: <20190425132636.31636-1-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190425132636.31636-1-arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:08:05 +0100
Message-ID: <87o94uunqi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v6 00/21] gdbstub: Refactor command packets
 handler
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425150805.QtMxangRBvsfZ6Ayigm8ComfgvLP5Hrck5KS-lN9KmE@z>


Jon Doron <arilou@gmail.com> writes:

> This patch series refactors the old gdbstub command packets handler
> with a new infrastructure which should ease extending and adding new
> and missing gdb command packets.
>
> version 4-6 changes:
> - mostly feedback from Richard Henderson

I admire your keen but I think my comments on v3 still apply so I'll
wait until the next iteration.

--
Alex Benn=C3=A9e

