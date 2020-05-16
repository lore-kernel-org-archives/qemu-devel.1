Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B9C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 11:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5B020657
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 11:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5B020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZvTG-0003LO-CZ
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZvSf-0002tw-VD; Sat, 16 May 2020 07:58:37 -0400
Resent-Date: Sat, 16 May 2020 07:58:37 -0400
Resent-Message-Id: <E1jZvSf-0002tw-VD@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZvSd-0007cK-RZ; Sat, 16 May 2020 07:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589630300; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eEKmgMws7R7MnTdiobJi7kU+eySWJJNgDi+8wTdrAdPjKbErYAb1m2AW4w8jTlvNUEA6CkbNiX84w4weAHcNbUQKJTvnbqmCNTxz3AP+9/qPw9JRF4X1iDJoW0STzn3L9B7gEcZoI2xPD/XpPaiIf8jwtpZXfV/YGAFXxNIK9S0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589630300;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1RpvGy/NDW8qEs7dJIjLZKUU/oW61szrc+xBeXn+w+o=; 
 b=BjeiP2asYubT0tQO56T8+ybOO1nUOkrrZhrNWdZrL/3RceVP04EKhJNBnTib/ibmFcfwPmZJJrb5o6sFFXgIQaWQxL/e6TI+BJbsIn33Y/jSqanAcfU9seSputHqYc9ZSpH/RksBwoCOeiBxB8OpXuE1GIk9nLwIBEr835uhmdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589630298545149.29489680263214;
 Sat, 16 May 2020 04:58:18 -0700 (PDT)
Message-ID: <158963029685.15373.7462129698683921952@45ef0f9c86ae>
In-Reply-To: <20200516063746.18296-1-anup.patel@wdc.com>
Subject: Re: [PATCH 0/4] RISC-V multi-socket support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: anup.patel@wdc.com
Date: Sat, 16 May 2020 04:58:18 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 06:59:03
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
Cc: peter.maydell@linaro.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 anup@brainfault.org, anup.patel@wdc.com, qemu-devel@nongnu.org,
 atish.patra@wdc.com, Alistair.Francis@wdc.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNjA2Mzc0Ni4xODI5
