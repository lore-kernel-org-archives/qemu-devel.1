Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9B9C742A2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 00:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65696208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 00:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65696208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hljNK-0000VG-Mu
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 20:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41270)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hljN8-0008NO-7a
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 20:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hljN7-00054D-2M
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 20:25:10 -0400
Resent-Date: Thu, 11 Jul 2019 20:25:10 -0400
Resent-Message-Id: <E1hljN7-00054D-2M@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hljN5-0004yS-58
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 20:25:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562884764; cv=none; d=zoho.com; s=zohoarc; 
 b=f7juZXvE+04jW/LKmX2YtIpMSvTikt3V2BBMs3ky316x6UEb80bcokBteUGM//gyEVybspTr3kfn+uB8U/yhi+3HfdMTjf3R6f22JwucwchX1ebkPTuxKvihqcbXnNxOHa5jL4SayFP4ybDoykj7U1Wxlav7iMFDxalXpa9h1V0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562884764;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=qtqWDPLt956MNZhBpI2AVtak/U3zOs3s9hVHtz24VAI=; 
 b=KmBm1wghE483RVejYoCiwNE3H1IVuihsnkOF3E6cUNj/NuJUijLvH6OghZlCUF/v58TwlKmGNlkOy6wjRpVulF+nAuggx092SEBNOt1UiUFyXcwrA6Bja3Ip6EToH7wJibGIrFqDBwrTr7j4SQ08f0vdvMcJllfJ1Kk3tnW8NfY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562884763338180.8392248933842;
 Thu, 11 Jul 2019 15:39:23 -0700 (PDT)
Message-ID: <156288476131.12463.4757639996334325979@c4a48874b076>
In-Reply-To: <20190711172845.31035-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Thu, 11 Jul 2019 15:39:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [RFC v4 00/29] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, yi.l.liu@intel.com,
 mst@redhat.com, jean-philippe.brucker@arm.com, zhangfei.gao@foxmail.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, vincent.stehle@arm.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMTE3Mjg0NS4zMTAz
NS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVp
bGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxs
IGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0
byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIK
IyBicmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAi
PT09IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1bmFt
ZSAtYQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0QvYnVp
bGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2NvbmZp
Z3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVlZCBy
ZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL21zZjIt
c29jLm8KICBDQyAgICAgIGkzODYtc29mdG1tdS9ody92aXJ0aW8vdmlydGlvLXBtZW0ubwogIEND
ICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9tdXNjYS5vCi92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1yNnR2ZjlhMy9zcmMvaHcvdmlydGlvL3ZpcnRpby1wbWVtLmM6MjE6MTA6IGZhdGFs
IGVycm9yOiBzdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19wbWVtLmg6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkKICAgMjEgfCAjaW5jbHVkZSAic3RhbmRhcmQtaGVhZGVycy9saW51eC92
aXJ0aW9fcG1lbS5oIgogICAgICB8ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcxMTE3Mjg0NS4zMTAzNS0x
LWVyaWMuYXVnZXJAcmVkaGF0LmNvbS90ZXN0aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


