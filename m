Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D979FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFF620663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFF620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcEtP-0001RZ-Sf
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcEsu-00012O-KN
 for qemu-devel@nongnu.org; Fri, 22 May 2020 17:07:16 -0400
Resent-Date: Fri, 22 May 2020 17:07:16 -0400
Resent-Message-Id: <E1jcEsu-00012O-KN@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcEss-0003MA-W7
 for qemu-devel@nongnu.org; Fri, 22 May 2020 17:07:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590181625; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JO6Uf5rVzVGmUvLIHrlN6sdfwoSe9jOOsM0FYUeAl7ZzU5QFeZrPvdLmWoaJGcVjYrnnZSqoC7aMVC6M5pr0MSkN0b4Acz4WanSJ7bPF92QvNZGrtgkNFOu6nV6JUhBwxVPQ3ISBM1gyOgAXdrm95iuOFZe0t8cyEa6/FpvI1Vo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590181625;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fJSXZpx+Mwhq96kNym/clSegvCa3CzT54ZQBLpmrgCg=; 
 b=ZZ1bCYZYbpGIWYhCVJAVG29CS28V1UH6cVzNm1n3rlm6vIouFtlm9AZkUo2TzqmusmTUBjyHaGKPielMqK0ZQ+1DktEkPchLXL7j4DAwCuMjkCjDXW7kk+wia6kD6hLxvj6PbuzNp5JDXvqQ0kpq0dI4YN5g57nWUAKpdue4ML0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590181624494455.7391608415288;
 Fri, 22 May 2020 14:07:04 -0700 (PDT)
