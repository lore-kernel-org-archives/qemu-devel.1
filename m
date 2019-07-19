Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191ABC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 23:26:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E302821849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 23:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E302821849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hocGc-0007Wh-1e
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 19:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hocGQ-000777-M4
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 19:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hocGP-0004AE-Hh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 19:26:10 -0400
Resent-Date: Fri, 19 Jul 2019 19:26:10 -0400
Resent-Message-Id: <E1hocGP-0004AE-Hh@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hocGP-00049F-AJ; Fri, 19 Jul 2019 19:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563578749; cv=none; d=zoho.com; s=zohoarc; 
 b=mkgOunwdKXRIu5AXcuepOKK9qO3nTpHfm8CiIjGDVhSaI2dCUz4mZHQaAgb0/8EMPspTPtao0lJmRJMaOUkdaNVFmP7TYOLwksU/vG8wzl1U4dlXcuKW29auqJpa1y+eatGerP/3I9NSSO93iHkds3ps7ju1IDRlx5E4SDg05C4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563578749;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=uQCHDO/mOv6wS4VuXcgNk+U5cSMAWKUu1XKCKoT5S9k=; 
 b=hCBeKWUYGhFFLQurSLGAnoVZ9+aWmHVOIkKdVSh2DXSmpedSOm5fUEHs6+ZhWN28z3d7w1n5TtDlujEkfXlbApLrhPcWr8HJWwBleKYowYjNxar3IOmuoVQLVOnrbuLF+H6meb7l7McVao5ptEo1qDE4LurhlSUMe6OO3iWBoRM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156357874731482.6449062434624;
 Fri, 19 Jul 2019 16:25:47 -0700 (PDT)
Message-ID: <156357874526.15703.6508714025645114569@c4a48874b076>
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mehta.aaru20@gmail.com
Date: Fri, 19 Jul 2019 16:25:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 00/14] Add support for io_uring
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
Cc: fam@euphon.net, kwolf@redhat.com, stefan@redhat.com, qemu-block@nongnu.org,
 slp@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 saket.sinha89@gmail.com, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, mlevitsk@redhat.com, jusual@mail.ru,
 mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxOTEzMzUzMC4yODY4
