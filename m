Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7423AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492772075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492772075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jooJV-0007uR-KE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jooIy-0007V2-Gk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:22:08 -0400
Resent-Date: Fri, 26 Jun 2020 09:22:08 -0400
Resent-Message-Id: <E1jooIy-0007V2-Gk@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jooIv-00028O-Pj
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593177711; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J7QA6s9/IaPYbVdR/v34Lwn5h3yME9k+1ibrWl99qWdSkVGPIXrsM/z29B+aqoqKIuwxIDQMhxlYvdTWMc2WUEJHEpRpM2rHs23qbT6oah6PH4FD3eG8JwSWOgLNimZWTGdtdQ6r6sKcm4Dz1+9rrJAB2UJuTt1xcesHBBFvkKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593177711;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=8rEPPOPqhQHEYLCXZXzImH/r57d6+jqzeMwd82GVMl8=; 
 b=NPGYLzBCjw59ZvhJ+Xln0/2Jfhz9SNcxeUzQ9uZ2ZNrsuYIL5FLfCTARMTUT1ZxqMdErpyF5AFvxvVtNvV2bY6E+atYPh+PobCBUWbQ9r0h1PUcOb6Fyh39VWE1UZ13YXhyj18Kq/vCiOk2VSyUgY3cOGbcLGOvVqToxUdiWPTo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593177709511290.56102179129005;
 Fri, 26 Jun 2020 06:21:49 -0700 (PDT)
Message-ID: <159317770833.28361.1220547955654360271@d1fd068a5071>
Subject: Re: [PATCH v3 0/2] linux-user: support of semtimedop syscall 
In-Reply-To: <20200626124612.58593-1-mkysel@tachyum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mkysel@tachyum.com
Date: Fri, 26 Jun 2020 06:21:49 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 09:22:02
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
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu,
 mkysel@tachyum.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNjEyNDYxMi41ODU5
