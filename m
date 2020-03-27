Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7319C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D7D207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D7D207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHniR-0002TO-P2
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHnhn-0001zR-Bi
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHnhl-0007ek-Qq
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:03:18 -0400
Resent-Date: Fri, 27 Mar 2020 08:03:18 -0400
Resent-Message-Id: <E1jHnhl-0007ek-Qq@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHnhl-0007Xg-GM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:03:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585310588; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NwQHw80aYmkUVgT/Rx9glg0UWIgCLX6VrE47gNl20TFWtaa+wewcxGMwPVH6tRLEimeGjrmHyxAhHXYEw4sDRqYZwhlaWzcrH56OZhl8ZDvtRWlxnAvOJ+NxMaRRbekqF+etfZA92kcHtKw12NWv6oHYkoGjbiV7NuoR3tq6tro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585310588;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7tkCB9H2CC1AGzmMOShw1MV4iJaYqjRpPS0XS6aH5pU=; 
 b=BBPcqPwTMejFX54oXlebFmtjbe8NJVReY7aMAFzdKgEJaTuqKHsWPWcqML0AAwOUGsOn68TJspq3rMWmUH8qoT/IlHK3tszuXsTA/XXuxl1EWMNCx11YSDUpnyLVDANXGKygcg5G3FNyZBk9KDiRSo8zsDrsSCFH1qyzR/tEUPQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585310586844784.1076366892755;
 Fri, 27 Mar 2020 05:03:06 -0700 (PDT)
In-Reply-To: <1585307647-24456-1-git-send-email-jasowang@redhat.com>
Subject: Re: [PULL 00/13] Net patches
Message-ID: <158531058571.31566.12719599627879978627@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jasowang@redhat.com
Date: Fri, 27 Mar 2020 05:03:06 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg1MzA3NjQ3LTI0NDU2LTEt
Z2l0LXNlbmQtZW1haWwtamFzb3dhbmdAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNl
bnRvczcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBT
SE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgaHcvbmV0L2Nhbi9jYW5fcGNtMzY4MF9wY2kubwogIENDICAgICAgaHcvbmV0L2Nhbi9jYW5f
bWlvZTM2ODBfcGNpLm8KICBDQyAgICAgIGh3L252cmFtL2VlcHJvbTkzeHgubwovdG1wL3FlbXUt
dGVzdC9zcmMvaHcvbmV0L2FsbHdpbm5lci1zdW44aS1lbWFjLmM6NzczOjU6IGVycm9yOiBpbml0
aWFsaXphdGlvbiBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJyb3JdCiAgICAg
LmNhbl9yZWNlaXZlID0gYWxsd2lubmVyX3N1bjhpX2VtYWNfY2FuX3JlY2VpdmUsCiAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L2FsbHdpbm5lci1zdW44aS1lbWFjLmM6NzczOjU6IGVy
cm9yOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IgJ25ldF9hbGx3aW5uZXJfc3VuOGlfZW1hY19p
bmZvLmNhbl9yZWNlaXZlJykgWy1XZXJyb3JdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0
ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbaHcvbmV0L2FsbHdpbm5lci1zdW44aS1lbWFjLm9dIEVy
cm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5w
eSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9OWRlNzZhN2IxMTViNGFiOGE5NDA2OGNhOWMyY2FkN2YnLCAnLXUnLCAnMTAwMycs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtdG5obGVqODcvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0yNy0wOC4w
MC40NS4xNzA5NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWRlNzZhN2Ix
MTViNGFiOGE5NDA2OGNhOWMyY2FkN2YKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
dG5obGVqODcvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDJtMjAuNjMwcwp1c2VyICAgIDBtOC4wNDhzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg1MzA3NjQ3LTI0NDU2
LTEtZ2l0LXNlbmQtZW1haWwtamFzb3dhbmdAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlj
a0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

