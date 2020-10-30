Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F297C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2FF20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EjRbcXmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2FF20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYI9U-0005tY-Jd
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHyR-0003tA-LT
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:08:55 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:27667)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kYHyN-0005PU-0N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604016530; x=1635552530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uglsZ3eiI/MMkCcfScADMxe/ATBlY3PIwVJOHPBy3ws=;
 b=EjRbcXmtVdU7Y2QdvoF7gt2rJWq4hstImA88K47G3XccAqT9ZZYpOOLZ
 iy5fgkbnJYgZtCu0oUuYhyoQq1hK86yQ/5V8AlcwbIVLXmx+iaZuykF2/
 9DEc0Derg8UExwpZpcbxU715ZkrdUc7NwJ3Vr+Y85RfL3crYK9gxB21A3 w=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Oct 2020 17:08:44 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 29 Oct 2020 17:08:44 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id C45784122; Thu, 29 Oct 2020 19:08:43 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 09/33] Hexagon (target/hexagon) architecture types
Date: Thu, 29 Oct 2020 19:08:15 -0500
Message-Id: <1604016519-28065-10-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604016519-28065-1-git-send-email-tsimpson@quicinc.com>
References: <1604016519-28065-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 19:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: ale@rev.ng, bcain@quicinc.com, richard.henderson@linaro.org,
 at.org@qualcomm.com, laurent@vivier.eu, tsimpson@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RGVmaW5lIHR5cGVzIHVzZWQgaW4gZmlsZXMgaW1wb3J0ZWQgZnJvbSB0aGUgSGV4YWdvbiBhcmNo
aXRlY3R1cmUgbGlicmFyeQoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29u
QHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9hcmNoX3R5cGVzLmggfCAzOCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM4
IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9oZXhfYXJj
aF90eXBlcy5oCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2FyY2hfdHlwZXMuaCBi
L3RhcmdldC9oZXhhZ29uL2hleF9hcmNoX3R5cGVzLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uNTdkYzg0NgotLS0gL2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9hcmNoX3R5cGVzLmgKQEAgLTAsMCArMSwzOCBAQAorLyoKKyAqICBDb3B5cmlnaHQoYykgMjAx
OS0yMDIwIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2
ZWQuCisgKgorICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyAqICB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgor
ICogIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisgKgorICogIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAor
ICogIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCisgKiAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQorICogIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCisgKgorICogIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiAgYWxvbmcgd2l0aCB0aGlzIHByb2dy
YW07IGlmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KKyAqLworCisj
aWZuZGVmIEhFWEFHT05fQVJDSF9UWVBFU19ICisjZGVmaW5lIEhFWEFHT05fQVJDSF9UWVBFU19I
CisKKyNpbmNsdWRlICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAicWVtdS9pbnQxMjguaCIKKwor
LyoKKyAqIFRoZXNlIHR5cGVzIGFyZSB1c2VkIGJ5IHRoZSBjb2RlIGltcG9ydGVkIGZyb20gdGhl
IEhleGFnb24KKyAqIGFyY2hpdGVjdHVyZSBsaWJyYXJ5LgorICovCit0eXBlZGVmIHVpbnQ4X3Qg
ICAgIHNpemUxdV90OwordHlwZWRlZiBpbnQ4X3QgICAgICBzaXplMXNfdDsKK3R5cGVkZWYgdWlu
dDE2X3QgICAgc2l6ZTJ1X3Q7Cit0eXBlZGVmIGludDE2X3QgICAgIHNpemUyc190OwordHlwZWRl
ZiB1aW50MzJfdCAgICBzaXplNHVfdDsKK3R5cGVkZWYgaW50MzJfdCAgICAgc2l6ZTRzX3Q7Cit0
eXBlZGVmIHVpbnQ2NF90ICAgIHNpemU4dV90OwordHlwZWRlZiBpbnQ2NF90ICAgICBzaXplOHNf
dDsKK3R5cGVkZWYgSW50MTI4ICAgICAgc2l6ZTE2c190OworCisjZW5kaWYKLS0gCjIuNy40Cgo=

