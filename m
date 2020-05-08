Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E8821473
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmRqCjDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E8821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5ZC-0000ox-I2
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Nm-0000Mm-RI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:50 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:40340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5Nl-0008K0-OI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:57:50 -0400
Received: by mail-pl1-x62a.google.com with SMTP id t16so912962plo.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ue+9fqV+aUXjlOrd/Ti1cgDoWTGdV3YEiFv/3ErGggQ=;
 b=YmRqCjDVWM1RHj44Nl23Z1Y7c6OFu8l6qEzLozV47ewI5f/eX5iwkpVu8gGkx/cIBG
 SlGaj61Di7y0LjGvqEV+mUltF/tN6W7UVMtj4S4SBU32SVKCCtPQijlUR6NgOszQKr4m
 luee6Yjp3nFvZTt5EytfJH3KjT8oSLJ3tvQH9A0bcEYgoiTPcvd6waHe9mt4ITIveWj7
 2flYT5cY+Vl0uS1qknVj59py4amgIwUE93Hf+dBbbgekobj74PXp7ODaiGSJzhrgK3NV
 ZeImChMnMgI30oR0pMZeNkfffxRXTZXlo8gBb/7s3K92fkKziITMy+v4pGNwBh3D7j8W
 OsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ue+9fqV+aUXjlOrd/Ti1cgDoWTGdV3YEiFv/3ErGggQ=;
 b=daFrHU0IsMJrbKsinmOS9kutMT7W4nOWdaMSz1hjF1g9nraAN1W1Uka47dojU47qaV
 dUmhchMSbqscWml9d1PkwFdDQ1cgMlZW/VAG4XcU9GdwpFqvElYR1hxYw67k8fu5+AE0
 yZUrpiNC+l8Mdw2vTn9mEiPVD0tWxPBaZyyWe+nReUH97FPV4YYIXHHd26oBh6Sdzma/
 2iH6h4raBz7oemF92eZXdc5iYr5eICNU5PO3EMwVGKQNSYvFVFJhvj5qBA7xbAUrM4ce
 fQbu+PGyHWI/95o8qnW+p4Ao8sRihar81pe1eUrv8xrGTwM95FSsea37+OZgKeHB9Wbm
 Pedw==
X-Gm-Message-State: AGi0PuaaiyniRMajW7pm70w4ek/C68KiogtxNllu9E4etCY3J96Bdx9w
 Dd4OJrlq7tnH+umK0bdYIM6ygWS5/GM=
X-Google-Smtp-Source: APiQypJ6CvnECgiHqzegqs9QRvn1NcHuWx0cdAjcWpwdSxdp9vjGTTttDBSxZpkMysdF3XuoDbTObQ==
X-Received: by 2002:a17:902:328:: with SMTP id 37mr3273123pld.35.1588953467745; 
 Fri, 08 May 2020 08:57:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z7sm2141601pff.47.2020.05.08.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:57:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tcg/s390: Support host vector operations
Date: Fri,  8 May 2020 08:57:42 -0700
Message-Id: <20200508155745.8223-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've had this floating around on a branch for a while now
It is able to run arm sve tests under qemu, but I have not
been able to test it against real hardware. 


r~


Richard Henderson (3):
  tcg/s390: Change FACILITY representation
  tcg/s390: Merge TCG_AREG0 and TCG_REG_CALL_STACK into TCGReg
  tcg/s390: Implement vector operations

 tcg/s390/tcg-target.h     |  92 ++--
 tcg/s390/tcg-target.opc.h |   5 +
 tcg/s390/tcg-target.inc.c | 862 +++++++++++++++++++++++++++++++++++---
 3 files changed, 864 insertions(+), 95 deletions(-)
 create mode 100644 tcg/s390/tcg-target.opc.h

-- 
2.20.1


