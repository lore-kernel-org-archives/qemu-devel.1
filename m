Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A1C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6400E20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6400E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF14L-00046e-Gi
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jF13a-0003Sm-1Z
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jF13Y-0003mf-OW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:42:17 -0400
Resent-Date: Thu, 19 Mar 2020 15:42:17 -0400
Resent-Message-Id: <E1jF13Y-0003mf-OW@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jF13W-0003jn-0S; Thu, 19 Mar 2020 15:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584646915; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MOLZC6Ni1KuEhxroVamVmXPq4gzuRNJ6nMy0xNIk94PT5bNt0cVBRqFMKsXshj1tU1k/p92je3WyWIufuFw+afkUqFvuw3wucl20UX702olDHHyd2G5x5cUtmTHpfVGbN+DNUuQ+Zwq/rxP/qx9uionYv690dStTIP8g1PkeNcY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584646915;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ksfxhT8dVK1mu2oN8YSLnqT8uazrNOi2DYSlrItSUUI=; 
 b=l4BJHsuy7Gw3q2OinP+kSZfUD9076GRLTbvnGSiXGzpuK2DieqR8dOdiGhA3nCHe/QAZDj7jjxomb0pL2Be+6VBejMAxJGci/Z7zbJ0HcF01PfV05PyqwLG34wUtxluERdwmwKpMSu7XBXXenGMm8rdRzSn034OgxXOvssvHSeQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584646912647273.2919263517657;
 Thu, 19 Mar 2020 12:41:52 -0700 (PDT)
In-Reply-To: <20200319161925.1818377-2-dnbrdsky@gmail.com>
Subject: Re: [PATCH] lockable: replaced locks with lock guard macros where
 appropriate
Message-ID: <158464691088.9037.5280412894035369099@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dnbrdsky@gmail.com
Date: Thu, 19 Mar 2020 12:41:52 -0700 (PDT)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 stefanha@gmail.com, pl@kamp.de, armbru@redhat.com, qemu-devel@nongnu.org,
 dnbrdsky@gmail.com, alex.williamson@redhat.com, kraxel@redhat.com,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, mreitz@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxOTE2MTkyNS4xODE4
Mzc3LTItZG5icmRza3lAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB0
cmFjZS1yb290Lm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy91dGls
L3JjdS5jOjM0OgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9yY3UuYzogSW4gZnVuY3Rpb24gJ3N5
bmNocm9uaXplX3JjdSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvbG9ja2FibGUu
aDoxNzM6Mjk6IGVycm9yOiByZWRlZmluaXRpb24gb2YgJ3FlbXVfbG9ja2FibGVfYXV0b19fQ09V
TlRFUl9fJwogICAgIGdfYXV0b3B0cihRZW11TG9ja2FibGUpIHFlbXVfbG9ja2FibGVfYXV0byMj
X19DT1VOVEVSX18gPSBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy91dGlsL3JjdS5jOjE1Mjo1OiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8gJ1FFTVVfTE9DS19HVUFSRCcKLS0tCi90bXAvcWVtdS10ZXN0L3NyYy91
dGlsL3JjdS5jOjE0NTo1OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ1FFTVVfTE9DS19H
VUFSRCcKICAgICBRRU1VX0xPQ0tfR1VBUkQoJnJjdV9zeW5jX2xvY2spOwogICAgIF5+fn5+fn5+
fn5+fn5+fgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHV0aWwv
cmN1Lm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9NGI2M2ZmZDJhYjVmNDk4N2EwYTU1ZDJhNTJhMDY0YzcnLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTVlbmEyaWRrL3NyYy9kb2NrZXItc3JjLjIwMjAtMDMt
MTktMTUuMzkuMzkuMjM1ODY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NGI2
M2ZmZDJhYjVmNDk4N2EwYTU1ZDJhNTJhMDY0YzcKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtNWVuYTJpZGsvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRv
cmFdIEVycm9yIDIKCnJlYWwgICAgMW00Ni43NTJzCnVzZXIgICAgMG04LjYyOHMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzE5MTYx
OTI1LjE4MTgzNzctMi1kbmJyZHNreUBnbWFpbC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

