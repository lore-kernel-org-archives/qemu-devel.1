Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298A620774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 12:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298A620774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6YPR-0003pl-BM
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 08:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6YOb-0003A6-0y; Fri, 14 Aug 2020 08:01:17 -0400
Resent-Date: Fri, 14 Aug 2020 08:01:17 -0400
Resent-Message-Id: <E1k6YOb-0003A6-0y@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6YOS-0007aD-Vc; Fri, 14 Aug 2020 08:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597406449; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bCN9eKjorkf4QH4414/VYrvHIblsvt+5gg+1fTqNX1g1uJqsd1cOSZxb7WxsofMF2XZRnGp0W9SX1uI79TZa7SXed7cWc/l7A6RFHLaWSLgqlOicT04qf1CJxV/j8wWeUgXZN1x1dFcyf8aJz3fbUPKhi/Sefg129Cirl4ah47I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597406449;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=jZx0l/G7PWzdZUpffWO6vr2Mzt46xMdgX22MzPDzRmo=; 
 b=OKESl6xtpJ71tNS6UYUCZgtHjj3IUzQmmv1ugjtkfH+y818yVIXyyRBOqGrgUShQF7Vm1ZYTTZ5MbcGTVETlthNvCo5Qlb8BMfYaBhByfunHh/UTgWSFC8aEJU6bTvtbwo13SKH8ICQvs3K+SxPouad55FPRWO6k8ItJ4sR74eg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597406445184806.6854110514956;
 Fri, 14 Aug 2020 05:00:45 -0700 (PDT)
Subject: Re: [PATCH] hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
Message-ID: <159740644375.3532.5857124494185505383@66eaa9a8a123>
In-Reply-To: <20200814110057.307-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Fri, 14 Aug 2020 05:00:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 08:01:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Andrew.Baumann@microsoft.com, f4bug@amsat.org, b.galvani@gmail.com,
 nieklinnenbank@gmail.com, qemu-arm@nongnu.org, michael@walle.cc,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNDExMDA1Ny4zMDct
