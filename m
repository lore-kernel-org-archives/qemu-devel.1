Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E9BC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E4E206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E4E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37958 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZnO-0001Z5-8n
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdZls-0000ZL-UR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdZlr-0005jh-3X
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:33:00 -0400
Resent-Date: Wed, 19 Jun 2019 08:33:00 -0400
Resent-Message-Id: <E1hdZlr-0005jh-3X@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdZlp-0005gh-Eh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560944826; cv=none; d=zoho.com; s=zohoarc; 
 b=aGFkvb3wtP6eERroB730IPvqtLzJEIDNURZ5XqHwujxQJfiMmKoOh2XGBHjUpQkbXRle1yHAwefIhuglf4IXUsLxpLfnrWzoV4GcXRp00PCB2wQ2Wjhet/V+xd8DuMylclxQHg0yCQEfzIOtmUCcOUlSQIkEWAqwnPjoOkHjjFA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560944826;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=j29+Usq3Jq+mg0vUi2oIIN1s9ZHP7XKdzd/EgZnt4Q4=; 
 b=H9j+TCEGYk4xE692dRgxXwKDpoRo7J41jv2Q1PNZcaek/Ui1xGCEt71X+7EWzawRcyyJzG549NzMYANFVkfNT5h3gtaiCR/qldPPPz3JS1oGTKxaoJT44CSpGYYySHuRXa6wkCeTf7ksKkn3jA8zH/5W/O3dTs1vmSLnAtP2pmw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560944824558404.1510845374322;
 Wed, 19 Jun 2019 04:47:04 -0700 (PDT)
In-Reply-To: <1560942225-24728-1-git-send-email-stefan.brankovic@rt-rk.com>
Message-ID: <156094482372.27031.3686344990594718096@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefan.brankovic@rt-rk.com
Date: Wed, 19 Jun 2019 04:47:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/8] target/ppc: Optimize emulation of some
 Altivec instructions
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwOTQyMjI1LTI0NzI4LTEt
Z2l0LXNlbmQtZW1haWwtc3RlZmFuLmJyYW5rb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRl
dGFpbHMgYmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVz
dGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAoj
IEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBv
biB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0k
UFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JD
PSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxM
Cm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAt
ajQgVj0xCm1ha2UgaW5zdGFsbAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVj
aG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
Q0MgICAgICByaXNjdjY0LXNvZnRtbXUvYWNjZWwvdGNnL3RjZy1hbGwubwpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXdwNmVkbGd4L3NyYy90YXJnZXQv
cHBjL3RyYW5zbGF0ZS5jOjY4MjY6Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13cDZlZGxn
eC9zcmMvdGFyZ2V0L3BwYy90cmFuc2xhdGUvdm14LWltcGwuaW5jLmM6IEluIGZ1bmN0aW9uIOKA
mHRyYW5zX2x2c2zigJk6Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13cDZlZGxneC9zcmMv
dGFyZ2V0L3BwYy90cmFuc2xhdGUvdm14LWltcGwuaW5jLmM6NTIwOjI5OiBlcnJvcjogcGFzc2lu
ZyBhcmd1bWVudCAyIG9mIOKAmHRjZ19nZW5fZXh0X2kzMl9pNjTigJkgZnJvbSBpbmNvbXBhdGli
bGUgcG9pbnRlciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogIDUy
MCB8ICAgICB0Y2dfZ2VuX2V4dF9pMzJfaTY0KHNoLCBFQSk7CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwK
LS0tCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+
fn5+Xn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
d3A2ZWRsZ3gvc3JjL3RhcmdldC9wcGMvdHJhbnNsYXRlLmM6NjgyNjoKL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLXdwNmVkbGd4L3NyYy90YXJnZXQvcHBjL3RyYW5zbGF0ZS92bXgtaW1wbC5p
bmMuYzogSW4gZnVuY3Rpb24g4oCYdHJhbnNfbHZzcuKAmToKL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLXdwNmVkbGd4L3NyYy90YXJnZXQvcHBjL3RyYW5zbGF0ZS92bXgtaW1wbC5pbmMuYzo1
NTk6Mjk6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDIgb2Yg4oCYdGNnX2dlbl9leHRfaTMyX2k2
NOKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxl
LXBvaW50ZXItdHlwZXNdCiAgNTU5IHwgICAgIHRjZ19nZW5fZXh0X2kzMl9pNjQoc2gsIEVBKTsK
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4KICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfAoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMTU2MDk0MjIyNS0yNDcyOC0xLWdpdC1zZW5kLWVtYWlsLXN0ZWZh
bi5icmFua292aWNAcnQtcmsuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


