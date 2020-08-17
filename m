Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64AAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1C82224D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPxM9Ws2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1C82224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hUz-0005Io-Ek
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsS-00080J-CM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k7gsQ-0003gL-9k
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597677405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1stjU8fsCZhvlm5NQ0xYz90Wb+FZENs6sRtQCHDzqJw=;
 b=CPxM9Ws2pfAtk8KU90t835itQGzlFqUhWL2P6wp3iXZmwDZZzOo4Qb0jn72caKeHs+oa/t
 90t43x8FgALaVWwC37fx8ubl67lCBiod3iC7fIp30EGy8V6PCjDWWS9+Hl2TMEmavsTHve
 1jEwLI5wq8p+VArh/MmxIO98jsZR/1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-bmnaymB6MJ6blMvPERzn_g-1; Mon, 17 Aug 2020 11:16:40 -0400
X-MC-Unique: bmnaymB6MJ6blMvPERzn_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E534807331;
 Mon, 17 Aug 2020 15:16:39 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5699B5C3E1;
 Mon, 17 Aug 2020 15:16:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/3] Block patches
Date: Mon, 17 Aug 2020 16:16:31 +0100
Message-Id: <20200817151634.35563-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 01:24:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkMGVkNmE2OWQzOTlhZTE5Mzk1OTIy
NWNkZWFhOTM4Mjc0NmM5MWNjOg0KDQogIFVwZGF0ZSB2ZXJzaW9uIGZvciB2NS4xLjAgcmVsZWFz
ZSAoMjAyMC0wOC0xMSAxNzowNzowMyArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0
IHRhZ3MvYmxvY2stcHVsbC1yZXF1ZXN0DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
byA0NDI3N2JmOTE0NDcxOTYyYzllODhlMDljODU5YWFlNjVhZTEwOWM0Og0KDQogIGFpby1wb3Np
eDoga2VlcCBhaW9fbm90aWZ5X21lIGRpc2FibGVkIGR1cmluZyBwb2xsaW5nICgyMDIwLTA4LTEz
IDEzOjM0OjE0ID0NCiswMTAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpQdWxsIHJlcXVlc3QNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQpTdGVmYW4gSGFqbm9jemkgKDMpOg0KICBhc3luYzogcmVuYW1lIGV2ZW50X25vdGlmaWVyX2R1
bW15X2NiL3BvbGwoKQ0KICBhc3luYzogYWx3YXlzIHNldCBjdHgtPm5vdGlmaWVkIGluIGFpb19u
b3RpZnkoKQ0KICBhaW8tcG9zaXg6IGtlZXAgYWlvX25vdGlmeV9tZSBkaXNhYmxlZCBkdXJpbmcg
cG9sbGluZw0KDQogdXRpbC9haW8tcG9zaXguYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogdXRpbC9hc3luYy5jICAgICB8IDM2ICsrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNDggaW5zZXJ0
aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQoNCi0tPTIwDQoyLjI2LjINCg0K


