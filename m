Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A2C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A0E20859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A0E20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haJr7-0005Wo-0M
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1haJpr-00040l-3Z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1haJbZ-0004SZ-Ev
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:40:54 -0400
Resent-Date: Mon, 10 Jun 2019 08:40:54 -0400
Resent-Message-Id: <E1haJbZ-0004SZ-Ev@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1haJbZ-0004Pw-7C
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:40:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560170434; cv=none; d=zoho.com; s=zohoarc; 
 b=QpUa9+26fEedpOOaYOcjFbYubqkKfH24DZGhVq2ix6Nc5aKJ8oucq2eZ0lcMa76iUJO7ApFR3V8uDF3/4pLlpGIOfit1/+jvLnWAdtTklFhfc1eQVFVOx5LxeUcth+q9MpXso3iL5P8iovxmWKlNXq/PIPOTbDE0QmeVBWVRqfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560170434;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=P6i4mJtIxknMB7Din8R9VZGhJkmx05XlF2OuVvVqwnk=; 
 b=XZJY87Be/Qs1DouygV0jCwdziqmwdwlHvCi63nyKquvL0GNqBukeHPiVRQ5r0HSoHsU4Hpcw8DrQ2EgOe2MAEp++CsLyipB/rLrJHuV+qQehUE7rkt5GCTEDXoBvHevNSsg0wPOEPuYH8LCaVawTL8Rk1oYMM1kyu39bUkoAw2I=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15601704322973.918671950455064;
 Mon, 10 Jun 2019 05:40:32 -0700 (PDT)
In-Reply-To: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
Message-ID: <156017043152.32260.17385653823787715066@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 10 Jun 2019 05:40:32 -0700 (PDT)
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
YWlsZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBU
QVJHRVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKQ29uZmlndXJlIG9wdGlvbnM6Ci0tZW5hYmxlLXdlcnJvciAtLXRhcmdldC1saXN0
PXg4Nl82NC1zb2Z0bW11IC0tcHJlZml4PS90bXAvcWVtdS10ZXN0L2luc3RhbGwgLS1weXRob249
L3Vzci9iaW4vcHl0aG9uMyAtLWVuYWJsZS1kZWJ1ZyAtLWVuYWJsZS1zYW5pdGl6ZXJzIC0tY3h4
PWNsYW5nKysgLS1jYz1jbGFuZyAtLWhvc3QtY2M9Y2xhbmcKCkVSUk9SOiBNZXNvbiBub3QgZm91
bmQuIFVzZSAtLW1lc29uPS9wYXRoL3RvL21lc29uCgojIFFFTVUgY29uZmlndXJlIGxvZyBNb24g
SnVuIDEwIDEyOjQwOjI2IFVUQyAyMDE5CiMgQ29uZmlndXJlZCB3aXRoOiAnL3RtcC9xZW11LXRl
c3Qvc3JjL2NvbmZpZ3VyZScgJy0tZW5hYmxlLXdlcnJvcicgJy0tdGFyZ2V0LWxpc3Q9eDg2XzY0
LXNvZnRtbXUnICctLXByZWZpeD0vdG1wL3FlbXUtdGVzdC9pbnN0YWxsJyAnLS1weXRob249L3Vz
ci9iaW4vcHl0aG9uMycgJy0tZW5hYmxlLWRlYnVnJyAnLS1lbmFibGUtc2FuaXRpemVycycgJy0t
Y3h4PWNsYW5nKysnICctLWNjPWNsYW5nJyAnLS1ob3N0LWNjPWNsYW5nJwotLS0KZnVuY3M6IGRv
X2NvbXBpbGVyIGRvX2NjIGNvbXBpbGVfb2JqZWN0IGNoZWNrX2RlZmluZSBtYWluCmxpbmVzOiA5
MiAxMjIgNjIyIDY5MSAwCmNsYW5nIC1EX0dOVV9TT1VSQ0UgLURfRklMRV9PRkZTRVRfQklUUz02
NCAtRF9MQVJHRUZJTEVfU09VUkNFIC1Xc3RyaWN0LXByb3RvdHlwZXMgLVdyZWR1bmRhbnQtZGVj
bHMgLVdhbGwgLVd1bmRlZiAtV3dyaXRlLXN0cmluZ3MgLVdtaXNzaW5nLXByb3RvdHlwZXMgLWZu
by1zdHJpY3QtYWxpYXNpbmcgLWZuby1jb21tb24gLWZ3cmFwdiAtc3RkPWdudTk5IC1jIC1vIGNv
bmZpZy10ZW1wL3FlbXUtY29uZi5vIGNvbmZpZy10ZW1wL3FlbXUtY29uZi5jCmNvbmZpZy10ZW1w
L3FlbXUtY29uZi5jOjI6MjogZXJyb3I6IF9faTM4Nl9fIG5vdCBkZWZpbmVkCiNlcnJvciBfX2kz
ODZfXyBub3QgZGVmaW5lZAogXgoxIGVycm9yIGdlbmVyYXRlZC4KLS0tCmZ1bmNzOiBkb19jb21w
aWxlciBkb19jYyBjb21waWxlX29iamVjdCBjaGVja19kZWZpbmUgbWFpbgpsaW5lczogOTIgMTIy
IDYyMiA2OTQgMApjbGFuZyAtRF9HTlVfU09VUkNFIC1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLURf
TEFSR0VGSUxFX1NPVVJDRSAtV3N0cmljdC1wcm90b3R5cGVzIC1XcmVkdW5kYW50LWRlY2xzIC1X
YWxsIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1XbWlzc2luZy1wcm90b3R5cGVzIC1mbm8tc3Ry
aWN0LWFsaWFzaW5nIC1mbm8tY29tbW9uIC1md3JhcHYgLXN0ZD1nbnU5OSAtYyAtbyBjb25maWct
dGVtcC9xZW11LWNvbmYubyBjb25maWctdGVtcC9xZW11LWNvbmYuYwpjb25maWctdGVtcC9xZW11
LWNvbmYuYzoyOjI6IGVycm9yOiBfX0lMUDMyX18gbm90IGRlZmluZWQKI2Vycm9yIF9fSUxQMzJf
XyBub3QgZGVmaW5lZAogXgoxIGVycm9yIGdlbmVyYXRlZC4KCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjAxNjUzMDEtMzkwMjYtMS1naXQt
c2VuZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


