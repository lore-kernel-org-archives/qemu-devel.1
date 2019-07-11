Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A93C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6B221537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6B221537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhWm-0007Gu-4B
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38832)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlhWa-0006lw-Rx
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlhWZ-0005gd-Jy
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:26:48 -0400
Resent-Date: Thu, 11 Jul 2019 18:26:48 -0400
Resent-Message-Id: <E1hlhWZ-0005gd-Jy@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlhWZ-0005ZP-Bn
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562883968; cv=none; d=zoho.com; s=zohoarc; 
 b=HVNOUPdVC4adh+ON1SafTmT/PKJ7N9PKJH3QIInf0BID5/KWpbviZTjI7DHqnwxcdGmL4AmfsgfkHlxPU+MRgz5GK0MyFXcP0las2gFoui7OPKLkG/vKo3oASL+C0+oxaunJdXx64jBB1ogIQSQ4ZxqIS7Kh9YwMuEFpcA8K+aU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562883968;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=aifl6bsVuqHmMA4CldjdqwLxfkuDkSE718RvMbYrfr8=; 
 b=f1zlHT6GraTMFbshz07ZI8V3YwVxOlxi37J7f24ccXn+l5+kBzaOzOSWP4H0LiBwCGqUujm5bK17ECLluLUfIkRS+8nvgSAiDtFWEI8ltSPesHzsNPc3/tPzOHxyQMT6PtCWGKbFqq/GpVyYlz9LaP2K0nXGWlU45JloFXz28kg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562883966760138.24248795858557;
 Thu, 11 Jul 2019 15:26:06 -0700 (PDT)
Message-ID: <156288396475.12463.8495950257512135187@c4a48874b076>
In-Reply-To: <20190711173933.31203-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Thu, 11 Jul 2019 15:26:06 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [RFC v5 00/29] vSMMUv3/pSMMUv3 2 stage VFIO
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMTE3MzkzMy4zMTIw
My0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVp
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
U1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBpMzg2LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRp
by1jcnlwdG8ubwogIENDICAgICAgaTM4Ni1zb2Z0bW11L2h3L3ZpcnRpby92aXJ0aW8tY3J5cHRv
LXBjaS5vCiAgQ0MgICAgICBpMzg2LXNvZnRtbXUvaHcvdmlydGlvL3ZpcnRpby1wbWVtLm8KL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXU1MmxqamswL3NyYy9ody92aXJ0aW8vdmlydGlvLXBt
ZW0uYzoyMToxMDogZmF0YWwgZXJyb3I6IHN0YW5kYXJkLWhlYWRlcnMvbGludXgvdmlydGlvX3Bt
ZW0uaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQogICAyMSB8ICNpbmNsdWRlICJzdGFuZGFy
ZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19wbWVtLmgiCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4KCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
NzExMTczOTMzLjMxMjAzLTEtZXJpYy5hdWdlckByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


