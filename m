Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458242075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO+4wjPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458242075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh90P-0007Nd-Fs
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8y1-0002dK-Nf
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8y0-0006ln-Qk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeDB82xEvMkQfbKYkEl5hVpTTwCGfpocvzSRNAvRCMA=;
 b=SO+4wjPQ7Z8rGhOLBVzhl+45PHM9M63vTslcK4tUTxz7Q3Dnq5LGBZjm+iH/SfOaK8ZA3/
 kARzhvpp78XRHysoaabNI4Y8+5UkIxN/sb2HK4Mn2yAV6ohuS1UGx39pBjhvIxRehTCw0A
 6zEGuqeYNVrk3dG+btH8HE0iGP9EXzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-g2LwYyuLMNWaE_GxE7nrxw-1; Fri, 05 Jun 2020 05:48:46 -0400
X-MC-Unique: g2LwYyuLMNWaE_GxE7nrxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D06F461;
 Fri,  5 Jun 2020 09:48:44 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC77B7CCF2;
 Fri,  5 Jun 2020 09:48:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 04/11] fuzz: fix typo in i440fx-qtest-reboot arguments
Date: Fri,  5 Jun 2020 10:47:43 +0100
Message-Id: <20200605094750.149957-5-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpTaWduZWQtb2ZmLWJ5OiBB
bGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6IERhcnJlbiBLZW5u
eSA8ZGFycmVuLmtlbm55QG9yYWNsZS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwNTEyMDMwMTMzLjI5
ODk2LTMtYWx4bmRyQGJ1LmVkdQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhfZnV6ei5jIGIvdGVzdHMvcXRlc3QvZnV6ei9p
NDQwZnhfZnV6ei5jCmluZGV4IGJjZDY3NjliNGMuLjc3NWIzMDQxYmEgMTAwNjQ0Ci0tLSBhL3Rl
c3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYworKysgYi90ZXN0cy9xdGVzdC9mdXp6L2k0NDBm
eF9mdXp6LmMKQEAgLTE1Niw3ICsxNTYsNyBAQCBzdGF0aWMgdm9pZCBpNDQwZnhfZnV6el9xb3Nf
Zm9yayhRVGVzdFN0YXRlICpzLAogfQogCiBzdGF0aWMgY29uc3QgY2hhciAqaTQ0MGZ4X3F0ZXN0
X2FyZ3YgPSBUQVJHRVRfTkFNRSAiIC1tYWNoaW5lIGFjY2VsPXF0ZXN0IgotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIi1tIDAgLWRpc3BsYXkgbm9uZSI7CisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiIC1tIDAgLWRpc3BsYXkgbm9uZSI7CiBz
dGF0aWMgY29uc3QgY2hhciAqaTQ0MGZ4X2FyZ3YoRnV6elRhcmdldCAqdCkKIHsKICAgICByZXR1
cm4gaTQ0MGZ4X3F0ZXN0X2FyZ3Y7Ci0tIAoyLjI1LjQKCg==


