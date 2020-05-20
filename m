Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14E9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C077C2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C077C2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRmK-0005mx-UC
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbRjk-0000v8-2D
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:38:32 -0400
Resent-Date: Wed, 20 May 2020 12:38:32 -0400
Resent-Message-Id: <E1jbRjk-0000v8-2D@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbRji-0002yE-Hr
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:38:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589992706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TrrAfxgMOntdWMUE+hODxohvJvB5J5Fv3x862jG4eOc+tXncePBtCM1SMb8bfnqoBV+wU/XwFwNkp1gRQYwjHFtifuxXftzhfC6R0oWuItA7FzqypzUneB2FNaCFVDAjIyEySstrjq1sJGkKUzZzvr/9DL/9XZeBsBFwN3fIubE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589992706;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=15tyVLFtF94IlviAU0NkXkIwTSn5qdYmbJofTgDSHM8=; 
 b=FBPNVGGwy/dCFY5pprVbBk/oq8bcbKkkaSoMIgen2I0t8JT2qVPBAp2KWsPO9vAVAqoHynccGv5WbLtRRcxEIId0GyCWREmst7Kc2qRrlNVa+E6ept5wlUomwgIE1lI5c9AZu488UJlyt+T8JaBfVk0z7qIj1k5XGyOdNHgGBC8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589992705455788.4020777949285;
 Wed, 20 May 2020 09:38:25 -0700 (PDT)
