Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA30C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE7D208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgQ/MxhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE7D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7Ov-0006KF-F1
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7M3-0003A5-13
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL7Lz-0006Au-6b
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4G0drXFEOYY/NZXMIC7xADNYTBe+qXzwwq4WtVyI9zc=;
 b=GgQ/MxhPvxHtcD3xo0Mu7CUbVnW4ykC7JacNGy/v21JqJfvNvKkm+hxuWFTZSOTvbYgvG7
 ke1r1R8Y12W0+vSGXSmucSefN90J6C30+cx2ASJd3PidUl9BM4y3HUBnVSJWfFzeI1JA1a
 Wb4OEbot0DNLu/VJ0UNAXNS1cKEOA+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-uZnbaH6gP9aKjqN93OnfmQ-1; Wed, 23 Sep 2020 12:10:42 -0400
X-MC-Unique: uZnbaH6gP9aKjqN93OnfmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57311007469;
 Wed, 23 Sep 2020 16:10:40 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 544895D990;
 Wed, 23 Sep 2020 16:10:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/13] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c
 maintainer
Date: Wed, 23 Sep 2020 17:10:19 +0100
Message-Id: <20200923161031.69474-2-stefanha@redhat.com>
In-Reply-To: <20200923161031.69474-1-stefanha@redhat.com>
References: <20200923161031.69474-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RGV2ZWxvcG1lbnQgb2YgdGhlIHVzZXJzcGFjZSBOVk1lIGJsb2NrIGRyaXZlciBwaWNrZWQgdXAg
YWdhaW4gcmVjZW50bHkuCkFmdGVyIHRhbGtpbmcgd2l0aCBGYW0gSSBhbSBzdGVwcGluZyB1cCBh
cyBibG9jay9udm1lLmMgbWFpbnRhaW5lci4KUGF0Y2hlcyB3aWxsIGJlIG1lcmdlZCB0aHJvdWdo
IG15ICdibG9jaycgdHJlZS4KCkNjOiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPgpDYzog
S2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1zdW5nLmNvbT4KQ2M6IEZhbSBaaGVuZyA8ZmFtQGV1
cGhvbi5uZXQ+ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KQWNrZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBL
bGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPgpBY2tlZC1ieTogRmFtIFpoZW5nIDxm
YW1AZXVwaG9uLm5ldD4KTWVzc2FnZS1pZDogMjAyMDA5MDcxMTE2MzIuOTA0OTktMS1zdGVmYW5o
YUByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KLS0tCiBNQUlOVEFJTkVSUyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJ
TlRBSU5FUlMKaW5kZXggM2QxN2NhZDE5YS4uNTM0ZmI0YzUxOSAxMDA2NDQKLS0tIGEvTUFJTlRB
SU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI5MjAsMTAgKzI5MjAsMTIgQEAgUzogU3VwcG9y
dGVkCiBGOiBibG9jay9udWxsLmMKIAogTlZNZSBCbG9jayBEcml2ZXIKLU06IEZhbSBaaGVuZyA8
ZmFtQGV1cGhvbi5uZXQ+CitNOiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
CitSOiBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PgogTDogcWVtdS1ibG9ja0Bub25nbnUub3Jn
CiBTOiBTdXBwb3J0ZWQKIEY6IGJsb2NrL252bWUqCitUOiBnaXQgaHR0cHM6Ly9naXRodWIuY29t
L3N0ZWZhbmhhL3FlbXUuZ2l0IGJsb2NrCiAKIEJvb3RkZXZpY2UKIE06IEdvbmdsZWkgPGFyZWku
Z29uZ2xlaUBodWF3ZWkuY29tPgotLSAKMi4yNi4yCgo=


