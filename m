Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24852C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBF22166E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBF22166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhnX-0000rD-6l
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 00:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkhlH-0008Bn-8F
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkhlF-0005hp-9K
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:29:51 -0400
Resent-Date: Tue, 09 Jul 2019 00:29:50 -0400
Resent-Message-Id: <E1hkhlF-0005hp-9K@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkhlD-0005ga-Fx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562646565; cv=none; d=zoho.com; s=zohoarc; 
 b=Hz977ZjrBpQIrSlLXm7pcBy00Q6v/xY9hyPOhXJ/H6xOgsUwL8k6QMsn6VB0tDeetlm9m++vxI8u3Kw9dITSd91Cq9TtSYpzFOsZNj8Q54cp3FOPU2KCfI+x4U22+zzLycgzWHZX8pVl8SwuitHHSz7DLXcLlSvwJlQWASRg2XM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562646565;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=CkzZd5rdPHga3AmitGb2iSb+4FIYpP1crDkJ5jxcoCM=; 
 b=iDRGSu4Pwf9tp061cJNphpdYEmPHovjuRaPo9ilRdGTDBm0SfVDLSYEsBi4jBfrvD7KjMH0rj9WUnt4HqxHp8ZG69RqgBJSRL11A2Lv7GpyJkKlQx4hql/gbsWjip80JrvQ0yMiM1wb7qSRoVfS2WAqC+IJNIilvbROSA/FhFnM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562646563499581.3627582296537;
 Mon, 8 Jul 2019 21:29:23 -0700 (PDT)
Message-ID: <156264656088.29002.58169205026833340@c4a48874b076>
In-Reply-To: <1562637554-22439-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Mon, 8 Jul 2019 21:29:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 00/13] Add migration support for VFIO
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYyNjM3NTU0LTIyNDM5LTEt
Z2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0
LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICByZXBsaWNhdGlvbi5vCiAgQ0MgICAgICBibG9jay9yYXctZm9ybWF0Lm8KSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIGh3L3ZmaW8vdHJhY2UuYzo0OgovdG1wL3FlbXUtdGVzdC9idWlsZC9ody92Zmlv
L3RyYWNlLmg6MzY1ODozNTogZXJyb3I6IGZvcm1hdCBzcGVjaWZpZXMgdHlwZSAndW5zaWduZWQg
aW50JyBidXQgdGhlIGFyZ3VtZW50IGhhcyB0eXBlICd1aW50NjRfdCcgKGFrYSAndW5zaWduZWQg
bG9uZycpIFstV2Vycm9yLC1XZm9ybWF0XQogICAgICAgICAgICAgICAgICwgbmFtZSwgcHJlY29w
eSwgcG9zdGNvcHksIGNvbXBhdGlibGUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn4KL3RtcC9xZW11LXRlc3QvYnVpbGQvaHcvdmZpby90cmFjZS5oOjM3NzA6OTg6
IGVycm9yOiBleHBlY3RlZCAnKScKICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9f
bG9hZF9zdGF0ZV9kZXZpY2VfZGF0YSAiICIgKCVzKSwgT2Zmc2V0IDB4JSJQUkl4NjQiIHNpemUg
MHglIlBSSXg2ICJcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L2J1aWxkL2h3L3ZmaW8vdHJhY2UuaDozNzcwOjE3OiBub3RlOiB0byBt
YXRjaCB0aGlzICcoJwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMTU2MjYzNzU1NC0yMjQzOS0xLWdpdC1zZW5kLWVtYWlsLWt3YW5raGVkZUBu
dmlkaWEuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


