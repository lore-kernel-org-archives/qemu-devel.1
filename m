Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C68420740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 23:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C68420740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZNg3-0003sS-Fb
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 18:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iZNeu-00031p-ET
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iZNes-0008C6-JV
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 18:20:43 -0500
Resent-Date: Mon, 25 Nov 2019 18:20:43 -0500
Resent-Message-Id: <E1iZNes-0008C6-JV@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iZNes-0008Bp-Bf; Mon, 25 Nov 2019 18:20:42 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574724029; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zx6MgozdAYKTnQ4CxNvP9HR3t5Y67M7RkL63gTc6OCXFbsKr5iD4tutMbHxX3+Hn0GHP9gEVDZDq2cfj2U4WEg0gOL0Wb/kTDPdLAH5t6fQDT/Y7CUlQMzBlZImWFpTQCIk/1TU6dVgVrBuJ4g7Fv2R8MESq7kfKzMox6UNSqzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574724029;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XNtKQQdJm9jYMdXyexvtCI8NLGMJh+NTIZNPjTx+i7Q=; 
 b=kiosqyhjCPz6WzfuxFEDk51hXahpYOJpUlRZXCRARaL7gf243OQbBjrFC9pIG3HMk37MsYPdSJbRPVRnEIkukNXHNtaOvL/1Ts6P3powGounWYmKLDNmpmtiqh8etaZ9qQLjxWrTmGcGSq96JJt0aHo5MIVi5k7wxTfQxftLqFU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157472402749278.99801083434284;
 Mon, 25 Nov 2019 15:20:27 -0800 (PST)
In-Reply-To: <20191125172031.16282-1-david@redhat.com>
Subject: Re: [PATCH v2 0/2] s390x/cpumodel: Introduce dynamic feature group
Message-ID: <157472402533.28656.6410799825544177136@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@redhat.com
Date: Mon, 25 Nov 2019 15:20:27 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, berrange@redhat.com,
 frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mimu@linux.ibm.com, jdenemar@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNTE3MjAzMS4xNjI4
Mi0xLWRhdmlkQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MiAwLzJdIHMzOTB4L2NwdW1vZGVsOiBJbnRyb2R1
Y2UgZHluYW1pYyBmZWF0dXJlIGdyb3VwClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTEy
NTE3MjAzMS4xNjI4Mi0xLWRhdmlkQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmFiYjFiYmEgczM5
MHgvY3B1bW9kZWw6IEludHJvZHVjZSBkeW5hbWljIGZlYXR1cmUgZ3JvdXBzCmY4YjM2MmYgczM5
MHgvY3B1bW9kZWw6IEZhY3RvciBvdXQgQ1BVIGZlYXR1cmUgZGVwZW5kZW5jaWVzCgo9PT0gT1VU
UFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IGY4YjM2MmY0MDQ1MSAoczM5MHgvY3B1
bW9kZWw6IEZhY3RvciBvdXQgQ1BVIGZlYXR1cmUgZGVwZW5kZW5jaWVzKQoyLzIgQ2hlY2tpbmcg
Y29tbWl0IGFiYjFiYmE4MjI4NyAoczM5MHgvY3B1bW9kZWw6IEludHJvZHVjZSBkeW5hbWljIGZl
YXR1cmUgZ3JvdXBzKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojODI6IEZJTEU6
IHRhcmdldC9zMzkweC9jcHVfZmVhdHVyZXMuYzoxODY6CisgICAgRFlOX0ZFQVRfR1JPVVBfSU5J
VCgiYWxsLWZlYXR1cmVzIiwgQUxMLCAiRmVhdHVyZXMgdmFsaWQgZm9yIGEgQ1BVIGRlZmluaXRp
b24iKSwKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojODQ6IEZJTEU6IHRhcmdldC9z
MzkweC9jcHVfZmVhdHVyZXMuYzoxODg6CisgICAgRFlOX0ZFQVRfR1JPVVBfSU5JVCgicmVjb21t
ZW5kZWQtZmVhdHVyZXMiLCBSRUNPTU1FTkRFRCwgIkF2YWlsYWJsZSwgcmVjb21tZW5kZWQgZmVh
dHVyZXMgc3VwcG9ydGVkIGJ5IHRoZSBhY2NlbGVyYXRvciBpbiB0aGUgY3VycmVudCBob3N0IGZv
ciBhIENQVSBkZWZpbml0aW9uIiksCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzg2
OiBGSUxFOiB0YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzLmM6MTkwOgorICAgIERZTl9GRUFUX0dS
T1VQX0lOSVQoImF2YWlsYWJsZS1mZWF0dXJlcyIsIEFWQUlMQUJMRSwgIkF2YWlsYWJsZSBmZWF0
dXJlcyBzdXBwb3J0ZWQgYnkgdGhlIGFjY2VsZXJhdG9yIGluIHRoZSBjdXJyZW50IGhvc3QgZm9y
IGEgQ1BVIGRlZmluaXRpb24iKSwKCnRvdGFsOiAyIGVycm9ycywgMSB3YXJuaW5ncywgMjA5IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDIvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMjUxNzIw
MzEuMTYyODItMS1kYXZpZEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


