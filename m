Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D705207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D705207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHTu-0000nD-Ow
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnHTM-0000LI-Cc; Mon, 22 Jun 2020 04:06:32 -0400
Resent-Date: Mon, 22 Jun 2020 04:06:32 -0400
Resent-Message-Id: <E1jnHTM-0000LI-Cc@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnHTJ-0005hD-O4; Mon, 22 Jun 2020 04:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592813177; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Gy2nHJ4Xk+8dAta2b2PAXbAyIZptiB6hgr/GYZQbl0EPPy3TT/cdoTyQGsTSj3kBHqZurXBB7pmGZiGBeiEUDzDdcKHQJl5mwJ1Jg2ifjifBXpevLBpl6eQkNxbLxRgxiMYx+vk/Knff3qtvQRul75YCZ186ZPdTJldpqrZtb3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592813177;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wBPobnDhhsEguf5x2DQbemnC+aLAZIa9TtQODKH0cew=; 
 b=OjaSqvyLrO+TcGjvEVeW+uItDZZaa9y8HLj40Ov5KlwhjmU0JwQfh2p0yEvMCbVJmVFAcPS1UkWQWGK7dQVcCBCb2EfSjruSVonGKaG0MoUtlzRlxqV55e1KLzPg/j/tdW01x6F0ldlZhMte4daAFs7G6kalyhPTpFEwRcXDDMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592813174812917.6987319836513;
 Mon, 22 Jun 2020 01:06:14 -0700 (PDT)
