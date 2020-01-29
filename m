Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B95AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5EC20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5EC20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwnic-0003OG-Jj
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iwni0-0002rY-4j
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iwnhx-0003Ls-LK
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:48:43 -0500
Resent-Date: Wed, 29 Jan 2020 08:48:43 -0500
Resent-Message-Id: <E1iwnhx-0003Ls-LK@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iwnhx-0003LE-De
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:48:41 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580305704162174.85070197272853;
 Wed, 29 Jan 2020 05:48:24 -0800 (PST)
In-Reply-To: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
Subject: Re: [RFC v3 00/25] intel_iommu: expose Shared Virtual Addressing to
 VMs
Message-ID: <158030570300.2504.13309596574427255696@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yi.l.liu@intel.com
Date: Wed, 29 Jan 2020 05:48:24 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, kvm@vger.kernel.org,
 mst@redhat.com, jun.j.tian@intel.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com,
 hao.wu@intel.com, yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgwMzAwMjE2LTg2MTcyLTEt
Z2l0LXNlbmQtZW1haWwteWkubC5saXVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhl
IHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9j
a2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2Vu
dG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNI
T1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBody9wY2kvcGNpX2hvc3QubwogIENDICAgICAgaHcvcGNpL3BjaWUubwovdG1wL3FlbXUtdGVz
dC9zcmMvaHcvcGNpLWhvc3QvZGVzaWdud2FyZS5jOiBJbiBmdW5jdGlvbiAnZGVzaWdud2FyZV9w
Y2llX2hvc3RfcmVhbGl6ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9wY2ktaG9zdC9kZXNpZ253
YXJlLmM6NjkzOjU6IGVycm9yOiBpbmNvbXBhdGlibGUgdHlwZSBmb3IgYXJndW1lbnQgMiBvZiAn
cGNpX3NldHVwX2lvbW11JwogICAgIHBjaV9zZXR1cF9pb21tdShwY2ktPmJ1cywgZGVzaWdud2Fy
ZV9pb21tdV9vcHMsIHMpOwogICAgIF4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10
ZXN0L3NyYy9pbmNsdWRlL2h3L3BjaS9tc2kuaDoyNDowLAotLS0KL3RtcC9xZW11LXRlc3Qvc3Jj
L2luY2x1ZGUvaHcvcGNpL3BjaS5oOjQ5OTo2OiBub3RlOiBleHBlY3RlZCAnY29uc3Qgc3RydWN0
IFBDSUlPTU1VT3BzIConIGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdQQ0lJT01NVU9wcycKIHZv
aWQgcGNpX3NldHVwX2lvbW11KFBDSUJ1cyAqYnVzLCBjb25zdCBQQ0lJT01NVU9wcyAqaW9tbXVf
b3BzLCB2b2lkICpvcGFxdWUpOwogICAgICBeCm1ha2U6ICoqKiBbaHcvcGNpLWhvc3QvZGVzaWdu
d2FyZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CnJtIHRlc3RzL3FlbXUtaW90ZXN0cy9zb2NrZXRfc2NtX2hlbHBlci5vClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPTA4ZmNjYzI1OGY1MjQxYjg4NmZmODljY2Y0M2U4OTI2JywgJy11JywgJzEwMDEnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScs
ICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNI
RV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUt
ZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAteHJuaG83cm0vc3JjL2RvY2tlci1zcmMuMjAyMC0wMS0yOS0wOC40Ni4xMC4y
OTc0MjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDhmY2NjMjU4ZjUyNDFi
ODg2ZmY4OWNjZjQzZTg5MjYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteHJuaG83
cm0vc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAy
CgpyZWFsICAgIDJtMTMuMjYzcwp1c2VyICAgIDBtOC4yNjlzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTgwMzAwMjE2LTg2MTcyLTEtZ2l0
LXNlbmQtZW1haWwteWkubC5saXVAaW50ZWwuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRv
czcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

