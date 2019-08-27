Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C946C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5298A2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5298A2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2WuK-0004Sa-5j
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2Ws2-00033G-SD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2Ws0-00026A-OM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:30:30 -0400
Resent-Date: Tue, 27 Aug 2019 04:30:30 -0400
Resent-Message-Id: <E1i2Ws0-00026A-OM@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2Ws0-00025j-GA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566894613; cv=none; d=zoho.com; s=zohoarc; 
 b=XFbJLf6p4f2R30MX/cESJ7dXCmjtP3WKGYB+ZJAQcZTslzCq7LZJ5/Q3yQwgvDWEFEYX9uDvT6Ino7mlkX/LU5X8AUAFki8/XWVGneKBdnX1EVorGYkttztukHFaRvQsX+6FIuamFXxJr8qQPomovW7I+9wfB20nwdJSWKOPUck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566894613;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=MrLcT7XcdB9Bjea/Tmw0vrzYSUo3IiYo5qACUKEPgu0=; 
 b=kBVRSmykGZi79EmN1INYjQ9bgGmJ1xolCpd5iD0PmV+rXD1L7KpYcX7wlSnxrB2wTqupom6AOWnnbYXh61njzTJ0wQ8uQBxd5SLdXM4ymoe6mm2TlEHTi2LJRzrB2lPQAxbGpdgE+UXAFOu5936oDSrL3xLPxn5lmzJXqZk3oMU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566894611362870.4079343492892;
 Tue, 27 Aug 2019 01:30:11 -0700 (PDT)
In-Reply-To: <20190827080512.2417-1-fangying1@huawei.com>
Message-ID: <156689460980.15196.16519032948851164388@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fangying1@huawei.com
Date: Tue, 27 Aug 2019 01:30:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] qmp: Fix memory leak in
 migrate_params_test_apply
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 zhouyibo3@huawei.com, dgilbert@redhat.com, lcf.lichaofeng@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyNzA4MDUxMi4yNDE3
LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwODI3MDgwNTEyLjI0MTctMS1mYW5neWluZzFA
aHVhd2VpLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gcW1w
OiBGaXggbWVtb3J5IGxlYWsgaW4gbWlncmF0ZV9wYXJhbXNfdGVzdF9hcHBseQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2ZTVk
ZjMxIHFtcDogRml4IG1lbW9yeSBsZWFrIGluIG1pZ3JhdGVfcGFyYW1zX3Rlc3RfYXBwbHkKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBnX2ZyZWUoTlVMTCkgaXMgc2FmZSB0aGlzIGNoZWNr
IGlzIHByb2JhYmx5IG5vdCByZXF1aXJlZAojNDg6IEZJTEU6IG1pZ3JhdGlvbi9taWdyYXRpb24u
YzoxMjU0OgorICAgICAgICBpZiAoZGVzdC0+dGxzX2NyZWRzKSB7CisgICAgICAgICAgICBnX2Zy
ZWUoZGVzdC0+dGxzX2NyZWRzKTsKCkVSUk9SOiBnX2ZyZWUoTlVMTCkgaXMgc2FmZSB0aGlzIGNo
ZWNrIGlzIHByb2JhYmx5IG5vdCByZXF1aXJlZAojNTY6IEZJTEU6IG1pZ3JhdGlvbi9taWdyYXRp
b24uYzoxMjYyOgorICAgICAgICBpZiAoZGVzdC0+dGxzX2hvc3RuYW1lKSB7CisgICAgICAgICAg
ICBnX2ZyZWUoZGVzdC0+dGxzX2hvc3RuYW1lKTsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5n
cywgMTcgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDZlNWRmMzEyZmVmZiAocW1wOiBGaXggbWVtb3J5
IGxlYWsgaW4gbWlncmF0ZV9wYXJhbXNfdGVzdF9hcHBseSkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTA4MjcwODA1MTIuMjQxNy0xLWZhbmd5aW5nMUBodWF3ZWkuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


