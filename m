Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A46C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 01:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D0F24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 01:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D0F24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBTQN-0001Uu-27
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 21:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jBTPl-00011F-2W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jBTPj-0004qm-Ew
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:10:32 -0400
Resent-Date: Mon, 09 Mar 2020 21:10:32 -0400
Resent-Message-Id: <E1jBTPj-0004qm-Ew@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jBTPj-0004nQ-76
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:10:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583802619; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nV7/Kq74lZutS6KA/NWUIneOMWxp++RI2dLqygq/7ciAz3pkGb1b5/E+jtriVRk7kdeDqqOnC+GhcuqbzABzsOm8jbPKVFCbbV43ZnlmE/jiKTEaNkI6DKacVQZP+jcDIZK1VAEkis8KkQEjBoYcVJz5ts9nM8PJuFiR/QIh5uY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583802619;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=a/+oaMfF/CyMSXFNTjH9mvuTOPPjc4uuGM1ikY5I2gM=; 
 b=gJo20f/wTz+HxlW8HuaSoYsGTKXr89EBKDNwbxqXApPHyfXsf78PFz8xostwnNlPYsIuacT0BKh1lDU5bk9W2K/AahObzygDHImtxZJfF2aSI/FuWys6dzuM7kSgNRDFoCK1d2F+ouWtfDX81wuLhJ4baPuFGe0AjD2e5knyXps=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583802616683224.1670055469158;
 Mon, 9 Mar 2020 18:10:16 -0700 (PDT)
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
Subject: Re: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <158380261540.20878.16942121833169088104@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Mon, 9 Mar 2020 18:10:16 -0700 (PDT)
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
U1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYTkwNTAx
MiBody9pMzg2L3ZtcG9ydDogQXNzZXJ0IHZtcG9ydCBpbml0aWFsaXplZCBiZWZvcmUgcmVnaXN0
ZXJpbmcgY29tbWFuZHMKYWFkNDM1OSBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENN
RF9HRVRIWgozZWRiOWRhIGkzODYvY3B1OiBTdG9yZSBMQVBJQyBidXMgZnJlcXVlbmN5IGluIENQ
VSBzdHJ1Y3R1cmUKYjcyYTNlMCBody9pMzg2L3ZtcG9ydDogQWxsb3cgeDJhcGljIHdpdGhvdXQg
SVIKNzUwNDY3NiBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRfVkNQVV9J
TkZPCjc5ZDBhM2YgaHcvaTM4Ni92bXBvcnQ6IEFkZCBzdXBwb3J0IGZvciBDTURfR0VUVElNRUZV
TEwKMGQ2ZTZiMSBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRUSU1FCjgw
NWI1MTQgaHcvaTM4Ni92bXBvcnQ6IEFkZCBzdXBwb3J0IGZvciBDTURfR0VUQklPU1VVSUQKODI3
MTg3MSBody9pMzg2L3ZtcG9ydDogRGVmaW5lIGVudW0gZm9yIGFsbCBjb21tYW5kcwo5MjY2NTA1
IGh3L2kzODYvdm1wb3J0OiBSZXBvcnQgVk1YIHR5cGUgaW4gQ01EX0dFVFZFUlNJT04KN2UyNTBj
ZCBody9pMzg2L3ZtcG9ydDogSW50cm9kdWNlIHZteC12ZXJzaW9uIHByb3BlcnR5CmI1N2FmODIg
aHcvaTM4Ni92bXBvcnQ6IEFkZCBkZXZpY2UgcHJvcGVydGllcwpkYjEyZmE5IGh3L2kzODYvdm1w
b3J0OiBTZXQgRUFYIHRvIC0xIG9uIGZhaWxlZCBhbmQgdW5zdXBwb3J0ZWQgY29tbWFuZHMKOGVh
YjhkZSBody9pMzg2L3ZtcG9ydDogUHJvcGFnYXRlIElPUG9ydCByZWFkIHRvIHZDUFUgRUFYIHJl
Z2lzdGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzE0IENoZWNraW5nIGNvbW1pdCA4ZWFiOGRl
ZDA5NWIgKGh3L2kzODYvdm1wb3J0OiBQcm9wYWdhdGUgSU9Qb3J0IHJlYWQgdG8gdkNQVSBFQVgg
cmVnaXN0ZXIpCjIvMTQgQ2hlY2tpbmcgY29tbWl0IGRiMTJmYTk1YmEzYiAoaHcvaTM4Ni92bXBv
cnQ6IFNldCBFQVggdG8gLTEgb24gZmFpbGVkIGFuZCB1bnN1cHBvcnRlZCBjb21tYW5kcykKMy8x
NCBDaGVja2luZyBjb21taXQgYjU3YWY4MjAyNmZjIChody9pMzg2L3ZtcG9ydDogQWRkIGRldmlj
ZSBwcm9wZXJ0aWVzKQo0LzE0IENoZWNraW5nIGNvbW1pdCA3ZTI1MGNkYWI0NjggKGh3L2kzODYv
dm1wb3J0OiBJbnRyb2R1Y2Ugdm14LXZlcnNpb24gcHJvcGVydHkpCjUvMTQgQ2hlY2tpbmcgY29t
bWl0IDkyNjY1MDU4MjJlOCAoaHcvaTM4Ni92bXBvcnQ6IFJlcG9ydCBWTVggdHlwZSBpbiBDTURf
R0VUVkVSU0lPTikKNi8xNCBDaGVja2luZyBjb21taXQgODI3MTg3MTA2MTNkIChody9pMzg2L3Zt
cG9ydDogRGVmaW5lIGVudW0gZm9yIGFsbCBjb21tYW5kcykKNy8xNCBDaGVja2luZyBjb21taXQg
ODA1YjUxNDZkMmVhIChody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRCSU9T
VVVJRCkKRVJST1I6ICIoZm9vKikiIHNob3VsZCBiZSAiKGZvbyAqKSIKIzMzOiBGSUxFOiBody9p
Mzg2L3ZtcG9ydC5jOjEyODoKKyAgICB1aW50MzJfdCAqdXVpZF9wYXJ0cyA9ICh1aW50MzJfdCop
KHFlbXVfdXVpZC5kYXRhKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzkgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNy8xNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOC8xNCBDaGVj
a2luZyBjb21taXQgMGQ2ZTZiMWI2MjMwIChody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9y
IENNRF9HRVRUSU1FKQo5LzE0IENoZWNraW5nIGNvbW1pdCA3OWQwYTNmODlkOWMgKGh3L2kzODYv
dm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVFRJTUVGVUxMKQoxMC8xNCBDaGVja2luZyBj
b21taXQgNzUwNDY3NjdhNjQ3IChody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9H
RVRfVkNQVV9JTkZPKQpFUlJPUjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNl
cyBhcmUgbm90IHJlcXVpcmVkCiM0MTogRklMRTogaHcvaTM4Ni92bXBvcnQuYzoxODU6CisgICAg
cmV0dXJuICgxIDw8IFZDUFVfSU5GT19SRVNFUlZFRF9CSVQpOwoKdG90YWw6IDEgZXJyb3JzLCAw
IHdhcm5pbmdzLCAzOCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxMC8xNCBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMTEvMTQgQ2hlY2tpbmcgY29tbWl0IGI3MmEzZTAzZDI2ZCAoaHcvaTM4Ni92
bXBvcnQ6IEFsbG93IHgyYXBpYyB3aXRob3V0IElSKQoxMi8xNCBDaGVja2luZyBjb21taXQgM2Vk
YjlkYTcxMjUxIChpMzg2L2NwdTogU3RvcmUgTEFQSUMgYnVzIGZyZXF1ZW5jeSBpbiBDUFUgc3Ry
dWN0dXJlKQoxMy8xNCBDaGVja2luZyBjb21taXQgYWFkNDM1OTMwYmVjIChody9pMzg2L3ZtcG9y
dDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRIWikKMTQvMTQgQ2hlY2tpbmcgY29tbWl0IGE5MDUw
MTI5YjMzMyAoaHcvaTM4Ni92bXBvcnQ6IEFzc2VydCB2bXBvcnQgaW5pdGlhbGl6ZWQgYmVmb3Jl
IHJlZ2lzdGVyaW5nIGNvbW1hbmRzKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMwOTIzNTQxMS43NjU4Ny0xLWxpcmFuLmFsb25Ab3JhY2xl
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

