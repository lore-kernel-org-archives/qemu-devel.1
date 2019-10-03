Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C965FC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 20:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF452086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 20:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF452086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG839-00089P-5N
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 16:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iG82P-0007Xh-Ca
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 16:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iG82N-0006Xo-Np
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 16:49:25 -0400
Resent-Date: Thu, 03 Oct 2019 16:49:25 -0400
Resent-Message-Id: <E1iG82N-0006Xo-Np@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iG82E-0006Sl-Ko; Thu, 03 Oct 2019 16:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570135732; cv=none; d=zoho.com; s=zohoarc; 
 b=bSEUB12tdZWxpkVf9sQIupqxk66N2N4LrAKN3affa7aKpPN1Fi/9TEhjN5X5GJYnkxcisOddx6NELGQvJr6qnxJNfMo538uK8gTSyj0sSaFjC48zhwE+cjvv+OpIuJBVkzFNVQ0RkpMRJYSv4DJA1zxxr50jMXbP6WWLQJAKZvk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570135732;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=+5RjFWOG5NANj46YvT/9F6lcLZzfFlJJSbNHyIz4Jak=; 
 b=nLwv+yGcSAgIghPEMM4RPRIoPvJ41uMmRwdaFRwwkHSTb57l1BC5sRwcd/2vYrJn0jR5IoyCqpMCAREfuWHGUDt+49rHUGXNueITxA8tQVDZeu8OldfYClCPFjEHPgRBy7gps8WnBAI7sdVhAXNAhXZ/lBB8w3QDd17Jq0RH4UM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570135731415157.00215091933217;
 Thu, 3 Oct 2019 13:48:51 -0700 (PDT)
Subject: Re: [PULL v2 0/8] Ide patches
In-Reply-To: <20191003193245.8993-1-jsnow@redhat.com>
Message-ID: <157013572893.27524.3414201102212256408@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Thu, 3 Oct 2019 13:48:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: fam@euphon.net, peter.maydell@linaro.org, thuth@redhat.com,
 lersek@redhat.com, qemu-block@nongnu.org, mst@redhat.com, lvivier@redhat.com,
 jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 arei.gonglei@huawei.com, kraxel@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMzE5MzI0NS44OTkz
LTEtanNub3dAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMDAzMTkzMjQ1Ljg5OTMtMS1q
c25vd0ByZWRoYXQuY29tClN1YmplY3Q6IFtQVUxMIHYyIDAvOF0gSWRlIHBhdGNoZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
ZTEwN2VkMyBoZC1nZW8tdGVzdDogQWRkIHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlCmNkMTE4OGYg
Ym9vdGRldmljZTogRldfQ0ZHIGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMKNjI3OTJhZCBib290
ZGV2aWNlOiBSZWZhY3RvciBnZXRfYm9vdF9kZXZpY2VzX2xpc3QKMDBkMmJhYiBib290ZGV2aWNl
OiBHYXRoZXIgTENIUyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzCmQ4NWIwZGMgc2NzaTogUHJv
cGFnYXRlIHVucmVhbGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQKMDJjZDZmOSBib290ZGV2aWNl
OiBBZGQgaW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTCmIwNmFmZjggYmxvY2s6IFN1cHBvcnQgcHJv
dmlkaW5nIExDSFMgZnJvbSB1c2VyCjMzNWUzOGEgYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZp
eCB0YWJiaW5nCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IDMzNWUz
OGExMmE2ZSAoYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0YWJiaW5nKQpFUlJPUjogTWFj
cm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lz
CiM1NzogRklMRTogaW5jbHVkZS9ody9ibG9jay9ibG9jay5oOjY1OgorI2RlZmluZSBERUZJTkVf
QkxPQ0tfQ0hTX1BST1BFUlRJRVMoX3N0YXRlLCBfY29uZikgICAgICAgICAgICAgICAgICAgICAg
XAorICAgIERFRklORV9QUk9QX1VJTlQzMigiY3lscyIsIF9zdGF0ZSwgX2NvbmYuY3lscywgMCks
ICAgICAgICAgICAgICAgICAgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigiaGVhZHMiLCBfc3Rh
dGUsIF9jb25mLmhlYWRzLCAwKSwgICAgICAgICAgICAgICAgXAogICAgIERFRklORV9QUk9QX1VJ
TlQzMigic2VjcyIsIF9zdGF0ZSwgX2NvbmYuc2VjcywgMCkKCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMzcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS84IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IGIwNmFmZjhlYzhjYiAoYmxvY2s6IFN1cHBvcnQg
cHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyKQozLzggQ2hlY2tpbmcgY29tbWl0IDAyY2Q2Zjk3ZWMz
MSAoYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUykKNC84IENoZWNraW5n
IGNvbW1pdCBkODViMGRjY2RlNzMgKHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFj
ayB0byBzY3NpLWhkKQo1LzggQ2hlY2tpbmcgY29tbWl0IDAwZDJiYWI0ZmMxNyAoYm9vdGRldmlj
ZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcykKNi84IENoZWNraW5nIGNv
bW1pdCA2Mjc5MmFkOTUyNDAgKGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNf
bGlzdCkKNy84IENoZWNraW5nIGNvbW1pdCBjZDExODhmOTU0NmQgKGJvb3RkZXZpY2U6IEZXX0NG
RyBpbnRlcmZhY2UgZm9yIExDSFMgdmFsdWVzKQo4LzggQ2hlY2tpbmcgY29tbWl0IGUxMDdlZDM3
MTA3NCAoaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVycmlkZSkKV0FSTklORzog
QmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzY1MDog
RklMRTogdGVzdHMvaGQtZ2VvLXRlc3QuYzoxMDAzOgorICAgICAgICAgICAgICAgICAgICAgICAi
c2tpcHBpbmcgaGQtZ2VvL292ZXJyaWRlLyogdGVzdHMiKTsKCnRvdGFsOiAwIGVycm9ycywgMSB3
YXJuaW5ncywgNjE2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDE5MTAwMzE5MzI0NS44OTkzLTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


