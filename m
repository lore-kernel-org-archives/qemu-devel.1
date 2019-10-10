Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F03C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C9021920
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C9021920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYJU-0008KT-6T
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIYHo-00078J-65
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIYHm-0001ig-EF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:15:19 -0400
Resent-Date: Thu, 10 Oct 2019 09:15:19 -0400
Resent-Message-Id: <E1iIYHm-0001ig-EF@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIYHm-0001iK-67
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570713304; cv=none; d=zoho.com; s=zohoarc; 
 b=Szgf9gsf54YVkNjujFeNCH3yoVHVmk8tbOcsIVeZjbrU5+NFqyOQcqjeC5Smlao+XbKIQXv0XIZ7ZR2bSWbMTFP3uQ3L4hxfF1J/8aWde/HVcjBjqH344IMxfUnvF2rywBFfkAjxZQzt+xwfrgZx3t0cXFiX7XVIsj91Lh84JF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570713304;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JuXqxE2jonW9JSE+7Ho0jzP9eNdbHgvJPlOx8PCvHBc=; 
 b=aoOSvuVgABgIyKK3pyXDRg8zqCS9LBwBDCjKnEn9FbQIJhIZQuiI1racBQ9+5xXQc2BEXyyQN1kAWbA2GLoBcN3gTigpR3CT5ZYDCQbUblJA8HFbY2zEtcl4kaxlD2OdOLsYix56PD0Pu6SX6FTseWpkOfV47M9BeRHhny51x+g=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570713302913589.7599983334851;
 Thu, 10 Oct 2019 06:15:02 -0700 (PDT)
In-Reply-To: <1570709475-32073-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
Subject: Re: [PATCH v3] virtio-net: prevent offloads reset on migration
Message-ID: <157071330156.7138.10951394337252973749@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mikhail.sennikovskii@cloud.ionos.com
Date: Thu, 10 Oct 2019 06:15:02 -0700 (PDT)
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
Cc: mst@redhat.com, jasowang@redhat.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org, mikhail.sennikovskii@cloud.ionos.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcwNzA5NDc1LTMyMDczLTIt
Z2l0LXNlbmQtZW1haWwtbWlraGFpbC5zZW5uaWtvdnNraWlAY2xvdWQuaW9ub3MuY29tLwoKCgpI
aSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVz
dC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxv
dy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1
Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFr
ZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVz
dC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody90aW1lci9tYzE0NjgxOHJ0Yy5v
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvY2hhci92aXJ0aW8tc2VyaWFsLWJ1cy5vCi90
bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5ldC5jOiBJbiBmdW5jdGlvbiAndmlydGlv
X25ldF9zZXRfZmVhdHVyZXMnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L3ZpcnRpby1uZXQu
Yzo3ODA6NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdydW5zdGF0
ZV9jaGVjaycgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgaWYg
KG4tPmhhc192bmV0X2hkciAmJiAhcnVuc3RhdGVfY2hlY2soUlVOX1NUQVRFX0lOTUlHUkFURSkp
IHsKICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5ldC5jOjc4MDo1OiBl
cnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAncnVuc3RhdGVfY2hlY2snIFstV2Vy
cm9yPW5lc3RlZC1leHRlcm5zXQovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L3ZpcnRpby1uZXQu
Yzo3ODA6NDQ6IGVycm9yOiAnUlVOX1NUQVRFX0lOTUlHUkFURScgdW5kZWNsYXJlZCAoZmlyc3Qg
dXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgICAgaWYgKG4tPmhhc192bmV0X2hkciAmJiAhcnVuc3Rh
dGVfY2hlY2soUlVOX1NUQVRFX0lOTUlHUkFURSkpIHsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdmlydGlvLW5l
dC5jOjc4MDo0NDogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQg
b25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtody9uZXQvdmlydGlvLW5l
dC5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvY29yZS9tYWNoaW5lLXFtcC1jbWRzLm8KICBD
QyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9jb3JlL251bWEubwotLS0KICBDQyAgICAgIGFhcmNo
NjQtc29mdG1tdS9ody9kbWEvcHhhMnh4X2RtYS5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUv
aHcvZ3Bpby9vbWFwX2dwaW8ubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2dwaW8vaW14
X2dwaW8ubwptYWtlOiAqKiogW3g4Nl82NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11
L2h3L2dwaW8vYmNtMjgzNV9ncGlvLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9ncGlv
L25yZjUxX2dwaW8ubwotLS0KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9hcm0vaGlnaGJh
bmsubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9pbnRlZ3JhdG9yY3AubwovdG1w
L3FlbXUtdGVzdC9zcmMvaHcvbmV0L3ZpcnRpby1uZXQuYzogSW4gZnVuY3Rpb24gJ3ZpcnRpb19u
ZXRfc2V0X2ZlYXR1cmVzJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC92aXJ0aW8tbmV0LmM6
NzgwOjU6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAncnVuc3RhdGVf
Y2hlY2snIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgIGlmIChu
LT5oYXNfdm5ldF9oZHIgJiYgIXJ1bnN0YXRlX2NoZWNrKFJVTl9TVEFURV9JTk1JR1JBVEUpKSB7
CiAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L3ZpcnRpby1uZXQuYzo3ODA6NTogZXJy
b3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ3J1bnN0YXRlX2NoZWNrJyBbLVdlcnJv
cj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC92aXJ0aW8tbmV0LmM6
NzgwOjQ0OiBlcnJvcjogJ1JVTl9TVEFURV9JTk1JR1JBVEUnIHVuZGVjbGFyZWQgKGZpcnN0IHVz
ZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAgIGlmIChuLT5oYXNfdm5ldF9oZHIgJiYgIXJ1bnN0YXRl
X2NoZWNrKFJVTl9TVEFURV9JTk1JR1JBVEUpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L3ZpcnRpby1uZXQu
Yzo3ODA6NDQ6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9u
bHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCmNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbaHcvbmV0L3ZpcnRpby1uZXQu
b10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgog
IENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9tYWluc3RvbmUubwptYWtlOiAqKiogW2Fh
cmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9k
dWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9MTE5ZDM3ZDgwZWQzNDgwNTg2YmUzNDk5ZGZlMTg2OGUnLCAnLXUnLCAnMTAwMScs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC00aWRiZGtjaC9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTEwLTA5LjEy
LjQwLjEyNjU2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAv
cWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAy
LgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0xMTlkMzdkODBl
ZDM0ODA1ODZiZTM0OTlkZmUxODY4ZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00
aWRiZGtjaC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVy
cm9yIDIKCnJlYWwgICAgMm0yMi4yMjBzCnVzZXIgICAgMG04LjI1NnMKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NzA3MDk0NzUtMzIwNzMt
Mi1naXQtc2VuZC1lbWFpbC1taWtoYWlsLnNlbm5pa292c2tpaUBjbG91ZC5pb25vcy5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


