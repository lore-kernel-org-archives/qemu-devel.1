Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC660C3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E42420857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E42420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Wot-0002I3-OQ
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 22:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j3Wo0-0001bK-Uz
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j3Wnz-0006Pm-83
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:10:44 -0500
Resent-Date: Sun, 16 Feb 2020 22:10:44 -0500
Resent-Message-Id: <E1j3Wnz-0006Pm-83@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j3Wnz-0006Mw-0Q
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:10:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581909038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C5zjxCOejxnC7xPgkE3VE14KRi5Y7b4Qx708OJch0jMYVB6cTolWmbQsl9JH546Yci4Vub3UR0IVD4hx1B+bXhWEkMa2piIf8TRoSzF5ZvS6GkAsuSYl3UciHy3GpqmCvawC6nMZ2ct4Oaq77b/vEmvwGRfCv5eVna12MqFM/po=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581909038;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GTtKibUKOkRoKJAENZRBty/aFImimokhFgpWwbsFoYg=; 
 b=a4qtremg1rblDyenX8svz+0UzZnogMstYWhXl6EMiQN4ePnb9Esx0S3UVi5tOh3a+VtmbnotA/Kok7vHh5rx1aNScbG4Btbt/P49zOgR7U+nCw6/7s/nQtFyz7TJhJZP2Tj7EMAYenhkvdlru502rOGvYZ9wEfUMD+iLZjooWpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581909036175930.4571141855496;
 Sun, 16 Feb 2020 19:10:36 -0800 (PST)
