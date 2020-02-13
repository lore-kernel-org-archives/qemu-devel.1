Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CBC352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE8520724
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE8520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24tk-0007g4-0l
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j24t2-0006gT-3o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j24t0-00087d-Cg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:09:55 -0500
Resent-Date: Wed, 12 Feb 2020 22:09:55 -0500
Resent-Message-Id: <E1j24t0-00087d-Cg@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j24t0-00082h-7T; Wed, 12 Feb 2020 22:09:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581563379; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BxXlXYGu3Pbh//xSFWHceCxpVy1z6pPwSHJjDu5+DuJ+iZScCb9Crt3b0x0vAt1m7JpHzFwYkZTTJZCKm+Cnk3128jJeGeSJYhVI6M3hcQUn4ZMFJus9bHmJF3ffQj4PeQjciXiGEbTbosAs24AqC4iqVchRzvf2QZ4V0dI4dtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581563379;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2qrPk11StMim88jkk3UxfLuh5HqkdvdT46pcDWIH1BY=; 
 b=GBP72be1d6YTx1LS9lx/hr7ewrEJun3m/s4ozztLohofWUqyc/cb2rVtkHQIwbz7TYW/2rEXdi5oeS/h4s3P7u2QUrn9F6NCmK+N5ayNMAfYrxHlBXD2Uyyq7BT9afaholGoxBwaE5wO5v/P8lZwMrqZJfHO5zxH/AXS/cqV7wo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581563376483364.5326312713074;
 Wed, 12 Feb 2020 19:09:36 -0800 (PST)
In-Reply-To: <20200213023532.902-1-fangying1@huawei.com>
Subject: Re: [PATCH 0/4] arm64: Add the cpufreq device to show cpufreq info to
 guest
Message-ID: <158156337473.23372.16619241886120636354@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fangying1@huawei.com
Date: Wed, 12 Feb 2020 19:09:36 -0800 (PST)
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, guoheyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMzAyMzUzMi45MDIt
MS1mYW5neWluZzFAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcv
YWNwaS9jcHVmcmVxLm8KICBDQyAgICAgIGh3L2FjcGkvaXBtaS5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9hY3BpL2NwdWZyZXEuYzogSW4gZnVuY3Rpb24gJ2NwdWZyZXFfcmVhZCc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ody9hY3BpL2NwdWZyZXEuYzo3MTo0NzogZXJyb3I6IGZvcm1hdCAnJWx4JyBl
eHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgdW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50
IDIgaGFzIHR5cGUgJ2h3YWRkcicge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFstV2Vy
cm9yPWZvcm1hdD1dCiAgICAgICAgIHdhcm5fcmVwb3J0KCJjcHVmcmVxX3JlYWQ6IG9mZnNldCAw
eCVseCBvdXQgb2YgcmFuZ2UiLCBvZmZzZXQpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB+fl4gICAgICAgICAgICAgICAgfn5+fn5+CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICVsbHgKL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2FjcGkvY3B1ZnJlcS5jOjEyNzo1MjogZXJyb3I6IGZvcm1hdCAnJWx4JyBleHBlY3RzIGFyZ3Vt
ZW50IG9mIHR5cGUgJ2xvbmcgdW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50IDIgaGFzIHR5cGUg
J2h3YWRkcicge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1d
CiAgICAgICAgIGVycm9yX3ByaW50ZigiY3B1ZnJlcV9yZWFkOiBCYWQgb2Zmc2V0IDB4JWx4XG4i
LCBvZmZzZXQpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH5+XiAgICAgfn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJWxseAovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jcHVmcmVxLmM6IElu
IGZ1bmN0aW9uICdjcHVmcmVxX3dyaXRlJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY3B1
ZnJlcS5jOjE0Mzo0OTogZXJyb3I6IGZvcm1hdCAnJWx4JyBleHBlY3RzIGFyZ3VtZW50IG9mIHR5
cGUgJ2xvbmcgdW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50IDIgaGFzIHR5cGUgJ2h3YWRkcicg
e2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgICAg
IGVycm9yX3ByaW50ZigiY3B1ZnJlcV93cml0ZTogb2Zmc2V0IDB4JWx4IG91dCBvZiByYW5nZSIs
IG9mZnNldCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fn5eICAgICAgICAgICAgICAgIH5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICVsbHgKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY3B1ZnJlcS5j
OjE1Mzo1MzogZXJyb3I6IGZvcm1hdCAnJWx4JyBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xv
bmcgdW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50IDIgaGFzIHR5cGUgJ2h3YWRkcicge2FrYSAn
bG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgICAgIGVycm9y
X3ByaW50ZigiY3B1ZnJlcV93cml0ZTogQmFkIG9mZnNldCAweCVseFxuIiwgb2Zmc2V0KTsKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5eICAgICB+
fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JWxseAovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jcHVmcmVxLmM6IEluIGZ1bmN0aW9uICdD
UFBDX1JlYWQnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9jcHVmcmVxLmM6MTc2OjQ0OiBl
cnJvcjogcGFzc2luZyBhcmd1bWVudCA0IG9mICdxZW11X3N0cnRvdWwnIGZyb20gaW5jb21wYXRp
YmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICAg
ICByZXQgPSBxZW11X3N0cnRvdWwoYnVmZmVyLCAmZW5kcHRyLCAwLCAmaHopOwogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fgpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvY3B1ZnJlcS5jOjMwOgotLS0KICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgbG9uZyAqcmVzdWx0KTsKICAgICAgICAgICAgICAgICAgfn5+fn5+
fn5+fn5+fn5+Xn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3Jz
Cm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvYWNwaS9jcHVm
cmVxLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9OTY5OGNiNjg4MGM0NGNiMDk4NGE4NDJiMmJlMGZjNzAnLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV9zaWFfYjNkL3NyYy9kb2NrZXItc3JjLjIwMjAtMDIt
MTItMjIuMDcuMjguMTY4NTM6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OTY5
OGNiNjg4MGM0NGNiMDk4NGE4NDJiMmJlMGZjNzAKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtX3NpYV9iM2Qvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRv
cmFdIEVycm9yIDIKCnJlYWwgICAgMm02Ljk4MHMKdXNlciAgICAwbTguMjU5cwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMTMwMjM1
MzIuOTAyLTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3Jh
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