MS1mNGJ1Z0BhbXNhdC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXIt
bWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRz
IGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlv
dSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2Ut
ZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGFhcmNoNjQt
c29mdG1tdS90cmFjZS9nZW5lcmF0ZWQtaGVscGVycy5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRt
bXUvdGFyZ2V0L2FybS90cmFuc2xhdGUtc3ZlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FybS9h
bGx3aW5uZXItYTEwLmM6IEluIGZ1bmN0aW9uICdhd19hMTBfcmVhbGl6ZSc6Ci90bXAvcWVtdS10
ZXN0L3NyYy9ody9hcm0vYWxsd2lubmVyLWExMC5jOjE2OTo0ODogZXJyb3I6IHBhc3NpbmcgYXJn
dW1lbnQgMiBvZiAnb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rJyBmcm9tIGluY29tcGF0aWJsZSBw
b2ludGVyIHR5cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgMTY5IHwg
ICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoJnMtPm1tYzApLCAiZG1hLW1lbW9y
eSIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwKLS0tCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FvbS9vYmplY3Qu
aDoxMjQzOjUyOiBub3RlOiBleHBlY3RlZCAnT2JqZWN0IConIHtha2EgJ3N0cnVjdCBPYmplY3Qg
Kid9IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdjb25zdCBjaGFyIConCiAxMjQzIHwgdm9pZCBv
YmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT2JqZWN0ICpvYmosIE9iamVjdCAqdmFsdWUsCiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+Xn5+
fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdC5oOjUwOTo2OiBlcnJvcjog
cGFzc2luZyBhcmd1bWVudCAzIG9mICdvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsnIGZyb20gaW5j
b21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBl
c10KICA1MDkgfCAgICAgKChPYmplY3QgKikob2JqKSkKICAgICAgfCAgICAgfl5+fn5+fn5+fn5+
fn5+fn4KICAgICAgfCAgICAgIHwKLS0tCiAgMTcwIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBPQkpFQ1QoZ2V0X3N5c3RlbV9tZW1vcnkoKSksICZlcnJvcl9mYXRhbCk7CiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2lu
Y2x1ZGUvcW9tL29iamVjdC5oOjEyNDQ6NDM6IG5vdGU6IGV4cGVjdGVkICdjb25zdCBjaGFyICon
IGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdPYmplY3QgKicge2FrYSAnc3RydWN0IE9iamVjdCAq
J30KIDEyNDQgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1l
LCBFcnJvciAqKmVycnApOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+
fn5+fn5+fn5+fl5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMK
bWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9hcm0vYWxs
d2lubmVyLWExMC5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vYWxsd2lubmVyLWgzLmM6IEluIGZ1
bmN0aW9uICdhbGx3aW5uZXJfaDNfcmVhbGl6ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0v
YWxsd2lubmVyLWgzLmM6MzUyOjQ4OiBlcnJvcjogcGFzc2luZyBhcmd1bWVudCAyIG9mICdvYmpl
Y3RfcHJvcGVydHlfc2V0X2xpbmsnIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdl
cnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICAzNTIgfCAgICAgb2JqZWN0X3Byb3Bl
cnR5X3NldF9saW5rKE9CSkVDVCgmcy0+bW1jMCksICJkbWEtbWVtb3J5IiwKICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fgog
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfAot
LS0KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdC5oOjEyNDM6NTI6IG5vdGU6
IGV4cGVjdGVkICdPYmplY3QgKicge2FrYSAnc3RydWN0IE9iamVjdCAqJ30gYnV0IGFyZ3VtZW50
IGlzIG9mIHR5cGUgJ2NvbnN0IGNoYXIgKicKIDEyNDMgfCB2b2lkIG9iamVjdF9wcm9wZXJ0eV9z
ZXRfbGluayhPYmplY3QgKm9iaiwgT2JqZWN0ICp2YWx1ZSwKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5efn5+fgovdG1wL3FlbXUtdGVz
dC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6NTA5OjY6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50
IDMgb2YgJ29iamVjdF9wcm9wZXJ0eV9zZXRfbGluaycgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRl
ciB0eXBlIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogIDUwOSB8ICAgICAo
KE9iamVjdCAqKShvYmopKQogICAgICB8ICAgICB+Xn5+fn5+fn5+fn5+fn5+fgogICAgICB8ICAg
ICAgfAotLS0KICAzNTMgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChnZXRf
c3lzdGVtX21lbW9yeSgpKSwgJmVycm9yX2ZhdGFsKTsKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0
Lmg6MTI0NDo0Mzogbm90ZTogZXhwZWN0ZWQgJ2NvbnN0IGNoYXIgKicgYnV0IGFyZ3VtZW50IGlz
IG9mIHR5cGUgJ09iamVjdCAqJyB7YWthICdzdHJ1Y3QgT2JqZWN0IConfQogMTI0NCB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsIEVycm9yICoqZXJycCk7
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+Xn5+fgpj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogWy90
bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L2FybS9hbGx3aW5uZXItaDMub10gRXJy
b3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjUyNzogYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3Ig
MgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIEdFTiAgICAgeDg2
XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0LmV4ZQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD05MGNj
NjFmZGY4YTU0ZGZiODNlMmFlZTc4OGI4MWZlYycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zh
ci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1j
Y2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLW85YjFpYmRsL3NyYy9kb2NrZXItc3JjLjIwMjAtMDgtMTQtMDcuNTcuMjcuMzIyMDA6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rl
c3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmls
dGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OTBjYzYxZmRmOGE1NGRmYjgzZTJhZWU3
ODhiODFmZWMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbzliMWliZGwvc3JjJwpt
YWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAg
M20xNy44MzNzCnVzZXIgICAgMG04LjQ2NXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODE0MTEwMDU3LjMwNy0xLWY0YnVnQGFtc2F0
Lm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

