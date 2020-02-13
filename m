Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFAE20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFAE20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BWQ-0003Zf-6x
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j2BVt-00037j-Jt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j2BVr-0002Fg-Vo
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:14:29 -0500
Resent-Date: Thu, 13 Feb 2020 05:14:29 -0500
Resent-Message-Id: <E1j2BVr-0002Fg-Vo@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j2BVr-0002FS-ND
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:14:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581588854; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N9Pq+7XyfrAJrTqlyjasok3FGoeyIv2kDRFtQig0Jxeb6gOxT2HPEj/C084BYBdSdh20+oc26ZYPMqTlz36Pe86uXMoeFuMI4MtDhHX3BeoE7fi+eCJqoiFqZ+AjSmWm2/nNRyqbUWCdKjfJ2JfekguaDBhZpnryZkcptSlMWfg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581588854;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=V97RCoiffzfrw6JUh0sfAR4wJ4TAC5DzVcCickuBJZ8=; 
 b=IUGxrGqULe9ZNyJmYtksEC1VCTgCXUT8TYm30K36svUUzKOyWnJ2FJlIuwpN2TuCwbuO6hd/XDick/fdI70g6qnmtmhIevcT0zo92gSdftZbeXjewX6oUAHQV2JyNhAUpnXGinlHmyWDkmviWb9oRzl9Z5evyU6jsLbNje0/UPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581588852199393.5466308282457;
 Thu, 13 Feb 2020 02:14:12 -0800 (PST)
In-Reply-To: <20200213093755.370-1-fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 00/14] *** multifd for RDMA v2 ***
Message-ID: <158158885089.23372.3307991609443123651@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fengzhimin1@huawei.com
Date: Thu, 13 Feb 2020 02:14:12 -0800 (PST)
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
Cc: jemmy858585@gmail.com, quintela@redhat.com, qemu-devel@nongnu.org,
 fengzhimin1@huawei.com, armbru@redhat.com, dgilbert@redhat.com,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMzA5Mzc1NS4zNzAt
MS1mZW5nemhpbWluMUBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi90bXAvcWVtdS10
ZXN0L3NyYy9taWdyYXRpb24vbXVsdGlmZC5jOjY2MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
bXVsdGlmZF9jaGFubmVsX3JkbWFfY29ubmVjdCcKLi4vbWlncmF0aW9uL211bHRpZmQubzogSW4g
ZnVuY3Rpb24gYG11bHRpZmRfbG9hZF9jbGVhbnVwJzoKL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3Jh
dGlvbi9tdWx0aWZkLmM6ODQzOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBxZW11X3JkbWFfY2xl
YW51cCcKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6MjA2OiBxZW11LXN5c3RlbS14ODZfNjR3LmV4ZV0gRXJyb3IgMQptYWtl
OiAqKiogW01ha2VmaWxlOjQ5NzogeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6ICoq
KiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCi4uL21pZ3JhdGlvbi9tdWx0aWZkLm86
IEluIGZ1bmN0aW9uIGBtdWx0aWZkX3JkbWFfcmVjdl90aHJlYWQnOgovdG1wL3FlbXUtdGVzdC9z
cmMvbWlncmF0aW9uL211bHRpZmQuYzo4OTg6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFlbXVf
cmRtYV9yZWdpc3RyYXRpb25faGFuZGxlJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlv
bi9tdWx0aWZkLmM6NjYzOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBtdWx0aWZkX2NoYW5uZWxf
cmRtYV9jb25uZWN0JwouLi9taWdyYXRpb24vbXVsdGlmZC5vOiBJbiBmdW5jdGlvbiBgbXVsdGlm
ZF9sb2FkX2NsZWFudXAnOgovdG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0aW9uL211bHRpZmQuYzo4
NDM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFlbXVfcmRtYV9jbGVhbnVwJwpjb2xsZWN0Mjog
ZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToy
MDY6IHFlbXUtc3lzdGVtLWFhcmNoNjR3LmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxl
OjQ5NzogYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQs
IGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD04ODQ3M2Q2MzRkNjU0M2VhOTkyMDQ1Y2JlOWE4MDZlMScsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9Jywg
Jy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcy
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXlpcTdhZXZmL3NyYy9kb2NrZXItc3JjLjIwMjAtMDIt
MTMtMDUuMTEuMzUuMTM3NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04ODQ3
M2Q2MzRkNjU0M2VhOTkyMDQ1Y2JlOWE4MDZlMQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC15aXE3YWV2Zi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9y
YV0gRXJyb3IgMgoKcmVhbCAgICAybTM1Ljc5MXMKdXNlciAgICAwbTcuNzE3cwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMTMwOTM3
NTUuMzcwLTEtZmVuZ3poaW1pbjFAaHVhd2VpLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRv
cmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

