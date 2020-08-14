Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7EB20791
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7EB20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cOi-0008PT-6d
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6cNH-0007FG-EC; Fri, 14 Aug 2020 12:16:11 -0400
Resent-Date: Fri, 14 Aug 2020 12:16:11 -0400
Resent-Message-Id: <E1k6cNH-0007FG-EC@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6cNF-0007wp-7N; Fri, 14 Aug 2020 12:16:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597421742; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ilQBgM7fl7nc9oFqocnEfHzcL3mZRkpWMirfJux2N5bLHj/kIjYZ79wcTdpHxbOQwpMEFQVXnfovWPoOUlnXzx9hikrQ1lbyGHE3iUPxS6t/002sr/IV6Y2JDqMAu/DY3OULvU0HRQG/f81V/MBb5xcgb8b/wiG1nQ5QNjNR46g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597421742;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zsEzD+oJXlKYnT1NqYRAk9BKBoDDhrkyxikqy/3BBV0=; 
 b=Y/d80pvjGRX9rqTOD4tUYJ37aAta6Vl+0gRyWBl7qiRN2ofkOhUrjtC49kuZAKqa/OD+pZz9PvDoRk4+rqILFUfL9z5l2SEI6J8wNj2YbnoFD7q4+2DNi4fwbnolGKEtAJgI54OZP1DSHkcrZ3rI93YKvoaKE/16bS4GauEFTrI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597421738572459.14829975056193;
 Fri, 14 Aug 2020 09:15:38 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] preallocate filter
Message-ID: <159742173728.5486.12528644550377419671@66eaa9a8a123>
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 14 Aug 2020 09:15:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 12:16:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNDEzMDM0OC4yMDYy
NS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgbmJkL3RyYWNlLm8KICBDQyAgICAgIHNjc2kvdHJhY2UubwoKV2FybmluZywgdHJlYXRlZCBh
cyBlcnJvcjoKLi4vc3JjL2RvY3Mvc3lzdGVtL3FlbXUtYmxvY2stZHJpdmVycy5yc3QuaW5jOjk4
MDpEdXBsaWNhdGUgZXhwbGljaXQgdGFyZ2V0IG5hbWU6ICJjbWRvcHRpb24tcHJlYWxsb2NhdGUt
YXJnLXByZWFsbG9jLWFsaWduIi4KICBDQyAgICAgIGF1ZGlvL3RyYWNlLm8KICBDQyAgICAgIGNo
YXJkZXYvdHJhY2UubwotLS0KICBDQyAgICAgIGh3L2lkZS90cmFjZS5vCiAgQ0MgICAgICBody9p
bnB1dC90cmFjZS5vCiAgQ0MgICAgICBody9pbnRjL3RyYWNlLm8KbWFrZTogKioqIFtNYWtlZmls
ZToxMTExOiAuZG9jc19zeXN0ZW1fcWVtdS4xX2RvY3Nfc3lzdGVtX3FlbXUtYmxvY2stZHJpdmVy
cy43X2RvY3Nfc3lzdGVtX3FlbXUtY3B1LW1vZGVscy43LnNlbnRpbmVsLl0gRXJyb3IgMgptYWtl
OiAqKiogRGVsZXRpbmcgZmlsZSAnLmRvY3Nfc3lzdGVtX3FlbXUuMV9kb2NzX3N5c3RlbV9xZW11
LWJsb2NrLWRyaXZlcnMuN19kb2NzX3N5c3RlbV9xZW11LWNwdS1tb2RlbHMuNy5zZW50aW5lbC4n
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCgpXYXJuaW5nLCB0cmVh
dGVkIGFzIGVycm9yOgouLi9zcmMvZG9jcy9zeXN0ZW0vcWVtdS1ibG9jay1kcml2ZXJzLnJzdC5p
bmM6OTgwOkR1cGxpY2F0ZSBleHBsaWNpdCB0YXJnZXQgbmFtZTogImNtZG9wdGlvbi1wcmVhbGxv
Y2F0ZS1hcmctcHJlYWxsb2MtYWxpZ24iLgptYWtlOiAqKiogW01ha2VmaWxlOjExMDA6IGRvY3Mv
c3lzdGVtL2luZGV4Lmh0bWxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9k
dWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9MmI4MzMyZWViMGM4NDY3MWJmNWY3OTViMzcwNzMyNDUnLCAnLXUnLCAnMTAwMycs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdD
Q0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1tc3p0YnZkOS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTE0LTEyLjEz
LjA4LjI0MTQwOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2ZlZG9yYScsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTJiODMzMmVlYjBj
ODQ2NzFiZjVmNzk1YjM3MDczMjQ1Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW1z
enRidmQ5L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJv
ciAyCgpyZWFsICAgIDJtMjkuNjQzcwp1c2VyICAgIDBtNy45NjZzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgxNDEzMDM0OC4yMDYy
NS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

