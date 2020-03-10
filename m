Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88476C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 01:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588DC20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 01:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588DC20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBU28-0005LZ-Gs
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 21:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jBU1S-0004wJ-N9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jBU1Q-00028r-Rw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:49:30 -0400
Resent-Date: Mon, 09 Mar 2020 21:49:30 -0400
Resent-Message-Id: <E1jBU1Q-00028r-Rw@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jBU1Q-00027D-K3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 21:49:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583804946; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mI6RV/45bGCeXM1X5FtzTpjmoCtKgRIZElF8+nencFTVp5oGOCZeRMvYH20uwtb6VLJ44I5yiEZKicV+7gvkztPOAg+wsI5K45/hWbefBwM8Ab/JPNgzei8PGw7XirwmAOOv3I0xUT5FmY8lIaF4jfe47HGNVKTQg8Cu8YKRVj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583804946;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yJe9vTuQtSJZRfvJvLhoNuzXF0i4mcudD594qBnANUc=; 
 b=bFNSr9tae82OjBGqESB89JNuubl47ToAV+sBR+UBeARl+xYlu9zqEeW9UjYG7QDdvKp8zBcKnjf8r1lyHlMhiQNU5y6IyhZM4pJm8jrHFsw8kVUVzt9dVu7zwfPDoVvmvMXv3qvJIR9KEUwxzmVNSrnDLWZ9kR1EKVcKTleLkSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583804943490111.65363200862669;
 Mon, 9 Mar 2020 18:49:03 -0700 (PDT)
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
Subject: Re: [PATCH 00/14]: hw/i386/vmport: Bug fixes and improvements
Message-ID: <158380494227.20878.10457483366399815170@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Mon, 9 Mar 2020 18:49:03 -0700 (PDT)
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
YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkZjM5OTYyIGh3L2kz
ODYvdm1wb3J0OiBBc3NlcnQgdm1wb3J0IGluaXRpYWxpemVkIGJlZm9yZSByZWdpc3RlcmluZyBj
b21tYW5kcwozZTI2YzkzIGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVEha
CjExMDRiYTIgaTM4Ni9jcHU6IFN0b3JlIExBUElDIGJ1cyBmcmVxdWVuY3kgaW4gQ1BVIHN0cnVj
dHVyZQphMDcyNjllIGh3L2kzODYvdm1wb3J0OiBBbGxvdyB4MmFwaWMgd2l0aG91dCBJUgo5Y2Iy
MzNjIGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVF9WQ1BVX0lORk8KYjI3
NTNjZSBody9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRUSU1FRlVMTAo4ZjFi
MmRkIGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVFRJTUUKZThiZGEyNCBo
dy9pMzg2L3ZtcG9ydDogQWRkIHN1cHBvcnQgZm9yIENNRF9HRVRCSU9TVVVJRAozMTY0NzU2IGh3
L2kzODYvdm1wb3J0OiBEZWZpbmUgZW51bSBmb3IgYWxsIGNvbW1hbmRzCjE5MzZkNGQgaHcvaTM4
Ni92bXBvcnQ6IFJlcG9ydCBWTVggdHlwZSBpbiBDTURfR0VUVkVSU0lPTgphZTEwODVmIGh3L2kz
ODYvdm1wb3J0OiBJbnRyb2R1Y2Ugdm14LXZlcnNpb24gcHJvcGVydHkKYTAzNWQ3YSBody9pMzg2
L3ZtcG9ydDogQWRkIGRldmljZSBwcm9wZXJ0aWVzCjIyZTlmYTUgaHcvaTM4Ni92bXBvcnQ6IFNl
dCBFQVggdG8gLTEgb24gZmFpbGVkIGFuZCB1bnN1cHBvcnRlZCBjb21tYW5kcwpiNmUwZWQyIGh3
L2kzODYvdm1wb3J0OiBQcm9wYWdhdGUgSU9Qb3J0IHJlYWQgdG8gdkNQVSBFQVggcmVnaXN0ZXIK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTQgQ2hlY2tpbmcgY29tbWl0IGI2ZTBlZDJhZjljNyAo
aHcvaTM4Ni92bXBvcnQ6IFByb3BhZ2F0ZSBJT1BvcnQgcmVhZCB0byB2Q1BVIEVBWCByZWdpc3Rl
cikKMi8xNCBDaGVja2luZyBjb21taXQgMjJlOWZhNTdkMzRlIChody9pMzg2L3ZtcG9ydDogU2V0
IEVBWCB0byAtMSBvbiBmYWlsZWQgYW5kIHVuc3VwcG9ydGVkIGNvbW1hbmRzKQozLzE0IENoZWNr
aW5nIGNvbW1pdCBhMDM1ZDdhZTFiMGMgKGh3L2kzODYvdm1wb3J0OiBBZGQgZGV2aWNlIHByb3Bl
cnRpZXMpCjQvMTQgQ2hlY2tpbmcgY29tbWl0IGFlMTA4NWZmNzUwNyAoaHcvaTM4Ni92bXBvcnQ6
IEludHJvZHVjZSB2bXgtdmVyc2lvbiBwcm9wZXJ0eSkKNS8xNCBDaGVja2luZyBjb21taXQgMTkz
NmQ0ZDQ5ZjNmIChody9pMzg2L3ZtcG9ydDogUmVwb3J0IFZNWCB0eXBlIGluIENNRF9HRVRWRVJT
SU9OKQo2LzE0IENoZWNraW5nIGNvbW1pdCAzMTY0NzU2NjJiYmMgKGh3L2kzODYvdm1wb3J0OiBE
ZWZpbmUgZW51bSBmb3IgYWxsIGNvbW1hbmRzKQo3LzE0IENoZWNraW5nIGNvbW1pdCBlOGJkYTI0
NDQ4MjQgKGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVEJJT1NVVUlEKQpF
UlJPUjogIihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgojMzM6IEZJTEU6IGh3L2kzODYvdm1w
b3J0LmM6MTI4OgorICAgIHVpbnQzMl90ICp1dWlkX3BhcnRzID0gKHVpbnQzMl90KikocWVtdV91
dWlkLmRhdGEpOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzOSBsaW5lcyBjaGVja2Vk
CgpQYXRjaCA3LzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo4LzE0IENoZWNraW5nIGNv
bW1pdCA4ZjFiMmRkY2ZlMzkgKGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dF
VFRJTUUpCjkvMTQgQ2hlY2tpbmcgY29tbWl0IGIyNzUzY2U5MDhlZCAoaHcvaTM4Ni92bXBvcnQ6
IEFkZCBzdXBwb3J0IGZvciBDTURfR0VUVElNRUZVTEwpCjEwLzE0IENoZWNraW5nIGNvbW1pdCA5
Y2IyMzNjMjE0ZWEgKGh3L2kzODYvdm1wb3J0OiBBZGQgc3VwcG9ydCBmb3IgQ01EX0dFVF9WQ1BV
X0lORk8pCkVSUk9SOiByZXR1cm4gaXMgbm90IGEgZnVuY3Rpb24sIHBhcmVudGhlc2VzIGFyZSBu
b3QgcmVxdWlyZWQKIzQxOiBGSUxFOiBody9pMzg2L3ZtcG9ydC5jOjE4NToKKyAgICByZXR1cm4g
KDEgPDwgVkNQVV9JTkZPX1JFU0VSVkVEX0JJVCk7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDM4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEwLzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgoxMS8xNCBDaGVja2luZyBjb21taXQgYTA3MjY5ZTNjNjAwIChody9pMzg2L3ZtcG9ydDog
QWxsb3cgeDJhcGljIHdpdGhvdXQgSVIpCjEyLzE0IENoZWNraW5nIGNvbW1pdCAxMTA0YmEyOTE0
OTYgKGkzODYvY3B1OiBTdG9yZSBMQVBJQyBidXMgZnJlcXVlbmN5IGluIENQVSBzdHJ1Y3R1cmUp
CjEzLzE0IENoZWNraW5nIGNvbW1pdCAzZTI2YzkzOTNhZWYgKGh3L2kzODYvdm1wb3J0OiBBZGQg
c3VwcG9ydCBmb3IgQ01EX0dFVEhaKQoxNC8xNCBDaGVja2luZyBjb21taXQgZGYzOTk2MmUzNDU4
IChody9pMzg2L3ZtcG9ydDogQXNzZXJ0IHZtcG9ydCBpbml0aWFsaXplZCBiZWZvcmUgcmVnaXN0
ZXJpbmcgY29tbWFuZHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwMzA5MjM1NDExLjc2NTg3LTEtbGlyYW4uYWxvbkBvcmFjbGUuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

