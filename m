Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB8BC55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C9D2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C9D2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYMd-0002Ph-3m
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRYM1-0001t9-Ri
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRYM1-0001d1-E0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:41:09 -0400
Resent-Date: Thu, 23 Apr 2020 05:41:09 -0400
Resent-Message-Id: <E1jRYM1-0001d1-E0@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRYLl-0001Jd-WC; Thu, 23 Apr 2020 05:40:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587634839; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eWCkClE+UWycU8ui2qSK4t2Ja0l9vndbx4dXw8Kp7jvixexkMmwSPXaS1vNI9uLMiGguz71mJB59cZS3sRoFyWAtyWDJqcIAW0aWmaYGU/zTIfjvBr0zAPbYYVI35mXELNhpba7+4gbkZ8zh2J43G8QPSFAF8LYL/tt+Bn224YY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587634839;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=czaH0LMiDY4URh9rV+Em2xM0FjdarAbGzjU6sN564y8=; 
 b=ke0nsyrSJdHaP1AL2oJez72iss65VjAM/WD9dCY0t8MoOgloqi8XglOId1ItlGyzpjs7AlRYUNVN0icFcu/1WiZxiQnj4guUF+cthBhYw7ItcU5SoGe5Hg3iFQ6shyOJV8OSLk6NFy7OEG77dU8J/tHORstvpTl8DH+LhoEr8r4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587634836986923.1533065848702;
 Thu, 23 Apr 2020 02:40:36 -0700 (PDT)
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
Subject: Re: [PATCH QEMU v2 0/5] Add a GPIO backend
Message-ID: <158763483525.4520.16083031382332426221@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: geert+renesas@glider.be
Date: Thu, 23 Apr 2020 02:40:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:13:42
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
Cc: peter.maydell@linaro.org, geert+renesas@glider.be, linus.walleij@linaro.org,
 magnus.damm@gmail.com, qemu-devel@nongnu.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, graf@amazon.com, pbonzini@redhat.com,
 bartekgola@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzA5MDExOC4xMTE5
OS0xLWdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9j
a2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLm8KICBDQyAgICAgIGh3L2FjcGkvaG1hdC5v
CgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9x
ZW11LW9wdGlvbnMuaHg6ODgxOlVuZXhwZWN0ZWQgaW5kZW50YXRpb24uCiAgQ0MgICAgICBody9h
Y3BpL2FjcGlfaW50ZXJmYWNlLm8KICBDQyAgICAgIGh3L2FjcGkvYmlvcy1saW5rZXItbG9hZGVy
Lm8KLS0tCiAgQ0MgICAgICBody9hY3BpL3BjaS5vCiAgQ0MgICAgICBody9hY3BpL2lwbWkubwog
IENDICAgICAgaHcvYWNwaS9hY3BpLXN0dWIubwptYWtlOiAqKiogW01ha2VmaWxlOjExMTU6IC5k
b2NzX3N5c3RlbV9xZW11LjFfZG9jc19zeXN0ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19z
eXN0ZW1fcWVtdS1jcHUtbW9kZWxzLjcuc2VudGluZWwuXSBFcnJvciAyCm1ha2U6ICoqKiBEZWxl
dGluZyBmaWxlICcuZG9jc19zeXN0ZW1fcWVtdS4xX2RvY3Nfc3lzdGVtX3FlbXUtYmxvY2stZHJp
dmVycy43X2RvY3Nfc3lzdGVtX3FlbXUtY3B1LW1vZGVscy43LnNlbnRpbmVsLicKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KCldhcm5pbmcsIHRyZWF0ZWQgYXMgZXJy
b3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4uL3FlbXUtb3B0aW9ucy5oeDo4ODE6VW5leHBl
Y3RlZCBpbmRlbnRhdGlvbi4KbWFrZTogKioqIFtNYWtlZmlsZToxMTA0OiBkb2NzL3N5c3RlbS9p
bmRleC5odG1sXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBG
aWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAg
IHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PWRiMDg1ZDVmZDBjNDRjMWZhNjAxNmJlNmUzMjM1MzBkJywgJy11JywgJzEwMDMnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJ
Uj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9j
a2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtZHMwcm5yaGovc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0yMy0wNS4zNy40NC4zMTU0
MzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4n
LCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9
LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1kYjA4NWQ1ZmQwYzQ0YzFmYTYw
MTZiZTZlMzIzNTMwZAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTog
TGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1kczBybnJoai9z
cmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVh
bCAgICAybTQ1LjY5OXMKdXNlciAgICAwbTcuNDc2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjMwOTAxMTguMTExOTktMS1nZWVy
dCtyZW5lc2FzQGdsaWRlci5iZS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

