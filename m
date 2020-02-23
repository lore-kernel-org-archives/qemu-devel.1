Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF99C35673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1E920880
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FogAYnP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60Pk-0002hD-Ss
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j60Oj-0001Hr-UQ
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j60Oi-00089N-KK
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j60Oh-000885-Vp
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582499451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2JtFWCLlvKrPzw6359S9afKJXhhVBFgj6XfWSRDbCzY=;
 b=FogAYnP4osWlAFWRv+rP2WmXRzx1usCE+adUToT1UaZQu6DX8cFUr8PTRaehc7nlpqc/yG
 3gvqBx6JtXTKHedT6ZZDp2TNs+rhzIC6bTRYiE6LoYt4g+VasfQpiQJs4uprxYgiZACm3/
 q48r+q78tQYzB/xJSfsU7g75nM/y0Yg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-lAfzy-ciNJa2VvsI_RdcGQ-1; Sun, 23 Feb 2020 18:10:49 -0500
X-MC-Unique: lAfzy-ciNJa2VvsI_RdcGQ-1
Received: by mail-wr1-f71.google.com with SMTP id z1so977276wrs.9
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 15:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=r73RMxZRMG+NmOKyR3pA63JKzPvw0kuX26+4+fo0u6k=;
 b=CuF/HFJNMONe5cJBailSN6+tz9XNTwJ8RkomHSy8Wd3Ngjr6qxbbrbIJPifWkvQPLY
 VFs8NvBNeYqtqUlBbI2YBwhVJk0+0fqJIulg5vGZLWrLM9YO9ne1au0UsvAOHYmM3wQ+
 tB/f1ojhjw/5eZz9o7BQsai3eumSOGQgDBL/ge/gFaQX44FHRuDTsUI7duAI1TzgfDh5
 iswch/U6W5w7P+Mp+qp2G5JVdv7NeM8AjGNagZBdpZvYYCKo1S7nULRtDMU2WPZV1veV
 xpDqLXeWaUQpQ/mWGIbXYUtCHJEe1OOf7mPnse/e6sask6yyiBqI+Fi3ormhDhXQdgxz
 kCmg==
X-Gm-Message-State: APjAAAV47mYeQA29NYR7qWbSvMaTxq+3GmxeSzYLLC521Z33B2XIwRIp
 vVeHy1sPTxciX/it8lrNBSyPsx9XBnAvVSyyBvTQvdJII6v2vmgy7/QfRsUdr6Lx9kkjlTjFTU/
 gD9OJjbirNF+onC8=
X-Received: by 2002:a05:600c:299:: with SMTP id
 25mr18350043wmk.68.1582499447906; 
 Sun, 23 Feb 2020 15:10:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwRR2QcjHY5wzv5ITqtwhlIu6dQ65kERAg2OHxjt7EdpPNvV+QAqS1dn4GqrazGjFTftx5m+w==
X-Received: by 2002:a05:600c:299:: with SMTP id
 25mr18350022wmk.68.1582499447603; 
 Sun, 23 Feb 2020 15:10:47 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r6sm15777598wrp.95.2020.02.23.15.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:10:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/arm/gumstix: Trivial cleanups
Date: Mon, 24 Feb 2020 00:10:42 +0100
Message-Id: <20200223231044.8003-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Two house keeping patches while looking at the Gumstix boards,
to make the code slightly more readable/documented.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/arm/gumstix: Simplify since the machines are little-endian only
  hw/arm/gumstix: Use the IEC binary prefix definitions

 hw/arm/gumstix.c | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

--=20
2.21.1


