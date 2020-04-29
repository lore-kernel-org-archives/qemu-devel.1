Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC284C83006
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A9520787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A9520787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTpnh-0000QV-LF
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:43:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTplj-0007mY-Ob
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTpi7-0005fK-2q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:41:07 -0400
Resent-Date: Wed, 29 Apr 2020 12:41:07 -0400
Resent-Message-Id: <E1jTpi7-0005fK-2q@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTpi6-0005Pn-8d
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588178227; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gCFT0uZ1aqYKMqQZmPfWRvEaNkpqeTCxWtyMGcRKRc7EQlIQ5JsSniBC6mMIiDG4/N5mwU/Q1bvmI7h+SqeszK9Km7vXKrpInjlC1uK/ljj6MNb0pA5Wk3ThEFCpdkpxcvDD9xuAyV3Nz1zkIR1ue4RxCL3tSmShtAoS5rnMKUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588178227;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1ZNePUhN7zidCvmmLQSfnxxbfAS39TDAtg65IPNZOzk=; 
 b=E7IJ+VxM7c6ODJYtEcclOnEsrFYodkDkSTKoPpKrmslceZhcHZmKmsIzfh4zbRk4J+2q8JBdjLEB9YsgwhmcKO1YxMd5DhyPP3R8kRXTmDMpGI4h6KUu/lJCoMOjD6hxF6gWY4dKt+YMepSUip5v5bFivgreBE83CKipWAhdU8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15881782253491008.6319063130279;
 Wed, 29 Apr 2020 09:37:05 -0700 (PDT)
Message-ID: <158817822391.2106.812965025966549690@45ef0f9c86ae>
In-Reply-To: <20200429115236.28709-1-kraxel@redhat.com>
Subject: Re: [PATCH v2 0/6] ramfb: a bunch of reverts and fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 29 Apr 2020 09:37:05 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:03:04
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
Cc: hqm03ster@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 kraxel@redhat.com, pbonzini@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTExNTIzNi4yODcw
OS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDQyOTExNTIzNi4yODcwOS0xLWtyYXhlbEByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzZdIHJhbWZiOiBhIGJ1bmNoIG9mIHJldmVydHMg
YW5kIGZpeGVzClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjA2MjA3YyByYW1mYjogZml4IHNp
emUgY2FsY3VsYXRpb24KMzUwM2M3YiByYW1mYjogYWRkIHNhbml0eSBjaGVja3MgdG8gcmFtZmJf
Y3JlYXRlX2Rpc3BsYXlfc3VyZmFjZQo3OGI2ZTIwIHJhbWZiOiBkb24ndCB1cGRhdGUgUkFNRkJT
dGF0ZSBvbiBlcnJvcnMKOTY2NDgyMjMgcmFtZmI6IGRyb3AgbGVmdG92ZXIgZGVidWcgbWVzc2Fn
ZQozMjlmZTRlIFJldmVydCAiaHcvZGlzcGxheS9yYW1mYjogbG9jayBndWVzdCByZXNvbHV0aW9u
IGFmdGVyIGl0J3Mgc2V0Igo5ZmVkOTVkIFJldmVydCAiaHcvZGlzcGxheS9yYW1mYjogaW5pdGlh
bGl6ZSBmdy1jb25maWcgc3BhY2Ugd2l0aCB4cmVzLyB5cmVzIgoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KMS82IENoZWNraW5nIGNvbW1pdCA5ZmVkOTVkZWQxYzEgKFJldmVydCAiaHcvZGlzcGxheS9y
YW1mYjogaW5pdGlhbGl6ZSBmdy1jb25maWcgc3BhY2Ugd2l0aCB4cmVzLyB5cmVzIikKMi82IENo
ZWNraW5nIGNvbW1pdCAzMjlmZTRlNmY2OGQgKFJldmVydCAiaHcvZGlzcGxheS9yYW1mYjogbG9j
ayBndWVzdCByZXNvbHV0aW9uIGFmdGVyIGl0J3Mgc2V0IikKMy82IENoZWNraW5nIGNvbW1pdCA5
NjY0ODIyM2MzM2EgKHJhbWZiOiBkcm9wIGxlZnRvdmVyIGRlYnVnIG1lc3NhZ2UpCjQvNiBDaGVj
a2luZyBjb21taXQgNzhiNmUyMGRjMDlmIChyYW1mYjogZG9uJ3QgdXBkYXRlIFJBTUZCU3RhdGUg
b24gZXJyb3JzKQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9m
IHRoaXMgc3RhdGVtZW50CiM0NjogRklMRTogaHcvZGlzcGxheS9yYW1mYi5jOjg3OgorICAgIGlm
ICghc3VyZmFjZSkKWy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzQgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNC82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzYgQ2hlY2tp
bmcgY29tbWl0IDM1MDNjN2I5ZDc3OCAocmFtZmI6IGFkZCBzYW5pdHkgY2hlY2tzIHRvIHJhbWZi
X2NyZWF0ZV9kaXNwbGF5X3N1cmZhY2UpCjYvNiBDaGVja2luZyBjb21taXQgNjA2MjA3YzYwZDI1
IChyYW1mYjogZml4IHNpemUgY2FsY3VsYXRpb24pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI5MTE1MjM2LjI4NzA5LTEta3JheGVsQHJl
ZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

