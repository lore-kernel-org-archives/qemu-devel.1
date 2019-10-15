Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE56AECE59D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 23:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915D62083B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 23:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915D62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKWFt-0000qU-Mf
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 19:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKWEy-0000M8-ED
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 19:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKWEw-0001Bv-RC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 19:28:32 -0400
Resent-Date: Tue, 15 Oct 2019 19:28:32 -0400
Resent-Message-Id: <E1iKWEw-0001Bv-RC@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKWEw-0001BK-Jf
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 19:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571182079; cv=none; d=zoho.com; s=zohoarc; 
 b=F9lLo4l6DYZjDaKnp65MpjHOJ448CRPtcHFPJZ/N4AnB+MuSDK9gRfOuoZLSBmVTAHiG3+KgISzfwuEmB1tpsX/O1AQtsIimrRyfJqcxoKvrYmK4/EDAQ1ww9iKr+UcLkg7PWeJJiJC9FbNf9ZO+uWR/hC0mqSVkMGNqLnbyEZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571182079;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NquMdh5cqrg+w/TM1tlktRlQRtwUKUgGaymy3L81CUg=; 
 b=oJKALsYjx2vub/ii+CYC37H8/IaMIhDUoOQ7IUZh/SIlrTbzldZkjIH18x1lcgD/9OqpbOFCakx/BVGDrQoqb1XRaQAAtYPJ/UCtKVOsT4hRK2tOby52b5Yw3177+QWfYuL8fL5KF6yY5f5zDppP+GLOpW38myZPAJb+H9gJaE8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571182076549352.5095287510885;
 Tue, 15 Oct 2019 16:27:56 -0700 (PDT)
In-Reply-To: <20191015140140.34748-1-zhengxiang9@huawei.com>
Subject: Re: [PATCH v19 0/5] Add ARMv8 RAS virtualization support in QEMU
Message-ID: <157118207403.5946.11773682662828159447@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengxiang9@huawei.com
Date: Tue, 15 Oct 2019 16:27:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, zhengxiang9@huawei.com, qemu-arm@nongnu.org,
 james.morse@arm.com, jonathan.cameron@huawei.com, imammedo@redhat.com,
 pbonzini@redhat.com, xuwei5@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNTE0MDE0MC4zNDc0
OC0xLXpoZW5neGlhbmc5QGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHFhcGkvcWFwaS1ldmVudHMtdHJhY2UubwogIENDICAgICAgcWFwaS9xYXBpLWV2ZW50cy10cmFu
c2FjdGlvbi5vCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMv
ZG9jcy9zcGVjcy9hY3BpX2hlc3RfZ2hlcy5yc3Q6OTM6RW51bWVyYXRlZCBsaXN0IGVuZHMgd2l0
aG91dCBhIGJsYW5rIGxpbmU7IHVuZXhwZWN0ZWQgdW5pbmRlbnQuCiAgQ0MgICAgICBxb2JqZWN0
L3FudW0ubwogIENDICAgICAgcW9iamVjdC9xbnVsbC5vCi0tLQogIENDICAgICAgcW9iamVjdC9q
c29uLXN0cmVhbWVyLm8KICBDQyAgICAgIHFvYmplY3QvYmxvY2stcWRpY3QubwogIENDICAgICAg
dHJhY2Uvc2ltcGxlLm8KbWFrZTogKioqIFtNYWtlZmlsZTo5OTc6IGRvY3Mvc3BlY3MvaW5kZXgu
aHRtbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD1mMDUyMGZmYTliZDM0MGU3YWRmOTc1YWYwMTAxNmI2ZicsICctdScs
ICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9Jywg
Jy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtXzkwbmFydWsvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0x
NS0xOS4yNi4wNy4yNDQyOTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1mMDUy
MGZmYTliZDM0MGU3YWRmOTc1YWYwMTAxNmI2ZgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC1fOTBuYXJ1ay9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9y
YV0gRXJyb3IgMgoKcmVhbCAgICAxbTQ3LjkzMXMKdXNlciAgICAwbTguMjM1cwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMTUxNDAx
NDAuMzQ3NDgtMS16aGVuZ3hpYW5nOUBodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZl
ZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


