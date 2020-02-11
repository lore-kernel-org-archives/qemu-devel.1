Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68EAC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CEF20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 01:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y7QcN+fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CEF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1KBc-0007rB-On
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 20:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jck-0002Mz-6B
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jci-0001n1-Ra
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:58 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jci-0004uP-H4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381716; x=1612917716;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fX4jiaKRL0KvmyYNfuCszvooVtv6M9+V3zlzTkr/sxI=;
 b=Y7QcN+fgFEg2ZINQaifuV99RYxyjrZS3Ry8NildaDkpnmm2YhfaDrPV9
 RVhzkIEuAKhv4j8IxbvZcfUU7r1+o9fdj2s9aR6CeUky1IO/v2hIhQN7K
 1RyHZcKf/vEZjmUu4raMu4g6Vte97raHev2927vFPgam7IXQvUrfzq/Vc Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:41:02 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id C33FE1BB0; Mon, 10 Feb 2020 18:41:01 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 48/66] Hexagon TCG generation - step 11
Date: Mon, 10 Feb 2020 18:40:26 -0600
Message-Id: <1581381644-13678-49-git-send-email-tsimpson@quicinc.com>
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

T3ZlcnJpZGUgY29tcGFyZSwgdHJhbnNmZXIsIGNvbmRpdGlvbmFsIGp1bXAgaW5zdHJ1Y3Rpb25z
CgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oIHwgMTE5ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTE5IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXJfb3ZlcnJpZGVzLmggYi90YXJn
ZXQvaGV4YWdvbi9oZWxwZXJfb3ZlcnJpZGVzLmgKaW5kZXggYzY1MWJiYy4uMjU5NzE2ZiAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2hlbHBlcl9vdmVycmlkZXMuaApAQCAtMTQzMiw0ICsxNDMyLDEyMyBAQAogI2RlZmlu
ZSBmV1JBUF9KNF9jbXBlcV90cDBfanVtcF90KEdFTkhMUFIsIFNIT1JUQ09ERSkgXAogICAgIGdl
bl9jbXBuZF9jbXBfam1wKDAsIFRDR19DT05EX0VRLCB0cnVlLCBSc1YsIFJ0ViwgcmlWKQogCisv
KiBwMCA9IGNtcC5lcShyMCwgIzcpICovCisjZGVmaW5lIGZXUkFQX1NBMV9jbXBlcWkoR0VOSExQ
UiwgU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3YgdG1wID0gdGNnX3RlbXBf
bmV3KCk7IFwKKyAgICAgICAgZ2VuX2NvbXBhcmVpKFRDR19DT05EX0VRLCB0bXAsIFJzViwgdWlW
KTsgXAorICAgICAgICBnZW5fbG9nX3ByZWRfd3JpdGUoMCwgdG1wKTsgXAorICAgICAgICB0Y2df
dGVtcF9mcmVlKHRtcCk7IFwKKyAgICB9IHdoaWxlICgwKQorCisvKiByMCA9IGFkZChyMjksIzgp
ICovCisjZGVmaW5lIGZXUkFQX1NBMV9hZGRzcChHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICB0
Y2dfZ2VuX2FkZGlfdGwoUmRWLCBoZXhfZ3ByW0hFWF9SRUdfU1BdLCBJTU1OTygwKSkKKworLyog
cjAgPSBhZGQocjAsIHIxKSAqLworI2RlZmluZSBmV1JBUF9TQTFfYWRkcngoR0VOSExQUiwgU0hP
UlRDT0RFKSBcCisgICAgdGNnX2dlbl9hZGRfdGwoUnhWLCBSeFYsIFJzVikKKworI2RlZmluZSBm
V1JBUF9BMl9hZGQoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9hZGRfdGwoUmRW
LCBSc1YsIFJ0VikKKworI2RlZmluZSBmV1JBUF9BMl9zdWIoR0VOSExQUiwgU0hPUlRDT0RFKSBc
CisgICAgdGNnX2dlbl9zdWJfdGwoUmRWLCBSdFYsIFJzVikKKworLyogcjAgPSBzdWIoIzEwLCBy
MSkgKi8KKyNkZWZpbmUgZldSQVBfQTJfc3VicmkoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAg
dGNnX2dlbl9zdWJmaV90bChSZFYsIHNpViwgUnNWKQorCisjZGVmaW5lIGZXUkFQX0EyX2FkZGko
R0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9hZGRpX3RsKFJkViwgUnNWLCBzaVYp
CisKKyNkZWZpbmUgZldSQVBfQTJfYW5kKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIHRjZ19n
ZW5fYW5kX3RsKFJkViwgUnNWLCBSdFYpCisKKyNkZWZpbmUgZldSQVBfQTJfYW5kaXIoR0VOSExQ
UiwgU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9hbmRpX3RsKFJkViwgUnNWLCBzaVYpCisKKyNk
ZWZpbmUgZldSQVBfQTJfeG9yKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5feG9y
X3RsKFJkViwgUnNWLCBSdFYpCisKKy8qIFRyYW5zZmVyIGluc3RydWN0aW9ucyAqLworI2RlZmlu
ZSBmV1JBUF9BMl90ZnIoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9tb3ZfdGwo
UmRWLCBSc1YpCisjZGVmaW5lIGZXUkFQX1NBMV90ZnIoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisg
ICAgdGNnX2dlbl9tb3ZfdGwoUmRWLCBSc1YpCisjZGVmaW5lIGZXUkFQX0EyX3RmcnNpKEdFTkhM
UFIsIFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92aV90bChSZFYsIHNpVikKKyNkZWZpbmUg
ZldSQVBfQTJfdGZyY3JyKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fbW92X3Rs
KFJkViwgQ3NWKQorI2RlZmluZSBmV1JBUF9BMl90ZnJyY3IoR0VOSExQUiwgU0hPUlRDT0RFKSBc
CisgICAgdGNnX2dlbl9tb3ZfdGwoQ2RWLCBSc1YpCisKKyNkZWZpbmUgZldSQVBfQTJfbm9wKEdF
TkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGRvIHsgfSB3aGlsZSAoMCkKKworLyogQ29tcGFyZSBp
bnN0cnVjdGlvbnMgKi8KKyNkZWZpbmUgZldSQVBfQzJfY21wZXEoR0VOSExQUiwgU0hPUlRDT0RF
KSBcCisgICAgZ2VuX2NvbXBhcmUoVENHX0NPTkRfRVEsIFBkViwgUnNWLCBSdFYpCisjZGVmaW5l
IGZXUkFQX0M0X2NtcG5lcShHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fY29tcGFyZShU
Q0dfQ09ORF9ORSwgUGRWLCBSc1YsIFJ0VikKKyNkZWZpbmUgZldSQVBfQzJfY21wZ3QoR0VOSExQ
UiwgU0hPUlRDT0RFKSBcCisgICAgZ2VuX2NvbXBhcmUoVENHX0NPTkRfR1QsIFBkViwgUnNWLCBS
dFYpCisjZGVmaW5lIGZXUkFQX0MyX2NtcGd0dShHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBn
ZW5fY29tcGFyZShUQ0dfQ09ORF9HVFUsIFBkViwgUnNWLCBSdFYpCisjZGVmaW5lIGZXUkFQX0M0
X2NtcGx0ZShHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fY29tcGFyZShUQ0dfQ09ORF9M
RSwgUGRWLCBSc1YsIFJ0VikKKyNkZWZpbmUgZldSQVBfQzRfY21wbHRldShHRU5ITFBSLCBTSE9S
VENPREUpIFwKKyAgICBnZW5fY29tcGFyZShUQ0dfQ09ORF9MRVUsIFBkViwgUnNWLCBSdFYpCisj
ZGVmaW5lIGZXUkFQX0MyX2NtcGVxcChHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fY29t
cGFyZV9pNjQoVENHX0NPTkRfRVEsIFBkViwgUnNzViwgUnR0VikKKyNkZWZpbmUgZldSQVBfQzJf
Y21wZ3RwKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl9jb21wYXJlX2k2NChUQ0dfQ09O
RF9HVCwgUGRWLCBSc3NWLCBSdHRWKQorI2RlZmluZSBmV1JBUF9DMl9jbXBndHVwKEdFTkhMUFIs
IFNIT1JUQ09ERSkgXAorICAgIGdlbl9jb21wYXJlX2k2NChUQ0dfQ09ORF9HVFUsIFBkViwgUnNz
ViwgUnR0VikKKyNkZWZpbmUgZldSQVBfQzJfY21wZXFpKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAor
ICAgIGdlbl9jb21wYXJlaShUQ0dfQ09ORF9FUSwgUGRWLCBSc1YsIHNpVikKKyNkZWZpbmUgZldS
QVBfQzJfY21wZ3RpKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl9jb21wYXJlaShUQ0df
Q09ORF9HVCwgUGRWLCBSc1YsIHNpVikKKyNkZWZpbmUgZldSQVBfQzJfY21wZ3R1aShHRU5ITFBS
LCBTSE9SVENPREUpIFwKKyAgICBnZW5fY29tcGFyZWkoVENHX0NPTkRfR1RVLCBQZFYsIFJzViwg
dWlWKQorCisjZGVmaW5lIGZXUkFQX1NBMV96eHRiKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAg
IHRjZ19nZW5fZXh0OHVfdGwoUmRWLCBSc1YpCisKKyNkZWZpbmUgZldSQVBfSjJfanVtcChHRU5I
TFBSLCBTSE9SVENPREUpIFwKKyAgICBnZW5fanVtcChyaVYpCisjZGVmaW5lIGZXUkFQX0oyX2p1
bXByKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl93cml0ZV9uZXdfcGMoUnNWKQorCisj
ZGVmaW5lIGZXUkFQX2NvbmRfanVtcChDT05EKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3Yg
TFNCID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAgQ09ORDsgXAorICAgICAgICBnZW5fY29u
ZF9qdW1wKExTQiwgcmlWKTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKExTQik7IFwKKyAgICB9
IHdoaWxlICgwKQorCisjZGVmaW5lIGZXUkFQX0oyX2p1bXB0KEdFTkhMUFIsIFNIT1JUQ09ERSkg
XAorICAgIGZXUkFQX2NvbmRfanVtcChmTFNCT0xEKFB1VikpCisjZGVmaW5lIGZXUkFQX0oyX2p1
bXBmKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX2NvbmRfanVtcChmTFNCT0xETk9U
KFB1VikpCisjZGVmaW5lIGZXUkFQX0oyX2p1bXBmbmV3cHQoR0VOSExQUiwgU0hPUlRDT0RFKSBc
CisgICAgZldSQVBfY29uZF9qdW1wKGZMU0JORVdOT1QoUHVOKSkKKyNkZWZpbmUgZldSQVBfSjJf
anVtcGZuZXcoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZldSQVBfY29uZF9qdW1wKGZMU0JO
RVdOT1QoUHVOKSkKKworI2RlZmluZSBmV1JBUF9KMl9qdW1wcmZuZXcoR0VOSExQUiwgU0hPUlRD
T0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIFRDR3YgTFNCID0gdGNnX3RlbXBfbmV3KCk7IFwK
KyAgICAgICAgdGNnX2dlbl9hbmRpX3RsKExTQiwgUHVOLCAxKTsgXAorICAgICAgICB0Y2dfZ2Vu
X3hvcmlfdGwoTFNCLCBMU0IsIDEpOyBcCisgICAgICAgIGdlbl9jb25kX2p1bXByKExTQiwgUnNW
KTsgXAorICAgICAgICB0Y2dfdGVtcF9mcmVlKExTQik7IFwKKyAgICB9IHdoaWxlICgwKQorCisj
ZGVmaW5lIGZXUkFQX0oyX2p1bXB0bmV3KEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGdlbl9j
b25kX2p1bXAoUHVOLCByaVYpCisjZGVmaW5lIGZXUkFQX0oyX2p1bXB0bmV3cHQoR0VOSExQUiwg
U0hPUlRDT0RFKSBcCisgICAgZ2VuX2NvbmRfanVtcChQdU4sIHJpVikKKwogI2VuZGlmCi0tIAoy
LjcuNAoK

