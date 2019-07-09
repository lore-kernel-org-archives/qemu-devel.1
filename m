Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A7C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5229C2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 04:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5229C2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkhlj-0008Fr-JR
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 00:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkhkn-0007oI-04
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkhkl-0005VY-KS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:29:20 -0400
Resent-Date: Tue, 09 Jul 2019 00:29:20 -0400
Resent-Message-Id: <E1hkhkl-0005VY-KS@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkhkl-0005V1-Cd
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 00:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562646501; cv=none; d=zoho.com; s=zohoarc; 
 b=Rt+vU3EYDCSxvRTk0PpsCV4dCO8dVTXGIqM/hASn0NHDKPxGTnbyvQbE1TDbax05uCOBOHqInLLbMR1APGZA7+aLyvWOUnAvSi+O2JkNj4NvinDjTXErLSNbSWTjzw6ZTeaXyIFnwJkwbGF/KZTZvu4KQruCO2PSRlEyKZSErbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562646501;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=tKCjy3OMpt2tdQIdlhtA6H8yaiE1QWuHi+G5Hjv5jTw=; 
 b=bWOtx2Ewhbd+2xw882xfzhU9MRXK4iLoYIP53g7yBe/P4Tao0mc5ZtbfdrlsK5UlXN4Qb7sy9ilyR2S85yjtNn+rS6A2+YWejWoQWvy2w+2unAxZaYuEe9fc0rLa6IIgc+FIaRKj1NdotD/QerzTuwZ5igk6i09P3woZZwIS9DM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562646499663443.8247510424786;
 Mon, 8 Jul 2019 21:28:19 -0700 (PDT)
