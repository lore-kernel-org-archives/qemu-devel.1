Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FB8C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CC1205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CC1205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnXT-0003Ex-1v
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgnWU-0002am-6m
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgnWS-0007ZH-Bv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:50:26 -0400
Resent-Date: Fri, 28 Jun 2019 05:50:25 -0400
Resent-Message-Id: <E1hgnWS-0007ZH-Bv@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgnWQ-0007UO-DX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:50:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561715403; cv=none; d=zoho.com; s=zohoarc; 
 b=LeyvCFDD7p7XTZ0nM1Mn+aMdFJtaxHQ6pfu825oRHlEtEfiLsRaiMd8LrwP6QBEyjBrhDMfysJUFx6U7Zysw2+/nZ9d6whmFlZQhVZBJDgxO9e2OsUYHt0K+h7j5EgdzvVx4MK+DbZv89RZXW6+5HTvChgrBw38xH/NLw93FW2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561715403;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Z5Nc5gJwtAooU2d6hc5XXPfB5gvyTQsJtnoeYjNdAHk=; 
 b=KVfp4mwBzZkeGaJJsWb7V8eJbsgxtoVLyJBGnicUuUGHlf9Jmwj3XZ2dyNzC5FgT7gnMjw0k7Lpu9kwVHIpuu0r2Y8VimltSbPjBhjx8TFlI9DHGpagrGhNW3dVaJXivHIyIhuvNlKUJJbteehKvH01J6OXBIi49vZVomRsPT+A=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156171539598038.013847031470505;
 Fri, 28 Jun 2019 02:49:55 -0700 (PDT)
Message-ID: <156171539473.6332.3788894025347542150@c4a48874b076>
In-Reply-To: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 28 Jun 2019 02:49:55 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v15 0/5] linux-user: A set of miscellaneous
 patches
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNzEyMDgyLTMxNDQxLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhl
IGRldGFpbHMgYmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMg
VGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0
aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGll
ZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFM
TD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwK
U1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNU
QUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVj
ayAtajQgVj0xCm1ha2UgaW5zdGFsbAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hv
CmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CiAgQ0MgICAgICBtaWNyb2JsYXplLWxpbnV4LXVzZXIvbGludXgtdXNlci9zdHJhY2UubwogIEND
ICAgICAgbWlwczY0ZWwtbGludXgtdXNlci9saW51eC11c2VyL3N5c2NhbGwubwogIExJTksgICAg
bWljcm9ibGF6ZWVsLWxpbnV4LXVzZXIvcWVtdS1taWNyb2JsYXplZWwKL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLXRyMHd2b3l6L3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzozMjI6MTY6IGVy
cm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYc3RhdHjigJkKICAzMjIgfCBfc3lzY2FsbDUo
aW50LCBzdGF0eCwgaW50LCBkaXJmZCwgY29uc3QgY2hhciAqLCBwYXRobmFtZSwgaW50LCBmbGFn
cywKICAgICAgfCAgICAgICAgICAgICAgICBefn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtdHIwd3ZveXovc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIxMzoxMzogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyDigJhfc3lzY2FsbDXigJkKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjE3MTIwODItMzE0NDEtMS1naXQtc2Vu
ZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLnMzOTB4Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


