Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E41CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB2F2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB2F2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaIO-0003GS-P1
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMaHN-0002ne-Du
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMaHL-000693-Oy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:11:33 -0400
Resent-Date: Mon, 21 Oct 2019 12:11:33 -0400
Resent-Message-Id: <E1iMaHL-000693-Oy@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMaHL-00068p-Je
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:11:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571674275; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TmL6xaoKzBHElckuFjQi0cLn02HnWtTINeD50jg/RqegB+CV1NwDOGpG+gJ4JPDadHr7WVVjY3i0NO0w9zYjnS4qmUHQ6ALwneh4QOeM//Jn53KOXZpxLYBx/P5+kjcNAAkhzAjS2vP2pRKogClj5mWGgg28Ma695o15XQDMAzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571674275;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=y1H2CMS+FQwrzWMzXcYCRR+wRBa/bpcN1M/zXKCF1x0=; 
 b=GQ1NoaeCXn/OU9DwSicOBikwUwCDXeUnExArkqjSQRSZx8HdWvKGZWyXI4BoxWxqUk0C8IZo1+LcyECtmuGI0U7rV8iTv5MPNI5zFq0Kyg9GSNtsE4TFXDT9ir/l3MS/o4MBy4kp4bNWo99TK9oiey7tyvUKBzON0NSUdTxQFBQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571674273960643.1125226444449;
 Mon, 21 Oct 2019 09:11:13 -0700 (PDT)
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
Subject: Re: [PATCH v8 0/9] linux-user: strace improvements
Message-ID: <157167427263.7343.1757104845884426341@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 21 Oct 2019 09:11:13 -0700 (PDT)
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
Cc: f4bug@amsat.org, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMTExNDg1Ny4yMDUz
OC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY4IDAvOV0gbGludXgtdXNlcjogc3RyYWNlIGltcHJv
dmVtZW50cwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMjExMTQ4NTcuMjA1MzgtMS1m
NGJ1Z0BhbXNhdC5vcmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRh
dGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBh
dGNoZXcvMjAxOTEwMjExNDU4MzkuMTI2ODQtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcgLT4g
cGF0Y2hldy8yMDE5MTAyMTE0NTgzOS4xMjY4NC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjkxM2YxODQgbGludXgtdXNlci9zeXNjYWxs
OiBBbGlnbiB0YXJnZXRfc29ja2FkZHIgZmllbGRzIHVzaW5nIEFCSSB0eXBlcwoxZmZiOTg2Yjcg
bGludXgtdXNlci9zdHJhY2U6IExldCBwcmludF9zb2NrYWRkcigpIGhhdmUgYSAnbGFzdCcgYXJn
dW1lbnQKNmEwNTI4MyBsaW51eC11c2VyL3N0cmFjZTogSW1wcm92ZSBiaW5kKCkgb3V0cHV0Cjhm
OWY1ZDEgbGludXgtdXNlci9zdHJhY2U6IEFkZCBwcmludF9zb2NrZmQoKQplNzY0MGNkIGxpbnV4
LXVzZXIvc3RyYWNlOiBEdW1wIEFGX05FVExJTksgc29ja2FkZHIgY29udGVudApkMDdlNzYzIGxp
bnV4LXVzZXIvc3lzY2FsbDogSW50cm9kdWNlIHRhcmdldF9zb2NrYWRkcl9ubAphODkxZjllIGxp
bnV4LXVzZXIvc3RyYWNlOiBJbXByb3ZlIHNldHRpbWVvZmRheSgpCjNiNDRhNmUgbGludXgtdXNl
ci9zdHJhY2U6IEFkZCBwcmludF90aW1lem9uZSgpCjc4ZDg2NDcgbGludXgtdXNlci9zdHJhY2U6
IERpc3BsYXkgaW52YWxpZCBwb2ludGVyIGluIHByaW50X3RpbWV2YWwoKQoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCA3OGQ4NjQ3MTdmNGQgKGxpbnV4LXVzZXIvc3Ry
YWNlOiBEaXNwbGF5IGludmFsaWQgcG9pbnRlciBpbiBwcmludF90aW1ldmFsKCkpCjIvOSBDaGVj
a2luZyBjb21taXQgM2I0NGE2ZTMzMzJjIChsaW51eC11c2VyL3N0cmFjZTogQWRkIHByaW50X3Rp
bWV6b25lKCkpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5n
IG9mIHRoZSBkZWNsYXJhdGlvbgojMjA6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6NjY6CitV
TlVTRUQgc3RhdGljIHZvaWQgcHJpbnRfdGltZXpvbmUoYWJpX3Vsb25nLCBpbnQpOwoKdG90YWw6
IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzMiBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzkgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvOSBDaGVja2luZyBjb21taXQgYTg5MWY5ZWZkY2ZiIChs
aW51eC11c2VyL3N0cmFjZTogSW1wcm92ZSBzZXR0aW1lb2ZkYXkoKSkKNC85IENoZWNraW5nIGNv
bW1pdCBkMDdlNzYzYWM0ODUgKGxpbnV4LXVzZXIvc3lzY2FsbDogSW50cm9kdWNlIHRhcmdldF9z
b2NrYWRkcl9ubCkKNS85IENoZWNraW5nIGNvbW1pdCBlNzY0MGNkNDYwODMgKGxpbnV4LXVzZXIv
c3RyYWNlOiBEdW1wIEFGX05FVExJTksgc29ja2FkZHIgY29udGVudCkKNi85IENoZWNraW5nIGNv
bW1pdCA4ZjlmNWQxNjJkOTkgKGxpbnV4LXVzZXIvc3RyYWNlOiBBZGQgcHJpbnRfc29ja2ZkKCkp
CjcvOSBDaGVja2luZyBjb21taXQgNmEwNTI4MzM3OGVmIChsaW51eC11c2VyL3N0cmFjZTogSW1w
cm92ZSBiaW5kKCkgb3V0cHV0KQo4LzkgQ2hlY2tpbmcgY29tbWl0IDFmZmI5ODZiNzZiMiAobGlu
dXgtdXNlci9zdHJhY2U6IExldCBwcmludF9zb2NrYWRkcigpIGhhdmUgYSAnbGFzdCcgYXJndW1l
bnQpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRo
ZSBkZWNsYXJhdGlvbgojMjI6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6NzA6CitVTlVTRUQg
c3RhdGljIHZvaWQgcHJpbnRfc29ja2FkZHIoYWJpX3Vsb25nLCBhYmlfbG9uZywgaW50KTsKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNDAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC85IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo5LzkgQ2hlY2tpbmcgY29tbWl0IDkxM2YxODQwZDFi
ZSAobGludXgtdXNlci9zeXNjYWxsOiBBbGlnbiB0YXJnZXRfc29ja2FkZHIgZmllbGRzIHVzaW5n
IEFCSSB0eXBlcykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTEwMjExMTQ4NTcuMjA1MzgtMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


