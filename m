Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABCAC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F95A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 03:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F95A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy6KS-0007z7-Kq
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 23:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1hy6Jj-00070j-0F
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 23:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hy6Jh-00019N-Bg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 23:20:46 -0400
Resent-Date: Wed, 14 Aug 2019 23:20:46 -0400
Resent-Message-Id: <E1hy6Jh-00019N-Bg@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hy6Jh-00017U-2y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 23:20:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565839233; cv=none; d=zoho.com; s=zohoarc; 
 b=ix6e1cPdDa0qpRJYC5vE6GVnB6iJhPHekxFlwHkUjhbD+kkIR+qZvSzMh6lDZrXk9AxjS6xpvuMsPKR49FKoZgidG6XU3zS01mft9Mbr9Jpkcv1UQL3DK3TaKfeuTMrWf14RycRogEbfhni3+Sjap5vhs6LhrtR8Rj7tzwSmZIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565839233;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=hyiDm99Y7gVR3L1CTrsUGqO22EPKV8qt9q1gqvFiOEg=; 
 b=F5Gu3d/A0wYc5msfzbCusleJeYnPb+Cp8uKwr1RcyEQkahlAL05lg8AiBZpQQTonIvMBpXrRzQqGv8y7YiP9bcfjlZK2x8mo3VZNCw8vbpnEmpVflXZE0YF83kLz0rTJeUvOhgpTFYdGRD+I/DOubGlg+s0pRasCzORt4gTX4Vk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565839229501855.6548970289311;
 Wed, 14 Aug 2019 20:20:29 -0700 (PDT)
In-Reply-To: <cover.1565814686.git.lukasstraub2@web.de>
Message-ID: <156583922839.3056.7768886745241439528@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lukasstraub2@web.de
Date: Wed, 14 Aug 2019 20:20:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH 0/3] colo: Add support for continious
 replication
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
Cc: chen.zhang@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTY1ODE0Njg2Lmdp
dC5sdWthc3N0cmF1YjJAd2ViLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0g
UEFDS0FHRVMgPT09IgpycG0gLXFhCgplY2hvCmVjaG8gIj09PSBVTkFNRSA9PT0iCnVuYW1lIC1h
CgpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApt
a2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJl
IC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlh
YmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFsbAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKICAgICAgICAgICAgICAgICBmcm9tIC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC02amk2cWZpMi9zcmMvaW5jbHVkZS9uZXQvZmlsdGVyLmg6MTMsCiAgICAgICAgICAg
ICAgICAgZnJvbSAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNmppNnFmaTIvc3JjL25ldC9m
aWx0ZXIuYzoxNDoKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZqaTZxZmkyL3NyYy9uZXQv
ZmlsdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG5ldGZpbHRlcl9jb21wbGV0ZeKAmToKL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLTZqaTZxZmkyL3NyYy9pbmNsdWRlL3FlbXUvcXVldWUuaDo0MTI6
NDQ6IGVycm9yOiDigJhwb3NpdGlvbuKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICA0MTIgfCAgICAgICAg
IChsaXN0ZWxtKS0+ZmllbGQudHFlX2NpcmMudHFsX3ByZXYgPSAmKGVsbSktPmZpZWxkLnRxZV9j
aXJjOyAgICAgICAgIFwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNmppNnFmaTIvc3JjL25ldC9m
aWx0ZXIuYzoyMzc6MjE6IG5vdGU6IOKAmHBvc2l0aW9u4oCZIHdhcyBkZWNsYXJlZCBoZXJlCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zl
ci4xNTY1ODE0Njg2LmdpdC5sdWthc3N0cmF1YjJAd2ViLmRlL3Rlc3RpbmcuczM5MHgvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


