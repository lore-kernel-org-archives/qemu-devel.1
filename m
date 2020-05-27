Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A570C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D435A207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D435A207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwo7-0004xq-2b
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdwnI-00043Q-NG; Wed, 27 May 2020 10:12:32 -0400
Resent-Date: Wed, 27 May 2020 10:12:32 -0400
Resent-Message-Id: <E1jdwnI-00043Q-NG@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdwnG-00029Y-M0; Wed, 27 May 2020 10:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590588743; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bZaexx1sXc0b76ZjDrU21Yi4OeED0YA3jM+BB/MnxtaHinOxxTNolAKk7IGTUADxgOOeAA4D/cJxbju3eCYspG91wEla0Rv4BERfPeARedgkYElpO4iKBOdmgmuo9upISdYGUAlz4z66pIzAP6/X/8pfdoPtyl1Ou9vO0EEOLKc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590588743;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WAyzjL3hEXT84H/Z2H6ONVPz1tt8FwSrVRCJOz7nvg8=; 
 b=Ct2cWzPw3/aJnAU8pBJpjwqBeUi9E7Yh9O7XwJfS84a/1hJWtrQkeQVgFsl+UH2C8mh1YrbWq/60wxxw2WR3a+kxb+DnDiJZeQ1qrIlg4V31a0Hq+/v++wXF1HXqkO5x+cjdnvF5oY7kMTmmLQ61hViVLx3eZM4cB5/GT0TvTpo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590588741032122.77576622460163;
 Wed, 27 May 2020 07:12:21 -0700 (PDT)
Message-ID: <159058873989.16318.11496237609169277676@45ef0f9c86ae>
In-Reply-To: <20200527100546.29297-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/3] some linux-user guest_base fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 27 May 2020 07:12:21 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 10:12:26
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
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNzEwMDU0Ni4yOTI5
Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTI3MTAwNTQ2LjI5Mjk3LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFUQ0ggIHYxIDAvM10gc29tZSBsaW51eC11c2Vy
IGd1ZXN0X2Jhc2UgZml4ZXMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
IC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDUyNzEwMDU0Ni4yOTI5Ny0xLWFsZXgu
YmVubmVlQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDIwMDUyNzEwMDU0Ni4yOTI5Ny0xLWFsZXgu
YmVubmVlQGxpbmFyby5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphNTM3ZTEz
IHRlc3RzL3RjZzogYWRkIHNpbXBsZSBjb21tcGFnZSB0ZXN0IGNhc2UKMjZjNDI0ZSBsaW51eC11
c2VyOiBkZWFsIHdpdGggYWRkcmVzcyB3cmFwIGZvciBBUk1fQ09NTVBBR0Ugb24gMzIgYml0Cjg4
MjVjYjEgbGludXgtdXNlcjogcHJvdmlkZSBmYWxsYmFjayBwZ2RfZmluZF9ob2xlIGZvciBiYXJl
IGNocm9vdHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgODgyNWNi
MTQ4ZmE4IChsaW51eC11c2VyOiBwcm92aWRlIGZhbGxiYWNrIHBnZF9maW5kX2hvbGUgZm9yIGJh
cmUgY2hyb290cykKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzQ0OiBGSUxFOiBs
aW51eC11c2VyL2VsZmxvYWQuYzoyMTE0Ogorc3RhdGljIHVpbnRwdHJfdCBwZ2RfZmluZF9ob2xl
X2ZhbGxiYWNrKHVpbnRwdHJfdCBndWVzdF9zaXplLCB1aW50cHRyX3QgYnJrLCBsb25nIGFsaWdu
KQoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA2MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAx
LzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMi8zIENoZWNraW5nIGNvbW1pdCAyNmM0MjRl
MzQ2ZGYgKGxpbnV4LXVzZXI6IGRlYWwgd2l0aCBhZGRyZXNzIHdyYXAgZm9yIEFSTV9DT01NUEFH
RSBvbiAzMiBiaXQpCjMvMyBDaGVja2luZyBjb21taXQgYTUzN2UxM2RiZWE1ICh0ZXN0cy90Y2c6
IGFkZCBzaW1wbGUgY29tbXBhZ2UgdGVzdCBjYXNlKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3Ig
ZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyODogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogVXNlIG9mIHZvbGF0aWxlIGlzIHVzdWFsbHkgd3Jv
bmcsIHBsZWFzZSBhZGQgYSBjb21tZW50CiM1NzogRklMRTogdGVzdHMvdGNnL2FybS9jb21tcGFn
ZS5jOjI1OgordHlwZWRlZiBpbnQgKGNtcHhjaGdfZm4pKGludCBvbGR2YWwsIGludCBuZXd2YWws
IHZvbGF0aWxlIGludCAqcHRyKTsKCkVSUk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3
cm9uZywgcGxlYXNlIGFkZCBhIGNvbW1lbnQKIzYzOiBGSUxFOiB0ZXN0cy90Y2cvYXJtL2NvbW1w
YWdlLmM6MzE6CisgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2xhdGlsZSBpbnQ2NF90ICpw
dHIpOwoKdG90YWw6IDIgZXJyb3JzLCAxIHdhcm5pbmdzLCA2OSBsaW5lcyBjaGVja2VkCgpQYXRj
aCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTI3MTAwNTQ2LjI5Mjk3LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