My0xLW1reXNlbEB0YWNoeXVtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYzIDAvMl0gbGludXgtdXNlcjogc3VwcG9ydCBv
ZiBzZW10aW1lZG9wIHN5c2NhbGwgClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDYyNjEy
NDYxMi41ODU5My0xLW1reXNlbEB0YWNoeXVtLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgNjEx
YWM2My4uMTBmN2ZmYSAgbWFzdGVyICAgICAtPiBtYXN0ZXIKICogW25ldyB0YWddICAgICAgICAg
cGF0Y2hldy8xNTkzMTc3MjIwLTI4MTQzLTEtZ2l0LXNlbmQtZW1haWwtYm1lbmcuY25AZ21haWwu
Y29tIC0+IHBhdGNoZXcvMTU5MzE3NzIyMC0yODE0My0xLWdpdC1zZW5kLWVtYWlsLWJtZW5nLmNu
QGdtYWlsLmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwNjI1MTg0ODM4LjI4
MTcyLTEtcGhpbG1kQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDYyNTE4NDgzOC4yODE3Mi0x
LXBoaWxtZEByZWRoYXQuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA2MjYw
MzMxNDQuNzkwMDk4LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIw
MjAwNjI2MDMzMTQ0Ljc5MDA5OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKIC0gW3Rh
ZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDYyNjA5MjMxNy4zODc1LTEtbWFyay5jYXZlLWF5
bGFuZEBpbGFuZGUuY28udWsgLT4gcGF0Y2hldy8yMDIwMDYyNjA5MjMxNy4zODc1LTEtbWFyay5j
YXZlLWF5bGFuZEBpbGFuZGUuY28udWsKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIw
MDYyNjEyNDYxMi41ODU5My0xLW1reXNlbEB0YWNoeXVtLmNvbSAtPiBwYXRjaGV3LzIwMjAwNjI2
MTI0NjEyLjU4NTkzLTEtbWt5c2VsQHRhY2h5dW0uY29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMjAyMDA2MjYxMzA2NTguNzY0OTgtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20gLT4g
cGF0Y2hldy8yMDIwMDYyNjEzMDY1OC43NjQ5OC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbQog
LSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3L2NvdmVyLjE1OTIzMTUyMjYuZ2l0LmJhbGF0b25A
ZWlrLmJtZS5odSAtPiBwYXRjaGV3L2NvdmVyLjE1OTIzMTUyMjYuZ2l0LmJhbGF0b25AZWlrLmJt
ZS5odQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjliNmZiMTYgbGludXgtdXNlcjog
c3VwcG9ydCBvZiBzZW10aW1lZG9wIHN5c2NhbGwKMjMwYTNjYSBsaW51eC11c2VyOiByZWZhY3Rv
ciBpcGMgc3lzY2FsbAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCAy
MzBhM2NhZGFhYzQgKGxpbnV4LXVzZXI6IHJlZmFjdG9yIGlwYyBzeXNjYWxsKQpXQVJOSU5HOiBh
cmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojMjA6IEZJTEU6
IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjgxNzoKKyNpZmRlZiBfX3MzOTB4X18KCldBUk5JTkc6IGFy
Y2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiMzNTogRklMRTog
bGludXgtdXNlci9zeXNjYWxsLmM6NDA2MToKKyNpZmRlZiBfX3MzOTB4X18KCldBUk5JTkc6IGFy
Y2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM0OTogRklMRTog
bGludXgtdXNlci9zeXNjYWxsLmM6NDA3NjoKKyNpZmRlZiBfX05SX2lwYwoKV0FSTklORzogYXJj
aGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzUwOiBGSUxFOiBs
aW51eC11c2VyL3N5c2NhbGwuYzo0MDc3OgorI2lmIGRlZmluZWQoX19zcGFyY19fKQoKRVJST1I6
IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRo
ZXNpcwojNTI6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjQwNzk6CisjZGVmaW5lIE1TR1JD
Vl9BUkdTKF9fbXNncCwgX19tc2d0eXApIF9fbXNncCwgX19tc2d0eXAKCkVSUk9SOiBNYWNyb3Mg
d2l0aCBjb21wbGV4IHZhbHVlcyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMKIzU4
OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzo0MDg1OgorI2RlZmluZSBNU0dSQ1ZfQVJHUyhf
X21zZ3AsIF9fbXNndHlwKSBcCisgICAgKChsb25nIGludFtdKXsobG9uZyBpbnQpX19tc2dwLCBf
X21zZ3R5cH0pLCAwCgp0b3RhbDogMiBlcnJvcnMsIDQgd2FybmluZ3MsIDU1IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi8yIENoZWNraW5nIGNv
bW1pdCA5YjZmYjE2ZDViYjcgKGxpbnV4LXVzZXI6IHN1cHBvcnQgb2Ygc2VtdGltZWRvcCBzeXNj
YWxsKQpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZv
aWRlZAojNDA6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjM4OTE6CisjaWZkZWYgX19zMzkw
eF9fCgpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2Vk
IGluIHBhcmVudGhlc2lzCiM0MTogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6Mzg5MjoKKyNk
ZWZpbmUgU0VNVElNRURPUF9JUENfQVJHUyhfX25zb3BzLCBfX3NvcHMsIF9fdGltZW91dCkgXAor
ICAoX19uc29wcyksIChfX3RpbWVvdXQpLCAoX19zb3BzKQoKRVJST1I6IE1hY3JvcyB3aXRoIGNv
bXBsZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNpcwojNDQ6IEZJTEU6
IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjM4OTU6CisjZGVmaW5lIFNFTVRJTUVET1BfSVBDX0FSR1Mo
X19uc29wcywgX19zb3BzLCBfX3RpbWVvdXQpIFwKKyAgKF9fbnNvcHMpLCAwLCAoX19zb3BzKSwg
KF9fdGltZW91dCkKCnRvdGFsOiAyIGVycm9ycywgMSB3YXJuaW5ncywgOTggbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYyNjEyNDYxMi41ODU5My0x
LW1reXNlbEB0YWNoeXVtLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

