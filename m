Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CDAC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA4D20787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 08:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhU3h7xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA4D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUR6K-000624-PC
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 04:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUR2f-0000Hw-8N
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jUR2G-0001xI-7N
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:29:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jUR2F-0001rB-Mk
 for qemu-devel@nongnu.org; Fri, 01 May 2020 04:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588321718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e6Jprs66xeK3vL78NLs76pCV7hFBkLFL5enEHcUjkwA=;
 b=EhU3h7xr4opp05OLCWRAnwW41/XGUCLWm8A/ZHAzp6pMxxxt2U3kHIqG5civnpC5dGxt87
 c+Yq5xg9FlHI4eUpDzH2rNMRDY/qBhjYgNU1EB9v4V8xKH+gfwBYPFD9hMJWR3aE/ahG+Z
 kSyq2qcIySganICS6ECuGqWEIw87V6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-FfYyRxKPMgSOumtJ9QZS9A-1; Fri, 01 May 2020 04:28:35 -0400
X-MC-Unique: FfYyRxKPMgSOumtJ9QZS9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E806C107ACCD;
 Fri,  1 May 2020 08:28:33 +0000 (UTC)
Received: from localhost (ovpn-112-199.ams2.redhat.com [10.36.112.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 991165EE09;
 Fri,  1 May 2020 08:28:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Block patches
Date: Fri,  1 May 2020 09:28:02 +0100
Message-Id: <20200501082806.205696-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 04:28:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Bandan Das <bsd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Lieven <pl@kamp.de>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
bG93IHRoZSBmdXp6ZXINCnRhcmdldCB0byBiZSBzZWxlY3RlZCBmcm9tIGFyZ3ZbMF0uDQoNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCg0KQWxleGFuZGVyIEJ1bGVrb3YgKDEpOg0KICBmdXp6OiBzZWxlY3QgZnV6eiB0YXJn
ZXQgdXNpbmcgZXhlY3V0YWJsZSBuYW1lDQoNCkRhbmllbCBCcm9kc2t5ICgyKToNCiAgbG9ja2Fi
bGU6IGZpeCBfX0NPVU5URVJfXyBtYWNybyB0byBiZSByZWZlcmVuY2VkIHByb3Blcmx5DQogIGxv
Y2thYmxlOiByZXBsYWNlZCBsb2NrcyB3aXRoIGxvY2sgZ3VhcmQgbWFjcm9zIHdoZXJlIGFwcHJv
cHJpYXRlDQoNClNpbXJhbiBTaW5naGFsICgxKToNCiAgbG9ja2FibGU6IFJlcGxhY2UgbG9ja3Mg
d2l0aCBsb2NrIGd1YXJkIG1hY3Jvcw0KDQogaW5jbHVkZS9xZW11L2xvY2thYmxlLmggfCAgNyAr
KystLS0NCiBpbmNsdWRlL3FlbXUvcmN1LmggICAgICB8ICAyICstDQogYmxvY2svaXNjc2kuYyAg
ICAgICAgICAgfCAgNyArKy0tLS0NCiBibG9jay9uZnMuYyAgICAgICAgICAgICB8IDUxICsrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogY3B1cy1jb21tb24uYyAgICAg
ICAgICAgfCAxNCArKysrLS0tLS0tLQ0KIGh3L2Rpc3BsYXkvcXhsLmMgICAgICAgIHwgNDMgKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIGh3L2h5cGVydi9oeXBlcnYuYyAgICAg
IHwgMTUgKysrKysrLS0tLS0tDQogaHcvcmRtYS9yZG1hX2JhY2tlbmQuYyAgfCA1MCArKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQogaHcvcmRtYS9yZG1hX3JtLmMgICAg
ICAgfCAgMyArLS0NCiBody92ZmlvL3BsYXRmb3JtLmMgICAgICB8ICA1ICsrLS0NCiBtaWdyYXRp
b24vbWlncmF0aW9uLmMgICB8ICAzICstLQ0KIG1pZ3JhdGlvbi9tdWx0aWZkLmMgICAgIHwgIDgg
KysrLS0tLQ0KIG1pZ3JhdGlvbi9yYW0uYyAgICAgICAgIHwgIDMgKy0tDQogbW9uaXRvci9taXNj
LmMgICAgICAgICAgfCAgNCArLS0tDQogdGVzdHMvcXRlc3QvZnV6ei9mdXp6LmMgfCAxOSArKysr
KysrKy0tLS0tLS0NCiB1aS9zcGljZS1kaXNwbGF5LmMgICAgICB8IDE0ICsrKysrLS0tLS0tDQog
dXRpbC9sb2cuYyAgICAgICAgICAgICAgfCAgNCArKy0tDQogdXRpbC9xZW11LXRpbWVyLmMgICAg
ICAgfCAxNyArKysrKysrLS0tLS0tLQ0KIHV0aWwvcmN1LmMgICAgICAgICAgICAgIHwgIDggKysr
LS0tLQ0KIHV0aWwvdGhyZWFkLXBvb2wuYyAgICAgIHwgIDMgKy0tDQogdXRpbC92ZmlvLWhlbHBl
cnMuYyAgICAgfCAgNSArKy0tDQogc2xpcnAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIDIy
IGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspLCAxNTQgZGVsZXRpb25zKC0pDQoNCi0t
IA0KMi4yNS4zDQoNCg==


