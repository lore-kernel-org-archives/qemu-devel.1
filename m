Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD072C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3238C21974
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JpCNSh2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3238C21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsYd-00068J-NI
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOv-00041k-0x
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:05 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:39956)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMsOq-0005ea-3g
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601296620; x=1632832620;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ng/9pbwkuB0G7/4g7NS7GDk7yeDkhNIZfVOb3sQUTiU=;
 b=JpCNSh2AyeaMH+6RNSuhFF+HuPmoKjVXKdSdrB3vFvPKGWKVsXNmmFAQ
 cyxfyqshJgLICajR7O6h0J5BwwdwJH8YMcR/E0RFmXvwKSA9+qjEHHT+r
 s2azsX9h6RzDWu/67qpaw1rF0LetinLgB0yPbPvDVkVnWKl1+62sZTzlh E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Sep 2020 05:36:52 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 28 Sep 2020 05:36:51 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 2C112CE1; Mon, 28 Sep 2020 07:36:51 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: tsimpson@quicinc.com
Subject: [RFC PATCH v4 01/29] Hexagon Update MAINTAINERS file
Date: Mon, 28 Sep 2020 07:36:20 -0500
Message-Id: <1601296608-29390-2-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601296608-29390-1-git-send-email-tsimpson@quicinc.com>
References: <1601296608-29390-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.39;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 08:36:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIFRheWxvciBTaW1wc29uIGFzIHRoZSBIZXhhZ29uIHRhcmdldCBtYWludGFpbmVyCgpTaWdu
ZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogTUFJ
TlRBSU5FUlMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCAzZDE3Y2FkLi4zYWFh
ZmIzIDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTg1LDYg
KzE4NSwxNCBAQCBGOiBpbmNsdWRlL2h3L2NyaXMvCiBGOiB0ZXN0cy90Y2cvY3Jpcy8KIEY6IGRp
c2FzL2NyaXMuYwogCitIZXhhZ29uIFRDRyBDUFVzCitNOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBz
b25AcXVpY2luYy5jb20+CitTOiBTdXBwb3J0ZWQKK0Y6IHRhcmdldC9oZXhhZ29uLworRjogbGlu
dXgtdXNlci9oZXhhZ29uLworRjogZGlzYXMvaGV4YWdvbi5jCitGOiBkZWZhdWx0LWNvbmZpZ3Mv
aGV4YWdvbi1saW51eC11c2VyLm1haworCiBIUFBBIChQQS1SSVNDKSBUQ0cgQ1BVcwogTTogUmlj
aGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD4KIFM6IE1haW50YWluZWQKLS0gCjIuNy40
Cgo=

