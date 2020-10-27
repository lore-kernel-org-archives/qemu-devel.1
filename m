Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF28DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274562054F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biTk4wZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274562054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT26-0000RV-Ca
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStz-0006LC-Lk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStu-0003Nf-2u
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciZb03MkLztGKYckXNmisFrJ80M+zii2LwPcZC9HzjQ=;
 b=biTk4wZ3U7ncirDLqjcWqkdZVqARemTl0286kMiINdJnSJtghAR5VAEFYb1vvMHN+AKrQ3
 cC7WufXm1pSRwh9mBZF5rpqnOdgSZcMmsFMFnhbdEYHKQ4IXSLPexGX3ynlBi0ss3zRHBR
 YzfICoySu3uqExzyfMdmOluqDKytXm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-IYcTSR5LOUqeAygqfRU18g-1; Tue, 27 Oct 2020 13:36:43 -0400
X-MC-Unique: IYcTSR5LOUqeAygqfRU18g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7228B1019631;
 Tue, 27 Oct 2020 17:36:42 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DFE819C4F;
 Tue, 27 Oct 2020 17:36:41 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/12] vhost-user-blk-test: drop unused return value
Date: Tue, 27 Oct 2020 17:35:27 +0000
Message-Id: <20201027173528.213464-12-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHNvY2tfcGF0aCByZXR1cm4gdmFsdWUgd2FzIHVudXNlZCBhbmQgYm9ndXMgKGl0IGRvZXNu
J3QgbWFrZSBzZW5zZQp3aGVuIHRoZXJlIGFyZSBtdWx0aXBsZSBkcml2ZXMgYmVjYXVzZSBvbmx5
IHRoZSBsYXN0IHBhdGggaXMgYXJiaXRyYXJpbHkKcmV0dXJuZWQpLgoKU2lnbmVkLW9mZi1ieTog
U3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHRlc3RzL3F0ZXN0L3Zo
b3N0LXVzZXItYmxrLXRlc3QuYyB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3Qvdmhvc3QtdXNl
ci1ibGstdGVzdC5jIGIvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jCmluZGV4IDE1
ZGFmOGNjYmMuLjBkMDU2Y2MxODkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXIt
YmxrLXRlc3QuYworKysgYi90ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMKQEAgLTcw
NSw4ICs3MDUsOCBAQCBzdGF0aWMgdm9pZCBxdWl0X3N0b3JhZ2VfZGFlbW9uKHZvaWQgKnFtcF90
ZXN0X3N0YXRlKQogICAgIGdfZnJlZShxbXBfdGVzdF9zdGF0ZSk7CiB9CiAKLXN0YXRpYyBjaGFy
ICpzdGFydF92aG9zdF91c2VyX2JsayhHU3RyaW5nICpjbWRfbGluZSwgaW50IHZ1c19pbnN0YW5j
ZXMsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IG51bV9xdWV1ZXMpCitz
dGF0aWMgdm9pZCBzdGFydF92aG9zdF91c2VyX2JsayhHU3RyaW5nICpjbWRfbGluZSwgaW50IHZ1
c19pbnN0YW5jZXMsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgbnVtX3F1
ZXVlcykKIHsKICAgICBjb25zdCBjaGFyICp2aG9zdF91c2VyX2Jsa19iaW4gPSBxdGVzdF9xZW11
X3N0b3JhZ2VfZGFlbW9uX2JpbmFyeSgpOwogICAgIGludCBmZCwgcW1wX2ZkLCBpOwpAQCAtNzc0
LDcgKzc3NCw2IEBAIHN0YXRpYyBjaGFyICpzdGFydF92aG9zdF91c2VyX2JsayhHU3RyaW5nICpj
bWRfbGluZSwgaW50IHZ1c19pbnN0YW5jZXMsCiAgICAgZ190ZXN0X3F1ZXVlX2Rlc3Ryb3kocXVp
dF9zdG9yYWdlX2RhZW1vbiwgcW1wX3Rlc3Rfc3RhdGUpOwogCiAgICAgcW9iamVjdF91bnJlZihx
dGVzdF9xbXAocW1wX3Rlc3Rfc3RhdGUsICJ7J2V4ZWN1dGUnOiAncW1wX2NhcGFiaWxpdGllcyd9
IikpOwotICAgIHJldHVybiBzb2NrX3BhdGg7CiB9CiAKIHN0YXRpYyB2b2lkICp2aG9zdF91c2Vy
X2Jsa190ZXN0X3NldHVwKEdTdHJpbmcgKmNtZF9saW5lLCB2b2lkICphcmcpCi0tIAoyLjI2LjIK
Cg==


