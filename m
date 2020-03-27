Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FAC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6C42074F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6C42074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnkl-0003cS-0r
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHnkB-0003Ds-TN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHnkA-00022R-8b
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:05:47 -0400
Resent-Date: Fri, 27 Mar 2020 08:05:47 -0400
Resent-Message-Id: <E1jHnkA-00022R-8b@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHnk9-0001wQ-Us
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:05:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585310739; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RmrD2Ea2YbxofAuewhN+pjO4Aawa8g5I4YY1G+QYWkcXrSEnBqzm6WCun7DDHKLdP9hkXFVQI/wfPHLoRx4T1yufMMiNgQTiHTh9d2OVf7SdAZnblwbe06Daz4jSsEb10p0NUzF2cCUzfy8sHI/NYiZEqW8U1C2fy88bZnwL0lE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585310739;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uTG7VYCpwRQ7pl6D5JT6ZEx48beiuJUOuBKU9DUSvN4=; 
 b=JphDg93c0lDvU2z0r9F8LO6xfF75z7qfZj1aUqnRRqcPJINKu/L67590UFCi6vF7T7mJMmFqNV0D2mQ9P3ufJXMD322kBemLRoJymhBALUZ1N4RZU8iR/FhIUjovQUsbGymurzIboDD8qLTLZEJBPh48k1K76sL/M/hsubgP0IQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585310738797925.9667552222573;
 Fri, 27 Mar 2020 05:05:38 -0700 (PDT)
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
Subject: Re: [PULL 00/13] Net patches
Message-ID: <158531073768.31566.5283456712651053023@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jasowang@redhat.com
Date: Fri, 27 Mar 2020 05:05:38 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg1MzA3NjQ3LTI0NDU2LTEt
Z2l0LXNlbmQtZW1haWwtamFzb3dhbmdAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhl
IHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9j
a2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NApt
YWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRl
c3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09Cgog
IENDICAgICAgaHcvbmV0L3JvY2tlci9yb2NrZXJfd29ybGQubwogIENDICAgICAgaHcvbmV0L3Jv
Y2tlci9yb2NrZXJfb2ZfZHBhLm8KICBDQyAgICAgIGh3L25ldC9jYW4vY2FuX3NqYTEwMDAubwov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L2FsbHdpbm5lci1zdW44aS1lbWFjLmM6NzczOjIwOiBl
cnJvcjogaW5pdGlhbGl6YXRpb24gb2YgJ19Cb29sICgqKShOZXRDbGllbnRTdGF0ZSAqKScge2Fr
YSAnX0Jvb2wgKCopKHN0cnVjdCBOZXRDbGllbnRTdGF0ZSAqKSd9IGZyb20gaW5jb21wYXRpYmxl
IHBvaW50ZXIgdHlwZSAnaW50ICgqKShOZXRDbGllbnRTdGF0ZSAqKScge2FrYSAnaW50ICgqKShz
dHJ1Y3QgTmV0Q2xpZW50U3RhdGUgKiknfSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10
eXBlc10KICAgICAuY2FuX3JlY2VpdmUgPSBhbGx3aW5uZXJfc3VuOGlfZW1hY19jYW5fcmVjZWl2
ZSwKICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L2FsbHdpbm5lci1zdW44aS1lbWFjLmM6NzczOjIwOiBu
b3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IgJ25ldF9hbGx3aW5uZXJfc3VuOGlfZW1hY19p
bmZvLmNhbl9yZWNlaXZlJykKY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJv
cnMKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9uZXQvYWxs
d2lubmVyLXN1bjhpLWVtYWMub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLgogIENDICAgICAgaHcvbmV0L2Nhbi9jYW5fa3Zhc2VyX3BjaS5vClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTVmOTgzMjhkZGM5NTQ2ZTNhMjI3MzJiNjlkMzMxMDM5JywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtMjVqbTY0MzUvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0yNy0w
OC4wMy4zNy4yNDg3MjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01Zjk4MzI4
ZGRjOTU0NmUzYTIyNzMyYjY5ZDMzMTAzOQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC0yNWptNjQzNS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0g
RXJyb3IgMgoKcmVhbCAgICAybTEuMjM4cwp1c2VyICAgIDBtOC4xNzlzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg1MzA3NjQ3LTI0NDU2
LTEtZ2l0LXNlbmQtZW1haWwtamFzb3dhbmdAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5n
d0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

