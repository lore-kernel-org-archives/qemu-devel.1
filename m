Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62BECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 20:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F6F20659
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 20:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F6F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKphf-0007WW-GO
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 16:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKpgW-0006rc-8Z
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 16:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKpgU-0004fl-Ge
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 16:14:15 -0400
Resent-Date: Wed, 16 Oct 2019 16:14:15 -0400
Resent-Message-Id: <E1iKpgU-0004fl-Ge@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKpgU-0004eu-BO; Wed, 16 Oct 2019 16:14:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571256829; cv=none; d=zoho.com; s=zohoarc; 
 b=jk1ESQGKOPftO51oPgpM9ugLLKk2YookeEBevNCkcV8tnGj9sVXosT6JVYgAXjiZrHS8h9SUs7AnSmgZkMrsoOkMTHHypYbMmsYYsbfZx+OMboR/XM2qBLNb9JYEswSflBT65YN3b8oJ7omor83HtSCoOXtbo+JxKH27lsl6dYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571256829;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=p7PXjWCullfhNN5Zz4mX/t/rE0Hi/pIUQqX2yzRIX/Q=; 
 b=H0zlCqFCimjAzSwma0fBBKC+SiQfdeipK9VQB/zs63YKipehZjgt0AEPjoXEqcV3njG/lOKNhn75sP1eYxMHlBLhxcj0FJRcg567cFjvTH6Tl4FkwQBwQaaObrKcYSnnez6g3QP5sHRmC+l+4DsIeRIXcwUciop0bYjO1YA86FE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157125682781069.5481411037905;
 Wed, 16 Oct 2019 13:13:47 -0700 (PDT)
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Subject: Re: [PATCH v8 0/8] Add Qemu to SeaBIOS LCHS interface
Message-ID: <157125682550.16217.17369072157851577767@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sameid@google.com
Date: Wed, 16 Oct 2019 13:13:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 philmd@redhat.com, seabios@seabios.org, qemu-devel@nongnu.org,
 jsnow@redhat.com, kevin@koconnor.net, liran.alon@oracle.com, kraxel@redhat.com,
 sameid@google.com, lersek@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNjE2NDE0NS4xMTU4
OTgtMS1zYW1laWRAZ29vZ2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY4IDAvOF0gQWRkIFFlbXUgdG8gU2VhQklPUyBM
Q0hTIGludGVyZmFjZQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMTYxNjQxNDUuMTE1
ODk4LTEtc2FtZWlkQGdvb2dsZS5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM0NWVkYmIgYm9vdGRldmljZTog
RldfQ0ZHIGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMKNzI5Y2U3NiBib290ZGV2aWNlOiBSZWZh
Y3RvciBnZXRfYm9vdF9kZXZpY2VzX2xpc3QKNDY4NTNiZCBib290ZGV2aWNlOiBHYXRoZXIgTENI
UyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzCjRmOWU1OTcgc2NzaTogUHJvcGFnYXRlIHVucmVh
bGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQKNTAxNzlhNyBib290ZGV2aWNlOiBBZGQgaW50ZXJm
YWNlIHRvIGdhdGhlciBMQ0hTCjk2OGNmMzMgYmxvY2s6IFN1cHBvcnQgcHJvdmlkaW5nIExDSFMg
ZnJvbSB1c2VyCmNjYjE3NDcgaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVycmlk
ZQo1MzhkYmQzIGJsb2NrOiBSZWZhY3RvciBtYWNyb3MgLSBmaXggdGFiYmluZwoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KMS84IENoZWNraW5nIGNvbW1pdCA1MzhkYmQzMjhhNmIgKGJsb2NrOiBSZWZh
Y3RvciBtYWNyb3MgLSBmaXggdGFiYmluZykKRVJST1I6IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFs
dWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNpcwojNTc6IEZJTEU6IGluY2x1ZGUv
aHcvYmxvY2svYmxvY2suaDo2NToKKyNkZWZpbmUgREVGSU5FX0JMT0NLX0NIU19QUk9QRVJUSUVT
KF9zdGF0ZSwgX2NvbmYpICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICBERUZJTkVfUFJPUF9V
SU5UMzIoImN5bHMiLCBfc3RhdGUsIF9jb25mLmN5bHMsIDApLCAgICAgICAgICAgICAgICAgIFwK
KyAgICBERUZJTkVfUFJPUF9VSU5UMzIoImhlYWRzIiwgX3N0YXRlLCBfY29uZi5oZWFkcywgMCks
ICAgICAgICAgICAgICAgIFwKICAgICBERUZJTkVfUFJPUF9VSU5UMzIoInNlY3MiLCBfc3RhdGUs
IF9jb25mLnNlY3MsIDApCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDM3IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDEvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi84IENoZWNraW5n
IGNvbW1pdCBjY2IxNzQ3ZjExYzUgKGhkLWdlby10ZXN0OiBBZGQgdGVzdHMgZm9yIGxjaHMgb3Zl
cnJpZGUpCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBh
cmF0ZSBsaW5lCiM2MDY6IEZJTEU6IHRlc3RzL2hkLWdlby10ZXN0LmM6OTY1OgorICAgICAgICAg
ICAgICAgICAgICAgICAic2tpcHBpbmcgaGQtZ2VvL292ZXJyaWRlLyogdGVzdHMiKTsKCnRvdGFs
OiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTc4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvOCBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgozLzggQ2hlY2tpbmcgY29tbWl0IDk2OGNmMzMwZWNiYyAo
YmxvY2s6IFN1cHBvcnQgcHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyKQo0LzggQ2hlY2tpbmcgY29t
bWl0IDUwMTc5YTdjNDQ3MyAoYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENI
UykKNS84IENoZWNraW5nIGNvbW1pdCA0ZjllNTk3YTMyYjggKHNjc2k6IFByb3BhZ2F0ZSB1bnJl
YWxpemUoKSBjYWxsYmFjayB0byBzY3NpLWhkKQo2LzggQ2hlY2tpbmcgY29tbWl0IDQ2ODUzYmQw
YjdiZiAoYm9vdGRldmljZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcykK
Ny84IENoZWNraW5nIGNvbW1pdCA3MjljZTc2NWE0OTkgKGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdl
dF9ib290X2RldmljZXNfbGlzdCkKOC84IENoZWNraW5nIGNvbW1pdCBjNDVlZGJiNjRmZGUgKGJv
b3RkZXZpY2U6IEZXX0NGRyBpbnRlcmZhY2UgZm9yIExDSFMgdmFsdWVzKQo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAxNjE2NDE0NS4xMTU4
OTgtMS1zYW1laWRAZ29vZ2xlLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


