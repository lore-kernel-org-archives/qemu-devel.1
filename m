Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31B0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EA220758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EA220758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNTp-0004X2-LR
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbNTI-00041i-Fd
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:05:16 -0400
Resent-Date: Wed, 20 May 2020 08:05:16 -0400
Resent-Message-Id: <E1jbNTI-00041i-Fd@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbNTH-0002H1-19
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589976301; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mLumU+aEd7qZUZ0jT2EKP/YtJV5xJqf8oiT6bri0rqD+dVggpYoiVteGmHLYiGoIP/loPVnxGSgGFIhh+6S7MUkKDW0YR5RFSyCY2IxfcNAhgXYJJY3Yf+/Jt45i5XOBZpBcFmg+TH5t4YSmO90y6G/4bg5HzpO/OGw9P9uNEO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589976301;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DtIRJLvno3PetJaMo8/IhJb9lbTYX4DOc4xfwaKKU/4=; 
 b=NuCbZbkml+4gbdYCM7YMDaDiDNXafSq35lE3q2pEWYjnoXj3Mqvi1LQ2FHN2r3iRiCoBMGlvYeK2oyMxPBK3l/ZD5ZxDpkzHOcqmb9YD+AxmGusDGaTOO4JTOcU2KqxlIPRdrTGHCrEb4Jvkl9d3yu4n5EK+0zbPu7EWMCSwpwo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589976299461268.77473304411683;
 Wed, 20 May 2020 05:04:59 -0700 (PDT)
Message-ID: <158997629777.27309.88585309452841694@45ef0f9c86ae>
In-Reply-To: <20200520093629.1495-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v7 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Wed, 20 May 2020 05:04:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 08:05:13
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMDA5MzYyOS4xNDk1
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L2h3L2FybS9uZXRkdWlub3BsdXMyLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0
bW11L2h3L2kzODYvaW50ZWxfaW9tbXUubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni9wYy5j
OiBJbiBmdW5jdGlvbiAncGNfbWFjaGluZV9kb25lJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kz
ODYvcGMuYzo4NDU6MzA6IGVycm9yOiAnUENNYWNoaW5lU3RhdGUnIHtha2EgJ3N0cnVjdCBQQ01h
Y2hpbmVTdGF0ZSd9IGhhcyBubyBtZW1iZXIgbmFtZWQgJ2Z3X2NmZycKICAgICBGV0NmZ1N0YXRl
ICpmd19jZmcgPSBwY21zLT5md19jZmc7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
Cm1ha2VbMV06ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvaTM4Ni9w
Yy5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL25zZXJpZXMubwogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L2h3L2FybS9vbWFwX3N4MS5vCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0
bW11L3RhcmdldC9hcm0vY3B1Lm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90YXJnZXQvYXJt
L2dkYnN0dWIubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vY3B1NjQubwpt
YWtlOiAqKiogW01ha2VmaWxlOjUyNzogeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvdGFyZ2V0L2FybS9nZGJzdHViNjQubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3Rh
cmdldC9hcm0vbWFjaGluZS5vCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0zZWY0YWM5OTE0YzA0ZDg2OTcwMjZkZTk1YTYzNzY4ZScsICctdScsICcxMDAxJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9E
SVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9j
a2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAta3A3YWQ0aTIvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0yMC0wOC4wMS41MS4yNjg0
MjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4n
LCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9
LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0zZWY0YWM5OTE0YzA0ZDg2OTcw
MjZkZTk1YTYzNzY4ZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTog
TGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rcDdhZDRpMi9z
cmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVh
bCAgICAzbTcuMTYwcwp1c2VyICAgIDBtOS4wNDZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUyMDA5MzYyOS4xNDk1LTEtbWlhb3l1
Ym9AaHVhd2VpLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