Message-ID: <156264649710.29002.12824378116022801626@c4a48874b076>
In-Reply-To: <1562637554-22439-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwankhede@nvidia.com
Date: Mon, 8 Jul 2019 21:28:19 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
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
ZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMg
YmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBz
Y3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQg
cG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Ag
b2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52Cgpl
Y2hvCmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1F
ID09PSIKdW5hbWUgLWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlM
RD0kUFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQK
JFNSQy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6
IHdlIG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0
YWxsCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcvd2F0Y2hkb2cvdHJhY2Uu
bwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaHcvdmZpby90cmFjZS5jOjQ6Cmh3L3ZmaW8vdHJhY2Uu
aDogSW4gZnVuY3Rpb24g4oCYX25vY2hlY2tfX3RyYWNlX3ZmaW9fc2F2ZV9wZW5kaW5n4oCZOgpo
dy92ZmlvL3RyYWNlLmg6MzY1NToxODogZXJyb3I6IGZvcm1hdCDigJgleOKAmSBleHBlY3RzIGFy
Z3VtZW50IG9mIHR5cGUg4oCYdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgNyBoYXMgdHlw
ZSDigJh1aW50NjRfdOKAmSB7YWthIOKAmGxvbmcgdW5zaWduZWQgaW504oCZfSBbLVdlcnJvcj1m
b3JtYXQ9XQogMzY1NSB8ICAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX3NhdmVf
cGVuZGluZyAiICIgKCVzKSwgcHJlY29weSAweCUiUFJJeDY0IiBwb3N0Y29weSAweCV4IlBSSXg2
NCIgY29tcGF0aWJsZSAweCUiUFJJeDY0ICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KLi4uLi4uCi0tLQogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQKICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAlbHgKaHcvdmZpby90cmFjZS5oOiBJbiBmdW5jdGlv
biDigJhfbm9jaGVja19fdHJhY2VfdmZpb19sb2FkX3N0YXRlX2RldmljZV9kYXRh4oCZOgpody92
ZmlvL3RyYWNlLmg6Mzc3MDo2MTogZXJyb3I6IGV4cGVjdGVkIOKAmCnigJkgYmVmb3JlIOKAmFBS
SXg24oCZCiAzNzcwIHwgICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9fbG9hZF9z
dGF0ZV9kZXZpY2VfZGF0YSAiICIgKCVzKSwgT2Zmc2V0IDB4JSJQUkl4NjQiIHNpemUgMHglIlBS
SXg2ICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH5+fn5+CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKQpody92ZmlvL3RyYWNlLmg6Mzc3MDoyMDogZXJyb3I6IGZvcm1h
dCDigJglZOKAmSBleHBlY3RzIGEgbWF0Y2hpbmcg4oCYaW504oCZIGFyZ3VtZW50IFstV2Vycm9y
PWZvcm1hdD1dCiAzNzcwIHwgICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9fbG9h
ZF9zdGF0ZV9kZXZpY2VfZGF0YSAiICIgKCVzKSwgT2Zmc2V0IDB4JSJQUkl4NjQiIHNpemUgMHgl
IlBSSXg2ICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgfl4KICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgfAogICAgICB8ICAgICAgICAgICAgICAgICAgICBpbnQKaHcvdmZpby90cmFj
ZS5oOjM3NzA6MjQ6IGVycm9yOiBmb3JtYXQg4oCYJXp14oCZIGV4cGVjdHMgYSBtYXRjaGluZyDi
gJhzaXplX3TigJkgYXJndW1lbnQgWy1XZXJyb3I9Zm9ybWF0PV0KIDM3NzAgfCAgICAgICAgIHFl
bXVfbG9nKCIlZEAlenUuJTA2enU6dmZpb19sb2FkX3N0YXRlX2RldmljZV9kYXRhICIgIiAoJXMp
LCBPZmZzZXQgMHglIlBSSXg2NCIgc2l6ZSAweCUiUFJJeDYgIlxuIiwKICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICB+fl4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIHwKICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgIGxvbmcgdW5zaWduZWQgaW50Cmh3L3ZmaW8vdHJhY2Uu
aDozNzcwOjMwOiBlcnJvcjogZm9ybWF0IOKAmCV6deKAmSBleHBlY3RzIGEgbWF0Y2hpbmcg4oCY
c2l6ZV904oCZIGFyZ3VtZW50IFstV2Vycm9yPWZvcm1hdD1dCiAzNzcwIHwgICAgICAgICBxZW11
X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9fbG9hZF9zdGF0ZV9kZXZpY2VfZGF0YSAiICIgKCVzKSwg
T2Zmc2V0IDB4JSJQUkl4NjQiIHNpemUgMHglIlBSSXg2ICJcbiIsCiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgIH5+fn5eCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb25nIHVuc2lnbmVkIGlu
dApody92ZmlvL3RyYWNlLmg6Mzc3MDoxODogZXJyb3I6IGZvcm1hdCDigJglc+KAmSBleHBlY3Rz
IGEgbWF0Y2hpbmcg4oCYY2hhciAq4oCZIGFyZ3VtZW50IFstV2Vycm9yPWZvcm1hdD1dCiAzNzcw
IHwgICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9fbG9hZF9zdGF0ZV9kZXZpY2Vf
ZGF0YSAiICIgKCVzKSwgT2Zmc2V0IDB4JSJQUkl4NjQiIHNpemUgMHglIlBSSXg2ICJcbiIsCiAg
ICAgIHwgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+Cmh3L3ZmaW8vdHJhY2UuaDozNzcwOjY2OiBub3RlOiBmb3JtYXQgc3RyaW5nIGlz
IGRlZmluZWQgaGVyZQotLS0KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfl4KICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNoYXIgKgpody92ZmlvL3RyYWNlLmg6Mzc3MDoxODogZXJyb3I6IGZvcm1h
dCDigJglbHjigJkgZXhwZWN0cyBhIG1hdGNoaW5nIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIGFy
Z3VtZW50IFstV2Vycm9yPWZvcm1hdD1dCiAzNzcwIHwgICAgICAgICBxZW11X2xvZygiJWRAJXp1
LiUwNnp1OnZmaW9fbG9hZF9zdGF0ZV9kZXZpY2VfZGF0YSAiICIgKCVzKSwgT2Zmc2V0IDB4JSJQ
Ukl4NjQiIHNpemUgMHglIlBSSXg2ICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICBefn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYjkzejhhX3ovc3JjL2luY2x1ZGUvcWVt
dS9vc2RlcC5oOjEwMywKLS0tCi91c3IvaW5jbHVkZS9pbnR0eXBlcy5oOjEyMTozNDogbm90ZTog
Zm9ybWF0IHN0cmluZyBpcyBkZWZpbmVkIGhlcmUKICAxMjEgfCAjIGRlZmluZSBQUkl4NjQgIF9f
UFJJNjRfUFJFRklYICJ4IgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaHcvdmZpby90cmFjZS5jOjQ6
Cmh3L3ZmaW8vdHJhY2UuaDozNzcwOjE4OiBlcnJvcjogc3B1cmlvdXMgdHJhaWxpbmcg4oCYJeKA
mSBpbiBmb3JtYXQgWy1XZXJyb3I9Zm9ybWF0PV0KIDM3NzAgfCAgICAgICAgIHFlbXVfbG9nKCIl
ZEAlenUuJTA2enU6dmZpb19sb2FkX3N0YXRlX2RldmljZV9kYXRhICIgIiAoJXMpLCBPZmZzZXQg
MHglIlBSSXg2NCIgc2l6ZSAweCUiUFJJeDYgIlxuIiwKICAgICAgfCAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KaHcvdmZpby90cmFj
ZS5oOjM3NzA6OTY6IG5vdGU6IGZvcm1hdCBzdHJpbmcgaXMgZGVmaW5lZCBoZXJlCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTYyNjM3NTU0
LTIyNDM5LTEtZ2l0LXNlbmQtZW1haWwta3dhbmtoZWRlQG52aWRpYS5jb20vdGVzdGluZy5zMzkw
eC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


