Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EC5C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C04220675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfiW7UOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C04220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyPv-0002WV-95
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVyO5-0008Kt-Gg; Tue, 05 May 2020 10:17:33 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVyO4-0005HC-O2; Tue, 05 May 2020 10:17:33 -0400
Received: by mail-lf1-x143.google.com with SMTP id a9so1489928lfb.8;
 Tue, 05 May 2020 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bjVoctQqo/4MwwvukrYp9moB4syUyfv4XonW2FlcGoI=;
 b=YfiW7UOwXhiEiB/+7CPeE2LEgopbLS6+g1YGp0Q9h5/iNNiK/wgufuAbe4+yXtugjC
 uYOKSzKozXybMH6ZZCU84B1iyGXMRxBj5JsrqbnYtgvcget76iiokeTGh8DoryTlQ2rV
 QEoYV8v2s0knNTVm0cTN5OV08fVKFFRqLhK8gCRRJGxSfvEePKqJ1L9CHBIotNifcl/d
 LAKmgi2X1IMw7QRKguda2SnizZjyHuA0WIkh6Id8Wv1uwyk6nbFYmEC69ZsMGSEXapA1
 goEnbReDnA5v0i1KVT2PTDjcPXsE+FyKwxCn1Nyd4BaT79OEZvmfZr9M7bqPvBF+PtXl
 E2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bjVoctQqo/4MwwvukrYp9moB4syUyfv4XonW2FlcGoI=;
 b=CfpNhEFSMMyjn2aOubh0vXQRY7Il6Cbw0U7PeDr1aCU4Da1uMDQlFVVCuKtwgViHR+
 HfFyPuTCdHmr3m3g/y+4eF0G0jb4zRWQfkD6rAdUZuL7t/FdXaOPgZqwqpgvS/QUk3vE
 qxnZe/Ogpp5WXJtIMQDahhUgFZ46LVjtjplqWfC7IOkbrg2+7p92E76TdoYC1AAlWzE6
 tKI24gdWXTLfa8OXmAug7QOHkUiVzWpxQy9aJk2gLVeXpYw5O1Uba4EmHcRuduv4X90r
 eIvXWudUJ5mpYUS3F3H5YqFlKuXf3n5tPZ8XaGoucTqJ9VnV2HwQAUVdip01FF7ch6Fa
 Adrw==
X-Gm-Message-State: AGi0PuYFhc0E2tTokeMNcLm1wEeW/Uk+WVIxK9clLELi4gT4Ia/jYTfv
 bGOaj68Uo1wL0mgJ6jQnrQSn+piOL4g=
X-Google-Smtp-Source: APiQypLx1kdFgVW933udCgDVGkwv/Ayudmio9lWpGw6uZI04qZlMIlYJH23MWha1fjJJG5m2LGmLjg==
X-Received: by 2002:ac2:5684:: with SMTP id 4mr1851708lfr.88.1588688250294;
 Tue, 05 May 2020 07:17:30 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id t16sm1878625ljo.6.2020.05.05.07.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 07:17:29 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/1] target/arm: Remove access_el3_aa32ns_aa64any()
Date: Tue,  5 May 2020 16:17:28 +0200
Message-Id: <20200505141729.31930-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
we should merge access_el3_aa32ns and access_el3_aa32ns_aa64_any()
and always call the merged function to handle both aa32-only cases
and mixed aa32/aa64.

Cheers,
Edgar

ChangeLog:

v2 -> v3:
* Update commit message and cover letter to reflect that
  access_el3_aa32ns_aa64any is now being removed

v1 -> v2:
* Keep access_el3_aa32ns in favor of access_el3_aa32ns_aa64any
* Simplify description of access_el3_aa32ns
* Tweak secure aa32-el3 check in access_el3_aa32ns as suggested by Peter


Edgar E. Iglesias (1):
  target/arm: Drop access_el3_aa32ns_aa64any()

 target/arm/helper.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

-- 
2.20.1


