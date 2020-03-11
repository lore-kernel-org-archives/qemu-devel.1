Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3808CC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020BC208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5YKjVGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020BC208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0gM-0007bp-3J
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC0fR-0006FP-Jo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC0fQ-00009d-Jv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:40:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53929
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC0fQ-00009D-GY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583930456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5s+FuYJm7Z3euUnW8fQZI3FVrF1mHoAXjlYJpNJR7r8=;
 b=f5YKjVGFTlr/evV7o5rcZYv7BfYo9AEYI6LUvpfpdfQvY1G34ckeiBlS6BLhlQIoLXIBlE
 qHCYjUbhcJzCPe0pBHSD8IGeHRI8fkZtfh3ZOAuC6+bJMvEAM0U8rkYM4lEFTaTR0HW/uy
 SWeeC1MAdJd1MQcQSlKl7MA+XCsCmS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-SyK5Vbh9OO6ZCuMwLbpD-w-1; Wed, 11 Mar 2020 08:40:52 -0400
X-MC-Unique: SyK5Vbh9OO6ZCuMwLbpD-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 335A0800D48;
 Wed, 11 Mar 2020 12:40:51 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D462560C18;
 Wed, 11 Mar 2020 12:40:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Block patches
Date: Wed, 11 Mar 2020 12:40:36 +0000
Message-Id: <20200311124045.277969-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2N2YxN2UyM2JhY2E1ZGQ1NDVmZTk4
YjAxMTY5Y2MzNTFhNzBmZTM1OgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL2tldmluL3RhZ3MvZm9yLXVwc3RyZWFtJyBpbnRvIHN0YWdpbmcgKDIwMjAtMDMtMDYgMTc6
MTU6MzYgKzAwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoKCiAg
aHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0IHRhZ3MvYmxvY2stcHVsbC1yZXF1
ZXN0Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gZDM3ZDBlMzY1YWZiNjgyNWE5MGQ4
MzU2ZmM2YWRjYzFmNThmNDBmMzoKCiAgYWlvLXBvc2l4OiByZW1vdmUgaWRsZSBwb2xsIGhhbmRs
ZXJzIHRvIGltcHJvdmUgc2NhbGFiaWxpdHkgKDIwMjAtMDMtMDkgMTY6NDU6MTYgKzAwMDApCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tClB1bGwgcmVxdWVzdAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKU3RlZmFuIEhham5vY3ppICg5KToKICBxZW11
L3F1ZXVlLmg6IGNsZWFyIGxpbmtlZCBsaXN0IHBvaW50ZXJzIG9uIHJlbW92ZQogIGFpby1wb3Np
eDogcmVtb3ZlIGNvbmZ1c2luZyBRTElTVF9TQUZFX1JFTU9WRSgpCiAgYWlvLXBvc2l4OiBjb21w
bGV0ZWx5IHN0b3AgcG9sbGluZyB3aGVuIGRpc2FibGVkCiAgYWlvLXBvc2l4OiBtb3ZlIFJDVV9S
RUFEX0xPQ0soKSBpbnRvIHJ1bl9wb2xsX2hhbmRsZXJzKCkKICBhaW8tcG9zaXg6IGV4dHJhY3Qg
cHBvbGwoMikgYW5kIGVwb2xsKDcpIGZkIG1vbml0b3JpbmcKICBhaW8tcG9zaXg6IHNpbXBsaWZ5
IEZETW9uT3BzLT51cGRhdGUoKSBwcm90b3R5cGUKICBhaW8tcG9zaXg6IGFkZCBpb191cmluZyBm
ZCBtb25pdG9yaW5nIGltcGxlbWVudGF0aW9uCiAgYWlvLXBvc2l4OiBzdXBwb3J0IHVzZXJzcGFj
ZSBwb2xsaW5nIG9mIGZkIG1vbml0b3JpbmcKICBhaW8tcG9zaXg6IHJlbW92ZSBpZGxlIHBvbGwg
aGFuZGxlcnMgdG8gaW1wcm92ZSBzY2FsYWJpbGl0eQoKIE1BSU5UQUlORVJTICAgICAgICAgICB8
ICAgMiArCiBjb25maWd1cmUgICAgICAgICAgICAgfCAgIDUgKwogaW5jbHVkZS9ibG9jay9haW8u
aCAgIHwgIDcxICsrKysrKy0KIGluY2x1ZGUvcWVtdS9xdWV1ZS5oICB8ICAxOSArLQogdXRpbC9N
YWtlZmlsZS5vYmpzICAgIHwgICAzICsKIHV0aWwvYWlvLXBvc2l4LmMgICAgICB8IDQ1MSArKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHV0aWwvYWlvLXBvc2l4Lmgg
ICAgICB8ICA4MSArKysrKysrKwogdXRpbC9mZG1vbi1lcG9sbC5jICAgIHwgMTU1ICsrKysrKysr
KysrKysrKwogdXRpbC9mZG1vbi1pb191cmluZy5jIHwgMzMyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIHV0aWwvZmRtb24tcG9sbC5jICAgICB8IDEwNyArKysrKysrKysrCiB1dGls
L3RyYWNlLWV2ZW50cyAgICAgfCAgIDIgKwogMTEgZmlsZXMgY2hhbmdlZCwgOTE1IGluc2VydGlv
bnMoKyksIDMxMyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB1dGlsL2Fpby1wb3Np
eC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9mZG1vbi1lcG9sbC5jCiBjcmVhdGUgbW9kZSAx
MDA2NDQgdXRpbC9mZG1vbi1pb191cmluZy5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9mZG1v
bi1wb2xsLmMKCi0tIAoyLjI0LjEKCg==


