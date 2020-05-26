Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2D620663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2D620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUbN-0002dj-LG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdUXB-0004RH-4i; Tue, 26 May 2020 04:02:01 -0400
Resent-Date: Tue, 26 May 2020 04:02:01 -0400
Resent-Message-Id: <E1jdUXB-0004RH-4i@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdUX9-0003uG-8R; Tue, 26 May 2020 04:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590480081; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XmXq7RAo2ppFathmAZ9VT6r3A1+EvqDnF3kmJ25/41DAVySJkde/AwjxEIWrW3eSh73BnccbNjPTPHxqwRF8yYEIWwJo0gXQ0mHsTrVdEm8tGJqGVHxqhYyKMnjOv+1FGWgctcLZLqMtRNl9sS5r0DKFKd7mZMFZW2HPl9xHZwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590480081;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6yU1K5yi4PXn/bAEEOX/zYjBwTqTWnhWpfX2RJR29i0=; 
 b=AS8XJBpxOk97tMZPngiIFGEKk8zTjMGGAgFfZ6fDkb6CdU1zQm5T3J/MhLJ+IxaZ51YJQKN7XPuOtH5pf8VCNggdP2j+qL7IM/B068x9XIZpuThdiqtWD7FS3FR4QHdMIzHH9jy12qf2yuZBuqOkWD6WvWIMOANcK41Q2ss+ZP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590480078839733.2454656612559;
 Tue, 26 May 2020 01:01:18 -0700 (PDT)
Message-ID: <159048007747.8305.13096425178050944933@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Tue, 26 May 2020 01:01:18 -0700 (PDT)
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
bnVsbC5vCiAgQ0MgICAgICBjaGFyZGV2L2NoYXItcGFyYWxsZWwubwovdG1wL3FlbXUtdGVzdC9z
cmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOiBJbiBmdW5jdGlvbiAncWNvdzJfZ2V0X2hvc3Rfb2Zm
c2V0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NzM6MTk6IGVy
cm9yOiAnZXhwZWN0ZWRfdHlwZScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1
bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgIH0gZWxzZSBpZiAo
dHlwZSAhPSBleHBlY3RlZF90eXBlKSB7CiAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10
ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ5OjI1OiBub3RlOiAnZXhwZWN0ZWRfdHlw
ZScgd2FzIGRlY2xhcmVkIGhlcmUKICAgICBRQ293MlN1YmNsdXN0ZXJUeXBlIGV4cGVjdGVkX3R5
cGUsIHR5cGU7CiAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9i
bG9jay9xY293Mi1jbHVzdGVyLmM6NDc1OjE5OiBlcnJvcjogJ2NoZWNrX29mZnNldCcgbWF5IGJl
IHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5p
dGlhbGl6ZWRdCiAgICAgICAgIH0gZWxzZSBpZiAoY2hlY2tfb2Zmc2V0KSB7CiAgICAgICAgICAg
ICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ3OjEw
OiBub3RlOiAnY2hlY2tfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIGJvb2wgY2hlY2tf
b2Zmc2V0OwogICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rl
ci5jOjQ3NjoyOTogZXJyb3I6ICdleHBlY3RlZF9vZmZzZXQnIG1heSBiZSB1c2VkIHVuaW5pdGlh
bGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAg
ICAgICAgICAgZXhwZWN0ZWRfb2Zmc2V0ICs9IHMtPmNsdXN0ZXJfc2l6ZTsKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVy
LmM6NDQ4OjE0OiBub3RlOiAnZXhwZWN0ZWRfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAg
IHVpbnQ2NF90IGV4cGVjdGVkX29mZnNldDsKICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbYmxvY2svcWNvdzItY2x1c3Rl
ci5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAg
Q0MgICAgICBjaGFyZGV2L2NoYXItcGlwZS5vClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTQ5ZGU2ZjgxMDU2
ZTRkYWRhOGZkY2IyZjM2NDc2ZDBkJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWNj
eTF5M3VnL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjYtMDMuNTkuMDIuMzA2NTA6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1
aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTQ5ZGU2ZjgxMDU2ZTRkYWRhOGZkY2IyZjM2NDc2
ZDBkCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWNjeTF5M3VnL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTE1
LjMxOXMKdXNlciAgICAwbTguMTE2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU5MDQyOTkwMS5naXQuYmVydG9AaWdhbGlhLmNv
bS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

