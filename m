Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F03206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 08:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F03206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieDzr-0007WE-8k
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 03:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieDz5-0006yX-69
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieDz3-0006eI-Kd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:01:34 -0500
Resent-Date: Mon, 09 Dec 2019 03:01:34 -0500
Resent-Message-Id: <E1ieDz3-0006eI-Kd@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieDz3-0006cB-DH
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 03:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575878481; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jAKgHzkGItg38nMcz45wtf7OM1xnI22RmHVQnehbDrPSBSi23rF6gqaIw+nTR6L1GeAnkNCio/PdGdnf+PZdJfgCPOE/s2aFun11HLdFzq5DoQDsByJ7NGH7YLWXfjsOtoVXlsqQ0ki09sitzhKWygEX8F+bAXtUJEDUEKeEFKE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575878481;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=osG9YzChnSx9DKtQthr7qFmhHkrAIsYoHqr14BIfpJg=; 
 b=G1rC96sFwIME1df7DgfAmwQkWZrMI/hlff6KKlz7mtSVOFEZYkFYYo6UzfeSN1eASJ5uDXFVDBp7+Pkroke5obNkjJEDo1v+CqZ4MhejDfArAir2I6vAYXfnP0pj4bvKsGo9gnH8Fe3wvvF/vjfGan0r1OoYmMzf1MkipJzoqK4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575878478998539.0868277814335;
 Mon, 9 Dec 2019 00:01:18 -0800 (PST)
In-Reply-To: <20191209063841.8321-1-tao3.xu@intel.com>
Subject: Re: [PATCH v2] util/cutils: Expand do_strtosz parsing precision to 64
 bits
Message-ID: <157587846634.7675.14962090152382930948@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Mon, 9 Dec 2019 00:01:18 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: qemu-devel@nongnu.org, tao3.xu@intel.com, armbru@redhat.com,
 ehabkost@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTA2Mzg0MS44MzIx
LTEtdGFvMy54dUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNrLXVuaXQ6
IHRlc3RzL3Rlc3Qtdm1zdGF0ZQogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1jdXRp
bHMKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtY3V0aWxzLmM6MjE0NTp0
ZXN0X3FlbXVfc3RydG9zel9lcmFuZ2U6IGFzc2VydGlvbiBmYWlsZWQgKGVyciA9PSAtRVJBTkdF
KTogKC0yMiA9PSAtMzQpCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3Ny
Yy90ZXN0cy90ZXN0LWN1dGlscy5jOjIxNDU6dGVzdF9xZW11X3N0cnRvc3pfZXJhbmdlOiBhc3Nl
cnRpb24gZmFpbGVkIChlcnIgPT0gLUVSQU5HRSk6ICgtMjIgPT0gLTM0KQptYWtlOiAqKiogW2No
ZWNrLXVuaXRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDEzCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAx
NwotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nl
c3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywg
J3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZGFjNTIzMzEzNjQ3NGE5
ODgzNTM4NmM3OTNiYWFmY2UnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNj
b21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2Fj
aGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFy
L3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOXFqZ2hm
eWIvc3JjL2RvY2tlci1zcmMuMjAxOS0xMi0wOS0wMi40Ny4xNy4yNDYxMTovdmFyL3RtcC9xZW11
Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2sn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZGFjNTIzMzEzNjQ3NGE5ODgzNTM4NmM3OTNiYWFmY2UK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOXFqZ2hmeWIvc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEzbTQ5LjE0
MXMKdXNlciAgICAwbTcuODcwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEyMDkwNjM4NDEuODMyMS0xLXRhbzMueHVAaW50ZWwuY29t
L3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