In-Reply-To: <20200217025957.12031-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 0/4] tcg: Fix for Bug 1863508
Message-ID: <158190903522.4691.6682279640266372624@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sun, 16 Feb 2020 19:10:36 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNzAyNTk1Ny4xMjAz
MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzRdIHRjZzogRml4IGZvciBC
dWcgMTg2MzUwOApNZXNzYWdlLWlkOiAyMDIwMDIxNzAyNTk1Ny4xMjAzMS0xLXJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmcKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDIxNzAyNTk1Ny4xMjAzMS0xLXJpY2hh
cmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDIwMDIxNzAyNTk1Ny4xMjAzMS0x
LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0JwpkY2RlNWE0IHRjZzogUmVtb3ZlIHRjZy1ydW50aW1lLWd2ZWMuYyBET19DTVAwCmQzZDcy
OTcgdGNnOiBUaWR5IHRjZy1ydW50aW1lLWd2ZWMuYyBEVVAqCjE5MDNjYzggdGNnOiBUaWR5IHRj
Zy1ydW50aW1lLWd2ZWMuYyB0eXBlcwpkNTdmNjJmIHRjZzogUmVtb3ZlIENPTkZJR19WRUNUT1Ix
NgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCBkNTdmNjJmNWM2ZDQg
KHRjZzogUmVtb3ZlIENPTkZJR19WRUNUT1IxNikKMi80IENoZWNraW5nIGNvbW1pdCAxOTAzY2M4
NTZiODcgKHRjZzogVGlkeSB0Y2ctcnVudGltZS1ndmVjLmMgdHlwZXMpCkVSUk9SOiBzcGFjZXMg
cmVxdWlyZWQgYXJvdW5kIHRoYXQgJyYnIChjdHg6V3hPKQojNDQxOiBGSUxFOiBhY2NlbC90Y2cv
dGNnLXJ1bnRpbWUtZ3ZlYy5jOjUxMDoKKyAgICAgICAgKih1aW50NjRfdCAqKShkICsgaSkgPSAq
KHVpbnQ2NF90ICopKGEgKyBpKSAmfiAqKHVpbnQ2NF90ICopKGIgKyBpKTsKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2Ug
cHJvaGliaXRlZCBhZnRlciB0aGF0ICd+JyAoY3R4Ok94VykKIzQ0MTogRklMRTogYWNjZWwvdGNn
L3RjZy1ydW50aW1lLWd2ZWMuYzo1MTA6CisgICAgICAgICoodWludDY0X3QgKikoZCArIGkpID0g
Kih1aW50NjRfdCAqKShhICsgaSkgJn4gKih1aW50NjRfdCAqKShiICsgaSk7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFj
ZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJ3wnIChjdHg6V3hPKQojNDUyOiBGSUxFOiBhY2NlbC90
Y2cvdGNnLXJ1bnRpbWUtZ3ZlYy5jOjUyMToKKyAgICAgICAgKih1aW50NjRfdCAqKShkICsgaSkg
PSAqKHVpbnQ2NF90ICopKGEgKyBpKSB8fiAqKHVpbnQ2NF90ICopKGIgKyBpKTsKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3Bh
Y2UgcHJvaGliaXRlZCBhZnRlciB0aGF0ICd+JyAoY3R4Ok94VykKIzQ1MjogRklMRTogYWNjZWwv
dGNnL3RjZy1ydW50aW1lLWd2ZWMuYzo1MjE6CisgICAgICAgICoodWludDY0X3QgKikoZCArIGkp
ID0gKih1aW50NjRfdCAqKShhICsgaSkgfH4gKih1aW50NjRfdCAqKShiICsgaSk7CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBz
cGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz09JyAoY3R4Old4QikKIzY3NjogRklMRTogYWNj
ZWwvdGNnL3RjZy1ydW50aW1lLWd2ZWMuYzo4OTc6CisgICAgRE9fQ01QMShndmVjX2VxIyNTWiwg
dWludCMjU1ojI190LCA9PSkgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnIT0nIChjdHg6V3hC
KQojNjc3OiBGSUxFOiBhY2NlbC90Y2cvdGNnLXJ1bnRpbWUtZ3ZlYy5jOjg5ODoKKyAgICBET19D
TVAxKGd2ZWNfbmUjI1NaLCB1aW50IyNTWiMjX3QsICE9KSAgICBcCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0
aGF0ICc8JyAoY3R4Old4QikKIzY3ODogRklMRTogYWNjZWwvdGNnL3RjZy1ydW50aW1lLWd2ZWMu
Yzo4OTk6CisgICAgRE9fQ01QMShndmVjX2x0IyNTWiwgaW50IyNTWiMjX3QsIDwpICAgICAgXAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICc8PScgKGN0eDpXeEIpCiM2Nzk6IEZJTEU6IGFjY2VsL3RjZy90
Y2ctcnVudGltZS1ndmVjLmM6OTAwOgorICAgIERPX0NNUDEoZ3ZlY19sZSMjU1osIGludCMjU1oj
I190LCA8PSkgICAgIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoK
RVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPCcgKGN0eDpXeEIpCiM2ODA6IEZJ
TEU6IGFjY2VsL3RjZy90Y2ctcnVudGltZS1ndmVjLmM6OTAxOgorICAgIERPX0NNUDEoZ3ZlY19s
dHUjI1NaLCB1aW50IyNTWiMjX3QsIDwpICAgIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc8PScg
KGN0eDpXeEIpCiM2ODE6IEZJTEU6IGFjY2VsL3RjZy90Y2ctcnVudGltZS1ndmVjLmM6OTAyOgor
ICAgIERPX0NNUDEoZ3ZlY19sZXUjI1NaLCB1aW50IyNTWiMjX3QsIDw9KQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxMCBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDYzMCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjMvNCBDaGVja2luZyBjb21taXQgZDNkNzI5N2NmZmM4ICh0Y2c6IFRpZHkgdGNnLXJ1bnRp
bWUtZ3ZlYy5jIERVUCopCjQvNCBDaGVja2luZyBjb21taXQgZGNkZTVhNDYxYTI4ICh0Y2c6IFJl
bW92ZSB0Y2ctcnVudGltZS1ndmVjLmMgRE9fQ01QMCkKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBh
cm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMzMDogRklMRTogYWNjZWwvdGNnL3RjZy1ydW50aW1l
LWd2ZWMuYzo4Njk6CisgICAgICAgICooVFlQRSAqKShkICsgaSkgPSAtKCooVFlQRSAqKShhICsg
aSkgT1AgKihUWVBFICopKGIgKyBpKSk7ICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAyMyBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
MjE3MDI1OTU3LjEyMDMxLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