OC0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1
aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2ls
bCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcg
dG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2Ui
CiMgYnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8g
Ij09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1FID09PSIKdW5h
bWUgLWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0kUFdEL2J1
aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNSQy9jb25m
aWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6IHdlIG5lZWQg
cmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0YWxsCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgbmJkL3RyYWNlLm8KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIGJsb2NrL3RyYWNlLmM6NDoKYmxvY2svdHJhY2UuaDogSW4gZnVuY3Rpb24g4oCYX25v
Y2hlY2tfX3RyYWNlX2x1cmluZ19yZXN1Ym1pdF9zaG9ydF9yZWFk4oCZOgpibG9jay90cmFjZS5o
OjE3MDQ6OTY6IGVycm9yOiBzdHJheSDigJhc4oCZIGluIHByb2dyYW0KIDE3MDQgfCAgICAgICAg
IHFlbXVfbG9nKCIlZEAlenUuJTA2enU6bHVyaW5nX3Jlc3VibWl0X3Nob3J0X3JlYWQgIiAiTHVy
aW5nU3RhdGUgJXAgbHVyaW5nY2IgJXAgbnJlYWQgIlxuIiwKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KYmxvY2svdHJhY2UuaDoxNzA0OjYwOiBlcnJvcjog
ZXhwZWN0ZWQg4oCYKeKAmSBiZWZvcmUg4oCYbuKAmQogMTcwNCB8ICAgICAgICAgcWVtdV9sb2co
IiVkQCV6dS4lMDZ6dTpsdXJpbmdfcmVzdWJtaXRfc2hvcnRfcmVhZCAiICJMdXJpbmdTdGF0ZSAl
cCBsdXJpbmdjYiAlcCBucmVhZCAiXG4iLAogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIH4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICkKYmxvY2svdHJhY2UuaDoxNzA0Ojk4OiBlcnJv
cjogbWlzc2luZyB0ZXJtaW5hdGluZyAiIGNoYXJhY3RlciBbLVdlcnJvcl0KIDE3MDQgfCAgICAg
ICAgIHFlbXVfbG9nKCIlZEAlenUuJTA2enU6bHVyaW5nX3Jlc3VibWl0X3Nob3J0X3JlYWQgIiAi
THVyaW5nU3RhdGUgJXAgbHVyaW5nY2IgJXAgbnJlYWQgIlxuIiwKICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpibG9jay90cmFjZS5oOjE3MDQ6OTg6IGVy
cm9yOiBtaXNzaW5nIHRlcm1pbmF0aW5nICIgY2hhcmFjdGVyCiAxNzA0IHwgICAgICAgICBxZW11
X2xvZygiJWRAJXp1LiUwNnp1Omx1cmluZ19yZXN1Ym1pdF9zaG9ydF9yZWFkICIgIkx1cmluZ1N0
YXRlICVwIGx1cmluZ2NiICVwIG5yZWFkICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF5+CmJsb2NrL3RyYWNlLmg6MTcwNDoyMDogZXJyb3I6IGZv
cm1hdCDigJglZOKAmSBleHBlY3RzIGEgbWF0Y2hpbmcg4oCYaW504oCZIGFyZ3VtZW50IFstV2Vy
cm9yPWZvcm1hdD1dCiAxNzA0IHwgICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1Omx1cmlu
Z19yZXN1Ym1pdF9zaG9ydF9yZWFkICIgIkx1cmluZ1N0YXRlICVwIGx1cmluZ2NiICVwIG5yZWFk
ICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgfl4KICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgfAogICAgICB8ICAgICAgICAgICAgICAgICAgICBpbnQKYmxvY2svdHJhY2UuaDoxNzA0
OjI0OiBlcnJvcjogZm9ybWF0IOKAmCV6deKAmSBleHBlY3RzIGEgbWF0Y2hpbmcg4oCYc2l6ZV90
4oCZIGFyZ3VtZW50IFstV2Vycm9yPWZvcm1hdD1dCiAxNzA0IHwgICAgICAgICBxZW11X2xvZygi
JWRAJXp1LiUwNnp1Omx1cmluZ19yZXN1Ym1pdF9zaG9ydF9yZWFkICIgIkx1cmluZ1N0YXRlICVw
IGx1cmluZ2NiICVwIG5yZWFkICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfn5e
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICB8CiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICBsb25nIHVuc2lnbmVkIGludApibG9jay90cmFjZS5oOjE3MDQ6MzA6IGVycm9yOiBm
b3JtYXQg4oCYJXp14oCZIGV4cGVjdHMgYSBtYXRjaGluZyDigJhzaXplX3TigJkgYXJndW1lbnQg
Wy1XZXJyb3I9Zm9ybWF0PV0KIDE3MDQgfCAgICAgICAgIHFlbXVfbG9nKCIlZEAlenUuJTA2enU6
bHVyaW5nX3Jlc3VibWl0X3Nob3J0X3JlYWQgIiAiTHVyaW5nU3RhdGUgJXAgbHVyaW5nY2IgJXAg
bnJlYWQgIlxuIiwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fl4KICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGxvbmcgdW5zaWduZWQgaW50CmJsb2NrL3RyYWNlLmg6MTcwNDoxODogZXJy
b3I6IGZvcm1hdCDigJglcOKAmSBleHBlY3RzIGEgbWF0Y2hpbmcg4oCYdm9pZCAq4oCZIGFyZ3Vt
ZW50IFstV2Vycm9yPWZvcm1hdD1dCiAxNzA0IHwgICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUw
Nnp1Omx1cmluZ19yZXN1Ym1pdF9zaG9ydF9yZWFkICIgIkx1cmluZ1N0YXRlICVwIGx1cmluZ2Ni
ICVwIG5yZWFkICJcbiIsCiAgICAgIHwgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KYmxvY2svdHJhY2UuaDoxNzA0Ojc1OiBub3RlOiBm
b3JtYXQgc3RyaW5nIGlzIGRlZmluZWQgaGVyZQotLS0KICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fl4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKgpibG9jay90cmFjZS5oOjE3MDQ6MTg6IGVycm9yOiBmb3JtYXQg4oCYJXDigJkgZXhwZWN0
cyBhIG1hdGNoaW5nIOKAmHZvaWQgKuKAmSBhcmd1bWVudCBbLVdlcnJvcj1mb3JtYXQ9XQogMTcw
NCB8ICAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTpsdXJpbmdfcmVzdWJtaXRfc2hvcnRf
cmVhZCAiICJMdXJpbmdTdGF0ZSAlcCBsdXJpbmdjYiAlcCBucmVhZCAiXG4iLAogICAgICB8ICAg
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
CmJsb2NrL3RyYWNlLmg6MTcwNDo4Nzogbm90ZTogZm9ybWF0IHN0cmluZyBpcyBkZWZpbmVkIGhl
cmUKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMTkwNzE5MTMzNTMwLjI4Njg4LTEtbWVodGEuYWFydTIwQGdtYWlsLmNvbS90ZXN0aW5nLnMz
OTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


