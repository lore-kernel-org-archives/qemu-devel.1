Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F618C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 02:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4602070B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 02:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4602070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heWCE-0002hE-3y
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 22:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1heWAz-000264-4s
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 22:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1heWAx-0007Ih-Ld
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 22:54:49 -0400
Resent-Date: Fri, 21 Jun 2019 22:54:48 -0400
Resent-Message-Id: <E1heWAx-0007Ih-Ld@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1heWAx-0006vq-DF
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 22:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561171153; cv=none; d=zoho.com; s=zohoarc; 
 b=d2voGgo76USJLlaSdAhgWdTJGOxcBSLr2Sbqh9vfCgeKxeCnnusAdz85920ayNwC2dzaPxY98izD33TDuUlCoJqZHcjYEpCTVYVTzpLOBv9c0icRaRc75s38N3+1BRiVL1CBrLovGvyHm/K5EPLtRVWH+tlVRls0wOLtZhSapRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561171153;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=eL9Y9BhZATYEErVINWmIw7Pd/9MdQ7IW2vjEkNEqN2c=; 
 b=TDeYvG7CKued5emAUSh2MUTenntOsObYANPKxLs7sohL14nYtCaUEDOoIwnfupXXRYKetWe0s+LYKrGr8uDYF+Kyc56XP7p3TuvNs/7x1xYKSh4utVf5bDVAmNdLHr6pLYkZFG9J60vbBx9s2dMzsS4wHtwRX9RFRLppSVovflE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561171150980542.5349430617862;
 Fri, 21 Jun 2019 19:39:10 -0700 (PDT)
In-Reply-To: <20190621213712.16222-1-liran.alon@oracle.com>
Message-ID: <156117114996.4070.7484891206134271759@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Fri, 21 Jun 2019 19:39:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/2] target/i386: kvm: Fix treatment of AMD
 SVM in nested migration
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
Cc: pbonzini@redhat.com, maran.wilson@oracle.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyMTIxMzcxMi4xNjIy
Mi0xLWxpcmFuLmFsb25Ab3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzJdIHRhcmdldC9p
Mzg2OiBrdm06IEZpeCB0cmVhdG1lbnQgb2YgQU1EIFNWTSBpbiBuZXN0ZWQgbWlncmF0aW9uClR5
cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDYyMTIxMzcxMi4xNjIyMi0xLWxpcmFuLmFsb25A
b3JhY2xlLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
ICAgICAgIHBhdGNoZXcvMjAxOTA2MjEyMTM3MTIuMTYyMjItMS1saXJhbi5hbG9uQG9yYWNsZS5j
b20gLT4gcGF0Y2hldy8yMDE5MDYyMTIxMzcxMi4xNjIyMi0xLWxpcmFuLmFsb25Ab3JhY2xlLmNv
bQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmE1ZGU5NDA4YTggdGFyZ2V0L2kzODY6
IGt2bTogSW5pdCBuZXN0ZWQtc3RhdGUgaW4gY2FzZSBvZiB2Q1BVIGV4cG9zZWQgd2l0aCBTVk0K
MDZjYTk5ZDkwNyB0YXJnZXQvaTM4Njoga3ZtOiBCbG9jayBtaWdyYXRpb24gb24gdkNQVSBleHBv
c2VkIHdpdGggU1ZNIHdoZW4ga2VybmVsIGxhY2tzIGNhcHMgdG8gc2F2ZS9yZXN0b3JlIG5lc3Rl
ZCBzdGF0ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCAwNmNhOTlk
OTA3YmMgKHRhcmdldC9pMzg2OiBrdm06IEJsb2NrIG1pZ3JhdGlvbiBvbiB2Q1BVIGV4cG9zZWQg
d2l0aCBTVk0gd2hlbiBrZXJuZWwgbGFja3MgY2FwcyB0byBzYXZlL3Jlc3RvcmUgbmVzdGVkIHN0
YXRlKQpFUlJPUjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90
IHJlcXVpcmVkCiM0NjogRklMRTogdGFyZ2V0L2kzODYvY3B1Lmg6MTg3NzoKKyAgICByZXR1cm4g
KGNwdV9oYXNfdm14KGVudikgfHwgY3B1X2hhc19zdm0oZW52KSk7Cgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDMyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMi8yIENoZWNraW5nIGNvbW1pdCBhNWRlOTQwOGE4OWEgKHRhcmdldC9pMzg2
OiBrdm06IEluaXQgbmVzdGVkLXN0YXRlIGluIGNhc2Ugb2YgdkNQVSBleHBvc2VkIHdpdGggU1ZN
KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5
MDYyMTIxMzcxMi4xNjIyMi0xLWxpcmFuLmFsb25Ab3JhY2xlLmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


