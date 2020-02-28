Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D74C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D202469C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E3xMIT9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D202469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7j5V-0003Oz-Co
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ikp-0003A6-Pv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7iko-0005j5-Nz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:47 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ikm-0005Uz-VE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908284; x=1614444284;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7+Hc0jfS3tQCWIYlje1XKRzVTi6/FQnF/P9hm/fXxY0=;
 b=E3xMIT9nB4DFef8+MY4vmtiE/7/yVS61YZWSd45AkHZ/3/elbqJ9jKuM
 IhkovSl/x/4g6ej29ntLkRiowUJ0AOvB5zCqs+H0viHa/I8UjhFs7z+SB
 sAMiPivPowXzYqsQH8PEYx8VjFkIU4tnV9IM7sMstcxnLAb1Wj0Z+xjeR s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:29 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id C8B84F0B; Fri, 28 Feb 2020 10:44:29 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 23/67] Hexagon generator phase 2 - qemu_wrap_generated.h
Date: Fri, 28 Feb 2020 10:43:19 -0600
Message-Id: <1582908244-304-24-git-send-email-tsimpson@quicinc.com>
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

R2l2ZXMgYSBkZWZhdWx0IGRlZmluaXRpb24gb2YgZldSQVBfPHRhZz4gZm9yIGVhY2ggaW5zdHJ1
Y3Rpb24KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kb19xZW11LnB5IHwgMTQgKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vZG9fcWVtdS5weSBiL3RhcmdldC9oZXhhZ29uL2RvX3FlbXUucHkKaW5kZXggNmYwZTM3Ni4u
M2Y1MmVmMyAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZG9fcWVtdS5weQorKysgYi90YXJn
ZXQvaGV4YWdvbi9kb19xZW11LnB5CkBAIC03NjcsMyArNzY3LDE3IEBAIHJlYWxmLndyaXRlKGYu
Z2V0dmFsdWUoKSkKIHJlYWxmLmNsb3NlKCkKIGYuY2xvc2UoKQogCisjIworIyMgR2VuZXJhdGUg
dGhlIHFlbXVfd3JhcF9nZW5lcmF0ZWQuaCBmaWxlCisjIyAgICAgR2l2ZXMgYSBkZWZhdWx0IGRl
ZmluaXRpb24gb2YgZldSQVBfPHRhZz4gZm9yIGVhY2ggaW5zdHJ1Y3Rpb24KKyMjCitmID0gU3Ry
aW5nSU8oKQorZm9yIHRhZyBpbiB0YWdzOgorICAgIGYud3JpdGUoICIjaWZuZGVmIGZXUkFQXyVz
XG4iICUgdGFnICkKKyAgICBmLndyaXRlKCAiI2RlZmluZSBmV1JBUF8lcyhHRU5ITFBSLCBTSE9S
VENPREUpIEdFTkhMUFJcbiIgJSB0YWcgKQorICAgIGYud3JpdGUoICIjZW5kaWZcblxuIiApCity
ZWFsZiA9IG9wZW4oJ3FlbXVfd3JhcF9nZW5lcmF0ZWQuaCcsICd3dCcpCityZWFsZi53cml0ZShm
LmdldHZhbHVlKCkpCityZWFsZi5jbG9zZSgpCitmLmNsb3NlKCkKKwotLSAKMi43LjQKCg==

