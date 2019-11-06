Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4F1C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305E1217F9
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305E1217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSQj7-0006GU-85
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSQhy-0005KF-VK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:11:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSQhx-000876-A3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:11:10 -0500
Resent-Date: Wed, 06 Nov 2019 14:11:10 -0500
Resent-Message-Id: <E1iSQhx-000876-A3@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSQhx-00081V-28
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:11:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573067435; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CmT6fUjxItAvxX0sl8gcIcZ0dFPsYgTrAqX5YYakcAyg1AUZKD04mDWaoMt9VjG7Bqg8mbtmMfxIf/38fmMpVTynTJwpYJ7qAAvtEkWPJyh1RM2J8N2riOza5LRep352NqWSDCulEzHhYIwlTNqi2r8VqXCak8WOBrf6QzMKr/w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573067435;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=OGty4QV4K0RJ9gmmlachJQ+PbfuMD5yLXg7EtDMySmo=; 
 b=gpzEmjcdGxJBZAIhrMQpbLeO5aamtoXCa7dpeJIlPODJz6Ij2gr8m3A0pdM392YE8K9H5+TJ3l42aHZaSeRFOhgMnEvRZA/y2kUjoN63t5XKuK3fFQCm7OtTjlVQDDS5gc5lo5XmluXrPSX+D5w572DvRV+SnCJPV/Jd35Oc2jw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573067435015306.7335094921565;
 Wed, 6 Nov 2019 11:10:35 -0800 (PST)
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
Subject: Re: [PULL v2 00/13] Linux user for 4.2 patches
Message-ID: <157306743367.21358.12293983229221302772@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Wed, 6 Nov 2019 11:10:35 -0800 (PST)
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
Cc: riku.voipio@iki.fi, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 laurent@vivier.eu, alex.bennee@linaro.org, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNjEzMDQ1Ni42MTc2
LTEtbGF1cmVudEB2aXZpZXIuZXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIHYyIDAwLzEzXSBMaW51eCB1c2VyIGZvciA0LjIgcGF0
Y2hlcwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMDYxMzA0NTYuNjE3Ni0xLWxhdXJl
bnRAdml2aWVyLmV1Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8v
Z2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICAyZGQ4ZmQ2Li40NTcwYzJlICBtYXN0
ZXIgICAgIC0+IG1hc3RlcgogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkxMDE4MDA0
ODUwLjk4ODgtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbSAtPiBwYXRjaGV3LzIwMTkx
MDE4MDA0ODUwLjk4ODgtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjY2ZWVlZjggbGludXgtdXNlci9hbHBoYTogU2V0IHIyMCBz
ZWNvbmRhcnkgcmV0dXJuIHZhbHVlCjc1MmVlNmUgbGludXgtdXNlci9zcGFyYzogRml4IGNwdV9j
bG9uZV9yZWdzXyoKMjA1YWI0ZSBsaW51eC11c2VyOiBJbnRyb2R1Y2UgY3B1X2Nsb25lX3JlZ3Nf
cGFyZW50CmUxMTY4MTUgbGludXgtdXNlcjogUmVuYW1lIGNwdV9jbG9uZV9yZWdzIHRvIGNwdV9j
bG9uZV9yZWdzX2NoaWxkCmUzMzFlNWMgbGludXgtdXNlci9zcGFyYzY0OiBGaXggdGFyZ2V0X3Np
Z25hbF9mcmFtZQowYTlmNDRjIGxpbnV4LXVzZXIvc3BhcmM6IEZpeCBXUkVHIHVzYWdlIGluIHNl
dHVwX2ZyYW1lCjM5MjIwZGIgbGludXgtdXNlci9zcGFyYzogVXNlIFdSRUdfU1AgY29uc3RhbnQg
aW4gc3BhcmMvc2lnbmFsLmMKNTRmNDNjZCBsaW51eC11c2VyL3NwYXJjOiBCZWdpbiB1c2luZyBX
UkVHIGNvbnN0YW50cyBpbiBzcGFyYy9zaWduYWwuYwo0MWYxMzQ1IGxpbnV4LXVzZXIvc3BhcmM6
IFVzZSBXUkVHIGNvbnN0YW50cyBpbiBzcGFyYy90YXJnZXRfY3B1LmgKMDg0ZTRjZSB0YXJnZXQv
c3BhcmM6IERlZmluZSBhbiBlbnVtZXJhdGlvbiBmb3IgYWNjZXNzaW5nIGVudi0+cmVnd3B0cgo4
ZGExNTQ1IHRlc3RzL3RjZy9tdWx0aWFyY2gvbGludXgtdGVzdDogRml4IGVycm9yIGNoZWNrIGZv
ciBzaG1hdAoyOWY1MjlhIHNjcmlwdHMvcWVtdS1iaW5mbXQtY29uZjogVXBkYXRlIGZvciBzcGFy
YzY0CmNjZGFhMDggbGludXgtdXNlcjogU3VwcG9ydCBmb3IgTkVUTElOSyBzb2NrZXQgb3B0aW9u
cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMyBDaGVja2luZyBjb21taXQgY2NkYWEwODhkZWMz
IChsaW51eC11c2VyOiBTdXBwb3J0IGZvciBORVRMSU5LIHNvY2tldCBvcHRpb25zKQoyLzEzIENo
ZWNraW5nIGNvbW1pdCAyOWY1MjlhNTk5ZjEgKHNjcmlwdHMvcWVtdS1iaW5mbXQtY29uZjogVXBk
YXRlIGZvciBzcGFyYzY0KQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzY6IEZJ
TEU6IHNjcmlwdHMvcWVtdS1iaW5mbXQtY29uZi5zaDo0MToKK3NwYXJjNjRfbWFnaWM9J1x4N2ZF
TEZceDAyXHgwMlx4MDFceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgw
Mlx4MDBceDJiJwoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMzNzogRklMRTogc2Ny
aXB0cy9xZW11LWJpbmZtdC1jb25mLnNoOjQyOgorc3BhcmM2NF9tYXNrPSdceGZmXHhmZlx4ZmZc
eGZmXHhmZlx4ZmZceGZmXHgwMFx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4
ZmVceGZmXHhmZicKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMjAgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi8xMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8xMyBDaGVja2luZyBj
b21taXQgOGRhMTU0NTVmNmY2ICh0ZXN0cy90Y2cvbXVsdGlhcmNoL2xpbnV4LXRlc3Q6IEZpeCBl
cnJvciBjaGVjayBmb3Igc2htYXQpCjQvMTMgQ2hlY2tpbmcgY29tbWl0IDA4NGU0Y2U3ODVkNyAo
dGFyZ2V0L3NwYXJjOiBEZWZpbmUgYW4gZW51bWVyYXRpb24gZm9yIGFjY2Vzc2luZyBlbnYtPnJl
Z3dwdHIpCjUvMTMgQ2hlY2tpbmcgY29tbWl0IDQxZjEzNDVmNDExNiAobGludXgtdXNlci9zcGFy
YzogVXNlIFdSRUcgY29uc3RhbnRzIGluIHNwYXJjL3RhcmdldF9jcHUuaCkKNi8xMyBDaGVja2lu
ZyBjb21taXQgNTRmNDNjZDE2MzVhIChsaW51eC11c2VyL3NwYXJjOiBCZWdpbiB1c2luZyBXUkVH
IGNvbnN0YW50cyBpbiBzcGFyYy9zaWduYWwuYykKNy8xMyBDaGVja2luZyBjb21taXQgMzkyMjBk
YjYxNmNhIChsaW51eC11c2VyL3NwYXJjOiBVc2UgV1JFR19TUCBjb25zdGFudCBpbiBzcGFyYy9z
aWduYWwuYykKOC8xMyBDaGVja2luZyBjb21taXQgMGE5ZjQ0YzcyNDRhIChsaW51eC11c2VyL3Nw
YXJjOiBGaXggV1JFRyB1c2FnZSBpbiBzZXR1cF9mcmFtZSkKOS8xMyBDaGVja2luZyBjb21taXQg
ZTMzMWU1YzU2ODlkIChsaW51eC11c2VyL3NwYXJjNjQ6IEZpeCB0YXJnZXRfc2lnbmFsX2ZyYW1l
KQoxMC8xMyBDaGVja2luZyBjb21taXQgZTExNjgxNTdmYWM0IChsaW51eC11c2VyOiBSZW5hbWUg
Y3B1X2Nsb25lX3JlZ3MgdG8gY3B1X2Nsb25lX3JlZ3NfY2hpbGQpCjExLzEzIENoZWNraW5nIGNv
bW1pdCAyMDVhYjRlNjAwMWQgKGxpbnV4LXVzZXI6IEludHJvZHVjZSBjcHVfY2xvbmVfcmVnc19w
YXJlbnQpCjEyLzEzIENoZWNraW5nIGNvbW1pdCA3NTJlZTZlYzIzMDIgKGxpbnV4LXVzZXIvc3Bh
cmM6IEZpeCBjcHVfY2xvbmVfcmVnc18qKQoxMy8xMyBDaGVja2luZyBjb21taXQgNjZlZWVmOGY4
OWY3IChsaW51eC11c2VyL2FscGhhOiBTZXQgcjIwIHNlY29uZGFyeSByZXR1cm4gdmFsdWUpCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTA2
MTMwNDU2LjYxNzYtMS1sYXVyZW50QHZpdmllci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


