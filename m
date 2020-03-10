Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008E7C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C489C24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C489C24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBT9z-0005nu-Vp
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jBT9D-0005Og-SW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jBT9C-0003Xz-AJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:53:27 -0400
Resent-Date: Mon, 09 Mar 2020 20:53:27 -0400
Resent-Message-Id: <E1jBT9C-0003Xz-AJ@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jBT9C-0003X0-2P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583801595; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GkDZu/ZitiM5WsS+BVyk4RBdp6Vgz0PvjPKYVJEbts58iVfCzQ0pWhZxOXBdRKhyznXXLFcoGMwm9Bx23REjXPj1OrIVEp3DFYVz74k0NgB40toAiC+AWGmeULqTM0DtnwMwJOwSvUAJyL6uLtCK/9+xHts6QIU+qQRFHT8d+F4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583801595;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=t687RcDiOlr8jgiX2VQehSp02oBXioIx4GwYlpWF1k4=; 
 b=ZiT2pJpzDY/jtsXbZxMxewn59KzT0GbBlyQca85HCwbqCiHEWLsJDCumfO5ulAt6r7VZs3rNlyJ3LPh74fAAkB4OfBEsr3BJmau8w9AcjvOuHr/Nt+/XyYSzlsWCL5l/JwHaYLnf31yYnOijRCZTTkfIkoLwRr3+hzOtrs3pV9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15838015929691002.7365739551253;
 Mon, 9 Mar 2020 17:53:12 -0700 (PDT)
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
Subject: Re: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <158380159181.20878.10054025532913314694@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Mon, 9 Mar 2020 17:53:12 -0700 (PDT)
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
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwOTIzNTQxMS43NjU4
Ny0xLWxpcmFuLmFsb25Ab3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAwLzE0XTogaHcvaTM4Ni92bXBvcnQ6IEJ1
ZyBmaXhlcyBhbmQgaW1wcm92ZW1lbnRzCk1lc3NhZ2UtaWQ6IDIwMjAwMzA5MjM1NDExLjc2NTg3
LTEtbGlyYW4uYWxvbkBvcmFjbGUuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5YTVlZWEzIGh3L2kz
ODYvdm1wb3J0OiBBc3NlcnQgdm1wb3J0IGluaXRpYWxpemVkIGJlZm9yZSByZWdpc3RlcmluZyBj
b21tYW5kcwoxZTZkZDA0IGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVEha
CjBhYzBkMDMgaTM4Ni9jcHU6IFN0b3JlIExBUElDIGJ1cyBmcmVxdWVuY3kgaW4gQ1BVIHN0cnVj
dHVyZQphN2M2N2Y3IGh3L2kzODYvdm1wb3J0OiBBbGxvdyB4MmFwaWMgd2l0aG91dCBJUgo0NWE4
OTA2IGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVF9WQ1BVX0lORk8KYjJl
NTE4MiBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRUSU1FRlVMTAo3ODFj
NTc4IGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVFRJTUUKYjk3NjZlMSBo
dy9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRCSU9TVVVJRAo0NWQ4NGVhIGh3
L2kzODYvdm1wb3J0OiBEZWZpbmUgZW51bSBmb3IgYWxsIGNvbW1hbmRzCjRmZDBmMmEgaHcvaTM4
Ni92bXBvcnQ6IFJlcG9ydCBWTVggdHlwZSBpbiBDTURfR0VUVkVSU0lPTgpmYjlhMzdkIGh3L2kz
ODYvdm1wb3J0OiBJbnRyb2R1Y2Ugdm14LXZlcnNpb24gcHJvcGVydHkKNDJjOWIxYiBody9pMzg2
L3ZtcG9ydDogQWRkIGRldmljZSBwcm9wZXJ0aWVzCmVmODBmZTMgaHcvaTM4Ni92bXBvcnQ6IFNl
dCBFQVggdG8gLTEgb24gZmFpbGVkIGFuZCB1bnN1cHBvcnRlZCBjb21tYW5kcwo0ZjRjMzc2IGh3
L2kzODYvdm1wb3J0OiBQcm9wYWdhdGUgSU9Qb3J0IHJlYWQgdG8gdkNQVSBFQVggcmVnaXN0ZXIK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTQgQ2hlY2tpbmcgY29tbWl0IDRmNGMzNzY2ZGFiOCAo
aHcvaTM4Ni92bXBvcnQ6IFByb3BhZ2F0ZSBJT1BvcnQgcmVhZCB0byB2Q1BVIEVBWCByZWdpc3Rl
cikKMi8xNCBDaGVja2luZyBjb21taXQgZWY4MGZlMzg0ZjJhIChody9pMzg2L3ZtcG9ydDogU2V0
IEVBWCB0byAtMSBvbiBmYWlsZWQgYW5kIHVuc3VwcG9ydGVkIGNvbW1hbmRzKQozLzE0IENoZWNr
aW5nIGNvbW1pdCA0MmM5YjFiY2JhMjIgKGh3L2kzODYvdm1wb3J0OiBBZGQgZGV2aWNlIHByb3Bl
cnRpZXMpCjQvMTQgQ2hlY2tpbmcgY29tbWl0IGZiOWEzN2Q5NGFlOCAoaHcvaTM4Ni92bXBvcnQ6
IEludHJvZHVjZSB2bXgtdmVyc2lvbiBwcm9wZXJ0eSkKNS8xNCBDaGVja2luZyBjb21taXQgNGZk
MGYyYTRmYmQ4IChody9pMzg2L3ZtcG9ydDogUmVwb3J0IFZNWCB0eXBlIGluIENNRF9HRVRWRVJT
SU9OKQo2LzE0IENoZWNraW5nIGNvbW1pdCA0NWQ4NGVhYWQ5YjggKGh3L2kzODYvdm1wb3J0OiBE
ZWZpbmUgZW51bSBmb3IgYWxsIGNvbW1hbmRzKQo3LzE0IENoZWNraW5nIGNvbW1pdCBiOTc2NmUx
ZDdiODkgKGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVEJJT1NVVUlEKQpF
UlJPUjogIihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgojMzM6IEZJTEU6IGh3L2kzODYvdm1w
b3J0LmM6MTI4OgorICAgIHVpbnQzMl90ICp1dWlkX3BhcnRzID0gKHVpbnQzMl90KikocWVtdV91
dWlkLmRhdGEpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzOSBsaW5lcyBjaGVja2Vk
CgpQYXRjaCA3LzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo4LzE0IENoZWNraW5nIGNv
bW1pdCA3ODFjNTc4NjEwNmEgKGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dF
VFRJTUUpCjkvMTQgQ2hlY2tpbmcgY29tbWl0IGIyZTUxODI0MTI5ZSAoaHcvaTM4Ni92bXBvcnQ6
IEFkZCBzdXBwb3J0IGZvciBDTURfR0VUVElNRUZVTEwpCjEwLzE0IENoZWNraW5nIGNvbW1pdCA0
NWE4OTA2NzAwZjYgKGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVF9WQ1BV
X0lORk8pCkVSUk9SOiByZXR1cm4gaXMgbm90IGEgZnVuY3Rpb24sIHBhcmVudGhlc2VzIGFyZSBu
b3QgcmVxdWlyZWQKIzQxOiBGSUxFOiBody9pMzg2L3ZtcG9ydC5jOjE4NToKKyAgICByZXR1cm4g
KDEgPDwgVkNQVV9JTkZPX1JFU0VSVkVEX0JJVCk7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDM4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEwLzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgoxMS8xNCBDaGVja2luZyBjb21taXQgYTdjNjdmNzM2Y2QxIChody9pMzg2L3ZtcG9ydDog
QWxsb3cgeDJhcGljIHdpdGhvdXQgSVIpCjEyLzE0IENoZWNraW5nIGNvbW1pdCAwYWMwZDAzNjM4
NzMgKGkzODYvY3B1OiBTdG9yZSBMQVBJQyBidXMgZnJlcXVlbmN5IGluIENQVSBzdHJ1Y3R1cmUp
CjEzLzE0IENoZWNraW5nIGNvbW1pdCAxZTZkZDA0MmQyYTIgKGh3L2kzODYvdm1wb3J0OiBBZGQg
c3VwcG9ydCBmb3IgQ01EX0dFVEhaKQoxNC8xNCBDaGVja2luZyBjb21taXQgOWE1ZWVhMzg4NTc2
IChody9pMzg2L3ZtcG9ydDogQXNzZXJ0IHZtcG9ydCBpbml0aWFsaXplZCBiZWZvcmUgcmVnaXN0
ZXJpbmcgY29tbWFuZHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwMzA5MjM1NDExLjc2NTg3LTEtbGlyYW4uYWxvbkBvcmFjbGUuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

