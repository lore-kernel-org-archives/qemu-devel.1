Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E9C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFE12467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 02:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFE12467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBV5g-0007KN-6l
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 22:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jBV4w-0006ao-NI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jBV4v-0006aJ-Bq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:57:10 -0400
Resent-Date: Mon, 09 Mar 2020 22:57:10 -0400
Resent-Message-Id: <E1jBV4v-0006aJ-Bq@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jBV4v-0006YS-3o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 22:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583808997; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xu/3XIg75N/oMD1YFdOD74Wgt+EW4fIF6OZTLdIqjFpKe4abPZpcR0Gukl8TD54prLEXOQK7IpYyAuswW8XfAutfJ5SkRw8VQJgVi+CEW9fzSv0Mn+4Y+x2Oag4WJw5XoyK1fUocjlYueG7W74FF/UCyLdy7K8MEH54PeunzsEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583808997;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NQ7Q7Oxe7127i/yj/UK+gGLtni8vekkvHJVF2a2Jd1w=; 
 b=TG0XQsNh3vnZVkLzH0Nj85BwR94pAixscPyNf52psjF57lvlEd4bdlTM2zdye5acau3Vt3nDh88PzKVCfMVMza+Jke0RHFd2Lj7CHZu4yQgsbQdz5CUyNXcTb+Gogerh6c74DQdpalUDOUOphb0uoCKnRMCVSyq7Bc4yp5TEv4c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583808995463927.0917425846558;
 Mon, 9 Mar 2020 19:56:35 -0700 (PDT)
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
Subject: Re: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <158380899428.20878.7825802984725531875@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Mon, 9 Mar 2020 19:56:35 -0700 (PDT)
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
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
IC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDMwOTIzNTQxMS43NjU4Ny0xLWxpcmFu
LmFsb25Ab3JhY2xlLmNvbSAtPiBwYXRjaGV3LzIwMjAwMzA5MjM1NDExLjc2NTg3LTEtbGlyYW4u
YWxvbkBvcmFjbGUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKM2E5YTkwNSBo
dy9pMzg2L3ZtcG9ydDogQXNzZXJ0IHZtcG9ydCBpbml0aWFsaXplZCBiZWZvcmUgcmVnaXN0ZXJp
bmcgY29tbWFuZHMKYTFlNDVlNiBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9H
RVRIWgoxMGUwY2NmIGkzODYvY3B1OiBTdG9yZSBMQVBJQyBidXMgZnJlcXVlbmN5IGluIENQVSBz
dHJ1Y3R1cmUKYjRiNThhMyBody9pMzg2L3ZtcG9ydDogQWxsb3cgeDJhcGljIHdpdGhvdXQgSVIK
MDRkMzJiYiBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRfVkNQVV9JTkZP
Cjc5MjVkN2UgaHcvaTM4Ni92bXBvcnQ6IEFkZCBzdXBwb3J0IGZvciBDTURfR0VUVElNRUZVTEwK
YjkxOWM4NyBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRUSU1FCjg3ZmU4
ZTIgaHcvaTM4Ni92bXBvcnQ6IEFkZCBzdXBwb3J0IGZvciBDTURfR0VUQklPU1VVSUQKOGNhZDk2
ZSBody9pMzg2L3ZtcG9ydDogRGVmaW5lIGVudW0gZm9yIGFsbCBjb21tYW5kcwplMTY3NDUzIGh3
L2kzODYvdm1wb3J0OiBSZXBvcnQgVk1YIHR5cGUgaW4gQ01EX0dFVFZFUlNJT04KZTcwYjJkMSBo
dy9pMzg2L3ZtcG9ydDogSW50cm9kdWNlIHZteC12ZXJzaW9uIHByb3BlcnR5CjRjMzdmOGIgaHcv
aTM4Ni92bXBvcnQ6IEFkZCBkZXZpY2UgcHJvcGVydGllcwo2YWViMjAxIGh3L2kzODYvdm1wb3J0
OiBTZXQgRUFYIHRvIC0xIG9uIGZhaWxlZCBhbmQgdW5zdXBwb3J0ZWQgY29tbWFuZHMKNzg4NjRl
OCBody9pMzg2L3ZtcG9ydDogUHJvcGFnYXRlIElPUG9ydCByZWFkIHRvIHZDUFUgRUFYIHJlZ2lz
dGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzE0IENoZWNraW5nIGNvbW1pdCA3ODg2NGU4Mjhk
OWEgKGh3L2kzODYvdm1wb3J0OiBQcm9wYWdhdGUgSU9Qb3J0IHJlYWQgdG8gdkNQVSBFQVggcmVn
aXN0ZXIpCjIvMTQgQ2hlY2tpbmcgY29tbWl0IDZhZWIyMDE0ZDk4MiAoaHcvaTM4Ni92bXBvcnQ6
IFNldCBFQVggdG8gLTEgb24gZmFpbGVkIGFuZCB1bnN1cHBvcnRlZCBjb21tYW5kcykKMy8xNCBD
aGVja2luZyBjb21taXQgNGMzN2Y4YjdmY2M1IChody9pMzg2L3ZtcG9ydDogQWRkIGRldmljZSBw
cm9wZXJ0aWVzKQo0LzE0IENoZWNraW5nIGNvbW1pdCBlNzBiMmQxODY0YjcgKGh3L2kzODYvdm1w
b3J0OiBJbnRyb2R1Y2Ugdm14LXZlcnNpb24gcHJvcGVydHkpCjUvMTQgQ2hlY2tpbmcgY29tbWl0
IGUxNjc0NTM5ZGY0OSAoaHcvaTM4Ni92bXBvcnQ6IFJlcG9ydCBWTVggdHlwZSBpbiBDTURfR0VU
VkVSU0lPTikKNi8xNCBDaGVja2luZyBjb21taXQgOGNhZDk2ZTZjNjA2IChody9pMzg2L3ZtcG9y
dDogRGVmaW5lIGVudW0gZm9yIGFsbCBjb21tYW5kcykKNy8xNCBDaGVja2luZyBjb21taXQgODdm
ZThlMjFiNTk1IChody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRCSU9TVVVJ
RCkKRVJST1I6ICIoZm9vKikiIHNob3VsZCBiZSAiKGZvbyAqKSIKIzMzOiBGSUxFOiBody9pMzg2
L3ZtcG9ydC5jOjEyODoKKyAgICB1aW50MzJfdCAqdXVpZF9wYXJ0cyA9ICh1aW50MzJfdCopKHFl
bXVfdXVpZC5kYXRhKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzkgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggNy8xNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOC8xNCBDaGVja2lu
ZyBjb21taXQgYjkxOWM4N2IyZDcxIChody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENN
RF9HRVRUSU1FKQo5LzE0IENoZWNraW5nIGNvbW1pdCA3OTI1ZDdlNThiYzcgKGh3L2kzODYvdm1w
b3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVFRJTUVGVUxMKQoxMC8xNCBDaGVja2luZyBjb21t
aXQgMDRkMzJiYjc3MmI5IChody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRf
VkNQVV9JTkZPKQpFUlJPUjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBh
cmUgbm90IHJlcXVpcmVkCiM0MTogRklMRTogaHcvaTM4Ni92bXBvcnQuYzoxODU6CisgICAgcmV0
dXJuICgxIDw8IFZDUFVfSU5GT19SRVNFUlZFRF9CSVQpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAzOCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxMC8xNCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKMTEvMTQgQ2hlY2tpbmcgY29tbWl0IGI0YjU4YTM3NTRhMyAoaHcvaTM4Ni92bXBv
cnQ6IEFsbG93IHgyYXBpYyB3aXRob3V0IElSKQoxMi8xNCBDaGVja2luZyBjb21taXQgMTBlMGNj
ZjliNTNhIChpMzg2L2NwdTogU3RvcmUgTEFQSUMgYnVzIGZyZXF1ZW5jeSBpbiBDUFUgc3RydWN0
dXJlKQoxMy8xNCBDaGVja2luZyBjb21taXQgYTFlNDVlNjZlMThmIChody9pMzg2L3ZtcG9ydDog
QWRkIHN1cHBvcnQgZm9yIENNRF9HRVRIWikKMTQvMTQgQ2hlY2tpbmcgY29tbWl0IDNhOWE5MDU2
ZDFiMyAoaHcvaTM4Ni92bXBvcnQ6IEFzc2VydCB2bXBvcnQgaW5pdGlhbGl6ZWQgYmVmb3JlIHJl
Z2lzdGVyaW5nIGNvbW1hbmRzKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDIwMDMwOTIzNTQxMS43NjU4Ny0xLWxpcmFuLmFsb25Ab3JhY2xlLmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

