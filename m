Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BEDC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B37206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B37206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7o0-000452-Io
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hi47f-0003vc-NU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hi47d-0006V0-0B
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:46:02 -0400
Resent-Date: Mon, 01 Jul 2019 17:46:02 -0400
Resent-Message-Id: <E1hi47d-0006V0-0B@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hi47b-0006SS-6C
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:46:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562003793; cv=none; d=zoho.com; s=zohoarc; 
 b=Fi3UPVkzm6nVkqlnhBwMThgDsk1WVy6HSlqRsqXRB4NSmd0Mm26+ufFkK2VchNSRDE+7Ntu186hs0FA8wi/Emtw1cKgV1e5ZN/sM+1sCHb7Umn9UxYpEWPoPZ8H//9MK9VuXTbRW3h1uqbIarqPAgEZJRChCCLuKfI9AefSTjio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562003793;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=PRFo8pvFF6HfovX3RooKrIVoLNOEvhKbUyB1xczFlq4=; 
 b=R84gwx59IyR3owOA35q9StOFX+IgluTdeSyo5rVBRB/S9YRfIFT9F3foL6g58wQgAguacPClXtB+829wlar6hADpEhYHhOMMBXgRABv7npn3xZVTR4IWGvenKNDAivGWzpH5VfqU8pzDMlvi9UAz98bYipUegfii9aNo28ENmgw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562003790980951.0250206531146;
 Mon, 1 Jul 2019 10:56:30 -0700 (PDT)
Message-ID: <156200378933.9862.9905804796969886990@c4a48874b076>
In-Reply-To: <20190701123108.12493-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 1 Jul 2019 10:56:30 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/6] hw/arm: Use ARM_CPU_TYPE_NAME() and
 object_initialize_child()
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
Cc: peter.maydell@linaro.org, andrew.smirnov@gmail.com, jasowang@redhat.com,
 alistair@alistair23.me, qemu-devel@nongnu.org, jcd@tribudubois.net,
 b.galvani@gmail.com, i.mitsyanko@gmail.com, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, antonynpavlov@gmail.com, edgar.iglesias@gmail.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMTEyMzEwOC4xMjQ5
My0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0g
UEFDS0FHRVMgPT09IgpycG0gLXFhCgplY2hvCmVjaG8gIj09PSBVTkFNRSA9PT0iCnVuYW1lIC1h
CgpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApt
a2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJl
IC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlh
YmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFsbAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3L2RtYS9pODI1Ny5vCiAgQ0MgICAgICBody9kbWEv
eGlsaW54X2F4aWRtYS5vCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC02dW1jNWVvcC9zcmMv
aHcvZG1hL3hpbGlueF9heGlkbWEuYzogSW4gZnVuY3Rpb24g4oCYeGlsaW54X2F4aWRtYV9pbml0
4oCZOgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNnVtYzVlb3Avc3JjL2h3L2RtYS94aWxp
bnhfYXhpZG1hLmM6NTY4OjI5OiBlcnJvcjog4oCYVFlQRV9YSUxJTlhfQVhJX0VORVRfREFUQV9T
VFJFQU3igJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91
IG1lYW4g4oCYVFlQRV9YSUxJTlhfQVhJX0RNQV9EQVRBX1NUUkVBTeKAmT8KICA1NjggfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9YSUxJTlhfQVhJX0VORVRfREFUQV9TVFJFQU0s
ICZlcnJvcl9hYm9ydCwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgVFlQRV9YSUxJTlhfQVhJX0RNQV9EQVRBX1NUUkVBTQovdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtNnVtYzVlb3Avc3JjL2h3L2RtYS94aWxpbnhfYXhpZG1hLmM6NTY4OjI5OiBub3Rl
OiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVh
Y2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNnVt
YzVlb3Avc3JjL2h3L2RtYS94aWxpbnhfYXhpZG1hLmM6NTcyOjI5OiBlcnJvcjog4oCYVFlQRV9Y
SUxJTlhfQVhJX0VORVRfQ09OVFJPTF9TVFJFQU3igJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGlu
IHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYVFlQRV9YSUxJTlhfQVhJX0RNQV9DT05U
Uk9MX1NUUkVBTeKAmT8KICA1NzIgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9Y
SUxJTlhfQVhJX0VORVRfQ09OVFJPTF9TVFJFQU0sICZlcnJvcl9hYm9ydCwKICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9YSUxJTlhfQVhJX0RN
QV9DT05UUk9MX1NUUkVBTQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAxOTA3MDExMjMxMDguMTI0OTMtMS1waGlsbWRAcmVkaGF0LmNvbS90
ZXN0aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


