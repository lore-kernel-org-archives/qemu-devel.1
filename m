Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2C0C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C383A21783
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C383A21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgA4W-0001Bc-2b
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 11:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgA3Z-0000NN-PA
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgA3Y-0002AZ-JB
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:41:57 -0400
Resent-Date: Wed, 26 Jun 2019 11:41:57 -0400
Resent-Message-Id: <E1hgA3Y-0002AZ-JB@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgA3Y-00028d-Db
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:41:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561563667; cv=none; d=zoho.com; s=zohoarc; 
 b=GLKgyKCZWS6S1/6yNcvzVjT936ri4D9S+vcqhDbT+yETj7qjEJBZ0BQXNqbG7w+2qRSWpj7SmCZ0L2IBe7jJSNv+D87IScFIF+RAuLwpiyla4WGmtsp38ubNyXUXVzPexdGOtl17sZM4+B6orQCNV1/WDLx1zsKDAlI3sRGggoI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561563667;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=o8NnjDmGIFlTCwvlW/mKh4NrkXGLHcyxXpZI3Of7Ujo=; 
 b=TuFqPc6OEJ6IhIJ3YA9/xV7r6mnZq0v1uJxmIN9HHWF9ZvE6fDCJ8ZkGM+4gPwqW2FgEt/0P5EvUTopXnSKnyQbX5jde+PzfMjWoFhLSBlEE6OWdcv62ZS7QIItxC7hBa4scxValKZhBO1rNY8rSpwBJ3Eb8Xto+lHqoDp/fW40=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561563664594618.6854988653449;
 Wed, 26 Jun 2019 08:41:04 -0700 (PDT)
Message-ID: <156156366354.6332.12395600972268443110@c4a48874b076>
In-Reply-To: <20190626152703.4871-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dinechin@redhat.com
Date: Wed, 26 Jun 2019 08:41:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH] hyperv-stub: Remove invalid reference to
 hyperv_synic
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, rth@twiddle.net,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNjE1MjcwMy40ODcx
LTEtZGluZWNoaW5AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQg
dGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxsIGJl
IGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0byBh
IGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIKIyBi
cmFuY2gKc2V0IC1lCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0k
UFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNS
Qy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6IHdl
IG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0YWxs
CgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAiPT09IFBBQ0tBR0VTID09
PSIKcnBtIC1xYQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYyNjE1MjcwMy40ODcxLTEt
ZGluZWNoaW5AcmVkaGF0LmNvbS90ZXN0aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


