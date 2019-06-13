Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54219C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB922082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB922082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTlz-0008RD-Ux
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hbSI7-00039H-60
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hbSI5-0004TK-WD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:09:31 -0400
Resent-Date: Thu, 13 Jun 2019 12:09:31 -0400
Resent-Message-Id: <E1hbSI5-0004TK-WD@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hbSI5-0004JA-Np; Thu, 13 Jun 2019 12:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560442111; cv=none; d=zoho.com; s=zohoarc; 
 b=GYHiruSDctb78WLDdhIKS/xGGub8ly6peyD1xa/GLqow36jNQWMdyOVNWhmnZfMHcTXCAP17uBNfbLJnQvHcpISIWjDAAvX/kL45yflpyNril50JxUyznR3g5WcGubV/iFD+PQBSR+cVarX/Ybni0ZxPGgNS/C4HFhvFWjel8vU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560442111;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=9+B6DrpGogsTPZN07YfD6xd3GJySSQ6xyoCMAGlb63I=; 
 b=mk2otVyozEFPhnzuLCAdnbljk8gYsW6k2odQuPh0FidGxeOhrU4xeqlBcolTYgXAR121q+muF4cnDE3vxSq74dk76hcbHXVZOnPV0CxKNnPT2/0jeB41ElCEvGgF1xxjYp5/Ed2P9DfNxwdFycWeA8J/3o09BJcv7+mPyMncutU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560442107137649.7058792055913;
 Thu, 13 Jun 2019 09:08:27 -0700 (PDT)
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
Message-ID: <156044210518.5426.10152353151796303692@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Thu, 13 Jun 2019 09:08:27 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v8 0/7] backup-top filter driver for backup
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyOTE1NDY1NC45NTg3
MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5k
CnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNh
biBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKICBDQyAgICAgIGNyeXB0by9jaXBoZXIubwogIENDICAgICAgY3J5cHRvL3Rsc2NyZWRzLm8K
ICBDQyAgICAgIGNyeXB0by90bHNjcmVkc2Fub24ubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
YmFja3VwLXRvcC5jOjI2ODo1OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rp
b24gJ2JkcnZfc2V0X2Fpb19jb250ZXh0JyBpcyBpbnZhbGlkIGluIEM5OSBbLVdlcnJvciwtV2lt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgYmRydl9zZXRfYWlvX2NvbnRleHQodG9w
LCBiZHJ2X2dldF9haW9fY29udGV4dChzb3VyY2UpKTsKICAgIF4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL2JhY2t1cC10b3AuYzoyNjg6NTogbm90ZTogZGlkIHlvdSBtZWFuICdiZHJ2X2dldF9h
aW9fY29udGV4dCc/Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmg6NTc5
OjEzOiBub3RlOiAnYmRydl9nZXRfYWlvX2NvbnRleHQnIGRlY2xhcmVkIGhlcmUKQWlvQ29udGV4
dCAqYmRydl9nZXRfYWlvX2NvbnRleHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOwogICAgICAgICAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9iYWNrdXAtdG9wLmM6MjY4OjU6IGVycm9yOiB0
aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGlzIG5vdCBhIHByb3RvdHlwZSBbLVdlcnJvciwtV3N0
cmljdC1wcm90b3R5cGVzXQogICAgYmRydl9zZXRfYWlvX2NvbnRleHQodG9wLCBiZHJ2X2dldF9h
aW9fY29udGV4dChzb3VyY2UpKTsKICAgIF4KMiBlcnJvcnMgZ2VuZXJhdGVkLgoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA1MjkxNTQ2
NTQuOTU4NzAtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


