Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830BFC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B32D20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B32D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVDh-0006If-Br
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipVD5-0005s7-Qn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipVD4-0001tD-01
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:38:39 -0500
Resent-Date: Thu, 09 Jan 2020 05:38:39 -0500
Resent-Message-Id: <E1ipVD4-0001tD-01@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipVD3-0001mq-MF
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 05:38:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578566303; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=efcIZONVcLRDVNrhkdqZlafZRswDif7jbK24jbG+pKO5dd47I4Q7Fh4couvbCB0PiYyAdn8388br23Qlc7YaB9CamkMezH7GyhuWE7dhWGOYquJuDG2v5yQDrJoG81V06l5Fyd2EF/Y8YsV0gJON75efKQiebVeCuYG/II5QcUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578566303;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=CGGVIOz2PwQje2nag3V/SVfZ0TigPpfJ62bxJrth3ng=; 
 b=dh6Md+Z1EYZ2UhTqktW53ELO+NohZh5qz/MgnlySV7I4IQ5ZXMr4ipzJQSc8+OMn+lFBzE12r0c+t82S+OTxk/luCcQOPgpqfOoVanUdxwXE2wU43QumjbnbL/rsHvMGQiLO6LLJiWs5xVTpNIPB0w+XaR/kXtp4IeYIP2hUThk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578566299550449.2713697406124;
 Thu, 9 Jan 2020 02:38:19 -0800 (PST)
In-Reply-To: <20200109045922.904-1-fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 00/12] *** mulitple RDMA channels for migration ***
Message-ID: <157856629834.10177.4325482129569168778@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fengzhimin1@huawei.com
Date: Thu, 9 Jan 2020 02:38:19 -0800 (PST)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwOTA0NTkyMi45MDQt
MS1mZW5nemhpbWluMUBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICBh
YXJjaDY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NHcuZXhlCi4uL21pZ3JhdGlvbi9taWdy
YXRpb24ubzogSW4gZnVuY3Rpb24gYG1pZ3JhdGVfZmRfY2xlYW51cCc6Ci90bXAvcWVtdS10ZXN0
L3NyYy9taWdyYXRpb24vbWlncmF0aW9uLmM6MTU0OTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
bXVsdGlSRE1BX3NhdmVfY2xlYW51cCcKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4
aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA2OiBxZW11LXN5c3RlbS14ODZfNjR3
LmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQ4MzogeDg2XzY0LXNvZnRtbXUvYWxs
XSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCi4uL21p
Z3JhdGlvbi9taWdyYXRpb24ubzogSW4gZnVuY3Rpb24gYG1pZ3JhdGVfZmRfY2xlYW51cCc6Ci90
bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vbWlncmF0aW9uLmM6MTU0OTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgbXVsdGlSRE1BX3NhdmVfY2xlYW51cCcKY29sbGVjdDI6IGVycm9yOiBsZCBy
ZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA2OiBxZW11LXN5
c3RlbS1hYXJjaDY0dy5leGVdIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0ODM6IGFhcmNo
NjQtc29mdG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxl
PgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9YjY5ZDIxNWI4ZTQxNDNiYThmOWU1NGZhOWQ1YTZjYmMnLCAnLXUnLCAnMTAwMScsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLTFmcnBhZzUyL3NyYy9kb2NrZXItc3JjLjIwMjAtMDEtMDktMDUuMzUuNDYu
MjcyOTk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjY5ZDIxNWI4ZTQxNDNi
YThmOWU1NGZhOWQ1YTZjYmMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMWZycGFn
NTIvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgMm0zMi42NTdzCnVzZXIgICAgMG04LjU3M3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTA5MDQ1OTIyLjkwNC0xLWZl
bmd6aGltaW4xQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


