Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD2AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FE5206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX3VDxyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FE5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFlr-00027t-89
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhx-0004i1-Ep
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21675
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhr-0006bb-PS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X0SaLnFosWQMILbJjlT+5LzCR5g7SXKjLHbsNPSwkA=;
 b=VX3VDxyiz31fRBgY/x4SG9N9Sc1AipLCVyYWAoRrtXko+VM9o9kUZ1DjQ4KGKM6pEPYixl
 C9DUl5RUmlF9+S6N+QFiKB6fyN+f61xkAy2Mx88vGOCTC99xJjpto7zHDKdClhoKBB+oah
 waSQf5aWSzSk6Fx1XrPGescjpV8Ik8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-J7nP85P4O9GsDqYrtl5g0w-1; Fri, 19 Jun 2020 08:01:11 -0400
X-MC-Unique: J7nP85P4O9GsDqYrtl5g0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E362107ACCA;
 Fri, 19 Jun 2020 12:01:10 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB2435D9CA;
 Fri, 19 Jun 2020 12:01:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 2/6] vhost-user-server: drop unused #include <eventfd.h>
Date: Fri, 19 Jun 2020 13:00:42 +0100
Message-Id: <20200619120046.2422205-2-stefanha@redhat.com>
In-Reply-To: <20200619120046.2422205-1-stefanha@redhat.com>
References: <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619120046.2422205-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMgYi91dGlsL3Zob3N0
LXVzZXItc2VydmVyLmMKaW5kZXggZTk0YThkOGE4My4uNDlhZGE4YmM3OCAxMDA2NDQKLS0tIGEv
dXRpbC92aG9zdC11c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwpA
QCAtNyw3ICs3LDYgQEAKICAqIGxhdGVyLiAgU2VlIHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRv
cC1sZXZlbCBkaXJlY3RvcnkuCiAgKi8KICNpbmNsdWRlICJxZW11L29zZGVwLmgiCi0jaW5jbHVk
ZSA8c3lzL2V2ZW50ZmQuaD4KICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUg
InZob3N0LXVzZXItc2VydmVyLmgiCiAKLS0gCjIuMjYuMgoK


