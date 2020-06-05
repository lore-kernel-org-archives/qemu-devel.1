Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEEAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB36D207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+u0jxuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB36D207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8yQ-00032R-69
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xL-0001Zi-Og
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8xL-0006ea-3K
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qxyNF0Wnmk6QI4CjeBEfwFsOpoZUCPNbn8klcolTwaU=;
 b=A+u0jxuI4qey4j8lRH6Jb6tOL6afgBbFo0GaQc6DWUMc4FMMTM84VSODYHppmgC7za5+Fc
 apR27l+vX1nW9TDoRMhAJEzVwdFdqF7qPD6hJlEdE0jxaQJ1adwyjPU5vRJWHO1PIQB3Ao
 2oofxVvCRAUSgwo63XeguUlasxt1NjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-zM3zYmr8PKelVvK67Ncqxg-1; Fri, 05 Jun 2020 05:48:02 -0400
X-MC-Unique: zM3zYmr8PKelVvK67Ncqxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2962C83DE6D;
 Fri,  5 Jun 2020 09:48:01 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC6178FC8;
 Fri,  5 Jun 2020 09:47:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 00/11] Block patches
Date: Fri,  5 Jun 2020 10:47:39 +0100
Message-Id: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
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
 Laurent Vivier <lvivier@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2NjIzNGZlZTljMmQzN2JmYmM1MjNh
YThkMGFlNTMwMGExNGNjMTBlOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvYWxpc3RhaXIvdGFncy9wdWxsLXJpc2N2LXRvLWFwcGx5LTIwMj0NCjAwNjAzJyBpbnRv
IHN0YWdpbmcgKDIwMjAtMDYtMDQgMTE6Mzg6NDggKzAxMDApDQoNCmFyZSBhdmFpbGFibGUgaW4g
dGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBzOi8vZ2l0aHViLmNvbS9zdGVmYW5oYS9x
ZW11LmdpdCB0YWdzL2Jsb2NrLXB1bGwtcmVxdWVzdA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5n
ZXMgdXAgdG8gN2QyNDEwY2VhMTU0YmY5MTVmYjMwMTc5ZWJkYTNiMTdhYzM2ZTcwZToNCg0KICBi
bG9jazogRmFjdG9yIG91dCBiZHJ2X3J1bl9jbygpICgyMDIwLTA2LTA1IDA5OjU0OjQ4ICswMTAw
KQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpQdWxsIHJlcXVlc3QNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpBbGV4YW5kZXIgQnVsZWtv
diAoNCk6DQogIGZ1eno6IGFkZCBkYXRhZGlyIGZvciBvc3MtZnV6eiBjb21wYXRhYmlsaXR5DQog
IGZ1eno6IGZpeCB0eXBvIGluIGk0NDBmeC1xdGVzdC1yZWJvb3QgYXJndW1lbnRzDQogIGZ1eno6
IGFkZCBtYW5nbGVkIG9iamVjdCBuYW1lIHRvIGxpbmtlciBzY3JpcHQNCiAgZnV6ejogcnVuIHRo
ZSBtYWluLWxvb3AgaW4gZm9yay1zZXJ2ZXIgcHJvY2Vzcw0KDQpQaGlsaXBwZSBNYXRoaWV1LURh
dWQ9QzM9QTkgKDQpOg0KICBtZW1vcnk6IFJlbmFtZSBtZW1vcnlfcmVnaW9uX2RvX3dyaXRlYmFj
ayAtPiBtZW1vcnlfcmVnaW9uX3dyaXRlYmFjaw0KICBtZW1vcnk6IEV4dHJhY3QgbWVtb3J5X3Jl
Z2lvbl9tc3luYygpIGZyb20gbWVtb3J5X3JlZ2lvbl93cml0ZWJhY2soKQ0KICBody9ibG9jazog
TGV0IHRoZSBOVk1lIGVtdWxhdGVkIGRldmljZSBiZSB0YXJnZXQtYWdub3N0aWMNCiAgZXhlYzog
UmVuYW1lIHFlbXVfcmFtX3dyaXRlYmFjaygpIGFzIHFlbXVfcmFtX21zeW5jKCkNCg0KU3RlZmFu
byBHYXJ6YXJlbGxhICgyKToNCiAgaW9fdXJpbmc6IHJldHJ5IGlvX3VyaW5nX3N1Ym1pdCgpIGlm
IGl0IGZhaWxzIHdpdGggZXJybm89M0RFSU5UUg0KICBpb191cmluZzogdXNlIGlvX3VyaW5nX2Nx
X3JlYWR5KCkgdG8gY2hlY2sgZm9yIHJlYWR5IGNxZXMNCg0KVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSAoMSk6DQogIGJsb2NrOiBGYWN0b3Igb3V0IGJkcnZfcnVuX2NvKCkNCg0KIGh3L2Js
b2NrL01ha2VmaWxlLm9ianMgICAgICAgICAgICAgIHwgICAyICstDQogaW5jbHVkZS9leGVjL21l
bW9yeS5oICAgICAgICAgICAgICAgfCAgMTUgKystDQogaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgg
ICAgICAgICAgICAgfCAgIDQgKy0NCiBpbmNsdWRlL3N5c2VtdS9zeXNlbXUuaCAgICAgICAgICAg
ICB8ICAgMiArDQogYmxvY2svaW8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxOTMgKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KIGJsb2NrL2lvX3VyaW5nLmMgICAgICAgICAgICAg
ICAgICAgIHwgIDExICstDQogZXhlYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDIgKy0NCiBody9ibG9jay9udm1lLmMgICAgICAgICAgICAgICAgICAgICB8ICAgNiArLQ0KIG1l
bW9yeS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEyICstDQogc29mdG1tdS92bC5j
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiB0YXJnZXQvYXJtL2hlbHBlci5jICAg
ICAgICAgICAgICAgICB8ICAgMiArLQ0KIHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5jICAgICAgICAg
ICAgIHwgIDE1ICsrKw0KIHRlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYyAgICAgIHwgICAz
ICstDQogdGVzdHMvcXRlc3QvZnV6ei92aXJ0aW9fbmV0X2Z1enouYyAgfCAgIDIgKw0KIHRlc3Rz
L3F0ZXN0L2Z1enovdmlydGlvX3Njc2lfZnV6ei5jIHwgICAyICsNCiB0ZXN0cy9xdGVzdC9mdXp6
L2ZvcmtfZnV6ei5sZCAgICAgICB8ICAgNSArDQogMTYgZmlsZXMgY2hhbmdlZCwgMTM0IGluc2Vy
dGlvbnMoKyksIDE0NCBkZWxldGlvbnMoLSkNCg0KLS09MjANCjIuMjUuNA0KDQo=


