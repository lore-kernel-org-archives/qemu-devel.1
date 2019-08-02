Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED06C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7E82067D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E82067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUWI-0007bn-W9
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1htUVt-00076d-ET
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1htUVs-0007Dz-1V
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:10:17 -0400
Resent-Date: Fri, 02 Aug 2019 06:10:17 -0400
Resent-Message-Id: <E1htUVs-0007Dz-1V@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1htUVr-0007DW-Pe; Fri, 02 Aug 2019 06:10:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564740601; cv=none; d=zoho.com; s=zohoarc; 
 b=Zo3j/zpGDWUHpDuaNE0eir5Xx2IdjtjAAP5HoLzjrFWUM5z/E49Tf0Ao1UaI7yArAERUgjLCvLpkbkQZVNlOa861okSkOSMghEPebbZfjBFd2TPkf5/QJBGrTJJ4HBz4iE5HCrWU67SZhSaVij108/fZi009SxZhyXM16HckQm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564740601;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=JQk/JvU+YfwW4TTCywJjtbbFgxDcmPsyRALQ402wC4g=; 
 b=nLWhQ5YQ/kNFa7RQkDwEQLt6hF3YblsT/ZeOGo8jFkIcQpYaDPV+yO87vMZgOtyi5BfPcXxufPhuf7YtpS+Kpw4asxcKONrVhggPLC5bMwVuPc44gTboGQ3INidgypTZcMSqE+pKtbN2KpMehp0bqBbjINN/FWBuanwaPHRGiY4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156474059989075.05864610165918;
 Fri, 2 Aug 2019 03:09:59 -0700 (PDT)
Message-ID: <156474059846.30590.17314698059589823399@c4a48874b076>
In-Reply-To: <20190802093854.5343-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Fri, 2 Aug 2019 03:09:59 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/4] s390: stop abusing
 memory_region_allocate_system_memory()
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwMjA5Mzg1NC41MzQz
LTEtaW1hbW1lZG9AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQg
dGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxsIGJl
IGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0byBh
IGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIKIyBi
cmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAiPT09
IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1bmFtZSAt
YQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0QvYnVpbGQK
bWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2NvbmZpZ3Vy
ZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVlZCByZWxp
YWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBzMzkweC1zb2Z0bW11L3RhcmdldC9zMzkweC9rdm0u
bwogIENDICAgICAgc3BhcmM2NC1zb2Z0bW11L3FhcGkvcWFwaS1pbnRyb3NwZWN0Lm8KL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJpbWc1aWEwL3NyYy90YXJnZXQvczM5MHgva3ZtLmM6IElu
IGZ1bmN0aW9uIOKAmGt2bV9hcmNoX2luaXTigJk6Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1yaW1nNWlhMC9zcmMvdGFyZ2V0L3MzOTB4L2t2bS5jOjM1MDo1OiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYa3ZtX3NldF9tYXhfbWVtc2xvdF9zaXpl4oCZOyBk
aWQgeW91IG1lYW4g4oCYa3ZtX2dldF9tYXhfbWVtc2xvdHPigJk/IFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDM1MCB8ICAgICBrdm1fc2V0X21heF9tZW1zbG90X3Np
emUoS1ZNX1NMT1RfTUFYX0JZVEVTKTsKICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+CiAgICAgIHwgICAgIGt2bV9nZXRfbWF4X21lbXNsb3RzCi92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1yaW1nNWlhMC9zcmMvdGFyZ2V0L3MzOTB4L2t2bS5jOjM1MDo1OiBlcnJvcjogbmVz
dGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiDigJhrdm1fc2V0X21heF9tZW1zbG90X3NpemXigJkg
Wy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJpbWc1
aWEwL3NyYy9ydWxlcy5tYWs6Njk6IHRhcmdldC9zMzkweC9rdm0ub10gRXJyb3IgMQptYWtlOiAq
KiogW01ha2VmaWxlOjQ3MjogczM5MHgtc29mdG1tdS9hbGxdIEVycm9yIDIKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwODAyMDkzODU0
LjUzNDMtMS1pbWFtbWVkb0ByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