Message-ID: <159281317330.26976.1063867866837496160@d1fd068a5071>
Subject: Re: [PATCH v4 0/9] pc-bios: s390x: Cleanup part 1
In-Reply-To: <20200622074235.32528-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Mon, 22 Jun 2020 01:06:14 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 04:06:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyMjA3NDIzNS4zMjUy
OC0xLWZyYW5ramFAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY0IDAvOV0gcGMtYmlvczogczM5MHg6IENs
ZWFudXAgcGFydCAxClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDYyMjA3NDIzNS4zMjUy
OC0xLWZyYW5ramFAbGludXguaWJtLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMWUzNzE2ZSBwYy1iaW9zOiBz
MzkweDogTWFrZSB1MzIgcHRyIGNoZWNrIGV4cGxpY2l0CmUxYmFlNTQgcGMtYmlvczogczM5MHg6
IFVzZSBlYmNkaWMyYXNjaWkgdGFibGUKNzQ1MmI1ZSBwYy1iaW9zOiBzMzkweDogTW92ZSBwYW5p
YygpIGludG8gaGVhZGVyIGFuZCBhZGQgaW5maW5pdGUgbG9vcAo2Y2RjYmM2IHBjLWJpb3M6IHMz
OTB4OiBVc2UgUFNXIG1hc2tzIHdoZXJlIHBvc3NpYmxlIGFuZCBpbnRyb2R1Y2UgUFNXX01BU0tf
U0hPUlRfQUREUgo2YzM5YjIzIHBjLWJpb3M6IHMzOTB4OiBSZW5hbWUgYW5kIHVzZSBQU1dfTUFT
S19aTU9ERSBjb25zdGFudAo5MTgxN2EzIHBjLWJpb3M6IHMzOTB4OiBHZXQgcmlkIG9mIG1hZ2lj
IG9mZnNldHMgaW50byB0aGUgbG93Y29yZQphNmFmYmVmIHBjLWJpb3M6IHMzOTB4OiBNb3ZlIHNs
ZWVwIGFuZCB5aWVsZCB0byBoZWxwZXIuaAphYTYxYjU2IHBjLWJpb3M6IHMzOTB4OiBDb25zb2xp
ZGF0ZSB0aW1pbmcgZnVuY3Rpb25zIGludG8gdGltZS5oCjEwM2Y1ODggcGMtYmlvczogczM5MHg6
IGNpby5jIGNsZWFudXAgYW5kIGNvbXBpbGUgZml4Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzkg
Q2hlY2tpbmcgY29tbWl0IDEwM2Y1ODhkMWVlOCAocGMtYmlvczogczM5MHg6IGNpby5jIGNsZWFu
dXAgYW5kIGNvbXBpbGUgZml4KQoyLzkgQ2hlY2tpbmcgY29tbWl0IGFhNjFiNTZhMGVlYSAocGMt
YmlvczogczM5MHg6IENvbnNvbGlkYXRlIHRpbWluZyBmdW5jdGlvbnMgaW50byB0aW1lLmgpCldB
Uk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMg
bmVlZCB1cGRhdGluZz8KIzkzOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9y
cywgMSB3YXJuaW5ncywgMTQyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvOSBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgozLzkgQ2hlY2tpbmcgY29tbWl0IGE2YWZiZWZhMzhhYiAocGMtYmlvczog
czM5MHg6IE1vdmUgc2xlZXAgYW5kIHlpZWxkIHRvIGhlbHBlci5oKQo0LzkgQ2hlY2tpbmcgY29t
bWl0IDkxODE3YTM0ZWQyNiAocGMtYmlvczogczM5MHg6IEdldCByaWQgb2YgbWFnaWMgb2Zmc2V0
cyBpbnRvIHRoZSBsb3djb3JlKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6
JyAoY3R4OlZ4VikKIzMwOiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEyNzoKKyAgICAg
ICAgICAgIF9fdTE2IGNzc2lkOjg7CiAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBz
cGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzE6IEZJTEU6IHBjLWJp
b3MvczM5MC1jY3cvY2lvLmg6MTI4OgorICAgICAgICAgICAgX191MTYgcmVzZXJ2ZWQ6NDsKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnOicgKGN0eDpWeFYpCiMzMjogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMjk6
CisgICAgICAgICAgICBfX3UxNiBtOjE7CiAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzMzogRklMRTogcGMtYmlv
cy9zMzkwLWNjdy9jaW8uaDoxMzA6CisgICAgICAgICAgICBfX3UxNiBzc2lkOjI7CiAgICAgICAg
ICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicg
KGN0eDpWeFYpCiMzNDogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMzE6CisgICAgICAg
ICAgICBfX3UxNiBvbmU6MTsKICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiA1IGVycm9y
cywgMCB3YXJuaW5ncywgMzcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC85IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo1LzkgQ2hlY2tpbmcgY29tbWl0IDZjMzliMjMzZGU1MCAocGMtYmlvczog
czM5MHg6IFJlbmFtZSBhbmQgdXNlIFBTV19NQVNLX1pNT0RFIGNvbnN0YW50KQo2LzkgQ2hlY2tp
bmcgY29tbWl0IDZjZGNiYzYwNzViMCAocGMtYmlvczogczM5MHg6IFVzZSBQU1cgbWFza3Mgd2hl
cmUgcG9zc2libGUgYW5kIGludHJvZHVjZSBQU1dfTUFTS19TSE9SVF9BRERSKQo3LzkgQ2hlY2tp
bmcgY29tbWl0IDc0NTJiNWU2NGM5YSAocGMtYmlvczogczM5MHg6IE1vdmUgcGFuaWMoKSBpbnRv
IGhlYWRlciBhbmQgYWRkIGluZmluaXRlIGxvb3ApCjgvOSBDaGVja2luZyBjb21taXQgZTFiYWU1
NDQzOTBlIChwYy1iaW9zOiBzMzkweDogVXNlIGViY2RpYzJhc2NpaSB0YWJsZSkKOS85IENoZWNr
aW5nIGNvbW1pdCAxZTM3MTZlMTkwNzUgKHBjLWJpb3M6IHMzOTB4OiBNYWtlIHUzMiBwdHIgY2hl
Y2sgZXhwbGljaXQpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwNjIyMDc0MjM1LjMyNTI4LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

