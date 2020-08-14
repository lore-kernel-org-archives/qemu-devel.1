Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5CB20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5CB20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bcE-0000Q9-LN
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6bZy-0004lL-KU; Fri, 14 Aug 2020 11:25:14 -0400
Resent-Date: Fri, 14 Aug 2020 11:25:14 -0400
Resent-Message-Id: <E1k6bZy-0004lL-KU@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6bZv-0001jY-KK; Fri, 14 Aug 2020 11:25:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597418703; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jjdx0bh8neylRGUDdx1hhtPOFtr4knQPHQDlye/UVDRmVajhsuWIDjm08k2ABTlKadnoHgxHx7JP/NoW0OLKyGa7O6DgmC7hG3ZA4qqxiyIdPhuHG7WEaDdQkSSeOk8o7lm++20Q033eA5x10YgUrtcH0hzTMZ5vpvreQGekCNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597418703;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vfUb17nn2fBVNoSV2y3uAj6CAHyNR3Ty/On+fHfI9r0=; 
 b=FTV22VJOHTSa42BOVyqVANeSNMKf5EIkiyOkC1GSAvXFt4TEsIhyutuFSSP/mcmJLrtRoAfhY6qadQlLai2W8TZ3+m/iufIG3lCD/8vyJHNFWMnc+J8DBS5f/zpA3c8p5tjiL4GKjxQ/8Z8ZeT8zD49dDl0knOsy5/qF8CiUBuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597418700833352.36484035920955;
 Fri, 14 Aug 2020 08:25:00 -0700 (PDT)
Subject: Re: [PATCH] ide:do nothing for identify cmd if no any device attached
Message-ID: <159741869977.4317.12600913538742599756@66eaa9a8a123>
In-Reply-To: <20200814043657.5815-1-RockCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: RockCui-oc@zhaoxin.com
Date: Fri, 14 Aug 2020 08:25:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 10:22:48
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
Cc: CobeChen@zhaoxin.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, RockCui-oc@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNDA0MzY1Ny41ODE1
LTEtUm9ja0N1aS1vY0B6aGFveGluLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwODE0MDQzNjU3LjU4
MTUtMS1Sb2NrQ3VpLW9jQHpoYW94aW4uY29tClN1YmplY3Q6IFtQQVRDSF0gaWRlOmRvIG5vdGhp
bmcgZm9yIGlkZW50aWZ5IGNtZCBpZiBubyBhbnkgZGV2aWNlIGF0dGFjaGVkCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVs
bCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmMwZWUy
ZjUgaWRlOmRvIG5vdGhpbmcgZm9yIGlkZW50aWZ5IGNtZCBpZiBubyBhbnkgZGV2aWNlIGF0dGFj
aGVkCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMjc6
IEZJTEU6IGh3L2lkZS9jb3JlLmM6MjA3NzoKKyAgICBpZiAoKCFidXMtPmlmc1swXS5ibGsgJiYg
IWJ1cy0+aWZzWzFdLmJsaykgfHwgJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1
c2UgdGFicwojMjg6IEZJTEU6IGh3L2lkZS9jb3JlLmM6MjA3ODoKK15JKHMgIT0gYnVzLT5pZnMg
JiYgIXMtPmJsaykpIHskCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDExIGxpbmVzIGNo
ZWNrZWQKCkNvbW1pdCBjMGVlMmY1YWJiZjMgKGlkZTpkbyBub3RoaW5nIGZvciBpZGVudGlmeSBj
bWQgaWYgbm8gYW55IGRldmljZSBhdHRhY2hlZCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4
MTQwNDM2NTcuNTgxNS0xLVJvY2tDdWktb2NAemhhb3hpbi5jb20vdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

