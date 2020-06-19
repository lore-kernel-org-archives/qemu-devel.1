Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1B4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02EC62083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1takkdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EC62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFkq-0000ij-4M
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFj8-0006ng-4y
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFj6-0006ij-Cf
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mh585U2B/M9NmLNmH8i/bQ2gYzD5lB7pAuJmwaEMtsE=;
 b=X1takkdP2Tlr1h9gW7cCy/TZBjpMdfZ1SRYAAFp+zz71xHP58MSZIQ2rbUh3YEsYWgLe0K
 vFdnspK2JCoBbzqCMUcbp2wzEiYzuJjt1x4YFC9Wrt1xpGHHxAo0l8emBVh4dEcTzgP/5E
 iBA/ApD3++wlyOuacanU/KyixPOiLv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-1qUVzBdaPOif51qCrZ322A-1; Fri, 19 Jun 2020 08:02:29 -0400
X-MC-Unique: 1qUVzBdaPOif51qCrZ322A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE90018FE861;
 Fri, 19 Jun 2020 12:02:28 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 670707C1EC;
 Fri, 19 Jun 2020 12:02:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 6/6] block-helpers: update doc comment in gtkdoc style
Date: Fri, 19 Jun 2020 13:01:57 +0100
Message-Id: <20200619120157.2422429-6-stefanha@redhat.com>
In-Reply-To: <20200619120157.2422429-1-stefanha@redhat.com>
References: <20200614183907.514282-4-coiby.xu@gmail.com>
 <20200619120157.2422429-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UUVNVSB1c2VzIHRoZSBndGtkb2Mgc3R5bGUgZm9yIEFQSSBkb2MgY29tbWVudHMuIEZvciBleGFt
cGxlcywgc2VlCmluY2x1ZGUvcW9tL29iamVjdC5oLgoKRnVsbHkgZG9jdW1lbnQgdGhlIGZ1bmN0
aW9uIHdpdGggdXAtdG8tZGF0ZSBpbmZvcm1hdGlvbiAodGhlIG1pbi9tYXgKdmFsdWVzIHdlcmUg
b3V0ZGF0ZWQpLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgotLS0KIHV0aWwvYmxvY2staGVscGVycy5jIHwgMTggKysrKysrKysrKy0tLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS91dGlsL2Jsb2NrLWhlbHBlcnMuYyBiL3V0aWwvYmxvY2staGVscGVycy5jCmluZGV4
IDlkMTIzNjgwMzIuLmM0ODUxNDMyZjUgMTAwNjQ0Ci0tLSBhL3V0aWwvYmxvY2staGVscGVycy5j
CisrKyBiL3V0aWwvYmxvY2staGVscGVycy5jCkBAIC0xMywxNSArMTMsMTcgQEAKICNpbmNsdWRl
ICJxYXBpL3FtcC9xZXJyb3IuaCIKICNpbmNsdWRlICJibG9jay1oZWxwZXJzLmgiCiAKLS8qCi0g
KiBMb2dpY2FsIGJsb2NrIHNpemUgaW5wdXQgdmFsaWRhdGlvbgorLyoqCisgKiBjaGVja19ibG9j
a19zaXplOgorICogQGlkOiBUaGUgdW5pcXVlIElEIG9mIHRoZSBvYmplY3QKKyAqIEBuYW1lOiBU
aGUgbmFtZSBvZiB0aGUgcHJvcGVydHkgYmVpbmcgdmFsaWRhdGVkCisgKiBAdmFsdWU6IFRoZSBi
bG9jayBzaXplIGluIGJ5dGVzCisgKiBAZXJycDogQSBwb2ludGVyIHRvIGFuIGFyZWEgdG8gc3Rv
cmUgYW4gZXJyb3IKICAqCi0gKiBUaGUgc2l6ZSBzaG91bGQgbWVldCB0aGUgZm9sbG93aW5nIGNv
bmRpdGlvbnM6Ci0gKiAxLiBtaW49NTEyCi0gKiAyLiBtYXg9MzI3NjgKLSAqIDMuIGEgcG93ZXIg
b2YgMgotICoKLSAqICBNb3ZlZCBmcm9tIGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmM6c2V0X2Js
b2Nrc2l6ZSgpCisgKiBUaGlzIGZ1bmN0aW9uIGNoZWNrcyB0aGF0IHRoZSBibG9jayBzaXplIG1l
ZXRzIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9uczoKKyAqIDEuIEF0IGxlYXN0IE1JTl9CTE9DS19T
SVpFCisgKiAyLiBObyBsYXJnZXIgdGhhbiBNQVhfQkxPQ0tfU0laRQorICogMy4gQSBwb3dlciBv
ZiAyCiAgKi8KIHZvaWQgY2hlY2tfYmxvY2tfc2l6ZShjb25zdCBjaGFyICppZCwgY29uc3QgY2hh
ciAqbmFtZSwgaW50NjRfdCB2YWx1ZSwKICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApCi0tIAoyLjI2LjIKCg==