Message-ID: <159018162329.1576.250572947116616263@45ef0f9c86ae>
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
Subject: Re: [PATCH 00/19] Add Thread Sanitizer support to QEMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: robert.foley@linaro.org
Date: Fri, 22 May 2020 14:07:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 15:19:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMjE2MDc1NS44ODYt
MS1yb2JlcnQuZm9sZXlAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjIxNjA3NTUuODg2LTEtcm9iZXJ0LmZv
bGV5QGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIIDAwLzE5XSBBZGQgVGhyZWFkIFNhbml0aXpl
ciBzdXBwb3J0IHRvIFFFTVUKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoxNzM3NjYzIGRvY3M6
IEFkZGVkIGRldGFpbHMgb24gVFNhbiB0byB0ZXN0aW5nLnJzdAo4MmFhNDYwIHRhcmdldC9hcm06
IEZpeCB0c2FuIHdhcm5pbmcgaW4gY3B1LmMKNGEzYmQ1YSB1dGlsOiBBZGRlZCB0c2FuIGFubm90
YXRlIGZvciB0aHJlYWQgbmFtZS4KZjI2MTRiYiB1dGlsOiBmaXhlZCB0c2FuIHdhcm5pbmdzIGlu
IHRocmVhZF9wb29sLmMKNTY1MjljNyBxaHQ6IEZpeCB0c2FuIHdhcm5pbmdzLgoxMjhmNjNjIHV0
aWwvYXN5bmM6IEZpeGVkIHRzYW4gd2FybmluZ3MKZjg2YzM4YyBhY2NlbC90Y2c6IEZpeGVkIHRz
YW4gd2FybmluZ3MuCjBkN2VlMTYgY29uZmlndXJlOiBhZGRlZCB0c2FuIHN1cHBvcnQgZm9yIGJs
YWNrbGlzdC4KY2ZiMmQzNCBhY2NlbC90Y2c6IEZpeGVkIHRzYW4gd2FybmluZ3MgcmVsYXRlZCB0
byBwYXJhbGxlbF9jcHVzCjFlZjFlZDIgaW5jbHVkZS9xZW11OiBBZGRlZCB0c2FuLmggZm9yIGFu
bm90YXRpb25zLgpiZDI4N2U5IHRlc3RzL2RvY2tlcjogQWRkZWQgZG9ja2VyIGJ1aWxkIHN1cHBv
cnQgZm9yIFRTYW4uCjZiYWYwZDMgdGhyZWFkOiBhZGQgdHNhbiBhbm5vdGF0aW9ucyB0byBRZW11
U3BpbgpiYmY4OGQ5IHRyYW5zbGF0ZS1hbGw6IGNhbGwgcWVtdV9zcGluX2Rlc3Ryb3kgZm9yIFBh
Z2VEZXNjCjVmMGEyMTMgdGNnOiBjYWxsIHFlbXVfc3Bpbl9kZXN0cm95IGZvciB0Yi0+am1wX2xv
Y2sKZmIxOTY0OSBxaHQ6IGNhbGwgcWVtdV9zcGluX2Rlc3Ryb3kgZm9yIGhlYWQgYnVja2V0cwo2
ODhjYTY0IGNwdXRsYjogZGVzdHJveSBDUFVUTEIgd2l0aCB0bGJfZGVzdHJveQpiZThkMWY4IHRo
cmVhZDogYWRkIHFlbXVfc3Bpbl9kZXN0cm95CjJhMzI2YjYgY3B1OiBjb252ZXJ0IHF1ZXVlZCB3
b3JrIHRvIGEgUVNJTVBMRVEKN2ZiNzgzMCBjb25maWd1cmU6IGFkZCAtLWVuYWJsZS10c2FuIGZs
YWcgKyBmaWJlciBhbm5vdGF0aW9ucyBmb3IgY29yb3V0aW5lLXVjb250ZXh0Cgo9PT0gT1VUUFVU
IEJFR0lOID09PQoxLzE5IENoZWNraW5nIGNvbW1pdCA3ZmI3ODMwNzk3YmUgKGNvbmZpZ3VyZTog
YWRkIC0tZW5hYmxlLXRzYW4gZmxhZyArIGZpYmVyIGFubm90YXRpb25zIGZvciBjb3JvdXRpbmUt
dWNvbnRleHQpCjIvMTkgQ2hlY2tpbmcgY29tbWl0IDJhMzI2YjZmNzIxNSAoY3B1OiBjb252ZXJ0
IHF1ZXVlZCB3b3JrIHRvIGEgUVNJTVBMRVEpCjMvMTkgQ2hlY2tpbmcgY29tbWl0IGJlOGQxZjhm
ZjUxNyAodGhyZWFkOiBhZGQgcWVtdV9zcGluX2Rlc3Ryb3kpCjQvMTkgQ2hlY2tpbmcgY29tbWl0
IDY4OGNhNjQ3NjRiZiAoY3B1dGxiOiBkZXN0cm95IENQVVRMQiB3aXRoIHRsYl9kZXN0cm95KQo1
LzE5IENoZWNraW5nIGNvbW1pdCBmYjE5NjQ5ZjcwMjUgKHFodDogY2FsbCBxZW11X3NwaW5fZGVz
dHJveSBmb3IgaGVhZCBidWNrZXRzKQo2LzE5IENoZWNraW5nIGNvbW1pdCA1ZjBhMjEzNjVlNmUg
KHRjZzogY2FsbCBxZW11X3NwaW5fZGVzdHJveSBmb3IgdGItPmptcF9sb2NrKQo3LzE5IENoZWNr
aW5nIGNvbW1pdCBiYmY4OGQ5MjU3NWEgKHRyYW5zbGF0ZS1hbGw6IGNhbGwgcWVtdV9zcGluX2Rl
c3Ryb3kgZm9yIFBhZ2VEZXNjKQo4LzE5IENoZWNraW5nIGNvbW1pdCA2YmFmMGQzN2NmZGYgKHRo
cmVhZDogYWRkIHRzYW4gYW5ub3RhdGlvbnMgdG8gUWVtdVNwaW4pCjkvMTkgQ2hlY2tpbmcgY29t
bWl0IGJkMjg3ZTk2Y2Y0YSAodGVzdHMvZG9ja2VyOiBBZGRlZCBkb2NrZXIgYnVpbGQgc3VwcG9y
dCBmb3IgVFNhbi4pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzc0OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTE4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDkv
MTkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMTAvMTkgQ2hlY2tpbmcgY29tbWl0IDFlZjFl
ZDIyYmU0YiAoaW5jbHVkZS9xZW11OiBBZGRlZCB0c2FuLmggZm9yIGFubm90YXRpb25zLikKV0FS
TklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBu
ZWVkIHVwZGF0aW5nPwojMTg6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCA0OCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxMC8xOSBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoxMS8xOSBDaGVja2luZyBjb21taXQgY2ZiMmQzNDNiNmVkIChhY2NlbC90
Y2c6IEZpeGVkIHRzYW4gd2FybmluZ3MgcmVsYXRlZCB0byBwYXJhbGxlbF9jcHVzKQoxMi8xOSBD
aGVja2luZyBjb21taXQgMGQ3ZWUxNmZmZTgzIChjb25maWd1cmU6IGFkZGVkIHRzYW4gc3VwcG9y
dCBmb3IgYmxhY2tsaXN0LikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShz
KSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjg6IApuZXcgZmlsZSBtb2RlIDEw
MDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxNCBsaW5lcyBjaGVja2VkCgpQYXRj
aCAxMi8xOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoxMy8xOSBDaGVja2luZyBjb21taXQg
Zjg2YzM4YzZhYTg3IChhY2NlbC90Y2c6IEZpeGVkIHRzYW4gd2FybmluZ3MuKQoxNC8xOSBDaGVj
a2luZyBjb21taXQgMTI4ZjYzYzM3Yjc2ICh1dGlsL2FzeW5jOiBGaXhlZCB0c2FuIHdhcm5pbmdz
KQoxNS8xOSBDaGVja2luZyBjb21taXQgNTY1MjljN2ZmODM3IChxaHQ6IEZpeCB0c2FuIHdhcm5p
bmdzLikKMTYvMTkgQ2hlY2tpbmcgY29tbWl0IGYyNjE0YmJhZmRiNCAodXRpbDogZml4ZWQgdHNh
biB3YXJuaW5ncyBpbiB0aHJlYWRfcG9vbC5jKQoxNy8xOSBDaGVja2luZyBjb21taXQgNGEzYmQ1
YTY0NDE0ICh1dGlsOiBBZGRlZCB0c2FuIGFubm90YXRlIGZvciB0aHJlYWQgbmFtZS4pCjE4LzE5
IENoZWNraW5nIGNvbW1pdCA4MmFhNDYwNzIyYjMgKHRhcmdldC9hcm06IEZpeCB0c2FuIHdhcm5p
bmcgaW4gY3B1LmMpCjE5LzE5IENoZWNraW5nIGNvbW1pdCAxNzM3NjYzMGExNDYgKGRvY3M6IEFk
ZGVkIGRldGFpbHMgb24gVFNhbiB0byB0ZXN0aW5nLnJzdCkKRVJST1I6IHRyYWlsaW5nIHdoaXRl
c3BhY2UKIzM0OiBGSUxFOiBkb2NzL2RldmVsL3Rlc3RpbmcucnN0OjQxMzoKKyAgJAoKRVJST1I6
IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzQwOiBGSUxFOiBkb2NzL2RldmVsL3Rlc3RpbmcucnN0OjQx
OToKK3RoZSBmaWxlcyB3aXRoIFRTYW4gd2FybmluZ3MuICAkCgp0b3RhbDogMiBlcnJvcnMsIDAg
d2FybmluZ3MsIDc4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDE5LzE5IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDUyMjE2MDc1NS44ODYtMS1yb2JlcnQuZm9sZXlAbGluYXJvLm9yZy90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

