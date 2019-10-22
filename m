Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7431FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F5721783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F5721783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzS3-0007cy-FB
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMzQa-00074Y-2h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMzQX-0000IB-R1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:02:43 -0400
Resent-Date: Tue, 22 Oct 2019 15:02:43 -0400
Resent-Message-Id: <E1iMzQX-0000IB-R1@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMzQX-0000Hl-ET; Tue, 22 Oct 2019 15:02:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571770932; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HlVe8mti7whsOfzYxKWZAwz0SQs2vA0CnbepQmJWS7ApTBheS9Qm9AxdabrJP0wsm40Wb9reJWa/DnwqPu8HPFDC80N7X0nsWR9BP03iV06RMfTDxhSIjngWv7r4AbnIMjXXdNzChk7wgBpVCPSp0gtoQAy6+Ob4If2b61/R5Y8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571770932;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6aFQURCgMk4UGFShsJp9H33SSNHFid2bawIVpZQs22w=; 
 b=L7RcdcF+5nTC/ZKaWbEtfwJRPnCjuMJugmQTMSBZ8+YkNEdHEGznbdXT/WvUSQDT/AntP/6/xkuCaxHQYETrocRDCZi4RqDPa4/o/3GRRLXBkK5gDKVWxx0hZJG8dYBxdDl8Spo+yYMMO35XrRSafhIymtxn0IiEhTrdLwAD190=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571770930359371.31486011532695;
 Tue, 22 Oct 2019 12:02:10 -0700 (PDT)
In-Reply-To: <20191022111738.20803-1-laurent@vivier.eu>
Subject: Re: [PATCH v14 0/9] hw/m68k: add Apple Machintosh Quadra 800 machine
Message-ID: <157177092820.12860.9657269944687850302@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 22 Oct 2019 12:02:10 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMjExMTczOC4yMDgw
My0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjE0IDAvOV0gaHcvbTY4azogYWRkIEFwcGxlIE1h
Y2hpbnRvc2ggUXVhZHJhIDgwMCBtYWNoaW5lClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5
MTAyMjExMTczOC4yMDgwMy0xLWxhdXJlbnRAdml2aWVyLmV1Cgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk1MjNiNGUgQm9vdExp
bnV4Q29uc29sZVRlc3Q6IFRlc3QgdGhlIFF1YWRyYSA4MDAKNmMxMjU5ZCBody9tNjhrOiBkZWZp
bmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKYWQ2ZjA3YSBody9tNjhrOiBhZGQgYSBkdW1teSBTV0lN
IGZsb3BweSBjb250cm9sbGVyCjA1M2VlOWMgaHcvbTY4azogYWRkIE51YnVzIG1hY2ZiIHZpZGVv
IGNhcmQKMzdmMmUwMyBody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydAo0MDkyOGRlIGh3L202OGs6
IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZpYQo2M2ZiNjhkIGh3L202OGs6IGFkZCBW
SUEgc3VwcG9ydAo3Mjg1NWY5IGRwODM5M3g6IG1hbmFnZSBiaWcgZW5kaWFuIGJ1cwpjM2E2NzNh
IGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgYzNhNjczYTI3YzcyIChlc3A6IGFkZCBwc2V1ZG8t
RE1BIGFzIHVzZWQgYnkgTWFjaW50b3NoKQoyLzkgQ2hlY2tpbmcgY29tbWl0IDcyODU1ZjliNzRj
NCAoZHA4MzkzeDogbWFuYWdlIGJpZyBlbmRpYW4gYnVzKQozLzkgQ2hlY2tpbmcgY29tbWl0IDYz
ZmI2OGRjYzNlMiAoaHcvbTY4azogYWRkIFZJQSBzdXBwb3J0KQpXQVJOSU5HOiBhZGRlZCwgbW92
ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM4
MzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0
aGF0ICcmJicgKGN0eDpXeFcpCiM0NTU6IEZJTEU6IGh3L21pc2MvbWFjX3ZpYS5jOjM2ODoKKyAg
ICAgICAgaWYgKCEodjFzLT5sYXN0X2IgJiBWSUExQl92UlRDQ2xrKSAmJiAocy0+YiAmIFZJQTFC
X3ZSVENDbGspKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA5MTIgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
My85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzkgQ2hlY2tpbmcgY29tbWl0IDQwOTI4
ZGViZTRlYiAoaHcvbTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9ydCBmb3IgdmlhKQo1Lzkg
Q2hlY2tpbmcgY29tbWl0IDM3ZjJlMDMzZTNlNiAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzY0OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVy
cm9ycywgMSB3YXJuaW5ncywgNTMxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvOSBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgo2LzkgQ2hlY2tpbmcgY29tbWl0IDA1M2VlOWM2NTcwNSAoaHcvbTY4
azogYWRkIE51YnVzIG1hY2ZiIHZpZGVvIGNhcmQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzc1OiAKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTk3IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDYvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3LzkgQ2hlY2tp
bmcgY29tbWl0IGFkNmYwN2FiNjE2YiAoaHcvbTY4azogYWRkIGEgZHVtbXkgU1dJTSBmbG9wcHkg
Y29udHJvbGxlcikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjI6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
dG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1OTMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNy85
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjgvOSBDaGVja2luZyBjb21taXQgNmMxMjU5ZDUy
ZjY1IChody9tNjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDApCldBUk5JTkc6IGFkZGVk
LCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGlu
Zz8KIzcxOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5n
cywgNTMwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
Lgo5LzkgQ2hlY2tpbmcgY29tbWl0IDk1MjNiNGViODkyNyAoQm9vdExpbnV4Q29uc29sZVRlc3Q6
IFRlc3QgdGhlIFF1YWRyYSA4MDApCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDIyMTExNzM4LjIwODAzLTEtbGF1cmVudEB2aXZpZXIuZXUv
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


