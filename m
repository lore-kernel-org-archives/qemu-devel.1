Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3731D20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731D20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2PB-0002BE-AK
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iv2OD-0001Ne-4I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iv2OB-0000gU-Ac
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:05:00 -0500
Resent-Date: Fri, 24 Jan 2020 12:05:00 -0500
Resent-Message-Id: <E1iv2OB-0000gU-Ac@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iv2OB-0000cB-2c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:04:59 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15798854616751006.7685000869205;
 Fri, 24 Jan 2020 09:04:21 -0800 (PST)
In-Reply-To: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v4 0/7] target/mips: Misc MIPS fixes and improvements for
 5.0
Message-ID: <157988546030.23531.7354490297539534319@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 24 Jan 2020 09:04:21 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: amarkovic@wavecomp.com, aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc5ODgzOTI5LTE1MTctMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6
IDE1Nzk4ODM5MjktMTUxNy0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQt
cmsuY29tClN1YmplY3Q6IFtQQVRDSCB2NCAwLzddIHRhcmdldC9taXBzOiBNaXNjIE1JUFMgZml4
ZXMgYW5kIGltcHJvdmVtZW50cyBmb3IgNS4wCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRh
Z10gICAgICAgICBwYXRjaGV3LzE1Nzk4ODM5MjktMTUxNy0xLWdpdC1zZW5kLWVtYWlsLWFsZWtz
YW5kYXIubWFya292aWNAcnQtcmsuY29tIC0+IHBhdGNoZXcvMTU3OTg4MzkyOS0xNTE3LTEtZ2l0
LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20KICogW25ldyB0YWddICAg
ICAgICAgcGF0Y2hldy8yMDIwMDEyNDE2MjYwNi44Nzg3LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnIC0+IHBhdGNoZXcvMjAyMDAxMjQxNjI2MDYuODc4Ny0xLXBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZwogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwMTI0MTY1MzM1LjQyMi0xLXJv
YmVydC5mb2xleUBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDAxMjQxNjUzMzUuNDIyLTEtcm9i
ZXJ0LmZvbGV5QGxpbmFyby5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozMzY5
ODIzIGRpc2FzOiBtaXBzOiBBZGQgbWljcm9taXBzIFI2IGRpc2Fzc2VtYmxlciAtIDMyLWJpdCBp
bnN0cnVjdGlvbnMKOWU5ODQ5MCBkaXNhczogbWlwczogQWRkIG1pY3JvbWlwcyBSNiBkaXNhc3Nl
bWJsZXIgLSBpbmZyYXN0cnVjdHVyZSBhbmQgMTYtYml0IGluc3RydWN0aW9ucwphYTE5NmVjIGRp
c2FzOiBBZGQgYSBmaWVsZCBmb3IgdGFyZ2V0LWRlcGVuZGFudCBkYXRhCjY5ODQyNzMgdGFyZ2V0
L21pcHM6IEFkZCBpbXBsZW1lbnRhdGlvbiBvZiBHSU5WVCBpbnN0cnVjdGlvbgo1ZDc0ZGIxIHRh
cmdldC9taXBzOiBBbWVuZCBDUDAgV2F0Y2hIaSByZWdpc3RlciBpbXBsZW1lbnRhdGlvbgpmNDAx
YzYxIHRhcmdldC9taXBzOiBBZGQgc3VwcG9ydCBmb3IgTUlQUzwzMnw2ND5SNiBDUkMzMiBJU0EK
ZjdlNTAwZCB0YXJnZXQvbWlwczogUmVjdGlmeSBkb2N1bWVudGF0aW9uIG9uIGRlcHJlY2F0aW5n
IHI0ayBtYWNoaW5lCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzcgQ2hlY2tpbmcgY29tbWl0IGY3
ZTUwMGQ4ZTYzNyAodGFyZ2V0L21pcHM6IFJlY3RpZnkgZG9jdW1lbnRhdGlvbiBvbiBkZXByZWNh
dGluZyByNGsgbWFjaGluZSkKMi83IENoZWNraW5nIGNvbW1pdCBmNDAxYzYxYjYyN2QgKHRhcmdl
dC9taXBzOiBBZGQgc3VwcG9ydCBmb3IgTUlQUzwzMnw2ND5SNiBDUkMzMiBJU0EpCjMvNyBDaGVj
a2luZyBjb21taXQgNWQ3NGRiMTc0YzRhICh0YXJnZXQvbWlwczogQW1lbmQgQ1AwIFdhdGNoSGkg
cmVnaXN0ZXIgaW1wbGVtZW50YXRpb24pCjQvNyBDaGVja2luZyBjb21taXQgNjk4NDI3M2QyZjBl
ICh0YXJnZXQvbWlwczogQWRkIGltcGxlbWVudGF0aW9uIG9mIEdJTlZUIGluc3RydWN0aW9uKQo1
LzcgQ2hlY2tpbmcgY29tbWl0IGFhMTk2ZWMwMDM0NiAoZGlzYXM6IEFkZCBhIGZpZWxkIGZvciB0
YXJnZXQtZGVwZW5kYW50IGRhdGEpCjYvNyBDaGVja2luZyBjb21taXQgOWU5ODQ5MGI1NTI5IChk
aXNhczogbWlwczogQWRkIG1pY3JvbWlwcyBSNiBkaXNhc3NlbWJsZXIgLSBpbmZyYXN0cnVjdHVy
ZSBhbmQgMTYtYml0IGluc3RydWN0aW9ucykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0
ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzY6IApuZXcgZmls
ZSBtb2RlIDEwMDY0NAoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBu
YW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJwojMTI5NzogRklMRTogaW5jbHVkZS9kaXNhcy9k
aXMtYXNtLmg6Mzk1OgoraW50IHByaW50X2luc25fbWljcm9taXBzX3I2ICAgICAgKGJmZF92bWEs
IGRpc2Fzc2VtYmxlX2luZm8qKTsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTI3MiBs
aW5lcyBjaGVja2VkCgpQYXRjaCA2LzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjcvNyBD
aGVja2luZyBjb21taXQgMzM2OTgyM2YzNTk4IChkaXNhczogbWlwczogQWRkIG1pY3JvbWlwcyBS
NiBkaXNhc3NlbWJsZXIgLSAzMi1iaXQgaW5zdHJ1Y3Rpb25zKQo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTc5ODgzOTI5LTE1MTctMS1naXQtc2Vu
ZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

