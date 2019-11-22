Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D684C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 21:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C9F20708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 21:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C9F20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYGvq-0006FS-4s
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 16:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iYGur-0005f7-Km
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 16:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iYGup-000145-So
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 16:56:37 -0500
Resent-Date: Fri, 22 Nov 2019 16:56:37 -0500
Resent-Message-Id: <E1iYGup-000145-So@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iYGup-00013n-Jz; Fri, 22 Nov 2019 16:56:35 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574459775; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gIHV0GOFPPDwgggjXTyREtuc5zK5BppoUU7XQJXWmU61c1gyIewxTu3yDgCEVTSU/aRKODcwz/gq6Ma5+URJd3gzLc6eMm7eUxH25ZOQglLajFvzI/VI+0j+nHclgCnVjxX6gnpcAELt4caEkJ2bYeeDHuzUW+X5p7TYt5Sc4Hs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574459775;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Aopdlnxyd+Q62iFdgjjobbRZv2KIaehJuQW03tduVIk=; 
 b=a6TO2W4sKuuYW/1YWLsTDEBQgjXkJChtFRnbS7zOF5D/8ydKKPqeb57BobsnB4t6CBqLIrkvzSkFYy3hR05ABkQnRcH3NUHW8doB7QKUXP+/3QX2kSPlUilB8YWbuhFlQni1/GI4Xdk1lB/4Wh6AHlM3cRKCOHReRpzRxYIHlzI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574459774321303.30069052499914;
 Fri, 22 Nov 2019 13:56:14 -0800 (PST)
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
Message-ID: <157445977223.7001.2372720475649008814@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Fri, 22 Nov 2019 13:56:14 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, eric.auger@redhat.com, bharatb.linux@gmail.com,
 qemu-arm@nongnu.org, dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMjE4Mjk0My40NjU2
LTEtZXJpYy5hdWdlckByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4
ODZfNjQtc29mdG1tdS9ody92aXJ0aW8vdmlydGlvLXNjc2ktcGNpLm8KICBDQyAgICAgIHg4Nl82
NC1zb2Z0bW11L2h3L3ZpcnRpby92aXJ0aW8tYmxrLXBjaS5vCi90bXAvcWVtdS10ZXN0L3NyYy9o
dy92aXJ0aW8vdmlydGlvLWlvbW11LmM6IEluIGZ1bmN0aW9uICdpbnRfY21wJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYzo2OTc6NTogZXJyb3I6IHVua25vd24g
dHlwZSBuYW1lICd1aW50JzsgZGlkIHlvdSBtZWFuICdndWludCc/CiAgICAgdWludCB1YSA9IEdQ
T0lOVEVSX1RPX1VJTlQoYSk7CiAgICAgXn5+fgogICAgIGd1aW50Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9ody92aXJ0aW8vdmlydGlvLWlvbW11LmM6Njk4OjU6IGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSAndWludCc7IGRpZCB5b3UgbWVhbiAnZ3VpbnQnPwogICAgIHVpbnQgdWIgPSBHUE9JTlRFUl9U
T19VSU5UKGIpOwogICAgIF5+fn4KICAgICBndWludAptYWtlWzFdOiAqKiogWy90bXAvcWVtdS10
ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUub10gRXJyb3IgMQpt
YWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L2FjY2VsL3RjZy90Y2ctcnVudGltZS5vCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvYWNjZWwvdGNnL3RjZy1ydW50aW1lLWd2ZWMubwotLS0KICBDQyAgICAgIGFhcmNoNjQt
c29mdG1tdS9ody9ibG9jay9kYXRhcGxhbmUvdmlydGlvLWJsay5vCiAgQ0MgICAgICBhYXJjaDY0
LXNvZnRtbXUvaHcvY2hhci9leHlub3M0MjEwX3VhcnQubwogIENDICAgICAgYWFyY2g2NC1zb2Z0
bW11L2h3L2NoYXIvb21hcF91YXJ0Lm8KbWFrZTogKioqIFtNYWtlZmlsZTo0OTE6IHg4Nl82NC1z
b2Z0bW11L2FsbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2NoYXIvZGlnaWMtdWFydC5vCiAgQ0Mg
ICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvY2hhci9zdG0zMmYyeHhfdXNhcnQubwotLS0KICBDQyAg
ICAgIGFhcmNoNjQtc29mdG1tdS9ody9hcm0vYm9vdC5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRt
bXUvaHcvYXJtL3N5c2J1cy1mZHQubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdmlydGlvL3ZpcnRp
by1pb21tdS5jOiBJbiBmdW5jdGlvbiAnaW50X2NtcCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody92
aXJ0aW8vdmlydGlvLWlvbW11LmM6Njk3OjU6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSAndWlu
dCc7IGRpZCB5b3UgbWVhbiAnZ3VpbnQnPwogICAgIHVpbnQgdWEgPSBHUE9JTlRFUl9UT19VSU5U
KGEpOwogICAgIF5+fn4KICAgICBndWludAovdG1wL3FlbXUtdGVzdC9zcmMvaHcvdmlydGlvL3Zp
cnRpby1pb21tdS5jOjY5ODo1OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ3VpbnQnOyBkaWQg
eW91IG1lYW4gJ2d1aW50Jz8KICAgICB1aW50IHViID0gR1BPSU5URVJfVE9fVUlOVChiKTsKICAg
ICBefn5+CiAgICAgZ3VpbnQKbWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMu
bWFrOjY5OiBody92aXJ0aW8vdmlydGlvLWlvbW11Lm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo0OTE6IGFh
cmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9k
dWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9MDI4ZGYzMzI1ZDdjNDkyN2ExYzMzNDA0MDAxNjcyOGYnLCAnLXUnLCAnMTAwMycs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdD
Q0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1jdXRoYnVkZS9zcmMvZG9ja2VyLXNyYy4yMDE5LTExLTIyLTE2LjQ5
LjUyLjUyMTA6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3Fl
bXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4K
ZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDI4ZGYzMzI1ZDdj
NDkyN2ExYzMzNDA0MDAxNjcyOGYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1h
a2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtY3V0
aGJ1ZGUvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9y
IDIKCnJlYWwgICAgNm0yMS4wMTJzCnVzZXIgICAgMG04LjMxOXMKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTIyMTgyOTQzLjQ2NTYt
MS1lcmljLmF1Z2VyQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


