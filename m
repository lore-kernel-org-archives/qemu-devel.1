Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4688C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918402078D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6rupvlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918402078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspS0-0006QP-SJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jspOv-0002mh-2X
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:20:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jspOt-0006IF-0j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594135245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o+pvQjsUs/ODdDmVh8lJBkF3Yj2KFQk55EO/shVDkZs=;
 b=T6rupvlDwTVDmWseC4yTBB5iHVqqCjLk/zvA7a27ccyxDezSEtvCr2Zi7PNiqBd5Bh2xO2
 J6otscaoYsFzbaeU+WgHz7RWTwZzA2lnRc/jkHB1OSrPQSGoYsBD6wtPJrspkzRGSnWJpk
 WXooHuU9/0+3z55hND4bbpTX07jYRS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-D-pbJEUnMXWfa-Ti3IKtRg-1; Tue, 07 Jul 2020 11:20:38 -0400
X-MC-Unique: D-pbJEUnMXWfa-Ti3IKtRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C71D2BFDC;
 Tue,  7 Jul 2020 15:20:36 +0000 (UTC)
Received: from localhost (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87C8878125;
 Tue,  7 Jul 2020 15:20:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Tracing patches
Date: Tue,  7 Jul 2020 16:20:23 +0100
Message-Id: <20200707152024.459718-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA3NjIzYjViYTAxN2Y2MWRlNWQ3YzJi
YmExMmM2ZmViM2Q1NTA5MWIxOg0KDQogIE1lcmdlIHJlbW90ZS10cmFja2luZyBicmFuY2ggJ3Jl
bW90ZXMvdml2aWVyMi90YWdzL2xpbnV4LXVzZXItZm9yLTUuMS1wdWxsLXJlcXVlc3QnIGludG8g
c3RhZ2luZyAoMjAyMC0wNy0wNiAxMTo0MDoxMCArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0
aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3Fl
bXUuZ2l0IHRhZ3MvdHJhY2luZy1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFu
Z2VzIHVwIHRvIDI3ZTA4YmFiOTRmN2M2ZWJlMGI3NTkzOGM5OGMzOTRjOTY5ZTNmZDg6DQoNCiAg
dHJhY2V0b29sOiB3b3JrIGFyb3VuZCB1c3QgPHN5cy9zZHQuaD4gaW5jbHVkZSBjb25mbGljdCAo
MjAyMC0wNy0wNyAxNjowNzoxNCArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCkZp
eCBmb3IgYSBMVFRuZyBVc2Vyc3BhY2UgVHJhY2VyIGhlYWRlciBwcm9ibGVtLg0KDQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQoNClN0ZWZhbiBIYWpub2N6aSAoMSk6DQogIHRyYWNldG9vbDogd29yayBhcm91bmQgdXN0IDxz
eXMvc2R0Lmg+IGluY2x1ZGUgY29uZmxpY3QNCg0KIHNjcmlwdHMvdHJhY2V0b29sL2JhY2tlbmQv
ZHRyYWNlLnB5IHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoN
Ci0tIA0KMi4yNi4yDQoNCg==


