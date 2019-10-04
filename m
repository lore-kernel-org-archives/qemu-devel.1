Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF36C10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081A120862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081A120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGBNP-0007s8-6V
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iGBDR-0002Xu-0Y
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 20:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iGBDO-0000Ee-31
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 20:13:00 -0400
Resent-Date: Thu, 03 Oct 2019 20:12:59 -0400
Resent-Message-Id: <E1iGBDO-0000Ee-31@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iGBDI-0000B8-I0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 20:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570147960; cv=none; d=zoho.com; s=zohoarc; 
 b=Bcl+k0F2QbZCfrTcJTZqSs/M89UtMNgls7wdbaTDhftvuEzwxS/fga3XlUXsiKYnkDbH1W+SjIkYPKxw1dN2wf45/xSFD9F2ehFyk8KTzdWWIsvajILO2+fJFlMNJdrkyApPmPXkkPVFnfz1rk6GaAsvWIRk9F+ePATShzijB50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570147960;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=+/HPZKOwlRrtuMf//KGufgpnd5hhs+9QgJS6Iki75yw=; 
 b=CWgbJ9zNY1eNCT/SMW9bPVJ3r0e3TlLWgTWFpAm86qrQQxavNMejd1Yio7f6010cBTE0nge4HrDuQvnlfO1rr5Kar9pCmtikKuvPFjYB/LS/KaTxVNU/5wQdJ/hk6hHoZd4ZxAtducvT1oaFfd2kSTXdPTAvK163aT8CAp0A9Pc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570147958800748.8395732569935;
 Thu, 3 Oct 2019 17:12:38 -0700 (PDT)
Subject: Re: [PATCH 0/7] fw_cfg: Run tests on big-endian
In-Reply-To: <20191003225437.16651-1-philmd@redhat.com>
Message-ID: <157014795715.27944.7985035778935178812@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Thu, 3 Oct 2019 17:12:38 -0700 (PDT)
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
Cc: lvivier@redhat.com, thuth@redhat.com, lersek@redhat.com, liq3ea@gmail.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMzIyNTQzNy4xNjY1
MS0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMDMyMjU0MzcuMTY2NTEt
MS1waGlsbWRAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggMC83XSBmd19jZmc6IFJ1biB0ZXN0
cyBvbiBiaWctZW5kaWFuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBw
YXRjaGV3LzIwMTkwOTE2MTQxNTQ0LjE3NTQwLTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+
IHBhdGNoZXcvMjAxOTA5MTYxNDE1NDQuMTc1NDAtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2MDY2YWQ0IHRlc3RzL2Z3X2NmZzogUnVu
IHRoZSB0ZXN0cyBvbiBiaWctZW5kaWFuIHRhcmdldHMKNDQyY2IwMCB0ZXN0cy9md19jZmc6IERl
Y2xhcmUgb25lIFFGV0NGRyBmb3IgYWxsIHRlc3RzCjVhMmQyNzQgdGVzdHMvbGlicW9zL2Z3X2Nm
ZzogUGFzcyBRVGVzdFN0YXRlIGFzIGFyZ3VtZW50CjNlYWZlNjIgdGVzdHMvZndfY2ZnOiBMZXQg
dGhlIHRlc3RzIHVzZSBhIGNvbnRleHQKOGMzYWE3ZiB0ZXN0cy9saWJxb3MvZndfY2ZnOiBEb2N1
bWVudCBwY19md19jZmdfaW5pdCB0byBkcm9wIHBjX2Z3X2NmZ191bmluaXQKNDRmMTllMyB0ZXN0
cy9saWJxb3MvZndfY2ZnOiBEb2N1bWVudCBtbV9md19jZmdfaW5pdCB0byBkcm9wIG1tX2Z3X2Nm
Z191bmluaXQKMmQ2YTBlMiB0ZXN0cy9saWJxb3MvZndfY2ZnOiBEb2N1bWVudCBpb19md19jZmdf
aW5pdCB0byBkcm9wIGlvX2Z3X2NmZ191bmluaXQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNyBD
aGVja2luZyBjb21taXQgMmQ2YTBlMmVmZTc2ICh0ZXN0cy9saWJxb3MvZndfY2ZnOiBEb2N1bWVu
dCBpb19md19jZmdfaW5pdCB0byBkcm9wIGlvX2Z3X2NmZ191bmluaXQpCjIvNyBDaGVja2luZyBj
b21taXQgNDRmMTllMzI4MDMwICh0ZXN0cy9saWJxb3MvZndfY2ZnOiBEb2N1bWVudCBtbV9md19j
ZmdfaW5pdCB0byBkcm9wIG1tX2Z3X2NmZ191bmluaXQpCjMvNyBDaGVja2luZyBjb21taXQgOGMz
YWE3ZjZiMTY2ICh0ZXN0cy9saWJxb3MvZndfY2ZnOiBEb2N1bWVudCBwY19md19jZmdfaW5pdCB0
byBkcm9wIHBjX2Z3X2NmZ191bmluaXQpCjQvNyBDaGVja2luZyBjb21taXQgM2VhZmU2Mjc0Yjcx
ICh0ZXN0cy9md19jZmc6IExldCB0aGUgdGVzdHMgdXNlIGEgY29udGV4dCkKRVJST1I6IGxpbmUg
b3ZlciA5MCBjaGFyYWN0ZXJzCiM3NDogRklMRTogdGVzdHMvZndfY2ZnLXRlc3QuYzo3NzoKKyAg
ICBzID0gcXRlc3RfaW5pdGYoIi1NICVzIC11dWlkIDQ2MDBjYjMyLTM4ZWMtNGIyZi04YWNiLTgx
YzZlYTU0ZjJkOCIsIGN0eC0+bWFjaGluZV9uYW1lKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMjI3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKNS83IENoZWNraW5nIGNvbW1pdCA1YTJkMjc0YWY2NzUgKHRlc3RzL2xpYnFvcy9md19j
Zmc6IFBhc3MgUVRlc3RTdGF0ZSBhcyBhcmd1bWVudCkKV0FSTklORzogbGluZSBvdmVyIDgwIGNo
YXJhY3RlcnMKIzM4NzogRklMRTogdGVzdHMvbGlicW9zL2Z3X2NmZy5oOjI5Ogordm9pZCBxZndf
Y2ZnX2dldChRVGVzdFN0YXRlICpxdHMsIFFGV0NGRyAqZndfY2ZnLCB1aW50MTZfdCBrZXksIHZv
aWQgKmRhdGEsIHNpemVfdCBsZW4pOwoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAzOTEg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggNS83IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvNyBD
aGVja2luZyBjb21taXQgNDQyY2IwMDhkZTk4ICh0ZXN0cy9md19jZmc6IERlY2xhcmUgb25lIFFG
V0NGRyBmb3IgYWxsIHRlc3RzKQo3LzcgQ2hlY2tpbmcgY29tbWl0IDYwNjZhZDRiMTgzNCAodGVz
dHMvZndfY2ZnOiBSdW4gdGhlIHRlc3RzIG9uIGJpZy1lbmRpYW4gdGFyZ2V0cykKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMDMyMjU0Mzcu
MTY2NTEtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


