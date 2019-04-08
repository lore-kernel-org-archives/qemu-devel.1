Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D691C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C3F20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 02:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C3F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDJzH-00013q-AV
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 22:26:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDJyU-0000jW-Lu
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDJyT-0005Hf-Db
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:25:30 -0400
Resent-Date: Sun, 07 Apr 2019 22:25:30 -0400
Resent-Message-Id: <E1hDJyT-0005Hf-Db@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDJyT-0005HP-3R
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 22:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554690298; cv=none; d=zoho.com; s=zohoarc; 
	b=n4o5JPIhCMZA7p7GmGdgLvp3MBF/fauYTkK17CkrVecJbmvI+6qiSTfn2xKNRs0i3eVGaq4vbNoJzOswgxs70eSwfigvmA2qINn29LHyJoUCv1bKfbXlaFPK2IyALP/ObLafRaSnskK2y9tjhDjt6CFnHD/UCm5eftUAqbLDN/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554690298;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=SSNblKIs7ik4lUpcJAxxQvjheDwG85q7gXCaYDbEtaI=; 
	b=a9WaLMjL3kx7fMThiaZPVAFKfoHAjX/l7FFSObAKm5TJaFcmeoUEdeawALpnkO5OyL4lq/y7RN1FGmAlL9sqVAfZwKEEMJ+5kzNEr5MrYn2OkPjm8jgxo04nM/hCjJg/LJNRm9h0AgOq+Mq43ulLMrxxdSBYG1vyIloW2GfYvzE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554690298210443.99578873396683;
	Sun, 7 Apr 2019 19:24:58 -0700 (PDT)
Message-ID: <155469029685.12882.6842154497172555422@76452e4e88f2>
In-Reply-To: <B786F00D-5518-405B-B0AC-C5BF2D7283F5@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Sun, 7 Apr 2019 19:24:58 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix absolute and relative
 input issues on Mojave
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-devel@nongnu.org,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408022458.v0OrBw_jWkfOZz1pug2SGkhE84aWMRCSV2YM-X3D-P0@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9CNzg2RjAwRC01NTE4LTQwNUIt
QjBBQy1DNUJGMkQ3MjgzRjVAbWUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiBCNzg2RjAwRC01NTE4LTQwNUItQjBBQy1DNUJGMkQ3
MjgzRjVAbWUuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8yXSB1aS9jb2NvYTog
Rml4IGFic29sdXRlIGFuZCByZWxhdGl2ZSBpbnB1dCBpc3N1ZXMgb24gTW9qYXZlClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hl
dy9CNzg2RjAwRC01NTE4LTQwNUItQjBBQy1DNUJGMkQ3MjgzRjVAbWUuY29tIC0+IHBhdGNoZXcv
Qjc4NkYwMEQtNTUxOC00MDVCLUIwQUMtQzVCRjJENzI4M0Y1QG1lLmNvbQpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjljNWM3ZjA0N2QgdWkvY29jb2E6IEZpeCBtb3VzZSBncmFiYmlu
ZyBpbiBmdWxsc2NyZWVuIG1vZGUgZm9yIHJlbGF0aXZlIGlucHV0IGRldmljZQpmZmU3NmJhZmMx
IHVpL2NvY29hOiBGaXggYWJzb2x1dGUgaW5wdXQgZGV2aWNlIGdyYWJiaW5nIGlzc3VlIG9uCgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IGZmZTc2YmFmYzFiYiAodWkv
Y29jb2E6IEZpeCBhYnNvbHV0ZSBpbnB1dCBkZXZpY2UgZ3JhYmJpbmcgaXNzdWUgb24pCkVSUk9S
OiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5nbGVkIGJ5IHRoZSBtYWlsaW5nIGxpc3QKIzI6
IApBdXRob3I6IENoZW4gWmhhbmcgdmlhIFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNjEgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
MS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0IDljNWM3
ZjA0N2RhOCAodWkvY29jb2E6IEZpeCBtb3VzZSBncmFiYmluZyBpbiBmdWxsc2NyZWVuIG1vZGUg
Zm9yIHJlbGF0aXZlIGlucHV0IGRldmljZSkKRVJST1I6IEF1dGhvciBlbWFpbCBhZGRyZXNzIGlz
IG1hbmdsZWQgYnkgdGhlIG1haWxpbmcgbGlzdAojMjogCkF1dGhvcjogQ2hlbiBaaGFuZyB2aWEg
UWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3JnPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAxMyBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
L0I3ODZGMDBELTU1MTgtNDA1Qi1CMEFDLUM1QkYyRDcyODNGNUBtZS5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


