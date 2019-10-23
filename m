Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE46CA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1422084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1422084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNB3s-0006Fj-3R
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 03:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNB2q-0004zG-Sh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNB2o-00089b-Gu
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:27:00 -0400
Resent-Date: Wed, 23 Oct 2019 03:26:59 -0400
Resent-Message-Id: <E1iNB2o-00089b-Gu@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNB2n-00086f-0H
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571815601; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=egtO4tVcp8vOnX6se1YrJUb1z5LzG4C1TbkwSlRc+3i/dgvLQB/aDxcZ+GqUxBLXFpk8XIdwYQSHtieAOv6h+9OekI52KiWPX0vSKRbVIiVNpyb/dQuRQT8aTbSnMmsK7cQ13IN6faEKPmtEmE+Cqxhu6g5XMFRvsY6D6y8HBDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571815601;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2vIi7KbdAUGJgjb+0stC0CMAwfjg4j8Ajh+7c9aazi0=; 
 b=ZLmURoUR7bUgnicmGrQCuQVR0GxzjF7uwUV1gf9lqWxquKRAfnCINe8CmD4tVyyqmQuf+xs9CPyO589yfVBmj7IO+GItKr+g3LWcP+pot2imUEx++Mxaf/aM6/2hC2pSO/l/flMssW2mFJqpQl/8dT+Rb59fPb+Vfm+14166C58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157181559822329.243253347145924;
 Wed, 23 Oct 2019 00:26:38 -0700 (PDT)
In-Reply-To: <20191022155413.4619-1-svens@stackframe.org>
Subject: Re: [PATCH v2] net: add tulip (dec21143) driver
Message-ID: <157181559694.14240.6820797679763891500@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: svens@stackframe.org
Date: Wed, 23 Oct 2019 00:26:38 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, svens@stackframe.org,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMjE1NTQxMy40NjE5
LTEtc3ZlbnNAc3RhY2tmcmFtZS5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3
L3BjaS1icmlkZ2UvcGNpZV9wY2lfYnJpZGdlLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAv
cWVtdS10ZXN0L3NyYy9ody9uZXQvdHVsaXAuYzoxMDoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25l
dC90dWxpcC5jOiBJbiBmdW5jdGlvbiAndHVsaXBfcmVhZCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9o
dy9uZXQvdHVsaXAuYzo1NDQ6NDQ6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0cyBhcmd1bWVu
dCBvZiB0eXBlICdsb25nIHVuc2lnbmVkIGludCcsIGJ1dCBhcmd1bWVudCAzIGhhcyB0eXBlICdo
d2FkZHInIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9XQog
ICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICIlczogcmVhZCBhY2Nl
c3MgYWRkIHVua25vd24gYWRkcmVzcyIKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAg
ICAgICAgICAgIiAlbHhcbiIsIF9fZnVuY19fLCBhZGRyKTsKLS0tCiAgICAgICAgICAgICAgICAg
ICAlbGx4CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L3R1
bGlwLmM6MTA6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9uZXQvdHVsaXAuYzogSW4gZnVuY3Rpb24g
J3R1bGlwX3dyaXRlJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC90dWxpcC5jOjgzMzo0MDog
ZXJyb3I6IGZvcm1hdCAnJWx4JyBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgdW5zaWdu
ZWQgaW50JywgYnV0IGFyZ3VtZW50IDMgaGFzIHR5cGUgJ2h3YWRkcicge2FrYSAnbG9uZyBsb25n
IHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgICAgIHFlbXVfbG9nX21hc2so
TE9HX0dVRVNUX0VSUk9SLCAiJXM6IHdyaXRlIHRvIENTUiBhdCB1bmtub3duIGFkZHJlc3MgIgog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAgICAgICAiMHglbHhcbiIsIF9fZnVuY19f
LCBhZGRyKTsKLS0tCiAgICAgICAgICAgICAgICAgICAgfn5eCiAgICAgICAgICAgICAgICAgICAg
JWxseApjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiog
Wy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L25ldC90dWxpcC5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBody9w
Y2ktYnJpZGdlL3BjaV9leHBhbmRlcl9icmlkZ2UubwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkK
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdk
b2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1hNWQ3NjFk
MmRmYWI0MDZlYTUzMDQyZjU0MmI0YjZmYycsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0
JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICct
ZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICct
ZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
dXQzOGJpbDgvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0yMy0wMy4yNC4wOS40MjE2Oi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1p
bmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWE1ZDc2MWQyZGZhYjQwNmVhNTMwNDJmNTQyYjRi
NmZjCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXV0MzhiaWw4L3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtMjgu
NDI2cwp1c2VyICAgIDBtNy45NDZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyMjE1NTQxMy40NjE5LTEtc3ZlbnNAc3RhY2tmcmFt
ZS5vcmcvdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


