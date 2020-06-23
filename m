Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC33C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31B32098B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31B32098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsGo-0006DH-8O
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnsGE-0005jz-7c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:23:26 -0400
Resent-Date: Tue, 23 Jun 2020 19:23:26 -0400
Resent-Message-Id: <E1jnsGE-0005jz-7c@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnsGB-0004OI-QL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592954593; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WF/5J9ai1/ZUhNBZO7PBSWB09tvYRAVoc1q4kcGPzYQVGtiPBev2D+6ZBw2HzMSEjm+0dDO07ChrN7oKOVWhS4yFbj4GRK96yM91KzyVwjngEo2b1MPh03pmUtl7Pw3jp21FvuB4UOnkYtuxTGVu48X4eKNGuAJg6/6npX1Gp10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592954593;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GCCyV/a3m0z8D5iR1CscHagRoi+zbNuZnwpQgsKV1PI=; 
 b=GywVYdE2JBQ6UYmf3EjKQYfaT4jiW9d7wVRlX7aIDh0Xo837AWkmC6YusYpqGQZ3m3olRWjXibdZ5jRC4ZOBOZrwBOFhVjyLGScX6r8lDogJgag8TENkXNa3p5XUSkulAG2ysb0lEW7lOI9PJ/tx66/2iFsk7XPfHH0qSHOY8UY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159295459033385.77043038554234;
 Tue, 23 Jun 2020 16:23:10 -0700 (PDT)
Message-ID: <159295458868.6613.7707534523153132348@d1fd068a5071>
Subject: Re: [PATCH] i386: Mask SVM features if nested SVM is disabled
In-Reply-To: <20200623230116.277409-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Tue, 23 Jun 2020 16:23:10 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 19:23:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: yfu@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, babu.moger@amd.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyMzIzMDExNi4yNzc0
MDktMS1laGFia29zdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDE4NAogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC90ZXN0
LXg4Ni1jcHVpZC1jb21wYXQKICBURVNUICAgIGlvdGVzdC1xY293MjogMTg2CnFlbXUtc3lzdGVt
LXg4Nl82NDogd2FybmluZzogVGhpcyBmZWF0dXJlIGRlcGVuZHMgb24gb3RoZXIgZmVhdHVyZXMg
dGhhdCB3ZXJlIG5vdCByZXF1ZXN0ZWQ6IENQVUlELjgwMDAwMDBBSDpFRFgubnB0IFtiaXQgMF0K
KioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L3Rlc3QteDg2LWNwdWlkLWNv
bXBhdC5jOjY0OnRlc3RfY3B1aWRfcHJvcDogYXNzZXJ0aW9uIGZhaWxlZCAodmFsID09IGFyZ3Mt
PmV4cGVjdGVkX3ZhbHVlKTogKDAgPT0gMjE0NzQ4MzY1OCkKRVJST1IgLSBCYWlsIG91dCEgRVJS
T1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L3Rlc3QteDg2LWNwdWlkLWNvbXBhdC5j
OjY0OnRlc3RfY3B1aWRfcHJvcDogYXNzZXJ0aW9uIGZhaWxlZCAodmFsID09IGFyZ3MtPmV4cGVj
dGVkX3ZhbHVlKTogKDAgPT0gMjE0NzQ4MzY1OCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZf
NjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBU
RVNUICAgIGlvdGVzdC1xY293MjogMTg3CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE5MAotLS0K
ICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2Fs
bGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bics
ICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MmE1NWM0NGRjNTRkNDBhNDkzOGY4
NDg3MzAzZjZkYmEnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVu
Y29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09O
RklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9Jywg
Jy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAn
LXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbmFhYWdsbDYvc3Jj
L2RvY2tlci1zcmMuMjAyMC0wNi0yMy0xOS4wNy40My42MTAyOi92YXIvdG1wL3FlbXU6eixybycs
ICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFl
bXUuaW5zdGFuY2UudXVpZD0yYTU1YzQ0ZGM1NGQ0MGE0OTM4Zjg0ODczMDNmNmRiYQptYWtlWzFd
OiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1uYWFhZ2xsNi9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTVtMjUuMTIxcwp1c2Vy
ICAgIDBtOC41MTVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDYyMzIzMDExNi4yNzc0MDktMS1laGFia29zdEByZWRoYXQuY29tL3Rl
c3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

