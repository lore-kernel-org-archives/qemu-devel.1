Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED44C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8F120733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JjAJGYjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8F120733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JdI-0002nZ-PN
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-0000yL-Ie
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbq-0004yT-W4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbq-0004tJ-Je
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381662; x=1612917662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zn71YDhL1PCfjj8nGS+2Hkwxo00WwGvhojS4qiDjPCE=;
 b=JjAJGYjHBiHmDXruN0+UAdsLR11+xLl9RbjJhhFxnWlJIIidx63lVtkj
 B64uFMU0gu3Rq5C0G9wJPOWMDCIXLXwsr/fXEgbjr6zP4aNs/73C2k+Uo
 VgG0EDlGbPUHdfSdJzDvwSZzXS8Nw+qWB7GkdJho6jbO84dhwQbC6wpV0 o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:57 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 1C8511B48; Mon, 10 Feb 2020 18:40:57 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/66] Hexagon ELF Machine Definition
Date: Mon, 10 Feb 2020 18:39:40 -0600
Message-Id: <1581381644-13678-3-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

RGVmaW5lIEVNX0hFWEFHT04gMTY0CgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNp
bXBzb25AcXVpY2luYy5jb20+Ci0tLQogaW5jbHVkZS9lbGYuaCB8IDIgKysKIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2VsZi5oIGIvaW5jbHVk
ZS9lbGYuaAppbmRleCA4ZmJmZTYwLi5kNTFlN2Q0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2VsZi5o
CisrKyBiL2luY2x1ZGUvZWxmLmgKQEAgLTE3MCw2ICsxNzAsOCBAQCB0eXBlZGVmIHN0cnVjdCBt
aXBzX2VsZl9hYmlmbGFnc192MCB7CiAKICNkZWZpbmUgRU1fVU5JQ09SRTMyICAgIDExMCAgICAg
LyogVW5pQ29yZTMyICovCiAKKyNkZWZpbmUgRU1fSEVYQUdPTiAgICAgMTY0ICAgICAvKiBRdWFs
Y29tbSBIZXhhZ29uICovCisKICNkZWZpbmUgRU1fUklTQ1YgICAgICAgIDI0MyAgICAgLyogUklT
Qy1WICovCiAKICNkZWZpbmUgRU1fTkFOT01JUFMgICAgIDI0OSAgICAgLyogV2F2ZSBDb21wdXRp
bmcgbmFub01JUFMgKi8KLS0gCjIuNy40Cgo=

