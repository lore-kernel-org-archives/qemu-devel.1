Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE9EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC1520781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 08:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC1520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k68nK-0003Y5-3W
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 04:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k68mX-0002np-Dn; Thu, 13 Aug 2020 04:40:17 -0400
Resent-Date: Thu, 13 Aug 2020 04:40:17 -0400
Resent-Message-Id: <E1k68mX-0002np-Dn@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k68mU-00017j-Gq; Thu, 13 Aug 2020 04:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597307983; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E5LHpT5k/XTRrTPBfjRElFbBSWZc8ctjr6JD8fIoEwa6xRZXAQ68TP2JCNyZnEsENH+UqNm7D3aDVIFYSSOO7g0eZ3opxxBcih1Zfbjk30LkeR+93iD02g9NE9CWehWQUJHWHnBmkzuh/Mxvk3XD/ccadYKhjcmymxlU4cyeMl4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597307983;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lOLEa2licrTsMyIh0pDxRDKRxf3x3kTbiH3M6T3VrwY=; 
 b=mf4+wm5KA6J93ZGx1KoUiwNNvOCSBUBH7JLIlWZWFhmZBFVkPWMM5TgXGDFQPglsA2wVkU4j5X39WWQhP21kOG7QV2WcIfrq7OIy52wRcQtgG3dy4kag/Afsw8R3hj1owbnSedIz9ni4o3XcZOI/tQycBe3ir9pNc9yss9Vdypo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597307978627633.6176012084727;
 Thu, 13 Aug 2020 01:39:38 -0700 (PDT)
