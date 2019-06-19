Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4072CC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165222187F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165222187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcvY-0006Mr-5I
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49125)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdcqW-0002DD-8X
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdcqU-0000dQ-9n
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:50:00 -0400
Resent-Date: Wed, 19 Jun 2019 11:49:59 -0400
Resent-Message-Id: <E1hdcqU-0000dQ-9n@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdcqQ-0000ar-Tk
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560958456; cv=none; d=zoho.com; s=zohoarc; 
 b=Vv03hzLG7idJrAPdC7sSoFaLWLSAKUlJi/DRULIiErSaXlrtPCOH2meCED0t46HoIbQzJmZGh9Sd8mV2Ko/wxAaIQDMEAawaKc986jUi+CmicjqsRjJ7POsSCYe/Os5zKIPIwbDZ9sfVmIEqxY0Xs1EOLLPrVPi0pBGAVXy4Kp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560958456;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=OZbKmD5t/uYinzZ8GtfjKYV1JtUZhe4WeUEd0XzAjPw=; 
 b=hy/8AgDoF//XICDWPajQuCdrdnZXz2qzkYz8WSIFTJYQdwB1HhxRU6qYLut8vhuBQfPu7SI0El+nUGRyW4m3J3DlwpzZuhGF8YqY/k7YOd1yqP3LUWRQGYS5HIUhSzC4U+o392qsrzaerOAp2vIiUgQlGE9WkPYPzh45rku+8fg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560958454640575.6058373330274;
 Wed, 19 Jun 2019 08:34:14 -0700 (PDT)
In-Reply-To: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <156095845369.27251.8364122209845482881@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Wed, 19 Jun 2019 08:34:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v12 0/5]
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwOTUzODM0LTI5NTg0LTEt
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
CiAgQ0MgICAgICBtaXBzNjRlbC1saW51eC11c2VyL2xpbnV4LXVzZXIvc3lzY2FsbC5vCiAgQ0Mg
ICAgICBtaXBzNjQtbGludXgtdXNlci9hY2NlbC90Y2cvdXNlci1leGVjLXN0dWIubwogIENDICAg
ICAgbWlwczY0LWxpbnV4LXVzZXIvbGludXgtdXNlci9tYWluLm8KL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLW8yaG1lMXhrL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzozMjQ6MTY6IGVycm9y
OiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYc3RhdHjigJkKICAzMjQgfCBfc3lzY2FsbDUoaW50
LCBzdGF0eCwgaW50LCBkaXJmZCwgY29uc3QgY2hhciAqLCBwYXRobmFtZSwgaW50LCBmbGFncywK
ICAgICAgfCAgICAgICAgICAgICAgICBefn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
bzJobWUxeGsvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIxNToxMzogbm90ZTogaW4gZGVmaW5p
dGlvbiBvZiBtYWNybyDigJhfc3lzY2FsbDXigJkKLS0tCiAgQ0MgICAgICBtaWNyb2JsYXplLWxp
bnV4LXVzZXIvZGlzYXMubwogIENDICAgICAgbWlwczY0LWxpbnV4LXVzZXIvbGludXgtdXNlci9z
eXNjYWxsLm8KICBDQyAgICAgIG1pcHM2NC1saW51eC11c2VyL2xpbnV4LXVzZXIvc3RyYWNlLm8K
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW8yaG1lMXhrL3NyYy9saW51eC11c2VyL3N5c2Nh
bGwuYzozMjQ6MTY6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3Ig4oCYc3RhdHjigJkKICAz
MjQgfCBfc3lzY2FsbDUoaW50LCBzdGF0eCwgaW50LCBkaXJmZCwgY29uc3QgY2hhciAqLCBwYXRo
bmFtZSwgaW50LCBmbGFncywKICAgICAgfCAgICAgICAgICAgICAgICBefn5+fgovdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtbzJobWUxeGsvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjIxNTox
Mzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDigJhfc3lzY2FsbDXigJkKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjA5NTM4MzQt
Mjk1ODQtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0
aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


