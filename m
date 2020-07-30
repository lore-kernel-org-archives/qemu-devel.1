Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C60C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521D020829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 18:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGBLXj5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521D020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1D7i-0000ZA-Cp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 14:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1D4a-0006bX-Bs
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 14:14:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k1D4W-0001SQ-IX
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 14:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596132867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XJXGIzEFHMpXEOAZXStSOrA6MmphEqOXr+KQfZf5PZQ=;
 b=dGBLXj5WDcUA/wm/IOYGYxOOsZ8sH3yAA5oM/3xdHtLAZwLZ+IowNmx4bUGoPIo4Z115kg
 5l5zZNapHoEMEjSo4chB3dq+u/NkVsRBi8gNWmu+2vCn+zNlh8mSEzpSpiB1I6ieCqvSnk
 n7Sft43Zoar8HyLN/hpru4OBzf9+Ccc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-7V8x_GPOPle73S2t_WJOeA-1; Thu, 30 Jul 2020 14:14:24 -0400
X-MC-Unique: 7V8x_GPOPle73S2t_WJOeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26EB18015CE;
 Thu, 30 Jul 2020 18:14:23 +0000 (UTC)
Received: from localhost (ovpn-114-112.ams2.redhat.com [10.36.114.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED2096111F;
 Thu, 30 Jul 2020 18:14:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 0/2] Tracing patches
Date: Thu, 30 Jul 2020 19:14:12 +0100
Message-Id: <20200730181414.160066-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1NzcyZjJiMWZjNWQwMGU3ZTA0ZTAx
ZmEyOGU5MDgxZDY1NTA0NDBhOg0KDQogIFVwZGF0ZSB2ZXJzaW9uIGZvciB2NS4xLjAtcmMyIHJl
bGVhc2UgKDIwMjAtMDctMjggMjE6NTE6MDMgKzAxMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGh0dHBzOi8vZ2l0aHViLmNvbS9zdGVmYW5oYS9xZW11
LmdpdCB0YWdzL3RyYWNpbmctcHVsbC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byAwMDA4MjI0NDFlMzQ5MTY5OTFmN2MwMzIxN2RjMjRmMzhiZTQ5ZTUwOg0KDQogIHRy
YWNldG9vbDogY2FyZWZ1bGx5IGRlZmluZSBTRFRfVVNFX1ZBUklBRElDICgyMDIwLTA3LTMwIDE2
OjAyOjM4ICswMTAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpQdWxsIHJlcXVlc3QNCg0KQSBidWlsZCBmaXggYW5k
IGEgJ3NpbXBsZScgdHJhY2UgYmFja2VuZCByZWdyZXNzaW9uIGZpeC4NCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpK
b3NoIER1Qm9pcyAoMSk6DQogIHRyYWNlL3NpbXBsZTogQWxsb3cgZW5hYmxpbmcgc2ltcGxlIHRy
YWNlcyBmcm9tIGNvbW1hbmQgbGluZQ0KDQpTdGVmYW4gSGFqbm9jemkgKDEpOg0KICB0cmFjZXRv
b2w6IGNhcmVmdWxseSBkZWZpbmUgU0RUX1VTRV9WQVJJQURJQw0KDQogdHJhY2UvY29udHJvbC5j
ICAgICAgICAgICAgICAgICAgICAgfCAxICsNCiBzY3JpcHRzL3RyYWNldG9vbC9iYWNrZW5kL2R0
cmFjZS5weSB8IDQgKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQoNCi0t
IA0KMi4yNi4yDQoNCg==


