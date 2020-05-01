Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25353C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED94220731
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED94220731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUReG-0004G8-3K
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 05:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jURd2-0003Ie-Qt
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jURYz-0002of-JL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:06:40 -0400
Resent-Date: Fri, 01 May 2020 05:06:40 -0400
Resent-Message-Id: <E1jURYz-0002of-JL@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jURYz-0002ir-1h; Fri, 01 May 2020 05:02:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588323725; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VACEHcCZ842znn2pkSQGYNPB4DKLCwBE4WjIJWHtqpe1KN4FjFtWrGjePue/BY9+Hy6dggb28HzDXyussmpsI5GQE2iN31/Zt19/oC94GgnKgzFp+G6tkdLiuUijQ0fQFendfErDc0qDIOx8Ndw3PADjShY7dgHypVd889gMkrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588323725;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=e4a8/y3JaNC4zP59MJWnaV37GXCFgOK6hZDbcI+7EV0=; 
 b=bItoShB1QuYyYuKFJNtct6kmtn03O7sWgdqZaU8yueI5adv0EJqGawY4iQPA0jZwQUGF4yL4TWDKokJcIsIa0SQyKQ14E4pvU0BsLKENSo5pxQFQ3MIV8R3v+prKCDzHK6wmotuob5fdInlbqYUsGjFSCaB14SHIHmfXqSI//6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588323721284886.3003660819325;
 Fri, 1 May 2020 02:02:01 -0700 (PDT)
Message-ID: <158832371871.4471.4468572517954363608@45ef0f9c86ae>
In-Reply-To: <20200501082806.205696-1-stefanha@redhat.com>
Subject: Re: [PULL 0/4] Block patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Fri, 1 May 2020 02:02:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 02:18:39
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 alex.williamson@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 peter.maydell@linaro.org, quintela@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, armbru@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 kraxel@redhat.com, yuval.shaia.ml@gmail.com, pbonzini@redhat.com,
 mreitz@redhat.com, ronniesahlberg@gmail.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwMTA4MjgwNi4yMDU2
OTYtMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDA3NApzb2NrZXRfYWNjZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5h
dmFpbGFibGUKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVk
OiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3Rz
L3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVN
VSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJP
UiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRl
c3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWls
ZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+PSAwKQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0
LWFhcmNoNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDc5CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA4
MAotLS0KTm90IHJ1bjogMjU5CkZhaWx1cmVzOiAyNDkKRmFpbGVkIDEgb2YgMTE3IGlvdGVzdHMK
bWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQpUcmFjZWJhY2sg
KG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5
IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFp
c2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9j
ZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFi
ZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD01NzcxOGM5NDllYjU0MjE1ODA3YjQ1NzIxMDIx
ZTdlZScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5l
ZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVf
T1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAn
U0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcv
aG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1rY19uN21jcS9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTA1LTAxLTA0LjQwLjQwLjI1OTU5Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD01NzcxOGM5NDllYjU0MjE1ODA3YjQ1NzIxMDIxZTdlZQptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1rY19uN21jcS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMjFtMTguNDgxcwp1c2VyICAgIDBt
MTAuNzU3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAyMDA1MDEwODI4MDYuMjA1Njk2LTEtc3RlZmFuaGFAcmVkaGF0LmNvbS90ZXN0aW5n
LmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

