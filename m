Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4368C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC1C21738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC1C21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPnm-0000PR-SF
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hjPmL-0007oq-Rk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hjPmI-0001Hy-MK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:05:36 -0400
Resent-Date: Fri, 05 Jul 2019 11:05:36 -0400
Resent-Message-Id: <E1hjPmI-0001Hy-MK@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hjPmI-0000xM-CN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562338210; cv=none; d=zoho.com; s=zohoarc; 
 b=J7TDLGIBlZeVRu9wqxd9U8Rxs32Gty42qgGG7L+MzqbW0otK8V+HOe0kswcVh97VOgmqh4OxujWT7CSM6xgqcg+YX4LbDm1NlO3pC4gFK1L1LlUZORgDJTeq7/9VVF5gAmoTMV8xf5InPtA415aZycHzl5Nc2ouS8esHz+sUZDY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562338210;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=G8MCxrU+kukJcmJlmv9viZjd1yUsOk6n7sy2OWMqY44=; 
 b=dd7S2fjzjugOby85tgW7DzfotV22JfCqzeM01NPzn8XClYyasNP7JqGmEIDp6aHtfjdBrsAwh1vpgNcGquLZa/rB5K036FXMPiTmkmy3IshMEltEY0yss2CcqOkIpO2zdwERTl/q68alFn7yrjhwLdjh5nyNjf1hfnrcE/uYjm4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562338210303696.7143635139587;
 Fri, 5 Jul 2019 07:50:10 -0700 (PDT)
Message-ID: <156233820952.4051.5819777599182156401@c4a48874b076>
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Fri, 5 Jul 2019 07:50:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PULL 0/9] target-arm queue
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwNDE2MDgwMi4xMjQx
OS0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
YnVpbGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3
aWxsIGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGlu
ZyB0byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFz
ZSIKIyBicmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNo
byAiPT09IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1
bmFtZSAtYQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0Qv
YnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2Nv
bmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVl
ZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBsbTMyLXNvZnRtbXUvdGNnL3RjZy1vcC12
ZWMubwogIENDICAgICAgbG0zMi1zb2Z0bW11L3RjZy90Y2ctb3AtZ3ZlYy5vCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5vCi92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC03OV9scDlrdi9zcmMvdGFyZ2V0L2FybS9tX2hlbHBlci5jOjI3OjEwOiBmYXRhbCBl
cnJvcjogcWFwaS9xYXBpLWNvbW1hbmRzLXRhcmdldC5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5CiAgIDI3IHwgI2luY2x1ZGUgInFhcGkvcWFwaS1jb21tYW5kcy10YXJnZXQuaCIKICAgICAg
fCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJt
aW5hdGVkLgotLS0KICBDQyAgICAgIGFybS1zb2Z0bW11L3RhcmdldC9hcm0vbmVvbl9oZWxwZXIu
bwogIENDICAgICAgYXJtLXNvZnRtbXUvdGFyZ2V0L2FybS9tX2hlbHBlci5vCiAgQ0MgICAgICBh
cm0tc29mdG1tdS90YXJnZXQvYXJtL3BzY2kubwovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
NzlfbHA5a3Yvc3JjL3RhcmdldC9hcm0vbV9oZWxwZXIuYzoyNzoxMDogZmF0YWwgZXJyb3I6IHFh
cGkvcWFwaS1jb21tYW5kcy10YXJnZXQuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQogICAy
NyB8ICNpbmNsdWRlICJxYXBpL3FhcGktY29tbWFuZHMtdGFyZ2V0LmgiCiAgICAgIHwgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4K
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwNzA0MTYwODAyLjEyNDE5LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuczM5
MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


