Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3086C352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F44B2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ih1onvau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F44B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jrs-0001xl-KW
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcV-0001ym-Uq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcT-0008WM-FD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:43 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1JcT-0004uE-1r
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381701; x=1612917701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XbtMmHHKy9IdsEl46Mz89eb4fCaCb3TSmn0EhgVl7Us=;
 b=Ih1onvaug9M62R3zgm5jH/H5wDHoYpHKIJRYibl5lslQVcaXEZVn5A7m
 usf0r+oJgiBheZBDRwNmyZnkGiJV4aHpbTV9fo8anGO0Ezn+mjP7idD0G
 Nu06vW30ADZ+R2synWPGuuWiW0ZlUP2C7caiBMRyFgXxlE33USeb7sAMG 4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:41:02 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 9DF7C1B48; Mon, 10 Feb 2020 18:41:01 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 46/66] Hexagon TCG generation - step 09
Date: Mon, 10 Feb 2020 18:40:24 -0600
Message-Id: <1581381644-13678-47-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
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

T3ZlcnJpZGUgaW5zdHJ1Y3Rpb25zIHRvIHNwZWVkIHVwIHFlbXUKClNpZ25lZC1vZmYtYnk6IFRh
eWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZWxwZXJfb3ZlcnJpZGVzLmggfCA5NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyX292
ZXJyaWRlcy5oCmluZGV4IGU1NDRkZDUuLjUyZTRhNDcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2hlbHBlcl9vdmVycmlkZXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXJfb3ZlcnJp
ZGVzLmgKQEAgLTEyMzAsNCArMTIzMCwxMDEgQEAKICAgICAgICAgZ2VuX2hlbHBlcl92YWNzaF9w
cmVkKFBlViwgY3B1X2VudiwgUnh4ViwgUnNzViwgUnR0Vik7IFwKICAgICB9IHdoaWxlICgwKQog
CisvKgorICogVGhlIGZvbGxvd2luZyBmV1JBUCBtYWNyb3MgYXJlIHRvIHNwZWVkIHVwIHFlbXUK
KyAqIFdlIGNhbiBhZGQgbW9yZSBvdmVyIHRpbWUKKyAqLworCisvKgorICogQWRkIG9yIHN1YnRy
YWN0IHdpdGggY2FycnkuCisgKiBQcmVkaWNhdGUgcmVnaXN0ZXIgaXMgdXNlZCBhcyBhbiBleHRy
YSBpbnB1dCBhbmQgb3V0cHV0LgorICogcjU6NCA9IGFkZChyMTowLCByMzoyLCBwMSk6Y2FycnkK
KyAqLworI2RlZmluZSBmV1JBUF9BNF9hZGRwX2MoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAg
ZG8geyBcCisgICAgICAgIFRDR3YgTFNCID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgVENH
dl9pNjQgTFNCX2k2NCA9IHRjZ190ZW1wX25ld19pNjQoKTsgXAorICAgICAgICBUQ0d2X2k2NCB0
bXBfaTY0ID0gdGNnX3RlbXBfbmV3X2k2NCgpOyBcCisgICAgICAgIFRDR3YgdG1wID0gdGNnX3Rl
bXBfbmV3KCk7IFwKKyAgICAgICAgdGNnX2dlbl9hZGRfaTY0KFJkZFYsIFJzc1YsIFJ0dFYpOyBc
CisgICAgICAgIGZMU0JPTEQoUHhWKTsgXAorICAgICAgICB0Y2dfZ2VuX2V4dHVfaTMyX2k2NChM
U0JfaTY0LCBMU0IpOyBcCisgICAgICAgIHRjZ19nZW5fYWRkX2k2NChSZGRWLCBSZGRWLCBMU0Jf
aTY0KTsgXAorICAgICAgICBmQ0FSUllfRlJPTV9BREQoUnNzViwgUnR0ViwgTFNCX2k2NCk7IFwK
KyAgICAgICAgdGNnX2dlbl9leHRybF9pNjRfaTMyKHRtcCwgUnNzVik7IFwKKyAgICAgICAgZjhC
SVRTT0YoUHhWLCB0bXApOyBcCisgICAgICAgIHRjZ190ZW1wX2ZyZWUoTFNCKTsgXAorICAgICAg
ICB0Y2dfdGVtcF9mcmVlX2k2NChMU0JfaTY0KTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlX2k2
NCh0bXBfaTY0KTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKHRtcCk7IFwKKyAgICB9IHdoaWxl
ICgwKQorCisvKiByNTo0ID0gc3ViKHIxOjAsIHIzOjIsIHAxKTpjYXJyeSAqLworI2RlZmluZSBm
V1JBUF9BNF9zdWJwX2MoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAg
IFRDR3YgTFNCID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgVENHdl9pNjQgTFNCX2k2NCA9
IHRjZ190ZW1wX25ld19pNjQoKTsgXAorICAgICAgICBUQ0d2X2k2NCB0bXBfaTY0ID0gdGNnX3Rl
bXBfbmV3X2k2NCgpOyBcCisgICAgICAgIFRDR3YgdG1wID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAg
ICAgICAgdGNnX2dlbl9ub3RfaTY0KHRtcF9pNjQsIFJ0dFYpOyBcCisgICAgICAgIHRjZ19nZW5f
YWRkX2k2NChSZGRWLCBSc3NWLCB0bXBfaTY0KTsgXAorICAgICAgICBmTFNCT0xEKFB4Vik7IFwK
KyAgICAgICAgdGNnX2dlbl9leHR1X2kzMl9pNjQoTFNCX2k2NCwgTFNCKTsgXAorICAgICAgICB0
Y2dfZ2VuX2FkZF9pNjQoUmRkViwgUmRkViwgTFNCX2k2NCk7IFwKKyAgICAgICAgZkNBUlJZX0ZS
T01fQUREKFJzc1YsIHRtcF9pNjQsIExTQl9pNjQpOyBcCisgICAgICAgIHRjZ19nZW5fZXh0cmxf
aTY0X2kzMih0bXAsIFJzc1YpOyBcCisgICAgICAgIGY4QklUU09GKFB4ViwgdG1wKTsgXAorICAg
ICAgICB0Y2dfdGVtcF9mcmVlKExTQik7IFwKKyAgICAgICAgdGNnX3RlbXBfZnJlZV9pNjQoTFNC
X2k2NCk7IFwKKyAgICAgICAgdGNnX3RlbXBfZnJlZV9pNjQodG1wX2k2NCk7IFwKKyAgICAgICAg
dGNnX3RlbXBfZnJlZSh0bXApOyBcCisgICAgfSB3aGlsZSAoMCkKKworLyoKKyAqIENvbXBhcmUg
ZWFjaCBvZiB0aGUgOCB1bnNpZ25lZCBieXRlcworICogVGhlIG1pbmltdW0gaXMgcGxhY2VzIGlu
IGVhY2ggYnl0ZSBvZiB0aGUgZGVzdGluYXRpb24uCisgKiBFYWNoIGJpdCBvZiB0aGUgcHJlZGlj
YXRlIGlzIHNldCB0cnVlIGlmIHRoZSBiaXQgZnJvbSB0aGUgZmlyc3Qgb3BlcmFuZAorICogaXMg
Z3JlYXRlciB0aGFuIHRoZSBiaXQgZnJvbSB0aGUgc2Vjb25kIG9wZXJhbmQuCisgKiByNTo0LHAx
ID0gdm1pbnViKHIxOjAsIHIzOjIpCisgKi8KKyNkZWZpbmUgZldSQVBfQTZfdm1pbnViX1JkUChH
RU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgVENHdiBCWVRFID0gdGNn
X3RlbXBfbmV3KCk7IFwKKyAgICAgICAgVENHdiBsZWZ0ID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAg
ICAgICAgVENHdiByaWdodCA9IHRjZ190ZW1wX25ldygpOyBcCisgICAgICAgIFRDR3YgdG1wID0g
dGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgaW50IGk7IFwKKyAgICAgICAgdGNnX2dlbl9tb3Zp
X3RsKFBlViwgMCk7IFwKKyAgICAgICAgdGNnX2dlbl9tb3ZpX2k2NChSZGRWLCAwKTsgXAorICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgODsgaSsrKSB7IFwKKyAgICAgICAgICAgIGZHRVRVQllURShp
LCBSdHRWKTsgXAorICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwobGVmdCwgQllURSk7IFwKKyAg
ICAgICAgICAgIGZHRVRVQllURShpLCBSc3NWKTsgXAorICAgICAgICAgICAgdGNnX2dlbl9tb3Zf
dGwocmlnaHQsIEJZVEUpOyBcCisgICAgICAgICAgICB0Y2dfZ2VuX3NldGNvbmRfdGwoVENHX0NP
TkRfR1QsIHRtcCwgbGVmdCwgcmlnaHQpOyBcCisgICAgICAgICAgICBmU0VUQklUKGksIFBlViwg
dG1wKTsgXAorICAgICAgICAgICAgZk1JTih0bXAsIGxlZnQsIHJpZ2h0KTsgXAorICAgICAgICAg
ICAgZlNFVEJZVEUoaSwgUmRkViwgdG1wKTsgXAorICAgICAgICB9IFwKKyAgICAgICAgdGNnX3Rl
bXBfZnJlZShCWVRFKTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKGxlZnQpOyBcCisgICAgICAg
IHRjZ190ZW1wX2ZyZWUocmlnaHQpOyBcCisgICAgICAgIHRjZ190ZW1wX2ZyZWUodG1wKTsgXAor
ICAgIH0gd2hpbGUgKDApCisKKyNkZWZpbmUgZldSQVBfSjJfY2FsbChHRU5ITFBSLCBTSE9SVENP
REUpIFwKKyAgICBnZW5fY2FsbChyaVYpCisjZGVmaW5lIGZXUkFQX0oyX2NhbGxyKEdFTkhMUFIs
IFNIT1JUQ09ERSkgXAorICAgIGdlbl9jYWxscihSc1YpCisKKyNkZWZpbmUgZldSQVBfSjJfbG9v
cDByKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl9sb29wMHIoUnNWLCByaVYsIGluc24p
CisjZGVmaW5lIGZXUkFQX0oyX2xvb3AxcihHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5f
bG9vcDFyKFJzViwgcmlWLCBpbnNuKQorCisjZGVmaW5lIGZXUkFQX0oyX2VuZGxvb3AwKEdFTkhM
UFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl9lbmRsb29wMCgpCisjZGVmaW5lIGZXUkFQX0oyX2Vu
ZGxvb3AxKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl9lbmRsb29wMSgpCisKICNlbmRp
ZgotLSAKMi43LjQKCg==

