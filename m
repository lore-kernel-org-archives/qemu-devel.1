Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72AC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045472171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045472171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHAX-0005CI-5u
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAH3X-0007ge-2Y
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAH3V-0003ov-OZ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:14:22 -0400
Resent-Date: Tue, 17 Sep 2019 13:14:22 -0400
Resent-Message-Id: <E1iAH3V-0003ov-OZ@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAH3V-0003oH-H1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568740456; cv=none; d=zoho.com; s=zohoarc; 
 b=gqZVgOUL9pg9hghNANdghHSTD0rvtds8EIDEBF9N6JtNrRqzfd7dHNX12AbBWLV1M0RskO0/EmNkupys/HJwI7nJuWEcH97cjQf6fRflVh0tZeZ6I9WhUrTn7tXLhDlcJN7Tl9yu5Mu57cqWLVU5kPJTI4r7t7YfCRZC9ktHt5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568740456;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=F+VAErtq50GlKLIN3kVaefzGB2nNAVo8rGRhi2PCVUU=; 
 b=UgMlwgl7QeyUTU7uj1jxaGAVYWNVppqqBXxFs2Ncyk7CkZYc8Cgdr+TfuE2aaQr1YIAzPf7XwPUc6u5rU3wFQTsW5aXwv5+YZPINMwPuo6sFQ/86x+wBFqwpq0UpAMhc0V8vFydK2yTe72Y4y+7h2QZrvUyyfLkTlfRng5dRLcY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568740455719754.4435383909153;
 Tue, 17 Sep 2019 10:14:15 -0700 (PDT)
In-Reply-To: <20190917122559.15555-1-johannes@sipsolutions.net>
Message-ID: <156874045469.17151.12411065380886431817@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: johannes@sipsolutions.net
Date: Tue, 17 Sep 2019 10:14:15 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: handle NOFD flag in
 call/kick/err better
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
Cc: qemu-devel@nongnu.org, johannes.berg@intel.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzEyMjU1OS4xNTU1
NS0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVU
V09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgouL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkg
LS1lbmdpbmUgYXV0byBidWlsZCBxZW11OmZlZG9yYSB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMv
ZmVkb3JhLmRvY2tlciAgIC0tYWRkLWN1cnJlbnQtdXNlciAgCkltYWdlIGlzIHVwIHRvIGRhdGUu
CiAgTEQgICAgICBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEubW8KY2M6IGZhdGFsIGVycm9yOiBu
byBpbnB1dCBmaWxlcwpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogW2RvY2tlci10
ZXN0LW1pbmd3QGZlZG9yYS5tb10gRXJyb3IgNAoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE3MTIyNTU5LjE1NTU1LTEtam9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldC90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=


