Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0EDC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC64820659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htu7rP9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC64820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0jn-0004pd-SL
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0hl-0003DT-Uo
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0hk-0007UM-UT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:48:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0hk-0007Ti-OS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:48:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id 3so16843878wmi.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=htu7rP9bJC5DcYjOa/XndViIgo1a0L/5PDBv86DTC7hp2/NZUdMXvMInF947d7gH2j
 Dzjs4OPjd0v7HnKblSd10Y9TzYWLqcihe9T43lcfaoMdW8xDv9oULHmohfwPOesbQu0Z
 ehawMQvFlshCEflvqDJXh1vR/cc0FuDoMiOkNY40om+lrhLtoh3xxJozwVBvzqcaYiJa
 T4Wnk1NRoTisFhHd9K8ZNFRjXyqBe/O+fYAUCB6WsJA6P0G8ghxU9tlMiyBMf2QTXoiU
 o57H1ZqvCmYKhDf4ONBw+UgFypSKgi6v83Qgk3rxH3kU0o3/HP877Hb0J/dErlr/s6v+
 VrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=WVIINaWF9SHl3HhB/FribJOuUSpVHCxG5MLQ5K1FuWFrH0WXZ+C2bH88cPeTgU4KfX
 OUB6wNs/ZOpqmd0T+YFS2YtFtePCJkEgUAkVnoKrUdXUiy8TV952FeB6lc8qhm9C5hAp
 mzUttXn6eePHOa7CVtjHTmm0clTMHsJehlcrrNYBdLCCzNakr0ZxjHLDWlH8GN9Zf7W3
 nhB8sIaOXMIVBzQXXxyyOqWnLSZEu79DjjJOtB8tkcXMGvRInjUEml8N/nBCBglxbNSO
 BeiDPw0sdce4BJ5QVOya86dPa4FQVHSK3ZBXJzUt9VtJNVjOpDUW/kHmb/nR7XiH9Ipa
 v3hw==
X-Gm-Message-State: APjAAAWeA3s+BhbC7b/jqM9tJr9sqNuKnaeKE5MzZh62U1dL0IY3gezf
 ePxhvgyM7FEfUIbXyluwaRqAaA==
X-Google-Smtp-Source: APXvYqxnbFJ/sSqI+/EbBpuTVFWIoFZkIlpiC0T+IijMJLIhEsEja7b7duqa/jnQANY5Jnc9hcUc4Q==
X-Received: by 2002:a05:600c:20ca:: with SMTP id
 y10mr14852291wmm.82.1571060887483; 
 Mon, 14 Oct 2019 06:48:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b186sm25678335wmd.16.2019.10.14.06.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:48:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5AE8E1FF87;
 Mon, 14 Oct 2019 14:48:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v1 0/5] gitdm updates
Date: Mon, 14 Oct 2019 14:48:01 +0100
Message-Id: <20191014134806.21900-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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