Ni0xLWFudXAucGF0ZWxAd2RjLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MTYwNjM3NDYuMTgyOTYtMS1hbnVwLnBhdGVs
QHdkYy5jb20KU3ViamVjdDogW1BBVENIIDAvNF0gUklTQy1WIG11bHRpLXNvY2tldCBzdXBwb3J0
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo5MDMxNzU1IGh3L3Jpc2N2OiB2aXJ0OiBBbGxvdyBjcmVhdGlu
ZyBtdWx0aXBsZSBzb2NrZXRzCjY3ZTk1NDcgaHcvcmlzY3Y6IEFsbG93IGNyZWF0aW5nIG11bHRp
cGxlIGluc3RhbmNlcyBvZiBQTElDCjI5OTlhMTEgaHcvcmlzY3Y6IHNwaWtlOiBBbGxvdyBjcmVh
dGluZyBtdWx0aXBsZSBzb2NrZXRzCmI1NjNhODAgaHcvcmlzY3Y6IEFsbG93IGNyZWF0aW5nIG11
bHRpcGxlIGluc3RhbmNlcyBvZiBDTElOVAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS80IENoZWNr
aW5nIGNvbW1pdCBiNTYzYTgwODlhN2EgKGh3L3Jpc2N2OiBBbGxvdyBjcmVhdGluZyBtdWx0aXBs
ZSBpbnN0YW5jZXMgb2YgQ0xJTlQpCjIvNCBDaGVja2luZyBjb21taXQgMjk5OWExMTAxZjI3ICho
dy9yaXNjdjogc3Bpa2U6IEFsbG93IGNyZWF0aW5nIG11bHRpcGxlIHNvY2tldHMpCkVSUk9SOiBi
cmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzIw
MjogRklMRTogaHcvcmlzY3Yvc3Bpa2UuYzoxOTQ6CisgICAgaWYgKChzbXBfY3B1cyAvIHMtPm51
bV9zb2NzKSA8IFNQSUtFX0NQVVNfUEVSX1NPQ0tFVF9NSU4pClsuLi5dCgpFUlJPUjogYnJhY2Vz
IHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMyMDY6IEZJ
TEU6IGh3L3Jpc2N2L3NwaWtlLmM6MTk4OgorICAgIGlmIChTUElLRV9TT0NLRVRTX01BWCA8IHMt
Pm51bV9zb2NzKQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwg
YXJtcyBvZiB0aGlzIHN0YXRlbWVudAojMjEyOiBGSUxFOiBody9yaXNjdi9zcGlrZS5jOjIwNDoK
KyAgICAgICAgaWYgKGkgPT0gKHMtPm51bV9zb2NzIC0gMSkpClsuLi5dCisgICAgICAgIGVsc2UK
Wy4uLl0KCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyNDg6IEZJTEU6IGh3L3Jp
c2N2L3NwaWtlLmM6Mjk5OgorICAgIGh0aWZfbW1faW5pdChzeXN0ZW1fbWVtb3J5LCBtYXNrX3Jv
bSwgJnMtPnNvY1swXS5oYXJ0c1swXS5lbnYsIHNlcmlhbF9oZCgwKSk7CgpXQVJOSU5HOiBsaW5l
IG92ZXIgODAgY2hhcmFjdGVycwojMjY2OiBGSUxFOiBody9yaXNjdi9zcGlrZS5jOjMyMjoKKyAg
ICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QobWFjaGluZSksICJzb2MiLCAmcy0+c29j
WzBdLCBzaXplb2Yocy0+c29jWzBdKSwKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJz
CiMyODQ6IEZJTEU6IGh3L3Jpc2N2L3NwaWtlLmM6Mzg2OgorICAgIGh0aWZfbW1faW5pdChzeXN0
ZW1fbWVtb3J5LCBtYXNrX3JvbSwgJnMtPnNvY1swXS5oYXJ0c1swXS5lbnYsIHNlcmlhbF9oZCgw
KSk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzAyOiBGSUxFOiBody9yaXNj
di9zcGlrZS5jOjQxNDoKKyAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QobWFjaGlu
ZSksICJzb2MiLCAmcy0+c29jWzBdLCBzaXplb2Yocy0+c29jWzBdKSwKCldBUk5JTkc6IGxpbmUg
b3ZlciA4MCBjaGFyYWN0ZXJzCiMzMjk6IEZJTEU6IGh3L3Jpc2N2L3NwaWtlLmM6NDk3OgorICAg
IGh0aWZfbW1faW5pdChzeXN0ZW1fbWVtb3J5LCBtYXNrX3JvbSwgJnMtPnNvY1swXS5oYXJ0c1sw
XS5lbnYsIHNlcmlhbF9oZCgwKSk7Cgp0b3RhbDogMyBlcnJvcnMsIDUgd2FybmluZ3MsIDMyMiBs
aW5lcyBjaGVja2VkCgpQYXRjaCAyLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvNCBD
aGVja2luZyBjb21taXQgNjdlOTU0NzdmY2JlIChody9yaXNjdjogQWxsb3cgY3JlYXRpbmcgbXVs
dGlwbGUgaW5zdGFuY2VzIG9mIFBMSUMpCjQvNCBDaGVja2luZyBjb21taXQgOTAzMTc1NTFkOWRh
IChody9yaXNjdjogdmlydDogQWxsb3cgY3JlYXRpbmcgbXVsdGlwbGUgc29ja2V0cykKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpWeFYpCiMzMjogRklMRTogaHcv
cmlzY3YvdmlydC5jOjYzOgorICAgIFtWSVJUX1BMSUNdID0gICAgICAgIHsgIDB4YzAwMDAwMCwg
VklSVF9QTElDX1NJWkUoVklSVF9DUFVTX01BWCoyKSB9LAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyOTU6IEZJTEU6IGh3L3Jpc2N2L3ZpcnQuYzozNDM6
CisgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5hbWUsICJpbnRlcnJ1cHQtcGFy
ZW50IiwgcGxpY192aXJ0aW9fcGhhbmRsZSk7CgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3Nh
cnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM0Nzg6IEZJTEU6IGh3L3Jpc2N2L3Zp
cnQuYzo0OTc6CisgICAgaWYgKChzbXBfY3B1cyAvIHMtPm51bV9zb2NzKSA8IFZJUlRfQ1BVU19Q
RVJfU09DS0VUX01JTikKWy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3Ig
YWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzQ4MjogRklMRTogaHcvcmlzY3YvdmlydC5jOjUw
MToKKyAgICBpZiAoVklSVF9TT0NLRVRTX01BWCA8IHMtPm51bV9zb2NzKQpbLi4uXQoKRVJST1I6
IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAoj
NDk3OiBGSUxFOiBody9yaXNjdi92aXJ0LmM6NTA4OgorICAgICAgICBpZiAoaSA9PSAocy0+bnVt
X3NvY3MgLSAxKSkKWy4uLl0KKyAgICAgICAgZWxzZQpbLi4uXQoKdG90YWw6IDQgZXJyb3JzLCAx
IHdhcm5pbmdzLCA2MzggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDUxNjA2Mzc0Ni4xODI5Ni0xLWFudXAucGF0ZWxAd2RjLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

