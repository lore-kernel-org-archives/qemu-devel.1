Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83057C004C9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A5F2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asgfMBOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A5F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbZN-0006vw-0d
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:01:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbXx-0005oR-1Z
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMbXw-0002F8-0A
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMbXv-0002DC-Np
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:00:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id d22so1605854wrb.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=EIi4K2dkSBbuhfS2t70Kzgd4m/ZSCWhAQBd5+AA+hJM=;
	b=asgfMBOtomdN8aCDKZAOO2DEUwKq6iVGJhawyklo26ErrHVll+FJ2+FRuBNNkVXEGB
	sU3QFqn3uUQoDWtagpo+UJhXTXRIt88XswZWOAay+ZuGxQyYvmq83smE5X1yBHIKXkB7
	BO2wzFFhJpcSMsuC6FpzS/DZmgTykz6+hAuyzWYbsH8N1pokdlha1FrTigJVMxm3R199
	1JdZgYPv9SNVfEy3WG3cXe2jW34hHZeK+Ixg4KHrymekq7nrYa9Xl6wZbNkagLzftekh
	rADFpkxonWLnYTs4o/K71pgPajX7UdPCk0WLsxAkBPGWlVhk1IzauXK4Qc+FemG/em8x
	hTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=EIi4K2dkSBbuhfS2t70Kzgd4m/ZSCWhAQBd5+AA+hJM=;
	b=K2C+SD9CqqQsRcpM6Bqy/jXf3y6BtWMpUh83D7mxk8gFmuzt44srttTk/pFS3rq2td
	/q3yb/BKNBE9FQnCr71yAGx58HLgTcg1N8GgzXzmPZRX8Em7Z+Y++qdRF223Ig195XjA
	M5ZWtqQrG9fxAAMIrafePHSbcw60CAbOuBVVKRuuJmgoN10WX1vmokJqiHveMLhD3WSy
	syfEajngqHmAwjozXZIAsSrpmlVtOXZYU7Z7UrNATBaRsx5YWQbKXPAeZyQC8/mubWrh
	Yf8H1wcgHklBt1mAWWksFBaaFNuJcLQ4H8Ew4E3uoU0vxu1rbmPE7VF0Yl1cwTnMoiLg
	Xh+A==
X-Gm-Message-State: APjAAAUtM+byfaQcd1OH3wzdQRG+qvYyfAeWV0ECIiVJgQIXqgVa5aI1
	Vm5LBDVuoAliB9dqI4yOdSE1sg==
X-Google-Smtp-Source: APXvYqxB3Erbn6n5CoH9GnWhM9Q3MK2m5U0VE1h4JogAF+x0D2VP4DpbSNtj3FYRo/dcJJpZF5Y6nQ==
X-Received: by 2002:adf:e74b:: with SMTP id c11mr1351828wrn.221.1556902826282; 
	Fri, 03 May 2019 10:00:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id t67sm3935497wmg.0.2019.05.03.10.00.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 10:00:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5DDBD1FF87;
	Fri,  3 May 2019 18:00:25 +0100 (BST)
References: <20190503154424.73933-1-liboxuan@connect.hku.hk>
	<87bm0j4im0.fsf@zen.linaroharston>
	<CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "LI\, BO XUAN" <liboxuan@connect.hku.hk>
In-reply-to: <CALM0=-=b+z2aW-cuM=hmk3_oKG7w3ianMo_ZA7gj8zMgCOfC3g@mail.gmail.com>
Date: Fri, 03 May 2019 18:00:25 +0100
Message-ID: <878svn4gnq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF
 to trace and log
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503170025.nviJ1pl7_Ga4Q38ZSwgqpNBzc3lRz8DZ3gIQOgoEDIA@z>


LI, BO XUAN <liboxuan@connect.hku.hk> writes:

> Hi Alex,
>
> Sorry about that, I am still trying to get familiar with the patch
> submission process. Since my patch has been changed from your last review,
> I thought it would be safe to not include the r-b tag from last time. Will
> take care next time!

That's ok. As a general rule as long as you haven't substantially
changed a patch it's safe to keep previous r-b tags. You can always
mention it in your cover letter if you are unsure.

--
Alex Benn=C3=A9e

