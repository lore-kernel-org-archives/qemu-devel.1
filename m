Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2923BC5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C2D21655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C2D21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRD6r-0006Fv-6C
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRD6C-0005rR-Fb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRD6B-0002y1-4p
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:59:23 -0400
Resent-Date: Wed, 22 Apr 2020 06:59:23 -0400
Resent-Message-Id: <E1jRD6B-0002y1-4p@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRD6A-0002o4-Jf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587553149; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MVCiMB+vTwDxx8aeUBIZvDB91IzVMxT/D+M2lRSz0ERdwjXPbZgg+dmmfx4x4zePYVKdnxkq4n96kuLJhSN8oaDFFN3j41ZC1gTPGWfFl/XdCnb1LeKJVih3lclHRxY1IzqrzstVKLONu2mXNzMp93DiXoy+mfQ6HBfpoTXmxdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587553149;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aRVqNjnywyHJe+A9aOufFDtIv1WD0YE3DuXTESVF8Kc=; 
 b=l2gxDwFxcfIdlmkGwgMuruI/sSK1HN2z+QI7KfW0YZl8fReGyE4SWnod5JFYgp6scaCBOpDfAzomop+cmKPMSehEPSJnAGfqihf0e5Gp7EC5rArEx32Tfa0nu6LOqQ7TWadkK3+EpL8vMiytJE2Bh/qzoeanvw9A9NO1574fuQI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587553147897981.2845283886089;
 Wed, 22 Apr 2020 03:59:07 -0700 (PDT)
In-Reply-To: <20200422100211.30614-1-kraxel@redhat.com>
Subject: Re: [PATCH 0/5] ramfb: a bunch of reverts and fixes
Message-ID: <158755314647.861.3761670524204573772@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 22 Apr 2020 03:59:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 06:59:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjEwMDIxMS4zMDYx
NC0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC81XSByYW1mYjogYSBidW5jaCBvZiByZXZlcnRz
IGFuZCBmaXhlcwpNZXNzYWdlLWlkOiAyMDIwMDQyMjEwMDIxMS4zMDYxNC0xLWtyYXhlbEByZWRo
YXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBU
cnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRz
L2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBo
dHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAg
ICAgcGF0Y2hldy8yMDIwMDQyMjAxMTcyMi4xMzI4Ny0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmcgLT4gcGF0Y2hldy8yMDIwMDQyMjAxMTcyMi4xMzI4Ny0xLXJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmcKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDQyMjEwMDIxMS4z
MDYxNC0xLWtyYXhlbEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA0MjIxMDAyMTEuMzA2MTQt
MS1rcmF4ZWxAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjljYzBi
NmEgcmFtZmI6IGRyb3AgbGVmdG92ZXIgZGVidWcgbWVzc2FnZQpiMjhlMDQxIHJhbWZiOiBhZGQg
c2FuaXR5IGNoZWNrcyB0byByYW1mYl9jcmVhdGVfZGlzcGxheV9zdXJmYWNlCjI5YTU1YTggcmFt
ZmI6IGRvbid0IHVwZGF0ZSBSQU1GQlN0YXRlIG9uIGVycm9ycwowZmYwZGQ4IFJldmVydCAiaHcv
ZGlzcGxheS9yYW1mYjogbG9jayBndWVzdCByZXNvbHV0aW9uIGFmdGVyIGl0J3Mgc2V0IgpkYjUy
M2U1IFJldmVydCAiaHcvZGlzcGxheS9yYW1mYjogaW5pdGlhbGl6ZSBmdy1jb25maWcgc3BhY2Ug
d2l0aCB4cmVzLyB5cmVzIgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS81IENoZWNraW5nIGNvbW1p
dCBkYjUyM2U1NWNkZTAgKFJldmVydCAiaHcvZGlzcGxheS9yYW1mYjogaW5pdGlhbGl6ZSBmdy1j
b25maWcgc3BhY2Ugd2l0aCB4cmVzLyB5cmVzIikKMi81IENoZWNraW5nIGNvbW1pdCAwZmYwZGQ4
OTU1ZDMgKFJldmVydCAiaHcvZGlzcGxheS9yYW1mYjogbG9jayBndWVzdCByZXNvbHV0aW9uIGFm
dGVyIGl0J3Mgc2V0IikKMy81IENoZWNraW5nIGNvbW1pdCAyOWE1NWE4NGU0OTggKHJhbWZiOiBk
b24ndCB1cGRhdGUgUkFNRkJTdGF0ZSBvbiBlcnJvcnMpCkVSUk9SOiBicmFjZXMge30gYXJlIG5l
Y2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzQ2OiBGSUxFOiBody9kaXNw
bGF5L3JhbWZiLmM6ODk6CisgICAgaWYgKCFzdXJmYWNlKQpbLi4uXQoKdG90YWw6IDEgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAzNiBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzUgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KCjQvNSBDaGVja2luZyBjb21taXQgYjI4ZTA0MWNjMzE4IChyYW1mYjogYWRk
IHNhbml0eSBjaGVja3MgdG8gcmFtZmJfY3JlYXRlX2Rpc3BsYXlfc3VyZmFjZSkKNS81IENoZWNr
aW5nIGNvbW1pdCA5Y2MwYjZhMmVhNjkgKHJhbWZiOiBkcm9wIGxlZnRvdmVyIGRlYnVnIG1lc3Nh
Z2UpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNDIyMTAwMjExLjMwNjE0LTEta3JheGVsQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

