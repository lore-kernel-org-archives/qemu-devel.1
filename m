Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE28C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00905206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00905206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahmz-0001l6-9F
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hahfs-0003xi-K8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hahax-0005pj-EN
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:17:53 -0400
Resent-Date: Tue, 11 Jun 2019 10:17:52 -0400
Resent-Message-Id: <E1hahax-0005pj-EN@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hahax-0005on-04
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:17:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560262619; cv=none; d=zoho.com; s=zohoarc; 
 b=UGfpPKF/IWExOqwZJDGlGV8zdv+L1F6C37jlwZJJkJgqbujAiNpLIknCJzfrGr1l0YDagasw5cVTsB1sDSns6bMzTKzQR90N7ZVisP+0FlNFkV935XrWVjNd5HhdTBsFn7LPw2cZMMrT48dNlUB2rEPFaLd2LdeXKqlH721OnV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560262619;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=9Ld9cMK23pGZjVjCnUCKAs8rA8BdH5T8URkn6+phbqM=; 
 b=TAMY+3JVI0FlFmMmYJxjIVNiR2BeiIRGjsPhguiU/fSKfxC7y9jA2vAFpLXqLogaBit+pCuYKhexrp2vrOvlSFY2wYAWe/OyP6CJ4iBfWMnDitMKXAHMzSxRqCw7kYNqjGkSsjM7Uddpd+hUaDpqhG9u0Ayy/WDHEhHFXfL4mEs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560262617996605.0092699930582;
 Tue, 11 Jun 2019 07:16:57 -0700 (PDT)
In-Reply-To: <20190611113731.16940-1-philmd@redhat.com>
Message-ID: <156026261691.32260.5523393371246325860@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 11 Jun 2019 07:16:57 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v19 00/21] Add RX archtecture support
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
Cc: imammedo@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 ysato@users.sourceforge.jp, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxMTExMzczMS4xNjk0
MC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQ
V0QvYnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JD
L2NvbmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2Ug
bmVlZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwK
CmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0gUEFDS0FHRVMgPT09
IgpycG0gLXFhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgcHBjNjQtc29mdG1t
dS9hY2NlbC90Y2cvdGNnLXJ1bnRpbWUtZ3ZlYy5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbDR2OWJvd2Yvc3JjL3RhcmdldC9yeC9jcHUuaDozMSwK
ICAgICAgICAgICAgICAgICBmcm9tIC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1sNHY5Ym93
Zi9zcmMvZXhlYy5jOjIzOgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbDR2OWJvd2Yvc3Jj
L2luY2x1ZGUvZXhlYy9jcHUtZGVmcy5oOjM4OjEwOiBmYXRhbCBlcnJvcjogY3B1LXBhcmFtLmg6
IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICAgMzggfCAjaW5jbHVkZSAiY3B1LXBhcmFtLmgi
CiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA2MTExMTM3MzEuMTY5NDAtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLnMzOTB4Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


