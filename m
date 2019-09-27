Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18445C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AF52146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AF52146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkIo-0006sj-4L
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iDjf2-0007PG-Dt
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iDjf0-0004da-CE
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:23 -0400
Resent-Date: Fri, 27 Sep 2019 02:23:23 -0400
Resent-Message-Id: <E1iDjf0-0004da-CE@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iDjf0-0004B8-2D
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569565390; cv=none; d=zoho.com; s=zohoarc; 
 b=fJLqs5U+BqRcM9xZxI8wmVrajQ4xKwfHzVVLEZiedbtxCNQzjnQoJ68kTTBU1Pv9Cf/BA8FbdPhdS5TTCANPg6fyR3BCsznNMjMC792eENCO/sVoWfzO6l1t5cFWc5oDP1XuqAeml+clAeRC+HzX0JyxaYpf+XHhRxSSaRC6CWM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569565390;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=sVi6myzDcB3E3xJ2urBOYa86kBiXsWkQ1P6bkkD1+T8=; 
 b=GlNHtcsk1v1Q/SlF1jGPk1DyOVWtZKuESeF64Gb4iwHNx42/Fj6yBrltI8E1LDGd1fpr76FIoLO0K7xmnnUoptPHDZB14g+/o6N09KprpCtm+t5OkLPe4IO7TK3IzsPr72EvEr7TQorC8KUeFADpwXpIsMzT4fgkIE3vUyF/AIY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156956538590717.03807799723154;
 Thu, 26 Sep 2019 23:23:05 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix ehci-test
In-Reply-To: <20190926111955.17276-1-marcandre.lureau@redhat.com>
Message-ID: <156956538460.27075.1736255201296502655@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 26 Sep 2019 23:23:05 -0700 (PDT)
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNjExMTk1NS4xNzI3
Ni0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpsaWJ1ZGV2ICAg
ICAgICAgICBubwpkZWZhdWx0IGRldmljZXMgICB5ZXMKCndhcm5pbmc6IFB5dGhvbiAyIHN1cHBv
cnQgaXMgZGVwcmVjYXRlZAp3YXJuaW5nOiBQeXRob24gMyB3aWxsIGJlIHJlcXVpcmVkIGZvciBi
dWlsZGluZyBmdXR1cmUgdmVyc2lvbnMgb2YgUUVNVQpjcm9zcyBjb250YWluZXJzICBubwoKTk9U
RTogZ3Vlc3QgY3Jvc3MtY29tcGlsZXJzIGVuYWJsZWQ6IGNjCi0tLQpxZW11LXN5c3RlbS1hYXJj
aDY0OiBjYW5ub3Qgc2V0IHVwIGd1ZXN0IG1lbW9yeSAnZXh5bm9zNDIxMC5kcmFtMCc6IENhbm5v
dCBhbGxvY2F0ZSBtZW1vcnkKQnJva2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL2xp
YnF0ZXN0LmM6MTQwOiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNz
IGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJPUiAtIHRvbyBm
ZXcgdGVzdHMgcnVuIChleHBlY3RlZCA2MSwgZ290IDEpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3Qt
YWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy91c2ItaGNkLXhoY2ktdGVzdAoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA5MjYxMTE5NTUuMTcyNzYtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVzdGluZy5k
b2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


