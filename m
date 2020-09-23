Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8562C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F5820719
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyGAlT/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F5820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Uo-0004q1-4E
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Mm-0003sQ-Ed
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Mh-0006Iv-LA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTltilDTFPPP0W3QMFVvQxBFt8mKo6h0byLEt6DuNTs=;
 b=JyGAlT/FXO3R2s0uUTM1McWDLmBBThVjfmOi+mgQBEujM4ndTcEDaCm4lHXDAgJPJVSfu1
 Eo2H/tTrr2XVd/h4eL9BzEp0JCMqBBx9pOKxCprnFTH+v2SabTZ2BPuzAp3QcyQcp3iYGu
 xDoxsKQKtfogVgLm/MlxsQ5P4xXDLM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-T8SMYys6NBOj3zlBP9SEwQ-1; Wed, 23 Sep 2020 12:11:12 -0400
X-MC-Unique: T8SMYys6NBOj3zlBP9SEwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9AA61DDEB;
 Wed, 23 Sep 2020 16:11:11 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6891C73668;
 Wed, 23 Sep 2020 16:11:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/13] gitmodules: switch to qemu.org qboot mirror
Date: Wed, 23 Sep 2020 17:10:26 +0100
Message-Id: <20200923161031.69474-9-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSBub3cgaG9zdHMgYSBtaXJyb3Igb2YgcWJvb3QuZ2l0LiBRRU1VIG1pcnJvcnMgdGhpcmQt
cGFydHkgY29kZSB0bwplbnN1cmUgdGhhdCB1c2VycyBjYW4gYWx3YXlzIGJ1aWxkIFFFTVUgZXZl
biBpZiB0aGUgZGVwZW5kZW5jeSBnb2VzCm9mZmxpbmUgYW5kIHNvIFFFTVUgbWVldHMgaXRzIHJl
c3BvbnNpYmlsaXRpZXMgdG8gcHJvdmlkZSBmdWxsIHNvdXJjZQpjb2RlIHVuZGVyIHNvZnR3YXJl
IGxpY2Vuc2VzLgoKU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KVGVzdGVkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+CkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgpNZXNzYWdlLUlkOiA8
MjAyMDA5MTUxMzA4MzQuNzA2NzU4LTItc3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiAuZ2l0bW9k
dWxlcyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhLy5naXRtb2R1bGVzIGIvLmdpdG1vZHVsZXMKaW5kZXggOWZmYjlmM2Y0
Zi4uN2M4Njk1YjFkYyAxMDA2NDQKLS0tIGEvLmdpdG1vZHVsZXMKKysrIGIvLmdpdG1vZHVsZXMK
QEAgLTU3LDcgKzU3LDcgQEAKIAl1cmwgPSAJaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L29wZW5z
YmkuZ2l0CiBbc3VibW9kdWxlICJyb21zL3Fib290Il0KIAlwYXRoID0gcm9tcy9xYm9vdAotCXVy
bCA9IGh0dHBzOi8vZ2l0aHViLmNvbS9ib256aW5pL3Fib290CisJdXJsID0gaHR0cHM6Ly9naXQu
cWVtdS5vcmcvZ2l0L3Fib290LmdpdAogW3N1Ym1vZHVsZSAibWVzb24iXQogCXBhdGggPSBtZXNv
bgogCXVybCA9IGh0dHBzOi8vZ2l0aHViLmNvbS9tZXNvbmJ1aWxkL21lc29uLwotLSAKMi4yNi4y
Cgo=


