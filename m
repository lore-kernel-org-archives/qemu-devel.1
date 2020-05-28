Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F71C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 20:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374EE2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 20:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374EE2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jePci-000427-9p
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 16:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jePcA-0003cB-68
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:58:58 -0400
Resent-Date: Thu, 28 May 2020 16:58:58 -0400
Resent-Message-Id: <E1jePcA-0003cB-68@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jePc8-0004HH-Ev
 for qemu-devel@nongnu.org; Thu, 28 May 2020 16:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590699517; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zr1U41NmtMBHPzBG0kw/eXCxOa9NH7tw2aTtiks9ZVn/0XKipmEpsuyAV5b2aBapwMt4f8g/X/HAliYjJk1aVkZEXy8nlDeGRHglZw3EKJ1vpE6GoRuINlUZ+How8LBMmOM8pIFSlxotz/dVp7i5mMxogRil2FBINiktB668qPU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590699517;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U+A8lTBCBGsYKaRj4TVzj1bqbhYmqU62v7vgmZxLmPQ=; 
 b=SeUxn9WWTJbmwQVDR8ILqXhqip9SQkCTY5i7IlH+r9EIjYej/WbYSuPC0Vjbbs3QbtnMbsm52S2xV9i8rQGmv2CyvXB0KYcVahjBEaP2cJ/kCWDdH9udQEEj4mAT/ZCg7n7MYXIfDN78hoX+hidQ0icu/+7E3McI/+7feSmo1F8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590699515284856.7903815119723;
 Thu, 28 May 2020 13:58:35 -0700 (PDT)
Message-ID: <159069951375.20666.2158681200854299959@45ef0f9c86ae>
In-Reply-To: <20200528134035.32025-1-kraxel@redhat.com>
Subject: Re: [PATCH v2 0/4] microvm: memory config tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 28 May 2020 13:58:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:26:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyODEzNDAzNS4zMjAy
NS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQtc29m
dG1tdS90YXJnZXQvaTM4Ni90cmFuc2xhdGUubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3
L2FybS9vbWFwMS5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9pMzg2L3hlbi94ZW4taHZtLmM6IElu
IGZ1bmN0aW9uICd4ZW5fcmFtX2luaXQnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni94ZW4v
eGVuLWh2bS5jOjIwNjozNDogZXJyb3I6ICdYODZfTUFDSElORV9NQVhfUkFNX0JFTE9XXzRHJyB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFg4Nl9NQUNISU5FX01BWF9SQU1fQkVMT1dfNEcsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9pMzg2L3hlbi94
ZW4taHZtLmM6MjA2OjM0OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBv
cnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgptYWtlWzFdOiAq
KiogW2h3L2kzODYveGVuL3hlbi1odm0ub10gRXJyb3IgMQogIENDICAgICAgYWFyY2g2NC1zb2Z0
bW11L2h3L2FybS9vbWFwMi5vCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL3N0cm9uZ2FybS5vCi0tLQog
IENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vZ2Ric3R1YjY0Lm8KICBDQyAgICAg
IGFhcmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL21hY2hpbmUubwogIENDICAgICAgYWFyY2g2NC1z
b2Z0bW11L3RhcmdldC9hcm0vYXJjaF9kdW1wLm8KbWFrZTogKioqIFt4ODZfNjQtc29mdG1tdS9h
bGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBD
QyAgICAgIGFhcmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL21vbml0b3IubwogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vYXJtLXBvd2VyY3RsLm8KLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTc0YWI0MmVmMzQ1OTRmZGI5ODhmNzI0ZThlZmFhOTZkJywg
Jy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYn
LCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZreTVsdDBhL3NyYy9kb2NrZXItc3JjLjIw
MjAtMDUtMjgtMTYuNTUuMjQuNTA1NjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9NzRhYjQyZWYzNDU5NGZkYjk4OGY3MjRlOGVmYWE5NmQKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtZmt5NWx0MGEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDNtOC43OTlzCnVzZXIgICAgMG00LjQ4OHMKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
NTI4MTM0MDM1LjMyMDI1LTEta3JheGVsQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tA
Y2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

