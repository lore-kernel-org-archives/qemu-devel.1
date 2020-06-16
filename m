Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D628C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8770207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8770207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkzy5-0005mN-6V
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 21:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkzx5-0005CI-6G
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 20:59:47 -0400
Resent-Date: Mon, 15 Jun 2020 20:59:47 -0400
Resent-Message-Id: <E1jkzx5-0005CI-6G@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkzx2-0007PI-SC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 20:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592269176; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dqoGt6Iq4JfZr/T4zCzaV+ZoEtFH+Bxu98O/WqBtBpqpuLQs/zRLv5e5I3cacJbkrwU9qfBD/x3CfBGWUHeCxEllpErb/H2MoUHv7rTTTREBaWW1xqN/ULP8YPMB+p2p+VJJQ8KhjosU68nTdGksVQF37wTtaDLDbmmSLO01x1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592269176;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TAPdoeHkgpmNvK0YZ0sHct32/P+hbSYXlSjjGILrjoE=; 
 b=Zo80NDOQWu78tAlQl8lcN+8qzwurLgXCz+eLm9N65JCQj/SFVMRDOv95gQGLkm1YPV9gIHh265JJq0GlzOAhVrSFUQczV8Wn7xqGOat8b2pB1ZMzBficHeLRYCo1Zb8xkf6uTkufgBwr2JV8072BbN8oG2RIX9jjxNJK55Vb8Ok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592269174089967.3995458498893;
 Mon, 15 Jun 2020 17:59:34 -0700 (PDT)
Message-ID: <159226917300.3792.11111251484454225261@d1fd068a5071>
Subject: Re: [PATCH] hw/acpi: specify 64-bit acpi table
In-Reply-To: <20200616003654.1058035-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Jason@zx2c4.com
Date: Mon, 15 Jun 2020 17:59:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 20:59:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Jason@zx2c4.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNjAwMzY1NC4xMDU4
MDM1LTEtSmFzb25AengyYzQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmFjcGktdGVzdDogV2FybmluZyEg
RFNEVCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsIFthbWw6L3RtcC9hbWwtODJHSk0wXSwg
RXhwZWN0ZWQgW2FtbDp0ZXN0cy9kYXRhL2FjcGkvcGMvRFNEVF0uClNlZSBzb3VyY2UgZmlsZSB0
ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm9yIGluc3RydWN0aW9ucyBvbiBob3cgdG8g
dXBkYXRlIGV4cGVjdGVkIGZpbGVzLgp0byBzZWUgQVNMIGRpZmYgYmV0d2VlbiBtaXNtYXRjaGVk
IGZpbGVzIGluc3RhbGwgSUFTTCwgcmVidWlsZCBRRU1VIGZyb20gc2NyYXRjaCBhbmQgcmUtcnVu
IHRlc3RzIHdpdGggVj0xIGVudmlyb25tZW50IHZhcmlhYmxlIHNldCoqCkVSUk9SOi90bXAvcWVt
dS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6NDk0OnRlc3RfYWNwaV9h
c2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQpFUlJPUiAtIEJhaWwgb3V0
ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5j
OjQ5NDp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFpbGVkOiAoYWxsX3RhYmxlc19tYXRjaCkK
bWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3Qt
dXVpZAogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvcHRpbWVyLXRlc3QKLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTRhYjA4NDZiMTc5MzRiZmFhZjkzZDA2N2I5ZmU4
ZjU0JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9o
b21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNGp0a3dvamMvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNi0xNS0yMC40NC4zMC4xNTE3NjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpj
ZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9u
LXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9NGFiMDg0NmIxNzkzNGJmYWFmOTNkMDY3YjlmZThmNTQKbWFrZVsxXTogKioqIFtk
b2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtNGp0a3dvamMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVz
dC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE1bTMuMDU3cwp1c2VyICAgIDBtOC42
ODlzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDYxNjAwMzY1NC4xMDU4MDM1LTEtSmFzb25AengyYzQuY29tL3Rlc3RpbmcuZG9ja2Vy
LXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

