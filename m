Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5645BC742D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 01:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EF9208E4
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 01:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm6ch-00042f-Ap
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 21:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48465)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hm6cX-0003cz-3d
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 21:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hm6cU-0007mY-Vz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 21:14:36 -0400
Resent-Date: Fri, 12 Jul 2019 21:14:36 -0400
Resent-Message-Id: <E1hm6cU-0007mY-Vz@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hm6cU-0007hJ-My
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 21:14:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562980436; cv=none; d=zoho.com; s=zohoarc; 
 b=Z3MIt4lb7SgRP6aVwrK09bPxNZwzhKWat0QMxuAN/Kli6YzWsmMDCjdLHd1Hcec2MJmz0TZ1h4lCXxqUHF+cCSiqsuCF6DvJvSlbdWdU2/b8/8MMuAfTzud5fClsWLZyriPQFGi16qVRDgoMxYjVQWk0V1ccTnGtz9dt9pvowjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562980436;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=vKg5W3H3xGqftv6rLoYeWhBRsTECHGckkDRNA3SwWHA=; 
 b=KmQm+z08IR+UNv0qWtQqlNYvtGnsaJ8eGI7J/KjMrfDkTyFdQXwUdiHS+y7/spGdikixkSm42NJKH4aTNqsARapO7OkuX0hHjOnMCBw+/ZTn19AAYwyACFzhHK9BKFzzCNwhgfJ4J/GsKHtWUvf4r0WrFkZiSgYGz9e/xwvKX8o=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562980434512294.1022982603256;
 Fri, 12 Jul 2019 18:13:54 -0700 (PDT)
Message-ID: <156298043272.12463.2490556064780487596@c4a48874b076>
In-Reply-To: <20190711172845.31035-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Fri, 12 Jul 2019 18:13:54 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC v4 00/29] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, drjones@redhat.com, yi.l.liu@intel.com,
 mst@redhat.com, jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, vincent.stehle@arm.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMTE3Mjg0NS4zMTAz
NS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRo
ZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBw
cm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZfNjQtc29mdG1tdSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82NC1z
b2Z0bW11L2h3L3ZpcnRpby92aG9zdC11c2VyLWJsay1wY2kubwogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvaHcvdmlydGlvL3Zob3N0LXVzZXItaW5wdXQtcGNpLm8KICBDQyAgICAgIHg4Nl82NC1z
b2Z0bW11L2h3L3ZpcnRpby92aG9zdC11c2VyLXNjc2ktcGNpLm8KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L3ZpcnRpby92aXJ0aW8tcG1lbS5jOjIxOjEwOiBmYXRhbCBlcnJvcjogJ3N0YW5kYXJkLWhl
YWRlcnMvbGludXgvdmlydGlvX3BtZW0uaCcgZmlsZSBub3QgZm91bmQKI2luY2x1ZGUgInN0YW5k
YXJkLWhlYWRlcnMvbGludXgvdmlydGlvX3BtZW0uaCIKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KMSBlcnJvciBnZW5lcmF0ZWQuCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcxMTE3Mjg0NS4z
MTAzNS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


