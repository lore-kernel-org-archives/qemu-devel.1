Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA63C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4262088E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4262088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZKq-0000h5-5r
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdZKL-0000Am-DG; Tue, 26 May 2020 09:09:05 -0400
Resent-Date: Tue, 26 May 2020 09:09:05 -0400
Resent-Message-Id: <E1jdZKL-0000Am-DG@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdZKJ-0001h2-Pw; Tue, 26 May 2020 09:09:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590498501; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JlDjL1gdasWXPXNhOjdYoeaYjXZ8+IzA1AwcdeHt6eo/xqhOLaxO/bSUtrcV+t3p9be+HmayKMgqsqCaneTyX+aMnN7D7LSMozmxQiocUcYgyB1v1qHnbYuhYzeqIl1W6zQg8WPQ+WXDvU9dsslMBMkijxACbCXnBlPXH7BWWUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590498501;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ovEvqKhAETWXKDcRdFArVgHYG4dIo95wZcIhTqDpqBI=; 
 b=XLIXY4cjCft3hKpN7OnpaQecd02scuElmqYVtlkzE5ZY8MMcdh8h1fGesofT6/MXeZCFvTqcV+qqVjofbXLJ850IW+5z0lcLtie2BgOQQQPdeEfLuToAxbVE3LT1wOom1VFAT/4C4rWRV0wxNzNnLflsXWPG0/ZJJ39piusPaHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590498499159620.978204489109;
 Tue, 26 May 2020 06:08:19 -0700 (PDT)
Message-ID: <159049849779.10213.17032116873060530034@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Tue, 26 May 2020 06:08:19 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 09:09:01
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
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBjcnlwdG8veHRzLm8K
ICBDQyAgICAgIGNyeXB0by9ibG9jay5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1j
bHVzdGVyLmM6IEluIGZ1bmN0aW9uICdxY293Ml9nZXRfaG9zdF9vZmZzZXQnOgovdG1wL3FlbXUt
dGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3MzoxOTogZXJyb3I6ICdleHBlY3RlZF90
eXBlJyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9
bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICAgICAgfSBlbHNlIGlmICh0eXBlICE9IGV4cGVjdGVk
X3R5cGUpIHsKICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fj
b3cyLWNsdXN0ZXIuYzo0NDk6MjU6IG5vdGU6ICdleHBlY3RlZF90eXBlJyB3YXMgZGVjbGFyZWQg
aGVyZQogICAgIFFDb3cyU3ViY2x1c3RlclR5cGUgZXhwZWN0ZWRfdHlwZSwgdHlwZTsKICAgICAg
ICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0
ZXIuYzo0NzU6MTk6IGVycm9yOiAnY2hlY2tfb2Zmc2V0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxp
emVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICAg
ICAgfSBlbHNlIGlmIChjaGVja19vZmZzZXQpIHsKICAgICAgICAgICAgICAgICAgIF4KL3RtcC9x
ZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDc6MTA6IG5vdGU6ICdjaGVja19v
ZmZzZXQnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgYm9vbCBjaGVja19vZmZzZXQ7CiAgICAgICAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDc2OjI5OiBlcnJv
cjogJ2V4cGVjdGVkX29mZnNldCcgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1
bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgICAgICBleHBlY3Rl
ZF9vZmZzZXQgKz0gcy0+Y2x1c3Rlcl9zaXplOwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDg6MTQ6IG5vdGU6
ICdleHBlY3RlZF9vZmZzZXQnIHdhcyBkZWNsYXJlZCBoZXJlCi0tLQogICAgICAgICAgICAgIF4K
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKICBDQyAgICAgIGNyeXB0
by9ibG9jay1sdWtzLm8KbWFrZTogKioqIFtibG9jay9xY293Mi1jbHVzdGVyLm9dIEVycm9yIDEK
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGlvL2No
YW5uZWwtYnVmZmVyLm8KICBDQyAgICAgIGNyeXB0by9ibG9jay1xY293Lm8KLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTU2MjUwMjBkNDFlNzRmZjVhYTg2MTNkMzIwMDE1
YzEwJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9o
b21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtY2h5eHd0ZHEvc3JjL2RvY2tlci1z
cmMuMjAyMC0wNS0yNi0wOS4wNS40My43MjAzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNl
bnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD01NjI1MDIwZDQxZTc0ZmY1YWE4NjEzZDMyMDAxNWMxMAptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1jaHl4d3RkcS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMm0zNS43NzBzCnVzZXIgICAgMG00Ljk3
NHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
L2NvdmVyLjE1OTA0Mjk5MDEuZ2l0LmJlcnRvQGlnYWxpYS5jb20vdGVzdGluZy5kb2NrZXItcXVp
Y2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

