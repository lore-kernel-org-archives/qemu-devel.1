Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC85C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062A62183F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062A62183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39040 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdc3q-0000kS-4z
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdc0S-0005cr-Dy
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdbwI-00035F-1q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:51:55 -0400
Resent-Date: Wed, 19 Jun 2019 10:51:55 -0400
Resent-Message-Id: <E1hdbwI-00035F-1q@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdbwH-00033Q-Ph
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:51:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560955864; cv=none; d=zoho.com; s=zohoarc; 
 b=UJhxg3TR3UylewJCqrpqTA3bf4lMeZrPmMVGVSNSWN1fSto+32EOwQ7JhxawQusXTqtCTqQZK8t6uvpMHmk3a6LXxpFp5cItfHn977SnJdpa35KWIDxBYPWAEEPTkcvtVbw9KrMwAe7zWWck6NEtVVHdU8rx0AGi5XGDYgplFms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560955864;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=DgYTPDm/jhL9gSG08V54cGgU5k/mDZuQ8p7w2Gj9pSQ=; 
 b=ZPprlNJnKyCe1Be1yLQIRKjXgl0QwMyaJ7nDqCVcjaZZQVLAhxNzS/zgdQxLVOAl2DieoQNCTRmntHeS7VlNncTxUKsJpl6GrY4CJLFNQg0Xaux+x20DMP2er45dh4Uqq48OBFmhdqIgPFlEk6TcpYKHOEFNvQVk5kwLHBxGL+A=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15609558632577.2080382852228695;
 Wed, 19 Jun 2019 07:51:03 -0700 (PDT)
In-Reply-To: <1560953429-29203-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <156095586224.27251.8001461197679356681@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Wed, 19 Jun 2019 07:51:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v11 0/5] linux-user: A set of miscellaneous
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwOTUzNDI5LTI5MjAzLTEt
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
CiAgQ0MgICAgICBtaWNyb2JsYXplZWwtbGludXgtdXNlci9hY2NlbC90Y2cvdHJhbnNsYXRvci5v
CiAgQ0MgICAgICBtaXBzNjRlbC1saW51eC11c2VyL2xpbnV4LXVzZXIvc3lzY2FsbC5vCiAgQ0Mg
ICAgICBtaXBzNjRlbC1saW51eC11c2VyL2xpbnV4LXVzZXIvc3RyYWNlLm8KL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLWJrcnE1ZHZoL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzozMjQ6MTY6
IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYc3RhdHjigJkKICAzMjQgfCBfc3lzY2Fs
bDUoaW50LCBzdGF0eCwgaW50LCBkaXJmZCwgY29uc3QgY2hhciAqLCBwYXRobmFtZSwgaW50LCBm
bGFncywKICAgICAgfCAgICAgICAgICAgICAgICBefn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtYmtycTVkdmgvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIxNToxMzogbm90ZTogaW4g
ZGVmaW5pdGlvbiBvZiBtYWNybyDigJhfc3lzY2FsbDXigJkKLS0tCiAgQ0MgICAgICBtaXBzNjQt
bGludXgtdXNlci9hY2NlbC9zdHVicy9odmYtc3R1Yi5vCiAgQ0MgICAgICBtaXBzZWwtbGludXgt
dXNlci9saW51eC11c2VyL21haW4ubwogIENDICAgICAgbWlwc2VsLWxpbnV4LXVzZXIvbGludXgt
dXNlci9zeXNjYWxsLm8KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWJrcnE1ZHZoL3NyYy9s
aW51eC11c2VyL3N5c2NhbGwuYzozMjQ6MTY6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig
4oCYc3RhdHjigJkKICAzMjQgfCBfc3lzY2FsbDUoaW50LCBzdGF0eCwgaW50LCBkaXJmZCwgY29u
c3QgY2hhciAqLCBwYXRobmFtZSwgaW50LCBmbGFncywKICAgICAgfCAgICAgICAgICAgICAgICBe
fn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYmtycTVkdmgvc3JjL2xpbnV4LXVzZXIv
c3lzY2FsbC5jOjIxNToxMzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDigJhfc3lzY2Fs
bDXigJkKLS0tCiAgQ0MgICAgICBtaXBzNjQtbGludXgtdXNlci9saW51eC11c2VyL3N5c2NhbGwu
bwogIENDICAgICAgbWlwczY0LWxpbnV4LXVzZXIvbGludXgtdXNlci9zdHJhY2UubwogIENDICAg
ICAgbWlwczY0LWxpbnV4LXVzZXIvbGludXgtdXNlci9tbWFwLm8KL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWJrcnE1ZHZoL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzozMjQ6MTY6IGVycm9y
OiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYc3RhdHjigJkKICAzMjQgfCBfc3lzY2FsbDUoaW50
LCBzdGF0eCwgaW50LCBkaXJmZCwgY29uc3QgY2hhciAqLCBwYXRobmFtZSwgaW50LCBmbGFncywK
ICAgICAgfCAgICAgICAgICAgICAgICBefn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
YmtycTVkdmgvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIxNToxMzogbm90ZTogaW4gZGVmaW5p
dGlvbiBvZiBtYWNybyDigJhfc3lzY2FsbDXigJkKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjA5NTM0MjktMjkyMDMtMS1naXQtc2VuZC1l
bWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLnMzOTB4Lz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


