Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C474C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DDE21582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DDE21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iys5D-0004Az-2E
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 01:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iys47-0003Je-11
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iys44-0007XN-W7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:52:06 -0500
Resent-Date: Tue, 04 Feb 2020 01:52:06 -0500
Resent-Message-Id: <E1iys44-0007XN-W7@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iys43-0007TJ-63
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:52:04 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580799101563809.4337580970232;
 Mon, 3 Feb 2020 22:51:41 -0800 (PST)
In-Reply-To: <1580798552-703-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PULL 0/3] MIPS queue for February 4th, 2020
Message-ID: <158079910047.10925.8934713906088269562@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Mon, 3 Feb 2020 22:51:41 -0800 (PST)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgwNzk4NTUyLTcwMy0xLWdp
dC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tLwoKCgpIaSwKClRoaXMg
c2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRw
dXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCAwLzNdIE1JUFMg
cXVldWUgZm9yIEZlYnJ1YXJ5IDR0aCwgMjAyMApNZXNzYWdlLWlkOiAxNTgwNzk4NTUyLTcwMy0x
LWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tClR5cGU6IHNlcmll
cwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJh
c2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRo
dWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcv
MTU4MDc5ODU1Mi03MDMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJr
LmNvbSAtPiBwYXRjaGV3LzE1ODA3OTg1NTItNzAzLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRh
ci5tYXJrb3ZpY0BydC1yay5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyY2Iw
YmU4IHRhcmdldC9taXBzOiBTZXBhcmF0ZSBGUFUtcmVsYXRlZCBoZWxwZXJzIGludG8gdGhlaXIg
b3duIGZpbGUKZWZhYWNmYSB0YXJnZXQvbWlwczogU2VwYXJhdGUgQ1AwLXJlbGF0ZWQgaGVscGVy
cyBpbnRvIHRoZWlyIG93biBmaWxlCjRhYmY4YzEgdGFyZ2V0L21pcHM6IEZpeCBsbC9zYyBhZnRl
ciA3ZGQ1NDdlNWFiNmIzMWU3YTBjZmMxODJkM2FkMTMxZGQ1NWE5NDhmCgo9PT0gT1VUUFVUIEJF
R0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IDRhYmY4YzEyYTQ4ZSAodGFyZ2V0L21pcHM6IEZp
eCBsbC9zYyBhZnRlciA3ZGQ1NDdlNWFiNmIzMWU3YTBjZmMxODJkM2FkMTMxZGQ1NWE5NDhmKQoy
LzMgQ2hlY2tpbmcgY29tbWl0IGVmYWFjZmE0NzQ3ZiAodGFyZ2V0L21pcHM6IFNlcGFyYXRlIENQ
MC1yZWxhdGVkIGhlbHBlcnMgaW50byB0aGVpciBvd24gZmlsZSkKV0FSTklORzogYWRkZWQsIG1v
dmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwoj
Mjk6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIg
dGhhdCAnJicgKGN0eDpXeFcpCiMyMDI6IEZJTEU6IHRhcmdldC9taXBzL2NwMF9oZWxwZXIuYzox
Njk6CisgICAgdGN1ID0gKHYgPj4gQ1AwVENTdF9UQ1UwKSAmIDB4ZjsKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyYn
IChjdHg6V3hXKQojMjAzOiBGSUxFOiB0YXJnZXQvbWlwcy9jcDBfaGVscGVyLmM6MTcwOgorICAg
IHRteCA9ICh2ID4+IENQMFRDU3RfVE1YKSAmIDB4MTsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCAnJicgKGN0eDpXeFcp
CiMyMDU6IEZJTEU6IHRhcmdldC9taXBzL2NwMF9oZWxwZXIuYzoxNzI6CisgICAgdGtzdSA9ICh2
ID4+IENQMFRDU3RfVEtTVSkgJiAweDM7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCAnJicgKGN0eDpXeFcpCiMxNjc4
OiBGSUxFOiB0YXJnZXQvbWlwcy9jcDBfaGVscGVyLmM6MTY0NToKKyAgICBpZiAoISgoZW52LT5D
UDBfVlBDb250cm9sID4+IENQMFZQQ3RsX0RJUykgJiAxKSkgewogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBh
ZnRlciB0aGF0ICcmJyAoY3R4Old4VykKIzE2OTY6IEZJTEU6IHRhcmdldC9taXBzL2NwMF9oZWxw
ZXIuYzoxNjYzOgorICAgIGlmICgoZW52LT5DUDBfVlBDb250cm9sID4+IENQMFZQQ3RsX0RJUykg
JiAxKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0
b3RhbDogNSBlcnJvcnMsIDEgd2FybmluZ3MsIDMzNTggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8z
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzMgQ2hlY2tpbmcgY29tbWl0IDJjYjBiZThh
OTEwZCAodGFyZ2V0L21pcHM6IFNlcGFyYXRlIEZQVS1yZWxhdGVkIGhlbHBlcnMgaW50byB0aGVp
ciBvd24gZmlsZSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
RVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMxMTY0OiBG
SUxFOiB0YXJnZXQvbWlwcy9mcHVfaGVscGVyLmM6MTEzMzoKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBmbG9hdF9zdGF0dXMgKnN0YXR1cykgICAgICAgICAgICAgIFwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJy
b3JzLCAxIHdhcm5pbmdzLCAzODA2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvMyBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMTU4MDc5ODU1Mi03MDMtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1h
cmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

