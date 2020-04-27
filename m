Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D3C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C24820575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24820575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2vq-0007ce-9y
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT2uF-0004NO-2S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT2uE-0006FL-Fn
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:30:38 -0400
Resent-Date: Mon, 27 Apr 2020 08:30:38 -0400
Resent-Message-Id: <E1jT2uE-0006FL-Fn@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jT2uD-0006Ek-Sy
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587990628; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jn9aAbyb1rSOULHWM/3JFp1mGzLB9asvn5wMNYXFV+CO+Qlt2O1A9PU/DRisPEkPEm6ArM9FawgFo4BNbjk8xNm90qvjG8EdhWvnPRy+l63x5uR783Xle7+fJuE3gTPUWC5UERLTkJUsVKirHHvnYwRghe8riUecS+3WC1bxMoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587990628;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Isop7pLnIbwT7G4KsekZfFXUkjg8F7hjm1mpm8/haoM=; 
 b=DMYJDy8e9fxWUa8pYoVAzM/FYVTUN7vlh5FamcPjOsrVZl1WIrwI68GV9uNgjtBKM5k97Z3InLXv9ELfTaT2e+BhRbRWFHyiGS8puUh6TODaSTXhpY4FGg9Bmjn3BJq51nswiMSxx/ecKchFCqFbFtb3vXbaJQHdKcDYECCW+l0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587990627023535.7841873878533;
 Mon, 27 Apr 2020 05:30:27 -0700 (PDT)
In-Reply-To: <20200427121823.8094-1-changbin.du@gmail.com>
Subject: Re: [PATCH] ui/sdl2: fix segment fault caused by null pointer
 dereference
Message-ID: <158799062589.15667.13396530102330597831@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: changbin.du@gmail.com
Date: Mon, 27 Apr 2020 05:30:27 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 08:29:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: changbin.du@gmail.com, kraxel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNzEyMTgyMy44MDk0
LTEtY2hhbmdiaW4uZHVAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHVpL3NkbDI6IGZpeCBzZWdtZW50IGZhdWx0
IGNhdXNlZCBieSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UKTWVzc2FnZS1pZDogMjAyMDA0Mjcx
MjE4MjMuODA5NC0xLWNoYW5nYmluLmR1QGdtYWlsLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKY2M0
ZjA5MCB1aS9zZGwyOiBmaXggc2VnbWVudCBmYXVsdCBjYXVzZWQgYnkgbnVsbCBwb2ludGVyIGRl
cmVmZXJlbmNlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNl
c3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMzMjogRklMRTogdWkvc2RsMi5j
OjQxODoKKyAgICBpZiAoIXNjb25mKQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNz
YXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNDI6IEZJTEU6IHVpL3NkbDIuYzo0
MzA6CisgICAgaWYgKCFjb24pClsuLi5dCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDI3
IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBjYzRmMDkwYzA3YmMgKHVpL3NkbDI6IGZpeCBzZWdtZW50
IGZhdWx0IGNhdXNlZCBieSBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UpIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwNDI3MTIxODIzLjgwOTQtMS1jaGFuZ2Jpbi5kdUBnbWFpbC5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

