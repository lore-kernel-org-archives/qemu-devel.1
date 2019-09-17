Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE24C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BBB2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BBB2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGSy-0004xM-4l
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAGFp-0002AU-QH
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAGFo-0004Ts-2B
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:23:01 -0400
Resent-Date: Tue, 17 Sep 2019 12:23:01 -0400
Resent-Message-Id: <E1iAGFo-0004Ts-2B@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAGFn-0004TP-QR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568737364; cv=none; d=zoho.com; s=zohoarc; 
 b=PO0khn629XyrbYkDR95ANNJ51e66Q2e4a51HVsu0HVR1K02uwT0Ow/RB28aVIZIc1SPOI2Z4QzqaeuRQ90IWb+jcVT/n9CJI/jFFJlNneid/CTThXA5zy6BCRPSUEik+FrK6nDGRyad516m6nXMEe1NxARYtsu1bY0zX38J2XbI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568737364;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=OLus1Vpps5CB7PjqrLM9SH5sNjMuj7D1u9fqRP1QFbw=; 
 b=RJ5ZziHLJN12rxgOhPSvbDA/WH3tLp+ODyiskNcVuLDnYIwpBnwIxRh7d0h8jPZGsLyFi6cFKKjR7Q66QGKtyGtnEYMw/ORyxjbNcfnIEmTUnuV4nG/KZkwkDqXm0u0I3NU2kcq76/MlcsO8USu+AlV+TzsJl+HdNHAlcwpQxQA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568737358066846.301593742104;
 Tue, 17 Sep 2019 09:22:38 -0700 (PDT)
In-Reply-To: <20190917111441.27405-1-kraxel@redhat.com>
Message-ID: <156873735697.17151.14736504340945340177@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Tue, 17 Sep 2019 09:22:38 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/2] ati: fix ati_cursor_define bug.
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
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, flier_m@outlook.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzExMTQ0MS4yNzQw
NS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2Ug
ZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgouL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkgLS1lbmdpbmUgYXV0byBidWlsZCBxZW11OmZlZG9yYSB0ZXN0cy9kb2NrZXIvZG9ja2VyZmls
ZXMvZmVkb3JhLmRvY2tlciAgIC0tYWRkLWN1cnJlbnQtdXNlciAgCkltYWdlIGlzIHVwIHRvIGRh
dGUuCiAgTEQgICAgICBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEubW8KY2M6IGZhdGFsIGVycm9y
OiBubyBpbnB1dCBmaWxlcwpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogW2RvY2tl
ci10ZXN0LWRlYnVnQGZlZG9yYS5tb10gRXJyb3IgNAoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE3MTExNDQxLjI3NDA1LTEta3Jh
eGVsQHJlZGhhdC5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


