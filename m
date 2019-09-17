Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E95C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4019221670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4019221670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHwL-0001Yn-9s
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAHvf-00011q-Cv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAHvd-0004W3-Q9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:10:19 -0400
Resent-Date: Tue, 17 Sep 2019 14:10:19 -0400
Resent-Message-Id: <E1iAHvd-0004W3-Q9@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAHvc-0004SO-67
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:10:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568743792; cv=none; d=zoho.com; s=zohoarc; 
 b=fgi+xrEleb0VnkE6D+4B0wzCyObhuUcVrxzmPBiXO4nLNVvC9RVJGziFYNcFghyMdCqKbi5ctLgSbNr4bqCL1BsB/4tRaIbQ3T8GjuL43iElJgslaqw0pEM2/wop9KJVZg6QsN3OpgCmb2il3uMyXlgPG/WI+BBJoqajUmFsv1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568743792;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=N7oLRHg4rfJG8NQ7AWH6h2YReO4RvyuPrSZ+rPIeTeY=; 
 b=Bx8qFsBVOqnbn3bj68hxHqzSvlgTLTB6zxQy5Q2pk3QjoLrReNKoygV7DcuK0EzZ+0QZxnK1gC2Ojivsh5V0e3uOlDUpqehpWt9x1khBNEodpalLAH1W5VgsskFrGemfGeLgLGkz5YAy01xy7TUckwEJeaJ0L5soDIFini8uz88=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568743790242305.3360346097346;
 Tue, 17 Sep 2019 11:09:50 -0700 (PDT)
In-Reply-To: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
Message-ID: <156874378756.17151.16934104501272448361@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pavel.dovgaluk@gmail.com
Date: Tue, 17 Sep 2019 11:09:50 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com,
 artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, dovgaluk@ispras.ru, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, pavel.dovgaluk@ispras.ru,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY4NzIxNDY1NjUuMTc1Ny4z
MDMzMjE1ODczNjc3NTEyNDc0LnN0Z2l0QHBhc2hhLVByZWNpc2lvbi0zNjMwLVRvd2VyLwoKCgpI
aSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1m
ZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRB
UkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgouL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkgLS1lbmdpbmUgYXV0byBidWlsZCBxZW11
OmZlZG9yYSB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZmVkb3JhLmRvY2tlciAgIC0tYWRkLWN1
cnJlbnQtdXNlciAgCkltYWdlIGlzIHVwIHRvIGRhdGUuCiAgTEQgICAgICBkb2NrZXItdGVzdC1k
ZWJ1Z0BmZWRvcmEubW8KY2M6IGZhdGFsIGVycm9yOiBubyBpbnB1dCBmaWxlcwpjb21waWxhdGlv
biB0ZXJtaW5hdGVkLgptYWtlOiAqKiogW2RvY2tlci10ZXN0LWRlYnVnQGZlZG9yYS5tb10gRXJy
b3IgNAoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzE1Njg3MjE0NjU2NS4xNzU3LjMwMzMyMTU4NzM2Nzc1MTI0NzQuc3RnaXRAcGFzaGEtUHJl
Y2lzaW9uLTM2MzAtVG93ZXIvdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


