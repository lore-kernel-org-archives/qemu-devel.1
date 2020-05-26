Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EA8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BD42073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BD42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWbW-0007B4-7C
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdWb1-0006gj-1E; Tue, 26 May 2020 06:14:07 -0400
Resent-Date: Tue, 26 May 2020 06:14:07 -0400
Resent-Message-Id: <E1jdWb1-0006gj-1E@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdWaz-0002qB-NQ; Tue, 26 May 2020 06:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590488009; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VRZICilr/bFXSxhPzHSzbtg8TB7DVGsvy6dEA5O8384GOjjt57LmsFBQkOSR7Fn+UEniY4+eMT9ra21inzboPdAslr20fDMaOwGuvq/zQy7nPFw1Iuy6BWz21uc3DOr4NcwSzQCC4k7jQC7KOoN4EiGfKebMfpXRf9DOULyXyrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590488009;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=BI0TnidHE5ivNhePN5vBMsGcLlC+q71F/DE3cL+b5cs=; 
 b=dtOBfkDx8fEb2+TDn9PYTodnzvIOUKVscYZ+PJzLYx2WKIU95Wbgu5uf5QbNSFhBKRz/ANxWDqkYwOAH6wVNHBHCZP+Y8eiPwKDCKpgUcoU6FidYhyxmDDMMQL66boAx08QO/6CaaE5kf9LLoazRF8U6nUHIH1fKsnbeXlwpSiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590488007015294.0754729147169;
 Tue, 26 May 2020 03:13:27 -0700 (PDT)
Message-ID: <159048800574.9494.1236286537485889908@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Tue, 26 May 2020 03:13:27 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:17:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwNDI5OTAxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBjaGFyZGV2L2NoYXIt
cmluZ2J1Zi5vCiAgQ0MgICAgICBjaGFyZGV2L2NoYXItc2VyaWFsLm8KL3RtcC9xZW11LXRlc3Qv
c3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2dldF9ob3N0X29m
ZnNldCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDczOjE5OiBl
cnJvcjogJ2V4cGVjdGVkX3R5cGUnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBm
dW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICB9IGVsc2UgaWYg
KHR5cGUgIT0gZXhwZWN0ZWRfdHlwZSkgewogICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUt
dGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0OToyNTogbm90ZTogJ2V4cGVjdGVkX3R5
cGUnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgUUNvdzJTdWJjbHVzdGVyVHlwZSBleHBlY3RlZF90
eXBlLCB0eXBlOwogICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3NToxOTogZXJyb3I6ICdjaGVja19vZmZzZXQnIG1heSBi
ZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmlu
aXRpYWxpemVkXQogICAgICAgICB9IGVsc2UgaWYgKGNoZWNrX29mZnNldCkgewogICAgICAgICAg
ICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0Nzox
MDogbm90ZTogJ2NoZWNrX29mZnNldCcgd2FzIGRlY2xhcmVkIGhlcmUKICAgICBib29sIGNoZWNr
X29mZnNldDsKICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0
ZXIuYzo0NzY6Mjk6IGVycm9yOiAnZXhwZWN0ZWRfb2Zmc2V0JyBtYXkgYmUgdXNlZCB1bmluaXRp
YWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAg
ICAgICAgICAgIGV4cGVjdGVkX29mZnNldCArPSBzLT5jbHVzdGVyX3NpemU7CiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rl
ci5jOjQ0ODoxNDogbm90ZTogJ2V4cGVjdGVkX29mZnNldCcgd2FzIGRlY2xhcmVkIGhlcmUKICAg
ICB1aW50NjRfdCBleHBlY3RlZF9vZmZzZXQ7CiAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogW2Jsb2NrL3Fjb3cyLWNsdXN0
ZXIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgog
IENDICAgICAgY2hhcmRldi9jaGFyLXNvY2tldC5vClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2Fs
bCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTVhNjkxMzJj
MmU4OTQ5YzlhMWY4MDc1NDA4YzdjOTBiJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWhrMGdrM3N5L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjYtMDYuMTEuNTMuMzAyNjk6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTVhNjkxMzJjMmU4OTQ5YzlhMWY4MDc1NDA4
YzdjOTBiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWhrMGdrM3N5L3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAx
bTMyLjQzMHMKdXNlciAgICAwbTcuODE2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU5MDQyOTkwMS5naXQuYmVydG9AaWdhbGlh
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

