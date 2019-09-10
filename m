Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461FDC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1946F2168B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1946F2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7pFg-0001CH-AO
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 19:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7pEU-0000WD-RY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7pET-0004pr-BM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:07:34 -0400
Resent-Date: Tue, 10 Sep 2019 19:07:34 -0400
Resent-Message-Id: <E1i7pET-0004pr-BM@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7pET-0004ow-2o
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:07:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568156834; cv=none; d=zoho.com; s=zohoarc; 
 b=dF0NeD/o1wXoB02ZFZB/9oqcUarViQ2ERv7pQf6U7GxbrvXxPh4OBakzv+YfD4srm2lxfHtYsAzKvdY9U/IqcIb+BcgGciuV9vygLiHQ/cOjI/qIeQvP0KDmtDiirLh5guVIMjLCFsF+dUY/IzTPDoCXPoEKXm6oBp8r/issPKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568156834;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=z0WhTug2KCrxluQchMvvIFOGWXOQlBQQaLZgFtzhEQ8=; 
 b=lth7exdXLzE9cppJRqJzFapiMjNm4PrE1EcnDK73/IFEOH7jkYN/IrbJdiAR3HgSoSMR1LlSmDGYR0lVPcFk0wgPGbBZU8EGxL3d45+vDjLf6vuuJFEon1HivX9xFWfaG+x/4tFgGWuF4rDIsMs0OBxlSoIT+rb+dZ9HW+Zlj50=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568156834087753.4861730579565;
 Tue, 10 Sep 2019 16:07:14 -0700 (PDT)
In-Reply-To: <20190910120927.1669283-1-maozhongyi@cmss.chinamobile.com>
Message-ID: <156815683288.15929.12759685314475360301@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: maozhongyi@cmss.chinamobile.com
Date: Tue, 10 Sep 2019 16:07:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/3] some fix in tests/migration
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
Cc: tony.nguyen@bt.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 maozhongyi@cmss.chinamobile.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDEyMDkyNy4xNjY5
MjgzLTEtbWFvemhvbmd5aUBjbXNzLmNoaW5hbW9iaWxlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmll
cyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJl
bG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAw
LzNdIHNvbWUgZml4IGluIHRlc3RzL21pZ3JhdGlvbgpNZXNzYWdlLWlkOiAyMDE5MDkxMDEyMDky
Ny4xNjY5MjgzLTEtbWFvemhvbmd5aUBjbXNzLmNoaW5hbW9iaWxlLmNvbQpUeXBlOiBzZXJpZXMK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKMWExZDdiMSB0ZXN0cy9taWdyYXRpb27vvJpmaXggdW5yZWFjaGFibGUgcGF0aCBpbiBz
dHJlc3MgdGVzdAo1YTE5YjllIHRlc3RzL21pZ3JhdGlvbjogZml4IGEgdHlwbyBpbiBjb21tZW50
CjNiMWE4YjcgdGVzdHMvbWlncmF0aW9uOiBtZW0gbGVhayBmaXgKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvMyBDaGVja2luZyBjb21taXQgM2IxYThiN2E2MTdlICh0ZXN0cy9taWdyYXRpb246IG1l
bSBsZWFrIGZpeCkKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBv
ZiB0aGlzIHN0YXRlbWVudAojMjI6IEZJTEU6IHRlc3RzL21pZ3JhdGlvbi9zdHJlc3MuYzoxODQ6
CisgICAgICAgIGlmIChkYXRhKQpbLi4uXQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi8z
IENoZWNraW5nIGNvbW1pdCA1YTE5YjllYjU3ZDkgKHRlc3RzL21pZ3JhdGlvbjogZml4IGEgdHlw
byBpbiBjb21tZW50KQozLzMgQ2hlY2tpbmcgY29tbWl0IDFhMWQ3YjEwOTdiNCAodGVzdHMvbWln
cmF0aW9u77yaZml4IHVucmVhY2hhYmxlIHBhdGggaW4gc3RyZXNzIHRlc3QpCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTEwMTIwOTI3LjE2
NjkyODMtMS1tYW96aG9uZ3lpQGNtc3MuY2hpbmFtb2JpbGUuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


