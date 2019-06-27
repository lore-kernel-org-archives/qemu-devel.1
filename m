Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F53C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 19:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467FB20645
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 19:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467FB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgZiB-0002TY-9A
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 15:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgZgV-0001tU-3Z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgZgT-0001Ce-Ez
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:03:51 -0400
Resent-Date: Thu, 27 Jun 2019 15:03:50 -0400
Resent-Message-Id: <E1hgZgT-0001Ce-Ez@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgZgT-0001BD-3i
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:03:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561662207; cv=none; d=zoho.com; s=zohoarc; 
 b=RIxMlVysxhR7XhnO3rZmrQd1kpNAkEoiLTLRTRkWdlI4yqQY9wh19KJTLRKVfAFZURWOxKYWC/ZFkf3cVx6ZsyHIH65C7JuaarobPu0617Ge1u+FIJzy2HJS9tGEJjpHEFEPDh/hVibH5rFjTMDXbu2nDRFa69qSJgRhNLqmWiQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561662207;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=kkX1/2nNvleaoDU7FINRSAW++OmsDxhYC0VWJVJqpuM=; 
 b=l4lkUshyJy5vE8LI0AGDtN79oJWxHf1+GVWl98FEl1bkDXEGDxmmxoZ/NCkq5kvh0mVfpsE8IbGnr0OB+h7tSquujvObq+CsxRkD7B7dfyE35JyRLL7PnphT0Z0gx2li1ixgnyFeiCN+cpbsAw/d8PPIVBVPxNgHbmbw0wA+TuA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561661300172958.5732780787811;
 Thu, 27 Jun 2019 11:48:20 -0700 (PDT)
Message-ID: <156166129897.6332.18171727399490168843@c4a48874b076>
In-Reply-To: <1561649510-21183-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Thu, 27 Jun 2019 11:48:20 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v14 0/5] linux-user: A set of miscellaneous
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNjQ5NTEwLTIxMTgzLTEt
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
CiAgQ0MgICAgICBtaXBzNjQtbGludXgtdXNlci9saW51eC11c2VyL21haW4ubwogIENDICAgICAg
bWlwczY0LWxpbnV4LXVzZXIvbGludXgtdXNlci9zeXNjYWxsLm8KICBDQyAgICAgIG1pcHNlbC1s
aW51eC11c2VyL3RodW5rLm8KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXhzMmN2YjRvL3Ny
Yy9saW51eC11c2VyL3N5c2NhbGwuYzozMjM6MTY6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBm
b3Ig4oCYc3RhdHjigJkKICAzMjMgfCBfc3lzY2FsbDUoaW50LCBzdGF0eCwgaW50LCBkaXJmZCwg
Y29uc3QgY2hhciAqLCBwYXRobmFtZSwgaW50LCBmbGFncywKICAgICAgfCAgICAgICAgICAgICAg
ICBefn5+fgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteHMyY3ZiNG8vc3JjL2xpbnV4LXVz
ZXIvc3lzY2FsbC5jOjIxNDoxMzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDigJhfc3lz
Y2FsbDXigJkKLS0tCiAgQ0MgICAgICBtaXBzZWwtbGludXgtdXNlci9hY2NlbC90Y2cvdXNlci1l
eGVjLXN0dWIubwogIENDICAgICAgbWlwc2VsLWxpbnV4LXVzZXIvbGludXgtdXNlci9tYWluLm8K
ICBDQyAgICAgIG1pcHNlbC1saW51eC11c2VyL2xpbnV4LXVzZXIvc3lzY2FsbC5vCi92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC14czJjdmI0by9zcmMvbGludXgtdXNlci9zeXNjYWxsLmM6MzIz
OjE2OiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmHN0YXR44oCZCiAgMzIzIHwgX3N5
c2NhbGw1KGludCwgc3RhdHgsIGludCwgZGlyZmQsIGNvbnN0IGNoYXIgKiwgcGF0aG5hbWUsIGlu
dCwgZmxhZ3MsCiAgICAgIHwgICAgICAgICAgICAgICAgXn5+fn4KL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLXhzMmN2YjRvL3NyYy9saW51eC11c2VyL3N5c2NhbGwuYzoyMTQ6MTM6IG5vdGU6
IGluIGRlZmluaXRpb24gb2YgbWFjcm8g4oCYX3N5c2NhbGw14oCZCi0tLQogIENDICAgICAgbWlw
czY0ZWwtbGludXgtdXNlci9saW51eC11c2VyL21haW4ubwogIENDICAgICAgbWlwczY0ZWwtbGlu
dXgtdXNlci9saW51eC11c2VyL3N5c2NhbGwubwogIENDICAgICAgbWlwczY0ZWwtbGludXgtdXNl
ci9saW51eC11c2VyL3N0cmFjZS5vCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC14czJjdmI0
by9zcmMvbGludXgtdXNlci9zeXNjYWxsLmM6MzIzOjE2OiBlcnJvcjogY29uZmxpY3RpbmcgdHlw
ZXMgZm9yIOKAmHN0YXR44oCZCiAgMzIzIHwgX3N5c2NhbGw1KGludCwgc3RhdHgsIGludCwgZGly
ZmQsIGNvbnN0IGNoYXIgKiwgcGF0aG5hbWUsIGludCwgZmxhZ3MsCiAgICAgIHwgICAgICAgICAg
ICAgICAgXn5+fn4KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXhzMmN2YjRvL3NyYy9saW51
eC11c2VyL3N5c2NhbGwuYzoyMTQ6MTM6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8g4oCY
X3N5c2NhbGw14oCZCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8xNTYxNjQ5NTEwLTIxMTgzLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5t
YXJrb3ZpY0BydC1yay5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


