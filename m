Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30E5C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:40:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996532089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996532089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxy5-0004gX-AH
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIxP3-00043g-JG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIxP1-0003FW-R2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:04:29 -0400
Resent-Date: Fri, 11 Oct 2019 12:04:29 -0400
Resent-Message-Id: <E1iIxP1-0003FW-R2@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIxP1-0003EB-HV
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:04:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570809857; cv=none; d=zoho.com; s=zohoarc; 
 b=fh3CuHLIhswbIxiRhXKok7d0GUL/ICRM+hzg8HAKvL/kw3OLfpPtRNbVTj7cLOZd93udI9mrlzSsXdNUlpynB0mca/bG6g0BAgGtSpCenbJmMI3286/DNxgheZ2r72ZZqwAiSOJWeYvpp4NToO+zHjenwXiTrt1oLBhvA3bSmXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570809857;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+xXPqqukEjskz/cHKHgNoKooPeNUbkd61UDFgFZSN3o=; 
 b=YOQ05pA5fkiomytFfqKpl9qfpDk7FzU70/mdKcXDwUKRO617Gxw7rJI1O9w8uKqScKSzmt2VHxu9EiA3LsXNfTiD8ebpA3GlqWCUzZ6Awf3eTTMZ0TAiPyQ6BpydKQW/W94ocpEXs0lVMLBrkQK2pc3DQUKDCXIZW+M+VwIO9l0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570809854902972.7615494025482;
 Fri, 11 Oct 2019 09:04:14 -0700 (PDT)
In-Reply-To: <20191011112015.11785-1-jfreimann@redhat.com>
Subject: Re: [PATCH v3 0/10] add failover feature for assigned network devices
Message-ID: <157080985299.13900.8759570753307740272@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jfreimann@redhat.com
Date: Fri, 11 Oct 2019 09:04:14 -0700 (PDT)
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
Cc: parav@mellanox.com, mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMTExMjAxNS4xMTc4
NS0xLWpmcmVpbWFubkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDAyNQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMjcKKioKRVJST1I6L3RtcC9xZW11
LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0LmM6OTAzOndhaXRfZm9yX21pZ3JhdGlvbl9m
YWlsOiBhc3NlcnRpb24gZmFpbGVkOiAoIXN0cmNtcChzdGF0dXMsICJzZXR1cCIpIHx8ICFzdHJj
bXAoc3RhdHVzLCAiZmFpbGVkIikgfHwgKGFsbG93X2FjdGl2ZSAmJiAhc3RyY21wKHN0YXR1cywg
ImFjdGl2ZSIpKSkKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rl
c3RzL21pZ3JhdGlvbi10ZXN0LmM6OTAzOndhaXRfZm9yX21pZ3JhdGlvbl9mYWlsOiBhc3NlcnRp
b24gZmFpbGVkOiAoIXN0cmNtcChzdGF0dXMsICJzZXR1cCIpIHx8ICFzdHJjbXAoc3RhdHVzLCAi
ZmFpbGVkIikgfHwgKGFsbG93X2FjdGl2ZSAmJiAhc3RyY21wKHN0YXR1cywgImFjdGl2ZSIpKSkK
bWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5n
IGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyOQogIFRF
U1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1xZGlzdAotLS0KICBURVNUICAgIGlvdGVzdC1x
Y293MjogMTcyCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE3NAoqKgpFUlJPUjovdG1wL3FlbXUt
dGVzdC9zcmMvdGVzdHMvbWlncmF0aW9uLXRlc3QuYzo5MDM6d2FpdF9mb3JfbWlncmF0aW9uX2Zh
aWw6IGFzc2VydGlvbiBmYWlsZWQ6ICghc3RyY21wKHN0YXR1cywgInNldHVwIikgfHwgIXN0cmNt
cChzdGF0dXMsICJmYWlsZWQiKSB8fCAoYWxsb3dfYWN0aXZlICYmICFzdHJjbXAoc3RhdHVzLCAi
YWN0aXZlIikpKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVz
dHMvbWlncmF0aW9uLXRlc3QuYzo5MDM6d2FpdF9mb3JfbWlncmF0aW9uX2ZhaWw6IGFzc2VydGlv
biBmYWlsZWQ6ICghc3RyY21wKHN0YXR1cywgInNldHVwIikgfHwgIXN0cmNtcChzdGF0dXMsICJm
YWlsZWQiKSB8fCAoYWxsb3dfYWN0aXZlICYmICFzdHJjbXAoc3RhdHVzLCAiYWN0aXZlIikpKQpt
YWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQogIFRFU1QgICAgaW90ZXN0LXFj
b3cyOiAxNzYKICBURVNUICAgIGlvdGVzdC1xY293MjogMTc3CiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDE3OQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OGE1MGNmY2U2
NzhmNDViZmI1NTRiZWZkYjcyMjUwNGUnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1s
cnJ4OXp0ci9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTExLTExLjUzLjI0LjMwMzkxOi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1x
dWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9
bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04YTUwY2ZjZTY3OGY0NWJmYjU1NGJlZmRiNzIy
NTA0ZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1scnJ4OXp0ci9zcmMnCm1ha2U6
ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTBt
NDkuMzg2cwp1c2VyICAgIDBtOC43MzdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAxMTExMjAxNS4xMTc4NS0xLWpmcmVpbWFubkBy
ZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


