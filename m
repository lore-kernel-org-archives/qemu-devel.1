Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0555DC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6C3207E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C3207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvdw-0003VW-Ur
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1itvVr-0002Na-AA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1itvVn-0005Hx-8Z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:32:18 -0500
Resent-Date: Tue, 21 Jan 2020 10:32:18 -0500
Resent-Message-Id: <E1itvVn-0005Hx-8Z@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1itvVn-0005Gw-0i
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:32:15 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579620716288281.0428383662859;
 Tue, 21 Jan 2020 07:31:56 -0800 (PST)
In-Reply-To: <1579613937-5774-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v3 0/5] target/mips: Misc MIPS fixes and improvements for
 5.0
Message-ID: <157962071517.5474.2669822731749732251@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Tue, 21 Jan 2020 07:31:56 -0800 (PST)
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc5NjEzOTM3LTU3NzQtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6
IDE1Nzk2MTM5MzctNTc3NC0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQt
cmsuY29tClN1YmplY3Q6IFtQQVRDSCB2MyAwLzVdIHRhcmdldC9taXBzOiBNaXNjIE1JUFMgZml4
ZXMgYW5kIGltcHJvdmVtZW50cyBmb3IgNS4wCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRh
Z10gICAgICAgICBwYXRjaGV3LzIwMjAwMTIxMTUxNTQzLjE4NTM4LTEtcGhpbG1kQHJlZGhhdC5j
b20gLT4gcGF0Y2hldy8yMDIwMDEyMTE1MTU0My4xODUzOC0xLXBoaWxtZEByZWRoYXQuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYWY2MGM3NiBkaXNhczogbWlwczogQWRkIG1p
Y3JvbWlwcyBSNiBkaXNhc3NlbWJsZXIKYmNiODViMSB0YXJnZXQvbWlwczogQWRkIGltcGxlbWVu
dGF0aW9uIG9mIEdJTlZUIGluc3RydWN0aW9uCjFmZmQ3ODUgdGFyZ2V0L21pcHM6IEFtZW5kIENQ
MCBXYXRjaEhpIHJlZ2lzdGVyIGltcGxlbWVudGF0aW9uCmZlZDc0YjEgdGFyZ2V0L21pcHM6IEFk
ZCBzdXBwb3J0IGZvciBNSVBTPDMyfDY0PlI2IENSQzMyIElTQQo4NjhlMjhiIHRhcmdldC9taXBz
OiBSZWN0aWZ5IGRvY3VtZW50YXRpb24gb24gZGVwcmVjYXRpbmcgcjRrIG1hY2hpbmUKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvNSBDaGVja2luZyBjb21taXQgODY4ZTI4YjE0YTU4ICh0YXJnZXQv
bWlwczogUmVjdGlmeSBkb2N1bWVudGF0aW9uIG9uIGRlcHJlY2F0aW5nIHI0ayBtYWNoaW5lKQoy
LzUgQ2hlY2tpbmcgY29tbWl0IGZlZDc0YjExNDU0MSAodGFyZ2V0L21pcHM6IEFkZCBzdXBwb3J0
IGZvciBNSVBTPDMyfDY0PlI2IENSQzMyIElTQSkKMy81IENoZWNraW5nIGNvbW1pdCAxZmZkNzg1
MjAxZjcgKHRhcmdldC9taXBzOiBBbWVuZCBDUDAgV2F0Y2hIaSByZWdpc3RlciBpbXBsZW1lbnRh
dGlvbikKNC81IENoZWNraW5nIGNvbW1pdCBiY2I4NWIxMWVjN2QgKHRhcmdldC9taXBzOiBBZGQg
aW1wbGVtZW50YXRpb24gb2YgR0lOVlQgaW5zdHJ1Y3Rpb24pCjUvNSBDaGVja2luZyBjb21taXQg
YWY2MGM3NmM3ZGIxIChkaXNhczogbWlwczogQWRkIG1pY3JvbWlwcyBSNiBkaXNhc3NlbWJsZXIp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzM0OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBzcGFj
ZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVuY3Rpb24gbmFtZSBhbmQgb3BlbiBwYXJlbnRoZXNpcyAn
KCcKIzU3MTY6IEZJTEU6IGluY2x1ZGUvZGlzYXMvZGlzLWFzbS5oOjM5MjoKK2ludCBwcmludF9p
bnNuX21pY3JvbWlwc19yNiAgICAgIChiZmRfdm1hLCBkaXNhc3NlbWJsZV9pbmZvKik7Cgp0b3Rh
bDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDU2OTMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS81IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8xNTc5NjEzOTM3LTU3NzQtMS1naXQtc2VuZC1lbWFpbC1hbGVr
c2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


