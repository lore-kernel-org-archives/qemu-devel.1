Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91512071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91512071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3RB-0007sr-VY
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:12:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iv3PJ-00057r-Pv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iv3PI-00073k-6c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:10:13 -0500
Resent-Date: Fri, 24 Jan 2020 13:10:13 -0500
Resent-Message-Id: <E1iv3PI-00073k-6c@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iv3PH-00070S-V7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:10:12 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157988937975631.625457356730863;
 Fri, 24 Jan 2020 10:09:39 -0800 (PST)
In-Reply-To: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v4 0/7] target/mips: Misc MIPS fixes and improvements for
 5.0
Message-ID: <157988937854.23531.18012403747812344539@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 24 Jan 2020 10:09:39 -0800 (PST)
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
RU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplYTUxOGNhIGRpc2FzOiBt
aXBzOiBBZGQgbWljcm9taXBzIFI2IGRpc2Fzc2VtYmxlciAtIDMyLWJpdCBpbnN0cnVjdGlvbnMK
NDExZmI5OCBkaXNhczogbWlwczogQWRkIG1pY3JvbWlwcyBSNiBkaXNhc3NlbWJsZXIgLSBpbmZy
YXN0cnVjdHVyZSBhbmQgMTYtYml0IGluc3RydWN0aW9ucwoyMTE1NmI1IGRpc2FzOiBBZGQgYSBm
aWVsZCBmb3IgdGFyZ2V0LWRlcGVuZGFudCBkYXRhCmUxZjc4YjQgdGFyZ2V0L21pcHM6IEFkZCBp
bXBsZW1lbnRhdGlvbiBvZiBHSU5WVCBpbnN0cnVjdGlvbgo3MWNkYTBiIHRhcmdldC9taXBzOiBB
bWVuZCBDUDAgV2F0Y2hIaSByZWdpc3RlciBpbXBsZW1lbnRhdGlvbgo0YmE1ZDViIHRhcmdldC9t
aXBzOiBBZGQgc3VwcG9ydCBmb3IgTUlQUzwzMnw2ND5SNiBDUkMzMiBJU0EKMWExZDk2NyB0YXJn
ZXQvbWlwczogUmVjdGlmeSBkb2N1bWVudGF0aW9uIG9uIGRlcHJlY2F0aW5nIHI0ayBtYWNoaW5l
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzcgQ2hlY2tpbmcgY29tbWl0IDFhMWQ5NjcyODgxOCAo
dGFyZ2V0L21pcHM6IFJlY3RpZnkgZG9jdW1lbnRhdGlvbiBvbiBkZXByZWNhdGluZyByNGsgbWFj
aGluZSkKMi83IENoZWNraW5nIGNvbW1pdCA0YmE1ZDViYTg5YjYgKHRhcmdldC9taXBzOiBBZGQg
c3VwcG9ydCBmb3IgTUlQUzwzMnw2ND5SNiBDUkMzMiBJU0EpCjMvNyBDaGVja2luZyBjb21taXQg
NzFjZGEwYjFlZGQ3ICh0YXJnZXQvbWlwczogQW1lbmQgQ1AwIFdhdGNoSGkgcmVnaXN0ZXIgaW1w
bGVtZW50YXRpb24pCjQvNyBDaGVja2luZyBjb21taXQgZTFmNzhiNDE4NjBiICh0YXJnZXQvbWlw
czogQWRkIGltcGxlbWVudGF0aW9uIG9mIEdJTlZUIGluc3RydWN0aW9uKQo1LzcgQ2hlY2tpbmcg
Y29tbWl0IDIxMTU2YjUwZGQ3MiAoZGlzYXM6IEFkZCBhIGZpZWxkIGZvciB0YXJnZXQtZGVwZW5k
YW50IGRhdGEpCjYvNyBDaGVja2luZyBjb21taXQgNDExZmI5ODE3OTE3IChkaXNhczogbWlwczog
QWRkIG1pY3JvbWlwcyBSNiBkaXNhc3NlbWJsZXIgLSBpbmZyYXN0cnVjdHVyZSBhbmQgMTYtYml0
IGluc3RydWN0aW9ucykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwg
ZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzY6IApuZXcgZmlsZSBtb2RlIDEwMDY0
NAoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVu
IHBhcmVudGhlc2lzICcoJwojMTI5NzogRklMRTogaW5jbHVkZS9kaXNhcy9kaXMtYXNtLmg6Mzk1
OgoraW50IHByaW50X2luc25fbWljcm9taXBzX3I2ICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxl
X2luZm8qKTsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTI3MiBsaW5lcyBjaGVja2Vk
CgpQYXRjaCA2LzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjcvNyBDaGVja2luZyBjb21t
aXQgZWE1MThjYTI2ZjBkIChkaXNhczogbWlwczogQWRkIG1pY3JvbWlwcyBSNiBkaXNhc3NlbWJs
ZXIgLSAzMi1iaXQgaW5zdHJ1Y3Rpb25zKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8xNTc5ODgzOTI5LTE1MTctMS1naXQtc2VuZC1lbWFpbC1hbGVr
c2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

