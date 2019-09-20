Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA0C3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E26B217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E26B217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB6ja-00073u-GZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB6in-0006af-Js
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB6im-0008Fc-Ba
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:24:25 -0400
Resent-Date: Thu, 19 Sep 2019 20:24:25 -0400
Resent-Message-Id: <E1iB6im-0008Fc-Ba@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB6im-0008FL-3n
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568939060; cv=none; d=zoho.com; s=zohoarc; 
 b=IHKaM7On2d/Z93xAcrNoc+HitM4tun7VuhRYAvPOdw9hXpIIZtNy4WbY/rEu6ZcL7pts+HzCP9CEEZ3IlxbIE62Ai3V/zj305MnwnFjczXvwgUDAxGz+iN2gooE37t+2vA6Hjv4Ug/V9UZjdBK2mXhxJXJIQkcI6cWtqZMygY4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568939060;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=UVK8uhOnnHA9hljHksuecS0W4DemmpQlOKZwIls9dGU=; 
 b=heynLG37UDlxdH6nIDEeJFvCJdja0iEIw7alk+c/rgVkW8p9iNS4eRonuyVwIONjoL8Zb+65JXMfowrxFCllKQK+ul8ONa/TVm6LN1fOTMVjssWJZkDf/ybuTjY+uq1CRuDDr9Qtm4TJOpPOXpcTni2BiY2GpPtiSyff7hUNbM0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156893905805954.45521300084192;
 Thu, 19 Sep 2019 17:24:18 -0700 (PDT)
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Subject: Re: [Qemu-devel] [PATCH v3 00/22] Add virtual device fuzzing support
Message-ID: <156893905695.2125.5008595756444159248@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Thu, 19 Sep 2019 17:24:18 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
Reply-To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, alxndr@bu.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxODIzMTg0Ni4yMjUz
OC0xLWFseG5kckBidS5lZHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXIt
bWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRz
IGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlv
dSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2Ut
ZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3L2FjcGkv
Y3B1X2hvdHBsdWcubwogIENDICAgICAgaHcvYWNwaS9tZW1vcnlfaG90cGx1Zy5vCi90bXAvcWVt
dS10ZXN0L3NyYy92bC5jOiBJbiBmdW5jdGlvbiAncWVtdV9jbGVhbnVwJzoKL3RtcC9xZW11LXRl
c3Qvc3JjL3ZsLmM6NDQ3OTo2OiBlcnJvcjogb2xkLXN0eWxlIGZ1bmN0aW9uIGRlZmluaXRpb24g
Wy1XZXJyb3I9b2xkLXN0eWxlLWRlZmluaXRpb25dCiB2b2lkIHFlbXVfY2xlYW51cCgpCiAgICAg
IF5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA5MTgyMzE4NDYuMjI1MzgtMS1hbHhuZHJAYnUuZWR1L3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZl
ZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


