Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636CCC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363DE20768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363DE20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7kd-0004Jz-9s
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM7jz-0003pG-BN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM7jy-00040s-2i
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:15:27 -0400
Resent-Date: Wed, 08 Apr 2020 06:15:27 -0400
Resent-Message-Id: <E1jM7jy-00040s-2i@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM7jv-0003wV-5y; Wed, 08 Apr 2020 06:15:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586340903; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VP88jR4FJrbsOIiTs98V8YjhtGTLM9vhPcSpq0EuxoOGJ+Bv+1GnxTuKRPGpmsvgpOjxOvFqLnUZfq5KNvj1C2LqAh48XK6HVEFLC7/zRftNt6x9dgAA5Zp+vsIuixyxYEN6EHKfaACaA1lEWW4vgmIolcIc8dqXXuZ6A57DAM4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586340903;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ZJSRmXfgwdnHrbbQOeF/Yy7zpHUKyAc3ddVXS4N/k8c=; 
 b=OrxcOFWyyoRFuAnsv8/0V95HkGgxeHxzLW+FK+SVBKuSZDJYGs2jKJpjDHSYh3lCf6jbF9dZCyTEN8aBbxMjrOVXlZEysyDgOi3gcqi7RTkWeXbXpGftBRECYAad9+JHMfdcySPVWBdvJ/HUILJIkMvWHvMGEzFnBpE2nt/WAt0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586340901691795.3472922101779;
 Wed, 8 Apr 2020 03:15:01 -0700 (PDT)
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections
Message-ID: <158634090023.16886.3594598374674479037@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 8 Apr 2020 03:15:01 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODA5MzA1MS45ODkz
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQK
dGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2Fu
IHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3Jh
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKICBDQyAgICAgIHFlbXUtc3RvcmFnZS1kYWVtb24ubwogIENDICAgICAgY2hhcmRldi9jaGFy
Lm8KICBDQyAgICAgIGNoYXJkZXYvY2hhci1mZC5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9p
by5jOjMyMzY6MjM6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ2JzJyBbLVdlcnJvciwtV3VudXNl
ZC12YXJpYWJsZV0KICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJzID0gY2hpbGQtPmJzOwogICAgICAg
ICAgICAgICAgICAgICAgXgoxIGVycm9yIGdlbmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUt
dGVzdC9zcmMvcnVsZXMubWFrOjY5OiBibG9jay9pby5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1v
ZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWZlMDk1MDZlMTYz
MDQ3MzdhZDg4YTQ3OTMzMGVlZGQwJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNv
ZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLXA4OHduNWQwL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMDgtMDYuMTEuMDAuMTk1
Nzc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZmUwOTUwNmUxNjMwNDczN2Fk
ODhhNDc5MzMwZWVkZDAKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcDg4d241ZDAv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgM201OS4xMDlzCnVzZXIgICAgMG04LjkyOHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDA4MDkzMDUxLjk4OTMtMS12c2Vt
ZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

