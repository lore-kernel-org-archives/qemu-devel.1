Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47680C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAAD20781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAAD20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqg8M-00038T-Bq
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqg2i-0003dY-NG
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:57:04 -0400
Resent-Date: Wed, 01 Jul 2020 12:57:04 -0400
Resent-Message-Id: <E1jqg2i-0003dY-NG@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqg2g-0006E2-MB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593622616; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JcJXe8oNSBjCSzEUT/hejLgs8pHGACgqfvzZ0Ks4WgCTH6Fahx1mjPPBzAwgfzTOgpn9yfcL4F8BAkgRHHrtepFsTyKLJI+e+ed7CaAPv2aY0aSFBp9fc9Gwrg4mLT06ef302khnUrcZcrZtajOIsWal5jwWudB6x4VTQy2sQNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593622616;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=B1fkLU8EWbw7P+99//4UaeuNQ7VNDDYLX7S2/gdN76s=; 
 b=JnrweWOETroA459BOsZ5DP7S30o2dinNtpFFrjGZbFBZYKWscIKVlKIEI+opLfwsK5OJgTiu5xeD50oMI7omIB0tJpxMEE32UmTJSekUVLdwEtfxRwrkqMFNVjafs1vdLDoXsE1oivy354aV1Y33WNXCElhJpMKoeQB0zQwqC70=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15936226148571007.960573115331;
 Wed, 1 Jul 2020 09:56:54 -0700 (PDT)
Message-ID: <159362261393.26405.8499407454401124332@d1fd068a5071>
Subject: Re: [PATCH  v2 0/3] some docs (booting, mttcg, icount)
In-Reply-To: <20200701161153.30988-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 1 Jul 2020 09:56:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:55:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMTE2MTE1My4zMDk4
OC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAgdjIgMC8zXSBzb21lIGRvY3MgKGJvb3Rp
bmcsIG10dGNnLCBpY291bnQpClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcwMTE2MTE1
My4zMDk4OC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjBjNjkzMyBkb2NzL2RldmVs
OiBhZGQgc29tZSBub3RlcyBvbiB0Y2ctaWNvdW50IGZvciBkZXZlbG9wZXJzCmI0ZWQ2NmIgZG9j
cy9kZXZlbDogY29udmVydCBhbmQgdXBkYXRlIE1UVENHIGRlc2lnbiBkb2N1bWVudAoyYzljMjg5
IGRvY3MvYm9vdGluZy5yc3Q6IHN0YXJ0IGRvY3VtZW50aW5nIHRoZSBib290IHByb2Nlc3MKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgMmM5YzI4OWFhNzdjIChkb2Nz
L2Jvb3RpbmcucnN0OiBzdGFydCBkb2N1bWVudGluZyB0aGUgYm9vdCBwcm9jZXNzKQpXQVJOSU5H
OiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQg
dXBkYXRpbmc/CiMyNDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEg
d2FybmluZ3MsIDE2NiBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzMgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KMi8zIENoZWNraW5nIGNvbW1pdCBiNGVkNjZiNjUwZWYgKGRvY3MvZGV2ZWw6IGNv
bnZlcnQgYW5kIHVwZGF0ZSBNVFRDRyBkZXNpZ24gZG9jdW1lbnQpCldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
IzI3OiAKcmVuYW1lIGZyb20gZG9jcy9kZXZlbC9tdWx0aS10aHJlYWQtdGNnLnR4dAoKdG90YWw6
IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA5NyBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzMgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KMy8zIENoZWNraW5nIGNvbW1pdCBmMGM2OTMzZDM0YTUgKGRv
Y3MvZGV2ZWw6IGFkZCBzb21lIG5vdGVzIG9uIHRjZy1pY291bnQgZm9yIGRldmVsb3BlcnMpCldB
Uk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMg
bmVlZCB1cGRhdGluZz8KIzMzOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiB0cmFpbGlu
ZyB3aGl0ZXNwYWNlCiMxMDc6IEZJTEU6IGRvY3MvZGV2ZWwvdGNnLWljb3VudC5yc3Q6NzA6Cisg
ICQKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxMDg6IEZJTEU6IGRvY3MvZGV2ZWwvdGNn
LWljb3VudC5yc3Q6NzE6CisuLiBbMV0gc29tZXRpbWVzIHR3byBpbnN0cnVjdGlvbnMgaWYgZGVh
bGluZyB3aXRoIGRlbGF5IHNsb3RzICAkCgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMTIz
OiBGSUxFOiBkb2NzL2RldmVsL3RjZy1pY291bnQucnN0Ojg2OgorICAgJAoKdG90YWw6IDMgZXJy
b3JzLCAxIHdhcm5pbmdzLCA5NiBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNzAxMTYxMTUzLjMwOTg4LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

