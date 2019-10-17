Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12320C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 05:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A5D2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 05:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A5D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKyFJ-0005li-2E
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 01:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKyEe-00050X-Rk
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 01:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKyEd-0003ih-Aq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 01:22:04 -0400
Resent-Date: Thu, 17 Oct 2019 01:22:04 -0400
Resent-Message-Id: <E1iKyEd-0003ih-Aq@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKyEd-0003hz-25; Thu, 17 Oct 2019 01:22:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571289710; cv=none; d=zoho.com; s=zohoarc; 
 b=iouCWKFn6K+1h3U+/Ykd4LBlpii1mALxVtyZwlJir2eOIL+fUk6DyvAgw7niAS9LcjdtOy9AQfd0g+TiX9+LdhzZhcOS43eWQ6wTV8PXBYln+FWYzVJ3Iimxp49GQkkYEvBsk2dJbFl2c8ZDzx9hwehQPE+5ZeSdsj8e4BBlJy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571289710;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rgh9h98f0l/z0NEN89kufBa3+3XXSwpM+1EwMe9Qzj4=; 
 b=b8ntY1vtD3B/+/1sCLuIVRoi1q6cIIkGYvxa5jcyxnqPKyRt4XdHG1zY4T9nZ1wdYAPpgES5+aqzBiPhzWFgEC3LQ1XB2n2TOnniHGq+Bv4LSdURFxHK6d4T2/+Gon1AUP+FbJA9s36ZA3yjyRBARmOktwOpWfRLqkj9rkrZFU8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571289708411157.54615192034214;
 Wed, 16 Oct 2019 22:21:48 -0700 (PDT)
In-Reply-To: <20191017044232.27601-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 0/4] target/arm vector improvements
Message-ID: <157128970723.19066.12876415670200560539@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 16 Oct 2019 22:21:48 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNzA0NDIzMi4yNzYw
MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzRdIHRhcmdldC9hcm0gdmVj
dG9yIGltcHJvdmVtZW50cwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMTcwNDQyMzIu
Mjc2MDEtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjNlYTY2NTMgdGFyZ2V0
L2FybTogQ29udmVydCBQTVVMTC44IHRvIGd2ZWMKYjZjZjhlYSB0YXJnZXQvYXJtOiBDb252ZXJ0
IFBNVUxMLjY0IHRvIGd2ZWMKNWVkZGFmMiB0YXJnZXQvYXJtOiBDb252ZXJ0IFBNVUwuOCB0byBn
dmVjCmJkOGY5NjcgdGFyZ2V0L2FybTogVmVjdG9yaXplIFVTSEwgYW5kIFNTSEwKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgYmQ4Zjk2NzU1MWI2ICh0YXJnZXQvYXJt
OiBWZWN0b3JpemUgVVNITCBhbmQgU1NITCkKRVJST1I6IHRyYWlsaW5nIHN0YXRlbWVudHMgc2hv
dWxkIGJlIG9uIG5leHQgbGluZQojMTYwOiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS5jOjM1
ODM6CisgICAgICAgICAgICBjYXNlIDI6IGdlbl91c2hsX2kzMih2YXIsIHZhciwgc2hpZnQpOyBi
cmVhazsKCkVSUk9SOiB0cmFpbGluZyBzdGF0ZW1lbnRzIHNob3VsZCBiZSBvbiBuZXh0IGxpbmUK
IzE2NzogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUuYzozNTg5OgorICAgICAgICAgICAgY2Fz
ZSAyOiBnZW5fc3NobF9pMzIodmFyLCB2YXIsIHNoaWZ0KTsgYnJlYWs7Cgp0b3RhbDogMiBlcnJv
cnMsIDAgd2FybmluZ3MsIDU3MSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzQgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCjIvNCBDaGVja2luZyBjb21taXQgNWVkZGFmMjY2MWUzICh0YXJnZXQv
YXJtOiBDb252ZXJ0IFBNVUwuOCB0byBndmVjKQozLzQgQ2hlY2tpbmcgY29tbWl0IGI2Y2Y4ZWEw
OTVkYiAodGFyZ2V0L2FybTogQ29udmVydCBQTVVMTC42NCB0byBndmVjKQo0LzQgQ2hlY2tpbmcg
Y29tbWl0IDNlYTY2NTMzNmU2YyAodGFyZ2V0L2FybTogQ29udmVydCBQTVVMTC44IHRvIGd2ZWMp
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkx
MDE3MDQ0MjMyLjI3NjAxLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


