Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267BAC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E612020733
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 00:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QbKUKbZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E612020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Jen-0006Gj-VN
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 19:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbs-0000yO-OE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1j1Jbr-0004z4-1v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:04 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:3651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1j1Jbq-0004uE-M0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 19:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1581381662; x=1612917662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Cx2/9sh4shrLTO6Ry+GmDO4UemkD4ztOEk5EFEjcsQ=;
 b=QbKUKbZ06I0hGc5BtfhBoTZw7xS93bzJsPseEgQdFhtxZRdTM14OnYEk
 em5CoOTcIpIpOEIkdKuzGc8LwliWuvYVTa4oh3HrQQPTrPrB+Y56PldsA
 05WnhBLTdk8wSKj8XLPmcwi4xkE4EU/GBbAW02eHUBd+qD6NsqBxwI/3E E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg01-sd.qualcomm.com with ESMTP; 10 Feb 2020 16:40:58 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 27D811B48; Mon, 10 Feb 2020 18:40:58 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 12/66] Hexagon register map
Date: Mon, 10 Feb 2020 18:39:50 -0600
Message-Id: <1581381644-13678-13-git-send-email-tsimpson@quicinc.com>
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

Q2VydGFpbiBvcGVyYW5kIHR5cGVzIHJlcHJlc2VudCBhIG5vbi1jb250aWd1b3VzIHNldCBvZiB2
YWx1ZXMuCkZvciBleGFtcGxlLCB0aGUgY29tcG91bmQgY29tcGFyZS1hbmQtanVtcCBpbnN0cnVj
dGlvbiBjYW4gb25seSBhY2Nlc3MKcmVnaXN0ZXJzIFIwLVI3IGFuZCBSMTYtMjMuClRoaXMgdGFi
bGUgcmVwcmVzZW50cyB0aGUgbWFwcGluZyBmcm9tIHRoZSBlbmNvZGluZyB0byB0aGUgYWN0dWFs
IHZhbHVlcy4KClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5j
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9yZWdtYXAuaCB8IDM4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL3JlZ21hcC5oCgpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vcmVnbWFwLmggYi90YXJnZXQvaGV4YWdvbi9yZWdtYXAuaApuZXcgZmls
ZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5mYmViMDNhCi0tLSAvZGV2L251bGwKKysrIGIv
dGFyZ2V0L2hleGFnb24vcmVnbWFwLmgKQEAgLTAsMCArMSwzOCBAQAorLyoKKyAqICBDb3B5cmln
aHQgKGMpIDIwMTkgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBS
ZXNlcnZlZC4KKyAqCisgKiAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAqICBpdCB1bmRlciB0aGUgdGVybXMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICogIHRoZSBG
cmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2Us
IG9yCisgKiAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyAqCisgKiAgVGhp
cyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2Vm
dWwsCisgKiAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxp
ZWQgd2FycmFudHkgb2YKKyAqICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlCisgKiAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
Zm9yIG1vcmUgZGV0YWlscy4KKyAqCisgKiAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAqICBhbG9uZyB3aXRoIHRoaXMg
cHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgorICov
CisKKy8qCisgKiAgQ2VydGFpbiBvcGVyYW5kIHR5cGVzIHJlcHJlc2VudCBhIG5vbi1jb250aWd1
b3VzIHNldCBvZiB2YWx1ZXMuCisgKiAgRm9yIGV4YW1wbGUsIHRoZSBjb21wb3VuZCBjb21wYXJl
LWFuZC1qdW1wIGluc3RydWN0aW9uIGNhbiBvbmx5IGFjY2VzcworICogIHJlZ2lzdGVycyBSMC1S
NyBhbmQgUjE2LTIzLgorICogIFRoaXMgdGFibGUgcmVwcmVzZW50cyB0aGUgbWFwcGluZyBmcm9t
IHRoZSBlbmNvZGluZyB0byB0aGUgYWN0dWFsIHZhbHVlcy4KKyAqLworCisjaWZuZGVmIFJFR01B
UF9ICisjZGVmaW5lIFJFR01BUF9ICisKKyAgICAgICAgLyogTmFtZSAgIE51bSBUYWJsZSAqLwor
REVGX1JFR01BUChSXzE2LCAgMTYsIDAsIDEsIDIsIDMsIDQsIDUsIDYsIDcsIDE2LCAxNywgMTgs
IDE5LCAyMCwgMjEsIDIyLCAyMykKK0RFRl9SRUdNQVAoUl9fOCwgIDgsICAwLCAyLCA0LCA2LCAx
NiwgMTgsIDIwLCAyMikKK0RFRl9SRUdNQVAoUl9fNCwgIDQsICAwLCAyLCA0LCA2KQorREVGX1JF
R01BUChSXzQsICAgNCwgIDAsIDEsIDIsIDMpCitERUZfUkVHTUFQKFJfOFMsICA4LCAgMCwgMSwg
MiwgMywgMTYsIDE3LCAxOCwgMTkpCitERUZfUkVHTUFQKFJfOCwgICA4LCAgMCwgMSwgMiwgMywg
NCwgNSwgNiwgNykKK0RFRl9SRUdNQVAoVl9fOCwgIDgsICAwLCA0LCA4LCAxMiwgMTYsIDIwLCAy
NCwgMjgpCitERUZfUkVHTUFQKFZfXzE2LCAxNiwgMCwgMiwgNCwgNiwgOCwgMTAsIDEyLCAxNCwg
MTYsIDE4LCAyMCwgMjIsIDI0LCAyNiwgMjgsIDMwKQorCisjZW5kaWYKLS0gCjIuNy40Cgo=

