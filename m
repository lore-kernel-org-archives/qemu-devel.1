Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FDC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510E120719
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRc1jqDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510E120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Uj-0004hi-Vs
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Mr-0003vk-EG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Ml-0006JP-R9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AMWqCEjmxNIZ/0njGwj3JiXhDrYq9yyJCEF8NR/Kc0=;
 b=jRc1jqDJxAxp9A/yh68pXLmsEhcU387QDEUr19oXpIxes7yG5zfWJygsAuOo83IkQaF2rv
 iV+hYhzBBBUsfdziiDRvj06RbxFDNbToJ0tcPexuMeIK/N3Y/vamSKieI1yl94yIsM2MQJ
 9YLQt8EHope9UvGAijfHD4VfVDkW/UU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-VCFU9ko5NYKQWovXj75sjw-1; Wed, 23 Sep 2020 12:11:26 -0400
X-MC-Unique: VCFU9ko5NYKQWovXj75sjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ECE1801ABC;
 Wed, 23 Sep 2020 16:11:25 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5E3E2C31E;
 Wed, 23 Sep 2020 16:11:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/13] gitmodules: add qemu.org vbootrom submodule
Date: Wed, 23 Sep 2020 17:10:28 +0100
Message-Id: <20200923161031.69474-11-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 11:17:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
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
b2VuQGdvb2dsZS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQHJlZGhhdC5jb20+ClRlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDIwMDkxNTEzMDgzNC43MDY3NTgtNC1zdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIC5naXRtb2R1bGVzIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvLmdpdG1vZHVsZXMgYi8uZ2l0
bW9kdWxlcwppbmRleCAxYzE1YjNjNmY5Li4yYmRlZWFjZWY4IDEwMDY0NAotLS0gYS8uZ2l0bW9k
dWxlcworKysgYi8uZ2l0bW9kdWxlcwpAQCAtNjMsNCArNjMsNCBAQAogCXVybCA9IGh0dHBzOi8v
Z2l0LnFlbXUub3JnL2dpdC9tZXNvbi5naXQKIFtzdWJtb2R1bGUgInJvbXMvdmJvb3Ryb20iXQog
CXBhdGggPSByb21zL3Zib290cm9tCi0JdXJsID0gaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS92
Ym9vdHJvbS5naXQKKwl1cmwgPSBodHRwczovL2dpdC5xZW11Lm9yZy9naXQvdmJvb3Ryb20uZ2l0
Ci0tIAoyLjI2LjIKCg==


