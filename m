Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55479C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A80206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0mWZZYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A80206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSq3-0006vv-5e
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTSkV-0001Ld-3t
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jTSiB-0004gB-4B
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:06:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jTSiA-0004aX-HS; Tue, 28 Apr 2020 12:03:54 -0400
Received: by mail-lf1-x144.google.com with SMTP id w145so17363542lff.3;
 Tue, 28 Apr 2020 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yArlMeJLEqclMBk/jDgf3oGNxTygsUNwmienflwMm3k=;
 b=j0mWZZYFnSxj3FZOvyV8jT/ElcHRTsSkFi9e9vfxEedeYPKf3WmKh1wLrg2WXr7Gsz
 pxJNO0LzXHE0H038NF88DlJdrJ9vVONRPsShOgBd3kazspxf8AGr0HqlXmNEKz9MPXAT
 lExW3MMLqxGmfugQkmRtwX7auUGlz+5RZUoXd7FEAEdGUP/GXb7Y0ZXDQG8Qy8IzNtyr
 F0UKCHlJXerP1am8gi8nDmV/DzEWOchrYpD4JvGC4pZ6336MvcAJmmKPsPtHK0mgiHQ+
 Rz3ww2dWWJOPl3iEWgjmgy4Q2o2nKmqSNWmiMfVKrEnrUi2FeK4mVgnewx2xkVXtciCJ
 MsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yArlMeJLEqclMBk/jDgf3oGNxTygsUNwmienflwMm3k=;
 b=A/OOpr+4irl6YBVbutvz8sWwTRd2NKbL7rDRllZoLON8nClr0/TkSoTbBNssJTmz5Q
 rBbGfHQ6MC2e0dqhASlbnHdd05dOHFh3MmpwU0qEenN+EmN5Cc4pZg3TsgFgmgUXkrXw
 baSOegRmgTRsIkR+vbPMFvMv6ZTylfsDPzEppRndltFcqbTeTf7fhpvHbKWucgm5ZpYt
 Ld8yvTeLU3hcXvtTRV+jNTKOQlw8teR15yqwayN5EJKftm3jieJT96mwSOMAH8momys7
 6YufsZmXyPLXrfffSkZg+uPzXE0Thk3/bWAaATBfB5kAxWJT3E/86KG/2p9oTVmBHXNf
 LfMQ==
X-Gm-Message-State: AGi0PuYb2UkE84TeoxjqnnKaxSnDfhN8mkqO43v8tS/prCzfZz6P307a
 xtWGt7IQQenfVIYKv5alIIkYWdXb7lg=
X-Google-Smtp-Source: APiQypJI+cZsh16+K0O7tePSvwjHaQqCteAvJfdFe11U6G4DwlIeeSXKjK4+r3dCvd3d0JwcfQ4AUQ==
X-Received: by 2002:a19:42c3:: with SMTP id p186mr1473618lfa.194.1588089831760; 
 Tue, 28 Apr 2020 09:03:51 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q125sm13024013ljb.34.2020.04.28.09.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 09:03:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] target/arm: Remove access_el3_aa32ns()
Date: Tue, 28 Apr 2020 18:03:49 +0200
Message-Id: <20200428160350.10030-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Hi,

Laurent reported hitting the assert in access_el3_aa32ns()
when accessing 32-bit versions of some of the virtualization
regs when EL3 is 64-bit.

I think we got this wrong back then and it seems to me like
we should remove direct usage of access_el3_aa32ns() and
always call access_el3_aa32ns_aa64_any() to handle both
the aa32-only cases and the mixed aa32/aa64.

Cheers,
Edgar

Edgar E. Iglesias (1):
  target/arm: Drop access_el3_aa32ns()

 target/arm/helper.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

-- 
2.20.1


