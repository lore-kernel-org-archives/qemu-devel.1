Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 02:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322E62073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 02:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322E62073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdPl4-0001Mn-CT
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 22:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdPkV-0000qi-UT; Mon, 25 May 2020 22:55:27 -0400
Resent-Date: Mon, 25 May 2020 22:55:27 -0400
Resent-Message-Id: <E1jdPkV-0000qi-UT@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdPkU-0004YQ-BR; Mon, 25 May 2020 22:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590461692; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ffe02X5GIkA/mCKPhhWkoXRhta1RYQSgdId5Sz+p1LP3csTs3fZ0ircyTaw1XNojNGtrpPu4lIcKs19oxqNzN0YQqToA2K90zY4KoC1r9nNwOAIVwNPD3T2b9DyUxv2T1P4KL7Kx5dJ+XH2vpDdqWiXF5HHZlJyurcl/KMbUk5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590461692;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eKnXYTrqVkVZ9OU/joI6sk2rU3Bg6NF6S34HHfzsW0c=; 
 b=daBP1lAI/1IlzCpKEkN4NP9X+5X5Lu6IWdAwFeTfEFApBP92s3+GwUeMpptKOSDNUY/aArzHzKciGgJlBPMXbGazjj42cpToYg7IDkolML/H+Zc4EOjYDeqAFZVMcSLyJRuOf2/eZApB7Gn2jbNuItZK6Cbx840pigHoT3eWuSs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590461690812426.10550973212764;
 Mon, 25 May 2020 19:54:50 -0700 (PDT)
Message-ID: <159046168943.6628.8328464362928767250@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Mon, 25 May 2020 19:54:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 21:48:04
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
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay92aGR4LWxv
Zy5vCiAgQ0MgICAgICBibG9jay9xdW9ydW0ubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNv
dzItY2x1c3Rlci5jOiBJbiBmdW5jdGlvbiAncWNvdzJfZ2V0X2hvc3Rfb2Zmc2V0JzoKL3RtcC9x
ZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NzM6MTk6IGVycm9yOiAnZXhwZWN0
ZWRfdHlwZScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vy
cm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgIH0gZWxzZSBpZiAodHlwZSAhPSBleHBl
Y3RlZF90eXBlKSB7CiAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9xY293Mi1jbHVzdGVyLmM6NDQ5OjI1OiBub3RlOiAnZXhwZWN0ZWRfdHlwZScgd2FzIGRlY2xh
cmVkIGhlcmUKICAgICBRQ293MlN1YmNsdXN0ZXJUeXBlIGV4cGVjdGVkX3R5cGUsIHR5cGU7CiAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1j
bHVzdGVyLmM6NDc1OjE5OiBlcnJvcjogJ2NoZWNrX29mZnNldCcgbWF5IGJlIHVzZWQgdW5pbml0
aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAg
ICAgICAgIH0gZWxzZSBpZiAoY2hlY2tfb2Zmc2V0KSB7CiAgICAgICAgICAgICAgICAgICBeCi90
bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ3OjEwOiBub3RlOiAnY2hl
Y2tfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIGJvb2wgY2hlY2tfb2Zmc2V0OwogICAg
ICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3NjoyOTog
ZXJyb3I6ICdleHBlY3RlZF9vZmZzZXQnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhp
cyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICAgICAgZXhw
ZWN0ZWRfb2Zmc2V0ICs9IHMtPmNsdXN0ZXJfc2l6ZTsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ4OjE0OiBu
b3RlOiAnZXhwZWN0ZWRfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIHVpbnQ2NF90IGV4
cGVjdGVkX29mZnNldDsKICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbYmxvY2svcWNvdzItY2x1c3Rlci5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBs
aW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPTliMTI2NGJiZjdkYTQyYzg4OTk4MmRjYTE4OGNjMDNkJywgJy11JywgJzEwMDEnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScs
ICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNI
RV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUt
ZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtb2NxbXcyYWwvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0yNS0yMi41Mi40My4x
ODIwMjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWIxMjY0YmJmN2RhNDJj
ODg5OTgyZGNhMTg4Y2MwM2QKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtb2NxbXcy
YWwvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAy
CgpyZWFsICAgIDJtNy4wNTRzCnVzZXIgICAgMG03LjcwNHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTA0Mjk5MDEuZ2l0LmJl
cnRvQGlnYWxpYS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

