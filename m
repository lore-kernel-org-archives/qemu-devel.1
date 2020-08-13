Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8C720716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw/Co17w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8C720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67vw-0003XF-E6
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67uT-0001l1-IL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:44:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67uQ-0002Ph-QO
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597304661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YBiC1GqKFvRi0M+f4LQ+24i6Z9dfxAtAy1eweel2fo4=;
 b=dw/Co17wnfTlhVd2mib8gSh6UEY1vRZ944eNMbiBXY6ri3nUlHnl/9YlxbEOXhTHPpuMUd
 3mgL+R4+h7RdSfSzOeettP6/LQZs/M7MR3nsTyqDdfWxxgcW0MXDY14R6dWPAuyFXkmV7U
 SQvPeB6cmmRlGmjrAeinjKMmGCBKOUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-XU6xIUR4N92EkoCakcETtw-1; Thu, 13 Aug 2020 03:44:17 -0400
X-MC-Unique: XU6xIUR4N92EkoCakcETtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6C618064BF;
 Thu, 13 Aug 2020 07:44:14 +0000 (UTC)
Received: from localhost (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E43F19D71;
 Thu, 13 Aug 2020 07:43:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Tracing patches
Date: Thu, 13 Aug 2020 06:22:48 +0100
Message-Id: <20200813052257.226142-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkMGVkNmE2OWQzOTlhZTE5Mzk1OTIy
NWNkZWFhOTM4Mjc0NmM5MWNjOg0KDQogIFVwZGF0ZSB2ZXJzaW9uIGZvciB2NS4xLjAgcmVsZWFz
ZSAoMjAyMC0wOC0xMSAxNzowNzowMyArMDEwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0
IHRhZ3MvdHJhY2luZy1wdWxsLXJlcXVlc3QNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVw
IHRvIGJkNmM5ZTU2YWJhMmUxYjlhMzA3NjQyYzcyMzc1Mzg2YWZiY2YxZjI6DQoNCiAgdHJhY2Ut
ZXZlbnRzOiBGaXggYXR0cmlidXRpb24gb2YgdHJhY2UgcG9pbnRzIHRvIHNvdXJjZSAoMjAyMC0w
OC0xMiAyMDoyODo1PQ0KNCArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUHVsbCByZXF1ZXN0DQoNCm1hY09T
IGR0cmFjZSBzdXBwb3J0IGFuZCBjbGVhbnVwcy4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpNYXJrdXMgQXJtYnJ1
c3RlciAoNCk6DQogIHNjcmlwdHMvY2xlYW51cC10cmFjZS1ldmVudHM6IEZpeCBmb3IgdmNwdSBw
cm9wZXJ0eQ0KICBzY3JpcHRzL2NsZWFudXAtdHJhY2UtZXZlbnRzOiBFbWl0IGZpbGVzIGluIGFs
cGhhYmV0aWNhbCBvcmRlcg0KICB0cmFjZS1ldmVudHM6IERlbGV0ZSB1bnVzZWQgdHJhY2UgcG9p
bnRzDQogIHRyYWNlLWV2ZW50czogRml4IGF0dHJpYnV0aW9uIG9mIHRyYWNlIHBvaW50cyB0byBz
b3VyY2UNCg0KUGhpbGlwcGUgTWF0aGlldS1EYXVkPUMzPUE5ICgxKToNCiAgc29mdG1tdTogQWRk
IG1pc3NpbmcgdHJhY2UtZXZlbnRzIGZpbGUNCg0KUm9tYW4gQm9sc2hha292ICg0KToNCiAgc2Ny
aXB0cy90cmFjZXRvb2w6IEZpeCBkdHJhY2UgZ2VuZXJhdGlvbiBmb3IgbWFjT1MNCiAgc2NyaXB0
cy90cmFjZXRvb2w6IFVzZSB2b2lkIHBvaW50ZXIgZm9yIHZjcHUNCiAgYnVpbGQ6IERvbid0IG1h
a2Ugb2JqZWN0IGZpbGVzIGZvciBkdHJhY2Ugb24gbWFjT1MNCiAgbmV0L2NvbG86IE1hdGNoIGlz
LWVuYWJsZWQgcHJvYmUgdG8gdHJhY2Vwb2ludA0KDQogTWFrZWZpbGUub2JqcyAgICAgICAgICAg
ICAgICAgICB8ICAzICsrKw0KIG5ldC9jb2xvLWNvbXBhcmUuYyAgICAgICAgICAgICAgfCA0MiAr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCiBuZXQvZmlsdGVyLXJld3JpdGVyLmMg
ICAgICAgICAgIHwgMTAgKysrKysrLS0NCiBzb2Z0bW11L2JhbGxvb24uYyAgICAgICAgICAgICAg
IHwgIDIgKy0NCiBzb2Z0bW11L2lvcG9ydC5jICAgICAgICAgICAgICAgIHwgIDIgKy0NCiBzb2Z0
bW11L21lbW9yeS5jICAgICAgICAgICAgICAgIHwgIDIgKy0NCiBzb2Z0bW11L3ZsLmMgICAgICAg
ICAgICAgICAgICAgIHwgIDIgKy0NCiBhdWRpby90cmFjZS1ldmVudHMgICAgICAgICAgICAgIHwg
IDMgLS0tDQogYmxvY2svdHJhY2UtZXZlbnRzICAgICAgICAgICAgICB8ICA4ICsrLS0tLS0NCiBo
dy9ibG9jay90cmFjZS1ldmVudHMgICAgICAgICAgIHwgIDIgKy0NCiBody9jaGFyL3RyYWNlLWV2
ZW50cyAgICAgICAgICAgIHwgIDIgKy0NCiBody9kaXNwbGF5L3RyYWNlLWV2ZW50cyAgICAgICAg
IHwgIDQgKysrLQ0KIGh3L2h5cGVydi90cmFjZS1ldmVudHMgICAgICAgICAgfCAgMiArLQ0KIGh3
L21pcHMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgfCAgMiArLQ0KIGh3L21pc2MvdHJhY2UtZXZl
bnRzICAgICAgICAgICAgfCAgOSArKystLS0tDQogaHcvcHBjL3RyYWNlLWV2ZW50cyAgICAgICAg
ICAgICB8IDEwICsrLS0tLS0tDQogaHcvcmlzY3YvdHJhY2UtZXZlbnRzICAgICAgICAgICB8ICAy
ICstDQogaHcvcnRjL3RyYWNlLWV2ZW50cyAgICAgICAgICAgICB8ICAyICstDQogaHcvdGltZXIv
dHJhY2UtZXZlbnRzICAgICAgICAgICB8ICAxIC0NCiBody90cG0vdHJhY2UtZXZlbnRzICAgICAg
ICAgICAgIHwgIDIgKy0NCiBody91c2IvdHJhY2UtZXZlbnRzICAgICAgICAgICAgIHwgIDQgKysr
LQ0KIGh3L3ZmaW8vdHJhY2UtZXZlbnRzICAgICAgICAgICAgfCAxMCArKysrLS0tLQ0KIGh3L3Zp
cnRpby90cmFjZS1ldmVudHMgICAgICAgICAgfCAgMiArLQ0KIG1pZ3JhdGlvbi90cmFjZS1ldmVu
dHMgICAgICAgICAgfCAzNyArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIG5ldC90cmFj
ZS1ldmVudHMgICAgICAgICAgICAgICAgfCAgMiAtLQ0KIHNjcmlwdHMvY2xlYW51cC10cmFjZS1l
dmVudHMucGwgfCAyMyArKysrKysrKysrKy0tLS0tLS0NCiBzY3JpcHRzL3RyYWNldG9vbC9mb3Jt
YXQvZC5weSAgIHwgMTUgKysrKysrKysrKystDQogc2NyaXB0cy90cmFjZXRvb2wvdmNwdS5weSAg
ICAgICB8ICAyICstDQogc29mdG1tdS90cmFjZS1ldmVudHMgICAgICAgICAgICB8IDI4ICsrKysr
KysrKysrKysrKysrKysrKysNCiB0YXJnZXQvcHBjL3RyYWNlLWV2ZW50cyAgICAgICAgIHwgIDEg
LQ0KIHRhcmdldC9yaXNjdi90cmFjZS1ldmVudHMgICAgICAgfCAgMiArLQ0KIHRyYWNlLWV2ZW50
cyAgICAgICAgICAgICAgICAgICAgfCAzMiArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogdWkv
dHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICB8ICA2ICsrLS0tDQogdXRpbC90cmFjZS1ldmVu
dHMgICAgICAgICAgICAgICB8ICA0ICsrKy0NCiAzNCBmaWxlcyBjaGFuZ2VkLCAxNTIgaW5zZXJ0
aW9ucygrKSwgMTI4IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb2Z0bW11L3Ry
YWNlLWV2ZW50cw0KDQotLT0yMA0KMi4yNi4yDQoNCg==


