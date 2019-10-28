Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCE8CA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43F1208C0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 00:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43F1208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPF9M-0006v5-Vt
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 20:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iPEr0-00084e-NY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iPEqz-0005ov-41
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:55:18 -0400
Resent-Date: Mon, 28 Oct 2019 19:55:18 -0400
Resent-Message-Id: <E1iPEqz-0005ov-41@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iPEqy-0005oU-HG; Mon, 28 Oct 2019 19:55:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572306902; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fqXHmAgTjg13h3qe/jIFdv0BBxIZ8/2SqZsbRm5jVw47HkNd1NDF02dTv89uXVEP/J1dmSkiDkjFvQhkVq44vcK7t3sNLab1Ch9455FdesRGA3TNLiSgm9z6CS67rrR1lIWB+lmH3yG3RNSVwqvJvNurF7OejZVBZ1/CPpEcyrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572306902;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=FUSDOFiOqCkrJ1Ihfh+3Y1jD8laLsGs/EabPMKUD9zI=; 
 b=EQtSp/SXc92/284TiqxC0FpCtqnySeBjXGcqilqdfvI9isjlDNRgxkJ2dg/jrHW+r2PejoKKCEviTMXyQ31Ci6VZgwWr3AKm0Y2OYVSlYCPQ4T8UrgCqzx3B/4r/H30N4h3eVhZxZZHXfObNlxV0WlwYLtuOfWkw/i2IwLqRX3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572306901694358.99177190661055;
 Mon, 28 Oct 2019 16:55:01 -0700 (PDT)
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
Subject: Re: [PULL 00/11] Q800 branch patches
Message-ID: <157230690007.12254.13906808936182823844@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Mon, 28 Oct 2019 16:55:01 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 jasowang@redhat.com, qemu-devel@nongnu.org, laurent@vivier.eu,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyODE4MTY0My41MTQz
LTEtbGF1cmVudEB2aXZpZXIuZXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIDAwLzExXSBRODAwIGJyYW5jaCBwYXRjaGVzClR5cGU6
IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAyODE4MTY0My41MTQzLTEtbGF1cmVudEB2aXZpZXIu
ZXUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjBhYWZlMzMgQm9vdExpbnV4Q29uc29sZVRlc3Q6IFRlc3QgdGhlIFF1
YWRyYSA4MDAKNjU3OGQwNSBody9tNjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKOGQ5
MjQxMSBody9tNjhrOiBhZGQgYSBkdW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyCjMzZTEyN2Ug
aHcvbTY4azogYWRkIE51YnVzIG1hY2ZiIHZpZGVvIGNhcmQKOWU1NDEzZiBody9tNjhrOiBhZGQg
TnVidXMgc3VwcG9ydAo3NzdiODVhIGh3L202OGs6IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQg
Zm9yIHZpYQpkMjNjYjk4IGh3L202OGs6IGFkZCBWSUEgc3VwcG9ydAo0NzczOTFhIGRwODM5M3g6
IG1hbmFnZSBiaWcgZW5kaWFuIGJ1cwphNTkxNWE1IGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNl
ZCBieSBNYWNpbnRvc2gKMzI0ZGQxMSBlc3A6IG1vdmUgZ2V0X2NtZCgpIHBvc3QtRE1BIGNvZGUg
dG8gZ2V0X2NtZF9jYigpCjQ0N2UwYjkgZXNwOiBtb3ZlIGhhbmRsZV90aV9jbWQoKSBjbGVhbnVw
IGNvZGUgdG8gZXNwX2RvX2RtYSgpLgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2lu
ZyBjb21taXQgNDQ3ZTBiOWU3ZTgyIChlc3A6IG1vdmUgaGFuZGxlX3RpX2NtZCgpIGNsZWFudXAg
Y29kZSB0byBlc3BfZG9fZG1hKCkuKQoyLzExIENoZWNraW5nIGNvbW1pdCAzMjRkZDExYmQ4NDMg
KGVzcDogbW92ZSBnZXRfY21kKCkgcG9zdC1ETUEgY29kZSB0byBnZXRfY21kX2NiKCkpCjMvMTEg
Q2hlY2tpbmcgY29tbWl0IGE1OTE1YTU4Nzg0MSAoZXNwOiBhZGQgcHNldWRvLURNQSBhcyB1c2Vk
IGJ5IE1hY2ludG9zaCkKNC8xMSBDaGVja2luZyBjb21taXQgNDc3MzkxYTMyOTlhIChkcDgzOTN4
OiBtYW5hZ2UgYmlnIGVuZGlhbiBidXMpCjUvMTEgQ2hlY2tpbmcgY29tbWl0IGQyM2NiOThjYTE3
NSAoaHcvbTY4azogYWRkIFZJQSBzdXBwb3J0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVs
ZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM4NDogCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0ICcmJicg
KGN0eDpXeFcpCiM0NTY6IEZJTEU6IGh3L21pc2MvbWFjX3ZpYS5jOjM2ODoKKyAgICAgICAgaWYg
KCEodjFzLT5sYXN0X2IgJiBWSUExQl92UlRDQ2xrKSAmJiAocy0+YiAmIFZJQTFCX3ZSVENDbGsp
KSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6
IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA5MTIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS8xMSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi8xMSBDaGVja2luZyBjb21taXQgNzc3Yjg1YTQ0MDNk
IChody9tNjhrOiBpbXBsZW1lbnQgQURCIGJ1cyBzdXBwb3J0IGZvciB2aWEpCjcvMTEgQ2hlY2tp
bmcgY29tbWl0IDllNTQxM2ZlNjUyYyAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQpCldBUk5J
Tkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVl
ZCB1cGRhdGluZz8KIzY1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywg
MSB3YXJuaW5ncywgNTMxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDcvMTEgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KOC8xMSBDaGVja2luZyBjb21taXQgMzNlMTI3ZWE4YzkwIChody9tNjhrOiBh
ZGQgTnVidXMgbWFjZmIgdmlkZW8gY2FyZCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0
ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNzY6IApuZXcgZmls
ZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1OTcgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggOC8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo5LzExIENoZWNraW5n
IGNvbW1pdCA4ZDkyNDExMjBmOGYgKGh3L202OGs6IGFkZCBhIGR1bW15IFNXSU0gZmxvcHB5IGNv
bnRyb2xsZXIpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMg
TUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzYzOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRv
dGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTkzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDkvMTEg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMTAvMTEgQ2hlY2tpbmcgY29tbWl0IDY1NzhkMDVi
MmRlYiAoaHcvbTY4azogZGVmaW5lIE1hY2ludG9zaCBRdWFkcmEgODAwKQpXQVJOSU5HOiBhZGRl
ZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRp
bmc/CiM3MjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDUzNyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxMC8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoxMS8xMSBDaGVja2luZyBjb21taXQgMGFhZmUzMzI4ZjBiIChCb290TGludXhDb25zb2xl
VGVzdDogVGVzdCB0aGUgUXVhZHJhIDgwMCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMjgxODE2NDMuNTE0My0xLWxhdXJlbnRAdml2aWVy
LmV1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


