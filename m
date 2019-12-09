Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE72206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE72206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieRkc-0000Cy-Ld
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 17:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieRjm-0008Dw-Mr
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieRjl-00022C-5d
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:42:42 -0500
Resent-Date: Mon, 09 Dec 2019 17:42:42 -0500
Resent-Message-Id: <E1ieRjl-00022C-5d@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieRjk-00021k-So
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:42:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575931353; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dxBWD9g+kVG3Sr/cvAnyPP26UxO5iEVxw2J+1oBdVyyTEAZpGkHIwFxmFATOg58F9d3Ugags3HojuONdYgOWVTVpDZa0Hf/If6i/R5oq+rgmnoB+ifLDFKIXPwyRjKMgr8iiHirtktpEqX0GvuXxQF4yFYMuKak7bN1pp/7xJoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575931353;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MWi/mWewtCEiUt/qqPVaNdxG8CxQ68fES4xgvhUr5+I=; 
 b=ilvxPAWGoStWYYjQ8iQobd3l5I+vnn1xEianApgLyvSq9VyR6RwtlPqmC0QcpKw13rzBCRVEkECEHfwSRacjBjzEX0c7FwsxmWybN+Yr6dE3MEMjZfppIobmrhfnYAnLNj9LNUprDbKcXBr1pzgdgi7d8ch+lE0G4fDWSuU/7G8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575931351203518.5803280320293;
 Mon, 9 Dec 2019 14:42:31 -0800 (PST)
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/18] Complete the implementation of -accel
Message-ID: <157593135019.7675.11543310814974150733@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 9 Dec 2019 14:42:31 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc1OTAzNzA1LTEyOTI1LTEt
Z2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNl
bnRvczcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBT
SE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgbWlncmF0aW9uL2ZkLm8KICBDQyAgICAgIG1pZ3JhdGlvbi9leGVjLm8KL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L3hlbi94ZW4tY29tbW9uLmM6IEluIGZ1bmN0aW9uICd4ZW5fZ2V0X2lnZF9nZnhf
cGFzc3RocnUnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcveGVuL3hlbi1jb21tb24uYzoxMjk6MTI6
IGVycm9yOiAnaGFzX2lnZF9nZnhfcGFzc3RocnUnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQogICAgIHJldHVybiBoYXNfaWdkX2dmeF9wYXNzdGhydTsKICAgICAgICAg
ICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcveGVuL3hlbi1jb21tb24uYzoxMjk6MTI6IG5vdGU6
IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFj
aCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCi90bXAvcWVtdS10ZXN0L3NyYy9ody94ZW4veGVuLWNv
bW1vbi5jOiBJbiBmdW5jdGlvbiAneGVuX3NldF9pZ2RfZ2Z4X3Bhc3N0aHJ1JzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L3hlbi94ZW4tY29tbW9uLmM6MTM0OjU6IGVycm9yOiAnaGFzX2lnZF9nZnhf
cGFzc3RocnUnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAgIGhh
c19pZ2RfZ2Z4X3Bhc3N0aHJ1ID0gdmFsdWU7CiAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcv
eGVuL3hlbi1jb21tb24uYzogSW4gZnVuY3Rpb24gJ3hlbl9hY2NlbF9jbGFzc19pbml0JzoKL3Rt
cC9xZW11LXRlc3Qvc3JjL2h3L3hlbi94ZW4tY29tbW9uLmM6MTkzOjEwOiBlcnJvcjogJ2Vycm9y
X2Fib3J0JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICAgICAg
JmVycm9yX2Fib3J0KTsKICAgICAgICAgIF4KbWFrZTogKioqIFtody94ZW4veGVuLWNvbW1vbi5v
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTRmZjE0NDg1YTNlMzRmYWE4ZTBmZTdhZjliZTQ0MjcxJywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1l
JywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXZ2em12aWdfL3NyYy9kb2NrZXItc3JjLjIwMTktMTItMDkt
MTcuMzkuMzkuMTYwNDM6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTRmZjE0
NDg1YTNlMzRmYWE4ZTBmZTdhZjliZTQ0MjcxCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLXZ2em12aWdfL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9z
N10gRXJyb3IgMgoKcmVhbCAgICAybTUxLjg5NXMKdXNlciAgICAwbTcuOTE5cwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3NTkwMzcwNS0x
MjkyNS0xLWdpdC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXIt
cXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


