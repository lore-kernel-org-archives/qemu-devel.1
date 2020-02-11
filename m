Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B2FC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261F32072C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J2IyYidd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261F32072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jpo-0007lq-57
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jcc-000255-MJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1JcY-0000hj-Nw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:50 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1JcY-0004tJ-Dh
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381706; x=1612917706;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iOQNsCZ4evIQuzTuaS4Cp0fX0eb3+OuF6jTFmobH020=;
 b=J2IyYiddPCpn4PDt08B2r5DwFBINwuVltsNw1FWtLb2h8Xj1whQJ4bDu
 n37jW/Vl4hSCLvmqQBA/CPc8aNyIIuYgriVyHxzGmoNm+IESt7bZ6oPr9
 Qy8jsjTmxau4TV9/w/29mK5IUSQ/12JOKPVIowapoMa8T8OHRYsLKBlQj k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Feb 2020 16:41:02 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg05-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:41:01 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 63B581B5B; Mon, 10 Feb 2020 18:41:01 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 43/66] Hexagon TCG generation - step 06
Date: Mon, 10 Feb 2020 18:40:21 -0600
Message-Id: <1581381644-13678-44-git-send-email-tsimpson@quicinc.com>
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

T3ZlcnJpZGUgbWVtb3AgaW5zdHJ1Y3Rpb25zCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNv
biA8dHNpbXBzb25AcXVpY2luYy5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGVscGVyX292ZXJy
aWRlcy5oIHwgNjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2hlbHBlcl9vdmVycmlkZXMuaCBiL3RhcmdldC9oZXhhZ29uL2hlbHBlcl9vdmVycmlkZXMuaApp
bmRleCA5NzkxZDMzLi5mMDIzNDQyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXJf
b3ZlcnJpZGVzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oCkBAIC05
MzEsNCArOTMxLDY0IEBACiAgICAgZldSQVBfUFJFRF9TVE9SRShmRUFfSU1NKHVpViksIGZMU0JO
RVdOT1QoUHZOKSwgXAogICAgICAgICAgICAgICAgICAgICAgZkdFVEJZVEUoMCwgaGV4X25ld192
YWx1ZVtOdFhdKSwgMSwgTk9JTkMpCiAKKy8qIFdlIGhhdmUgdG8gYnJ1dGUgZm9yY2UgbWVtb3Bz
IGJlY2F1c2UgdGhleSBoYXZlIEMgbWF0aCBpbiB0aGUgc2VtYW50aWNzICovCisjZGVmaW5lIGZX
UkFQX01FTU9QKEdFTkhMUFIsIFNIT1JUQ09ERSwgU0laRSwgT1ApIFwKKyAgICBkbyB7IFwKKyAg
ICAgICAgVENHdiB0bXAgPSB0Y2dfdGVtcF9uZXcoKTsgXAorICAgICAgICBmRUFfUkkoUnNWLCB1
aVYpOyBcCisgICAgICAgIGZMT0FEKDEsIFNJWkUsIHMsIEVBLCB0bXApOyBcCisgICAgICAgIE9Q
OyBcCisgICAgICAgIGZTVE9SRSgxLCBTSVpFLCBFQSwgdG1wKTsgXAorICAgICAgICB0Y2dfdGVt
cF9mcmVlKHRtcCk7IFwKKyAgICB9IHdoaWxlICgwKQorCisjZGVmaW5lIGZXUkFQX0w0X2FkZF9t
ZW1vcHdfaW8oR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZldSQVBfTUVNT1AoR0VOSExQUiwg
U0hPUlRDT0RFLCA0LCB0Y2dfZ2VuX2FkZF90bCh0bXAsIHRtcCwgUnRWKSkKKyNkZWZpbmUgZldS
QVBfTDRfYWRkX21lbW9wYl9pbyhHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9NRU1P
UChHRU5ITFBSLCBTSE9SVENPREUsIDEsIHRjZ19nZW5fYWRkX3RsKHRtcCwgdG1wLCBSdFYpKQor
I2RlZmluZSBmV1JBUF9MNF9hZGRfbWVtb3BoX2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAg
IGZXUkFQX01FTU9QKEdFTkhMUFIsIFNIT1JUQ09ERSwgMiwgdGNnX2dlbl9hZGRfdGwodG1wLCB0
bXAsIFJ0VikpCisjZGVmaW5lIGZXUkFQX0w0X3N1Yl9tZW1vcHdfaW8oR0VOSExQUiwgU0hPUlRD
T0RFKSBcCisgICAgZldSQVBfTUVNT1AoR0VOSExQUiwgU0hPUlRDT0RFLCA0LCB0Y2dfZ2VuX3N1
Yl90bCh0bXAsIHRtcCwgUnRWKSkKKyNkZWZpbmUgZldSQVBfTDRfc3ViX21lbW9wYl9pbyhHRU5I
TFBSLCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9NRU1PUChHRU5ITFBSLCBTSE9SVENPREUsIDEs
IHRjZ19nZW5fc3ViX3RsKHRtcCwgdG1wLCBSdFYpKQorI2RlZmluZSBmV1JBUF9MNF9zdWJfbWVt
b3BoX2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX01FTU9QKEdFTkhMUFIsIFNI
T1JUQ09ERSwgMiwgdGNnX2dlbl9zdWJfdGwodG1wLCB0bXAsIFJ0VikpCisjZGVmaW5lIGZXUkFQ
X0w0X2FuZF9tZW1vcHdfaW8oR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZldSQVBfTUVNT1Ao
R0VOSExQUiwgU0hPUlRDT0RFLCA0LCB0Y2dfZ2VuX2FuZF90bCh0bXAsIHRtcCwgUnRWKSkKKyNk
ZWZpbmUgZldSQVBfTDRfYW5kX21lbW9wYl9pbyhHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBm
V1JBUF9NRU1PUChHRU5ITFBSLCBTSE9SVENPREUsIDEsIHRjZ19nZW5fYW5kX3RsKHRtcCwgdG1w
LCBSdFYpKQorI2RlZmluZSBmV1JBUF9MNF9hbmRfbWVtb3BoX2lvKEdFTkhMUFIsIFNIT1JUQ09E
RSkgXAorICAgIGZXUkFQX01FTU9QKEdFTkhMUFIsIFNIT1JUQ09ERSwgMiwgdGNnX2dlbl9hbmRf
dGwodG1wLCB0bXAsIFJ0VikpCisjZGVmaW5lIGZXUkFQX0w0X29yX21lbW9wd19pbyhHRU5ITFBS
LCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9NRU1PUChHRU5ITFBSLCBTSE9SVENPREUsIDQsIHRj
Z19nZW5fb3JfdGwodG1wLCB0bXAsIFJ0VikpCisjZGVmaW5lIGZXUkFQX0w0X29yX21lbW9wYl9p
byhHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9NRU1PUChHRU5ITFBSLCBTSE9SVENP
REUsIDEsIHRjZ19nZW5fb3JfdGwodG1wLCB0bXAsIFJ0VikpCisjZGVmaW5lIGZXUkFQX0w0X29y
X21lbW9waF9pbyhHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9NRU1PUChHRU5ITFBS
LCBTSE9SVENPREUsIDIsIHRjZ19nZW5fb3JfdGwodG1wLCB0bXAsIFJ0VikpCisjZGVmaW5lIGZX
UkFQX0w0X2lhZGRfbWVtb3B3X2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX01F
TU9QKEdFTkhMUFIsIFNIT1JUQ09ERSwgNCwgdGNnX2dlbl9hZGRpX3RsKHRtcCwgdG1wLCBVaVYp
KQorI2RlZmluZSBmV1JBUF9MNF9pYWRkX21lbW9wYl9pbyhHRU5ITFBSLCBTSE9SVENPREUpIFwK
KyAgICBmV1JBUF9NRU1PUChHRU5ITFBSLCBTSE9SVENPREUsIDEsIHRjZ19nZW5fYWRkaV90bCh0
bXAsIHRtcCwgVWlWKSkKKyNkZWZpbmUgZldSQVBfTDRfaWFkZF9tZW1vcGhfaW8oR0VOSExQUiwg
U0hPUlRDT0RFKSBcCisgICAgZldSQVBfTUVNT1AoR0VOSExQUiwgU0hPUlRDT0RFLCAyLCB0Y2df
Z2VuX2FkZGlfdGwodG1wLCB0bXAsIFVpVikpCisjZGVmaW5lIGZXUkFQX0w0X2lzdWJfbWVtb3B3
X2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX01FTU9QKEdFTkhMUFIsIFNIT1JU
Q09ERSwgNCwgdGNnX2dlbl9zdWJpX3RsKHRtcCwgdG1wLCBVaVYpKQorI2RlZmluZSBmV1JBUF9M
NF9pc3ViX21lbW9wYl9pbyhHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9NRU1PUChH
RU5ITFBSLCBTSE9SVENPREUsIDEsIHRjZ19nZW5fc3ViaV90bCh0bXAsIHRtcCwgVWlWKSkKKyNk
ZWZpbmUgZldSQVBfTDRfaXN1Yl9tZW1vcGhfaW8oR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAg
ZldSQVBfTUVNT1AoR0VOSExQUiwgU0hPUlRDT0RFLCAyLCB0Y2dfZ2VuX3N1YmlfdGwodG1wLCB0
bXAsIFVpVikpCisjZGVmaW5lIGZXUkFQX0w0X2lhbmRfbWVtb3B3X2lvKEdFTkhMUFIsIFNIT1JU
Q09ERSkgXAorICAgIGZXUkFQX01FTU9QKEdFTkhMUFIsIFNIT1JUQ09ERSwgNCwgdGNnX2dlbl9h
bmRpX3RsKHRtcCwgdG1wLCB+KDEgPDwgVWlWKSkpCisjZGVmaW5lIGZXUkFQX0w0X2lhbmRfbWVt
b3BiX2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX01FTU9QKEdFTkhMUFIsIFNI
T1JUQ09ERSwgMSwgdGNnX2dlbl9hbmRpX3RsKHRtcCwgdG1wLCB+KDEgPDwgVWlWKSkpCisjZGVm
aW5lIGZXUkFQX0w0X2lhbmRfbWVtb3BoX2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZX
UkFQX01FTU9QKEdFTkhMUFIsIFNIT1JUQ09ERSwgMiwgdGNnX2dlbl9hbmRpX3RsKHRtcCwgdG1w
LCB+KDEgPDwgVWlWKSkpCisjZGVmaW5lIGZXUkFQX0w0X2lvcl9tZW1vcHdfaW8oR0VOSExQUiwg
U0hPUlRDT0RFKSBcCisgICAgZldSQVBfTUVNT1AoR0VOSExQUiwgU0hPUlRDT0RFLCA0LCB0Y2df
Z2VuX29yaV90bCh0bXAsIHRtcCwgMSA8PCBVaVYpKQorI2RlZmluZSBmV1JBUF9MNF9pb3JfbWVt
b3BiX2lvKEdFTkhMUFIsIFNIT1JUQ09ERSkgXAorICAgIGZXUkFQX01FTU9QKEdFTkhMUFIsIFNI
T1JUQ09ERSwgMSwgdGNnX2dlbl9vcmlfdGwodG1wLCB0bXAsIDEgPDwgVWlWKSkKKyNkZWZpbmUg
ZldSQVBfTDRfaW9yX21lbW9waF9pbyhHRU5ITFBSLCBTSE9SVENPREUpIFwKKyAgICBmV1JBUF9N
RU1PUChHRU5ITFBSLCBTSE9SVENPREUsIDIsIHRjZ19nZW5fb3JpX3RsKHRtcCwgdG1wLCAxIDw8
IFVpVikpCisKICNlbmRpZgotLSAKMi43LjQKCg==

