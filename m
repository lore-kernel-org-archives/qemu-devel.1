Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C479C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F32321D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F32321D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1nc-00059g-Dw
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jC1mE-0002qe-Dq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jC1mC-0001e8-5j
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:01 -0400
Resent-Date: Wed, 11 Mar 2020 09:52:01 -0400
Resent-Message-Id: <E1jC1mC-0001e8-5j@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jC1mB-0001dP-O5; Wed, 11 Mar 2020 09:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583934709; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hmj7zDeAqAKA/dBDDlNE/V1j2dXiZQQELuomYXTzmAXCEeL5Q5yI6dqX3wT9D/KBLRbbn2m/CfXwvYT9t3WehfypWcRN5lx2PUR387fGRQtxRvz4ZBqvm+hRw3O3+yD4wwDLn9m7e5BOzxRlUZYP+H2dlWbuzhQ8B0Cx23VH/Vk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583934709;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hPWqXQD+iWy+iiLPtWS9ihfbOLuILTVMGxjQ6pj7woE=; 
 b=N7kZoclElMRStQpAAHelJn852dHoBjOJOk452heN/5OFuu75vyzfNrtH4cblnjJTloqluMTHNr6iDOeN+FBu497fsUy3Y89wMX9pk1dIYiacHnkJGC8Rm1Kv3pPSR1gmrCq4Op1DO6ULju8NgGRG/N0iQum21TyMCQ2nwDk2dks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583934706199183.91796003785146;
 Wed, 11 Mar 2020 06:51:46 -0700 (PDT)
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
Subject: Re: [PULL 0/9] Block patches
Message-ID: <158393470453.5248.14269785570464192054@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Wed, 11 Mar 2020 06:51:46 -0700 (PDT)
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
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMTEyNDA0NS4yNzc5
NjktMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCAwLzldIEJsb2NrIHBhdGNoZXMKTWVzc2FnZS1p
ZDogMjAyMDAzMTExMjQwNDUuMjc3OTY5LTEtc3RlZmFuaGFAcmVkaGF0LmNvbQpUeXBlOiBzZXJp
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjNkYzQ3YzYgYWlvLXBvc2l4OiByZW1vdmUgaWRsZSBwb2xsIGhhbmRs
ZXJzIHRvIGltcHJvdmUgc2NhbGFiaWxpdHkKNThjYTIzZCBhaW8tcG9zaXg6IHN1cHBvcnQgdXNl
cnNwYWNlIHBvbGxpbmcgb2YgZmQgbW9uaXRvcmluZwpmYzU4ODRjIGFpby1wb3NpeDogYWRkIGlv
X3VyaW5nIGZkIG1vbml0b3JpbmcgaW1wbGVtZW50YXRpb24KNzdmNjNkNiBhaW8tcG9zaXg6IHNp
bXBsaWZ5IEZETW9uT3BzLT51cGRhdGUoKSBwcm90b3R5cGUKZDYyZDEwMCBhaW8tcG9zaXg6IGV4
dHJhY3QgcHBvbGwoMikgYW5kIGVwb2xsKDcpIGZkIG1vbml0b3JpbmcKZGJiYmU2OSBhaW8tcG9z
aXg6IG1vdmUgUkNVX1JFQURfTE9DSygpIGludG8gcnVuX3BvbGxfaGFuZGxlcnMoKQo5MzljYWZh
IGFpby1wb3NpeDogY29tcGxldGVseSBzdG9wIHBvbGxpbmcgd2hlbiBkaXNhYmxlZAo0MjY0MjVi
IGFpby1wb3NpeDogcmVtb3ZlIGNvbmZ1c2luZyBRTElTVF9TQUZFX1JFTU9WRSgpCjg2YWM4YTcg
cWVtdS9xdWV1ZS5oOiBjbGVhciBsaW5rZWQgbGlzdCBwb2ludGVycyBvbiByZW1vdmUKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgODZhYzhhNzk2NDlkIChxZW11L3F1
ZXVlLmg6IGNsZWFyIGxpbmtlZCBsaXN0IHBvaW50ZXJzIG9uIHJlbW92ZSkKRVJST1I6IGRvIG5v
dCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24KIzY2OiBGSUxFOiBpbmNsdWRlL3FlbXUv
cXVldWUuaDozMTQ6CisgICAgaWYgKCgoaGVhZCktPnNxaF9maXJzdCA9IGVsbS0+ZmllbGQuc3Fl
X25leHQpID09IE5VTEwpICAgICAgICAgICAgICBcCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDU5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKMi85IENoZWNraW5nIGNvbW1pdCA0MjY0MjViYTZiYzIgKGFpby1wb3NpeDogcmVtb3ZlIGNv
bmZ1c2luZyBRTElTVF9TQUZFX1JFTU9WRSgpKQozLzkgQ2hlY2tpbmcgY29tbWl0IDkzOWNhZmEx
Y2Y3ZiAoYWlvLXBvc2l4OiBjb21wbGV0ZWx5IHN0b3AgcG9sbGluZyB3aGVuIGRpc2FibGVkKQo0
LzkgQ2hlY2tpbmcgY29tbWl0IGRiYmJlNjlhYThmZCAoYWlvLXBvc2l4OiBtb3ZlIFJDVV9SRUFE
X0xPQ0soKSBpbnRvIHJ1bl9wb2xsX2hhbmRsZXJzKCkpCjUvOSBDaGVja2luZyBjb21taXQgZDYy
ZDEwMDZlNTcxIChhaW8tcG9zaXg6IGV4dHJhY3QgcHBvbGwoMikgYW5kIGVwb2xsKDcpIGZkIG1v
bml0b3JpbmcpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMg
TUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzQ2OTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0
b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDcyMSBsaW5lcyBjaGVja2VkCgpQYXRjaCA1Lzkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNi85IENoZWNraW5nIGNvbW1pdCA3N2Y2M2Q2NTM0
OTYgKGFpby1wb3NpeDogc2ltcGxpZnkgRkRNb25PcHMtPnVwZGF0ZSgpIHByb3RvdHlwZSkKNy85
IENoZWNraW5nIGNvbW1pdCBmYzU4ODRjYjkzY2MgKGFpby1wb3NpeDogYWRkIGlvX3VyaW5nIGZk
IG1vbml0b3JpbmcgaW1wbGVtZW50YXRpb24pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxl
dGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzE4NjogCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDQ1NiBsaW5lcyBj
aGVja2VkCgpQYXRjaCA3LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC85IENoZWNraW5n
IGNvbW1pdCA1OGNhMjNkZWIzZTYgKGFpby1wb3NpeDogc3VwcG9ydCB1c2Vyc3BhY2UgcG9sbGlu
ZyBvZiBmZCBtb25pdG9yaW5nKQo5LzkgQ2hlY2tpbmcgY29tbWl0IDNkYzQ3YzZkMmY2YSAoYWlv
LXBvc2l4OiByZW1vdmUgaWRsZSBwb2xsIGhhbmRsZXJzIHRvIGltcHJvdmUgc2NhbGFiaWxpdHkp
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
MzExMTI0MDQ1LjI3Nzk2OS0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

