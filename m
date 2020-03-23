Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F5C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444102072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8HADWxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444102072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKtG-0003Sf-ID
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jGKsU-0002vb-L0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jGKsT-0004A2-58
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:04:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jGKsT-00049M-1n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584961455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g3uwfbKDinLA38zhP4GvF+8jCkS7cHxIlQnECXnV6oA=;
 b=W8HADWxkXDqd/hrZoFBeTJFhx99ilzW36oPCc/yHtAN08OcgYdyvwdEtbNuJ364GzyCErA
 Gc+9JbzPE/fz24goF07jEgWyH6TSISxcej97oGzuYvIVUsNSnCbxyOpDCJ8i5UHeGWkERp
 RY7C4H395FmZcdTiEni58IRRi1wze4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-Yj8Je4DlNFaIvmMl2782Ig-1; Mon, 23 Mar 2020 07:04:14 -0400
X-MC-Unique: Yj8Je4DlNFaIvmMl2782Ig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 519DC801E7A;
 Mon, 23 Mar 2020 11:04:13 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2251060BE2;
 Mon, 23 Mar 2020 11:04:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-ga: document vsock-listen in the man page
Date: Mon, 23 Mar 2020 11:04:08 +0000
Message-Id: <20200323110408.309111-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWx0aG91Z2ggcWVtdS1nYSBoYXMgc3VwcG9ydGVkIHZzb2NrIHNpbmNlIDIwMTYgaXQgd2FzIG5v
dCBkb2N1bWVudGVkIG9uCnRoZSBtYW4gcGFnZS4KCkFsc28gYWRkIHRoZSBzb2NrZXQgYWRkcmVz
cyByZXByZXNlbnRhdGlvbiB0byB0aGUgcWdhIC0taGVscCBvdXRwdXQuCgpGaXhlczogNTg2ZWY1
ZGVlNzcxODBmYzMyZTMzYmMwODA1MTYwMDAzMDYzMDIzOQogICAgICAgKCJxZ2E6IGFkZCB2c29j
ay1saXN0ZW4gbWV0aG9kIikKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5o
YUByZWRoYXQuY29tPgotLS0KIGRvY3MvaW50ZXJvcC9xZW11LWdhLnJzdCB8IDUgKysrLS0KIHFn
YS9tYWluLmMgICAgICAgICAgICAgICB8IDQgKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9pbnRlcm9wL3FlbXUt
Z2EucnN0IGIvZG9jcy9pbnRlcm9wL3FlbXUtZ2EucnN0CmluZGV4IDEzMTNhNGFlMWMuLjMwNjMz
NTdiYjUgMTAwNjQ0Ci0tLSBhL2RvY3MvaW50ZXJvcC9xZW11LWdhLnJzdAorKysgYi9kb2NzL2lu
dGVyb3AvcWVtdS1nYS5yc3QKQEAgLTM2LDEzICszNiwxNCBAQCBPcHRpb25zCiAuLiBvcHRpb246
OiAtbSwgLS1tZXRob2Q9TUVUSE9ECiAKICAgVHJhbnNwb3J0IG1ldGhvZDogb25lIG9mIGBgdW5p
eC1saXN0ZW5gYCwgYGB2aXJ0aW8tc2VyaWFsYGAsIG9yCi0gIGBgaXNhLXNlcmlhbGBgIChgYHZp
cnRpby1zZXJpYWxgYCBpcyB0aGUgZGVmYXVsdCkuCisgIGBgaXNhLXNlcmlhbGBgLCBvciBgYHZz
b2NrLWxpc3RlbmBgIChgYHZpcnRpby1zZXJpYWxgYCBpcyB0aGUgZGVmYXVsdCkuCiAKIC4uIG9w
dGlvbjo6IC1wLCAtLXBhdGg9UEFUSAogCiAgIERldmljZS9zb2NrZXQgcGF0aCAodGhlIGRlZmF1
bHQgZm9yIHZpcnRpby1zZXJpYWwgaXMKICAgYGAvZGV2L3ZpcnRpby1wb3J0cy9vcmcucWVtdS5n
dWVzdF9hZ2VudC4wYGAsCi0gIHRoZSBkZWZhdWx0IGZvciBpc2Etc2VyaWFsIGlzIGBgL2Rldi90
dHlTMGBgKQorICB0aGUgZGVmYXVsdCBmb3IgaXNhLXNlcmlhbCBpcyBgYC9kZXYvdHR5UzBgYCku
IFNvY2tldCBhZGRyZXNzZXMgZm9yCisgIHZzb2NrLWxpc3RlbiBhcmUgd3JpdHRlbiBhcyBgYDxj
aWQ+Ojxwb3J0PmBgLgogCiAuLiBvcHRpb246OiAtbCwgLS1sb2dmaWxlPVBBVEgKIApkaWZmIC0t
Z2l0IGEvcWdhL21haW4uYyBiL3FnYS9tYWluLmMKaW5kZXggOGVlMjczNmY4ZS4uZjBlNDU0ZjI4
ZCAxMDA2NDQKLS0tIGEvcWdhL21haW4uYworKysgYi9xZ2EvbWFpbi5jCkBAIC0yMzQsNyArMjM0
LDkgQEAgUUVNVV9DT1BZUklHSFQgIlxuIgogIiAgLXAsIC0tcGF0aCAgICAgICAgZGV2aWNlL3Nv
Y2tldCBwYXRoICh0aGUgZGVmYXVsdCBmb3IgdmlydGlvLXNlcmlhbCBpczpcbiIKICIgICAgICAg
ICAgICAgICAgICAgICVzLFxuIgogIiAgICAgICAgICAgICAgICAgICAgdGhlIGRlZmF1bHQgZm9y
IGlzYS1zZXJpYWwgaXM6XG4iCi0iICAgICAgICAgICAgICAgICAgICAlcylcbiIKKyIgICAgICAg
ICAgICAgICAgICAgICVzKS5cbiIKKyIgICAgICAgICAgICAgICAgICAgIFNvY2tldCBhZGRyZXNz
ZXMgZm9yIHZzb2NrLWxpc3RlbiBhcmUgd3JpdHRlbiBhc1xuIgorIiAgICAgICAgICAgICAgICAg
ICAgPGNpZD46PHBvcnQ+LlxuIgogIiAgLWwsIC0tbG9nZmlsZSAgICAgc2V0IGxvZ2ZpbGUgcGF0
aCwgbG9ncyB0byBzdGRlcnIgYnkgZGVmYXVsdFxuIgogIiAgLWYsIC0tcGlkZmlsZSAgICAgc3Bl
Y2lmeSBwaWRmaWxlIChkZWZhdWx0IGlzICVzKVxuIgogI2lmZGVmIENPTkZJR19GU0ZSRUVaRQot
LSAKMi4yNC4xCgo=


