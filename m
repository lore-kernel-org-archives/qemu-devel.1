Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A6AC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB932072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB932072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipqlS-0005ot-VP
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 04:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipqki-00051c-MJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipqkh-00027f-H4
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 04:38:48 -0500
Resent-Date: Fri, 10 Jan 2020 04:38:48 -0500
Resent-Message-Id: <E1ipqkh-00027f-H4@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipqke-0001km-ED; Fri, 10 Jan 2020 04:38:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578649111; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jDxzxbXKo4ZKjyvrzZS6hyI78aP1aLVC8W2p7tIlhWhG1MAvYJlot4272/uIvlTF3pqrGycFtoNKC3uooxBVersPIJDpgBuAWVkwgiukuFoZFjM4r/1Ey4PJIPyYXcDKxJ0TLiYQwnPaNph7xXOVuL2WQLeGHdnuMx/S23rj634=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578649111;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ja3PON84+9Sai4EXCegwrDowh5PIJAgCIg6r4RNCmjA=; 
 b=fvE+FwOGrnOGa9PVlFjejECtoIEoEfSeCgJITxBqs7JTEsVTtTjW+etlVirVooUt/3M+LZN9kURuB3rbb24tiZx7UezWqllTZjurHsTc5moUeMFWhDnksIPSdF8N21af06zohQOF0Zj3htHZ6wio5GlYKX4W5s2LxhzIV4RXVxY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578649107507463.1547522796719;
 Fri, 10 Jan 2020 01:38:27 -0800 (PST)
In-Reply-To: <20200110091710.53424-1-pannengyuan@huawei.com>
Subject: Re: [PATCH v2 0/2] fix mismatches between g_strsplit and g_free
Message-ID: <157864910613.14224.13450876414345316635@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pannengyuan@huawei.com
Date: Fri, 10 Jan 2020 01:38:27 -0800 (PST)
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 pannengyuan@huawei.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExMDA5MTcxMC41MzQy
NC0xLXBhbm5lbmd5dWFuQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNr
LXVuaXQ6IHRlc3RzL3Rlc3QtY3J5cHRvLWNpcGhlcgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVz
dHMvdGVzdC1jcnlwdG8tc2VjcmV0CiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LXFn
YQpFUlJPUiAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCAyNSwgZ290IDE3KQogIFRFU1Qg
ICAgaW90ZXN0LXFjb3cyOiAwMjkKbWFrZTogKioqIFtjaGVjay11bml0XSBFcnJvciAxCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDAzMQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMzIKLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTMyN2UxYmViYTk3OTRlMzA4NWE5ZTM5OTI3ZDFkZmU1JywgJy11
JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0x
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTFxZ2NmaWZkL3NyYy9kb2NrZXItc3JjLjIwMjAt
MDEtMTAtMDQuMjcuMzAuMTI1MTE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycs
ICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlk
PTMyN2UxYmViYTk3OTRlMzA4NWE5ZTM5OTI3ZDFkZmU1Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1
bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTFxZ2NmaWZkL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tA
Y2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxMG01NS43NTlzCnVzZXIgICAgMG04LjAxMHMKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
MTEwMDkxNzEwLjUzNDI0LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbS90ZXN0aW5nLmRvY2tlci1x
dWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


