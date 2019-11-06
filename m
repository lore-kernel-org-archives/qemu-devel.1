Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30622C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06942178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06942178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGhW-0004Oj-6i
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSGfK-0002p3-2M
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSGfE-0008WT-MH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:27:45 -0500
Resent-Date: Wed, 06 Nov 2019 03:27:45 -0500
Resent-Message-Id: <E1iSGfE-0008WT-MH@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSGfE-0008VS-Eg
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:27:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573028851; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FTcPQYK/0vU39XcMgqVYO9Os+hfGVvJ6TD1qhEEt0LbvzXr//+vWx5smG5d/jQJ0ilOeLY6Jysgnv2LBPWu83IKXdiwtYd6ZIBIBrp9SvZhNGOOaJZIQb+NAL/OwFYs3lJRnRDV3y6cyWdwb1TrTAaXVVZx36Sjoe5SjkFmDXgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573028851;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=pFRD+RJGajdidoeJvLJ+Xh7u0AHEeMheB60yYAKHxaM=; 
 b=klKGnrYjSahs/gp9ER99rQADNlBxxiOUC56YGV2kWqh57y0jBUUNl5mjvuDwiGnrSGzsXZS1ZuJmJ0ShvhxvW9bynJr4i0MZqdHLzTcO7hISEqv/X1+aNJhbjiTzgKfPWahP7GD/5A4tdqU9eJrx7n0DpLlusG5oEigWi54Dq3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573028849398598.290101807603;
 Wed, 6 Nov 2019 00:27:29 -0800 (PST)
In-Reply-To: <1572477125-25344-2-git-send-email-raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] vhost-user: Refractor vhost_user_set_mem_table Functions
Message-ID: <157302884819.21358.14919608537832624226@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: raphael.norwitz@nutanix.com
Date: Wed, 6 Nov 2019 00:27:29 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: raphael.norwitz@nutanix.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcyNDc3MTI1LTI1MzQ0LTIt
Z2l0LXNlbmQtZW1haWwtcmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tLwoKCgpIaSwKClRoaXMg
c2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRw
dXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHZob3N0LXVz
ZXI6IFJlZnJhY3RvciB2aG9zdF91c2VyX3NldF9tZW1fdGFibGUgRnVuY3Rpb25zClR5cGU6IHNl
cmllcwpNZXNzYWdlLWlkOiAxNTcyNDc3MTI1LTI1MzQ0LTItZ2l0LXNlbmQtZW1haWwtcmFwaGFl
bC5ub3J3aXR6QG51dGFuaXguY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozY2Q5ZWVlIHZob3N0LXVzZXI6IFJl
ZnJhY3RvciB2aG9zdF91c2VyX3NldF9tZW1fdGFibGUgRnVuY3Rpb25zCgo9PT0gT1VUUFVUIEJF
R0lOID09PQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNTM6IEZJTEU6IGh3L3Zp
cnRpby92aG9zdC11c2VyLmM6NDMzOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnLT51c2Vyc3BhY2VfYWRkciwgb2Zmc2V0KTsKCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM2MjogRklMRTogaHcvdmlydGlvL3Zob3N0LXVz
ZXIuYzo0NDI6CisgICAgICAgICAgICBtc2ctPnBheWxvYWQubWVtb3J5LnJlZ2lvbnNbKmZkX251
bV0ubWVtb3J5X3NpemUgID0gcmVnLT5tZW1vcnlfc2l6ZTsKCkVSUk9SOiB0cmFpbGluZyB3aGl0
ZXNwYWNlCiMxNDU6IEZJTEU6IGh3L3ZpcnRpby92aG9zdC11c2VyLmM6NDkzOgorICQKCnRvdGFs
OiAxIGVycm9ycywgMiB3YXJuaW5ncywgMTkwIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAzY2Q5ZWVl
Njc2NWYgKHZob3N0LXVzZXI6IFJlZnJhY3RvciB2aG9zdF91c2VyX3NldF9tZW1fdGFibGUgRnVu
Y3Rpb25zKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTcyNDc3MTI1LTI1MzQ0LTItZ2l0LXNlbmQt
ZW1haWwtcmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


