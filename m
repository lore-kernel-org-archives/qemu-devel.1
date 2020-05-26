Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32C5205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32C5205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVWE-0006D6-3Q
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdVVX-0005aM-52; Tue, 26 May 2020 05:04:23 -0400
Resent-Date: Tue, 26 May 2020 05:04:23 -0400
Resent-Message-Id: <E1jdVVX-0005aM-52@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdVVU-0005yv-MR; Tue, 26 May 2020 05:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590483843; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jN5n6Av20ksVI3tfbQhdnJEYFVVQCPQbvWcR+pKBs3v5xa0yE55utKSOBNw0J0nWPFwTAZ76hH95LJpV/qhTDbLAT/NrToE6CCV25MrI/2X3tDVsjffywAWRXC0LiWtzqM16qZp13hr3Y0sS/zwN6DCyr3D/dWk8Fv/tHEMSl1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590483843;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=d7T4dgu/nXTCGpYc7YxvZ6Oam7VHRTFCd/QxiqMCBMc=; 
 b=EBv3R1ZL5QGScE41vcwWzeUMJ6K3BEy1uy3FaoFOa8YR0OF9ibLc9ucP5JRf6g9oO/Xp8jBDCrvrfLyFXD0cul0fMdz+pGS2V8k+KPP59mkIQa/Hv0/hyN5OxiCG4kd+IIxAeb3WM/9nypmFZPCtu+IQX3C1tH2hZostzy2oL+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590483841674418.82438737746986;
 Tue, 26 May 2020 02:04:01 -0700 (PDT)
Message-ID: <159048384011.9264.8918018483923814043@45ef0f9c86ae>
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
Subject: Re: [PATCH 00/14] hw/display: Omnibus cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Tue, 26 May 2020 02:04:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:17:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-trivial@nongnu.org, alistair@alistair23.me,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, f4bug@amsat.org,
 i.mitsyanko@gmail.com, qemu-arm@nongnu.org, kraxel@redhat.com,
 edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNjA2MjI1Mi4xOTg1
