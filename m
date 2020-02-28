Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47787C3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170E12072A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lk3EdEIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170E12072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7jJo-0001Cn-5V
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ike-0002pA-E6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j7ika-0005XY-V0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j7ika-0005Ug-Il
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1582908272; x=1614444272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HYGhLhXmS2Pd2wefqh2Tib92Xjx/wOU8qBRvN2wX1PE=;
 b=Lk3EdEIXkBtFs8siMwo2rEE95XpTMmQ2qEPWGGvg88lTx9kObtQQV57B
 JdKBNSSwZjrzY+ApP77TJepAa9Loo4nt+WcmTOwcZA5Tb8SWNpHp58ZS+
 ht9M8/RsTJdqCnWY9s/h/ACc30mleLWxTuMT7D5P+rEAiuQ8+bUvJNKp1 Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2020 08:44:30 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 28 Feb 2020 08:44:29 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 5811F1102; Fri, 28 Feb 2020 10:44:29 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 19/67] Hexagon instruction class definitions
Date: Fri, 28 Feb 2020 10:43:15 -0600
Message-Id: <1582908244-304-20-git-send-email-tsimpson@quicinc.com>
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

ICAgIEltcG9ydGVkIGZyb20gdGhlIEhleGFnb24gYXJjaGl0ZWN0dXJlIGxpYnJhcnkKClNpZ25l
ZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZC9pY2xhc3MuZGVmIHwgNTIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvaWNsYXNzLmRlZgoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2ljbGFzcy5kZWYgYi90YXJnZXQvaGV4YWdv
bi9pbXBvcnRlZC9pY2xhc3MuZGVmCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjRlZjcyNWYKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9pY2xh
c3MuZGVmCkBAIC0wLDAgKzEsNTIgQEAKKy8qCisgKiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMCBR
dWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoK
KyAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQorICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisgKiAgdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqICAoYXQg
eW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorICoKKyAqICBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKKyAqICBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
ZgorICogIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUKKyAqICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLgorICoKKyAqICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBu
b3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uCisgKi8KKworLyogREVGXyoo
VFlQRSxTTE9UUyxVTklUUykgKi8KK0RFRl9QUF9JQ0xBU1MzMihFWFRFTkRFUiwwMTIzLExEU1R8
U1VOSVR8TVVOSVQpIC8qIDAgKi8KK0RFRl9QUF9JQ0xBU1MzMihDSiwwMTIzLENUUkxGTE9XKSAv
KiAxICovCitERUZfUFBfSUNMQVNTMzIoTkNKLDAxLExEU1R8Q1RSTEZMT1cpIC8qIDIgKi8KK0RF
Rl9QUF9JQ0xBU1MzMihWNExEU1QsMDEsTERTVCkgLyogMyAqLworREVGX1BQX0lDTEFTUzMyKFYy
TERTVCwwMSxMRFNUKSAvKiA0ICovCitERUZfUFBfSUNMQVNTMzIoSiwwMTIzLENUUkxGTE9XKSAg
LyogNSAqLworREVGX1BQX0lDTEFTUzMyKENSLDMsU1VOSVQpICAgICAvKiA2ICovCitERUZfUFBf
SUNMQVNTMzIoQUxVMzJfMm9wLDAxMjMsTERTVHxTVU5JVHxNVU5JVCkgLyogNyAqLworREVGX1BQ
X0lDTEFTUzMyKFNfMm9wLDIzLFNVTklUfE1VTklUKSAgICAgICAgICAgICAgIC8qIDggKi8KK0RF
Rl9QUF9JQ0xBU1MzMihMRCwwMSxMRFNUKSAgICAgICAgICAgICAgICAgICAgLyogOSAqLworREVG
X1BQX0lDTEFTUzMyKFNULDAxLExEU1QpICAgICAgICAgICAgICAgICAgICAgICAgLyogMTAgKi8K
K0RFRl9QUF9JQ0xBU1MzMihBTFUzMl9BRERJLDAxMjMsTERTVHxTVU5JVHxNVU5JVCkgLyogMTEg
Ki8KK0RFRl9QUF9JQ0xBU1MzMihTXzNvcCwyMyxTVU5JVHxNVU5JVCkgICAgICAgICAgICAgICAv
KiAxMiAqLworREVGX1BQX0lDTEFTUzMyKEFMVTY0LDIzLFNVTklUfE1VTklUKSAgICAgICAgICAg
ICAvKiAxMyAqLworREVGX1BQX0lDTEFTUzMyKE0sMjMsU1VOSVR8TVVOSVQpICAgICAgICAgICAg
ICAgICAvKiAxNCAqLworREVGX1BQX0lDTEFTUzMyKEFMVTMyXzNvcCwwMTIzLExEU1R8U1VOSVR8
TVVOSVQpIC8qIDE1ICovCisKK0RFRl9FRV9JQ0xBU1MzMihFRTAsMDEsSU5WQUxJRCkgLyogMCAq
LworREVGX0VFX0lDTEFTUzMyKEVFMSwwMSxJTlZBTElEKSAvKiAxICovCitERUZfRUVfSUNMQVNT
MzIoRUUyLDAxLElOVkFMSUQpIC8qIDIgKi8KK0RFRl9FRV9JQ0xBU1MzMihFRTMsMDEsSU5WQUxJ
RCkgLyogMyAqLworREVGX0VFX0lDTEFTUzMyKEVFNCwwMSxJTlZBTElEKSAvKiA0ICovCitERUZf
RUVfSUNMQVNTMzIoRUU1LDAxLElOVkFMSUQpIC8qIDUgKi8KK0RFRl9FRV9JQ0xBU1MzMihFRTYs
MDEsSU5WQUxJRCkgLyogNiAqLworREVGX0VFX0lDTEFTUzMyKEVFNywwMSxJTlZBTElEKSAvKiA3
ICovCitERUZfRUVfSUNMQVNTMzIoRUU4LDAxLElOVkFMSUQpIC8qIDggKi8KK0RFRl9FRV9JQ0xB
U1MzMihFRTksMDEsSU5WQUxJRCkgLyogOSAqLworREVGX0VFX0lDTEFTUzMyKEVFQSwwMSxJTlZB
TElEKSAvKiAxMCAqLworREVGX0VFX0lDTEFTUzMyKEVFQiwwMSxJTlZBTElEKSAvKiAxMSAqLwor
REVGX0VFX0lDTEFTUzMyKEVFQywwMSxJTlZBTElEKSAvKiAxMiAqLworREVGX0VFX0lDTEFTUzMy
KEVFRCwwMSxJTlZBTElEKSAvKiAxMyAqLworREVGX0VFX0lDTEFTUzMyKEVFRSwwMSxJTlZBTElE
KSAvKiAxNCAqLworREVGX0VFX0lDTEFTUzMyKEVFRiwwMSxJTlZBTElEKSAvKiAxNSAqLworCi0t
IAoyLjcuNAoK

