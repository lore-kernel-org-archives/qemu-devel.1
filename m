Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81158C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2A0207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVOEY8Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2A0207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh919-0000me-In
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yE-0003B5-Ur
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60522
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jh8yD-0006nR-TB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591350541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neypGGLZI2BNbUwgf7E6gIfCJtlvfRXE5wbBxTNrMHo=;
 b=CVOEY8Dg9/1qVS7hOjYROgMo2DgohxuojSiT7UW7+DrobP0HNtJjTfZN6gj3B5DVlne7pu
 RG8oj8G8K7a/LfSGRRr5S7R8XFMLdLstvjkdqV1NhjWRmGaYiDHQUGhNCiM3qm546H+eAS
 tFf5c59Yc/5IMFMLP+ILDPIadoe8trM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Tcjf3hNWPHmMwehKjeaIGw-1; Fri, 05 Jun 2020 05:48:59 -0400
X-MC-Unique: Tcjf3hNWPHmMwehKjeaIGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4B7107ACCA;
 Fri,  5 Jun 2020 09:48:57 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA9D560E1C;
 Fri,  5 Jun 2020 09:48:45 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 05/11] fuzz: add mangled object name to linker script
Date: Fri,  5 Jun 2020 10:47:44 +0100
Message-Id: <20200605094750.149957-6-stefanha@redhat.com>
In-Reply-To: <20200605094750.149957-1-stefanha@redhat.com>
References: <20200605094750.149957-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpQcmV2aW91c2x5LCB3ZSBy
ZWxpZWQgb24gIkZ1enplclRyYWNlUEMqKC5ic3MqKSIgdG8gcGxhY2UgbGliZnV6emVyJ3MKZnV6
emVyOjpUUEMgb2JqZWN0IGludG8gb3VyIGNvbnRpZ3VvdXMgc2hhcmVkLW1lbW9yeSByZWdpb24u
IFRoaXMgZG9lcwpub3Qgd29yayBmb3Igc29tZSBsaWJmdXp6ZXIgYnVpbGRzLCBzbyB0aGlzIGFk
ZGl0aW9uIGlkZW50aWZpZXMgdGhlCnJlZ2lvbiBieSBpdHMgbWFuZ2xlZCBuYW1lOiAqKC5ic3Mu
X1pONmZ1enplcjNUUENFKTsKClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBCdWxla292IDxhbHhu
ZHJAYnUuZWR1PgpSZXZpZXdlZC1ieTogRGFycmVuIEtlbm55IDxkYXJyZW4ua2VubnlAb3JhY2xl
LmNvbT4KTWVzc2FnZS1pZDogMjAyMDA1MTIwMzAxMzMuMjk4OTYtNC1hbHhuZHJAYnUuZWR1ClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0
ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5sZCB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9mdXp6L2ZvcmtfZnV6ei5s
ZCBiL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkCmluZGV4IGUwODZiYmE4NzMuLmJmYjY2
N2VkMDYgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkCisrKyBiL3Rl
c3RzL3F0ZXN0L2Z1enovZm9ya19mdXp6LmxkCkBAIC0yOCw2ICsyOCwxMSBAQCBTRUNUSU9OUwog
CiAgICAgICAvKiBJbnRlcm5hbCBMaWJmdXp6ZXIgVHJhY2VQQyBvYmplY3Qgd2hpY2ggY29udGFp
bnMgdGhlIFZhbHVlUHJvZmlsZU1hcCAqLwogICAgICAgRnV6emVyVHJhY2VQQyooLmJzcyopOwor
ICAgICAgLyoKKyAgICAgICAqIEluIGNhc2UgdGhlIGFib3ZlIGxpbmUgZmFpbHMsIGV4cGxpY2l0
bHkgc3BlY2lmeSB0aGUgKG1hbmdsZWQpIG5hbWUgb2YKKyAgICAgICAqIHRoZSBvYmplY3Qgd2Ug
Y2FyZSBhYm91dAorICAgICAgICovCisgICAgICAgKiguYnNzLl9aTjZmdXp6ZXIzVFBDRSk7CiAg
IH0KICAgLmRhdGEuZnV6el9lbmQgOiBBTElHTig0SykKICAgewotLSAKMi4yNS40Cgo=


