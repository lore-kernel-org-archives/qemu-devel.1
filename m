Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68165C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3C9206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3C9206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGmxy-0001oZ-FQ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGmwy-00011u-3Q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGmww-0006l7-AR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:02:47 -0400
Resent-Date: Tue, 24 Mar 2020 13:02:47 -0400
Resent-Message-Id: <E1jGmww-0006l7-AR@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGmww-0006ki-4O; Tue, 24 Mar 2020 13:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585069356; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=i3VmBAFngf1ir8EkYQ8OBLiCM1ey4p5AZ0Wa7UfqtqrdfTjzQE0wh9qx1+6zSWpjC0iD1jTYnbz9dVBLJsgQ2Gw9pYn4AhQqRdQ5xQGGF11so2SmqVuPkeBLaxvxbW9+agyQXKa2RGBufMo6hcWRQ55CIklJSVoPEzJ149LUDI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585069356;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qUV6xrOneM72vQx37qIipXuoJ2RuQdvK/gwO7FzxCX4=; 
 b=UTcI7cYwJwKXOzW3tBWALKdQNH4AoFkMkng3q4YBZb9xwEEMfxnlELtwd3X3oinS5BpxK1HbDcwyavyK+q195Lm5BITNX7zkFiKizI6ZFSDk+ZX3Kmujkjg91WhM7VPDXtUCg3BPFUs4OyT3QL90pScliT0nbozpnnenexD+pXs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585069350151152.34744957957753;
 Tue, 24 Mar 2020 10:02:30 -0700 (PDT)
In-Reply-To: <20200324150847.10476-1-frankja@linux.ibm.com>
Subject: Re: [PATCH 0/8] pc-bios: s390x: Cleanup part 1
Message-ID: <158506934886.14921.18258673565346427437@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Tue, 24 Mar 2020 10:02:30 -0700 (PDT)
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNDE1MDg0Ny4xMDQ3
Ni0xLWZyYW5ramFAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAvOF0gcGMtYmlvczogczM5MHg6IENsZWFu
dXAgcGFydCAxCk1lc3NhZ2UtaWQ6IDIwMjAwMzI0MTUwODQ3LjEwNDc2LTEtZnJhbmtqYUBsaW51
eC5pYm0uY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjMxZjVmYiBwYy1iaW9zOiBzMzkw
eDogTWFrZSB1MzIgcHRyIGNoZWNrIGV4cGxpY2l0CjMxYTc3YTIgcGMtYmlvczogczM5MHg6IFJl
cGxhY2UgMHgwMCB3aXRoIDB4MCBvciAwCmU3YzMzMTQgcGMtYmlvczogczM5MHg6IFVzZSBlYmNk
aWMyYXNjaWkgdGFibGUKNjdiZjZjYyBwYy1iaW9zOiBzMzkweDogTW92ZSBwYW5pYygpIGludG8g
aGVhZGVyIGFuZCBhZGQgaW5maW5pdGUgbG9vcAowNDMwZDQ3IHBjLWJpb3M6IHMzOTB4OiBVc2Ug
UFNXIG1hc2tzIHdoZXJlIHBvc3NpYmxlCjVkYzVmNTggcGMtYmlvczogczM5MHg6IFJlbmFtZSBh
bmQgdXNlIFBTV19NQVNLX1pNT0RFIGNvbnN0YW50CjQ5ZGE4YWQgcGMtYmlvczogczM5MHg6IEdl
dCByaWQgb2YgbWFnaWMgb2Zmc2V0cyBpbnRvIHRoZSBsb3djb3JlCjYxYThmZjEgcGMtYmlvczog
czM5MHg6IENvbnNvbGlkYXRlIHRpbWluZyBmdW5jdGlvbnMgaW50byB0aW1lLmgKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgNjFhOGZmMTQ5NWQ0IChwYy1iaW9zOiBz
MzkweDogQ29uc29saWRhdGUgdGltaW5nIGZ1bmN0aW9ucyBpbnRvIHRpbWUuaCkKV0FSTklORzog
YWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVw
ZGF0aW5nPwojMTAyOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3
YXJuaW5ncywgMTY3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvOCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoyLzggQ2hlY2tpbmcgY29tbWl0IDQ5ZGE4YWQwMzdlYSAocGMtYmlvczogczM5MHg6
IEdldCByaWQgb2YgbWFnaWMgb2Zmc2V0cyBpbnRvIHRoZSBsb3djb3JlKQpFUlJPUjogc3BhY2Vz
IHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzI5OiBGSUxFOiBwYy1iaW9zL3Mz
OTAtY2N3L2Npby5oOjEyNzoKKyAgICAgICAgICAgIF9fdTE2IGNzc2lkOjg7CiAgICAgICAgICAg
ICAgICAgICAgICAgIF4KCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzMwOiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEyODoKK15JICAgIF9fdTE2OjQ7JAoK
RVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzMTogRklM
RTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMjk6CisgICAgICAgICAgICBfX3UxNiBtOjE7CiAg
ICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAn
OicgKGN0eDpWeFYpCiMzMjogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMzA6CisgICAg
ICAgICAgICBfX3UxNiBzc2lkOjI7CiAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzMzogRklMRTogcGMtYmlv
cy9zMzkwLWNjdy9jaW8uaDoxMzE6CisgICAgICAgICAgICBfX3UxNiBvbmU6MTsKICAgICAgICAg
ICAgICAgICAgICAgIF4KCnRvdGFsOiA1IGVycm9ycywgMCB3YXJuaW5ncywgMzcgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggMi84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzggQ2hlY2tpbmcg
Y29tbWl0IDVkYzVmNTg0MDE0OSAocGMtYmlvczogczM5MHg6IFJlbmFtZSBhbmQgdXNlIFBTV19N
QVNLX1pNT0RFIGNvbnN0YW50KQo0LzggQ2hlY2tpbmcgY29tbWl0IDA0MzBkNDdkNTEyNSAocGMt
YmlvczogczM5MHg6IFVzZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2libGUpCjUvOCBDaGVja2luZyBj
b21taXQgNjdiZjZjYzhjOTAxIChwYy1iaW9zOiBzMzkweDogTW92ZSBwYW5pYygpIGludG8gaGVh
ZGVyIGFuZCBhZGQgaW5maW5pdGUgbG9vcCkKNi84IENoZWNraW5nIGNvbW1pdCBlN2MzMzE0MmE1
NTAgKHBjLWJpb3M6IHMzOTB4OiBVc2UgZWJjZGljMmFzY2lpIHRhYmxlKQo3LzggQ2hlY2tpbmcg
Y29tbWl0IDMxYTc3YTI4YjBmMyAocGMtYmlvczogczM5MHg6IFJlcGxhY2UgMHgwMCB3aXRoIDB4
MCBvciAwKQo4LzggQ2hlY2tpbmcgY29tbWl0IDYzMWY1ZmIzNTQyNyAocGMtYmlvczogczM5MHg6
IE1ha2UgdTMyIHB0ciBjaGVjayBleHBsaWNpdCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMjQxNTA4NDcuMTA0NzYtMS1mcmFua2phQGxp
bnV4LmlibS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

