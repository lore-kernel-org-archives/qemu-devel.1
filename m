Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E59FC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FFF52078B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZRldP+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFF52078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67zU-0002Hl-Ih
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67wS-0005IL-JU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:46:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k67wQ-0002tf-1c
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597304785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8RRjpvYPCcfDxxO0ofYqEkm/yCYLWT9vZIQ9mkRtceg=;
 b=cZRldP+Q3LNA6Al2lOCsCkCsnJRZaB96fubgE7T0gElgDdiIPcDoKIiyIc/T9G47+DEmOt
 2CIsYjiNu8awcYbsfIDp2QCH3LkMdIhyNYolxP+rglhbjE52wL4fPduDH0oMumLanrAj2F
 4rIMw0ddCfP+T5sB2jNYHBqKh2h74/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-G1Shg1S1N5eAQwIxNyAdqg-1; Thu, 13 Aug 2020 03:46:23 -0400
X-MC-Unique: G1Shg1S1N5eAQwIxNyAdqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFDB01835869;
 Thu, 13 Aug 2020 07:46:20 +0000 (UTC)
Received: from localhost (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 419F454FE6;
 Thu, 13 Aug 2020 07:45:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] scripts/cleanup-trace-events: Emit files in alphabetical
 order
Date: Thu, 13 Aug 2020 06:22:55 +0100
Message-Id: <20200813052257.226142-8-stefanha@redhat.com>
In-Reply-To: <20200813052257.226142-1-stefanha@redhat.com>
References: <20200813052257.226142-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 Markus Armbruster <armbru@redhat.com>,
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

RnJvbTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPgoKU2lnbmVkLW9mZi1i
eTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIw
MDgwNjE0MTMzNC4zNjQ2MzAyLTMtYXJtYnJ1QHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3Rl
ZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHNjcmlwdHMvY2xlYW51cC10
cmFjZS1ldmVudHMucGwgfCAxMyArKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NjcmlwdHMvY2xlYW51cC10
cmFjZS1ldmVudHMucGwgYi9zY3JpcHRzL2NsZWFudXAtdHJhY2UtZXZlbnRzLnBsCmluZGV4IDZj
Mzc2N2JkNmEuLmM0MGQyZmNjNTAgMTAwNzU1Ci0tLSBhL3NjcmlwdHMvY2xlYW51cC10cmFjZS1l
dmVudHMucGwKKysrIGIvc2NyaXB0cy9jbGVhbnVwLXRyYWNlLWV2ZW50cy5wbApAQCAtMTUsMTIg
KzE1LDE1IEBAIHVzZSB3YXJuaW5nczsKIHVzZSBzdHJpY3Q7CiB1c2UgRmlsZTo6QmFzZW5hbWU7
CiAKLW15ICRidWYgPSAnJzsKK215IEBmaWxlcyA9ICgpOworbXkgJGV2ZW50cyA9ICcnOwogbXkg
JXNlZW4gPSAoKTsKIAogc3ViIG91dCB7Ci0gICAgcHJpbnQgJGJ1ZjsKLSAgICAkYnVmID0gJyc7
CisgICAgcHJpbnQgc29ydCBAZmlsZXM7CisgICAgcHJpbnQgJGV2ZW50czsKKyAgICBAZmlsZXMg
PSAoKTsKKyAgICAkZXZlbnRzID0gJyc7CiAgICAgJXNlZW4gPSAoKTsKIH0KIApAQCAtNDIsNyAr
NDUsNyBAQCB3aGlsZSAoPElOPikgewogICAgICAgICAgICAgY2hvbXAgJGZuYW1lOwogICAgICAg
ICAgICAgbmV4dCBpZiAkc2VlbnskZm5hbWV9IHx8ICRmbmFtZSBlcSAndHJhY2UtZXZlbnRzJzsK
ICAgICAgICAgICAgICRzZWVueyRmbmFtZX0gPSAxOwotICAgICAgICAgICAgJGJ1ZiA9ICIjICRm
bmFtZVxuIiAuICRidWY7CisgICAgICAgICAgICBwdXNoIEBmaWxlcywgIiMgJGZuYW1lXG4iOwog
ICAgICAgICB9CiAgICAgICAgIHVubGVzcyAoY2xvc2UgR1JFUCkgewogICAgICAgICAgICAgZGll
ICJjbG9zZSBnaXQgZ3JlcDogJCEiCkBAIC01NSw3ICs1OCw3IEBAIHdoaWxlICg8SU4+KSB7CiAg
ICAgfSBlbHNpZiAoIS9eI3xeJC8pIHsKICAgICAgICAgd2FybiAidW5pbnRlbGxpZ2libGUgbGlu
ZSI7CiAgICAgfQotICAgICRidWYgLj0gJF87CisgICAgJGV2ZW50cyAuPSAkXzsKIH0KIAogb3V0
OwotLSAKMi4yNi4yCgo=


