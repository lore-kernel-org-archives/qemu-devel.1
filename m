Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C114C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57964207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbLSs1Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57964207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0un-00045r-63
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sQ-0002V4-Ld
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sP-0007Bg-Da
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:36465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0sO-0007B6-IK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id y19so19897755wrd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=TbLSs1BsHYuLOGnWPf/dhEtyADR1Rgj8OzmXIHp3Q0m3HBFcsmlD6Dc1trBT8H/Eg/
 fChdJo0lVt7g7GG69VJYvi6YvsfMD7ej5PDqycKOAQLhyc6zRkUfbG0OWM6fixLeObnA
 cYPYtTme7aL5oURaX4YvhU40hM4OTWvWA1ivS8jpxfDexL2PKbEJ5WkZpRZXV3jnvS/4
 fj/CsGQPEi8B7K+nYuO5E2SrvTM29imZ1iUyJvREMS67dbn856y9Pqx24xqndJzCPacB
 TvVNN94xteR3SzV77pQED0OSuDzsbamoJVOLXAtowvvaeaCTfnUHJYGi7ZRcbhqqpi5i
 B96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=X6JmbNPcDL4cs9Y8c7w/BG/ryuugTdYe4WnpZvAd+pKEJF50B9YbXlBzhgucaeizC0
 MztA09O9mELzb733Wl0HJKwLTEmBmlptGJJZg5DRDZV0hxjOyJHOSaaDEmcpQjJaRTpv
 TykagZiEAHDxmkJe5EdkS+NRDSHkvHnr+eBhedanUI1KdXn/c2NnLsFQ1RS+fOTT5X9x
 BOwolBVz8RfnFPagvBgbYdhZSv/26N+Ns7a21vZmjUjVwgcvgaSoPkdCfIBbbe1InCWM
 9tuc106B6khGSifid1gQHEXG5GEleSzfToTsvoeSxGaOiFpEsaa1Uv2c1+qYk5KuZzsl
 MveA==
X-Gm-Message-State: APjAAAXj7BTPGjZHo+LrgBCM97XePR5LSoK0p1XVnq+zk0v5LomWUPa2
 Q3vPdI4pUuZrPfal2i5hPSL6JGc7Qe4=
X-Google-Smtp-Source: APXvYqxqtM0MkyHgd4ABntnSN0B0P89V8XgUbo8EwDnVZdSZhGLpk5j2IYu5Rew+53rRtoZrAptSPw==
X-Received: by 2002:a5d:4b4c:: with SMTP id w12mr7476242wrs.107.1571061547243; 
 Mon, 14 Oct 2019 06:59:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w5sm17391076wrs.34.2019.10.14.06.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:59:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31B7D1FF87;
 Mon, 14 Oct 2019 14:59:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v1 0/5] gitdm updates
Date: Mon, 14 Oct 2019 14:59:00 +0100
Message-Id: <20191014135905.24364-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

With these changes I get a reasonably clean set of stats going back
two years and to the top 20. However most of the individuals are pure
guess work so I won't submit them in a PR without positive feedback to
it being correct. If you want the numbers to be correct by the time of
the KVM Forum QEMU keynote now is the time to let me know ;-)


Alex Bennée (5):
  contrib/gitdm: add more entries individuals and academics
  contrib/gitdm: add MontaVista to the domain map
  contrib/gitdm: add Andrey to the individual group
  contrib/gitdm: add Bin Meng to the individual group
  contrib/gitdm: add China Mobile to the domain map

 contrib/gitdm/domain-map            | 2 ++
 contrib/gitdm/group-map-academics   | 3 +++
 contrib/gitdm/group-map-individuals | 6 ++++++
 3 files changed, 11 insertions(+)

-- 
2.20.1


