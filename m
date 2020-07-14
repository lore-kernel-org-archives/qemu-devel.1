Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E4BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6972145D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6972145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFr2-0006Oj-Qs
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvFqV-0005xw-U8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:59:23 -0400
Resent-Date: Tue, 14 Jul 2020 03:59:23 -0400
Resent-Message-Id: <E1jvFqV-0005xw-U8@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvFqT-0005ao-LL
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594713555; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iZ4wTJrBS9FCl01tkh+3pxbkLFknxGbDYBIQiRdaynumc1SHj5LeDhkX/sptQtXbaJQmGIVV5qFSp5Rz4tPAib14PkI3Lo68cYxBoDQ90Zgt9fJ8zl1XtMOvjsvkUtOOc3VgP689NeHqgsDuCBYF0pJL/tijP9bO19eUeY4mNq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594713555;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fPf3iYuJDPY289iKjiOdmcth2eD0l9E11VR+y/UxyvQ=; 
 b=duDOiT6jrjEr4J4MzZIYExWhyzCcGWJmOIK0wuTiNZoVTl2V8thNKl1nUOM5e6Jt+anlrzrkk9K6bU91KItFJm+4gdP363QSFAIT2v5thxLIS9mOqCNO9Yh9oHSmwyCc9yqS41W+QMCdynvA8nms5R0Ovwk6ZR0NRB8STRp2l/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159471355287616.417004255769825;
 Tue, 14 Jul 2020 00:59:12 -0700 (PDT)
