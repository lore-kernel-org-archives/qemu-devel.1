Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D8CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 17:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8D9208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 17:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8D9208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQDse-0001Mh-LJ
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 13:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iQDrN-0000Zo-Ia
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iQDrK-0001Dd-JT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:03:44 -0400
Resent-Date: Thu, 31 Oct 2019 13:03:43 -0400
Resent-Message-Id: <E1iQDrK-0001Dd-JT@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iQDrD-00016v-NU; Thu, 31 Oct 2019 13:03:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572541393; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZK026lPd8JLV6TniaUEA4Hud0VDsoUn5SicvDU+7b5aVQORJ71gledZ5+ssAyPO811hJi1oz5a+faq4aobb00UVaEMhYmTQN0cZVvcrnd2i+2dZQ0smrWSj5xAhMFSFZd96QDe8CyKk67PtTvJOW6pElOsWsGq/XZj/krrpH2Z0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572541393;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vptXqUD7KLMHri6Y8eTmlH8gXvyYIsmZfQztJHI3Z5U=; 
 b=OIXlTrh8Csnz+k0v5QHYctMKc4flm2Y7eV+b5razIYehUE7f7emobUGq8tQL53aRzGL1VUIJl6xMU1j5MhP786VO/el3qvvqBv/VBdHUHfb12QDwxb/nPOOEj9V9l3j7edycB/lW8OYhIxI35cSbANgbFwsa71bBpjJyG/1E38Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572541392398725.8180245891328;
 Thu, 31 Oct 2019 10:03:12 -0700 (PDT)
In-Reply-To: <20191031155636.18589-1-jsnow@redhat.com>
Subject: Re: [libvirt] [PULL v2 0/9] Ide patches
Message-ID: <157254139020.11413.2225285472928289464@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Thu, 31 Oct 2019 10:03:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, libvir-list@redhat.com,
 lersek@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 arei.gonglei@huawei.com, kraxel@redhat.com, stefanha@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, fam@euphon.net, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAzMTE1NTYzNi4xODU4
OS0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtsaWJ2aXJ0XSBbUFVMTCB2MiAwLzldIElkZSBwYXRjaGVzClR5
cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAzMTE1NTYzNi4xODU4OS0xLWpzbm93QHJlZGhh
dC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKNTE0Yzk5MCBoZC1nZW8tdGVzdDogQWRkIHRlc3RzIGZvciBsY2hzIG92ZXJy
aWRlCjQxN2MwNmIgYm9vdGRldmljZTogRldfQ0ZHIGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMK
OTVjZmYyNSBib290ZGV2aWNlOiBSZWZhY3RvciBnZXRfYm9vdF9kZXZpY2VzX2xpc3QKODMzOGFj
NCBib290ZGV2aWNlOiBHYXRoZXIgTENIUyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzCjc0ZTRj
NTQgc2NzaTogUHJvcGFnYXRlIHVucmVhbGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQKODllOTlk
NSBib290ZGV2aWNlOiBBZGQgaW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTCjM4YTFmNzkgYmxvY2s6
IFN1cHBvcnQgcHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyCmZkYjIxY2YgYmxvY2s6IFJlZmFjdG9y
IG1hY3JvcyAtIGZpeCB0YWJiaW5nCmE3MmM3MTkgSURFOiBkZXByZWNhdGUgaWRlLWRyaXZlCgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzkgQ2hlY2tpbmcgY29tbWl0IGE3MmM3MTk0OWM5NyAoSURF
OiBkZXByZWNhdGUgaWRlLWRyaXZlKQoyLzkgQ2hlY2tpbmcgY29tbWl0IGZkYjIxY2YxYjk5YSAo
YmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0YWJiaW5nKQpFUlJPUjogTWFjcm9zIHdpdGgg
Y29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM1ODogRklM
RTogaW5jbHVkZS9ody9ibG9jay9ibG9jay5oOjY1OgorI2RlZmluZSBERUZJTkVfQkxPQ0tfQ0hT
X1BST1BFUlRJRVMoX3N0YXRlLCBfY29uZikgICAgICAgICAgICAgICAgICAgICAgXAorICAgIERF
RklORV9QUk9QX1VJTlQzMigiY3lscyIsIF9zdGF0ZSwgX2NvbmYuY3lscywgMCksICAgICAgICAg
ICAgICAgICAgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigiaGVhZHMiLCBfc3RhdGUsIF9jb25m
LmhlYWRzLCAwKSwgICAgICAgICAgICAgICAgXAogICAgIERFRklORV9QUk9QX1VJTlQzMigic2Vj
cyIsIF9zdGF0ZSwgX2NvbmYuc2VjcywgMCkKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
MzcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoz
LzkgQ2hlY2tpbmcgY29tbWl0IDM4YTFmNzliMDI2MyAoYmxvY2s6IFN1cHBvcnQgcHJvdmlkaW5n
IExDSFMgZnJvbSB1c2VyKQo0LzkgQ2hlY2tpbmcgY29tbWl0IDg5ZTk5ZDVlOTVkYiAoYm9vdGRl
dmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUykKNS85IENoZWNraW5nIGNvbW1pdCA3
NGU0YzU0MTEwYTMgKHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFjayB0byBzY3Np
LWhkKQo2LzkgQ2hlY2tpbmcgY29tbWl0IDgzMzhhYzQ3MjZmMSAoYm9vdGRldmljZTogR2F0aGVy
IExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcykKNy85IENoZWNraW5nIGNvbW1pdCA5NWNm
ZjI1ZGRjYzcgKGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNfbGlzdCkKOC85
IENoZWNraW5nIGNvbW1pdCA0MTdjMDZiNzkyNzcgKGJvb3RkZXZpY2U6IEZXX0NGRyBpbnRlcmZh
Y2UgZm9yIExDSFMgdmFsdWVzKQo5LzkgQ2hlY2tpbmcgY29tbWl0IDUxNGM5OTAyNDEwOCAoaGQt
Z2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVycmlkZSkKV0FSTklORzogQmxvY2sgY29t
bWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzYwNzogRklMRTogdGVz
dHMvaGQtZ2VvLXRlc3QuYzo5NjU6CisgICAgICAgICAgICAgICAgICAgICAgICJza2lwcGluZyBo
ZC1nZW8vb3ZlcnJpZGUvKiB0ZXN0cyIpOwoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1
NzggbGluZXMgY2hlY2tlZAoKUGF0Y2ggOS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDMx
MTU1NjM2LjE4NTg5LTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


