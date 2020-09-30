Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B33C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9452075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2US3qg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9452075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ8Z-00059h-QG
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ6t-00035x-9O
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kNZ6p-0005yu-BZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601460794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jaqD9QAgBxTdHo432H6PiiRfYvYRo/QbuHW14IK+c8s=;
 b=F2US3qg4P4H7GsE8wZrATtC3AwJjqpIN7eDvG+umwKSyO3xd+Pk64uVkK5cbRoDLqERxMv
 4EYMMQYlDe06GhTEks4YCvwWObhkI/oBXdzo/iYa9etbS5OUdq1tetK1VtzG3E8m7g6KcJ
 MPWe8GiivK+dVdliqxkafvoFR0Z0Qd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-m0e35rYqMnKtdgIaprRkww-1; Wed, 30 Sep 2020 06:13:10 -0400
X-MC-Unique: m0e35rYqMnKtdgIaprRkww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12021006701;
 Wed, 30 Sep 2020 10:13:09 +0000 (UTC)
Received: from localhost (ovpn-114-33.ams2.redhat.com [10.36.114.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 644065C1C4;
 Wed, 30 Sep 2020 10:13:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 00/17] Block patches
Date: Wed, 30 Sep 2020 11:12:48 +0100
Message-Id: <20200930101305.305302-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiMTUwY2I4ZjY3YmY0OTFhNDlhMWNi
MWM3ZGExNTFlZWFjYmRiY2M5Og0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvbXN0L3RhZ3MvZm9yX3Vwc3RyZWFtJyBpbnRvIHN0YWdpbmcgKDIwMjAtMDktMjkgMTM6
MTg6NTQgKzAxMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0K
DQogIGh0dHBzOi8vZ2l0bGFiLmNvbS9zdGVmYW5oYS9xZW11LmdpdCB0YWdzL2Jsb2NrLXB1bGwt
cmVxdWVzdA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gYmM0NzgzMWZmMjhkNmY1
ODMwYzljOGQ3NDIyMDEzMWRjNTRjNTI1MzoNCg0KICB1dGlsL3ZmaW8taGVscGVyczogUmV3b3Jr
IHRoZSBJT1ZBIGFsbG9jYXRvciB0byBhdm9pZCBJT1ZBIHJlc2VydmVkIHJlZ2lvbnMgKDIwMjAt
MDktMzAgMTA6MjM6MDUgKzAxMDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClB1bGwgcmVxdWVzdA0KDQpOb3RlIEkg
aGF2ZSBzd2l0Y2hlZCBmcm9tIEdpdEh1YiB0byBHaXRMYWIuDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KRXJpYyBB
dWdlciAoMik6DQogIHV0aWwvdmZpby1oZWxwZXJzOiBDb2xsZWN0IElPVkEgcmVzZXJ2ZWQgcmVn
aW9ucw0KICB1dGlsL3ZmaW8taGVscGVyczogUmV3b3JrIHRoZSBJT1ZBIGFsbG9jYXRvciB0byBh
dm9pZCBJT1ZBIHJlc2VydmVkDQogICAgcmVnaW9ucw0KDQpQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSAoNik6DQogIHV0aWwvdmZpby1oZWxwZXJzOiBQYXNzIHBhZ2UgcHJvdGVjdGlvbnMgdG8gcWVt
dV92ZmlvX3BjaV9tYXBfYmFyKCkNCiAgYmxvY2svbnZtZTogTWFwIGRvb3JiZWxscyBwYWdlcyB3
cml0ZS1vbmx5DQogIGJsb2NrL252bWU6IFJlZHVjZSBJL08gcmVnaXN0ZXJzIHNjb3BlDQogIGJs
b2NrL252bWU6IERyb3AgTlZNZVJlZ3Mgc3RydWN0dXJlLCBkaXJlY3RseSB1c2UgTnZtZUJhcg0K
ICBibG9jay9udm1lOiBVc2UgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgZnJvbSAnYmxvY2svbnZtZS5o
Jw0KICBibG9jay9udm1lOiBSZXBsYWNlIG1hZ2ljIHZhbHVlIGJ5IFNDQUxFX01TIGRlZmluaXRp
b24NCg0KU3RlZmFubyBHYXJ6YXJlbGxhICgxKToNCiAgZG9jczogYWRkICdpb191cmluZycgb3B0
aW9uIHRvICdhaW8nIHBhcmFtIGluIHFlbXUtb3B0aW9ucy5oeA0KDQpWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5ICg4KToNCiAgYmxvY2s6IHJldHVybiBlcnJvci1jb2RlIGZyb20gYmRydl9p
bnZhbGlkYXRlX2NhY2hlDQogIGJsb2NrL2lvOiByZWZhY3RvciBjb3JvdXRpbmUgd3JhcHBlcnMN
CiAgYmxvY2s6IGRlY2xhcmUgc29tZSBjb3JvdXRpbmUgZnVuY3Rpb25zIGluIGJsb2NrL2Nvcm91
dGluZXMuaA0KICBzY3JpcHRzOiBhZGQgYmxvY2stY29yb3V0aW5lLXdyYXBwZXIucHkNCiAgYmxv
Y2s6IGdlbmVyYXRlIGNvcm91dGluZS13cmFwcGVyIGNvZGUNCiAgYmxvY2s6IGRyb3AgYmRydl9w
cnd2DQogIGJsb2NrL2lvOiByZWZhY3RvciBzYXZlL2xvYWQgdm1zdGF0ZQ0KICBpbmNsdWRlL2Js
b2NrL2Jsb2NrLmg6IGRyb3Agbm9uLWFzY2lpIHF1b3RhdGlvbiBtYXJrDQoNCiBibG9jay9ibG9j
ay1nZW4uaCAgICAgICAgICAgICAgICAgICAgICB8ICA0OSArKysrDQogYmxvY2svY29yb3V0aW5l
cy5oICAgICAgICAgICAgICAgICAgICAgfCAgNjUgKysrKysNCiBpbmNsdWRlL2Jsb2NrL2Jsb2Nr
LmggICAgICAgICAgICAgICAgICB8ICAzNiArKy0NCiBpbmNsdWRlL3FlbXUvdmZpby1oZWxwZXJz
LmggICAgICAgICAgICB8ICAgMiArLQ0KIGJsb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDk3ICstLS0tLS0NCiBibG9jay9pby5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDMzOSArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogYmxvY2svbnZtZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNzMgKysrLS0tDQogdGVzdHMvdGVzdC1iZHJ2LWRyYWlu
LmMgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiB1dGlsL3ZmaW8taGVscGVycy5jICAgICAgICAg
ICAgICAgICAgICB8IDEzMyArKysrKysrKystDQogYmxvY2svbWVzb24uYnVpbGQgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDggKw0KIGRvY3MvZGV2ZWwvYmxvY2stY29yb3V0aW5lLXdyYXBwZXIu
cnN0IHwgIDU0ICsrKysNCiBkb2NzL2RldmVsL2luZGV4LnJzdCAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQogcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0N
CiBzY3JpcHRzL2Jsb2NrLWNvcm91dGluZS13cmFwcGVyLnB5ICAgICB8IDE4OCArKysrKysrKysr
KysrKw0KIDE0IGZpbGVzIGNoYW5nZWQsIDYyOSBpbnNlcnRpb25zKCspLCA0MjggZGVsZXRpb25z
KC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2Jsb2NrLWdlbi5oDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGJsb2NrL2Nvcm91dGluZXMuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL2RldmVs
L2Jsb2NrLWNvcm91dGluZS13cmFwcGVyLnJzdA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzY3JpcHRz
L2Jsb2NrLWNvcm91dGluZS13cmFwcGVyLnB5DQoNCi0tIA0KMi4yNi4yDQoNCg==


