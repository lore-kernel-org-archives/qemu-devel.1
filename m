Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A12C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075AC2467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pu2prBsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075AC2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7izr-0002za-Tj
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikp-0003AJ-Sk
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7iko-0005jE-OO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:47 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13235)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ikn-0005U6-00
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908285; x=1614444285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZEtJIeH5bg68fnwTSb22UnFqWycROWuG0DlJnkmVeKU=;
 b=pu2prBsqS4Yrm0lG6uPW6uAMLg+f3e4zfG65496U3yFC4FgVKioYpM6b
 YlsqGfcs3qiqaDfbeRa9U6tdcoCTQ9GFOl+/F96AgxkDbjIIHQF8qPoFX
 L3KWOS0D+cDNvmk/IIWZKm/o8+rzqshLh8fT8kYXJeUMaaAi0kQ0g8NB/ 4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id EF29D1191; Fri, 28 Feb 2020 10:44:29 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 25/67] Hexagon generator phase 2 -
 op_attribs_generated.h
Date: Fri, 28 Feb 2020 10:43:21 -0600
Message-Id: <1582908244-304-26-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Taylor Simpson <tsimpson@quicinc.com>, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TGlzdHMgYWxsIHRoZSBhdHRyaWJ1dGVzIGFzc29jaWF0ZWQgd2l0aCBlYWNoIGluc3RydWN0aW9u
CgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vZG9fcWVtdS5weSB8IDEzICsrKysrKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZG9f
cWVtdS5weSBiL3RhcmdldC9oZXhhZ29uL2RvX3FlbXUucHkKaW5kZXggMTA3ZTFlOC4uNDk5ZjBl
MCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZG9fcWVtdS5weQorKysgYi90YXJnZXQvaGV4
YWdvbi9kb19xZW11LnB5CkBAIC03OTMsMyArNzkzLDE2IEBAIHJlYWxmLndyaXRlKGYuZ2V0dmFs
dWUoKSkKIHJlYWxmLmNsb3NlKCkKIGYuY2xvc2UoKQogCisjIworIyMgR2VuZXJhdGUgdGhlIG9w
X2F0dHJpYnNfZ2VuZXJhdGVkLmggZmlsZQorIyMgICAgIExpc3RzIGFsbCB0aGUgYXR0cmlidXRl
cyBhc3NvY2lhdGVkIHdpdGggZWFjaCBpbnN0cnVjdGlvbgorIyMKK2YgPSBTdHJpbmdJTygpCitm
b3IgdGFnIGluIHRhZ3M6CisgICAgZi53cml0ZSgnT1BfQVRUUklCKCVzLEFUVFJJQlMoJXMpKVxu
JyAlIFwKKyAgICAgICAgKHRhZywgJywnLmpvaW4oc29ydGVkKGF0dHJpYmRpY3RbdGFnXSkpKSkK
K3JlYWxmID0gb3Blbignb3BfYXR0cmlic19nZW5lcmF0ZWQuaCcsICd3dCcpCityZWFsZi53cml0
ZShmLmdldHZhbHVlKCkpCityZWFsZi5jbG9zZSgpCitmLmNsb3NlKCkKKwotLSAKMi43LjQKCg==

