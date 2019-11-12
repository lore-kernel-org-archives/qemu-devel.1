Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744B0C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CE12196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/uWUvsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CE12196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZEe-0005U7-Ce
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZDs-0004dm-Rn
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZDr-00006Q-K0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUZDr-000054-Bh
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id z26so3937794wmi.4
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wlus6Qg23tyZnoYcyHUr7C2nwAGT3Mafjeo+ShDKaLw=;
 b=K/uWUvsOfzKBzR4D1bqAoqKp+MXEVSAzJCF23+wDhSnCdmzZAz9unEdauj2OcLws4T
 90bZOjn3jnGHxe7x5kNZMOtiRchRf4QR2wa9h4tzSYtg5wGjUSrlctdyxTo/c2Czc4OB
 7DVA5z9FMeRVWO8zww5K6vnRR7Gt21tUi+qFZuYpn5V6mLNxusczkWFbyFqGBmWK8xx+
 WaL0zyEatEgViDMkDgUpL5XbCcSjK/tAqKlxQ2BmU2XO398glszYZKhG4yw583XZM+1s
 Fe07/IcO+kgsC+0h9hMd+0pMFt/FHRiyy/AE4cT1mLvui0UMTM03jQ0bb4chkilM7Djn
 5i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wlus6Qg23tyZnoYcyHUr7C2nwAGT3Mafjeo+ShDKaLw=;
 b=h3a3DoCJNI+uNST5jxeUlEWww5RTTYfsYpO8T6TYFue15q7MlidGR+73KbtQ1fpszx
 RCGQT/IUU4zTPnyIsKMidwH+SiOG3VB/jFBnZfaKpMycCcIbb1/W3dkHfw84w9G+Yl2G
 Fz+wn7K0zBbrdUAk+2JAfM1HVGjkb6YI1fYdcqHSJkImSBA93ekec5/5BrXcNaQIeHm6
 ixUyn7LEfw5603y3qT/MB6zZWSXfMCUQNC+uv7XPc/SSR03A/UFSsTU6wlyO1MEF73+e
 HI2jK+v9Zto4jMf5ClWlpLNmMqHpnP0EUPCOvAQsPIUiaDWl7CXEhPzsMJ0YqkXgFtqT
 dloQ==
X-Gm-Message-State: APjAAAW+aCFIevnoQovaBUQJ78Zj8XiZGPYGYo7FKQavGnIJPHnsSiKS
 xn39j9R0QqZYpaCx1AFrMF7W/Q==
X-Google-Smtp-Source: APXvYqw90amr30Rv1K/sZ8DZ/f7eT6ySSLzUq7YyhRmzKNZssIk1Quvw57VxojNQuiu8hqlhTWeMCQ==
X-Received: by 2002:a7b:c18c:: with SMTP id y12mr3081061wmi.145.1573576853587; 
 Tue, 12 Nov 2019 08:40:53 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d202sm3672098wmd.47.2019.11.12.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:40:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 854741FF87;
 Tue, 12 Nov 2019 16:40:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/2] TCG plugin doc updates
Date: Tue, 12 Nov 2019 16:40:49 +0000
Message-Id: <20191112164051.16404-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

A few minor tweaks to the TCG plugin documentation.

Alex Bennée (2):
  docs/devel: rename plugins.rst to tcg-plugins.rst
  docs/devel: update tcg-plugins.rst with API versioning details

 MAINTAINERS                                 |  1 +
 docs/devel/{plugins.rst => tcg-plugins.rst} | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 rename docs/devel/{plugins.rst => tcg-plugins.rst} (87%)

-- 
2.20.1


