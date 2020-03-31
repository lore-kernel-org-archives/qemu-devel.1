Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9243AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607AA20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607AA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJF5h-0003BN-IM
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJF4z-0002l1-SI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJF4y-0000JR-Kk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:29:13 -0400
Resent-Date: Tue, 31 Mar 2020 07:29:13 -0400
Resent-Message-Id: <E1jJF4y-0000JR-Kk@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJF4y-0000Id-DH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585654140; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jSISU1J8x/BKvaXpHtxqUnr9m2417pJ+ZdH4FTx9esutO10f66KCd0VG9Epopls40TjPqNZlnu4VCQJxiWrkyKwGal8d+MzrLnIAI+h5+DVtoiV5FnZiKlA4ijOSi9WsIOtSKmsKRFPcU2Pttp8+U1gwi3sHIaclYJMmeFot81Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585654140;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=sQEYxcQugCj/V2WhVv3pMbkK3/i4GGIqJQY0lWh3m+0=; 
 b=dhXJEYyPr9dIw9oGVBaIU1g/ONe/rF/lQmtsvLsrTKe//ok6pcN88n4u1EiVgYv0fpwwuMHbOitDeMsfTMM/s/j3SAg/mxC+lP75WSQTu03TKOkcj0dYqKenQlpNuOO/ChzlNzWJ/YUPM3FgALI0mTD7IItJbjYDdxTQkpanQ9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585654137573324.1460113719638;
 Tue, 31 Mar 2020 04:28:57 -0700 (PDT)
In-Reply-To: <cover.1585641083.git.maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH v2 0/3] Improved reporting for migrate parameters
Message-ID: <158565413631.16271.6328083537074277892@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: maozhongyi@cmss.chinamobile.com
Date: Tue, 31 Mar 2020 04:28:57 -0700 (PDT)
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, maozhongyi@cmss.chinamobile.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTg1NjQxMDgzLmdp
dC5tYW96aG9uZ3lpQGNtc3MuY2hpbmFtb2JpbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjIgMC8zXSBJbXByb3ZlZCBy
ZXBvcnRpbmcgZm9yIG1pZ3JhdGUgcGFyYW1ldGVycwpNZXNzYWdlLWlkOiBjb3Zlci4xNTg1NjQx
MDgzLmdpdC5tYW96aG9uZ3lpQGNtc3MuY2hpbmFtb2JpbGUuY29tClR5cGU6IHNlcmllcwoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmZhdGFsOiB1bmFibGUgdG8gYWNjZXNz
ICdodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUvJzogRmFpbGVkIGNvbm5l
Y3QgdG8gZ2l0aHViLmNvbTo0NDM7IENvbm5lY3Rpb24gdGltZWQgb3V0ClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICJwYXRjaGV3LXRlc3RlcjIvc3JjL3BhdGNoZXct
Y2xpIiwgbGluZSA1MzEsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsi
cmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YsIFRydWUpCiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIyL3Ny
Yy9wYXRjaGV3LWNsaSIsIGxpbmUgNTcsIGluIGdpdF9jbG9uZV9yZXBvCiAgICBjd2Q9Y2FjaGVf
cmVwbywgc3Rkb3V0PWxvZ2YsIHN0ZGVycj1sb2dmKQogIEZpbGUgIi9vcHQvcmgvcmgtcHl0aG9u
MzYvcm9vdC91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI5MSwgaW4g
Y2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0JywgJ2ZldGNoJywgJzNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnK3JlZnMvdGFncy9wYXRj
aGV3L2NvdmVyLjE1ODU2NDEwODMuZ2l0Lm1hb3pob25neWlAY21zcy5jaGluYW1vYmlsZS5jb206
cmVmcy90YWdzL3BhdGNoZXcvY292ZXIuMTU4NTY0MTA4My5naXQubWFvemhvbmd5aUBjbXNzLmNo
aW5hbW9iaWxlLmNvbSddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxMjguCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIu
MTU4NTY0MTA4My5naXQubWFvemhvbmd5aUBjbXNzLmNoaW5hbW9iaWxlLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

