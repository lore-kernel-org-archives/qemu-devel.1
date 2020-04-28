Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F12C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2670206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2670206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRTG-0007ll-VL
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTROc-0005Q4-Rv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTRKf-0000Kr-0e
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:39:38 -0400
Resent-Date: Tue, 28 Apr 2020 10:39:38 -0400
Resent-Message-Id: <E1jTRKf-0000Kr-0e@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTRKe-0008WN-86; Tue, 28 Apr 2020 10:35:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588084493; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lojSe8YMbdqCaqkvcGY1y511kuX7n6n6WnbIS5/0PYxSMPqtpmr3jyVy2JmxNLH5tpWmXs7AI0qRNSggZR3fnWqTuHnxngPfndej78baDR4ZcEORFuczM1rQd+2EV+PiSQ5sZGFdBZchcWiLwV9XOFLV41puh44EnBc3HbB0Mak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588084493;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vnLqFN1UM+NnULpysaYDE7c4KKj/o4Wylu4C0io3U68=; 
 b=G481YwwOss7M5R/ZPLoqDTrsYKi4W1DJqWuoBWm6EP2eNhiS88dTByoKITM5dmdhNV+A+8JtVB/0PbL/l+6ijeM4ghXo0izpuICZPcgmsuzcKwlBRjZz1qYNqS1n5Nk8M0N38a928wf+X/cDFSt86o5LrSRU/BT67gxAaCvTWmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588084488913399.7635687250114;
 Tue, 28 Apr 2020 07:34:48 -0700 (PDT)
In-Reply-To: <20200428133407.10657-1-dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v21 0/4] implement zstd cluster compression method
Message-ID: <158808448742.30407.15546256250575826186@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dplotnikov@virtuozzo.com
Date: Tue, 28 Apr 2020 07:34:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:39:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODEzMzQwNy4xMDY1
Ny0xLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyMSAwLzRdIGltcGxlbWVudCB6c3Rk
IGNsdXN0ZXIgY29tcHJlc3Npb24gbWV0aG9kCk1lc3NhZ2UtaWQ6IDIwMjAwNDI4MTMzNDA3LjEw
NjU3LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
MTQ2ZmYyYSBpb3Rlc3RzOiAyODc6IGFkZCBxY293MiBjb21wcmVzc2lvbiB0eXBlIHRlc3QKNjk0
YmJjNyBxY293MjogYWRkIHpzdGQgY2x1c3RlciBjb21wcmVzc2lvbgo5NTRhYzBkIHFjb3cyOiBy
ZXdvcmsgdGhlIGNsdXN0ZXIgY29tcHJlc3Npb24gcm91dGluZQozMjk0YzIxIHFjb3cyOiBpbnRy
b2R1Y2UgY29tcHJlc3Npb24gdHlwZSBmZWF0dXJlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQg
Q2hlY2tpbmcgY29tbWl0IDMyOTRjMjFmOGE2NiAocWNvdzI6IGludHJvZHVjZSBjb21wcmVzc2lv
biB0eXBlIGZlYXR1cmUpCjIvNCBDaGVja2luZyBjb21taXQgOTU0YWMwZDBhNTQxIChxY293Mjog
cmV3b3JrIHRoZSBjbHVzdGVyIGNvbXByZXNzaW9uIHJvdXRpbmUpCjMvNCBDaGVja2luZyBjb21t
aXQgNjk0YmJjN2JmMDBmIChxY293MjogYWRkIHpzdGQgY2x1c3RlciBjb21wcmVzc2lvbikKRVJS
T1I6IGRvIG5vdCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24KIzExNTogRklMRTogYmxv
Y2svcWNvdzItdGhyZWFkcy5jOjIyNToKKyAgICBpZiAoKHpzdGRfcmV0ID0gWlNURF9jb21wcmVz
c1N0cmVhbTIoY2N0eCwgJm91dHB1dCwgJmlucHV0LCBaU1REX2VfZW5kKSkpIHsKCnRvdGFsOiAx
IGVycm9ycywgMCB3YXJuaW5ncywgMjM4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNCBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKNC80IENoZWNraW5nIGNvbW1pdCAxNDZmZjJhMDc4YTkgKGlv
dGVzdHM6IDI4NzogYWRkIHFjb3cyIGNvbXByZXNzaW9uIHR5cGUgdGVzdCkKV0FSTklORzogYWRk
ZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0
aW5nPwojMjM6IApuZXcgZmlsZSBtb2RlIDEwMDc1NQoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5p
bmdzLCAyMjggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNDI4MTMzNDA3LjEwNjU3LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

