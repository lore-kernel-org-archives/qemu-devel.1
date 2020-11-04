Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F162DC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A1B20759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqSpcwKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A1B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKbx-00084M-5B
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYp-0004jW-0i
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKYm-0007rL-ON
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oL3ELJHJad57HtFMYj3OrTr7NYemUoxtUw7hulfPZF0=;
 b=DqSpcwKy6sLBrSIWf0edt/lonp9fNoxlwuQdubUe1VwwDNJOEjefDxnB3roMQUfUGmItUc
 Lmbf5bQpDX3nzQlOvGTV+iqysJFNQUItpKvdxoDNo39oWaU0huko1YxCdeAs85kLJPZaQ1
 lReCra2yh8F1HecM/755k1cptaxabVk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-AW5D_4UkOR6iBI34-Klj4Q-1; Wed, 04 Nov 2020 10:18:48 -0500
X-MC-Unique: AW5D_4UkOR6iBI34-Klj4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F7A31018F60;
 Wed,  4 Nov 2020 15:18:47 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD20B610F3;
 Wed,  4 Nov 2020 15:18:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/33] MAINTAINERS: Cover "block/nvme.h" file
Date: Wed,  4 Nov 2020 15:17:58 +0000
Message-Id: <20201104151828.405824-4-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVGhlICJi
bG9jay9udm1lLmgiIGhlYWRlciBpcyBzaGFyZWQgYnkgYm90aCB0aGUgTlZNZSBibG9jawpkcml2
ZXIgYW5kIHRoZSBOVk1lIGVtdWxhdGVkIGRldmljZS4gQWRkIHRoZSAnRjonIGVudHJ5IG9uCmJv
dGggc2VjdGlvbnMsIHNvIGFsbCBtYWludGFpbmVycy9yZXZpZXdlcnMgYXJlIG5vdGlmaWVkCndo
ZW4gaXQgaXMgY2hhbmdlZC4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogS2xhdXMgSmVuc2VuIDxrLmplbnNlbkBzYW1z
dW5nLmNvbT4KTWVzc2FnZS1JZDogPDIwMjAwNzAxMTQwNjM0LjI1OTk0LTEtcGhpbG1kQHJlZGhh
dC5jb20+Ci0tLQogTUFJTlRBSU5FUlMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCBjMWQx
NjAyNmJhLi5lYTQ3YjllODg5IDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJ
TkVSUwpAQCAtMTg3OCw2ICsxODc4LDcgQEAgTTogS2xhdXMgSmVuc2VuIDxpdHNAaXJyZWxldmFu
dC5kaz4KIEw6IHFlbXUtYmxvY2tAbm9uZ251Lm9yZwogUzogU3VwcG9ydGVkCiBGOiBody9ibG9j
ay9udm1lKgorRjogaW5jbHVkZS9ibG9jay9udm1lLmgKIEY6IHRlc3RzL3F0ZXN0L252bWUtdGVz
dC5jCiBGOiBkb2NzL3NwZWNzL252bWUudHh0CiBUOiBnaXQgZ2l0Oi8vZ2l0LmluZnJhZGVhZC5v
cmcvcWVtdS1udm1lLmdpdCBudm1lLW5leHQKQEAgLTI5NjIsNiArMjk2Myw3IEBAIFI6IEZhbSBa
aGVuZyA8ZmFtQGV1cGhvbi5uZXQ+CiBMOiBxZW11LWJsb2NrQG5vbmdudS5vcmcKIFM6IFN1cHBv
cnRlZAogRjogYmxvY2svbnZtZSoKK0Y6IGluY2x1ZGUvYmxvY2svbnZtZS5oCiBUOiBnaXQgaHR0
cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0IGJsb2NrCiAKIEJvb3RkZXZpY2UKLS0g
CjIuMjguMAoK


