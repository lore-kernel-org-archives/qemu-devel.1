Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06765C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCD02073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCD02073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j29YW-0000lC-0U
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 03:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j29Xx-00009b-C8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j29Xv-00018M-0s
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:08:28 -0500
Resent-Date: Thu, 13 Feb 2020 03:08:28 -0500
Resent-Message-Id: <E1j29Xv-00018M-0s@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j29Xu-00017l-PW; Thu, 13 Feb 2020 03:08:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581581283; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bYrcaEJfzpJ9FHavAeyoIMSzRzOvAqvHENExqZI9sXGSRkN5Srwjud6QYW8WKOAYm4nNFCxfd+JSTbSYrYSW6O6d7KAeKWSwLXpCHICiNOyTf6DYT3yLO98u1CpQlzGkgfbi3M3l5D2K9qQ+WZE7Z0qXqfjLuG3H2BaK4u73180=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581581283;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3myoyQ/dxBlBuOdvxxEeeJ0JmSJutLSC/uPk4+ip0qw=; 
 b=Za2NDl9eRsKtFRUxqqCB3lBPu9mwHd8OvZgyQYzV09dJaGaaCPBFeCGMs4PKKwoozmd34KhO+i4K7/MDKua0XOCCX6YsjK91gWPPcz9wxFbYUwCkXOYCR5A21qom/NmXFd+eTKsutFfPH9qUQEXDsj4zBv3H8yKxHUXKO8ketac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581581279947944.9349268050538;
 Thu, 13 Feb 2020 00:07:59 -0800 (PST)
In-Reply-To: <20200213073630.2125-1-fangying1@huawei.com>
Subject: Re: [PATCH v2 0/4] arm64: Add the cpufreq device to show cpufreq info
 to guest
Message-ID: <158158127872.23372.17765831732012241578@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fangying1@huawei.com
Date: Thu, 13 Feb 2020 00:07:59 -0800 (PST)
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, guoheyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMzA3MzYzMC4yMTI1
LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXNpbmcgZXhwZWN0ZWQgZmls
ZSAndGVzdHMvZGF0YS9hY3BpL3ZpcnQvRFNEVCcKYWNwaS10ZXN0OiBXYXJuaW5nISBEU0RUIGJp
bmFyeSBmaWxlIG1pc21hdGNoLiBBY3R1YWwgW2FtbDovdG1wL2FtbC1TV1I5RjBdLCBFeHBlY3Rl
ZCBbYW1sOnRlc3RzL2RhdGEvYWNwaS92aXJ0L0RTRFRdLgp0byBzZWUgQVNMIGRpZmYgYmV0d2Vl
biBtaXNtYXRjaGVkIGZpbGVzIGluc3RhbGwgSUFTTCwgcmVidWlsZCBRRU1VIGZyb20gc2NyYXRj
aCBhbmQgcmUtcnVuIHRlc3RzIHdpdGggVj0xIGVudmlyb25tZW50IHZhcmlhYmxlIHNldCoqCkVS
Uk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6NDkw
OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQpFUlJP
UiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvYmlvcy10
YWJsZXMtdGVzdC5jOjQ5MDp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFpbGVkOiAoYWxsX3Rh
Ymxlc19tYXRjaCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCkNvdWxkIG5vdCBhY2Nlc3MgS1ZN
IGtlcm5lbCBtb2R1bGU6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKcWVtdS1zeXN0ZW0teDg2
XzY0OiAtYWNjZWwga3ZtOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBrdm06IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywg
J2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTY2YThk
ZmE0YTkxNjQyZTM4Yzc3Y2RjN2QyZTVmYzBjJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1v
cHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9Jywg
Jy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0Jywg
Jy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zh
ci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1j
Y2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWJ6bGhnbWt5L3NyYy9kb2NrZXItc3JjLjIwMjAtMDItMTMtMDIuNTYuNDMuMjcwNzU6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTY2YThkZmE0YTkxNjQyZTM4Yzc3Y2Rj
N2QyZTVmYzBjCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWJ6bGhnbWt5L3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAxMW0xNS41NjRzCnVzZXIgICAgMG04LjMxMXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjEzMDczNjMwLjIxMjUtMS1mYW5neWlu
ZzFAaHVhd2VpLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

