Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340FC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1AE2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6hQL5rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1AE2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdql-0006f7-9K
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iVdp3-0004yh-5m
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iVdp2-0008V1-3D
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:47:45 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iVdp0-0008Re-U8; Fri, 15 Nov 2019 10:47:44 -0500
Received: by mail-wm1-x342.google.com with SMTP id q70so10112552wme.1;
 Fri, 15 Nov 2019 07:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kQemV5htlZ/lDDSIUnrHXnpUKezonJ/3SoZp34SlFOk=;
 b=u6hQL5rm0SuXGfaoioSXKHupqNcKF3EEmBybxHVBygUM093XFTvklSWo+6ihjfPJlC
 zMmbhQMoXn02xjQk3D1iO57Q502vbQo13eytFmPzUBt1dBXwKMCOQRCM8WS55ptDLnth
 P0YGd1wk3M2ig4ufxDHwTtmpUiS0lgcOe5xHKYmOmcdTiH0lYYHSHZlT6YFrQH6hOFob
 7IpL4Ne+v2vbzEkp7ufet3zM27erO2T/KlP5O6McwjeSERN2EdgKT3jNoFfOLZVq2hFz
 ItW/V0mHpFxBXeld7sJNXq80yoRGc7FLL2SMg1xsSRTYGGeETDGpaE2A3i41Ybpv9xLb
 P2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kQemV5htlZ/lDDSIUnrHXnpUKezonJ/3SoZp34SlFOk=;
 b=V+gQHRmeHh0XO4myUwbp++yn7a4PY2+865jYxHkl7heOEW7kmBtPws/tCH/eNV7ld2
 iFp5gN/KeNWqEwmrpv5URh9NjyGSlpAUn+ka0BpXmN+IoxQCA2AEb6EPqyHtZx9bMe6z
 fDaR/qEsQ6uvdQcJ8s9Rf2xVY5sGZFJkANsDtbIHeaSEq5FsHRleUprq8bqE5aV3+me9
 ciIGjwQ1SD0lsR6ZGgmX5OsArtrncoh+crJYeIHcW72mG1ABZnT8assAS9SUn18o0c9+
 nuzxWusd5fC/JP3HfKz6b40sw9Tk76bEf9p2vA8iisGPuhB7Gibuo7aJ8LHZkAc+1KSv
 JhNw==
X-Gm-Message-State: APjAAAVNYP1uUwhYR+wT0DYtcXG/JNmEJ3wM+7Nax4lIwxEZpUxr+sD0
 oBIW7mfhV4a+gI0dzZ4ZkQGK/QF/h5g=
X-Google-Smtp-Source: APXvYqy9VP+NoDVEPvzuFHTc6B3WBmcXrwih6mboOyx7JOLu0s9eYnFkMH8ywKzx9uSrgwPUasv6Hg==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr7614701wml.29.1573832858863; 
 Fri, 15 Nov 2019 07:47:38 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id y15sm11649847wrh.94.2019.11.15.07.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:47:38 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] hw/arm: versal: Add the CRP as unimplemented
Date: Fri, 15 Nov 2019 16:47:33 +0100
Message-Id: <20191115154734.26449-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Some boot-loaders will access the CRP block and bug out
if recieving bus errors. Since we're in freeze, this does
not try to add a model of the CRP instead we only add it
as unimplemented. This is enough to work around the issue.

Cheers,
Edgar

Edgar E. Iglesias (1):
  hw/arm: versal: Add the CRP as unimplemented

 hw/arm/xlnx-versal.c         | 2 ++
 include/hw/arm/xlnx-versal.h | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.20.1


