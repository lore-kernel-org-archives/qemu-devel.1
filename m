Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26ED2075B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+8jFfjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26ED2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh92u-0004fQ-15
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yg-0004Ap-UO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yf-0006yx-5Y
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4jgqs1FW6h3L+meY8A/zsfuazK5mn5Zu3n3/QF+8jo=;
 b=K+8jFfjpjl+Gfk31dyfulIseGcZH6gLxXDCoKOPF9Q2FE6Z2NgJ5hnXyRKlGk0rtxcffxw
 6aTvG/BKD/I/mu4b1HHTvOeHwG2OdYQgzi4RKRto2iGJ9k3vQQ3enZPfftviNCt4vROm1V
 ITAu8nUcHtgw+Ef8rOvsSvQugBz+lbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-opwTX3LFNtu8nWdVF48POg-1; Fri, 05 Jun 2020 05:49:22 -0400
X-MC-Unique: opwTX3LFNtu8nWdVF48POg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47AAA0C00;
 Fri,  5 Jun 2020 09:49:17 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDB295C3F8;
 Fri,  5 Jun 2020 09:49:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 07/11] memory: Rename memory_region_do_writeback ->
 memory_region_writeback
Date: Fri,  5 Jun 2020 10:47:46 +0100
Message-Id: <20200605094750.149957-8-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKV2UgdXN1
YWxseSB1c2UgJ19kb18nIGZvciBpbnRlcm5hbCBmdW5jdGlvbnMuIFJlbmFtZQptZW1vcnlfcmVn
aW9uX2RvX3dyaXRlYmFjaygpIGFzIG1lbW9yeV9yZWdpb25fd3JpdGViYWNrKCkuCgpTaWduZWQt
b2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+ClJldmll
d2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+ClJldmlld2VkLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KQWNrZWQt
Ynk6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAw
NTA4MDYyNDU2LjIzMzQ0LTItcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFu
IEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGluY2x1ZGUvZXhlYy9tZW1vcnku
aCB8IDQgKystLQogbWVtb3J5LmMgICAgICAgICAgICAgIHwgMiArLQogdGFyZ2V0L2FybS9oZWxw
ZXIuYyAgIHwgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVj
L21lbW9yeS5oCmluZGV4IGUwMDBiZDJmOTcuLjFiN2NmZGQ1YjYgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvZXhlYy9tZW1vcnkuaAorKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgKQEAgLTE0NzQsMTQg
KzE0NzQsMTQgQEAgdm9pZCAqbWVtb3J5X3JlZ2lvbl9nZXRfcmFtX3B0cihNZW1vcnlSZWdpb24g
Km1yKTsKIHZvaWQgbWVtb3J5X3JlZ2lvbl9yYW1fcmVzaXplKE1lbW9yeVJlZ2lvbiAqbXIsIHJh
bV9hZGRyX3QgbmV3c2l6ZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoq
ZXJycCk7CiAvKioKLSAqIG1lbW9yeV9yZWdpb25fZG9fd3JpdGViYWNrOiBUcmlnZ2VyIGNhY2hl
IHdyaXRlYmFjayBvciBtc3luYyBmb3IKKyAqIG1lbW9yeV9yZWdpb25fd3JpdGViYWNrOiBUcmln
Z2VyIGNhY2hlIHdyaXRlYmFjayBvciBtc3luYyBmb3IKICAqIHNlbGVjdGVkIGFkZHJlc3MgcmFu
Z2UKICAqCiAgKiBAbXI6IHRoZSBtZW1vcnkgcmVnaW9uIHRvIGJlIHVwZGF0ZWQKICAqIEBhZGRy
OiB0aGUgaW5pdGlhbCBhZGRyZXNzIG9mIHRoZSByYW5nZSB0byBiZSB3cml0dGVuIGJhY2sKICAq
IEBzaXplOiB0aGUgc2l6ZSBvZiB0aGUgcmFuZ2UgdG8gYmUgd3JpdHRlbiBiYWNrCiAgKi8KLXZv
aWQgbWVtb3J5X3JlZ2lvbl9kb193cml0ZWJhY2soTWVtb3J5UmVnaW9uICptciwgaHdhZGRyIGFk
ZHIsIGh3YWRkciBzaXplKTsKK3ZvaWQgbWVtb3J5X3JlZ2lvbl93cml0ZWJhY2soTWVtb3J5UmVn
aW9uICptciwgaHdhZGRyIGFkZHIsIGh3YWRkciBzaXplKTsKIAogLyoqCiAgKiBtZW1vcnlfcmVn
aW9uX3NldF9sb2c6IFR1cm4gZGlydHkgbG9nZ2luZyBvbiBvciBvZmYgZm9yIGEgcmVnaW9uLgpk
aWZmIC0tZ2l0IGEvbWVtb3J5LmMgYi9tZW1vcnkuYwppbmRleCBmZDZmM2Q2YWNhLi5iYjg0MzM0
ZTFlIDEwMDY0NAotLS0gYS9tZW1vcnkuYworKysgYi9tZW1vcnkuYwpAQCAtMjE5OCw3ICsyMTk4
LDcgQEAgdm9pZCBtZW1vcnlfcmVnaW9uX3JhbV9yZXNpemUoTWVtb3J5UmVnaW9uICptciwgcmFt
X2FkZHJfdCBuZXdzaXplLCBFcnJvciAqKmVycnAKIH0KIAogCi12b2lkIG1lbW9yeV9yZWdpb25f
ZG9fd3JpdGViYWNrKE1lbW9yeVJlZ2lvbiAqbXIsIGh3YWRkciBhZGRyLCBod2FkZHIgc2l6ZSkK
K3ZvaWQgbWVtb3J5X3JlZ2lvbl93cml0ZWJhY2soTWVtb3J5UmVnaW9uICptciwgaHdhZGRyIGFk
ZHIsIGh3YWRkciBzaXplKQogewogICAgIC8qCiAgICAgICogTWlnaHQgYmUgZXh0ZW5kZWQgY2Fz
ZSBuZWVkZWQgdG8gY292ZXIKZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vaGVscGVyLmMgYi90YXJn
ZXQvYXJtL2hlbHBlci5jCmluZGV4IGE5MmFlNTU2NzIuLjk3MmE3NjY3MzAgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9hcm0vaGVscGVyLmMKKysrIGIvdGFyZ2V0L2FybS9oZWxwZXIuYwpAQCAtNjgxMyw3
ICs2ODEzLDcgQEAgc3RhdGljIHZvaWQgZGNjdmFwX3dyaXRlZm4oQ1BVQVJNU3RhdGUgKmVudiwg
Y29uc3QgQVJNQ1BSZWdJbmZvICpvcGFxdWUsCiAgICAgICAgIG1yID0gbWVtb3J5X3JlZ2lvbl9m
cm9tX2hvc3QoaGFkZHIsICZvZmZzZXQpOwogCiAgICAgICAgIGlmIChtcikgewotICAgICAgICAg
ICAgbWVtb3J5X3JlZ2lvbl9kb193cml0ZWJhY2sobXIsIG9mZnNldCwgZGxpbmVfc2l6ZSk7Cisg
ICAgICAgICAgICBtZW1vcnlfcmVnaW9uX3dyaXRlYmFjayhtciwgb2Zmc2V0LCBkbGluZV9zaXpl
KTsKICAgICAgICAgfQogICAgIH0KIH0KLS0gCjIuMjUuNAoK


