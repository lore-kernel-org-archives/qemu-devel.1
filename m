Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A33C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225D121473
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225D121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK5g-00056r-3k
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRK4t-0004BA-4G
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRK4r-00048e-Oi
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:26:30 -0400
Resent-Date: Wed, 22 Apr 2020 14:26:30 -0400
Resent-Message-Id: <E1jRK4r-00048e-Oi@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRK4r-0003zh-7p; Wed, 22 Apr 2020 14:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587579972; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h60mDLSZhPOGbR1A8H0xuSe8ocJJsetw1sUQVMd1QQ8Sk2x7t4hsYvjURsY80arDRAYl/8eaH2XjXUPz1x6Us8Rlr7St9iXjIRRLjFh41l/RI+DExRjc6Olmlob/o5WxIrIi02oNYgR0urnH/iEelTGYIRSStylgbah+JNYgbJw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587579972;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=30p6yq9SUBQq+C8UBqwVy/6RUv0Jyd1nuxZCLXeWH4A=; 
 b=fnP3ik9AAKNdynF0WSmRNUffvrgwYrsuphvUt/gaAJwSHYwKnx0gLYsHlLT2Kr0dAquq2uEt9BSrGbH1s9bWDpR+U5gNX3ZLURxGXPw8l1L3b9q3W7UcVndI+wgoDpBI3KLgZJIUgURpa5jAxrki04xnYs8gmAJ8wOwwlUh9geo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587579969552160.91313777470054;
 Wed, 22 Apr 2020 11:26:09 -0700 (PDT)
In-Reply-To: <20200422134815.1584-1-armbru@redhat.com>
Subject: Re: [PATCH v2 0/4] smbus: SPD fixes
Message-ID: <158757996833.861.8379197864420851161@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Wed, 22 Apr 2020 11:26:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 14:26:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjEzNDgxNS4xNTg0
LTEtYXJtYnJ1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MiAwLzRdIHNtYnVzOiBTUEQgZml4ZXMKTWVzc2Fn
ZS1pZDogMjAyMDA0MjIxMzQ4MTUuMTU4NC0xLWFybWJydUByZWRoYXQuY29tClR5cGU6IHNlcmll
cwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJh
c2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgNzc2OWMyMy4uZWU1NzNmNSAgbWFzdGVyICAgICAtPiBt
YXN0ZXIKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDQyMTEyMjIzNi4yNDg2Ny0x
LWY0YnVnQGFtc2F0Lm9yZyAtPiBwYXRjaGV3LzIwMjAwNDIxMTIyMjM2LjI0ODY3LTEtZjRidWdA
YW1zYXQub3JnCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA0MjIwMTE3MjIuMTMy
ODctMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDA0MjIwMTE3
MjIuMTMyODctMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnCiAtIFt0YWcgdXBkYXRlXSAg
ICAgIHBhdGNoZXcvMjAyMDA0MjIxMDAyMTEuMzA2MTQtMS1rcmF4ZWxAcmVkaGF0LmNvbSAtPiBw
YXRjaGV3LzIwMjAwNDIyMTAwMjExLjMwNjE0LTEta3JheGVsQHJlZGhhdC5jb20KIC0gW3RhZyB1
cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDQyMjEyNDUwMS4yODAxNS0xLXBldGVyLm1heWRlbGxA
bGluYXJvLm9yZyAtPiBwYXRjaGV3LzIwMjAwNDIyMTI0NTAxLjI4MDE1LTEtcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA0MjIxNzEzMDUu
MTA5MjMtMS1qb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbSAtPiBwYXRjaGV3LzIwMjAwNDIyMTcx
MzA1LjEwOTIzLTEtam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20KICogW25ldyB0YWddICAgICAg
ICAgcGF0Y2hldy8yMDIwMDQyMjE3MjM1MS4yNjU4My0xLXBib256aW5pQHJlZGhhdC5jb20gLT4g
cGF0Y2hldy8yMDIwMDQyMjE3MjM1MS4yNjU4My0xLXBib256aW5pQHJlZGhhdC5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkMjYxNGQyIHNtYnVzOiBGaXggc3BkX2RhdGFfZ2Vu
ZXJhdGUoKSBmb3IgbnVtYmVyIG9mIGJhbmtzID4gMgoxMTU2NTg5IGJhbWJvbywgc2FtNDYwZXg6
IFRpZHkgdXAgZXJyb3IgbWVzc2FnZSBmb3IgdW5zdXBwb3J0ZWQgUkFNIHNpemUKZmNkZDI1NiBz
bWJ1czogRml4IHNwZF9kYXRhX2dlbmVyYXRlKCkgZXJyb3IgQVBJIHZpb2xhdGlvbgo0ZGU2OTk4
IHNhbTQ2MGV4OiBTdXBwcmVzcyB1c2VsZXNzIHdhcm5pbmcgb24gLW0gMzIgYW5kIC1tIDY0Cgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0IDRkZTY5OThmNjlkNCAoc2Ft
NDYwZXg6IFN1cHByZXNzIHVzZWxlc3Mgd2FybmluZyBvbiAtbSAzMiBhbmQgLW0gNjQpCjIvNCBD
aGVja2luZyBjb21taXQgZmNkZDI1NjkyZjQ5IChzbWJ1czogRml4IHNwZF9kYXRhX2dlbmVyYXRl
KCkgZXJyb3IgQVBJIHZpb2xhdGlvbikKMy80IENoZWNraW5nIGNvbW1pdCAxMTU2NTg5NjUwYTcg
KGJhbWJvbywgc2FtNDYwZXg6IFRpZHkgdXAgZXJyb3IgbWVzc2FnZSBmb3IgdW5zdXBwb3J0ZWQg
UkFNIHNpemUpCkVSUk9SOiB1bm5lY2Vzc2FyeSB3aGl0ZXNwYWNlIGJlZm9yZSBhIHF1b3RlZCBu
ZXdsaW5lCiMzNzogRklMRTogaHcvcHBjL3BwYzR4eF9kZXZzLmM6NzIzOgorICAgICAgICBlcnJv
cl9wcmludGYoIlBvc3NpYmxlIHZhbGlkIFJBTSBzaXplOiAlIiBQUklpNjQgIiBNaUIgXG4iLAoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNSBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzQg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvNCBDaGVja2luZyBjb21taXQgZDI2MTRkMmUz
NzlkIChzbWJ1czogRml4IHNwZF9kYXRhX2dlbmVyYXRlKCkgZm9yIG51bWJlciBvZiBiYW5rcyA+
IDIpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNDIyMTM0ODE1LjE1ODQtMS1hcm1icnVAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

