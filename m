Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F048AC004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87F021537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87F021537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknwk-0003Cv-1Z
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hknvm-0002Zz-Lp
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hknvl-0006b4-By
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:05:06 -0400
Resent-Date: Tue, 09 Jul 2019 07:05:06 -0400
Resent-Message-Id: <E1hknvl-0006b4-By@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hknvl-0006SL-12
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:05:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562670250; cv=none; d=zoho.com; s=zohoarc; 
 b=CB9dljHCMuOn/2tBh3l8lgI6gDJaUR2j/VwXUQ5ReoO6VVDxKu0eis3uOwHL1FwZ5KF104giuJormtfHaGoanWcfVCOIM5gq+7tRq7CtLC//30CdJXpMTzsHt0+ADJHnQIlxJ7MH8uaKbN8nP0Jj8A0xG/yUjZs0Y1JZQY/GgaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562670250;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=X45Qu5Qqpz6z3pdI4b6p0h7J6ZEq2p+WMBfQKxmPJY4=; 
 b=X/arq2aCSRbMP1cxCo+X9tRegbRGDVPqUbfcq0w0Y420Kp7Hi+R2WFN6tER1jm3asuG8AzJ+GEeq6k6LIWeA6vV5uvzChLyfjvgR6vHpnc7TJxSOPS7wCnZMsSvNMq38Q8yzvZyjGFR6+TUkryqBsfTecnHHIwqwhP0AIFTiiTM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562670248942811.6344120423225;
 Tue, 9 Jul 2019 04:04:08 -0700 (PDT)
Message-ID: <156267024761.29610.14008284624779790468@c4a48874b076>
In-Reply-To: <20190709092049.13771-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 9 Jul 2019 04:04:08 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/5] tcg: Fix mmap_lock assertion failure,
 take 2
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwOTA5MjA0OS4xMzc3
MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNzA5MDkyMDQ5LjEzNzcxLTEt
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENI
IDAvNV0gdGNnOiBGaXggbW1hcF9sb2NrIGFzc2VydGlvbiBmYWlsdXJlLCB0YWtlIDIKVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczov
L2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0
Y2hldy8yMDE5MDcwOTA5MjA0OS4xMzc3MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcg
LT4gcGF0Y2hldy8yMDE5MDcwOTA5MjA0OS4xMzc3MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4ZTllOTY4IHRjZzogUmVsZWFz
ZSBtbWFwX2xvY2sgb24gdHJhbnNsYXRpb24gZmF1bHQKOTg1NDc4YiB0Y2c6IFJlbW92ZSBkdXBs
aWNhdGUgI2lmICFkZWZpbmVkKENPREVfQUNDRVNTKQozNDk5OWJlIHRjZzogUmVtb3ZlIGNwdV9s
ZCpfY29kZV9yYQo4ZmI4YmJjIHRjZzogSW50cm9kdWNlIHNldC9jbGVhcl9oZWxwZXJfcmV0YWRk
cgplNTgxYTI5IGluY2x1ZGUvcWVtdS9hdG9taWMuaDogQWRkIHNpZ25hbF9iYXJyaWVyCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IGU1ODFhMjllZTM3OSAoaW5jbHVk
ZS9xZW11L2F0b21pYy5oOiBBZGQgc2lnbmFsX2JhcnJpZXIpCjIvNSBDaGVja2luZyBjb21taXQg
OGZiOGJiYzhmYWQ2ICh0Y2c6IEludHJvZHVjZSBzZXQvY2xlYXJfaGVscGVyX3JldGFkZHIpCjMv
NSBDaGVja2luZyBjb21taXQgMzQ5OTliZTk2ODk2ICh0Y2c6IFJlbW92ZSBjcHVfbGQqX2NvZGVf
cmEpCjQvNSBDaGVja2luZyBjb21taXQgOTg1NDc4YjFiMDg2ICh0Y2c6IFJlbW92ZSBkdXBsaWNh
dGUgI2lmICFkZWZpbmVkKENPREVfQUNDRVNTKSkKNS81IENoZWNraW5nIGNvbW1pdCA4ZTllOTY4
M2E2MmEgKHRjZzogUmVsZWFzZSBtbWFwX2xvY2sgb24gdHJhbnNsYXRpb24gZmF1bHQpCkVSUk9S
OiB0cmFpbGluZyB3aGl0ZXNwYWNlCiM3ODogRklMRTogYWNjZWwvdGNnL3VzZXItZXhlYy5jOjEw
MzoKKyAgICAgICAgICogJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMjAgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNS81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwOTA5MjA0OS4x
Mzc3MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


