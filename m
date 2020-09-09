Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA97C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518C921D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBmEm54g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518C921D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxBI-0006CW-Fo
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFxAO-0004vy-A7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:17:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41321
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFxAH-0003AG-JJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599646640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biYrr0sgOG2yvzU7YW/FfGhiYk7BCSSoaNP4hEBXkBs=;
 b=dBmEm54gxEoqkmHDKjXpzeoXmTjSDsOkMweUkHQGo0NgWfIcIbwq+mSw6VpmHwnlqiVB9f
 PRskgCX6d/DPnj5grJigLaBEB8R/pfkoGzoxti98FxHsJUbHWCMSrop2E2fXur5SDTb+R5
 YpdGerFWWXSPLWc866VC7NrR6y9iDsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-ii93IggGMV6KqDqbVflFJQ-1; Wed, 09 Sep 2020 06:17:17 -0400
X-MC-Unique: ii93IggGMV6KqDqbVflFJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35FF1802B7C;
 Wed,  9 Sep 2020 10:17:16 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE26F5C1C2;
 Wed,  9 Sep 2020 10:17:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] gitmodules: add qemu.org vbootrom submodule
Date: Wed,  9 Sep 2020 11:16:42 +0100
Message-Id: <20200909101642.17698-4-stefanha@redhat.com>
In-Reply-To: <20200909101642.17698-1-stefanha@redhat.com>
References: <20200909101642.17698-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHZib290cm9tIG1vZHVsZSBpcyBuZWVkZWQgZm9yIHRoZSBuZXcgTlBDTTd4eCBBUk0gU29D
cy4gVGhlCnZib290cm9tLmdpdCByZXBvIGlzIG5vdyBtaXJyb3JlZCBvbiBxZW11Lm9yZy4gUUVN
VSBtaXJyb3JzIHRoaXJkLXBhcnR5CmNvZGUgdG8gZW5zdXJlIHRoYXQgdXNlcnMgY2FuIGFsd2F5
cyBidWlsZCBRRU1VIGV2ZW4gaWYgdGhlIGRlcGVuZGVuY3kKZ29lcyBvZmZsaW5lIGFuZCBzbyBR
RU1VIG1lZXRzIGl0cyByZXNwb25zaWJpbGl0aWVzIHRvIHByb3ZpZGUgZnVsbApzb3VyY2UgY29k
ZSB1bmRlciBzb2Z0d2FyZSBsaWNlbnNlcy4KClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPgpDYzogSGF2YXJkIFNraW5uZW1vZW4gPGhza2lubmVt
b2VuQGdvb2dsZS5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KLS0tClRoaXMgcGF0Y2ggY2FuIGJlIHJlYmFzZWQgb24gdG9wIG9mICJbUEFU
Q0ggdjggMDAvMTRdIEFkZCBOdXZvdG9uCk5QQ003MzAvTlBDTTc1MCBTb0NzIGFuZCB0d28gQk1D
IG1hY2hpbmVzIiBhbmQgcmVwbGFjZXMgdGhlIGdpdCBVUkwgaW4KdGhlIG9yaWdpbmFsIHBhdGNo
LgotLS0KIC5naXRtb2R1bGVzIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS8uZ2l0bW9kdWxlcyBiLy5naXRtb2R1bGVzCmluZGV4IGI4ZjhhMTQz
YmYuLjVmZWFiZjY0YzIgMTAwNjQ0Ci0tLSBhLy5naXRtb2R1bGVzCisrKyBiLy5naXRtb2R1bGVz
CkBAIC02MSwzICs2MSw2IEBACiBbc3VibW9kdWxlICJtZXNvbiJdCiAJcGF0aCA9IG1lc29uCiAJ
dXJsID0gaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L21lc29uLmdpdAorW3N1Ym1vZHVsZSAicm9t
cy92Ym9vdHJvbSJdCisgICAgICAgcGF0aCA9IHJvbXMvdmJvb3Ryb20KKyAgICAgICB1cmwgPSBo
dHRwczovL2dpdC5xZW11Lm9yZy9naXQvdmJvb3Ryb20uZ2l0Ci0tIAoyLjI2LjIKCg==


