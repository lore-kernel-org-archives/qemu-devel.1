Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C3CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 07:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDDB20679
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 07:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDDB20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOG7w-0004Ei-Dm
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 03:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iOG6P-0002Kx-CL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 03:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iOG6N-00071W-Hp
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 03:03:09 -0400
Resent-Date: Sat, 26 Oct 2019 03:03:09 -0400
Resent-Message-Id: <E1iOG6N-00071W-Hp@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iOG6N-000700-9q
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 03:03:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572073374; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OT1XvUd0MUPVvLPxOpFVRsk8p1yKHn89NUxU7qVe8rlAYtxRprkX5+gv0FbJyHYCf7jQQnCJ0HsUJ0b+NHn+0xuaPd5Py97IpXMIT2wMKrVrKDwKzRgfF6UJZqdvlK3zteiuvdF3DWvFHaz6XW4hT8huS3hMW4xCehZQFKxVa3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572073374;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=//H5WFc+YFTankG1EXLOLu18g742rcHL+JpWd6SWg+U=; 
 b=aJqQ60LyDElo52TTnvl74A0gWDuWaFRTJyl0eT+02DGkL36XC+v7j/D3Y2cx7UielDbgixC8GGXooEkSjIsp6W0WRCkQ9nBWjsUJPgh9yQkIa8YuPe+BSDX8yfHB/KqAuzfCkfu3QkcDoHdZlvCKmzaP3RHJXlX6ahMLaZRSX4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572073374145213.42867212761462;
 Sat, 26 Oct 2019 00:02:54 -0700 (PDT)
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v2 00/12] linux-user sparc fixes
Message-ID: <157207337312.8606.13542397279538445718@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 26 Oct 2019 00:02:54 -0700 (PDT)
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNTExMzkyMS45NDEy
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAwLzEyXSBsaW51eC11c2Vy
IHNwYXJjIGZpeGVzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAyNTExMzkyMS45NDEy
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMTBhNThlNiBsaW51
eC11c2VyL2FscGhhOiBTZXQgcjIwIHNlY29uZGFyeSByZXR1cm4gdmFsdWUKNWViOGUxMyBsaW51
eC11c2VyL3NwYXJjOiBGaXggY3B1X2Nsb25lX3JlZ3NfKgoxZmU0MDg1IGxpbnV4LXVzZXI6IElu
dHJvZHVjZSBjcHVfY2xvbmVfcmVnc19wYXJlbnQKYzZiZjZmMiBsaW51eC11c2VyOiBSZW5hbWUg
Y3B1X2Nsb25lX3JlZ3MgdG8gY3B1X2Nsb25lX3JlZ3NfY2hpbGQKMWUwYTkxNiBsaW51eC11c2Vy
L3NwYXJjNjQ6IEZpeCB0YXJnZXRfc2lnbmFsX2ZyYW1lCmIyNTBkNzQgbGludXgtdXNlci9zcGFy
YzogRml4IFdSRUcgdXNhZ2UgaW4gc2V0dXBfZnJhbWUKYTg1MDhlZCBsaW51eC11c2VyL3NwYXJj
OiBVc2UgV1JFR19TUCBjb25zdGFudCBpbiBzcGFyYy9zaWduYWwuYwo5YjEyZTFjIGxpbnV4LXVz
ZXIvc3BhcmM6IEJlZ2luIHVzaW5nIFdSRUcgY29uc3RhbnRzIGluIHNwYXJjL3NpZ25hbC5jCjBk
YTRlM2UgbGludXgtdXNlci9zcGFyYzogVXNlIFdSRUcgY29uc3RhbnRzIGluIHNwYXJjL3Rhcmdl
dF9jcHUuaAoyYmFiOTQwIHRhcmdldC9zcGFyYzogRGVmaW5lIGFuIGVudW1lcmF0aW9uIGZvciBh
Y2Nlc3NpbmcgZW52LT5yZWd3cHRyCmRmYzg4NjkgdGVzdHMvdGNnL211bHRpYXJjaC9saW51eC10
ZXN0OiBGaXggZXJyb3IgY2hlY2sgZm9yIHNobWF0CjMyZWY2Y2Qgc2NyaXB0cy9xZW11LWJpbmZt
dC1jb25mOiBVcGRhdGUgZm9yIHNwYXJjNjQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTIgQ2hl
Y2tpbmcgY29tbWl0IDMyZWY2Y2Q3NzQyZiAoc2NyaXB0cy9xZW11LWJpbmZtdC1jb25mOiBVcGRh
dGUgZm9yIHNwYXJjNjQpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzNDogRklM
RTogc2NyaXB0cy9xZW11LWJpbmZtdC1jb25mLnNoOjQxOgorc3BhcmM2NF9tYWdpYz0nXHg3ZkVM
Rlx4MDJceDAyXHgwMVx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAy
XHgwMFx4MmInCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzM1OiBGSUxFOiBzY3Jp
cHRzL3FlbXUtYmluZm10LWNvbmYuc2g6NDI6CitzcGFyYzY0X21hc2s9J1x4ZmZceGZmXHhmZlx4
ZmZceGZmXHhmZlx4ZmZceDAwXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhm
ZVx4ZmZceGZmJwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCAyMCBsaW5lcyBjaGVja2Vk
CgpQYXRjaCAxLzEyIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzEyIENoZWNraW5nIGNv
bW1pdCBkZmM4ODY5YmExNTAgKHRlc3RzL3RjZy9tdWx0aWFyY2gvbGludXgtdGVzdDogRml4IGVy
cm9yIGNoZWNrIGZvciBzaG1hdCkKMy8xMiBDaGVja2luZyBjb21taXQgMmJhYjk0MDQzNjQ4ICh0
YXJnZXQvc3BhcmM6IERlZmluZSBhbiBlbnVtZXJhdGlvbiBmb3IgYWNjZXNzaW5nIGVudi0+cmVn
d3B0cikKNC8xMiBDaGVja2luZyBjb21taXQgMGRhNGUzZTFmOThlIChsaW51eC11c2VyL3NwYXJj
OiBVc2UgV1JFRyBjb25zdGFudHMgaW4gc3BhcmMvdGFyZ2V0X2NwdS5oKQo1LzEyIENoZWNraW5n
IGNvbW1pdCA5YjEyZTFjOGUzODggKGxpbnV4LXVzZXIvc3BhcmM6IEJlZ2luIHVzaW5nIFdSRUcg
Y29uc3RhbnRzIGluIHNwYXJjL3NpZ25hbC5jKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3Vu
ZCB0aGF0ICcrJyAoY3R4OlZ4VikKIzQ5OiBGSUxFOiBsaW51eC11c2VyL3NwYXJjL3NpZ25hbC5j
OjE1MToKKyAgICAgICAgX19wdXRfdXNlcihlbnYtPnJlZ3dwdHJbV1JFR19PMCArIGldLCAmc2kt
PnNpX3JlZ3MudV9yZWdzW2krOF0pOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWly
ZWQgYXJvdW5kIHRoYXQgJysnIChjdHg6VnhWKQojMTIxOiBGSUxFOiBsaW51eC11c2VyL3NwYXJj
L3NpZ25hbC5jOjI5MDoKKyAgICAgICAgX19nZXRfdXNlcihlbnYtPnJlZ3dwdHJbaSArIFdSRUdf
TzBdLCAmc2YtPmluZm8uc2lfcmVncy51X3JlZ3NbaSs4XSk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpF
UlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcrJyAoY3R4OlZ4VikKIzE2ODogRklM
RTogbGludXgtdXNlci9zcGFyYy9zaWduYWwuYzo0NjA6CisgICAgd19hZGRyID0gVEFSR0VUX1NU
QUNLX0JJQVMrZW52LT5yZWd3cHRyW1dSRUdfTzZdOwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKycgKGN0eDpWeFYp
CiMyMDM6IEZJTEU6IGxpbnV4LXVzZXIvc3BhcmMvc2lnbmFsLmM6NTYzOgorICAgIHdfYWRkciA9
IFRBUkdFVF9TVEFDS19CSUFTK2Vudi0+cmVnd3B0cltXUkVHX082XTsKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCnRvdGFsOiA0IGVycm9ycywgMCB3YXJuaW5ncywgMTc1IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDUvMTIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjYvMTIgQ2hl
Y2tpbmcgY29tbWl0IGE4NTA4ZWQzZThmZiAobGludXgtdXNlci9zcGFyYzogVXNlIFdSRUdfU1Ag
Y29uc3RhbnQgaW4gc3BhcmMvc2lnbmFsLmMpCjcvMTIgQ2hlY2tpbmcgY29tbWl0IGIyNTBkNzRm
ZWQ5MCAobGludXgtdXNlci9zcGFyYzogRml4IFdSRUcgdXNhZ2UgaW4gc2V0dXBfZnJhbWUpCjgv
MTIgQ2hlY2tpbmcgY29tbWl0IDFlMGE5MTZkMWZjYSAobGludXgtdXNlci9zcGFyYzY0OiBGaXgg
dGFyZ2V0X3NpZ25hbF9mcmFtZSkKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5j
dGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJwojMjE6IEZJTEU6IGxpbnV4LXVzZXIv
c3BhcmMvc2lnbmFsLmM6OTA6CisgICAgdWludDMyX3QgICAgICAgICAgICBpbnNuc1syXSBfX2F0
dHJpYnV0ZV9fICgoYWxpZ25lZCAoOCkpKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
MTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
OS8xMiBDaGVja2luZyBjb21taXQgYzZiZjZmMmFiNzNmIChsaW51eC11c2VyOiBSZW5hbWUgY3B1
X2Nsb25lX3JlZ3MgdG8gY3B1X2Nsb25lX3JlZ3NfY2hpbGQpCjEwLzEyIENoZWNraW5nIGNvbW1p
dCAxZmU0MDg1MWZhZDYgKGxpbnV4LXVzZXI6IEludHJvZHVjZSBjcHVfY2xvbmVfcmVnc19wYXJl
bnQpCjExLzEyIENoZWNraW5nIGNvbW1pdCA1ZWI4ZTEzOTdhNmIgKGxpbnV4LXVzZXIvc3BhcmM6
IEZpeCBjcHVfY2xvbmVfcmVnc18qKQoxMi8xMiBDaGVja2luZyBjb21taXQgMTBhNThlNjg5NzQ2
IChsaW51eC11c2VyL2FscGhhOiBTZXQgcjIwIHNlY29uZGFyeSByZXR1cm4gdmFsdWUpCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDI1MTEz
OTIxLjk0MTItMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


