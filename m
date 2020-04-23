Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBEC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227C020724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227C020724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkLT-0008In-RJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRkKR-0007dN-Gl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRkKP-0002Jx-Vb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:28:18 -0400
Resent-Date: Thu, 23 Apr 2020 18:28:18 -0400
Resent-Message-Id: <E1jRkKP-0002Jx-Vb@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRkKP-00027M-Af; Thu, 23 Apr 2020 18:28:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587680890; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lyXdpUHVcwzhe8dnHES0dw0df44xCmvrFqAPCC1m5WlaVlKwQIxFvEiWxwmo2izjoASWs3s1X9BC9P1tC4ckL2OUCtYbt/kNYB0AmGCLCLAFna6/4uzvLar45v5OQ/E5+X7jFl2ljqy6EcSsAP6wObogpQIRfi4w0kHi5+7BB9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587680890;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EiLxSjIy1XkBYcLdKx9/2vS7TM6CgxCQL6g/vG+nOwc=; 
 b=kPSLfbS3oeMGWA902IbztdvRsBuYVSaeYV78HoZXsjJHp0qcsk/sc+sKot1doXhqqDL84aIT99/wdoLW0R5+b2nKfXMuV4UlFmmGXeLg33fAxnjY8WDqXsz7Vts0ar+M8GDfd2SPlbwRjgoPv1uq5SbEmhuRQkAYhheWyYaIcRc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587680887576812.2974059021717;
 Thu, 23 Apr 2020 15:28:07 -0700 (PDT)
In-Reply-To: <20200423221707.477404-1-eblake@redhat.com>
Subject: Re: [PATCH v2 0/3] qcow2: Allow resize of images with internal
 snapshots
Message-ID: <158768088631.10590.10570101292453550828@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Thu, 23 Apr 2020 15:28:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 18:28:14
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzIyMTcwNy40Nzc0
MDQtMS1lYmxha2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
Q0MgICAgICBibG9jay9xY293Mi1jbHVzdGVyLm8KICBDQyAgICAgIGJsb2NrL3Fjb3cyLXNuYXBz
aG90Lm8KICBDQyAgICAgIGJsb2NrL3Fjb3cyLWNhY2hlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Js
b2NrL3Fjb3cuYzo4NTQ6OTogZXJyb3I6IHZhcmlhYmxlICdyZXQnIGlzIHVzZWQgdW5pbml0aWFs
aXplZCB3aGVuZXZlciAnaWYnIGNvbmRpdGlvbiBpcyB0cnVlIFstV2Vycm9yLC1Xc29tZXRpbWVz
LXVuaW5pdGlhbGl6ZWRdCiAgICBpZiAoIXFjb3dfYmxrKSB7CiAgICAgICAgXn5+fn5+fn5+Ci90
bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293LmM6OTMzOjEyOiBub3RlOiB1bmluaXRpYWxpemVk
IHVzZSBvY2N1cnMgaGVyZQotLS0KICAgICAgICAgICBeCiAgICAgICAgICAgID0gMAoxIGVycm9y
IGdlbmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBi
bG9jay9xY293Lm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6MzQwOTo5OiBlcnJvcjogdmFy
aWFibGUgJ3JldCcgaXMgdXNlZCB1bmluaXRpYWxpemVkIHdoZW5ldmVyICdpZicgY29uZGl0aW9u
IGlzIHRydWUgWy1XZXJyb3IsLVdzb21ldGltZXMtdW5pbml0aWFsaXplZF0KICAgIGlmICghYmxr
KSB7CiAgICAgICAgXn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzozNTc0OjEy
OiBub3RlOiB1bmluaXRpYWxpemVkIHVzZSBvY2N1cnMgaGVyZQotLS0KICAgICAgICAgICBeCiAg
ICAgICAgICAgID0gMAoxIGVycm9yIGdlbmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVz
dC9zcmMvcnVsZXMubWFrOjY5OiBibG9jay9xY293Mi5vXSBFcnJvciAxClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBs
aW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBD
YWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NF
cnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcs
ICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWRkMDg3ZWY3MzUzODQ0YmNiNjA0ZGZhNDdjNmIwOTYz
JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywg
Jy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFf
Q09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9
JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAv
Y2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLV8wdWRkM252L3Ny
Yy9kb2NrZXItc3JjLjIwMjAtMDQtMjMtMTguMjQuMDUuMTc2ODY6L3Zhci90bXAvcWVtdTp6LHJv
JywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9ZGQwODdlZjczNTM4NDRiY2I2MDRkZmE0N2M2YjA5NjMKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtXzB1ZGQzbnYvc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM201OS45MDhzCnVzZXIg
ICAgMG04LjQ1MXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNDIzMjIxNzA3LjQ3NzQwNC0xLWVibGFrZUByZWRoYXQuY29tL3Rlc3Rp
bmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