Subject: Re: [PATCH 00/11] trivial patchs for static code analyzer fixes
Message-ID: <159730797733.15736.10346594019308505914@66eaa9a8a123>
In-Reply-To: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kuhn.chenqun@huawei.com
Date: Thu, 13 Aug 2020 01:39:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 04:40:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, kuhn.chenqun@huawei.com, pannengyuan@huawei.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzA3MzcxMi40MDAx
NDA0LTEta3Vobi5jaGVucXVuQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDgxMzA3Mzcx
Mi40MDAxNDA0LTEta3Vobi5jaGVucXVuQGh1YXdlaS5jb20KU3ViamVjdDogW1BBVENIIDAwLzEx
XSB0cml2aWFsIHBhdGNocyBmb3Igc3RhdGljIGNvZGUgYW5hbHl6ZXIgZml4ZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwODEzMDcz
NzEyLjQwMDE0MDQtMS1rdWhuLmNoZW5xdW5AaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzIwMjAwODEz
MDczNzEyLjQwMDE0MDQtMS1rdWhuLmNoZW5xdW5AaHVhd2VpLmNvbQpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjRmNzM3MjcgaHcvZGlzcGxheS92Z2E6UmVtb3ZlIHJlZHVuZGFudCBz
dGF0ZW1lbnQgaW4gdmdhX2RyYXdfZ3JhcGhpYygpCmE1MDFkMzkgaHcvaW50YzogUmVtb3ZlIHJl
ZHVuZGFudCBzdGF0ZW1lbnQgaW4gZXh5bm9zNDIxMF9jb21iaW5lcl9yZWFkKCkKMDg0ZWJkOCB1
c2IvYnVzOiBSZW1vdmUgZGVhZCBhc3NpZ25tZW50IGluIHVzYl9nZXRfZndfZGV2X3BhdGgoKQo1
YjI2ZDZhIHRjZy9vcHRpbWl6ZTogUmVtb3ZlIHJlZHVuZGFudCBzdGF0ZW1lbnQgaW4gdGNnX29w
dGltaXplKCkKZTYyOGEyMiB2ZmlvL3BsYXRmb3JtOiBSZW1vdmUgZGVhZCBhc3NpZ25tZW50IGlu
IHZmaW9faW50cF9pbnRlcnJ1cHQoKQo1NjVlZmMxIGh3L25ldC92aXJ0aW8tbmV0OlJlbW92ZSBy
ZWR1bmRhbnQgc3RhdGVtZW50IGluIHZpcnRpb19uZXRfcnNjX3RjcF9jdHJsX2NoZWNrKCkKN2I2
NWFjNCBody92aXJ0aW8vdmhvc3QtdXNlcjpSZW1vdmUgZGVhZCBhc3NpZ25tZW50IGluIHNjcnVi
X3NoYWRvd19yZWdpb25zKCkKMmRkNzE4YyB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQ6UmVtb3Zl
IHJlZHVuZGFudCBzdGF0ZW1lbnQgaW4gZGlzYXNfc2ltZF90d29fcmVnX21pc2NfZnAxNigpCjQ3
ODMzZGYgdGFyZ2V0L2FybS90cmFuc2xhdGUtYTY0OlJlbW92ZSBkZWFkIGFzc2lnbm1lbnQgaW4g
aGFuZGxlX3NjYWxhcl9zaW1kX3NobGkoKQplMWJiNmMzIGh3L2FybS9vbWFwMTpSZW1vdmUgcmVk
dW5kYW50IHN0YXRlbWVudCBpbiBvbWFwX2Nsa2RzcF9yZWFkKCkKMzlhN2Q4ZiBody9hcm0vdmly
dC1hY3BpLWJ1aWxkOlJlbW92ZSBkZWFkIGFzc2lnbm1lbnQgaW4gYnVpbGRfbWFkdCgpCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzExIENoZWNraW5nIGNvbW1pdCAzOWE3ZDhmMmQ2MmQgKGh3L2Fy
bS92aXJ0LWFjcGktYnVpbGQ6UmVtb3ZlIGRlYWQgYXNzaWdubWVudCBpbiBidWlsZF9tYWR0KCkp
CjIvMTEgQ2hlY2tpbmcgY29tbWl0IGUxYmI2YzNlMTc4YyAoaHcvYXJtL29tYXAxOlJlbW92ZSBy
ZWR1bmRhbnQgc3RhdGVtZW50IGluIG9tYXBfY2xrZHNwX3JlYWQoKSkKMy8xMSBDaGVja2luZyBj
b21taXQgNDc4MzNkZjkzNWE2ICh0YXJnZXQvYXJtL3RyYW5zbGF0ZS1hNjQ6UmVtb3ZlIGRlYWQg
YXNzaWdubWVudCBpbiBoYW5kbGVfc2NhbGFyX3NpbWRfc2hsaSgpKQo0LzExIENoZWNraW5nIGNv
bW1pdCAyZGQ3MThjYzE5MjYgKHRhcmdldC9hcm0vdHJhbnNsYXRlLWE2NDpSZW1vdmUgcmVkdW5k
YW50IHN0YXRlbWVudCBpbiBkaXNhc19zaW1kX3R3b19yZWdfbWlzY19mcDE2KCkpCjUvMTEgQ2hl
Y2tpbmcgY29tbWl0IDdiNjVhYzRjY2I5ZCAoaHcvdmlydGlvL3Zob3N0LXVzZXI6UmVtb3ZlIGRl
YWQgYXNzaWdubWVudCBpbiBzY3J1Yl9zaGFkb3dfcmVnaW9ucygpKQo2LzExIENoZWNraW5nIGNv
bW1pdCA1NjVlZmMxMmVjMmEgKGh3L25ldC92aXJ0aW8tbmV0OlJlbW92ZSByZWR1bmRhbnQgc3Rh
dGVtZW50IGluIHZpcnRpb19uZXRfcnNjX3RjcF9jdHJsX2NoZWNrKCkpCjcvMTEgQ2hlY2tpbmcg
Y29tbWl0IGU2MjhhMjIzNmU5NSAodmZpby9wbGF0Zm9ybTogUmVtb3ZlIGRlYWQgYXNzaWdubWVu
dCBpbiB2ZmlvX2ludHBfaW50ZXJydXB0KCkpCjgvMTEgQ2hlY2tpbmcgY29tbWl0IDViMjZkNmFm
NzViZCAodGNnL29wdGltaXplOiBSZW1vdmUgcmVkdW5kYW50IHN0YXRlbWVudCBpbiB0Y2dfb3B0
aW1pemUoKSkKOS8xMSBDaGVja2luZyBjb21taXQgMDg0ZWJkODc4Y2U2ICh1c2IvYnVzOiBSZW1v
dmUgZGVhZCBhc3NpZ25tZW50IGluIHVzYl9nZXRfZndfZGV2X3BhdGgoKSkKRVJST1I6IHNwYWNl
IHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMjU6IEZJTEU6IGh3L3VzYi9idXMu
Yzo2MTU6CisgICAgICAgICAgICBzbnByaW50Zihmd19wYXRoICsgcG9zLCBmd19sZW4gLSBwb3Ms
ICIlc0AlbHgiLHFkZXZfZndfbmFtZShxZGV2KSwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDEwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDkvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjEwLzExIENoZWNraW5nIGNvbW1pdCBhNTAxZDM5YzcyZTYgKGh3L2ludGM6IFJlbW92
ZSByZWR1bmRhbnQgc3RhdGVtZW50IGluIGV4eW5vczQyMTBfY29tYmluZXJfcmVhZCgpKQoxMS8x
MSBDaGVja2luZyBjb21taXQgNGY3MzcyN2ViMTlkIChody9kaXNwbGF5L3ZnYTpSZW1vdmUgcmVk
dW5kYW50IHN0YXRlbWVudCBpbiB2Z2FfZHJhd19ncmFwaGljKCkpCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODEzMDczNzEyLjQwMDE0MDQt
MS1rdWhuLmNoZW5xdW5AaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

