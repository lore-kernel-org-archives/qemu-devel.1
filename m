Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC67FC28D16
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80132085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80132085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKHc-0001hk-19
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1haKFb-0000JH-9q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1haKFa-0000k4-3K
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:22:15 -0400
Resent-Date: Mon, 10 Jun 2019 09:22:15 -0400
Resent-Message-Id: <E1haKFa-0000k4-3K@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1haKFZ-0000jW-Qj
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:22:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560170182; cv=none; d=zoho.com; s=zohoarc; 
 b=ftirwdjGQFhV8I5ukJO8pW9ta7CaUx/TP65WJaukeMyJkNmkL9pyv4CA5kTVJW7FKH/NZv6C7ZxK5UQ2ooSeN4J72xumswEHjcCOBomoUdHd7X0jxgLu9klN71ow/iJR8RRqoKIbiFgYF3M67sL7Y3ZpB2uPReuV0gACuLpVqtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560170182;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=iG/Lr5Vl248YQOjc/+7AM/QNU8Quoa2en4fBuwOQVtc=; 
 b=gfeOfxfj4Gz/QiYiE37+C6fNF1rqycsBoU3/Ck93VDWFTuEpy4MwRngfJJCP2QZpHRnPl5RZae8iT/Aupgci2GKnGZ9fSBnO1R9kvfWSXO/TYxKr+PYv5MrUKzvzXmak/fYnr/Q5IkdKjcp9yTZSNWOjFQQ/V3MHUUapCDsdlUI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560170181375532.4628776573328;
 Mon, 10 Jun 2019 05:36:21 -0700 (PDT)
In-Reply-To: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
Message-ID: <156017018046.32260.11357415926588735226@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 10 Jun 2019 05:36:21 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] Proof of concept for Meson
 integration
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwMTY1MzAxLTM5MDI2LTEt
Z2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgYnVpbGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBi
ZWxvdy4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNj
cmlwdCB3aWxsIGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBw
b2ludGluZyB0byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBv
ZiAiYmFzZSIKIyBicmFuY2gKc2V0IC1lCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5z
dGFsbApCVUlMRD0kUFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApj
ZCAkQlVJTEQKJFNSQy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAt
ajQKIyBYWFg6IHdlIG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEK
bWFrZSBpbnN0YWxsCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAiPT09
IFBBQ0tBR0VTID09PSIKcnBtIC1xYQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KCkVSUk9SOiBNZXNvbiBub3QgZm91bmQuIFVzZSAtLW1lc29uPS9wYXRoL3Rv
L21lc29uCgo9PT0gT1VUUFVUIEVORCA9PT0KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjAxNjUzMDEtMzkwMjYtMS1naXQtc2VuZC1lbWFp
bC1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


