Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05130C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EFA2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 20:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EFA2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ0bK-0001cQ-0Z
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 16:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJ0a5-0000Eg-29
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJ0a3-00029i-4F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 16:00:20 -0400
Resent-Date: Mon, 30 Mar 2020 16:00:20 -0400
Resent-Message-Id: <E1jJ0a3-00029i-4F@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJ0a2-00024o-Uk; Mon, 30 Mar 2020 16:00:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585598392; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BhyoMIqAmnKoRV+GFqSrJGJ/Ln8KOPEk4Xt2BS9XQUcgpvaX3rXVZ870soUp8pFGopySwCnH8zftNGgNr22ysmWf4OSrf60gIHO8K+VRLw2aZfarbq+iDLfqrShyMUEDDzrUIL/Lwkx3RVmowF5XCTcyQBTPrU1Bn2bAQ58UnA4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585598392;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=csLclqeDsiSiRcvsOCidlujRoAsKZYbsu2f153rCCR0=; 
 b=GPqLOjxoRIFRsh8Q27NGMLcuv14huNbQZXb/gIQDzfxI+Q8/4mtAJSAQg80OpC9G7VNifWne95Rzs2rTVSpyuRu9ECU4QMMgpWHkyBx8BeZ1SJ29gKYc0DPnXRvl+tbNELJ39HsyJVpocJr/kHhNOmK2ZIlFvFdyYENtk3xsiYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585598389649695.1731931413614;
 Mon, 30 Mar 2020 12:59:49 -0700 (PDT)
In-Reply-To: <20200330164909.28324-1-shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH for-5.0 0/3] acpi: Fixes for inconsistency in ACPI MR size
 during migration
Message-ID: <158559838781.14168.4660132133802021028@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shameerali.kolothum.thodi@huawei.com
Date: Mon, 30 Mar 2020 12:59:49 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 shannon.zhaosl@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMzMDE2NDkwOS4yODMy
NC0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNl
cmllcyBmYWlsZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZp
bmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhh
dmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxs
eS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4
Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9j
a2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgogIENDICAgICAgaHcvc21iaW9zL3NtYmlvcy5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAv
dG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L29zZGVwLmg6NTEsCiAgICAgICAgICAgICAg
ICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvbnZyYW0vZndfY2ZnLmM6MjU6Ci90bXAvcWVt
dS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvY29tcGlsZXIuaDo4MTozNTogZXJyb3I6IGludmFsaWQg
b3BlcmFuZHMgdG8gYmluYXJ5IC0gKGhhdmUgJ3VpbnQ2NF90IConIHtha2EgJ2xvbmcgbG9uZyB1
bnNpZ25lZCBpbnQgKid9IGFuZCAnc2l6ZV90IConIHtha2EgJ3Vuc2lnbmVkIGludCAqJ30pCiAj
ZGVmaW5lIHR5cGVfY2hlY2sodDEsdDIpICgodDEqKTAgLSAodDIqKTApCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9taWdyYXRp
b24vdm1zdGF0ZS5oOjI1NDo2OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ3R5cGVfY2hl
Y2snCi0tLQovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbnZyYW0vZndfY2ZnLmM6Njc0Ojk6IG5vdGU6
IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnVk1TVEFURV9VSU5UNjQnCiAgICAgICAgIFZNU1RBVEVf
VUlOVDY0KHRhYmxlX21yX3NpemUsIEZXQ2ZnU3RhdGUpLAogICAgICAgICBefn5+fn5+fn5+fn5+
fgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2NvbXBpbGVyLmg6ODE6MzU6IGVycm9y
OiBpbnZhbGlkIG9wZXJhbmRzIHRvIGJpbmFyeSAtIChoYXZlICd1aW50NjRfdCAqJyB7YWthICds
b25nIGxvbmcgdW5zaWduZWQgaW50IConfSBhbmQgJ3NpemVfdCAqJyB7YWthICd1bnNpZ25lZCBp
bnQgKid9KQogI2RlZmluZSB0eXBlX2NoZWNrKHQxLHQyKSAoKHQxKikwIC0gKHQyKikwKQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1
ZGUvbWlncmF0aW9uL3Ztc3RhdGUuaDoyNTQ6Njogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
ICd0eXBlX2NoZWNrJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L252cmFtL2Z3X2NmZy5jOjY3
NTo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ1ZNU1RBVEVfVUlOVDY0JwogICAgICAg
ICBWTVNUQVRFX1VJTlQ2NChsaW5rZXJfbXJfc2l6ZSwgRldDZmdTdGF0ZSksCiAgICAgICAgIF5+
fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvY29tcGlsZXIuaDo4
MTozNTogZXJyb3I6IGludmFsaWQgb3BlcmFuZHMgdG8gYmluYXJ5IC0gKGhhdmUgJ3VpbnQ2NF90
IConIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQgKid9IGFuZCAnc2l6ZV90IConIHtha2Eg
J3Vuc2lnbmVkIGludCAqJ30pCiAjZGVmaW5lIHR5cGVfY2hlY2sodDEsdDIpICgodDEqKTAgLSAo
dDIqKTApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVz
dC9zcmMvaW5jbHVkZS9taWdyYXRpb24vdm1zdGF0ZS5oOjI1NDo2OiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8gJ3R5cGVfY2hlY2snCi0tLQovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbnZyYW0v
ZndfY2ZnLmM6Njc2Ojk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnVk1TVEFURV9VSU5U
NjQnCiAgICAgICAgIFZNU1RBVEVfVUlOVDY0KHJzZHBfbXJfc2l6ZSwgRldDZmdTdGF0ZSksCiAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+Cm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVz
Lm1hazo2OTogaHcvbnZyYW0vZndfY2ZnLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgog
IEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgot
LS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3Mu
Q2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1
bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZTk3NWRhZmNlMThjNGQ4ZDhi
ZGMxYWVjY2ZlMmMzZmUnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21w
PXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFf
Q09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9
JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAv
Y2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWQ4czZjeXJsL3Ny
Yy9kb2NrZXItc3JjLjIwMjAtMDMtMzAtMTUuNTQuMjYuMzA0OTovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFl
bXUuaW5zdGFuY2UudXVpZD1lOTc1ZGFmY2UxOGM0ZDhkOGJkYzFhZWNjZmUyYzNmZQptYWtlWzFd
OiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1kOHM2Y3lybC9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA1bTIyLjIwMnMKdXNlciAg
ICAwbTguNTk5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDAzMzAxNjQ5MDkuMjgzMjQtMS1zaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
QGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t

