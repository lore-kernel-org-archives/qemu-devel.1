Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C8FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 01:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E822071C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 01:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E822071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdOi2-0006uK-Nv
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 21:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdOhN-0006TM-1l
 for qemu-devel@nongnu.org; Mon, 25 May 2020 21:48:09 -0400
Resent-Date: Mon, 25 May 2020 21:48:09 -0400
Resent-Message-Id: <E1jdOhN-0006TM-1l@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdOhL-0005Wh-FM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 21:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590457670; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gcQMc0t5BVGjINPTG+DTavC1N3unpPriSiEJq/sXAyRi8AN2Et4vmt13Eo1tcOgMHjFByvVro9/TCPuNtWeElywkRrJGn0WelAOnxZS4sCT1sE+fO0BxWEY9OE8Ttf4zpXon6O6S4CVULYJIZWXUgOR0xcm1TYh5yuDWZlSi6fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590457670;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+Kni1fjesEszp+N6zOCucy3wymLw+pCCbuTeFlXoKSs=; 
 b=LumgBd7gXwX6lC+kB4CccALQ0CzmdB0BExP5fiAo0rVWZZAfWpbBn/Q68t+YF9lNBXTppMPqP4kuheGxHtk4NRLqYNvY3wx7mYpIxAJiiDvNgXODr5P9k+CJWySVBTSEhdq6KfA8/W/FqvNLG9aEkenUBCZTSlDdQgxEpUOtARs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15904576691411001.6401035319129;
 Mon, 25 May 2020 18:47:49 -0700 (PDT)
Message-ID: <159045766735.6628.10756430861335368127@45ef0f9c86ae>
In-Reply-To: <20200525134101.24740-1-kraxel@redhat.com>
Subject: Re: [PATCH 0/3] microvm: memory config tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Mon, 25 May 2020 18:47:49 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 21:48:04
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNTEzNDEwMS4yNDc0
MC0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvcWFwaS9xYXBpLXR5cGVzLW1hY2hpbmUtdGFyZ2V0Lm8KICBDQyAgICAgIGFhcmNoNjQt
c29mdG1tdS9xYXBpL3FhcGktdHlwZXMtbWlzYy10YXJnZXQubwovdG1wL3FlbXUtdGVzdC9zcmMv
aHcvaTM4Ni94ZW4veGVuLWh2bS5jOiBJbiBmdW5jdGlvbiAneGVuX3JhbV9pbml0JzoKL3RtcC9x
ZW11LXRlc3Qvc3JjL2h3L2kzODYveGVuL3hlbi1odm0uYzoyMDY6MzQ6IGVycm9yOiAnWDg2X01B
Q0hJTkVfTUFYX1JBTV9CRUxPV180RycgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVu
Y3Rpb24pCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBYODZfTUFDSElORV9NQVhf
UkFNX0JFTE9XXzRHLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9zcmMvaHcvaTM4Ni94ZW4veGVuLWh2bS5jOjIwNjozNDogbm90ZTogZWFjaCB1bmRl
Y2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9u
IGl0IGFwcGVhcnMgaW4KbWFrZVsxXTogKioqIFtody9pMzg2L3hlbi94ZW4taHZtLm9dIEVycm9y
IDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAg
IGFhcmNoNjQtc29mdG1tdS9xYXBpL3FhcGktdHlwZXMubwogIENDICAgICAgYWFyY2g2NC1zb2Z0
bW11L3FhcGkvcWFwaS12aXNpdC1tYWNoaW5lLXRhcmdldC5vCi0tLQogIENDICAgICAgYWFyY2g2
NC1zb2Z0bW11L3FhcGkvcWFwaS1ldmVudHMtbWFjaGluZS10YXJnZXQubwogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L3FhcGkvcWFwaS1ldmVudHMtbWlzYy10YXJnZXQubwogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L3FhcGkvcWFwaS1ldmVudHMubwptYWtlOiAqKiogW3g4Nl82NC1zb2Z0bW11
L2FsbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgog
IENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3FhcGkvcWFwaS1jb21tYW5kcy1tYWNoaW5lLXRhcmdl
dC5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvcWFwaS9xYXBpLWNvbW1hbmRzLW1pc2MtdGFy
Z2V0Lm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTYzNTVkNzc1ODcw
ZTQwYjdiMjRiMDU3Y2U5ODYxM2NiJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW56
a2s0djVtL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjUtMjEuNDQuNDYuMTM3NzQ6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1
aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTYzNTVkNzc1ODcwZTQwYjdiMjRiMDU3Y2U5ODYx
M2NiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW56a2s0djVtL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTEu
NjMzcwp1c2VyICAgIDBtOC4xNjhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUyNTEzNDEwMS4yNDc0MC0xLWtyYXhlbEByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