Message-ID: <158999270448.28633.1966026024798405154@45ef0f9c86ae>
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 00/15] testing and plugin updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 20 May 2020 09:38:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 11:46:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMDE0MDU0MS4zMDI1
Ni0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTIwMTQwNTQxLjMwMjU2LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFUQ0ggIHYxIDAwLzE1XSB0ZXN0aW5nIGFuZCBw
bHVnaW4gdXBkYXRlcwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmExZjMwMDkgcGx1Z2luczog
bmV3IGxvY2tzdGVwIHBsdWdpbiBmb3IgZGVidWdnaW5nIFRDRyBjaGFuZ2VzCmY4YWI5ZjEgdGVz
dHMvdGNnOiBhZGQgbmV3IHRocmVhZGNvdW50IHRlc3QKYmJhZjVjMiBsaW51eC11c2VyOiBwcm9w
ZXJseSAidW5yZWFsaXplIiB2Q1BVIG9iamVjdAo4ZDYwMmVkIGNwdXMtY29tbW9uOiBlbnN1cmUg
YXV0by1hc3NpZ25lZCBjcHVfaW5kZXhlcyBkb24ndCBjbGFzaAphMzFkOGRkIHRlc3RzL3RjZy9h
YXJjaDY0OiBBZGQgYnRpIHNtb2tlIHRlc3QKNDZlZmFmYyB0ZXN0cy9kb2NrZXI6IHVzZSBhIGdj
Yy0xMCBiYXNlZCBpbWFnZSBmb3IgYXJtNjQgdGVzdHMKYzYyZDY2NCB0ZXN0cy9kb2NrZXI6IGFk
ZCBkZWJpYW4xMSBiYXNlIGltYWdlCmM1NTkwZmUgdGVzdHMvZG9ja2VyOiBidW1wIGZlZG9yYSB0
byAzMgo1ZWVhNmYxIHRlc3RzL3RjZzogYmV0dGVyIGRldGVjdCBjb25mdXNlZCBnZGIgd2hpY2gg
Y2FuJ3QgY29ubmVjdAo2M2RiODk4IHRlc3RzL2ZwOiBzcGxpdCBhbmQgYXVkaXQgdGhlIGNvbnZl
cnNpb24gdGVzdHMKZDQ4NDcxNSB0ZXN0cy9mcDogZW5hYmxlIGV4dGY4MF9sZV9xdWl0ZSB0ZXN0
cwpkYTEyM2YxIHRlc3RzL3RjZzogZml4IGludm9jYXRpb24gb2YgdGhlIG1lbW9yeSByZWNvcmQv
cmVwbGF5IHRlc3RzCjA2NjdjYzMgdHJhdmlzLnltbDogVXNlIGNsYW5nKysgaW4gdGhlIENsYW5n
IHRlc3RzCjAzMzM0ZGIgdGVzdHMvdm06IHBhc3MgLS1nZW5pc29pbWFnZSB0byBiYXNldm0gc2Ny
aXB0CmY0OWM5ZmYgY29uZmlndXJlOiBhZGQgYWx0ZXJuYXRlIGJpbmFyeSBmb3IgZ2VuaXNvaW1h
Z2UKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTUgQ2hlY2tpbmcgY29tbWl0IGY0OWM5ZmYyODQw
MCAoY29uZmlndXJlOiBhZGQgYWx0ZXJuYXRlIGJpbmFyeSBmb3IgZ2VuaXNvaW1hZ2UpCjIvMTUg
Q2hlY2tpbmcgY29tbWl0IDAzMzM0ZGIzZGVlYiAodGVzdHMvdm06IHBhc3MgLS1nZW5pc29pbWFn
ZSB0byBiYXNldm0gc2NyaXB0KQozLzE1IENoZWNraW5nIGNvbW1pdCAwNjY3Y2MzNzM3YTYgKHRy
YXZpcy55bWw6IFVzZSBjbGFuZysrIGluIHRoZSBDbGFuZyB0ZXN0cykKNC8xNSBDaGVja2luZyBj
b21taXQgZGExMjNmMWZjMzQ3ICh0ZXN0cy90Y2c6IGZpeCBpbnZvY2F0aW9uIG9mIHRoZSBtZW1v
cnkgcmVjb3JkL3JlcGxheSB0ZXN0cykKNS8xNSBDaGVja2luZyBjb21taXQgZDQ4NDcxNWZhYWJl
ICh0ZXN0cy9mcDogZW5hYmxlIGV4dGY4MF9sZV9xdWl0ZSB0ZXN0cykKNi8xNSBDaGVja2luZyBj
b21taXQgNjNkYjg5ODNjOTUyICh0ZXN0cy9mcDogc3BsaXQgYW5kIGF1ZGl0IHRoZSBjb252ZXJz
aW9uIHRlc3RzKQo3LzE1IENoZWNraW5nIGNvbW1pdCA1ZWVhNmYxN2QwZTQgKHRlc3RzL3RjZzog
YmV0dGVyIGRldGVjdCBjb25mdXNlZCBnZGIgd2hpY2ggY2FuJ3QgY29ubmVjdCkKOC8xNSBDaGVj
a2luZyBjb21taXQgYzU1OTBmZTFhOTEwICh0ZXN0cy9kb2NrZXI6IGJ1bXAgZmVkb3JhIHRvIDMy
KQo5LzE1IENoZWNraW5nIGNvbW1pdCBjNjJkNjY0ZTJiMDcgKHRlc3RzL2RvY2tlcjogYWRkIGRl
YmlhbjExIGJhc2UgaW1hZ2UpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUo
cyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI3OiAKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMjYgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggOS8xNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoxMC8xNSBDaGVja2luZyBjb21taXQg
NDZlZmFmYzRlNTIwICh0ZXN0cy9kb2NrZXI6IHVzZSBhIGdjYy0xMCBiYXNlZCBpbWFnZSBmb3Ig
YXJtNjQgdGVzdHMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzMxOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMzQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTAv
MTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMTEvMTUgQ2hlY2tpbmcgY29tbWl0IGEzMWQ4
ZGRjNzQ4YiAodGVzdHMvdGNnL2FhcmNoNjQ6IEFkZCBidGkgc21va2UgdGVzdCkKV0FSTklORzog
YWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVw
ZGF0aW5nPwojMzY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGV4dGVybnMgc2hvdWxk
IGJlIGF2b2lkZWQgaW4gLmMgZmlsZXMKIzEyMTogRklMRTogdGVzdHMvdGNnL2FhcmNoNjQvYnRp
LWNydC5pbmMuYzoxMzoKK2ludCBtYWluKHZvaWQpOwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5p
bmdzLCAxMzggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTEvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjEyLzE1IENoZWNraW5nIGNvbW1pdCA4ZDYwMmVkNzdhMjUgKGNwdXMtY29tbW9uOiBl
bnN1cmUgYXV0by1hc3NpZ25lZCBjcHVfaW5kZXhlcyBkb24ndCBjbGFzaCkKMTMvMTUgQ2hlY2tp
bmcgY29tbWl0IGJiYWY1YzJmNjJiZSAobGludXgtdXNlcjogcHJvcGVybHkgInVucmVhbGl6ZSIg
dkNQVSBvYmplY3QpCjE0LzE1IENoZWNraW5nIGNvbW1pdCBmOGFiOWYxZmNjOTYgKHRlc3RzL3Rj
ZzogYWRkIG5ldyB0aHJlYWRjb3VudCB0ZXN0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVs
ZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyOTogCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDcyIGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDE0LzE1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjE1LzE1IENoZWNr
aW5nIGNvbW1pdCBhMWYzMDA5Y2UxZjIgKHBsdWdpbnM6IG5ldyBsb2Nrc3RlcCBwbHVnaW4gZm9y
IGRlYnVnZ2luZyBUQ0cgY2hhbmdlcykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTU6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAzNTUgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMTUvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjAxNDA1NDEuMzAyNTYt
MS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

