Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30460C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF752178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF752178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHLc-000142-1l
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSHKi-0000Yo-BC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSHKg-0004lV-R1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:10:31 -0500
Resent-Date: Wed, 06 Nov 2019 04:10:31 -0500
Resent-Message-Id: <E1iSHKg-0004lV-R1@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSHKg-0004lG-J9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:10:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573031421; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JXnZ6WwrHfkV3Tk4U1bS26eB26zsHF+Yuj2/zELFLtbwq7dhT5jdQ/H03nm+AyJFkgPj97kOnXD7WpslS9ZjsluOg7ygsWHemvKxlFpAyL0aGQY8NblFo0iU03YXYsYxv0incTv2+KaZe5TOvYP7+uVdem6WxASozzFLcc26k6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573031421;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rxVJsOIoIYq6RkjPa8AZOoI2jiEiriVYznhSmxwn9Ag=; 
 b=IQo2l+y5/KafIgR8C3RVMIISsOYPSBgSPrbOq8hTa7nr+d1+nYg4/g7A0KzV1TUTaSlhD/ProJZ4euythoyqWd26jYglqaEwwc13KyrirKnQTChyctbDy7Eqw9Mgx4I1BeFQSddsFl/N6oiFyzUclYzO31DxnlloJXYWCZ1n8iA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573031418926467.8655153135511;
 Wed, 6 Nov 2019 01:10:18 -0800 (PST)
In-Reply-To: <20191106082604.9548-1-kraxel@redhat.com>
Subject: Re: [PULL 0/1] Audio 20191106 patches
Message-ID: <157303141800.21358.12660972527449509434@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 6 Nov 2019 01:10:18 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNjA4MjYwNC45NTQ4
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNrLXVuaXQ6
IHRlc3RzL3Rlc3QtdGhyb3R0bGUKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtdGhy
ZWFkLXBvb2wKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0
LmM6OTAzOndhaXRfZm9yX21pZ3JhdGlvbl9mYWlsOiBhc3NlcnRpb24gZmFpbGVkOiAoIXN0cmNt
cChzdGF0dXMsICJzZXR1cCIpIHx8ICFzdHJjbXAoc3RhdHVzLCAiZmFpbGVkIikgfHwgKGFsbG93
X2FjdGl2ZSAmJiAhc3RyY21wKHN0YXR1cywgImFjdGl2ZSIpKSkKRVJST1IgLSBCYWlsIG91dCEg
RVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0LmM6OTAzOndhaXRf
Zm9yX21pZ3JhdGlvbl9mYWlsOiBhc3NlcnRpb24gZmFpbGVkOiAoIXN0cmNtcChzdGF0dXMsICJz
ZXR1cCIpIHx8ICFzdHJjbXAoc3RhdHVzLCAiZmFpbGVkIikgfHwgKGFsbG93X2FjdGl2ZSAmJiAh
c3RyY21wKHN0YXR1cywgImFjdGl2ZSIpKSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVT
VCAgICBpb3Rlc3QtcWNvdzI6IDAxMwogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1o
Yml0bWFwCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1mMjBhYjVmMDA4
ZjQ0OGIxYTVjMzdkZGVhY2YxYTZjMCcsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScs
ICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScs
ICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWg5
X2Vuc3hrL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMDYtMDQuMDAuNDcuMjYzNDY6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1
aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWYyMGFiNWYwMDhmNDQ4YjFhNWMzN2RkZWFjZjFh
NmMwCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWg5X2Vuc3hrL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICA5bTI5
LjEwOXMKdXNlciAgICAwbTguMjg4cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMDYwODI2MDQuOTU0OC0xLWtyYXhlbEByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


