Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D0C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 01:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5ED2063F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 01:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5ED2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfE4z-0000PU-P5
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 21:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfE3D-0008Iu-Tc
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 21:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfE3C-0001yL-OG
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 21:45:43 -0400
Resent-Date: Sun, 23 Jun 2019 21:45:43 -0400
Resent-Message-Id: <E1hfE3C-0001yL-OG@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfE39-0001g6-OK; Sun, 23 Jun 2019 21:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561340718; cv=none; d=zoho.com; s=zohoarc; 
 b=SW4Twp5pELC+YrnNEkybW4ISFKuFGHYhoQc36tr2Zx81WhpGrib02RmVH3vWry2danCr7GI7Iq/1udjCXWTC7pBQT4QDwNdv68FoHZvxN/hTfhkxQA5C7UxQwgOKBLNpy+DsXhPYbE7St2cGOIHvgT5O0Ba+wtjRJk7V8v94x/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561340718;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=pHVJbijS7cWQSISouc91jRd+saoMtCPKUZPMsMXvkjc=; 
 b=h9mT4RnDAe0/ihgDii9Y3sLg/B3roW04fR4WsioufMQSJrNpHvqwbRbwFxgn7XwiM59Pi2PnHCjhvuJTWo0Q66N6IFUUqYpU7TVIBrUbD70ehAznvln4b7Wri2qNBM5PtE7RzWoZ20d0d9vHkITivKe7ywLOdeh4NMi2aqkfa58=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561340715794600.3735617368848;
 Sun, 23 Jun 2019 18:45:15 -0700 (PDT)
In-Reply-To: <20190624013921.11944-1-sjitindarsingh@gmail.com>
Message-ID: <156134071469.4070.7317419299052660389@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sjitindarsingh@gmail.com
Date: Sun, 23 Jun 2019 18:45:15 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH] powerpc/spapr: Add host threads
 parameter to ibm, get_system_parameter
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sjitindarsingh@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNDAxMzkyMS4xMTk0
NC0xLXNqaXRpbmRhcnNpbmdoQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtRRU1VLVBQQ10gW1BBVENI
XSBwb3dlcnBjL3NwYXByOiBBZGQgaG9zdCB0aHJlYWRzIHBhcmFtZXRlciB0byBpYm0sIGdldF9z
eXN0ZW1fcGFyYW1ldGVyClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDYyNDAxMzkyMS4x
MTk0NC0xLXNqaXRpbmRhcnNpbmdoQGdtYWlsLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA2MjQwMTM5MjEuMTE5NDQt
MS1zaml0aW5kYXJzaW5naEBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE5MDYyNDAxMzkyMS4xMTk0
NC0xLXNqaXRpbmRhcnNpbmdoQGdtYWlsLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjI4NWRhMTFhYmQgcG93ZXJwYy9zcGFwcjogQWRkIGhvc3QgdGhyZWFkcyBwYXJhbWV0ZXIg
dG8gaWJtLCBnZXRfc3lzdGVtX3BhcmFtZXRlcgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6
IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAoj
MzY6IEZJTEU6IGh3L3BwYy9zcGFwcl9ydGFzLmM6MjM4OgorICAgIGlmICgha3ZtX2VuYWJsZWQo
KSkKWy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2Yg
dGhpcyBzdGF0ZW1lbnQKIzQwOiBGSUxFOiBody9wcGMvc3BhcHJfcnRhcy5jOjI0MjoKKyAgICBp
ZiAoIWRpcikKWy4uLl0KCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNTYgbGluZXMgY2hl
Y2tlZAoKQ29tbWl0IDI4NWRhMTFhYmRlNSAocG93ZXJwYy9zcGFwcjogQWRkIGhvc3QgdGhyZWFk
cyBwYXJhbWV0ZXIgdG8gaWJtLCBnZXRfc3lzdGVtX3BhcmFtZXRlcikgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTA2MjQwMTM5MjEuMTE5NDQtMS1zaml0aW5kYXJzaW5naEBnbWFpbC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


