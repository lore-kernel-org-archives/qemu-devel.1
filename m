Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0055C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC7320869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC7320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRDl-0001aY-NM
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSRCd-0000lS-1a
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSRCb-0006HL-Hd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:42:50 -0500
Resent-Date: Wed, 06 Nov 2019 14:42:50 -0500
Resent-Message-Id: <E1iSRCb-0006HL-Hd@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSRCb-0006FL-6R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:42:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573069357; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H7qGQjx+VimgH3S/8AZb6pnoFhKDEed5wbytB+3k518G3jsZmI+HSCQC13TyuQT2WFkv+pDYtedn8q2CtIMk6fJld5blveZCFhXecrO2TJGQRrvTz0xl0cjTOqNiVl2W6lMsCPVR7G2nf2Pjk/PAdGX4MldMNC7NXBsHHMawLkA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573069357;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=v2UpgyE2+YYscjl2gcyBw9GUYcembQaBodnIdv9Gk6c=; 
 b=ey1BS5CAxx7cCcOwtfwqBOZxsIye78IyZkD8Y06LidAxx5BZEZWLhjE1Dz7qWgyvDLWevRHYYl+x6PDzbs1T6OwdIKj4m+JURToe1815gSVnw8deqG4OkFzDd4RSGvC5mhUjXJv27yMSFKor2C4b9miHn93Gabdt0C3bTuwS80o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573069354810998.9838691273121;
 Wed, 6 Nov 2019 11:42:34 -0800 (PST)
In-Reply-To: <20191106122524.5537-1-kraxel@redhat.com>
Subject: Re: [PULL 0/1] Seabios 20191106 patches
Message-ID: <157306935384.21358.7983455798091099758@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 6 Nov 2019 11:42:34 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNjEyMjUyNC41NTM3
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKUGFzc2VkIGFsbCAxMDggaW90ZXN0
cwogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVzdHMvcW9zLXRlc3QKKioKRVJST1I6
L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL2Jvb3Qtc2VjdG9yLmM6MTYxOmJvb3Rfc2VjdG9yX3Rl
c3Q6IGFzc2VydGlvbiBmYWlsZWQgKHNpZ25hdHVyZSA9PSBTSUdOQVRVUkUpOiAoMHgwMDAwMDAw
MCA9PSAweDAwMDBkZWFkKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9z
cmMvdGVzdHMvYm9vdC1zZWN0b3IuYzoxNjE6Ym9vdF9zZWN0b3JfdGVzdDogYXNzZXJ0aW9uIGZh
aWxlZCAoc2lnbmF0dXJlID09IFNJR05BVFVSRSk6ICgweDAwMDAwMDAwID09IDB4MDAwMGRlYWQp
Cm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxClRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5l
IDY2MiwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTk0ZmE3ZTIwNzhkODQ5MDhhOWY5YTdmMmY0NDJjNDM0Jywg
Jy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYn
LCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXF5NjB2ODA1L3NyYy9kb2NrZXItc3JjLjIw
MTktMTEtMDYtMTQuMjguMzAuMjk0MTc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9z
NycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJv
IGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51
dWlkPTk0ZmE3ZTIwNzhkODQ5MDhhOWY5YTdmMmY0NDJjNDM0Cm1ha2VbMV06ICoqKiBbZG9ja2Vy
LXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLXF5NjB2ODA1L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVp
Y2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNG00LjA1NHMKdXNlciAgICAwbTguNTEzcwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTExMDYxMjI1MjQuNTUzNy0xLWtyYXhlbEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNr
QGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


