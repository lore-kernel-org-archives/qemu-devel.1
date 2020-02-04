Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC00C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A15E2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A15E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytIr-000368-Oi
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iytHe-0001qb-OS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iytHc-0003W6-Pt
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:10:09 -0500
Resent-Date: Tue, 04 Feb 2020 03:10:09 -0500
Resent-Message-Id: <E1iytHc-0003W6-Pt@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iytHc-0003Lc-H1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:10:08 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580803786992508.43394377546963;
 Tue, 4 Feb 2020 00:09:46 -0800 (PST)
In-Reply-To: <1580803317-4422-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PULL v2 0/3] MIPS queue for February 4th, 2020
Message-ID: <158080378583.10925.13488810561515333869@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Tue, 4 Feb 2020 00:09:46 -0800 (PST)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgwODAzMzE3LTQ0MjItMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgdjIgMC8zXSBN
SVBTIHF1ZXVlIGZvciBGZWJydWFyeSA0dGgsIDIwMjAKTWVzc2FnZS1pZDogMTU4MDgwMzMxNy00
NDIyLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20KVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczov
L2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0
Y2hldy8xNTgwODAzMzE3LTQ0MjItMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmlj
QHJ0LXJrLmNvbSAtPiBwYXRjaGV3LzE1ODA4MDMzMTctNDQyMi0xLWdpdC1zZW5kLWVtYWlsLWFs
ZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKNTkzNTYyYiB0YXJnZXQvbWlwczogU2VwYXJhdGUgRlBVLXJlbGF0ZWQgaGVscGVycyBpbnRv
IHRoZWlyIG93biBmaWxlCmJlMDQxMGEgdGFyZ2V0L21pcHM6IFNlcGFyYXRlIENQMC1yZWxhdGVk
IGhlbHBlcnMgaW50byB0aGVpciBvd24gZmlsZQoxOWRlMzcxIHRhcmdldC9taXBzOiBGaXggaGFu
ZGxpbmcgb2YgTEwvU0MgaW5zdHJ1Y3Rpb25zIGFmdGVyIDdkZDU0N2U1YWIKCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgMTlkZTM3MWFjZTk1ICh0YXJnZXQvbWlwczog
Rml4IGhhbmRsaW5nIG9mIExML1NDIGluc3RydWN0aW9ucyBhZnRlciA3ZGQ1NDdlNWFiKQoyLzMg
Q2hlY2tpbmcgY29tbWl0IGJlMDQxMGE3ZmQ1NSAodGFyZ2V0L21pcHM6IFNlcGFyYXRlIENQMC1y
ZWxhdGVkIGhlbHBlcnMgaW50byB0aGVpciBvd24gZmlsZSkKV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjk6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhh
dCAnJicgKGN0eDpXeFcpCiMyMDI6IEZJTEU6IHRhcmdldC9taXBzL2NwMF9oZWxwZXIuYzoxNjk6
CisgICAgdGN1ID0gKHYgPj4gQ1AwVENTdF9UQ1UwKSAmIDB4ZjsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyYnIChj
dHg6V3hXKQojMjAzOiBGSUxFOiB0YXJnZXQvbWlwcy9jcDBfaGVscGVyLmM6MTcwOgorICAgIHRt
eCA9ICh2ID4+IENQMFRDU3RfVE1YKSAmIDB4MTsKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXgoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCAnJicgKGN0eDpXeFcpCiMy
MDU6IEZJTEU6IHRhcmdldC9taXBzL2NwMF9oZWxwZXIuYzoxNzI6CisgICAgdGtzdSA9ICh2ID4+
IENQMFRDU3RfVEtTVSkgJiAweDM7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoK
RVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCAnJicgKGN0eDpXeFcpCiMxNjc4OiBG
SUxFOiB0YXJnZXQvbWlwcy9jcDBfaGVscGVyLmM6MTY0NToKKyAgICBpZiAoISgoZW52LT5DUDBf
VlBDb250cm9sID4+IENQMFZQQ3RsX0RJUykgJiAxKSkgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBhZnRl
ciB0aGF0ICcmJyAoY3R4Old4VykKIzE2OTY6IEZJTEU6IHRhcmdldC9taXBzL2NwMF9oZWxwZXIu
YzoxNjYzOgorICAgIGlmICgoZW52LT5DUDBfVlBDb250cm9sID4+IENQMFZQQ3RsX0RJUykgJiAx
KSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3Rh
bDogNSBlcnJvcnMsIDEgd2FybmluZ3MsIDMzNTggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8zIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzMgQ2hlY2tpbmcgY29tbWl0IDU5MzU2MmJlZTQ3
ZCAodGFyZ2V0L21pcHM6IFNlcGFyYXRlIEZQVS1yZWxhdGVkIGhlbHBlcnMgaW50byB0aGVpciBv
d24gZmlsZSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBN
QUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJS
T1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMxMTY0OiBGSUxF
OiB0YXJnZXQvbWlwcy9mcHVfaGVscGVyLmM6MTEzMzoKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBmbG9hdF9zdGF0dXMgKnN0YXR1cykgICAgICAgICAgICAgIFwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3Jz
LCAxIHdhcm5pbmdzLCAzODA2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvMyBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMTU4MDgwMzMxNy00NDIyLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJr
b3ZpY0BydC1yay5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