Subject: Re: [PULL 0/7] Linux user for 5.1 patches
Message-ID: <159471355180.2008.16445869146206772547@07a7f0d89f7d>
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 14 Jul 2020 00:59:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:59:19
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDA3MzI1OS4xNDY0
Njc1LTEtbGF1cmVudEB2aXZpZXIuZXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcxNDA3MzI1OS4xNDY0
Njc1LTEtbGF1cmVudEB2aXZpZXIuZXUKU3ViamVjdDogW1BVTEwgMC83XSBMaW51eCB1c2VyIGZv
ciA1LjEgcGF0Y2hlcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0JwpmZmViNjkxIGxpbnV4LXVzZXI6IGZpeCBwcmludF9zeXNjYWxs
X2VycigpIHdoZW4gc3lzY2FsbCByZXR1cm5lZCB2YWx1ZSBpcyBuZWdhdGl2ZQo0MTViMTIzIGxp
bnV4LXVzZXI6IGZpeCB0aGUgZXJybm8gdmFsdWUgaW4gcHJpbnRfc3lzY2FsbF9lcnIoKQo3NWEw
NWFkIGxpbnV4LXVzZXI6IGFkZCBuZXRsaW5rIFJUTV9TRVRMSU5LIGNvbW1hbmQKMTI0ZTI5MCBs
aW51eC11c2VyOiBhZGQgbmV3IG5ldGxpbmsgdHlwZXMKMmZiMTk2NSBsaW51eC11c2VyOiBGaXgg
Q292ZXJpdHkgQ0lEIDE0MzAyNzEgLyBDSUQgMTQzMDI3MgoxNzhhNDM2IGxpbnV4LXVzZXI6IHJl
ZmFjdG9yIGlwYyBzeXNjYWxsIGFuZCBzdXBwb3J0IG9mIHNlbXRpbWVkb3Agc3lzY2FsbAo3OTAx
ZmE3IGxpbnV4LXVzZXI6IFVzZSBFUFJPVE9OT1NVUFBPUlQgZm9yIHVuaW1wbGVtZW50ZWQgbmV0
bGluayBwcm90b2NvbHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNyBDaGVja2luZyBjb21taXQg
NzkwMWZhNzhkZjg0IChsaW51eC11c2VyOiBVc2UgRVBST1RPTk9TVVBQT1JUIGZvciB1bmltcGxl
bWVudGVkIG5ldGxpbmsgcHJvdG9jb2xzKQoyLzcgQ2hlY2tpbmcgY29tbWl0IDE3OGE0MzZiZmUy
ZCAobGludXgtdXNlcjogcmVmYWN0b3IgaXBjIHN5c2NhbGwgYW5kIHN1cHBvcnQgb2Ygc2VtdGlt
ZWRvcCBzeXNjYWxsKQpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91
bGQgYmUgYXZvaWRlZAojMjk6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjgyMDoKKyNpZmRl
ZiBfX3MzOTB4X18KCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3Vs
ZCBiZSBhdm9pZGVkCiM2MjogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6Mzg5NDoKKyNpZmRl
ZiBfX3MzOTB4X18KCkVSUk9SOiBNYWNyb3Mgd2l0aCBjb21wbGV4IHZhbHVlcyBzaG91bGQgYmUg
ZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMKIzYzOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzoz
ODk1OgorI2RlZmluZSBTRU1USU1FRE9QX0lQQ19BUkdTKF9fbnNvcHMsIF9fc29wcywgX190aW1l
b3V0KSBcCisgIChfX25zb3BzKSwgKF9fdGltZW91dCksIChfX3NvcHMpCgpFUlJPUjogTWFjcm9z
IHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM2
NjogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6Mzg5ODoKKyNkZWZpbmUgU0VNVElNRURPUF9J
UENfQVJHUyhfX25zb3BzLCBfX3NvcHMsIF9fdGltZW91dCkgXAorICAoX19uc29wcyksIDAsIChf
X3NvcHMpLCAoX190aW1lb3V0KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmlu
ZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzExMTogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6NDA5
MzoKKyNpZmRlZiBfX3MzOTB4X18KCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZp
bmVzIHNob3VsZCBiZSBhdm9pZGVkCiMxMjU6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjQx
MDg6CisjaWZkZWYgX19OUl9pcGMKCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZp
bmVzIHNob3VsZCBiZSBhdm9pZGVkCiMxMjY6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjQx
MDk6CisjaWYgZGVmaW5lZChfX3NwYXJjX18pCgpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2
YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiMxMjg6IEZJTEU6IGxpbnV4
LXVzZXIvc3lzY2FsbC5jOjQxMTE6CisjZGVmaW5lIE1TR1JDVl9BUkdTKF9fbXNncCwgX19tc2d0
eXApIF9fbXNncCwgX19tc2d0eXAKCkVSUk9SOiBNYWNyb3Mgd2l0aCBjb21wbGV4IHZhbHVlcyBz
aG91bGQgYmUgZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMKIzEzNDogRklMRTogbGludXgtdXNlci9z
eXNjYWxsLmM6NDExNzoKKyNkZWZpbmUgTVNHUkNWX0FSR1MoX19tc2dwLCBfX21zZ3R5cCkgXAor
ICAgICgobG9uZyBpbnRbXSl7KGxvbmcgaW50KV9fbXNncCwgX19tc2d0eXB9KSwgMAoKdG90YWw6
IDQgZXJyb3JzLCA1IHdhcm5pbmdzLCAxNTMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi83IGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzcgQ2hlY2tpbmcgY29tbWl0IDJmYjE5NjU2Y2E5ZSAo
bGludXgtdXNlcjogRml4IENvdmVyaXR5IENJRCAxNDMwMjcxIC8gQ0lEIDE0MzAyNzIpCjQvNyBD
aGVja2luZyBjb21taXQgMTI0ZTI5MDkzMWEyIChsaW51eC11c2VyOiBhZGQgbmV3IG5ldGxpbmsg
dHlwZXMpCjUvNyBDaGVja2luZyBjb21taXQgNzVhMDVhZGYwYzQ2IChsaW51eC11c2VyOiBhZGQg
bmV0bGluayBSVE1fU0VUTElOSyBjb21tYW5kKQo2LzcgQ2hlY2tpbmcgY29tbWl0IDQxNWIxMjM5
NTc5NiAobGludXgtdXNlcjogZml4IHRoZSBlcnJubyB2YWx1ZSBpbiBwcmludF9zeXNjYWxsX2Vy
cigpKQo3LzcgQ2hlY2tpbmcgY29tbWl0IGZmZWI2OTE0NmVmNiAobGludXgtdXNlcjogZml4IHBy
aW50X3N5c2NhbGxfZXJyKCkgd2hlbiBzeXNjYWxsIHJldHVybmVkIHZhbHVlIGlzIG5lZ2F0aXZl
KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDcxNDA3MzI1OS4xNDY0Njc1LTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

