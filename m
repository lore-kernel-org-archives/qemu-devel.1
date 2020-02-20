Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9474AC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6DD2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6DD2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jJc-0007Fe-Df
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j4jJ3-0006jX-GZ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:43:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j4jJ2-0003Z2-2n
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:43:45 -0500
Resent-Date: Thu, 20 Feb 2020 05:43:45 -0500
Resent-Message-Id: <E1j4jJ2-0003Z2-2n@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j4jJ1-0003Ym-Mu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:43:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582195416; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WAlV677k6kPql6EIpkpo0XS+mh/rXwuu1NVj4Al46A8aaPe6Sd6WDGUD1lMdHjOzkvxPeBXn+8zEBwkcMfjv7N7/ymHq2NLz1Qkzz460xzwqma4hnCvfmd2qerBzu1IE+I6ll5gX5Ru6zhOkX/b5H2gUxn6EbI51bhw8YgaPsQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582195416;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=o/IBksAFgh78ilKmkaXcMyaw+YcfzBYv23n71lIdKY0=; 
 b=nCjX5WzQxo4HxJ8MS+Dh7vBdXXhQkS83aOjUfMuvqyeykYsebvqhgn0Q4YrlpmYTmU30IQzc/fzZlXiGHlzFQtOT8xPtFU0AINjcVDFG/xLAiMQGDSOYbB3xDC8iofgwRPKCwYsX00ETir5rZzLDN8/OP/p3KQgd9mQODN9bvI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582195415039237.70904310927324;
 Thu, 20 Feb 2020 02:43:35 -0800 (PST)
In-Reply-To: <20200220103828.24525-1-pbonzini@redhat.com>
Subject: Re: [PATCH] rcu_queue: add QSLIST functions
Message-ID: <158219541398.24906.10765707265472572410@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Thu, 20 Feb 2020 02:43:35 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIyMDEwMzgyOC4yNDUy
NS0xLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSF0gcmN1X3F1ZXVlOiBhZGQgUVNMSVNUIGZ1bmN0
aW9ucwpNZXNzYWdlLWlkOiAyMDIwMDIyMDEwMzgyOC4yNDUyNS0xLXBib256aW5pQHJlZGhhdC5j
b20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBw
YXRjaGV3LzIwMjAwMjIwMDQxMTE4LjIzMjY0LTEtYWx4bmRyQGJ1LmVkdSAtPiBwYXRjaGV3LzIw
MjAwMjIwMDQxMTE4LjIzMjY0LTEtYWx4bmRyQGJ1LmVkdQogKiBbbmV3IHRhZ10gICAgICAgICBw
YXRjaGV3LzIwMjAwMjIwMTAzODI4LjI0NTI1LTEtcGJvbnppbmlAcmVkaGF0LmNvbSAtPiBwYXRj
aGV3LzIwMjAwMjIwMTAzODI4LjI0NTI1LTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjkwOTExNGIgcmN1X3F1ZXVlOiBhZGQgUVNMSVNUIGZ1bmN0
aW9ucwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEg
bGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzI2OiBGSUxFOiBpbmNsdWRlL3FlbXUvcXVl
dWUuaDoyMTc6Cit9IHdoaWxlICgvKkNPTlNUQ09ORCovMCkKCldBUk5JTkc6IEJsb2NrIGNvbW1l
bnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2MTogRklMRTogaW5jbHVk
ZS9xZW11L3JjdV9xdWV1ZS5oOjI3ODoKK30gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQoKV0FSTklO
RzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzY2
OiBGSUxFOiBpbmNsdWRlL3FlbXUvcmN1X3F1ZXVlLmg6MjgzOgorfSB3aGlsZSAoLypDT05TVENP
TkQqLzApCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2Vw
YXJhdGUgbGluZQojNzA6IEZJTEU6IGluY2x1ZGUvcWVtdS9yY3VfcXVldWUuaDoyODc6Cit9IHdo
aWxlICgvKkNPTlNUQ09ORCovMCkKCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRp
bmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM4MzogRklMRTogaW5jbHVkZS9xZW11L3JjdV9xdWV1
ZS5oOjMwMDoKK30gd2hpbGUgKC8qQ09OU1RDT05EKi8wKQoKRVJST1I6IGNvZGUgaW5kZW50IHNo
b3VsZCBuZXZlciB1c2UgdGFicwojMTQxOiBGSUxFOiB0ZXN0cy90ZXN0LXJjdS1saXN0LmM6MTU1
OgorXkkgUVNMSVNUX1JFTU9WRV9SQ1UoJlFfbGlzdF9oZWFkLCBlbCwgbGlzdF9lbGVtZW50LCBm
KSQKCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRB
SU5FUlMgbmVlZCB1cGRhdGluZz8KIzE1MzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDog
MSBlcnJvcnMsIDYgd2FybmluZ3MsIDExOSBsaW5lcyBjaGVja2VkCgpDb21taXQgOTA5MTE0YjVm
Zjg5IChyY3VfcXVldWU6IGFkZCBRU0xJU1QgZnVuY3Rpb25zKSBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDIyMDEwMzgyOC4yNDUyNS0xLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

