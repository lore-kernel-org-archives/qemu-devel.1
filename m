Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0CFC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CA620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CA620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELoc-0000Ax-Vo
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jELjk-00015K-Fh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jELji-0003mg-FM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:35:04 -0400
Resent-Date: Tue, 17 Mar 2020 19:35:04 -0400
Resent-Message-Id: <E1jELji-0003mg-FM@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jELji-0003aV-6G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:35:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584488095; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=K+qe3na8xFRCmb0FwgypdwZ474Espt5FUXGQEOZOqKWpAyuB7lZR+pvdeP5T4iGOMsHPUQHJbdCga4srDnli11eR3cWzzcbcw7hKz9GKiBwxwbgCwnZz+AF93ulQ/Xw815kkHIUC5v4Pvwltg9sMbslPtUFMMt/LT3yCpzNZfq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584488095;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hgdklTOXHefriUvfKONHi7QhGxVJby3qEs2p0WfwN8o=; 
 b=CaWWxaOistm1VPs8X8DkhquixzeJHEowE5DHmINg6rZ5l9YqlggSWMxGerh3PsbeWTZjhbwrlVjinbI3ZEntvQFXWkyJcqYDwOEbAVlAYEAy7Wjlg+KXGlOwiXq86Yoi2R+KgkE0iMT3RIbckCKZLflblxHlDp3xe91kOHziiXE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584488093460712.9622064859693;
 Tue, 17 Mar 2020 16:34:53 -0700 (PDT)
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
Subject: Re: [PULL 0/5] tcg patch queue
Message-ID: <158448809242.25478.469157179204454235@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 17 Mar 2020 16:34:53 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxNzE5MDAxMy4yNTAz
Ni0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIDAvNV0gdGNnIHBhdGNoIHF1ZXVl
Ck1lc3NhZ2UtaWQ6IDIwMjAwMzE3MTkwMDEzLjI1MDM2LTEtcmljaGFyZC5oZW5kZXJzb25AbGlu
YXJvLm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODNlYWFkZCB0Y2c6IFJlbW92ZSB0Y2ctcnVudGlt
ZS1ndmVjLmMgRE9fQ01QMAplMDAwOGE1IHRjZzogVGlkeSB0Y2ctcnVudGltZS1ndmVjLmMgRFVQ
Kgo4ZTdkNmQzIHRjZzogVGlkeSB0Y2ctcnVudGltZS1ndmVjLmMgdHlwZXMKNDRiZDNjNSB0Y2c6
IFJlbW92ZSBDT05GSUdfVkVDVE9SMTYKZjQxMGMyOSB0Y2cvaTM4NjogQm91bmQgc2hpZnQgY291
bnQgZXhwYW5kaW5nIHNhcmlfdmVjCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcg
Y29tbWl0IGY0MTBjMjk2Yjc3NCAodGNnL2kzODY6IEJvdW5kIHNoaWZ0IGNvdW50IGV4cGFuZGlu
ZyBzYXJpX3ZlYykKMi81IENoZWNraW5nIGNvbW1pdCA0NGJkM2M1ZmJiZGIgKHRjZzogUmVtb3Zl
IENPTkZJR19WRUNUT1IxNikKMy81IENoZWNraW5nIGNvbW1pdCA4ZTdkNmQzOWM1MjkgKHRjZzog
VGlkeSB0Y2ctcnVudGltZS1ndmVjLmMgdHlwZXMpCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJv
dW5kIHRoYXQgJyYnIChjdHg6V3hPKQojNDQyOiBGSUxFOiBhY2NlbC90Y2cvdGNnLXJ1bnRpbWUt
Z3ZlYy5jOjUxMDoKKyAgICAgICAgKih1aW50NjRfdCAqKShkICsgaSkgPSAqKHVpbnQ2NF90ICop
KGEgKyBpKSAmfiAqKHVpbnQ2NF90ICopKGIgKyBpKTsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBh
ZnRlciB0aGF0ICd+JyAoY3R4Ok94VykKIzQ0MjogRklMRTogYWNjZWwvdGNnL3RjZy1ydW50aW1l
LWd2ZWMuYzo1MTA6CisgICAgICAgICoodWludDY0X3QgKikoZCArIGkpID0gKih1aW50NjRfdCAq
KShhICsgaSkgJn4gKih1aW50NjRfdCAqKShiICsgaSk7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQg
YXJvdW5kIHRoYXQgJ3wnIChjdHg6V3hPKQojNDUzOiBGSUxFOiBhY2NlbC90Y2cvdGNnLXJ1bnRp
bWUtZ3ZlYy5jOjUyMToKKyAgICAgICAgKih1aW50NjRfdCAqKShkICsgaSkgPSAqKHVpbnQ2NF90
ICopKGEgKyBpKSB8fiAqKHVpbnQ2NF90ICopKGIgKyBpKTsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcHJvaGliaXRl
ZCBhZnRlciB0aGF0ICd+JyAoY3R4Ok94VykKIzQ1MzogRklMRTogYWNjZWwvdGNnL3RjZy1ydW50
aW1lLWd2ZWMuYzo1MjE6CisgICAgICAgICoodWludDY0X3QgKikoZCArIGkpID0gKih1aW50NjRf
dCAqKShhICsgaSkgfH4gKih1aW50NjRfdCAqKShiICsgaSk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWly
ZWQgYXJvdW5kIHRoYXQgJz09JyAoY3R4Old4QikKIzY3NzogRklMRTogYWNjZWwvdGNnL3RjZy1y
dW50aW1lLWd2ZWMuYzo4OTc6CisgICAgRE9fQ01QMShndmVjX2VxIyNTWiwgdWludCMjU1ojI190
LCA9PSkgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJS
T1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnIT0nIChjdHg6V3hCKQojNjc4OiBGSUxF
OiBhY2NlbC90Y2cvdGNnLXJ1bnRpbWUtZ3ZlYy5jOjg5ODoKKyAgICBET19DTVAxKGd2ZWNfbmUj
I1NaLCB1aW50IyNTWiMjX3QsICE9KSAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc8JyAoY3R4
Old4QikKIzY3OTogRklMRTogYWNjZWwvdGNnL3RjZy1ydW50aW1lLWd2ZWMuYzo4OTk6CisgICAg
RE9fQ01QMShndmVjX2x0IyNTWiwgaW50IyNTWiMjX3QsIDwpICAgICAgXAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3Vu
ZCB0aGF0ICc8PScgKGN0eDpXeEIpCiM2ODA6IEZJTEU6IGFjY2VsL3RjZy90Y2ctcnVudGltZS1n
dmVjLmM6OTAwOgorICAgIERPX0NNUDEoZ3ZlY19sZSMjU1osIGludCMjU1ojI190LCA8PSkgICAg
IFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNl
cyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPCcgKGN0eDpXeEIpCiM2ODE6IEZJTEU6IGFjY2VsL3Rj
Zy90Y2ctcnVudGltZS1ndmVjLmM6OTAxOgorICAgIERPX0NNUDEoZ3ZlY19sdHUjI1NaLCB1aW50
IyNTWiMjX3QsIDwpICAgIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc8PScgKGN0eDpXeEIpCiM2
ODI6IEZJTEU6IGFjY2VsL3RjZy90Y2ctcnVudGltZS1ndmVjLmM6OTAyOgorICAgIERPX0NNUDEo
Z3ZlY19sZXUjI1NaLCB1aW50IyNTWiMjX3QsIDw9KQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxMCBlcnJvcnMsIDAgd2FybmluZ3MsIDYzMCBsaW5l
cyBjaGVja2VkCgpQYXRjaCAzLzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvNSBDaGVj
a2luZyBjb21taXQgZTAwMDhhNTAwZmJiICh0Y2c6IFRpZHkgdGNnLXJ1bnRpbWUtZ3ZlYy5jIERV
UCopCjUvNSBDaGVja2luZyBjb21taXQgODNlYWFkZDZhZjIzICh0Y2c6IFJlbW92ZSB0Y2ctcnVu
dGltZS1ndmVjLmMgRE9fQ01QMCkKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAn
KicgKGN0eDpXeFYpCiMzMDogRklMRTogYWNjZWwvdGNnL3RjZy1ydW50aW1lLWd2ZWMuYzo4Njk6
CisgICAgICAgICooVFlQRSAqKShkICsgaSkgPSAtKCooVFlQRSAqKShhICsgaSkgT1AgKihUWVBF
ICopKGIgKyBpKSk7ICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMyBsaW5lcyBj
aGVja2VkCgpQYXRjaCA1LzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzE3MTkwMDEzLjI1
MDM2LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

