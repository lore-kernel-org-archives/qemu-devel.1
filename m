Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA825C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F5B2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5B2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMr8v-0001Ct-GJ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMr1W-0003uj-Lx
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:08:50 -0400
Resent-Date: Mon, 28 Sep 2020 07:08:50 -0400
Resent-Message-Id: <E1kMr1W-0003uj-Lx@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMr0s-0000xP-1A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601291282; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RB37HYYiYIgvwMQL++oeKb5BjML8ctqt/Yz+vSnT3UI84EeM74v5E7yRjlSctLIX0e4gGtvLY00rwa+xYyN9BZZyjZ7zMPvoAJ5r7e3ANoGFfdRYKF6bcY9BYsMGPLsYDEFPPoxgTI+gP+1pU1kXMWdfSnH+TgojLOPnJRBuaIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601291282;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1YPaxs6T7oy/jmrLvAeJ//BzYr8M6DAyMWuG0RWt04o=; 
 b=Z5eDZC/q+RHnPc0Dr2OovTeQCTm1J3bX6N0YSTTb+9jFZM0gdzEIrA0CQRWwmyNIvgfqzItSV8Xe1Zv6pYzPL6NbF+P6FdNbm4rzrM7/LFzswO5rowllFErRVS1RmSNPOixMKkwoI/opZiIHF+LJIepOJCabfLo2bVD1A+zytPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601291281633188.94032159917197;
 Mon, 28 Sep 2020 04:08:01 -0700 (PDT)
Subject: Re: [PATCH] tests/venv: force compatible
 avocado-framework-plugin-result-html version
Message-ID: <160129128040.10465.9149224422848383737@66eaa9a8a123>
In-Reply-To: <20200928100902.28638-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Mon, 28 Sep 2020 04:08:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 07:08:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyODEwMDkwMi4yODYz
OC0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkMgbGlua2VyIGZvciB0aGUgaG9z
dCBtYWNoaW5lOiBjYyBsZC5iZmQgMi4yNy00MwpIb3N0IG1hY2hpbmUgY3B1IGZhbWlseTogeDg2
XzY0Ckhvc3QgbWFjaGluZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdBUk5J
Tkc6IE1vZHVsZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJkcyBj
b21wYXRpYmlsaXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQcm9n
cmFtIHNoIGZvdW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmluL3B5
dGhvbjMpCkNvbmZpZ3VyaW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQpxZW11
LXN5c3RlbS1hYXJjaDY0OiBjYW5ub3Qgc2V0IHVwIGd1ZXN0IG1lbW9yeSAnc2JzYS1yZWYucmFt
JzogQ2Fubm90IGFsbG9jYXRlIG1lbW9yeQpCcm9rZW4gcGlwZQouLi9zcmMvdGVzdHMvcXRlc3Qv
bGlicXRlc3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVkIHRvIHRlcm1pbmF0ZSBRRU1VIHByb2Nl
c3MgYnV0IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEgKGV4cGVjdGVkIDApCkVSUk9SIHF0ZXN0
LWFhcmNoNjQ6IHRlc3QtaG1wIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDcyLCBnb3Qg
MTIpCm1ha2U6ICoqKiBbcnVuLXRlc3QtMTcxXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCkNvdWxkIG5vdCBhY2Nlc3MgS1ZNIGtlcm5lbCBtb2R1bGU6
IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKcWVtdS1zeXN0ZW0teDg2XzY0OiAtYWNjZWwga3Zt
OiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBrdm06IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKLS0t
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4n
LCAnLS1ybScsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NDZlZjMyMGQ5YWRl
NDU1YmI4MWE5NGUyNGQwMDYxMzknLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NP
TkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScs
ICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywg
Jy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZjdramFfeWcvc3Jj
L2RvY2tlci1zcmMuMjAyMC0wOS0yOC0wNi41MC4wNS4xMjQyNTovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9NDZlZjMyMGQ5YWRlNDU1YmI4MWE5NGUyNGQwMDYxMzkKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZjdramFfeWcvc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE3bTU4LjA5N3MKdXNl
ciAgICAwbTIxLjg2OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAwOTI4MTAwOTAyLjI4NjM4LTEta3JheGVsQHJlZGhhdC5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

