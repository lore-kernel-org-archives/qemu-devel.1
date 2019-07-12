Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8395C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9FF206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9FF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxCZ-0008KT-5V
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlxCO-0007uh-Bz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlxCN-0008En-2t
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:11:00 -0400
Resent-Date: Fri, 12 Jul 2019 11:11:00 -0400
Resent-Message-Id: <E1hlxCN-0008En-2t@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlxCM-0008DU-Qc; Fri, 12 Jul 2019 11:10:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562944234; cv=none; d=zoho.com; s=zohoarc; 
 b=aC4+Tt+ZvyqkhW4MBGwPUP4FmpjmTEe513RBfOVJIPVWFzzvoCPwGFB3s5AyeQFQR0aEVwIst5ZaePIG/X7BJ7CcDJLDvCnk9PpeLaKYteBqzQSXNs4yeRVYTSdPKkh46N9a6rgtKiGkbk8IHge4JqYQyr0rud1jEm92Xeoi4uI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562944234;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=KFKVQlZ+hiD7Y/yLFhWdGD+6EayaMMXQXh0oGdYhEIc=; 
 b=PhJvilsF4xBSd7tmhIIn/kYxMLO5CJWhOVU/Hub+8BjuLP0jMd0F1bA3Qn9U7hJMFlrkIpfHv1r1NWpUqE6tq57id37M0cxNw3/mh0dbTwIv6GLACcm/B5TrNVBwen4peHO40cBlHa4CGtrRw71Kl4YfYXXHGVKTcGZPrME/MPc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15629442328741021.6922957521897;
 Fri, 12 Jul 2019 08:10:32 -0700 (PDT)
Message-ID: <156294423080.12463.1269186501858684252@c4a48874b076>
In-Reply-To: <20190711172845.31035-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Fri, 12 Jul 2019 08:10:32 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
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
U1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhcm0tc29mdG1tdS9tb25pdG9yL21pc2Mubwog
IENDICAgICAgaTM4Ni1zb2Z0bW11L2h3L3ZpcnRpby92aXJ0aW8tcG1lbS5vCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvaHcvYXJtL2ZzbC1pbXg3Lm8KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLW9qMnplal82L3NyYy9ody92aXJ0aW8vdmlydGlvLXBtZW0uYzoyMToxMDogZmF0YWwgZXJy
b3I6IHN0YW5kYXJkLWhlYWRlcnMvbGludXgvdmlydGlvX3BtZW0uaDogTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeQogICAyMSB8ICNpbmNsdWRlICJzdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRp
b19wbWVtLmgiCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNzExMTcyODQ1LjMxMDM1LTEtZXJp
Yy5hdWdlckByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


