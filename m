Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4506AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C97206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C97206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOXOw-0005gc-9i
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 22:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jOXOK-00052t-KX
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jOXOJ-0000n8-2i
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:03:04 -0400
Resent-Date: Tue, 14 Apr 2020 22:03:04 -0400
Resent-Message-Id: <E1jOXOJ-0000n8-2i@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jOXOI-0000lw-RQ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586916135; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aLgiqC0Gvdbbvv7/s82n5v3hUcQv+A6Ze2uoS2SdL9eP2NumLXldJKa13GYRLANbj/KMfuhdQaJUFWVSWcTRrSiE1dIgZEE1NAhHSuNZUk4FfiHss5OtZ0u+Z8cOUjc9NErLIe9M+3casybvMowRyWfuf3GqhaROxlvhg8FM4dM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586916135;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0DhjpRQEyKbBcmIQxKxPSSItKlThFeRJSMlxKyUrj/w=; 
 b=fv4Flu9ewFL4+GudkMgLLvLev9DoW8JaTpcv3aHYO4DPWUFw4A+mtgH6cJbWYZm6XnSgPw7CWGgImGfExOARD2l5mjj/kkgSgkpUUKeO/8CPyvfm86J7MTlTwJBu/N37EesHZV0gxFPq2iSDeS2jQDXtHolbMs6+aNzKSR5Ag3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586916132901474.78351592587444;
 Tue, 14 Apr 2020 19:02:12 -0700 (PDT)
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 00/26] VM introspection
Message-ID: <158691613041.27250.1487955234501467226@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alazar@bitdefender.com
Date: Tue, 14 Apr 2020 19:02:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: tamas@tklengyel.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 jan.kiszka@siemens.com, samuel.lauren@iki.fi, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alazar@bitdefender.com,
 quintela@redhat.com, patrick.colp@oracle.com, mathieu.tarral@protonmail.com,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, mdontu@bitdefender.com, dgilbert@redhat.com,
 marian.c.rotariu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNTAwNTkzOC4yMzg5
NS0xLWFsYXphckBiaXRkZWZlbmRlci5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgogIENDICAgICAgY2hhcmRldi9jaGFyLW11eC5vCiAgQ0MgICAgICBjaGFyZGV2L2NoYXItbnVs
bC5vCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8u
Li9xZW11LW9wdGlvbnMuaHg6NTA0MTpJbmxpbmUgbGl0ZXJhbCBzdGFydC1zdHJpbmcgd2l0aG91
dCBlbmQtc3RyaW5nLgptYWtlOiAqKiogW01ha2VmaWxlOjExMTU6IC5kb2NzX3N5c3RlbV9xZW11
LjFfZG9jc19zeXN0ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVtdS1jcHUt
bW9kZWxzLjcuc2VudGluZWwuXSBFcnJvciAyCm1ha2U6ICoqKiBEZWxldGluZyBmaWxlICcuZG9j
c19zeXN0ZW1fcWVtdS4xX2RvY3Nfc3lzdGVtX3FlbXUtYmxvY2stZHJpdmVycy43X2RvY3Nfc3lz
dGVtX3FlbXUtY3B1LW1vZGVscy43LnNlbnRpbmVsLicKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVu
ZmluaXNoZWQgam9icy4uLi4KCldhcm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10
ZXN0L3NyYy9kb2NzLy4uL3FlbXUtb3B0aW9ucy5oeDo1MDQxOklubGluZSBsaXRlcmFsIHN0YXJ0
LXN0cmluZyB3aXRob3V0IGVuZC1zdHJpbmcuCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEwNDogZG9j
cy9zeXN0ZW0vaW5kZXguaHRtbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwg
bGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxt
b2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD0xNDk2OWMxYjdhN2Y0Y2I1ODlkNTNmNWVlNGE3MDVmNCcsICctdScsICcxMDAz
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRT
PScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9X
X0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUv
cGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICct
dicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYTRpdTd2eTIvc3JjL2RvY2tlci1zcmMu
MjAyMC0wNC0xNC0yMS41OC40OC4yNjAxMDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRv
cmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD0xNDk2OWMxYjdhN2Y0Y2I1ODlkNTNmNWVlNGE3MDVmNAptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1hNGl1N3Z5Mi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRl
YnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTIyLjcxM3MKdXNlciAgICAwbTcuNzMzcwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA0MTUwMDU5MzguMjM4OTUtMS1hbGF6YXJAYml0ZGVmZW5kZXIuY29tL3Rlc3RpbmcuYXNhbi8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

