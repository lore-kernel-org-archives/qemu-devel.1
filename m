Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382ACC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AAAC2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAAC2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkRt-0003J7-5d
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRkRG-0002Yz-Hz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRkRF-0007vl-3Z
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:35:21 -0400
Resent-Date: Thu, 23 Apr 2020 18:35:21 -0400
Resent-Message-Id: <E1jRkRF-0007vl-3Z@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRkRE-0007kr-Dp; Thu, 23 Apr 2020 18:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587681312; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EXy+4sI3kBBJ7j0GPmUHyk4dJ1Z/VB2P8k/NRsmVYKS8pAyBcZgKJDkjhwk/pyZKozHPtsnE7G5pRdT1RkX0hTerkhKekWp2nMUa3kDOrifxX5KfycT92GJFDhlyCTA9/pARslN1VVjaryJ1/L9zxrO+/3UbW0BAYZIl01oAaMA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587681312;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rRUbm2iCt/ZEE1LViT4i/MHMLpodgOo8MYLfB4cvsYY=; 
 b=RSjcgw33jTAq80QOQN5Y/+vIDiNAPBrl+RI6luQL6TvDOlrGdY1jL5euuxaEDU4hRnNQkYS9pnA/PEoJ0v4VSFa4IbZie3NbUv3SpUjvRN2CKVmexiUyNvo/1ZK5cVTRs8WfDjGfpnyD/vQ6l6k8DBcjaSUxO4ijQTtSQt6f2uM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587681311504859.4920531263142;
 Thu, 23 Apr 2020 15:35:11 -0700 (PDT)
In-Reply-To: <20200423221707.477404-1-eblake@redhat.com>
Subject: Re: [PATCH v2 0/3] qcow2: Allow resize of images with internal
 snapshots
Message-ID: <158768131037.10590.793180427395960651@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Thu, 23 Apr 2020 15:35:11 -0700 (PDT)
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
MDQtMS1lYmxha2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYmxv
Y2svYmxrbG9nd3JpdGVzLm8KICBDQyAgICAgIGJsb2NrL2Jsb2NrLWJhY2tlbmQubwovdG1wL3Fl
bXUtdGVzdC9zcmMvYmxvY2svcWNvdy5jOiBJbiBmdW5jdGlvbiAncWNvd19jb19jcmVhdGUnOgov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdy5jOjkzMzoxMjogZXJyb3I6ICdyZXQnIG1heSBi
ZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmlu
aXRpYWxpemVkXQogICAgIHJldHVybiByZXQ7CiAgICAgICAgICAgIF5+fgpjYzE6IGFsbCB3YXJu
aW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3Ny
Yy9ydWxlcy5tYWs6Njk6IGJsb2NrL3Fjb3cub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzog
SW4gZnVuY3Rpb24gJ3Fjb3cyX2NvX2NyZWF0ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9x
Y293Mi5jOjM1NzQ6MTI6IGVycm9yOiAncmV0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGlu
IHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICByZXR1cm4g
cmV0OwogICAgICAgICAgICBefn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBl
cnJvcnMKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBibG9jay9x
Y293Mi5vXSBFcnJvciAxCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9wYXJhbGxlbHMuYzogSW4g
ZnVuY3Rpb24gJ3BhcmFsbGVsc19jb19jcmVhdGUnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cGFyYWxsZWxzLmM6NjA0OjEyOiBlcnJvcjogJ3JldCcgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXpl
ZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgcmV0
dXJuIHJldDsKICAgICAgICAgICAgXn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYmxv
Y2svcGFyYWxsZWxzLm9dIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxl
PgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9OTU0YjU3Zjg4NDlhNGJhMjlhMjkyOWM0N2U1YjMzNGMnLCAnLXUnLCAnMTAwMScsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLTZqOTcxamNhL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjMtMTguMzIuNTIu
Mjk3NjQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OTU0YjU3Zjg4NDlhNGJh
MjlhMjkyOWM0N2U1YjMzNGMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNmo5NzFq
Y2Evc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgMm0xOC44OTNzCnVzZXIgICAgMG04LjkxNnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDIzMjIxNzA3LjQ3NzQwNC0x
LWVibGFrZUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

