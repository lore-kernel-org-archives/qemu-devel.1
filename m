Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8BBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2EA2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2EA2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZSF-0002zx-LK
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqZRj-0002VG-JC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:54:27 -0400
Resent-Date: Wed, 01 Jul 2020 05:54:27 -0400
Resent-Message-Id: <E1jqZRj-0002VG-JC@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqZRg-0001G7-I8
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593597236; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MB6iX1r3bc08MfgHkHoI2ORyForRgputtpVrAIDXZ/U1YObRFP8hl7X+AaUObTHjISo5jbyY32PFp2b9mNWjhJeYkjxU9zUkWnHAVVoMyuY3UebFTHyDybgVTq/xquCW2wfIkYAZh2o9+1UASw/uafUMR77+rghkW5KffFrvNW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593597236;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gHKhh8QfaZ5WyxI9K+cK9HibxQzOmWCq7MxHn0Id9XY=; 
 b=FWVyU8KRENgDf6+0vFRY8BOtJkR09MO7ONz7g0E0NgaMGxKsEE6GewHhYnmbYxbRkqz+chCLNqgMfrLQYENUmd8VKxB9J3KiWenBCNTXhCzzGx95Bc3HZfYYErEYg7/pwrNiKybtEPvaxQ0+w0RAN2H95Afx3FFwuiZd0GGc+/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593597234419992.6330243285137;
 Wed, 1 Jul 2020 02:53:54 -0700 (PDT)
Message-ID: <159359723131.26405.13534157972316101442@d1fd068a5071>
Subject: Re: [PATCH v3 00/13]  vDPA support in qemu
In-Reply-To: <20200701092449.17451-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lulu@redhat.com
Date: Wed, 1 Jul 2020 02:53:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 05:54:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, mst@redhat.com, mhabets@solarflare.com,
 qemu-devel@nongnu.org, rob.miller@broadcom.com, saugatm@xilinx.com,
 lulu@redhat.com, armbru@redhat.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, jasowang@redhat.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 maxime.coquelin@redhat.com, aadam@redhat.com, cohuck@redhat.com,
 hanand@xilinx.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMTA5MjQ0OS4xNzQ1
MS0xLWx1bHVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0LXFjb3cy
OiAwMzkKQnJva2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmM6MTc1OiBraWxsX3FlbXUoKSBkZXRlY3RlZCBRRU1VIGRlYXRoIGZyb20gc2lnbmFsIDExIChT
ZWdtZW50YXRpb24gZmF1bHQpIChjb3JlIGR1bXBlZCkKRVJST1IgLSB0b28gZmV3IHRlc3RzIHJ1
biAoZXhwZWN0ZWQgNCwgZ290IDEpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJv
ciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCnFlbXUtc3lzdGVt
LWFhcmNoNjQ6IC1hY2NlbCBrdm06IGludmFsaWQgYWNjZWxlcmF0b3Iga3ZtCnFlbXUtc3lzdGVt
LWFhcmNoNjQ6IGZhbGxpbmcgYmFjayB0byB0Y2cKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTYzZTgwYTYxYjlhOTQ5ODc4ZTcxOWViY2M2MmUxNjViJywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1l
JywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXZyaXdrYXQ1L3NyYy9kb2NrZXItc3JjLjIwMjAtMDctMDEt
MDUuMzguMDEuMjM3MjY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTYzZTgw
YTYxYjlhOTQ5ODc4ZTcxOWViY2M2MmUxNjViCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLXZyaXdrYXQ1L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9z
N10gRXJyb3IgMgoKcmVhbCAgICAxNW01MS4xNTlzCnVzZXIgICAgMG05LjA3MHMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAxMDky
NDQ5LjE3NDUxLTEtbHVsdUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

