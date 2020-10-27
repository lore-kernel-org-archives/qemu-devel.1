Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E7C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1A62068D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmACJRRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1A62068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSwb-0001Ab-EK
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStT-0005rh-Jd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStQ-0003Gx-Hm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXpQ7RJ7D1rhMS8a9LW5ncNxcGPvR+/956bcQEH89kY=;
 b=MmACJRRlehlbhT543EWPpswE56S39UKuSNmJrOSZJJXQhqyuhCQV87YDJcW1uF5VH9TcIu
 Dggi4xVy7wrdfrpmiDUB2CSNi+fYzQhPBAkFRbM+Jv+tu/oxDeSse2y7XdY2SQMReGsftG
 gMrdzLorL/2EVL6RzcmqQh3H5T5nDjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-c-NRgwSANA23OyanodeoBg-1; Tue, 27 Oct 2020 13:36:15 -0400
X-MC-Unique: c-NRgwSANA23OyanodeoBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCCB5C7478;
 Tue, 27 Oct 2020 17:36:12 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61C521002388;
 Tue, 27 Oct 2020 17:35:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/12] libvhost-user: follow QEMU comment style
Date: Tue, 27 Oct 2020 17:35:17 +0000
Message-Id: <20201027173528.213464-2-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmggfCAxNSArKysrKysrKysrLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmggYi9jb250cmli
L2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5oCmluZGV4IDNiYmVhZTg1ODcuLmExNTM5ZGJi
NjkgMTAwNjQ0Ci0tLSBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmgKKysr
IGIvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaApAQCAtMzkyLDcgKzM5Miw4
IEBAIHN0cnVjdCBWdURldiB7CiAgICAgYm9vbCBicm9rZW47CiAgICAgdWludDE2X3QgbWF4X3F1
ZXVlczsKIAotICAgIC8qIEByZWFkX21zZzogY3VzdG9tIG1ldGhvZCB0byByZWFkIHZob3N0LXVz
ZXIgbWVzc2FnZQorICAgIC8qCisgICAgICogQHJlYWRfbXNnOiBjdXN0b20gbWV0aG9kIHRvIHJl
YWQgdmhvc3QtdXNlciBtZXNzYWdlCiAgICAgICoKICAgICAgKiBSZWFkIGRhdGEgZnJvbSB2aG9z
dF91c2VyIHNvY2tldCBmZCBhbmQgZmlsbCB1cAogICAgICAqIHRoZSBwYXNzZWQgVmhvc3RVc2Vy
TXNnICp2bXNnIHN0cnVjdC4KQEAgLTQwOSwxNSArNDEwLDE5IEBAIHN0cnVjdCBWdURldiB7CiAg
ICAgICoKICAgICAgKi8KICAgICB2dV9yZWFkX21zZ19jYiByZWFkX21zZzsKLSAgICAvKiBAc2V0
X3dhdGNoOiBhZGQgb3IgdXBkYXRlIHRoZSBnaXZlbiBmZCB0byB0aGUgd2F0Y2ggc2V0LAotICAg
ICAqIGNhbGwgY2Igd2hlbiBjb25kaXRpb24gaXMgbWV0ICovCisKKyAgICAvKgorICAgICAqIEBz
ZXRfd2F0Y2g6IGFkZCBvciB1cGRhdGUgdGhlIGdpdmVuIGZkIHRvIHRoZSB3YXRjaCBzZXQsCisg
ICAgICogY2FsbCBjYiB3aGVuIGNvbmRpdGlvbiBpcyBtZXQuCisgICAgICovCiAgICAgdnVfc2V0
X3dhdGNoX2NiIHNldF93YXRjaDsKIAogICAgIC8qIEByZW1vdmVfd2F0Y2g6IHJlbW92ZSB0aGUg
Z2l2ZW4gZmQgZnJvbSB0aGUgd2F0Y2ggc2V0ICovCiAgICAgdnVfcmVtb3ZlX3dhdGNoX2NiIHJl
bW92ZV93YXRjaDsKIAotICAgIC8qIEBwYW5pYzogZW5jb3VudGVyZWQgYW4gdW5yZWNvdmVyYWJs
ZSBlcnJvciwgeW91IG1heSB0cnkgdG8KLSAgICAgKiByZS1pbml0aWFsaXplICovCisgICAgLyoK
KyAgICAgKiBAcGFuaWM6IGVuY291bnRlcmVkIGFuIHVucmVjb3ZlcmFibGUgZXJyb3IsIHlvdSBt
YXkgdHJ5IHRvIHJlLWluaXRpYWxpemUKKyAgICAgKi8KICAgICB2dV9wYW5pY19jYiBwYW5pYzsK
ICAgICBjb25zdCBWdURldklmYWNlICppZmFjZTsKIAotLSAKMi4yNi4yCgo=


