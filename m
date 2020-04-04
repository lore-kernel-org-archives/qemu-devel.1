Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D6C2BA1A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495AF2072B
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495AF2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKePx-0007eo-E2
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jKePO-0007Ef-Ol
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jKePN-0001Pm-5E
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:44:06 -0400
Resent-Date: Sat, 04 Apr 2020 04:44:06 -0400
Resent-Message-Id: <E1jKePN-0001Pm-5E@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jKePM-0001Ou-U2
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585989831; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VZuZ7WI8QlGNfyfuILNOKmeNMzcVTUfGS33Rxm0tLllf1LdI+xxGLfErN5Ju9F/XtLjxyguc8lEjjdnuBSfJDdM8yh4zi1vXj/gx4bJ81WULEsfV99RcWPVEbt7xIiITECO8z/AAGNBpDzBnJghaxn4KoZG3Mk12iDx0A5UG8rI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585989831;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=J1Tz25PADWMfItqgvHpaogcXiPkCOpsMO2ZG36GO6tM=; 
 b=HVCMurHgfbS/83XdNNi8DS4mTMse+gu/jfXvLWU/vc0s8/l5kijKbvV2c8q8S7iKwP9IAVK1HvSTGf7u5GTIGwiRNSNrW7WGLzlJaoJNjUTojOZtIgjbca/oSDc935m1Fbp5esIwhHnvNYvNcmpnzbEEk6tGCsqqylNARSPDtUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585989825671408.52273328890954;
 Sat, 4 Apr 2020 01:43:45 -0700 (PDT)
In-Reply-To: <20200404082900.33711-1-arilou@gmail.com>
Subject: Re: [PATCH v2 0/7] hyperv: VMBus implementation
Message-ID: <158598982454.1341.10449643863637275398@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: arilou@gmail.com
Date: Sat, 4 Apr 2020 01:43:45 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
 pbonzini@redhat.com, vkuznets@redhat.com, arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwNDA4MjkwMC4zMzcx
MS0xLWFyaWxvdUBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4
Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvaTM4Ni8uLi94ZW5wdi94ZW5fbWFjaGluZV9wdi5vCiAg
Q0MgICAgICB4ODZfNjQtc29mdG1tdS9ody9pMzg2L2t2bS9jbG9jay5vCiAgQ0MgICAgICB4ODZf
NjQtc29mdG1tdS9ody9pMzg2L2t2bS9hcGljLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2h5cGVy
di92bWJ1cy5jOjE3NTg6NTc6IGVycm9yOiB1c2Ugb2YgbG9naWNhbCAnJiYnIHdpdGggY29uc3Rh
bnQgb3BlcmFuZCBbLVdlcnJvciwtV2NvbnN0YW50LWxvZ2ljYWwtb3BlcmFuZF0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbXNnLT52ZXJzaW9uX3JlcXVlc3RlZCAmJiAweGZmZmYs
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XiAgfn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9oeXBlcnYvdm1idXMuYzoxNzU4OjU3OiBu
b3RlOiB1c2UgJyYnIGZvciBhIGJpdHdpc2Ugb3BlcmF0aW9uCi0tLQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfl5+fn5+fn5+fgoxIGVycm9y
IGdlbmVyYXRlZC4KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L2kzODYva3ZtL2lvYXBpYy5v
Cm1ha2VbMV06ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvaHlwZXJ2
L3ZtYnVzLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IHg4Nl82NC1zb2Z0bW11L2FsbF0gRXJyb3Ig
MgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2Nr
ZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkp
Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vz
cy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAn
cnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0wOGE1MWY5YThmYTU0ZTRm
OTk3ZTgwZTkzOTg2YzhlOCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2Nv
bXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11
JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0
JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2Vy
LWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtaGw4ZTNfcHUvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0wNC0wNC4zOS4zMS4xNzAzNDov
dmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAn
dGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1m
aWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0wOGE1MWY5YThmYTU0ZTRmOTk3ZTgw
ZTkzOTg2YzhlOAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVh
dmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1obDhlM19wdS9zcmMn
Cm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAg
ICA0bTEyLjk2MHMKdXNlciAgICAwbTguMTMxcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDQwODI5MDAuMzM3MTEtMS1hcmlsb3VA
Z21haWwuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

