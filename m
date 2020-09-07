Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D266C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0360B207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs+1kPZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFNI-0005jB-4d
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFF8g-0005xE-FD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60381
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFF8e-0000gX-SW
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cMqIkVPXIWKRe4nl5FXSNfOMgI41529E9OBkbmkK7fU=;
 b=Xs+1kPZy7SAWgVY2xjjOsgvB2zRm1m6VUcIwjNSyzRYfoO7TdiZxbhfwf/axSvEmnoqTGr
 pUouH/kUOu50NrHBLQba04j5iZE6bWy9Vw4pbxKUrSHCzTLgrogQdum6IO9BVOezCCjF5T
 IjuYZ+jbAbyh+uMTt6iKuFg3xlb8Ook=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-EHR46C_DN7CIeiHVsy3rqw-1; Mon, 07 Sep 2020 07:16:38 -0400
X-MC-Unique: EHR46C_DN7CIeiHVsy3rqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE75710BBED6;
 Mon,  7 Sep 2020 11:16:36 +0000 (UTC)
Received: from localhost (ovpn-114-167.ams2.redhat.com [10.36.114.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CF187E19A;
 Mon,  7 Sep 2020 11:16:33 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c maintainer
Date: Mon,  7 Sep 2020 12:16:32 +0100
Message-Id: <20200907111632.90499-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RGV2ZWxvcG1lbnQgb2YgdGhlIHVzZXJzcGFjZSBOVk1lIGJsb2NrIGRyaXZlciBwaWNrZWQgdXAg
YWdhaW4gcmVjZW50bHkuCkFmdGVyIHRhbGtpbmcgd2l0aCBGYW0gSSBhbSBzdGVwcGluZyB1cCBh
cyBibG9jay9udm1lLmMgbWFpbnRhaW5lci4KUGF0Y2hlcyB3aWxsIGJlIG1lcmdlZCB0aHJvdWdo
IG15ICdibG9jaycgdHJlZS4KCkNjOiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPgpDYzog
S2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4KQ2M6IEZhbSBaaGVuZyA8ZmFtQGV1
cGhvbi5uZXQ+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KLS0tCiBNQUlOVEFJTkVSUyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMKaW5kZXggYjIzM2RhMmE3My4uYTE0Mzk0MTU1MSAxMDA2NDQKLS0tIGEvTUFJTlRBSU5F
UlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI4OTUsMTAgKzI4OTUsMTIgQEAgUzogU3VwcG9ydGVk
CiBGOiBibG9jay9udWxsLmMKIAogTlZNZSBCbG9jayBEcml2ZXIKLU06IEZhbSBaaGVuZyA8ZmFt
QGV1cGhvbi5uZXQ+CitNOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+CitS
OiBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PgogTDogcWVtdS1ibG9ja0Bub25nbnUub3JnCiBT
OiBTdXBwb3J0ZWQKIEY6IGJsb2NrL252bWUqCitUOiBnaXQgaHR0cHM6Ly9naXRodWIuY29tL3N0
ZWZhbmhhL3FlbXUuZ2l0IGJsb2NrCiAKIEJvb3RkZXZpY2UKIE06IEdvbmdsZWkgPGFyZWkuZ29u
Z2xlaUBodWF3ZWkuY29tPgotLSAKMi4yNi4yCgo=


