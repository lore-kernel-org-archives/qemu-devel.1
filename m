Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F95C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5A62075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekgSzSoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5A62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxEW-0000GV-Ku
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBj-00047r-Mq
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBi-0001YK-VZ
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5EJjHs8z/I64jA+XipsoincStHcoNY2kXiy9ancUzCg=;
 b=ekgSzSoFZzILVRmOz9giEo6UA2sgu5kx/N+8abNjMfd27PdfRlgS99KsFhfR4PxB5viK9X
 hNO6qooyaFDa9M4mwckIUpwyZJjIqMMpeAty1t5aP2NwSACa51thLAgePP7ZdLO0NT+v+Q
 /fzj6SSlp2yet1TbFl5vFsdCpYYiTd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-4wE6pclAMa-d1Hx91FG4Lw-1; Tue, 19 May 2020 04:01:05 -0400
X-MC-Unique: 4wE6pclAMa-d1Hx91FG4Lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B41B107ACCD;
 Tue, 19 May 2020 08:01:04 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2E322E037;
 Tue, 19 May 2020 08:00:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Block patches
Date: Tue, 19 May 2020 09:00:46 +0100
Message-Id: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAwMTNhMThlZGJiYzU5Y2RhZDAxOTEw
MGM3ZDAzYzA0OTQ2NDJiNzRjOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvcG1heWRlbGwvdGFncy9wdWxsLXRhcmdldC1hcm0tMjAyMDA1MT0NCjQnIGludG8gc3Rh
Z2luZyAoMjAyMC0wNS0xNCAxNjoxNzo1NSArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUg
R2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUu
Z2l0IHRhZ3MvYmxvY2stcHVsbC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byBiYTYwN2NhOGJmZjRkMmMyMDYyOTAyZjgzNTU2NTdjODY1YWM3YzI5Og0KDQogIGFpby1w
b3NpeDogZGlzYWJsZSBmZG1vbi1pb191cmluZyB3aGVuIEdTb3VyY2UgaXMgdXNlZCAoMjAyMC0w
NS0xOCAxODoxNjowMD0NCiArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCg0KUGhpbGlwcGUgTWF0aGlldS1EYXVkPUMzPUE5ICg2KToNCiAgdGVzdHMvZnV6ei9NYWtl
ZmlsZTogRG8gbm90IGxpbmsgY29kZSB1c2luZyB1bmF2YWlsYWJsZSBkZXZpY2VzDQogIE1ha2Vm
aWxlOiBMaXN0IGZ1enogdGFyZ2V0cyBpbiAnbWFrZSBoZWxwJw0KICB0ZXN0cy9mdXp6OiBBZGQg
bWlzc2luZyBzcGFjZSBpbiB0ZXN0IGRlc2NyaXB0aW9uDQogIHRlc3RzL2Z1eno6IFJlbW92ZSB1
bnVzZWZ1bC91bnVzZWQgdHlwZWRlZnMNCiAgdGVzdHMvZnV6ejogRXh0cmFjdCBwY2ljb25maWdf
ZnV6el9xb3MoKSBtZXRob2QNCiAgdGVzdHMvZnV6ejogRXh0cmFjdCBpb3BvcnRfZnV6el9xdGVz
dCgpIG1ldGhvZA0KDQpTdGVmYW4gSGFqbm9jemkgKDIpOg0KICBhaW8tcG9zaXg6IGRvbid0IGR1
cGxpY2F0ZSBmZCBoYW5kbGVyIGRlbGV0aW9uIGluDQogICAgZmRtb25faW9fdXJpbmdfZGVzdHJv
eSgpDQogIGFpby1wb3NpeDogZGlzYWJsZSBmZG1vbi1pb191cmluZyB3aGVuIEdTb3VyY2UgaXMg
dXNlZA0KDQogTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrLQ0KIHRl
c3RzL3F0ZXN0L2Z1enovTWFrZWZpbGUuaW5jbHVkZSB8ICA2ICsrLS0NCiBpbmNsdWRlL2Jsb2Nr
L2Fpby5oICAgICAgICAgICAgICAgfCAgMyArKw0KIHRlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1
enouYyAgICB8IDQ3ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCiB1dGlsL2Fpby1w
b3NpeC5jICAgICAgICAgICAgICAgICAgfCAxMyArKysrKysrKysNCiB1dGlsL2Fpby13aW4zMi5j
ICAgICAgICAgICAgICAgICAgfCAgNCArKysNCiB1dGlsL2FzeW5jLmMgICAgICAgICAgICAgICAg
ICAgICAgfCAgMSArDQogdXRpbC9mZG1vbi1pb191cmluZy5jICAgICAgICAgICAgIHwgMTMgKysr
KysrKy0tDQogOCBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMo
LSkNCg0KLS09MjANCjIuMjUuMw0KDQo=


