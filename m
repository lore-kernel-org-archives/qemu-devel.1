Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B236C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BA420673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipfEL11j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BA420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8su-0001n9-Dg
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:12:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8rk-0001BH-Sn
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hL8rj-0003qM-Ty
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:52 -0400
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136]:40012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hL8rj-0003pL-Md
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:10:51 -0400
Received: by mail-it1-x136.google.com with SMTP id k64so9777174itb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3t8thYSykPOt3evLHsj2Me359Tq+7SnvH1AtuRkDAoI=;
	b=ipfEL11jzs82Frpm2omtLpEsaA1SdoRmY+4+TNvIR61IAc1P+qMU+QHQRI3mU9pn+P
	0amqrspqXgsag1eYZXPzeZ+8RyrNdx+Y8vpgZv9v+GBBxa0Mjd8oRGEAkPFQlVRtoMOw
	KhRDyFvorEAkA/vBib/03XVj+5sXqF8jAlvz1avQMGDLao1n8MBLnNjfjKuSEXpoP1Zh
	rvi4yFEN5sIjD+JLWDz6FK5pIa4BQYz/0mA3UTjYqA1LEhL5irBE6qZ+f0anBWVYs3VP
	xn3RIE4L3+WodCHBnqyD2LsU87UDYiRk97Is5ZHq8hjzebUvXmmlUBlu5Rw6GAaPRnhj
	2diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=3t8thYSykPOt3evLHsj2Me359Tq+7SnvH1AtuRkDAoI=;
	b=dlcNpHqLvQ9zMQVApnT5PVpzgKd6s/MIou8BMiH5wVHlAEpA5jdyb3yC+o8sZbT3fd
	tmVDc3LnZ+oQWH/nBA2RxeaIYM+Bt0FGBeLm1Mza0yRgqK4qaLCsi8erwi1kgRTYKzLI
	ki75wJihjLax2k6gVC9vCkQPFKQK57iGlC60bJLTwIhvzuOYiOyEDJAxvYY8hAsny3p7
	bZZHJFA1thO4hk7MIrMu72Mr5Z362Sba7mtB9AhcSCcGAeNdAHWFzzK0l1CHFEyscfkT
	xQL51FRxFNWYGkmhX+p/54o3CBOdRNX9RpwfNd7v+kiqy8yiPnmWOMU2Vm1Hh4J5wYe/
	+gNw==
X-Gm-Message-State: APjAAAWzyoc7kGXuU6p7OyZa/Jj4FmTHqOJCtSs+717X7tiOodrpOIia
	lb1u5v7yrKTwjKS9iaYr2WCVqEGpktE=
X-Google-Smtp-Source: APXvYqxXWBFM0CKSf0BcE/68lR7YePynb5mh2HHBS3Caalv1d1lHcrTKLpkFkYNK66ZD460FYITeHA==
X-Received: by 2002:a24:4d06:: with SMTP id l6mr18718224itb.140.1556554249996; 
	Mon, 29 Apr 2019 09:10:49 -0700 (PDT)
Received: from localhost
	(CPE64777d5479c3-CM64777d5479c0.cpe.net.cable.rogers.com.
	[99.228.64.175])
	by smtp.gmail.com with ESMTPSA id 15sm16278734itm.6.2019.04.29.09.10.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 29 Apr 2019 09:10:49 -0700 (PDT)
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 12:10:45 -0400
Message-Id: <20190429161046.10527-1-stefanha@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::136
Subject: [Qemu-devel] [PULL 0/1] Tracing patches
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429161045.0CujDOgrgt9YSkhCOkuTiNcluRimbawjdI0VPyz2IgY@z>

The following changes since commit e0fb2c3d89aa77057ac4aa073e01f4ca484449b0:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190426' into staging (2019-04-28 11:43:10 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to b1939fcd438b7140cb8f2685dee026bb112819d7:

  trace: fix runstate tracing (2019-04-29 11:57:19 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Yury Kotov (1):
  trace: fix runstate tracing

 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1


