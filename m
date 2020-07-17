Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E1D20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjtHha+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwX5z-0007AR-R1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 16:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwX58-00064u-Nq
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:35:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:47097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwX56-0000Jg-Rk
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:35:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id a23so4338746pfk.13
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5c/gsJqJ6XcNRIcgHud5UAlDedsAxFvUwe0J2S8P1Ow=;
 b=xjtHha+hAKGbS5Zs36DiLtuQrk0M4D2HYdYNhmBBTzmZRSDgj9I/ygjKew0thwaS7Q
 N+qPsAMUOgJamJx8DiLo3Vxh7tK8Bqsan2L5D0PFchFNj3lAnlJsfCwl8PW5TumfYRde
 7Z/PtA2uZpzOtTXy2F2Dcp9C9wwqX6UqoPFUkD/08J6/HvC1nu9ihXwmRch4oy+cHPzq
 UtG5wsvfDxcmi/rop+985UPdxn3Yf3ecDIf51TjPu98TP0Jlx6PTIk1qYurk37wdwvWc
 ueebAXK0SR22hoIW24U06qXIDhharR/TpBVQHLpNtGi34vqO0lIXM0xT7uQ2oe0mEF0w
 ioFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5c/gsJqJ6XcNRIcgHud5UAlDedsAxFvUwe0J2S8P1Ow=;
 b=DraGWlHONHmrQMXXIapnazHHpNbTZ9yp44zD1TSncky8++X+jAsVsESqIu+LXKXQA2
 rnOXD9f4Y/xQRw0Josz+nr5gt+ZZCAWJvPcpbNgGi4eZpQLoB3iG7+YemunIB5X3kIXN
 MfmF5d9LgOKJHPsyai2jRBtl2r86hgMb3MSvqx0EVWhcaIRopIVU4AGpmQMozfS248v6
 dL8myEkOIjUs2PsmQVHSW4th9RDDEX3HnU3FJsdlJglYAgWcOnlhsZwiO3LdgEQeVvNs
 ylVcoLkPnJBSrXTmebrpEuKYRw2aEG4TOrOcQ1IO62n0YlBr8wgR8jR7THdu6EdMgHiR
 p1cA==
X-Gm-Message-State: AOAM531U/MG5uCH3sZgDzGg4GxZ4JMRT2/wOmdGgvOz2UQ1Uu5a/eoWy
 3jAkWMPFj+wmhTkMndUAqEamZwz1+Bs=
X-Google-Smtp-Source: ABdhPJxqoX7VfBnsYh6fUHrthCc671mObDCBZNx/+tZLSFHGfFNRylnqD6PEV9sD6bx64gtJLuIrFA==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr9843739pfv.30.1595018141686; 
 Fri, 17 Jul 2020 13:35:41 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:b0d0:3aae:620c:a8c5])
 by smtp.gmail.com with ESMTPSA id x7sm8212848pfq.197.2020.07.17.13.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 13:35:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/3] python/qemu: follow-up changes for ConsoleSocket
Date: Fri, 17 Jul 2020 16:30:38 -0400
Message-Id: <20200717203041.9867-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alex.bennee@linaro.org, jsnow@redhat.com, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For v1, we added a few minor changes, and also added one new patch 
in tests/vm to add a shutdown timeout.  This fixes an issue we saw in 
testing the aarch64 VMs with TCG.

This patch series introduces a few follow-up changes after the introduction of 
ConsoleSocket.

The first patch introduces cleanup changes for pylint and flake8.

The second patch allows machine.py to use a single type for the console_socket,
a ConsoleSocket.
Since machine.py will use ConsoleSocket for both the draining and non-draining
cases, we changed ConsoleSocket to handle the case where it does not drain the
socket at all and essentially behaves like a socket.

Robert Foley (3):
  python/qemu: Cleanup changes to ConsoleSocket
  python/qemu: Change ConsoleSocket to optionally drain socket.
  tests/vm: add shutdown timeout in basevm.py

 python/qemu/console_socket.py | 137 +++++++++++++++++++---------------
 python/qemu/machine.py        |  14 ++--
 python/qemu/pylintrc          |   2 +-
 tests/vm/basevm.py            |  15 ++--
 4 files changed, 94 insertions(+), 74 deletions(-)

-- 
2.17.1


