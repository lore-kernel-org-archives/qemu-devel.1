Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5A6C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EC4218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EC4218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7O6C-00009z-Cl
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7O5F-0007W2-PR
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7O5E-0004ZV-5h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:08:13 -0400
Resent-Date: Mon, 09 Sep 2019 14:08:13 -0400
Resent-Message-Id: <E1i7O5E-0004ZV-5h@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7O5D-0004WS-UQ; Mon, 09 Sep 2019 14:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568052466; cv=none; d=zoho.com; s=zohoarc; 
 b=kRcd0jQ8fipSlJVQcG9Jdvlu3CRitUlDfI9qy3suPnf05oh0hotm6Nnn8jv7+saZt+EdUjr2+MXrCJO27ZxQ4z8EX+XLj8TQv5ta8/IPjL30HO0RczIiGViWgVlllqeMKLMqrBVWwRNqfKPZmdwoUd+f2xHmueJa4HKwGkhHwc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568052466;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=vXY8+KUq8uGcyOc2mS6lQ6BqnoUQOch9pZmaz7MP7GM=; 
 b=ZZKB0iReDcyULXMjHcch6pTz+uOPf2i3GpTEyGP0ssLdRhFpTjTOKumODGecju8NeVBhXw9/QKDrBLzIbhslqchKvLnA2+yXr2gxBG6hgO47ROkMnUspREVNCGn2IIEMZjQuKqXrnR49sPcPrHd9ofLYPoKyX9LihAHaReLDTUA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156805245319241.32056072393982;
 Mon, 9 Sep 2019 11:07:33 -0700 (PDT)
In-Reply-To: <20190909155813.27760-1-laurent@vivier.eu>
Message-ID: <156805245126.9541.16140027456204686327@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Mon, 9 Sep 2019 11:07:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v9 0/9] hw/m68k: add Apple Machintosh
 Quadra 800 machine
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkwOTE1NTgxMy4yNzc2
MC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY5IDAvOV0gaHcvbTY4azog
YWRkIEFwcGxlIE1hY2hpbnRvc2ggUXVhZHJhIDgwMCBtYWNoaW5lCk1lc3NhZ2UtaWQ6IDIwMTkw
OTA5MTU1ODEzLjI3NzYwLTEtbGF1cmVudEB2aXZpZXIuZXUKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDE5MDkwOTE1
NTgxMy4yNzc2MC0xLWxhdXJlbnRAdml2aWVyLmV1IC0+IHBhdGNoZXcvMjAxOTA5MDkxNTU4MTMu
Mjc3NjAtMS1sYXVyZW50QHZpdmllci5ldQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CmEyMGEzNDEgaHcvbTY4azogZGVmaW5lIE1hY2ludG9zaCBRdWFkcmEgODAwCjg2ODVkMWQgaHcv
bTY4azogYWRkIGEgZHVtbXkgU1dJTSBmbG9wcHkgY29udHJvbGxlcgo0OWZkMTQ4IGh3L202OGs6
IGFkZCBOdWJ1cyBzdXBwb3J0IGZvciBtYWNmYiB2aWRlbyBjYXJkCjBiODAwNTAgaHcvbTY4azog
YWRkIE51YnVzIHN1cHBvcnQKN2E2NWM3ZCBody9tNjhrOiBhZGQgbWFjZmIgdmlkZW8gY2FyZAow
YmM1NTRkIGh3L202OGs6IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZpYQo3Yjc5ZTE3
IGh3L202OGs6IGFkZCB2aWEgc3VwcG9ydAowODVkNDVlIGRwODM5M3g6IG1hbmFnZSBiaWcgZW5k
aWFuIGJ1cwozZjliNjNlIGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgM2Y5YjYzZTE2ODIxIChl
c3A6IGFkZCBwc2V1ZG8tRE1BIGFzIHVzZWQgYnkgTWFjaW50b3NoKQoyLzkgQ2hlY2tpbmcgY29t
bWl0IDA4NWQ0NWVhMzc3OCAoZHA4MzkzeDogbWFuYWdlIGJpZyBlbmRpYW4gYnVzKQozLzkgQ2hl
Y2tpbmcgY29tbWl0IDdiNzllMTc5ZTUwYSAoaHcvbTY4azogYWRkIHZpYSBzdXBwb3J0KQpXQVJO
SU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5l
ZWQgdXBkYXRpbmc/CiMzOTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogc3BhY2UgcHJv
aGliaXRlZCBhZnRlciB0aGF0ICcmJicgKGN0eDpXeFcpCiMzODc6IEZJTEU6IGh3L21pc2MvbWFj
X3ZpYS5jOjM0NDoKKyAgICAgICAgaWYgKCEodjFzLT5sYXN0X2IgJiBWSUExQl92UlRDQ2xrKSAm
JiAocy0+YiAmIFZJQTFCX3ZSVENDbGspKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA4MTQgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMy85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzkgQ2hlY2tp
bmcgY29tbWl0IDBiYzU1NGQzNTdmMCAoaHcvbTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9y
dCBmb3IgdmlhKQo1LzkgQ2hlY2tpbmcgY29tbWl0IDdhNjVjN2RkMzM5OSAoaHcvbTY4azogYWRk
IG1hY2ZiIHZpZGVvIGNhcmQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUo
cyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzUzOiAKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTA0IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDUvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo2LzkgQ2hlY2tpbmcgY29tbWl0IDBi
ODAwNTA5MDc1OSAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQpCldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
IzM4OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywg
NTE4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3
LzkgQ2hlY2tpbmcgY29tbWl0IDQ5ZmQxNDhmOGZiMyAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBv
cnQgZm9yIG1hY2ZiIHZpZGVvIGNhcmQpCjgvOSBDaGVja2luZyBjb21taXQgODY4NWQxZGQ4ODQz
IChody9tNjhrOiBhZGQgYSBkdW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyKQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiMzNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDUxMCBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KOS85IENoZWNraW5nIGNvbW1pdCBhMjBhMzQxMTU3YjcgKGh3L202OGs6IGRlZmluZSBN
YWNpbnRvc2ggUXVhZHJhIDgwMCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmls
ZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojOTY6IApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MzkgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggOS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTA5MTU1ODEzLjI3NzYwLTEtbGF1
cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


