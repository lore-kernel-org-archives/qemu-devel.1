Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D650C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49C520575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="s8cPh37c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49C520575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWljD-0003hJ-VH
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jWliV-0002uj-Eh
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:57:55 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jWliU-0002eO-Ca
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:57:55 -0400
Received: by mail-lj1-x241.google.com with SMTP id u6so7503155ljl.6
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kyBtveBgtewVFjsGm++IS/2pw4fUMG6lASXmIKyp8+c=;
 b=s8cPh37cL8qx4Rs7pDVp1oFvZKAXShfLtgE4wTdp5YbAbg/KW0MCE8BVGY51i/Fsnb
 P14F/aGEYS98yGUHpFLJYqtF8lv7iy+YEBG9BUGrSC7jqbLq8apUmgCd6q57LL5mCQ0u
 k7t2LkMW9rP+zakgRciiL4qTm7fy0Qi0iJ4FHKaiYhDcEfZGmOxntKXbV2uYEc7MFz7W
 6EN5idzH1bF/gs0pxXtNHWKy5xerbReHacIMQvIKKK3EKKusaYzRYoWst4lHdy16fG09
 TCcZuZCj7Se57Y1TzzrfLWL4bYRrLHaeIoEXeNgdH5/T+8S4W3uJxZG342vS/Ptq9xB6
 KjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kyBtveBgtewVFjsGm++IS/2pw4fUMG6lASXmIKyp8+c=;
 b=hWLhimxqTsAUO0LCel9eynvdy3lTRb/+xf062Ka1TozuTgMJ1Xac2FnHhzKe1+FDQu
 cDkDVrrtXgPUxRG3/a1BD5mTBBZvFE4eWIkBua/XFf16NwR4YD9Ym9OtvE0dQ78tVXrl
 WJkSxNl297rK/HCokM0eJ3GFysQLvMZqtNl4bc9WLH/5q1ZPQbg7XfkAFcHCZU1ldHSv
 tdl+j9kUqVvaGz/9Fs4qTwv/8S1VV/wxRfhkwB5S5edUU6gZDgC78ZykTfyIc1nZrOSy
 ysgouep9L+fE2g6mHT4E8wTEfFeiGatnIuIg2ajDGny0EHAIpyjjPIDycIe6waufWd6m
 w3Ag==
X-Gm-Message-State: AGi0PubGwk6x1Yoq0D/tZC7t9rbw3kN0IuxhH+pxZysxmjbcDdYU52mG
 otQ+/3SRYrEca/KLbWF0JRwsgySP4iIN2g==
X-Google-Smtp-Source: APiQypKGap/RQt3/mJdbZO/RP5PdrDRpt0g47epCB3AqdlabpZiGVYz7RCViwX5Y/y66YoyWktp+hA==
X-Received: by 2002:a2e:8753:: with SMTP id q19mr9463524ljj.6.1588877872295;
 Thu, 07 May 2020 11:57:52 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id f9sm4464065lfm.62.2020.05.07.11.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 11:57:51 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] hw/net: Added basic IPv6 fragmentation. Fixed IPv6
 payload length. Fixed CSO for IPv6.
Date: Thu,  7 May 2020 22:25:40 +0300
Message-Id: <20200507192541.1046225-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::241;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Compare to previous patch - fixed issue with compilation in docker fedora test.

Andrew Melnychenko (1):
  hw/net: Added basic IPv6 fragmentation. Fixed IPv6 payload length.
    Fixed CSO for IPv6.

 hw/net/net_tx_pkt.c | 54 ++++++++++++++++++++++++---
 hw/net/net_tx_pkt.h |  7 ++++
 include/net/eth.h   | 15 ++++++--
 net/eth.c           | 89 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 151 insertions(+), 14 deletions(-)

-- 
2.24.1


