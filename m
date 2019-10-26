Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E110ECA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 11:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FA32070B
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 11:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FA32070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOJtD-0001S7-Np
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 07:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iOJrz-0008LO-PD
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iOJrw-0002ad-9f
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:04:31 -0400
Resent-Date: Sat, 26 Oct 2019 07:04:29 -0400
Resent-Message-Id: <E1iOJrw-0002ad-9f@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iOJrv-0002Ze-7p
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 07:04:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572087855; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mYijgT6u65sQlluUy2NjrNv2/WXjUAVlh1J0nddBFAY3oBQSc0SRvwkMQ7X5u7tbzThF+k07PHjfc6Se7rkxE3+B5QrWyHGHPN+mCVoqm9Edsm008PbiDML4u2PiSfLqpRmyDrw2CU0RjOyvude8TRus0LAg9UjW6qIDQUKPrp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572087855;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=y+GndarpdNJyzdO+IiBMKeKnX5oMV46v3h39/L5EY5c=; 
 b=Ock1GC1lf2zcm6Ju4L97sDXdvtgxfHLQOJb479uO14ro+SmZjV9Et+ewmlbMbA7+NY03K1QFflSYSswN+8ERZXj6P0Ey9KIxMOWjDK6D7rwROi9GAAq0FNywcMEL9A/kcwXiadTreiPnuYK/FkKPJGVT6SmhlGqkHcYjkiCjsA4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572087854927871.3648377715156;
 Sat, 26 Oct 2019 04:04:14 -0700 (PDT)
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
Subject: Re: [PULL 00/12] tcg patch queue
Message-ID: <157208785390.8606.14170641851632496955@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 26 Oct 2019 04:04:14 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNTE0MjE1OS4xMjQ1
OS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIDAwLzEyXSB0Y2cgcGF0Y2ggcXVl
dWUKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMDI1MTQyMTU5LjEyNDU5LTEtcmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJv
bSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgZWU3MGZjMi4uODU2
YmQyYyAgbWFzdGVyICAgICAtPiBtYXN0ZXIKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8y
MDE5MTAyNjEwMTIyMS41NTA2LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tIC0+IHBhdGNoZXcv
MjAxOTEwMjYxMDEyMjEuNTUwNi0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM2YmNlZjEgdHJhbnNsYXRlLWFsbDogUmVtb3ZlIHRiX2Fs
bG9jCjMzOGQzNDggdHJhbnNsYXRlLWFsbDogZml4IHVuaW5pdGlhbGl6ZWQgdGItPm9yaWdfdGIK
MGVjYzZlZiBjcHV0bGI6IEZpeCB0bGJfdmFkZHJfdG9faG9zdAphYzVhMjJlIGV4ZWM6IENhY2hl
IFRBUkdFVF9QQUdFX01BU0sgZm9yIFRBUkdFVF9QQUdFX0JJVFNfVkFSWQpjYmU2ZjNjIGV4ZWM6
IFByb21vdGUgVEFSR0VUX1BBR0VfTUFTSyB0byB0YXJnZXRfbG9uZwoxOTNkMmYxIGV4ZWM6IFJl
c3RyaWN0IFRBUkdFVF9QQUdFX0JJVFNfVkFSWSBhc3NlcnQgdG8gQ09ORklHX0RFQlVHX1RDRwpm
NDU1NjgxIGV4ZWM6IFVzZSBjb25zdCBhbGlhcyBmb3IgVEFSR0VUX1BBR0VfQklUU19WQVJZCjcy
Mjk5YzcgY29uZmlndXJlOiBEZXRlY3QgY29tcGlsZXIgc3VwcG9ydCBmb3IgX19hdHRyaWJ1dGVf
XygoYWxpYXMpKQo4NzhkYmVkIGV4ZWM6IFNwbGl0IG91dCB2YXJpYWJsZSBwYWdlIHNpemUgc3Vw
cG9ydCB0byBleGVjLXZhcnkuYwoyYTBmNGQzIGNwdTogdXNlIFJPVU5EX1VQKCkgdG8gZGVmaW5l
IHh4eF9QQUdFX0FMSUdOCjBiYThmNjcgY3B1dGxiOiBlbnN1cmUgX2NtbXUgaGVscGVyIGZ1bmN0
aW9ucyBmb2xsb3cgdGhlIG5hbWluZyBzdGFuZGFyZApkYjRlMTIxIHRjaTogQWRkIGltcGxlbWVu
dGF0aW9uIGZvciBJTkRFWF9vcF9sZDE2dV9pNjQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTIg
Q2hlY2tpbmcgY29tbWl0IGRiNGUxMjE4ZjViMSAodGNpOiBBZGQgaW1wbGVtZW50YXRpb24gZm9y
IElOREVYX29wX2xkMTZ1X2k2NCkKMi8xMiBDaGVja2luZyBjb21taXQgMGJhOGY2NzY0NzNjIChj
cHV0bGI6IGVuc3VyZSBfY21tdSBoZWxwZXIgZnVuY3Rpb25zIGZvbGxvdyB0aGUgbmFtaW5nIHN0
YW5kYXJkKQozLzEyIENoZWNraW5nIGNvbW1pdCAyYTBmNGQzZGY2NzUgKGNwdTogdXNlIFJPVU5E
X1VQKCkgdG8gZGVmaW5lIHh4eF9QQUdFX0FMSUdOKQo0LzEyIENoZWNraW5nIGNvbW1pdCA4Nzhk
YmVkNmIxN2MgKGV4ZWM6IFNwbGl0IG91dCB2YXJpYWJsZSBwYWdlIHNpemUgc3VwcG9ydCB0byBl
eGVjLXZhcnkuYykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzQ6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
dG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxMjUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC8x
MiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo1LzEyIENoZWNraW5nIGNvbW1pdCA3MjI5OWM3
NjExMTQgKGNvbmZpZ3VyZTogRGV0ZWN0IGNvbXBpbGVyIHN1cHBvcnQgZm9yIF9fYXR0cmlidXRl
X18oKGFsaWFzKSkpCjYvMTIgQ2hlY2tpbmcgY29tbWl0IGY0NTU2ODE5MzBkOSAoZXhlYzogVXNl
IGNvbnN0IGFsaWFzIGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkpCkVSUk9SOiBleHRlcm5zIHNo
b3VsZCBiZSBhdm9pZGVkIGluIC5jIGZpbGVzCiM2NjogRklMRTogZXhlYy12YXJ5LmM6NTc6Citl
eHRlcm4gY29uc3QgVGFyZ2V0UGFnZUJpdHMgdGFyZ2V0X3BhZ2UKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMTAzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvMTIgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KCjcvMTIgQ2hlY2tpbmcgY29tbWl0IDE5M2QyZjE5NmQxOCAoZXhlYzogUmVz
dHJpY3QgVEFSR0VUX1BBR0VfQklUU19WQVJZIGFzc2VydCB0byBDT05GSUdfREVCVUdfVENHKQo4
LzEyIENoZWNraW5nIGNvbW1pdCBjYmU2ZjNjMjVlN2MgKGV4ZWM6IFByb21vdGUgVEFSR0VUX1BB
R0VfTUFTSyB0byB0YXJnZXRfbG9uZykKOS8xMiBDaGVja2luZyBjb21taXQgYWM1YTIyZTFlNWZj
IChleGVjOiBDYWNoZSBUQVJHRVRfUEFHRV9NQVNLIGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkp
CjEwLzEyIENoZWNraW5nIGNvbW1pdCAwZWNjNmVmOGViZDggKGNwdXRsYjogRml4IHRsYl92YWRk
cl90b19ob3N0KQoxMS8xMiBDaGVja2luZyBjb21taXQgMzM4ZDM0OGUyZGU1ICh0cmFuc2xhdGUt
YWxsOiBmaXggdW5pbml0aWFsaXplZCB0Yi0+b3JpZ190YikKMTIvMTIgQ2hlY2tpbmcgY29tbWl0
IGM2YmNlZjFmMTk3MCAodHJhbnNsYXRlLWFsbDogUmVtb3ZlIHRiX2FsbG9jKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyNTE0MjE1OS4x
MjQ1OS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


