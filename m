Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACFAC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAF6206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAF6206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJte-0007DR-U9
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGJsA-0006JV-OI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGJs9-0005s1-Dk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:59:54 -0400
Resent-Date: Mon, 23 Mar 2020 05:59:54 -0400
Resent-Message-Id: <E1jGJs9-0005s1-Dk@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGJs9-0005rk-8N; Mon, 23 Mar 2020 05:59:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584957580; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hGO562kmRERM2as903OkAoUdhxXiVvWmb2qSUl2hpUEVtx0t7NczYDDh0/tM2R7NjoHhVrf9GGlVLgxfld6WUdkMA9dQhnxeJC9jAV6F4ufJLY+yj0rjsOicd32BUl732gnqPPyhXteJkKDQuYZs8nXN+pOSB3GCx8jX4zQlGho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584957580;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=czJRz+gbDDkNk/4k2pzZNP91QW0RRuLSY8JdJA/ewIs=; 
 b=JO+4Qmc1evDJI5GhMTegq1LO5MXtAxSh7GQgAyJZWTsdpuk9jtThpPHP3ywwwnqmFqVBhEHEvjLk5ms2VgKx+jWBzn66d3vmol+OP2pUo4JVQbg5iMyU/Ry9txwsjwC3d0r2IKChWXwAG/TEBYHRVSD3zMSsPAQTi6nxHCoMync=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584957577228921.7728560470297;
 Mon, 23 Mar 2020 02:59:37 -0700 (PDT)
In-Reply-To: <20200323084617.1782-1-bbhushan2@marvell.com>
Subject: Re: [PATCH v9 0/9] virtio-iommu: VFIO integration
Message-ID: <158495757489.4794.5101864136318571530@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bbhushan2@marvell.com
Date: Mon, 23 Mar 2020 02:59:37 -0700 (PDT)
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 bharatb.linux@gmail.com, jean-philippe@linaro.org, linuc.decode@gmail.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyMzA4NDYxNy4xNzgy
LTEtYmJodXNoYW4yQG1hcnZlbGwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4
ODZfNjQtc29mdG1tdS9ody92aXJ0aW8vdmlydGlvLWJsay1wY2kubwogIENDICAgICAgeDg2XzY0
LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRpby1uZXQtcGNpLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L3ZpcnRpby92aXJ0aW8taW9tbXUuYzogSW4gZnVuY3Rpb24gJ3ZpcnRpb19pb21tdV9maWxsX3By
b3BlcnR5JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYzo1NzY6
MjI6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIHVu
c2lnbmVkIGludCcsIGJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlICdzaXplX3QnIHtha2EgJ2xvbmcg
bG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9XQogICAgICAgICBlcnJvcl9yZXBv
cnQoIiVzIHByb3BlcnR5IG9mIHR5cGU9JWQgY291bGQgbm90IGJlIGZpbGxlZCAoJWQpLCIKICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ody92aXJ0aW8vdmlydGlvLWlvbW11LmM6
NTc4OjQzOgotLS0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+
XgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJWxseApjYzE6IGFs
bCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogWy90bXAvcWVt
dS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUub10gRXJyb3Ig
MQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAg
YWFyY2g2NC1zb2Z0bW11L2h3L3Njc2kvdmlydGlvLXNjc2ktZGF0YXBsYW5lLm8KICBDQyAgICAg
IGFhcmNoNjQtc29mdG1tdS9ody9zZW1paG9zdGluZy9jb25maWcubwotLS0KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS9ody92aXJ0aW8vdmlydGlvLWJhbGxvb24tcGNpLm8KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS9ody92aXJ0aW8vdmlydGlvLWlvbW11LXBjaS5vCiAgQ0MgICAgICBhYXJj
aDY0LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5vCm1ha2U6ICoqKiBbTWFrZWZp
bGU6NTI3OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody92aXJ0aW8v
dmlydGlvLWJsay1wY2kubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L3ZpcnRpby92aXJ0
aW8tbmV0LXBjaS5vCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS92aXJ0Lm8K
ICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLm8KL3RtcC9x
ZW11LXRlc3Qvc3JjL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYzogSW4gZnVuY3Rpb24gJ3ZpcnRp
b19pb21tdV9maWxsX3Byb3BlcnR5JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3ZpcnRpby92aXJ0
aW8taW9tbXUuYzo1NzY6MjI6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0cyBhcmd1bWVudCBv
ZiB0eXBlICdsb25nIHVuc2lnbmVkIGludCcsIGJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlICdzaXpl
X3QnIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9XQogICAg
ICAgICBlcnJvcl9yZXBvcnQoIiVzIHByb3BlcnR5IG9mIHR5cGU9JWQgY291bGQgbm90IGJlIGZp
bGxlZCAoJWQpLCIKICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ody92aXJ0aW8v
dmlydGlvLWlvbW11LmM6NTc4OjQzOgotLS0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH5+XgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJWxseApjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFd
OiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L3ZpcnRpby92aXJ0aW8t
aW9tbXUub10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9kaWdpY19ib2FyZHMubwptYWtl
OiAqKiogW01ha2VmaWxlOjUyNzogYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJh
Y2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2Vy
LnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
bGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD00ODBmY2I1NmI4NDU0YTgwYWUxNDBjZTM3
M2U5NDBlZScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25m
aW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJrcnk4eGg5L3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDMtMjMtMDUuNTUuNDcuMTY2OTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD00ODBmY2I1NmI4NDU0YTgwYWUxNDBjZTM3M2U5NDBlZQptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1ya3J5OHhoOS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTQ3LjAzOXMKdXNlciAgICAwbTcu
NTg5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDAzMjMwODQ2MTcuMTc4Mi0xLWJiaHVzaGFuMkBtYXJ2ZWxsLmNvbS90ZXN0aW5nLmRv
Y2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

