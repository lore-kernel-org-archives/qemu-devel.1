Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D14C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383A52072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383A52072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIGd-00006N-6M
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jFIEe-0007D0-58
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jFIEY-00065e-Aj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:02:51 -0400
Resent-Date: Fri, 20 Mar 2020 10:02:51 -0400
Resent-Message-Id: <E1jFIEY-00065e-Aj@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jFIEY-00065M-35
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584712957; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=USixjKjdQBFKHuQXWAqitGRxJHosSn3VO7KcKAW7e0i0Zl9p7sNWHTduq6riISLOIzvj60PZsAsD5lYEKEPzuZfbNsJ7PqsO1h4MKt7vBZrbBF42Ib1kfJ3Dm5iOYDNa2segamRUM8/RG6jF6MMqe8r4ZmWWBigqKQmApoSzUd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584712957;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ndbBxLKFW4B7s2v5Imwh+Ea91rIH1isOq/c+Jlz2QB4=; 
 b=kNlN0STpcoLVpzg7KK917BqREMFM3vuFGYcuhuJ2A5j1+x9cxq8D4ou1iE/gyuvuI2RV27R+UrMev5DTyVkEuGRq07DDuTZgnFvFLvgUjJLmRRVUhGLyIBn4bGi6+V47t1rG/vrfauVSVZilYVlIIVeUl3MoBEDqDGhd/TRUA9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584712953894709.0395486995387;
 Fri, 20 Mar 2020 07:02:33 -0700 (PDT)
In-Reply-To: <20200320120456.1931482-1-dnbrdsky@gmail.com>
Subject: Re: [PATCH v3 0/2] Replaced locks with lock guard macros
Message-ID: <158471295294.15782.3617482949930071577@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dnbrdsky@gmail.com
Date: Fri, 20 Mar 2020 07:02:33 -0700 (PDT)
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
Cc: dnbrdsky@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyMDEyMDQ1Ni4xOTMx
NDgyLTEtZG5icmRza3lAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
ICBDQyAgICAgIHV0aWwvbW1hcC1hbGxvYy5vCiAgQ0MgICAgICB1dGlsL29zbGliLXBvc2l4Lm8K
ICBDQyAgICAgIHV0aWwvcWVtdS1vcGVucHR5Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvdGhy
ZWFkLXBvb2wuYzoyMTM6NTogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSAncWVtdV9sb2NrYWJsZV9h
dXRvMScgWy1XZXJyb3IsLVd1bnVzZWQtdmFyaWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJnBv
b2wtPmxvY2spOwogICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xvY2thYmxl
Lmg6MTczOjI5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdRRU1VX0xPQ0tfR1VBUkQnCi0t
LQpxZW11X2xvY2thYmxlX2F1dG8xCl4KMSBlcnJvciBnZW5lcmF0ZWQuCm1ha2U6ICoqKiBbL3Rt
cC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogdXRpbC90aHJlYWQtcG9vbC5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBs
aW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPTE0NjQ4YzhjOGUzMzQ2MTU4ZGQyOTAwZGEyMmNmNjgyJywgJy11JywgJzEwMDEnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWtocGdpcXNsL3NyYy9kb2NrZXItc3JjLjIwMjAtMDMt
MjAtMDkuNTguNTAuMjE1NTg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MTQ2
NDhjOGM4ZTMzNDYxNThkZDI5MDBkYTIyY2Y2ODIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAta2hwZ2lxc2wvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRv
cmFdIEVycm9yIDIKCnJlYWwgICAgM200My4zMTBzCnVzZXIgICAgMG04LjU1MnMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzIwMTIw
NDU2LjE5MzE0ODItMS1kbmJyZHNreUBnbWFpbC5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

