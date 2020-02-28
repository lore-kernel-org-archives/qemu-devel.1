Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446D0C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE18246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjHepxBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE18246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jJ1-0008GM-7v
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7im0-0005Zr-Bz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ilz-000790-6v
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:46:00 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ilV-0005U4-Bb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908329; x=1614444329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zimOGde4GqV2wvJVLvI614WBNtqG6TBT/TyqREXlewQ=;
 b=FjHepxBPURgZFPWIRg4qjmk3ZYCD1optzLKYzIJWyRBED12JELHnNzmq
 zg+2Bz9+uZK6+y6khgmOvFylpQ1Y7DQaezKhJf318s8yhEZ88RZwAa6ZM
 GpxoqeQ4MoYtk4eeap3Rdmi2SJEQ1+CEmMw0XwbIrvYcJImvU2Fbkv+TT c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2020 08:44:33 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg04-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:32 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id C0C5FFD8; Fri, 28 Feb 2020 10:44:31 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 46/67] Hexagon TCG generation - step 08
Date: Fri, 28 Feb 2020 10:43:42 -0600
Message-Id: <1582908244-304-47-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
References: <1582908244-304-1-git-send-email-tsimpson@quicinc.com>
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

T3ZlcnJpZGUgbWF0aGVtYXRpY2FsIG9wZXJhdGlvbnMgd2l0aCBtb3JlIHRoYW4gb25lIGRlZmlu
aXRpb24KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXJfb3ZlcnJpZGVzLmggfCAzMCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyX292ZXJyaWRlcy5oIGIvdGFyZ2V0L2hl
eGFnb24vaGVscGVyX292ZXJyaWRlcy5oCmluZGV4IDFhYzM2M2UuLmQxOGFlYTQgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlcl9vdmVycmlkZXMuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9oZWxwZXJfb3ZlcnJpZGVzLmgKQEAgLTEyMDAsNCArMTIwMCwzNCBAQAogI2RlZmluZSBmV1JB
UF9TTDJfcmV0dXJuX2ZuZXcoR0VOSExQUiwgU0hPUlRDT0RFKSBcCiAgICAgZldSQVBfQ09ORF9S
RVRVUk5fU1VCSU5TTihmTFNCTkVXME5PVCkKIAorLyoKKyAqIE1hdGhlbWF0aWNhbCBvcGVyYXRp
b25zIHdpdGggbW9yZSB0aGFuIG9uZSBkZWZpbml0aW9uIHJlcXVpcmUKKyAqIHNwZWNpYWwgaGFu
ZGxpbmcKKyAqLworLyoKKyAqIEFwcHJveGltYXRlIHJlY2lwcm9jYWwKKyAqIHIzLHAxID0gc2Zy
ZWNpcGEocjAsIHIxKQorICovCisjZGVmaW5lIGZXUkFQX0YyX3NmcmVjaXBhKEdFTkhMUFIsIFNI
T1JUQ09ERSkgXAorICAgIGRvIHsgXAorICAgICAgICBnZW5faGVscGVyX3NmcmVjaXBhX3ZhbChS
ZFYsIGNwdV9lbnYsIFJzViwgUnRWKTsgIFwKKyAgICAgICAgZ2VuX2hlbHBlcl9zZnJlY2lwYV9w
cmVkKFBlViwgY3B1X2VudiwgUnNWLCBSdFYpOyAgXAorICAgIH0gd2hpbGUgKDApCisKKy8qCisg
KiBBcHByb3hpbWF0aW9uIG9mIHRoZSByZWNpcHJvY2FsIHNxdWFyZSByb290CisgKiByMSxwMCA9
IHNmaW52c3FydGEocjApCisgKi8KKyNkZWZpbmUgZldSQVBfRjJfc2ZpbnZzcXJ0YShHRU5ITFBS
LCBTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgZ2VuX2hlbHBlcl9zZmludnNxcnRh
X3ZhbChSZFYsIGNwdV9lbnYsIFJzVik7IFwKKyAgICAgICAgZ2VuX2hlbHBlcl9zZmludnNxcnRh
X3ByZWQoUGVWLCBjcHVfZW52LCBSc1YpOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmluZSBm
V1JBUF9BNV9BQ1MoR0VOSExQUiwgU0hPUlRDT0RFKSBcCisgICAgZG8geyBcCisgICAgICAgIGdl
bl9oZWxwZXJfdmFjc2hfdmFsKFJ4eFYsIGNwdV9lbnYsIFJ4eFYsIFJzc1YsIFJ0dFYpOyBcCisg
ICAgICAgIGdlbl9oZWxwZXJfdmFjc2hfcHJlZChQZVYsIGNwdV9lbnYsIFJ4eFYsIFJzc1YsIFJ0
dFYpOyBcCisgICAgfSB3aGlsZSAoMCkKKwogI2VuZGlmCi0tIAoyLjcuNAoK

