Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B77C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 19:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844CC206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 19:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844CC206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkY8J-0006Fv-L7
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 15:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkY7X-0005la-VF
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 15:16:45 -0400
Resent-Date: Sun, 14 Jun 2020 15:16:43 -0400
Resent-Message-Id: <E1jkY7X-0005la-VF@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkY7S-0007XS-CE
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 15:16:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592162190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WtbdiblD82CKcRJva24nfVZyL34tVmJQqRmU53Ra6WCKvkQYzNZocx63TaCp4sOGyXWWAwKR4C9SspXIZ/g9QdVLTJ6AN9CbTHuKltmC7rWVE9dmRk/5+PsvKoXpTvKERAW6V5Z+0V17NuAbG70UmR2nF3Z0zJO/Kt4xaJuOSgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592162190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MBGBWz/fMS05hdJTTz5bv9JN4QY+zTK1b7SUgNf+c6Y=; 
 b=VFyvmtWcTfG3JrgnC8asKk0cIUI97Re7KG+hfr1lqfq/pRf1MP0HGYw2IdMV84+ErgIs4HuE3htLiQdXGQmt95R0SPVv2oUaLik5Viv5RzrsRysO4wnp5ce+wuyevhYv32I+Hce0bri6lYx9s6i33qv+n4iaT19VXJNSP7B8rHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592162188954674.058628237977;
 Sun, 14 Jun 2020 12:16:28 -0700 (PDT)
Message-ID: <159216218770.30485.1172665077342708998@45ef0f9c86ae>
In-Reply-To: <20200614183907.514282-1-coiby.xu@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: coiby.xu@gmail.com
Date: Sun, 14 Jun 2020 12:16:28 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 15:12:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, coiby.xu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNDE4MzkwNy41MTQy
ODItMS1jb2lieS54dUBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNU
PXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09Cgog
IENDICAgICAgc3R1YnMvdm0tc3RvcC5vCiAgQ0MgICAgICB1aS9pbnB1dC1rZXltYXAubwogIEND
ICAgICAgcWVtdS1rZXltYXAubwovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC92aG9zdC11c2VyLXNl
cnZlci5jOjE0MjozMDogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ1ZIT1NU
X01FTU9SWV9NQVhfTlJFR0lPTlMnCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1Rf
TUVNT1JZX01BWF9OUkVHSU9OUywgbmZkcyArIG5mZHNfdCk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgoxIGVycm9yIGdlbmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9z
cmMvcnVsZXMubWFrOjY5OiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLm9dIEVycm9yIDEKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGNvbnRyaWIvZWxm
MmRtcC9tYWluLm8KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OTlhNzc4OGVkN2Y1NGRmMWIwZWJiN2Y5MWJl
YjUyMmUnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD14ODZfNjQtc29mdG1tdScsICctZScsICdF
WFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdE
RUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2Nh
Y2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFy
L3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOWdvYW9s
N3ovc3JjL2RvY2tlci1zcmMuMjAyMC0wNi0xNC0xNS4xMi41OS4xMDQzOTovdmFyL3RtcC9xZW11
Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1Zydd
JyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD05OWE3Nzg4ZWQ3ZjU0ZGYxYjBlYmI3ZjkxYmViNTIyZQpt
YWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rv
cnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC05Z29hb2w3ei9zcmMnCm1ha2U6ICoqKiBb
ZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTI5LjMzNXMK
dXNlciAgICAwbTguMzEzcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA2MTQxODM5MDcuNTE0MjgyLTEtY29pYnkueHVAZ21haWwuY29t
L3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

