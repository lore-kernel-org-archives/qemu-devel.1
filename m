Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B259C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 19:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0253621852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 19:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0253621852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj7mu-0006T2-6Q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 15:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hj7mB-00061p-Sn
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 15:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hj7mA-00029T-Fs
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 15:52:15 -0400
Resent-Date: Thu, 04 Jul 2019 15:52:15 -0400
Resent-Message-Id: <E1hj7mA-00029T-Fs@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hj7mA-00028Q-70
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 15:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562268974; cv=none; d=zoho.com; s=zohoarc; 
 b=JXjuVRFmKQi8+r8RRVeWcW1TO/eSTGxj0VSeNbx2P9jIdvDKu2tQyJo0mjPZdWYd+sNQHWHRxyRk6A6QVI3Daz8u2VKdeDZRAZlKrR92aDcqQcNgzwN3f+bhozJqWAOxz/8pWbc556lf4DEKtxSs2O2srkirueI/hYoq5g9iTpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562268974;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=lycfdSsVYvJR58q/wOnATTKt+iGAS1u9xF9GISRZv7o=; 
 b=F/V2CfzlkMAuRpfXVKklA83uTJhrBYNph6ninYQP2NayXAuCVGemUcnal+iUY2AmEwKjsAr6Ybkkeh7bR/nHle+DdsqTXZ0f6RhKuw1qQWvxt4aG1ReB6HWvpJSZIAxnGEUBCcxdc4DlMg4VXA+yztZLPeZCo5RsbexVusu1W7A=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562268974103656.6995921785822;
 Thu, 4 Jul 2019 12:36:14 -0700 (PDT)
Message-ID: <156226897318.29820.11432752796665662982@c4a48874b076>
In-Reply-To: <20190704180350.2086-1-julio.montes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: julio.montes@intel.com
Date: Thu, 4 Jul 2019 12:36:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
 disabled
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
Cc: julio.montes@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwNDE4MDM1MC4yMDg2
LTEtanVsaW8ubW9udGVzQGludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gaHcvaTM4NjogRml4
IGxpbmtlciBlcnJvciB3aGVuIElTQVBDIGlzIGRpc2FibGVkClR5cGU6IHNlcmllcwpNZXNzYWdl
LWlkOiAyMDE5MDcwNDE4MDM1MC4yMDg2LTEtanVsaW8ubW9udGVzQGludGVsLmNvbQoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKNjZkNTU0YiBody9pMzg2OiBGaXggbGlua2VyIGVycm9yIHdoZW4gSVNBUEMgaXMgZGlz
YWJsZWQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6
IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNjUgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IDY2ZDU1NGJhNjY0NSAoaHcvaTM4NjogRml4IGxpbmtlciBlcnJvciB3aGVuIElTQVBD
IGlzIGRpc2FibGVkKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwNDE4MDM1MC4yMDg2LTEt
anVsaW8ubW9udGVzQGludGVsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


