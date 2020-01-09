Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A4DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578DA206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578DA206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZVb-0002O2-CL
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipZV0-0001oU-Du
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipZUy-0002Hn-PE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:13:25 -0500
Resent-Date: Thu, 09 Jan 2020 10:13:25 -0500
Resent-Message-Id: <E1ipZUy-0002Hn-PE@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipZUy-00026H-Fw; Thu, 09 Jan 2020 10:13:24 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578582782; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kBS7/GQYz5gC0+ZbFbiAlHdw1SAUqGrN585N2B3A15EeDZuMnH0O+huUbYr8Np8VT2pmlRe/cGRY2k10lZkNY07j9DL6URzzd3NbOCaW6vLBMefa0iVgiJhbJbZBX1RuAURez3oXX6Qypo1+BCO4lK4iLW79IaiTe4sy822LW00=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578582782;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ddVp8ND7Kl/wMUaqnHDncxX4FWAN1DQjdQPag2p8LIE=; 
 b=cK5/FW+ypCK2dOQKutFQfIZp7EUudTFUtuZ8nEveha51g8coZ3KGrJ/aqcfrw7NxHmqPlW4J+cKepR8U9L+9IJNfzqotOzlU3AgqqW4x0Bb2+WbDgOPXsF66eo+Jl7iqBpJaCptAdFc8EnpqvE/sImYF8/axnHUdbdmJ97HE+b4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578582777749657.5808867795997;
 Thu, 9 Jan 2020 07:12:57 -0800 (PST)
In-Reply-To: <20200109144319.15912-1-eric.auger@redhat.com>
Subject: Re: [PATCH v12 00/13] VIRTIO-IOMMU device
Message-ID: <157858277631.10632.10417491075155237341@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Thu, 9 Jan 2020 07:12:57 -0800 (PST)
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 jean-philippe@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, eric.auger@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, mst@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwOTE0NDMxOS4xNTkx
Mi0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2st
cXRlc3QteDg2XzY0OiB0ZXN0cy90ZXN0LWhtcAogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0
OiB0ZXN0cy9xb3MtdGVzdAoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvdmlydGlv
LWlvbW11LXRlc3QuYzo0NjpwY2lfY29uZmlnOiBhc3NlcnRpb24gZmFpbGVkIChwcm9iZV9zaXpl
ID09IDB4MjAwKTogKDB4MDAwMDAwMDAgPT0gMHgwMDAwMDIwMCkKRVJST1IgLSBCYWlsIG91dCEg
RVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3ZpcnRpby1pb21tdS10ZXN0LmM6NDY6cGNp
X2NvbmZpZzogYXNzZXJ0aW9uIGZhaWxlZCAocHJvYmVfc2l6ZSA9PSAweDIwMCk6ICgweDAwMDAw
MDAwID09IDB4MDAwMDAyMDApCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVj
ay1xdGVzdC1hYXJjaDY0OiB0ZXN0cy90ZXN0LWhtcAogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAy
MjAKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9j
ZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcics
ICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWRlMjE1NDE2MWNjZjQ0
NjhhZjVlYmQzNWNiY2JkYzAzJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2Vj
Y29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VY
VFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RF
QlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2Nh
Y2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zh
ci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV9hcDZ1
bGNoL3NyYy9kb2NrZXItc3JjLjIwMjAtMDEtMDktMTAuMDEuMDUuMzI0NzI6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNr
J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJl
bD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWRlMjE1NDE2MWNjZjQ0NjhhZjVlYmQzNWNiY2JkYzAz
Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV9hcDZ1bGNoL3NyYycKbWFrZTogKioq
IFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxMW01MC44
OThzCnVzZXIgICAgMG04LjAyM3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTA5MTQ0MzE5LjE1OTEyLTEtZXJpYy5hdWdlckByZWRo
YXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


