Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96292C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538A02073A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nct+iqYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538A02073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2gww-0004Zt-Bw
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 14:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvH-00030s-VL
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2gvH-0003VT-2x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:47 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:34281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2gvG-0003Tx-Ud
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 14:46:47 -0500
Received: by mail-pf1-x42f.google.com with SMTP id i6so5377341pfc.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F7PHyP31BJs5fHuan+iMwqGlPcnh0NKkrTwQ9fASbuU=;
 b=nct+iqYYybKOjPGrvujzL4V1MLUDp+0z3pL+r92Uq1FjHCPbHo9OYjEl1uvT1+Fjaz
 XC9ahjioG5E4c9ACML2ccVKXP32ixwwNf4uYPLDVnv3SsMGbZH1BS+VypEKGhsruP+Vr
 4Y1BP6HTH7BQPXhVwgX6+0CnQqYQGd91Q+EA1SKFIu2xqBGlJ9fNqgMjG1745ZBqV4fC
 D7+0cTAlkE9zI8Lg1WPh4ySm4i/JAYVQt5XazR0W5qD6uE/Gy/bfLPFUecuGcu1Q4ri8
 Lg+E5vxNCRAklgqRop24Fom6+8LFPbN3XTWvqu44GjzoeyGioYkSmaevQa5Vc8uF0Br9
 zeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F7PHyP31BJs5fHuan+iMwqGlPcnh0NKkrTwQ9fASbuU=;
 b=Z3dkV0ojszLhLXmYI5BTSuZWCFIp4w0nL9Bc7WE6z9p7qJrs40tCCPP12PGAnemkA+
 pUBtYR1PG+w7UeORT3Ri69nwjg9dzUAvzspBDET8X56DXtmeJSNf3D5vU3D2U4xiAXeY
 rpBmYYjWZ2chQfSz6aSuz4mXj+2rn5Us0As/TT7wOb4v/GzkYEOm89fNA3Lh3LceIWeN
 S6LQfh/P4m+MQEGIH/aTG5aFlWXwLmhWIaEFDy/N0gjhi/PUmRMsSZFcVFXY0M6WDCQG
 CmUmlVA7vyoBf1lKBMZ4n/ZtEH636QowWPfIq7wsmPRMNY0NOSOR1O2brwlU2utEnGIa
 re5A==
X-Gm-Message-State: APjAAAUXteNiyFujhHfwGknKbOstb9QbEduv7f9NeELXdsGZhivofjM/
 gUHx1KjAz4l0NN2cVkyqb5YCLSefu0A=
X-Google-Smtp-Source: APXvYqxrXcBryYWBpH7j7LQAlsAlTFv0HAB2+1CC5zYZhIxbgd0ywRbcqwTW9RH/QLWQUfPbiongiQ==
X-Received: by 2002:aa7:864b:: with SMTP id a11mr5032655pfo.175.1581709605439; 
 Fri, 14 Feb 2020 11:46:45 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g13sm7558851pfo.169.2020.02.14.11.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 11:46:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] target/arm: fix some simd writes vs sve
Date: Fri, 14 Feb 2020 11:46:39 -0800
Message-Id: <20200214194643.23317-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The launchpad bug only mentions EXT, but I found three more
via inspection.  I really should extend RISU so that we can
do AdvSIMD testing with SVE enabled...


r~


Richard Henderson (4):
  target/arm: Flush high bits of sve register after AdvSIMD EXT
  target/arm: Flush high bits of sve register after AdvSIMD TBL/TBX
  target/arm: Flush high bits of sve register after AdvSIMD ZIP/UZP/TRN
  target/arm: Flush high bits of sve register after AdvSIMD INS

 target/arm/translate-a64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.20.1


