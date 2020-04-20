Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A9CC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 23:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2009E207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 23:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2009E207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQgB7-0008Va-8r
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 19:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jQgAY-000821-Mt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jQgAY-00059L-B1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:49:42 -0400
Resent-Date: Mon, 20 Apr 2020 19:49:42 -0400
Resent-Message-Id: <E1jQgAY-00059L-B1@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jQgAW-00057p-4H; Mon, 20 Apr 2020 19:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587426546; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UggKtWXbTYJi4GgnhAWV2d9G0TFthGV3IrJhG/cczlr3bo8bUnka4TInJnkEoDJRRWtBaPTnwTJCEeEcGJs8YaI1lF4ic72Z9GjkicwSxcXFHIejPaMBS/haj/IC0CxdI3iMcBO35w0nfGVXG5KK+TlIqHXDfctxG6DMTUu75O4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587426546;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mfHBStasfExHsv/vwgtOMn3LVgUvA8PUzZ4s75axtRs=; 
 b=HTe9qgWOs3uEBZmciHktA4TNlpfHtksBGFFDWoDMWIfdWEUqp3P+CP1UVXmcbhHqoEx7uEddgWAXXJZ4FACcG353xjymzyVODPPxd4B4SwsZDpbJyQ5h+ilDvOHoxsLqpQ5oC31og8QBSS0VDcCJUdD0kAELohd8fg6UWlqcZlA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587426545395395.20321391065784;
 Mon, 20 Apr 2020 16:49:05 -0700 (PDT)
In-Reply-To: <20200420133214.28921-1-kwolf@redhat.com>
Subject: Re: [PATCH v4 0/9] block: Fix resize (extending) of short overlays
Message-ID: <158742654412.13510.12104845467135175749@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Mon, 20 Apr 2020 16:49:05 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 19:49:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMDEzMzIxNC4yODky
MS0xLWt3b2xmQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJsb2Nr
L2RpcnR5LWJpdG1hcC5vCiAgQ0MgICAgICBibG9jay93cml0ZS10aHJlc2hvbGQubwogIENDICAg
ICAgYmxvY2svYmFja3VwLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2ZpbGUtd2luMzIuYzo2
NDc6Mjc6IGVycm9yOiBpbml0aWFsaXphdGlvbiBvZiAnaW50ICgqKShCbG9ja0RyaXZlclN0YXRl
ICosIGludDY0X3QsICBfQm9vbCwgIFByZWFsbG9jTW9kZSwgIEJkcnZSZXF1ZXN0RmxhZ3MsICBF
cnJvciAqKiknIHtha2EgJ2ludCAoKikoc3RydWN0IEJsb2NrRHJpdmVyU3RhdGUgKiwgbG9uZyBs
b25nIGludCwgIF9Cb29sLCAgZW51bSBQcmVhbGxvY01vZGUsICBlbnVtIDxhbm9ueW1vdXM+LCAg
c3RydWN0IEVycm9yICoqKSd9IGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSAnaW50ICgq
KShCbG9ja0RyaXZlclN0YXRlICosIGludDY0X3QsICBfQm9vbCwgIFByZWFsbG9jTW9kZSwgIEVy
cm9yICoqKScge2FrYSAnaW50ICgqKShzdHJ1Y3QgQmxvY2tEcml2ZXJTdGF0ZSAqLCBsb25nIGxv
bmcgaW50LCAgX0Jvb2wsICBlbnVtIFByZWFsbG9jTW9kZSwgIHN0cnVjdCBFcnJvciAqKiknfSBb
LVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICAgICAuYmRydl9jb190cnVuY2F0
ZSAgID0gcmF3X2NvX3RydW5jYXRlLAogICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2ZpbGUtd2luMzIuYzo2NDc6Mjc6IG5v
dGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciAnYmRydl9maWxlLmJkcnZfY29fdHJ1bmNhdGUn
KQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90
bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL2ZpbGUtd2luMzIub10gRXJyb3Ig
MQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5Iiwg
bGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD02NzA5MmRlODUwZDc0MGUwOTljNzJhMjcxNjU5MmUxMCcsICctdScsICcxMDAxJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNI
RV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUt
ZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtZG5haTdicWUvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0yMC0xOS40Ni4yMy41
MjA0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTY3MDkyZGU4NTBkNzQwZTA5
OWM3MmEyNzE2NTkyZTEwCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWRuYWk3YnFl
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpy
ZWFsICAgIDJtNDIuNDUwcwp1c2VyICAgIDBtOS4wODBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQyMDEzMzIxNC4yODkyMS0xLWt3
b2xmQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

