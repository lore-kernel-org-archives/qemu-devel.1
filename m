Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AB1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D88F20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D88F20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVYc-0004K6-LW
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCVY0-0003po-0Z
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCVXy-0001pZ-Cn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:39:19 -0400
Resent-Date: Thu, 12 Mar 2020 17:39:19 -0400
Resent-Message-Id: <E1jCVXy-0001pZ-Cn@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCVXy-0001nP-4t; Thu, 12 Mar 2020 17:39:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584049147; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cjzvMA1H8Gct+rTDOY81ZY1hZRM1DCPsYovdLdszgVatC1ILO4CAvJIQyzqHE2TtoE0PbIMwJxXoQmYpFRWZIEWm6MRrCXatGA09bEn+MVL5lc/oGRVwvJG/NabO++cTvJ0glZQgo781RFew/xnHdfYYVXxRMAIp6xACPqNiGDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584049147;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IvxfYoH/LFm7pcEsFjTjP87hQCZ/55HJ0b1GXIGyKjg=; 
 b=fEmeMC4V53NfNCoLE8glZF3L8eg/OaeCIWEyKklPCRPjgUvgkzK1/bGn/B3pA28Zzib5t7XIPeHyd3bI0NZnK0jUuy/rwEf6/n27CO4pqer9DoaOUS45RkCDBklYyK8k5lRLxaVqbBuglIau9FMVOrwXAI5AnYmkDIokGytVW74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158404914581059.00676860269948;
 Thu, 12 Mar 2020 14:39:05 -0700 (PDT)
In-Reply-To: <20200312192822.3739399-1-eblake@redhat.com>
Subject: Re: [PATCH v4 0/7] Tighten qemu-img rules on missing backing format
Message-ID: <158404914429.16773.14555927621203301707@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Thu, 12 Mar 2020 14:39:05 -0700 (PDT)
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMjE5MjgyMi4zNzM5
Mzk5LTEtZWJsYWtlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNU
PXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09Cgog
IENDICAgICAgYmxvY2svcmVwbGljYXRpb24ubwogIENDICAgICAgYmxvY2svdGhyb3R0bGUubwog
IENDICAgICAgYmxvY2svY29weS1vbi1yZWFkLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3No
ZWVwZG9nLmM6MjE3NDo5OiBlcnJvcjogdmFyaWFibGUgJ3FkaWN0JyBpcyB1c2VkIHVuaW5pdGlh
bGl6ZWQgd2hlbmV2ZXIgJ2lmJyBjb25kaXRpb24gaXMgdHJ1ZSBbLVdlcnJvciwtV3NvbWV0aW1l
cy11bmluaXRpYWxpemVkXQogICAgaWYgKGJhY2tpbmdfZm10ICYmIHN0cmNtcChiYWNraW5nX2Zt
dCwgInNoZWVwZG9nIikgIT0gMCkgewogICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBk
b2cuYzoyMjQxOjE5OiBub3RlOiB1bmluaXRpYWxpemVkIHVzZSBvY2N1cnMgaGVyZQotLS0KICAg
ICAgICAgICAgICAgIF4KICAgICAgICAgICAgICAgICA9IE5VTEwKMSBlcnJvciBnZW5lcmF0ZWQu
Cm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYmxvY2svc2hlZXBk
b2cub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD05Mzk5N2U1YjVlYjM0YzJmOWNiODUzNjM3MTNhN2Y4NScsICctdScs
ICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC03bDhjOTF3dS9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTAzLTEyLTE3LjM1LjUxLjY0ODA6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6
ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9u
LXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9OTM5OTdlNWI1ZWIzNGMyZjljYjg1MzYzNzEzYTdmODUKbWFrZVsxXTogKioqIFtk
b2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtN2w4Yzkxd3Uvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVz
dC1kZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM20xNC4wNzFzCnVzZXIgICAgMG04LjU1
NXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwMzEyMTkyODIyLjM3MzkzOTktMS1lYmxha2VAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4v
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

