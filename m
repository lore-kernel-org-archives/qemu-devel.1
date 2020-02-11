Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7CBC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFE020733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vdw+549L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFE020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1JlS-0000Jw-3a
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jc5-0001F1-3i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jc3-00065O-MM
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:16 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jc3-0004rC-9C
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381675; x=1612917675;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DsPb9ZrhIOPWCPBc/NbxH6Sx3sRh6HvhM1GYlZsZvgI=;
 b=Vdw+549LP82LkIsIFrZWNx8PrNlDVq6S9fHT7Rtip1D7j3kTlrygPeWX
 Cgdt3v2u0yyt/gw2x5sknZ87Z2idhfem92nTl0B+pzAVYvk88s3IYmJgg
 ri7WSQMIAitNqj/1MDdAPWIxoOCv5il2uGfXKU5R74CGVqC6eZSpg/4TD 8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:41:00 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg03-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:00 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id D57F11B42; Mon, 10 Feb 2020 18:40:59 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 25/66] Hexagon generator phase 2 - op_regs_generated.h
Date: Mon, 10 Feb 2020 18:40:03 -0600
Message-Id: <1581381644-13678-26-git-send-email-tsimpson@quicinc.com>
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

TGlzdHMgdGhlIHJlZ2lzdGVyIGFuZCBpbW1lZGlhdGUgb3BlcmFuZHMgZm9yIGVhY2ggaW5zdHJ1
Y3Rpb24KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kb19xZW11LnB5IHwgODYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4NiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZG9fcWVtdS5weSBiL3RhcmdldC9o
ZXhhZ29uL2RvX3FlbXUucHkKaW5kZXggZjI5NzkzMS4uNzUyMDQ2NCAxMDA3NTUKLS0tIGEvdGFy
Z2V0L2hleGFnb24vZG9fcWVtdS5weQorKysgYi90YXJnZXQvaGV4YWdvbi9kb19xZW11LnB5CkBA
IC04MTAsMyArODEwLDg5IEBAIHJlYWxmLndyaXRlKGYuZ2V0dmFsdWUoKSkKIHJlYWxmLmNsb3Nl
KCkKIGYuY2xvc2UoKQogCisjIworIyMgR2VuZXJhdGUgdGhlIG9wX3JlZ3NfZ2VuZXJhdGVkLmgg
ZmlsZQorIyMgICAgIExpc3RzIHRoZSByZWdpc3RlciBhbmQgaW1tZWRpYXRlIG9wZXJhbmRzIGZv
ciBlYWNoIGluc3RydWN0aW9uCisjIworZGVmIGNhbGN1bGF0ZV9yZWdpZF9yZWcodGFnKToKKyAg
ICBkZWYgbGV0dGVyX2luYyh4KTogcmV0dXJuIGNocihvcmQoeCkrMSkKKyAgICBvcmRlcmVkX2lt
cGxyZWdzID0gWyAnU1AnLCdGUCcsJ0xSJyBdCisgICAgc3JjZHN0X2xldHQgPSAnWCcKKyAgICBz
cmNfbGV0dCA9ICdTJworICAgIGRzdF9sZXR0ID0gJ0QnCisgICAgcmV0c3RyID0gIiIKKyAgICBt
YXBkaWN0ID0ge30KKyAgICBmb3IgcmVnIGluIG9yZGVyZWRfaW1wbHJlZ3M6CisgICAgICAgIHJl
Z19yZCA9IDAKKyAgICAgICAgcmVnX3dyID0gMAorICAgICAgICBpZiAoJ0FfSU1QTElDSVRfUkVB
RFNfJytyZWcpIGluIGF0dHJpYmRpY3RbdGFnXTogcmVnX3JkID0gMQorICAgICAgICBpZiAoJ0Ff
SU1QTElDSVRfV1JJVEVTXycrcmVnKSBpbiBhdHRyaWJkaWN0W3RhZ106IHJlZ193ciA9IDEKKyAg
ICAgICAgaWYgcmVnX3JkIGFuZCByZWdfd3I6CisgICAgICAgICAgICByZXRzdHIgKz0gc3JjZHN0
X2xldHQKKyAgICAgICAgICAgIG1hcGRpY3Rbc3JjZHN0X2xldHRdID0gcmVnCisgICAgICAgICAg
ICBzcmNkc3RfbGV0dCA9IGxldHRlcl9pbmMoc3JjZHN0X2xldHQpCisgICAgICAgIGVsaWYgcmVn
X3JkOgorICAgICAgICAgICAgcmV0c3RyICs9IHNyY19sZXR0CisgICAgICAgICAgICBtYXBkaWN0
W3NyY19sZXR0XSA9IHJlZworICAgICAgICAgICAgc3JjX2xldHQgPSBsZXR0ZXJfaW5jKHNyY19s
ZXR0KQorICAgICAgICBlbGlmIHJlZ193cjoKKyAgICAgICAgICAgIHJldHN0ciArPSBkc3RfbGV0
dAorICAgICAgICAgICAgbWFwZGljdFtkc3RfbGV0dF0gPSByZWcKKyAgICAgICAgICAgIGRzdF9s
ZXR0ID0gbGV0dGVyX2luYyhkc3RfbGV0dCkKKyAgICByZXR1cm4gcmV0c3RyLG1hcGRpY3QKKwor
ZGVmIGNhbGN1bGF0ZV9yZWdpZF9sZXR0ZXJzKHRhZyk6CisgICAgcmV0c3RyLG1hcGRpY3QgPSBj
YWxjdWxhdGVfcmVnaWRfcmVnKHRhZykKKyAgICByZXR1cm4gcmV0c3RyCisKK2RlZiBzdHJpcF92
ZXJpZl9pbmZvX2luX3JlZ3MoeCk6CisgICAgeT14LnJlcGxhY2UoJ1VSRUcuJywnJykKKyAgICB5
PXkucmVwbGFjZSgnTVJFRy4nLCcnKQorICAgIHJldHVybiB5LnJlcGxhY2UoJ0dSRUcuJywnJykK
KworZiA9IFN0cmluZ0lPKCkKKworZm9yIHRhZyBpbiB0YWdzOgorICAgIHJlZ3MgPSB0YWdyZWdz
W3RhZ10KKyAgICBycmVncyA9IFtdCisgICAgd3JlZ3MgPSBbXQorICAgIHJlZ2lkcyA9ICIiCisg
ICAgZm9yIHJlZ3R5cGUscmVnaWQsdG9zcyxudW1yZWdzIGluIHJlZ3M6CisgICAgICAgIGlmIGlz
X3JlYWQocmVnaWQpOgorICAgICAgICAgICAgaWYgcmVnaWRbMF0gbm90IGluIHJlZ2lkczogcmVn
aWRzICs9IHJlZ2lkWzBdCisgICAgICAgICAgICBycmVncy5hcHBlbmQocmVndHlwZStyZWdpZCtu
dW1yZWdzKQorICAgICAgICBpZiBpc193cml0dGVuKHJlZ2lkKToKKyAgICAgICAgICAgIHdyZWdz
LmFwcGVuZChyZWd0eXBlK3JlZ2lkK251bXJlZ3MpCisgICAgICAgICAgICBpZiByZWdpZFswXSBu
b3QgaW4gcmVnaWRzOiByZWdpZHMgKz0gcmVnaWRbMF0KKyAgICBmb3IgYXR0cmliIGluIGF0dHJp
YmRpY3RbdGFnXToKKyAgICAgICAgaWYgYXR0cmliaW5mb1thdHRyaWJdWydycmVnJ106CisgICAg
ICAgICAgICBycmVncy5hcHBlbmQoc3RyaXBfdmVyaWZfaW5mb19pbl9yZWdzKGF0dHJpYmluZm9b
YXR0cmliXVsncnJlZyddKSkKKyAgICAgICAgaWYgYXR0cmliaW5mb1thdHRyaWJdWyd3cmVnJ106
CisgICAgICAgICAgICB3cmVncy5hcHBlbmQoc3RyaXBfdmVyaWZfaW5mb19pbl9yZWdzKGF0dHJp
YmluZm9bYXR0cmliXVsnd3JlZyddKSkKKyAgICByZWdpZHMgKz0gY2FsY3VsYXRlX3JlZ2lkX2xl
dHRlcnModGFnKQorICAgIGYud3JpdGUoJ1JFR0lORk8oJXMsIiVzIixcdC8qUkQ6Ki9cdCIlcyIs
XHQvKldSOiovXHQiJXMiKVxuJyAlIFwKKyAgICAgICAgKHRhZyxyZWdpZHMsIiwiLmpvaW4ocnJl
Z3MpLCIsIi5qb2luKHdyZWdzKSkpCisKK2ZvciB0YWcgaW4gdGFnczoKKyAgICBpbW1zID0gdGFn
aW1tc1t0YWddCisgICAgZi53cml0ZSggJ0lNTUlORk8oJXMnICUgdGFnKQorICAgIGlmIG5vdCBp
bW1zOgorICAgICAgICBmLndyaXRlKCcnJywndScsMCwwLCdVJywwLDAnJycpCisgICAgZm9yIHNp
Z24sc2l6ZSxzaGFtdCBpbiBpbW1zOgorICAgICAgICBpZiBzaWduID09ICdyJzogc2lnbiA9ICdz
JworICAgICAgICBpZiBub3Qgc2hhbXQ6CisgICAgICAgICAgICBzaGFtdCA9ICIwIgorICAgICAg
ICBmLndyaXRlKCcnJywnJXMnLCVzLCVzJycnICUgKHNpZ24sc2l6ZSxzaGFtdCkpCisgICAgaWYg
bGVuKGltbXMpID09IDE6CisgICAgICAgIGlmIHNpZ24uaXN1cHBlcigpOgorICAgICAgICAgICAg
bXl1ID0gJ3UnCisgICAgICAgIGVsc2U6CisgICAgICAgICAgICBteXUgPSAnVScKKyAgICAgICAg
Zi53cml0ZSgnJycsJyVzJywwLDAnJycgJSBteXUpCisgICAgZi53cml0ZSgnKVxuJykKKworcmVh
bGYgPSBvcGVuKCdvcF9yZWdzX2dlbmVyYXRlZC5oJywndycpCityZWFsZi53cml0ZShmLmdldHZh
bHVlKCkpCityZWFsZi5jbG9zZSgpCitmLmNsb3NlKCkKKwotLSAKMi43LjQKCg==

