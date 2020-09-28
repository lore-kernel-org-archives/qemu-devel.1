Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFBEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1555B2100A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mD3TuEWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1555B2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwzR-0004Id-2Q
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMwxa-0002bO-Ks
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:29:10 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:53848)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@qualcomm.com>)
 id 1kMwxX-0007us-6B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1601314147; x=1632850147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZVw6YzvPuV/Y+aLbQX73q+XKzFCqW3ke1XSkVOkY2M0=;
 b=mD3TuEWzGhh3bxja4OX9BmXdq73kWb20S8Z8FAxt24tjMfWLTQR3TfBO
 MO+l8IwneIi3rZOu6d8F8NDEexIR6l2z4VZfzHkNWA+AtIyLFnk+TTt1E
 M+IRRLNQVo23lh710LZakzhzKAAHVgze+CKC2XIEnIZzDVb4zlT4Qc9l+ A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Sep 2020 10:29:02 -0700
X-QCInternal: smtphost
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP; 28 Sep 2020 10:29:01 -0700
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id AA19C115E; Mon, 28 Sep 2020 12:29:01 -0500 (CDT)
From: Taylor Simpson <tsimpson@quicinc.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 01/29] Hexagon Update MAINTAINERS file
Date: Mon, 28 Sep 2020 12:28:30 -0500
Message-Id: <1601314138-9930-2-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=199.106.114.38;
 envelope-from=tsimpson@qualcomm.com; helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 13:29:03
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, tsimpson@quicinc.com, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIFRheWxvciBTaW1wc29uIGFzIHRoZSBIZXhhZ29uIHRhcmdldCBtYWludGFpbmVyCgpTaWdu
ZWQtb2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+ClJldmlld2Vk
LWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KLS0t
CiBNQUlOVEFJTkVSUyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDVlZWQxZTYu
LmFiODM1MjUgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0x
ODUsNiArMTg1LDE0IEBAIEY6IGluY2x1ZGUvaHcvY3Jpcy8KIEY6IHRlc3RzL3RjZy9jcmlzLwog
RjogZGlzYXMvY3Jpcy5jCiAKK0hleGFnb24gVENHIENQVXMKK006IFRheWxvciBTaW1wc29uIDx0
c2ltcHNvbkBxdWljaW5jLmNvbT4KK1M6IFN1cHBvcnRlZAorRjogdGFyZ2V0L2hleGFnb24vCitG
OiBsaW51eC11c2VyL2hleGFnb24vCitGOiBkaXNhcy9oZXhhZ29uLmMKK0Y6IGRlZmF1bHQtY29u
Zmlncy9oZXhhZ29uLWxpbnV4LXVzZXIubWFrCisKIEhQUEEgKFBBLVJJU0MpIFRDRyBDUFVzCiBN
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0PgogUzogTWFpbnRhaW5lZAotLSAK
Mi43LjQKCg==

