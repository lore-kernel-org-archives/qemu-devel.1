Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3240DC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB8D20787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH+jMcE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB8D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUR3a-0001dp-QJ
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 04:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUR2H-0008TY-Mq
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUR0l-00073U-5N
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:28:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUR0k-0006ud-Ly
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588321623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Np9JwoZcuyR82WFm2+emGQGHQ4XnnaarXMT9R8vwarc=;
 b=eH+jMcE5Gez0qKy3yTlvYrK7CAHNxdzRpFkD4boTGoQ/Qi+caJwgUWCbZHmGJQ+4TXfTIW
 anbFVn98SKhy54QCbOenUujQ3H5HD3IL8mMaIKMuLYZQ09UeTrqGtzBAuza57MMZpOqgEM
 mrd3lv6fK4HhjjOgB1yA+NgEPqzzPy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-UmqT1Vz-OBqFOtL8Lbh1bA-1; Fri, 01 May 2020 04:26:59 -0400
X-MC-Unique: UmqT1Vz-OBqFOtL8Lbh1bA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD439835BB7;
 Fri,  1 May 2020 08:26:56 +0000 (UTC)
Received: from localhost (ovpn-112-199.ams2.redhat.com [10.36.112.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92CFA5D9CA;
 Fri,  1 May 2020 08:26:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/4] Block patches
Date: Fri,  1 May 2020 09:26:39 +0100
Message-Id: <20200501082643.205362-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:09:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Juan Quintela <quintela@redhat.com>, Peter Lieven <pl@kamp.de>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyN2M5NDU2NjM3OTA2OWZiODkzMGJi
MTQzM2RjZmZiZjdkZjMyMDNkOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvZWRnYXIvdGFncy9lZGdhci94aWxpbngtbmV4dC0yMDIwLTA0LTMwLmZvci11cHN0cmVh
bScgaW50byBzdGFnaW5nICgyMDIwLTA0LTMwIDE2OjQ3OjIzICswMTAwKQ0KDQphcmUgYXZhaWxh
YmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBodHRwczovL2dpdGh1Yi5jb20vc3Rl
ZmFuaGEvcWVtdS5naXQgdGFncy9ibG9jay1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIGNjMWFkYzQ0ODgwNTlhYzE2ZDRkMjc3MmE3YWE3Y2QxMzIzZGVlY2E6
DQoNCiAgbG9ja2FibGU6IFJlcGxhY2UgbG9ja3Mgd2l0aCBsb2NrIGd1YXJkIG1hY3JvcyAoMjAy
MC0wNS0wMSAwOToxOToyNSArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCkZpeCB0
aGUgUUVNVV9MT0NLX0dVQVJEKCkgbWFjcm9zLCB1c2UgdGhlbSBtb3JlIHdpZGVseSwgYW5kIGFs
bG93IGZ1enplcg0KdGFyZ2V0cyB0byBiZSBpbnZva2VkIGRlcGVuZGluZyBvbiBhcmd2WzBdLg0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQoNCkFsZXhhbmRlciBCdWxla292ICgxKToNCiAgZnV6ejogc2VsZWN0IGZ1enog
dGFyZ2V0IHVzaW5nIGV4ZWN1dGFibGUgbmFtZQ0KDQpEYW5pZWwgQnJvZHNreSAoMik6DQogIGxv
Y2thYmxlOiBmaXggX19DT1VOVEVSX18gbWFjcm8gdG8gYmUgcmVmZXJlbmNlZCBwcm9wZXJseQ0K
ICBsb2NrYWJsZTogcmVwbGFjZWQgbG9ja3Mgd2l0aCBsb2NrIGd1YXJkIG1hY3JvcyB3aGVyZSBh
cHByb3ByaWF0ZQ0KDQpTaW1yYW4gU2luZ2hhbCAoMSk6DQogIGxvY2thYmxlOiBSZXBsYWNlIGxv
Y2tzIHdpdGggbG9jayBndWFyZCBtYWNyb3MNCg0KIGluY2x1ZGUvcWVtdS9sb2NrYWJsZS5oIHwg
IDcgKysrLS0tDQogaW5jbHVkZS9xZW11L3JjdS5oICAgICAgfCAgMiArLQ0KIGJsb2NrL2lzY3Np
LmMgICAgICAgICAgIHwgIDcgKystLS0tDQogYmxvY2svbmZzLmMgICAgICAgICAgICAgfCA1MSAr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGNwdXMtY29tbW9uLmMg
ICAgICAgICAgIHwgMTQgKysrKy0tLS0tLS0NCiBody9kaXNwbGF5L3F4bC5jICAgICAgICB8IDQz
ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiBody9oeXBlcnYvaHlwZXJ2LmMg
ICAgICB8IDE1ICsrKysrKy0tLS0tLQ0KIGh3L3JkbWEvcmRtYV9iYWNrZW5kLmMgIHwgNTAgKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGh3L3JkbWEvcmRtYV9ybS5j
ICAgICAgIHwgIDMgKy0tDQogaHcvdmZpby9wbGF0Zm9ybS5jICAgICAgfCAgNSArKy0tDQogbWln
cmF0aW9uL21pZ3JhdGlvbi5jICAgfCAgMyArLS0NCiBtaWdyYXRpb24vbXVsdGlmZC5jICAgICB8
ICA4ICsrKy0tLS0NCiBtaWdyYXRpb24vcmFtLmMgICAgICAgICB8ICAzICstLQ0KIG1vbml0b3Iv
bWlzYy5jICAgICAgICAgIHwgIDQgKy0tLQ0KIHRlc3RzL3F0ZXN0L2Z1enovZnV6ei5jIHwgMTkg
KysrKysrKystLS0tLS0tDQogdWkvc3BpY2UtZGlzcGxheS5jICAgICAgfCAxNCArKysrKy0tLS0t
LQ0KIHV0aWwvbG9nLmMgICAgICAgICAgICAgIHwgIDQgKystLQ0KIHV0aWwvcWVtdS10aW1lci5j
ICAgICAgIHwgMTcgKysrKysrKy0tLS0tLS0NCiB1dGlsL3JjdS5jICAgICAgICAgICAgICB8ICA4
ICsrKy0tLS0NCiB1dGlsL3RocmVhZC1wb29sLmMgICAgICB8ICAzICstLQ0KIHV0aWwvdmZpby1o
ZWxwZXJzLmMgICAgIHwgIDUgKystLQ0KIHNsaXJwICAgICAgICAgICAgICAgICAgIHwgIDIgKy0N
CiAyMiBmaWxlcyBjaGFuZ2VkLCAxMzMgaW5zZXJ0aW9ucygrKSwgMTU0IGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMjUuMw0KDQo=


