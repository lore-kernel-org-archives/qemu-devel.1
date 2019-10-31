Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1ACA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF212080F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF212080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQB7o-00055X-Gk
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iQB4D-0000vn-Ni
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iQB4C-0002nQ-5L
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:04:49 -0400
Resent-Date: Thu, 31 Oct 2019 10:04:49 -0400
Resent-Message-Id: <E1iQB4C-0002nQ-5L@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iQB4B-0002hA-Vi; Thu, 31 Oct 2019 10:04:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572530645; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GW7jlOFMHxWSUaV3z44vy1cUZdrFsiVPix0IXZyZfI823RvZsXYHO7kzDTS1Janv9/Qc9kvRPG/J4mCn2tEkKMMHLU9Wg0BKtdLfrb7VKnVTrmFG0KQZnf+gqu9OuLuC1YJjOhjJTrQnq+bOOlahopJk2PY+k1wJcyviLd7m9qQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572530645;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lT2AScA+mTLA3qNQN6qK5wi+iVsLJFOCwDu+4oNl3MI=; 
 b=kKw6v8Nknoxq/7mCfMvMex3t66loIZjqcp7Z9nZHdSU6Hgpeqx9BKzdXi/re/mdseI3wY63lqlvcJd/jovVGCQr19u0VMhHE2wVU9KrYOvRgXFwFgyY9iYHqrjjkplPAwK3+dcZmw33TbJK4GKnGWN2qan5AweSEp2Xq/XvFfu0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572530644050799.12091932135;
 Thu, 31 Oct 2019 07:04:04 -0700 (PDT)
In-Reply-To: <20191031105904.12194-1-jsnow@redhat.com>
Subject: Re: [libvirt] [PULL 0/9] Ide patches
Message-ID: <157253064186.11413.2788074989565438899@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Thu, 31 Oct 2019 07:04:04 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAzMTEwNTkwNC4xMjE5
NC0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtsaWJ2aXJ0XSBbUFVMTCAwLzldIElkZSBwYXRjaGVzClR5cGU6
IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAzMTEwNTkwNC4xMjE5NC0xLWpzbm93QHJlZGhhdC5j
b20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCmQyNzhjY2YgaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBv
dmVycmlkZQoyODgwN2Q3IGJvb3RkZXZpY2U6IEZXX0NGRyBpbnRlcmZhY2UgZm9yIExDSFMgdmFs
dWVzCjExZjI3ZjEgYm9vdGRldmljZTogUmVmYWN0b3IgZ2V0X2Jvb3RfZGV2aWNlc19saXN0CmUw
MzJmZWYgYm9vdGRldmljZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcwo3
NGViMzM0IHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFjayB0byBzY3NpLWhkCmUy
MTE0OTUgYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUwphNjgzOTc3IGJs
b2NrOiBTdXBwb3J0IHByb3ZpZGluZyBMQ0hTIGZyb20gdXNlcgowNzFhYzYzIGJsb2NrOiBSZWZh
Y3RvciBtYWNyb3MgLSBmaXggdGFiYmluZwo5MGU2Nzg5IElERTogZGVwcmVjYXRlIGlkZS1kcml2
ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCA5MGU2Nzg5OGUzYjkg
KElERTogZGVwcmVjYXRlIGlkZS1kcml2ZSkKMi85IENoZWNraW5nIGNvbW1pdCAwNzFhYzYzZWQw
OTIgKGJsb2NrOiBSZWZhY3RvciBtYWNyb3MgLSBmaXggdGFiYmluZykKRVJST1I6IE1hY3JvcyB3
aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNpcwojNTg6
IEZJTEU6IGluY2x1ZGUvaHcvYmxvY2svYmxvY2suaDo2NToKKyNkZWZpbmUgREVGSU5FX0JMT0NL
X0NIU19QUk9QRVJUSUVTKF9zdGF0ZSwgX2NvbmYpICAgICAgICAgICAgICAgICAgICAgIFwKKyAg
ICBERUZJTkVfUFJPUF9VSU5UMzIoImN5bHMiLCBfc3RhdGUsIF9jb25mLmN5bHMsIDApLCAgICAg
ICAgICAgICAgICAgIFwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoImhlYWRzIiwgX3N0YXRlLCBf
Y29uZi5oZWFkcywgMCksICAgICAgICAgICAgICAgIFwKICAgICBERUZJTkVfUFJPUF9VSU5UMzIo
InNlY3MiLCBfc3RhdGUsIF9jb25mLnNlY3MsIDApCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDM3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKMy85IENoZWNraW5nIGNvbW1pdCBhNjgzOTc3NTUxODAgKGJsb2NrOiBTdXBwb3J0IHByb3Zp
ZGluZyBMQ0hTIGZyb20gdXNlcikKNC85IENoZWNraW5nIGNvbW1pdCBlMjExNDk1MzE5MTkgKGJv
b3RkZXZpY2U6IEFkZCBpbnRlcmZhY2UgdG8gZ2F0aGVyIExDSFMpCjUvOSBDaGVja2luZyBjb21t
aXQgNzRlYjMzNDg5ZjcxIChzY3NpOiBQcm9wYWdhdGUgdW5yZWFsaXplKCkgY2FsbGJhY2sgdG8g
c2NzaS1oZCkKNi85IENoZWNraW5nIGNvbW1pdCBlMDMyZmVmZTMwOTggKGJvb3RkZXZpY2U6IEdh
dGhlciBMQ0hTIGZyb20gYWxsIHJlbGV2YW50IGRldmljZXMpCjcvOSBDaGVja2luZyBjb21taXQg
MTFmMjdmMWY5ZTEwIChib290ZGV2aWNlOiBSZWZhY3RvciBnZXRfYm9vdF9kZXZpY2VzX2xpc3Qp
CjgvOSBDaGVja2luZyBjb21taXQgMjg4MDdkNzhiYjAxIChib290ZGV2aWNlOiBGV19DRkcgaW50
ZXJmYWNlIGZvciBMQ0hTIHZhbHVlcykKOS85IENoZWNraW5nIGNvbW1pdCBkMjc4Y2NmZDE5NjUg
KGhkLWdlby10ZXN0OiBBZGQgdGVzdHMgZm9yIGxjaHMgb3ZlcnJpZGUpCldBUk5JTkc6IEJsb2Nr
IGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2MDc6IEZJTEU6
IHRlc3RzL2hkLWdlby10ZXN0LmM6OTY1OgorICAgICAgICAgICAgICAgICAgICAgICAic2tpcHBp
bmcgaGQtZ2VvL292ZXJyaWRlLyogdGVzdHMiKTsKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5n
cywgNTc4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDkvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
Lgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5
MTAzMTEwNTkwNC4xMjE5NC0xLWpzbm93QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


