Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FCCC606CF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50E521707
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50E521707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkbx7-0000Lm-DE
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 18:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkbvo-0008K2-Fp
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkbvn-000202-6S
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:16:20 -0400
Resent-Date: Mon, 08 Jul 2019 18:16:20 -0400
Resent-Message-Id: <E1hkbvn-000202-6S@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkbvm-0001xk-SV
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:16:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562624108; cv=none; d=zoho.com; s=zohoarc; 
 b=XFdrkSmnbzW8amcD36iFReyA8PHPI8qvKL/V9+vUjTyPFOrEPbR32Ibt2oeSMG3c3Dgl5TPTestwOrUUzFS3of2Q5drukeE2kfVC2eajzYaLKcDTzMcnLrjggDEBhxkGaBXDeO0f4ADY71hqSHyt1xxUbSy9oZspc/QcupQ5fqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562624108;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Xhdj2DeEhjR9S7hw6CA/gr+SCzLOPefHIS3TIw1Dnik=; 
 b=SWgzN8snISr4vpdZgBSDTUZNViR4EEAmd2bMj6rIYox/O94y6MmOLhw6a9H7Yb7X0lyQRXwG6d/lsGG5m+rc4L8Khx4064N8YHjlcbnneHAxJ4DKlD3Xiv2Vvhw22L3FTUy+m2u0EVsGraauJmWZZBxlzFqYvs7OkUUA5LPrsYQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156262410736543.6120295990529;
 Mon, 8 Jul 2019 15:15:07 -0700 (PDT)
Message-ID: <156262410486.25929.605075715050003163@c4a48874b076>
In-Reply-To: <1562613452-24969-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Mon, 8 Jul 2019 15:15:07 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v5 00/13] Add migration support for VFIO
 device
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYyNjEzNDUyLTI0OTY5LTEt
Z2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0
LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBibG9jay9xZWQtdGFibGUubwogIENDICAgICAgYmxvY2svcWVkLWNsdXN0ZXIubwpJbiBmaWxl
IGluY2x1ZGVkIGZyb20gaHcvdmZpby90cmFjZS5jOjQ6Ci90bXAvcWVtdS10ZXN0L2J1aWxkL2h3
L3ZmaW8vdHJhY2UuaDozNjU1OjEyNjogZXJyb3I6IGV4cGVjdGVkICcpJwogICAgICAgIHFlbXVf
bG9nKCIlZEAlenUuJTA2enU6dmZpb19zYXZlX3BlbmRpbmcgIiAiICglcyksIHByZWNvcHkgMHgl
IlBSSXg2NCIgcG9zdGNvcHkgMHgleCJQUkl4NjQiIGNvbXBhdGlibGUgMHglIiJQUkl4NjQgIlxu
IiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L2J1aWxkL2h3L3ZmaW8vdHJhY2UuaDozNjU1
OjE3OiBub3RlOiB0byBtYXRjaCB0aGlzICcoJwogICAgICAgIHFlbXVfbG9nKCIlZEAlenUuJTA2
enU6dmZpb19zYXZlX3BlbmRpbmcgIiAiICglcyksIHByZWNvcHkgMHglIlBSSXg2NCIgcG9zdGNv
cHkgMHgleCJQUkl4NjQiIGNvbXBhdGlibGUgMHglIiJQUkl4NjQgIlxuIiwKICAgICAgICAgICAg
ICAgIF4KL3RtcC9xZW11LXRlc3QvYnVpbGQvaHcvdmZpby90cmFjZS5oOjM2NTU6MTI4OiBlcnJv
cjogbWlzc2luZyB0ZXJtaW5hdGluZyAnIicgY2hhcmFjdGVyIFstV2Vycm9yLC1XaW52YWxpZC1w
cC10b2tlbl0KICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9fc2F2ZV9wZW5kaW5n
ICIgIiAoJXMpLCBwcmVjb3B5IDB4JSJQUkl4NjQiIHBvc3Rjb3B5IDB4JXgiUFJJeDY0IiBjb21w
YXRpYmxlIDB4JSIiUFJJeDY0ICJcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L2J1
aWxkL2h3L3ZmaW8vdHJhY2UuaDozNzcwOjk4OiBlcnJvcjogZXhwZWN0ZWQgJyknCiAgICAgICAg
cWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX2xvYWRfc3RhdGVfZGV2aWNlX2RhdGEgIiAiICgl
cyksIE9mZnNldCAweCUiUFJJeDY0IiBzaXplIDB4JSJQUkl4NiAiXG4iLAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9idWlsZC9ody92Zmlv
L3RyYWNlLmg6Mzc3MDoxNzogbm90ZTogdG8gbWF0Y2ggdGhpcyAnKCcKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjI2MTM0NTItMjQ5Njkt
MS1naXQtc2VuZC1lbWFpbC1rd2Fua2hlZGVAbnZpZGlhLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


