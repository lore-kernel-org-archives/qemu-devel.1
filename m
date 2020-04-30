Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B4C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B047220774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B047220774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUGDx-0001YR-Ny
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUGB0-000745-J2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUGAz-00083C-Bf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:52:58 -0400
Resent-Date: Thu, 30 Apr 2020 16:52:58 -0400
Resent-Message-Id: <E1jUGAz-00083C-Bf@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUGAt-0007qr-I0; Thu, 30 Apr 2020 16:52:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588279884; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OJw/5DxWRyxzCT7j3fwxlpPxkeveM/5wvJw996+oJD9z32n0UxZC+kh5TLCVuGmvp92oZwSkFa0W8H4z3CVcUIcAG7VSeP7oVv1Zqa3VVBlJW4LfEBYD6rgFFeQJQ0bqPdXmOuVXNOdu1oH69h9MNrrrQ9vcHepGkFwgpsVdjLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588279884;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qDSSs6GbHry03J83vfCspSvRShLZb2uC2JpAfCFksgc=; 
 b=KjlleqdZag34TpaoTFRo3wZHHbaz5hO45xQZ7tEb9jfCxjUYAxxGTK91XQupv9R8gNF+z9SrV46299eZOF+GYysVrTtqBREv1Tz7EeQCTvwGznxX7YM4+F9+tN1nhkk1udBek6g3Bv04FRyQoBJosjNF45VtVA6F7v1IOJTvdtA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588279882690409.44598464492344;
 Thu, 30 Apr 2020 13:51:22 -0700 (PDT)
Message-ID: <158827987994.4471.17266156514265064982@45ef0f9c86ae>
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 00/17] 64bit block-layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Thu, 30 Apr 2020 13:51:22 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 16:09:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, pbonzini@redhat.com,
 integration@gluster.org, berto@igalia.com, ronniesahlberg@gmail.com,
 qemu-block@nongnu.org, sw@weilnetz.de, stefanha@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQzMDExMTAzMy4yOTk4
MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdGVz
dHMvdGVzdC10aW1lZC1hdmVyYWdlLm8KICBDQyAgICAgIHRlc3RzL3Rlc3QtdXRpbC1maWxlbW9u
aXRvci5vCiAgQ0MgICAgICB0ZXN0cy90ZXN0LXV0aWwtc29ja2V0cy5vCi90bXAvcWVtdS10ZXN0
L3NyYy90ZXN0cy90ZXN0LWJsb2NrLWlvdGhyZWFkLmM6Nzk6NTogZXJyb3I6IGluaXRpYWxpemF0
aW9uIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdlcnJvcl0KICAgICAuYmRydl9j
b19wZGlzY2FyZCAgICAgICA9IGJkcnZfdGVzdF9jb19wZGlzY2FyZCwKICAgICBeCi90bXAvcWVt
dS10ZXN0L3NyYy90ZXN0cy90ZXN0LWJsb2NrLWlvdGhyZWFkLmM6Nzk6NTogZXJyb3I6IChuZWFy
IGluaXRpYWxpemF0aW9uIGZvciAnYmRydl90ZXN0LmJkcnZfY29fcGRpc2NhcmQnKSBbLVdlcnJv
cl0KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKICBDQyAgICAgIHRl
c3RzL3Rlc3QtYXV0aHotc2ltcGxlLm8KbWFrZTogKioqIFt0ZXN0cy90ZXN0LWJsb2NrLWlvdGhy
ZWFkLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9NDJkZjM3OTliNTA3NGI4MmE4YTRiNjk2Y2I3NjU0N2YnLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEn
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC10OXE4Y2VuZi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0
LTMwLTE2LjQ3LjQyLjYwMzQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTQy
ZGYzNzk5YjUwNzRiODJhOGE0YjY5NmNiNzY1NDdmCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLXQ5cThjZW5mL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2Vu
dG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTM4Ljk2M3MKdXNlciAgICAwbTkuNDQxcwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MzAx
MTEwMzMuMjk5ODAtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItcXVp
Y2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

