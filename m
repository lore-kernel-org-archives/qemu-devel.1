Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0034C2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F5920678
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F5920678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6IC-0000m8-2G
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jK6H6-0007jD-Pc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jK6H4-0003N7-MA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:17:16 -0400
Resent-Date: Thu, 02 Apr 2020 16:17:16 -0400
Resent-Message-Id: <E1jK6H4-0003N7-MA@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jK6H4-0003Lj-Ei
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585858626; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eINW0ReSd0xGtziiUYspOyZawx/yJir8oA9iTOd453IBYpbiWF5MD2+exhl1wiIsZoo97DV7BaUe4zulmeAavtDy7R5heXnhghz1nJ+MpOmx67NHCJ7aAqPXZ0/b62snz1H1TuakxkKgg6I0L2eP8ZojfGNDHbVojJZS2N7KdE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585858626;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ljbzEQxh4iDlXrrFYBCXnU5xGv1eLWhGLiiDl1p21gM=; 
 b=NqDdBnKh7L2JtIs+xV35JYVZw0WS5N82U5dSmaK5OocEvCoHMa8LaeBfZKFgFr4dbcKpsE140gec9LB44S1vxLTlLoLtSgIVh1fheo4fVPE+UPSnAy7Se+1trFCm1sp9+o2+lyJH3/4/+JrfEnxlelxffzBmxrwhyS8mXEjdAWQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585858624548478.22096858879365;
 Thu, 2 Apr 2020 13:17:04 -0700 (PDT)
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
Subject: Re: [PULL 00/15] Misc patches for 5.0-rc2
Message-ID: <158585862408.23425.4843455252558607976@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Thu, 2 Apr 2020 13:17:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMjE5MDY0MC4xNjkz
LTEtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQg
dGVzdCBvbiBGcmVlQlNEIGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwg
YmUgaW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRv
IGEgY29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgoj
IGJyYW5jaAppZiBxZW11LXN5c3RlbS14ODZfNjQgLS1oZWxwID4vZGV2L251bGwgMj4mMTsgdGhl
bgogIFFFTVU9cWVtdS1zeXN0ZW0teDg2XzY0CmVsaWYgL3Vzci9saWJleGVjL3FlbXUta3ZtIC0t
aGVscCA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICBRRU1VPS91c3IvbGliZXhlYy9xZW11LWt2bQpl
bHNlCiAgZXhpdCAxCmZpCm1ha2Ugdm0tYnVpbGQtZnJlZWJzZCBKPTIxIFFFTVU9JFFFTVUKZXhp
dCAwCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDAyMTkwNjQwLjE2OTMtMS1wYm9uemlu
aUByZWRoYXQuY29tL3Rlc3RpbmcuRnJlZUJTRC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