Mi0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjYwNjIyNTIuMTk4NTItMS1mNGJ1Z0BhbXNhdC5v
cmcKU3ViamVjdDogW1BBVENIIDAwLzE0XSBody9kaXNwbGF5OiBPbW5pYnVzIGNsZWFudXBzClR5
cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODk2MDc5MCBody9kaXNwbGF5L3B4YTJ4eF9sY2Q6IFJl
cGxhY2UgcHJpbnRmKCkgY2FsbCBieSBxZW11X2xvZ19tYXNrKCkKZDBiNGNiOSBody9kaXNwbGF5
L29tYXBfZHNzOiBSZXBsYWNlIGZwcmludGYoKSBjYWxsIGJ5IHFlbXVfbG9nX21hc2soTE9HX1VO
SU1QKQpkMjFiMWIzIGh3L2Rpc3BsYXkvZXh5bm9zNDIxMF9maW1kOiBVc2UgcWVtdV9sb2dfbWFz
ayhHVUVTVF9FUlJPUikKZTE2ZmNiNSBody9kaXNwbGF5L3Ztd2FyZV92Z2E6IExldCB0aGUgUENJ
IGRldmljZSBvd24gaXRzIEkvTyBNZW1vcnlSZWdpb24KNmFlYWE4MyBody9kaXNwbGF5L3Ztd2Fy
ZV92Z2E6IFJlcGxhY2UgcHJpbnRmKCkgY2FsbHMgYnkgcWVtdV9sb2dfbWFzayhFUlJPUikKNjdi
MDNiZSBody9kaXNwbGF5L3hsbnhfZHA6IFJlcGxhY2UgZGlzYWJsZWQgRFBSSU5URigpIGJ5IGVy
cm9yX3JlcG9ydCgpCjBlYTMwYzcgaHcvZGlzcGxheS9kcGNkOiBDb252ZXJ0IGRlYnVnIHByaW50
ZigpcyB0byB0cmFjZSBldmVudHMKODcwYzcxYSBody9kaXNwbGF5L2RwY2Q6IEZpeCBtZW1vcnkg
cmVnaW9uIHNpemUKODM4NjUzMCBody9kaXNwbGF5L2NpcnJ1c192Z2E6IENvbnZlcnQgZGVidWcg
cHJpbnRmKCkgdG8gdHJhY2UgZXZlbnQKNmExNTZhOCBody9kaXNwbGF5L2NpcnJ1c192Z2E6IFVz
ZSBxZW11X2xvZ19tYXNrKEVSUk9SKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50Zgo3YmRkY2MxIGh3
L2Rpc3BsYXkvY2lycnVzX3ZnYTogVXNlIHFlbXVfbG9nX21hc2soVU5JTVApIGluc3RlYWQgb2Yg
ZGVidWcgcHJpbnRmCjM2NTU1NjAgaHcvZGlzcGxheS9jaXJydXNfdmdhOiBDb252ZXJ0IGRlYnVn
IHByaW50ZigpIHRvIHRyYWNlIGV2ZW50CjVkYTFkN2QgaHcvZGlzcGxheS9jZzM6IENvbnZlcnQg
ZGVidWcgcHJpbnRmKClzIHRvIHRyYWNlIGV2ZW50cwo1ZTE1Y2YzIGh3L2Rpc3BsYXkvZWRpZDog
QWRkIG1pc3NpbmcgJ3FkZXYtcHJvcGVydGllcy5oJyBoZWFkZXIKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvMTQgQ2hlY2tpbmcgY29tbWl0IDVlMTVjZjM0NGYwZCAoaHcvZGlzcGxheS9lZGlkOiBB
ZGQgbWlzc2luZyAncWRldi1wcm9wZXJ0aWVzLmgnIGhlYWRlcikKMi8xNCBDaGVja2luZyBjb21t
aXQgNWRhMWQ3ZDcwOWM0IChody9kaXNwbGF5L2NnMzogQ29udmVydCBkZWJ1ZyBwcmludGYoKXMg
dG8gdHJhY2UgZXZlbnRzKQozLzE0IENoZWNraW5nIGNvbW1pdCAzNjU1NTYwYTFhZjkgKGh3L2Rp
c3BsYXkvY2lycnVzX3ZnYTogQ29udmVydCBkZWJ1ZyBwcmludGYoKSB0byB0cmFjZSBldmVudCkK
NC8xNCBDaGVja2luZyBjb21taXQgN2JkZGNjMWZmYzQ1IChody9kaXNwbGF5L2NpcnJ1c192Z2E6
IFVzZSBxZW11X2xvZ19tYXNrKFVOSU1QKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50ZikKNS8xNCBD
aGVja2luZyBjb21taXQgNmExNTZhOGM3YmZkIChody9kaXNwbGF5L2NpcnJ1c192Z2E6IFVzZSBx
ZW11X2xvZ19tYXNrKEVSUk9SKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50ZikKRVJST1I6IHN1c3Bl
Y3QgY29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDE2LCAxMikKIzMxOiBG
SUxFOiBody9kaXNwbGF5L2NpcnJ1c192Z2EuYzoxMDM4OgogICAgICAgICAgICAgICAgaWYgKHMt
PmNpcnJ1c19ibHRfcGl4ZWx3aWR0aCA+IDIpIHsKKyAgICAgICAgICAgIHFlbXVfbG9nX21hc2so
TE9HX0dVRVNUX0VSUk9SLAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNTYgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNS8xNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi8xNCBDaGVj
a2luZyBjb21taXQgODM4NjUzMGE5YzYzIChody9kaXNwbGF5L2NpcnJ1c192Z2E6IENvbnZlcnQg
ZGVidWcgcHJpbnRmKCkgdG8gdHJhY2UgZXZlbnQpCjcvMTQgQ2hlY2tpbmcgY29tbWl0IDg3MGM3
MWE5YTMyZiAoaHcvZGlzcGxheS9kcGNkOiBGaXggbWVtb3J5IHJlZ2lvbiBzaXplKQo4LzE0IENo
ZWNraW5nIGNvbW1pdCAwZWEzMGM3NjA5ZGYgKGh3L2Rpc3BsYXkvZHBjZDogQ29udmVydCBkZWJ1
ZyBwcmludGYoKXMgdG8gdHJhY2UgZXZlbnRzKQo5LzE0IENoZWNraW5nIGNvbW1pdCA2N2IwM2Jl
ODg4YzIgKGh3L2Rpc3BsYXkveGxueF9kcDogUmVwbGFjZSBkaXNhYmxlZCBEUFJJTlRGKCkgYnkg
ZXJyb3JfcmVwb3J0KCkpCjEwLzE0IENoZWNraW5nIGNvbW1pdCA2YWVhYTgzNmQ3MTkgKGh3L2Rp
c3BsYXkvdm13YXJlX3ZnYTogUmVwbGFjZSBwcmludGYoKSBjYWxscyBieSBxZW11X2xvZ19tYXNr
KEVSUk9SKSkKMTEvMTQgQ2hlY2tpbmcgY29tbWl0IGUxNmZjYjU3YmRlZSAoaHcvZGlzcGxheS92
bXdhcmVfdmdhOiBMZXQgdGhlIFBDSSBkZXZpY2Ugb3duIGl0cyBJL08gTWVtb3J5UmVnaW9uKQox
Mi8xNCBDaGVja2luZyBjb21taXQgZDIxYjFiMzhmZTgwIChody9kaXNwbGF5L2V4eW5vczQyMTBf
ZmltZDogVXNlIHFlbXVfbG9nX21hc2soR1VFU1RfRVJST1IpKQoxMy8xNCBDaGVja2luZyBjb21t
aXQgZDBiNGNiOWVjNzY0IChody9kaXNwbGF5L29tYXBfZHNzOiBSZXBsYWNlIGZwcmludGYoKSBj
YWxsIGJ5IHFlbXVfbG9nX21hc2soTE9HX1VOSU1QKSkKMTQvMTQgQ2hlY2tpbmcgY29tbWl0IDg5
NjA3OTA1OGJmNiAoaHcvZGlzcGxheS9weGEyeHhfbGNkOiBSZXBsYWNlIHByaW50ZigpIGNhbGwg
YnkgcWVtdV9sb2dfbWFzaygpKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDIwMDUyNjA2MjI1Mi4xOTg1Mi0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

