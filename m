Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83285C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CF720663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CF720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT37n-00059q-FR
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT36z-000475-T9
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT36x-00032B-70
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:43:48 -0400
Resent-Date: Mon, 27 Apr 2020 08:43:48 -0400
Resent-Message-Id: <E1jT36x-00032B-70@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jT36w-0002uk-M6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587991416; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Db2m22OSEi0yYiAojeZ58r43t2T9wcEYaMmdfJCDE6kSD//lBzRvDqY9f5FQR1NN8sxTfujYckNjOuvFNO2kF4DBpsLu8bcubO/yzZMIBYydvwKwzWLsW9oS2QZsw9U31jp6QJ9NPQPY0v1XJdNmTxFMEBYQpanphZdyn4ngsv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587991416;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3FpNI7lQlpC/oTDE+oZkl7bZ+wYkOsPUjBdmkTw3cJg=; 
 b=FJ18Xfc+2oIqRD6ptYGByJoLLB3iTqEbshdxNROSejqcGA6F+dJsIw81o5MSHI1Cm+lWqzsE4Vrc5l1JVwxkLIUU6Wzwo/mF1ICIGVCp2aMxDZK20v7mZT3M/akVaXV5d3YIE1xSIh2uTcANUHqamUp6AiH7J8vPe6//PH9bDv8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15879914140641002.9328912420675;
 Mon, 27 Apr 2020 05:43:34 -0700 (PDT)
In-Reply-To: <20200427121823.8094-1-changbin.du@gmail.com>
Subject: Re: [PATCH] ui/sdl2: fix segment fault caused by null pointer
 dereference
Message-ID: <158799141292.15667.16491611917561766431@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: changbin.du@gmail.com
Date: Mon, 27 Apr 2020 05:43:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 08:29:35
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
Cc: changbin.du@gmail.com, kraxel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNzEyMTgyMy44MDk0
LTEtY2hhbmdiaW4uZHVAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgU0lHTiAgICBw
Yy1iaW9zL29wdGlvbnJvbS9wdmguYmluCiAgTElOSyAgICBxZW11LWlvLmV4ZQovdG1wL3FlbXUt
dGVzdC9zcmMvdWkvc2RsMi5jOiBJbiBmdW5jdGlvbiAnaGFuZGxlX2tleXVwJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL3VpL3NkbDIuYzo0MTg6MTA6IGVycm9yOiAnc2NvbmYnIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuICdzY29uJz8KICAgICBpZiAo
IXNjb25mKQogICAgICAgICAgXn5+fn4KICAgICAgICAgIHNjb24KL3RtcC9xZW11LXRlc3Qvc3Jj
L3VpL3NkbDIuYzo0MTg6MTA6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJl
cG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCm1ha2U6ICoq
KiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogdWkvc2RsMi5vXSBFcnJvciAxCm1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgTElOSyAgICBxZW11LWVk
aWQuZXhlClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlzZSBD
YWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NF
cnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcs
ICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTg3NGE0NDY5NjY0NTRiODlhYTgzNWU1MjVlYTBlNzIw
JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywg
Jy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRT
PScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9X
X0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUv
cGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICct
dicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtejlpdV9iamUvc3JjL2RvY2tlci1zcmMu
MjAyMC0wNC0yNy0wOC40MC4zNC4zMjcyMzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRv
cmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD04NzRhNDQ2OTY2NDU0Yjg5YWE4MzVlNTI1ZWEwZTcyMAptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC16OWl1X2JqZS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1p
bmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTU4LjgxNXMKdXNlciAgICAwbTguNjM3cwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA0MjcxMjE4MjMuODA5NC0xLWNoYW5nYmluLmR1QGdtYWlsLmNvbS90ZXN0aW5nLmRvY2tlci1t
aW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

