Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4462C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B913C2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 08:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B913C2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY4Wq-0003Li-Q2
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 03:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iY4Vl-0002Vk-Di
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iY4Vj-0004Qs-PU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:41:53 -0500
Resent-Date: Fri, 22 Nov 2019 03:41:53 -0500
Resent-Message-Id: <E1iY4Vj-0004Qs-PU@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iY4Vj-0004QL-HQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:41:51 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574412080; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PZGsN/DtwsoLbhIoU0esoVUyr+LaGZRj9hvUkzTMuHYOxkgUA5EQQ5uFk8THSeIhIbOj/M/LRr9mz3d6fVAqucUiIax/ETQQxgiJwBooJ7vRjEAbf4zZhoRgeLda/uqz9KwUQjFkrACL4JQNLkC5aOCpTHHzr11N52qJFLGmiyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574412080;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U4MwBQ3J1PydJZ7P9yTieW8SORo5akzbX9ZFm4DPxhw=; 
 b=RdOHPD06DBukwjYu8EmHFXkp4Ov/QiN5TV75B4ydMBNif+5SdgrqL8ucC8U3tbVu4lDWfkScq77AS+Jq/EvxVqic8w+OJzieYBTFqKI0Ym8Hr4MQD++OQvwHbWRxp+Zw3Ava2cXvQJlOQwKVyg4B8LjtPIP5eZSTiAsxIUP9MFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574412078544786.7115365045007;
 Fri, 22 Nov 2019 00:41:18 -0800 (PST)
In-Reply-To: <20191122074826.1373-1-tao3.xu@intel.com>
Subject: Re: [PATCH v17 00/14] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <157441207652.7001.8047298058253413835@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Fri, 22 Nov 2019 00:41:18 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, tao3.xu@intel.com, fan.du@intel.com,
 armbru@redhat.com, mdroth@linux.vnet.ibm.com, jingqi.liu@intel.com,
 imammedo@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMjA3NDgyNi4xMzcz
LTEtdGFvMy54dUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNrLXF0ZXN0
LXg4Nl82NDogdGVzdHMvbnVtYS10ZXN0CkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3NyYy90
ZXN0cy9saWJxdGVzdC5jOjE0OToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBkZWF0aCBmcm9t
IHNpZ25hbCA4IChGbG9hdGluZyBwb2ludCBleGNlcHRpb24pIChjb3JlIGR1bXBlZCkKRVJST1Ig
LSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgOSwgZ290IDgpCm1ha2U6ICoqKiBbY2hlY2st
cXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE3MgogIFRFU1QgICAgaW90ZXN0LXFjb3cy
OiAxNzQKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWRjZWM0MjhhOTc0
MzQyMTFiOWMwODU2ZGE2NThmZjBiJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXpy
OXN3b3RrL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMjItMDMuMjguMzIuMjYzNDE6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1
aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWRjZWM0MjhhOTc0MzQyMTFiOWMwODU2ZGE2NThm
ZjBiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXpyOXN3b3RrL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxMm00
NC4zNjJzCnVzZXIgICAgMG03Ljk5N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTIyMDc0ODI2LjEzNzMtMS10YW8zLnh1QGludGVs
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


