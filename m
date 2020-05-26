Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B78C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DD0207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DD0207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSsF-0003Lz-Qf
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdSrg-0002on-E0; Tue, 26 May 2020 02:15:04 -0400
Resent-Date: Tue, 26 May 2020 02:15:04 -0400
Resent-Message-Id: <E1jdSrg-0002on-E0@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdSre-00011d-PS; Tue, 26 May 2020 02:15:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590473668; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dCOv8Q3GN6LF0m8MCu3IccQk8htSCk7eRnRbUOq9ZX1MS/JGR2cq5f4uv+wE+/eS1VAnD/T5nSkNhg8YOlazmviEHXmR2GtPkw8+3vnPzfhWyLbrGErtpFYhHymcPclJXdyy+NHv4Jv4f5gaTu4Qg3pXb/fxZJgdkrpSeoYZfUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590473668;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=BcflA/QwJOcTdua30BHP2iAEuiRsG9WSaNBmZbDEqGg=; 
 b=LD78jPNcwdNbrsOTrrFeCtnK0rcm+zdpQ9aDzgNqDn7sKjh4ftgkaVa/1EqwWL4ION3BHPSYCYS1o7XapQcFanGqvGaaHiRDMX76qv5IvVuHSrbQUwyA/PYcPJ70mRkX56IvVtt9W1NZuD+AmxsaURKULCPGLFkXOdKjfRmE6Ks=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590473666703875.3450362572063;
 Mon, 25 May 2020 23:14:26 -0700 (PDT)
Message-ID: <159047366532.7716.2948522571327652780@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Mon, 25 May 2020 23:14:26 -0700 (PDT)
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
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBjcnlwdG8vaG1hYy5v
CiAgQ0MgICAgICBjcnlwdG8vaG1hYy1uZXR0bGUubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cWNvdzItY2x1c3Rlci5jOiBJbiBmdW5jdGlvbiAncWNvdzJfZ2V0X2hvc3Rfb2Zmc2V0JzoKL3Rt
cC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NzM6MTk6IGVycm9yOiAnZXhw
ZWN0ZWRfdHlwZScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgIH0gZWxzZSBpZiAodHlwZSAhPSBl
eHBlY3RlZF90eXBlKSB7CiAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9i
bG9jay9xY293Mi1jbHVzdGVyLmM6NDQ5OjI1OiBub3RlOiAnZXhwZWN0ZWRfdHlwZScgd2FzIGRl
Y2xhcmVkIGhlcmUKICAgICBRQ293MlN1YmNsdXN0ZXJUeXBlIGV4cGVjdGVkX3R5cGUsIHR5cGU7
CiAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293
Mi1jbHVzdGVyLmM6NDc1OjE5OiBlcnJvcjogJ2NoZWNrX29mZnNldCcgbWF5IGJlIHVzZWQgdW5p
bml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRd
CiAgICAgICAgIH0gZWxzZSBpZiAoY2hlY2tfb2Zmc2V0KSB7CiAgICAgICAgICAgICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ3OjEwOiBub3RlOiAn
Y2hlY2tfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIGJvb2wgY2hlY2tfb2Zmc2V0Owog
ICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3Njoy
OTogZXJyb3I6ICdleHBlY3RlZF9vZmZzZXQnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4g
dGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICAgICAg
ZXhwZWN0ZWRfb2Zmc2V0ICs9IHMtPmNsdXN0ZXJfc2l6ZTsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ4OjE0
OiBub3RlOiAnZXhwZWN0ZWRfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIHVpbnQ2NF90
IGV4cGVjdGVkX29mZnNldDsKICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5n
IHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbYmxvY2svcWNvdzItY2x1c3Rlci5vXSBFcnJv
ciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAo
bW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHki
LCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3Io
cmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydz
dWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPTBlZTEwYWEzYTBjMzQ5NzBhMzdmZTQyY2M0YjIzNTk5JywgJy11JywgJzEwMDMnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFS
R0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICct
ZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0ND
QUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9x
ZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLTdlcTVxc3h1L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjYtMDIuMTIu
MjQuMjY1MDY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTBlZTEwYWEzYTBj
MzQ5NzBhMzdmZTQyY2M0YjIzNTk5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTdl
cTVxc3h1L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJy
b3IgMgoKcmVhbCAgICAybTEuNTI3cwp1c2VyICAgIDBtNy45MDZzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTkwNDI5OTAxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

