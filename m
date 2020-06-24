Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DEFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21972084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILyeYEps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21972084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo32P-00061h-Ti
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2yW-000779-HQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:49:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54848
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jo2yS-0000mJ-5u
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fOnDCXeDgYTRhhQ82n988LX4gb/rcnq6b5gPC/dGqKo=;
 b=ILyeYEps1dbRFjo4xj7Oz/rDy2vx/Zq0HYE4hTRInc3a+Z+n31mLQqgi1nEa6LydLthB5Q
 MwBp8uLBKzEwQ/SWgIdq6Kd8HyfcISXeC/gJhD9JBYhndc9hOYneJ4g/Dik7tk6wuTEgpQ
 OnDwYJHuBJAtrGHROaTpHqNIYL3TO9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-l7kW7NQPNfKReAVn5dyk-Q-1; Wed, 24 Jun 2020 06:49:44 -0400
X-MC-Unique: l7kW7NQPNfKReAVn5dyk-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4375E18A8220;
 Wed, 24 Jun 2020 10:49:43 +0000 (UTC)
Received: from localhost (ovpn-114-150.ams2.redhat.com [10.36.114.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFF8ABA45;
 Wed, 24 Jun 2020 10:49:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Tracing patches
Date: Wed, 24 Jun 2020 11:49:33 +0100
Message-Id: <20200624104935.61329-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkODhkNWEzODA2ZDc4ZGNmY2E2NDhj
NjJkYWU5ZDg4ZDNlODAzYmQyOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvcGhpbG1kLWdpdGxhYi90YWdzL3JlbmVzYXMtaHctMjAyMDA2Mj0NCjInIGludG8gc3Rh
Z2luZyAoMjAyMC0wNi0yMyAxMzo1NTo1MiArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUu
Z2l0IHRhZ3MvdHJhY2luZy1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2Vz
IHVwIHRvIGRiMjVkNTZjMDE0YWExYTk2MzE5YzY2M2UwYTYwMzQ2YTIyM2IzMWU6DQoNCiAgdHJh
Y2Uvc2ltcGxlOiBGaXggdW5hdXRob3JpemVkIGVuYWJsZSAoMjAyMC0wNi0yNCAxMToyMTowMCAr
MDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KTWFya3VzIEFybWJy
dXN0ZXIgKDEpOg0KICB0cmFjZS9zaW1wbGU6IEZpeCB1bmF1dGhvcml6ZWQgZW5hYmxlDQoNClBo
aWxpcHBlIE1hdGhpZXUtRGF1ZD1DMz1BOSAoMSk6DQogIHNjcmlwdHMvdHJhY2V0b29sOiBVcGRh
dGUgbWFpbnRhaW5lciBlbWFpbCBhZGRyZXNzDQoNCiB0cmFjZS9zaW1wbGUuaCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIHRyYWNlL3NpbXBsZS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDIwICsrKysrKysrKysrKystLS0tLS0NCiBzY3JpcHRzL3Ry
YWNldG9vbC5weSAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIHNjcmlwdHMvdHJh
Y2V0b29sL19faW5pdF9fLnB5ICAgICAgICAgICAgICAgICB8ICAyICstDQogc2NyaXB0cy90cmFj
ZXRvb2wvYmFja2VuZC9fX2luaXRfXy5weSAgICAgICAgIHwgIDIgKy0NCiBzY3JpcHRzL3RyYWNl
dG9vbC9iYWNrZW5kL2R0cmFjZS5weSAgICAgICAgICAgfCAgMiArLQ0KIHNjcmlwdHMvdHJhY2V0
b29sL2JhY2tlbmQvbG9nLnB5ICAgICAgICAgICAgICB8ICAyICstDQogc2NyaXB0cy90cmFjZXRv
b2wvYmFja2VuZC9zaW1wbGUucHkgICAgICAgICAgIHwgIDIgKy0NCiBzY3JpcHRzL3RyYWNldG9v
bC9iYWNrZW5kL3VzdC5weSAgICAgICAgICAgICAgfCAgMiArLQ0KIHNjcmlwdHMvdHJhY2V0b29s
L2Zvcm1hdC9fX2luaXRfXy5weSAgICAgICAgICB8ICAyICstDQogc2NyaXB0cy90cmFjZXRvb2wv
Zm9ybWF0L2MucHkgICAgICAgICAgICAgICAgIHwgIDIgKy0NCiBzY3JpcHRzL3RyYWNldG9vbC9m
b3JtYXQvZC5weSAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIHNjcmlwdHMvdHJhY2V0b29sL2Zv
cm1hdC9oLnB5ICAgICAgICAgICAgICAgICB8ICAyICstDQogc2NyaXB0cy90cmFjZXRvb2wvZm9y
bWF0L3N0YXAucHkgICAgICAgICAgICAgIHwgIDIgKy0NCiBzY3JpcHRzL3RyYWNldG9vbC9mb3Jt
YXQvdGNnX2gucHkgICAgICAgICAgICAgfCAgMiArLQ0KIHNjcmlwdHMvdHJhY2V0b29sL2Zvcm1h
dC90Y2dfaGVscGVyX2MucHkgICAgICB8ICAyICstDQogc2NyaXB0cy90cmFjZXRvb2wvZm9ybWF0
L3RjZ19oZWxwZXJfaC5weSAgICAgIHwgIDIgKy0NCiAuLi4vdHJhY2V0b29sL2Zvcm1hdC90Y2df
aGVscGVyX3dyYXBwZXJfaC5weSAgfCAgMiArLQ0KIHNjcmlwdHMvdHJhY2V0b29sL3RyYW5zZm9y
bS5weSAgICAgICAgICAgICAgICB8ICAyICstDQogc2NyaXB0cy90cmFjZXRvb2wvdmNwdS5weSAg
ICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCiAyMCBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCAyNSBkZWxldGlvbnMoLSkNCg0KLS09MjANCjIuMjYuMg0KDQo=


