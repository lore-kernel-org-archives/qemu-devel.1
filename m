Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800E7C4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F280208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F280208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDZr-0003uY-Fx
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hhDYU-0003CG-Ix
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hhDYT-0005HA-3q
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:38:14 -0400
Resent-Date: Sat, 29 Jun 2019 09:38:14 -0400
Resent-Message-Id: <E1hhDYT-0005HA-3q@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hhDYS-0005EW-RO
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561815474; cv=none; d=zoho.com; s=zohoarc; 
 b=I7bj8c9xnHPd6q78Z2QSdhiO0v++zg9pIZhOgR6nH54+5W5tdzuZAPIdD+nI/bSJ1kRejVbfcFusPGkL3eNVyqPrqg10I5t0JNUet9scAw2DJwQS4fwKHi84BZhFHsh6xJg6LEX+LDAQu8CxtxL6mIyBH12UHVA3JMgrWTgJwUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561815474;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ah47dNo/Vk/3ORGPyKthRqATuDrAC42cgDKRN3hupHY=; 
 b=Z5rdhcIZQuCfuCOS8cQbDxu6cxIfsjCyljJJw+VliirC3NN9bQVzZEzAL0zF8mdvdKNtGdiPCqvpF+yaO3kK/R862eQBKNlDf3iNPQ28yL+zidCbbgGGVHcWCG9btSd2URlpx61eev7AAOT1j78tYvRGcvNP35iYpNL8SUqdEBg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156181547149485.54275108764568;
 Sat, 29 Jun 2019 06:37:51 -0700 (PDT)
Message-ID: <156181547046.16285.8706013476764581614@c4a48874b076>
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 29 Jun 2019 06:37:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v6 00/16] tcg/ppc: Add vector opcodes
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyOTEzMDAxNy4yOTcz
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2NiAwMC8x
Nl0gdGNnL3BwYzogQWRkIHZlY3RvciBvcGNvZGVzCk1lc3NhZ2UtaWQ6IDIwMTkwNjI5MTMwMDE3
LjI5NzMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKNzM1ZTQyOCB0Y2cvcHBjOiBVcGRhdGUgdmVjdG9yIHN1cHBvcnQgdG8gdjMuMDAKZDVk
ZjhjZSB0Y2cvcHBjOiBVcGRhdGUgdmVjdG9yIHN1cHBvcnQgdG8gdjIuMDcKNzBiYWU4YyB0Y2cv
cHBjOiBVcGRhdGUgdmVjdG9yIHN1cHBvcnQgdG8gdjIuMDYKY2RjYjZmZCB0Y2cvcHBjOiBFbmFi
bGUgQWx0aXZlYyBkZXRlY3Rpb24KNWVjYTA0YSB0Y2cvcHBjOiBTdXBwb3J0IHZlY3RvciBkdXAy
CjlhOTJhNWIgdGNnL3BwYzogU3VwcG9ydCB2ZWN0b3IgbXVsdGlwbHkKOWRjYmJiNSB0Y2cvcHBj
OiBTdXBwb3J0IHZlY3RvciBzaGlmdCBieSBpbW1lZGlhdGUKNTcwN2NmZiB0Y2cvcHBjOiBQcmVw
YXJlIGNhc2UgZm9yIHZlY3RvciBtdWx0aXBseQo0ZThjODU2IHRjZy9wcGM6IEFkZCBzdXBwb3J0
IGZvciB2ZWN0b3Igc2F0dXJhdGVkIGFkZC9zdWJ0cmFjdAo4NTQyMzQ5IHRjZy9wcGM6IEFkZCBz
dXBwb3J0IGZvciB2ZWN0b3IgYWRkL3N1YnRyYWN0CjA5ZGNjYTMgdGNnL3BwYzogQWRkIHN1cHBv
cnQgZm9yIHZlY3RvciBtYXhpbXVtL21pbmltdW0KOTQwZDgwMiB0Y2cvcHBjOiBBZGQgc3VwcG9y
dCBmb3IgbG9hZC9zdG9yZS9sb2dpYy9jb21wYXJpc29uCjEzNTRiNDggdGNnL3BwYzogRW5hYmxl
IHRjZyBiYWNrZW5kIHZlY3RvciBjb21waWxhdGlvbgpjZTY1ZGM3IHRjZy9wcGM6IEludHJvZHVj
ZSBtYWNyb3MgVlJUKCksIFZSQSgpLCBWUkIoKSwgVlJDKCkKYzE1ZTA3NiB0Y2cvcHBjOiBJbnRy
b2R1Y2UgbWFjcm8gVlg0KCkKYTM1MTc5NiB0Y2cvcHBjOiBJbnRyb2R1Y2UgQWx0aXZlYyByZWdp
c3RlcnMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hlY2tpbmcgY29tbWl0IGEzNTE3OTY3
NGNmMiAodGNnL3BwYzogSW50cm9kdWNlIEFsdGl2ZWMgcmVnaXN0ZXJzKQoyLzE2IENoZWNraW5n
IGNvbW1pdCBjMTVlMDc2YzdkMGYgKHRjZy9wcGM6IEludHJvZHVjZSBtYWNybyBWWDQoKSkKRVJS
T1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnfCcgKGN0eDpWeFYpCiMyMTogRklMRTog
dGNnL3BwYy90Y2ctdGFyZ2V0LmluYy5jOjMyMjoKKyNkZWZpbmUgVlg0KG9wYykgIChPUENEKDQp
fChvcGMpKQogICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xNiBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKMy8xNiBDaGVja2luZyBjb21taXQgY2U2NWRjNzZmNzQzICh0Y2cvcHBjOiBJbnRy
b2R1Y2UgbWFjcm9zIFZSVCgpLCBWUkEoKSwgVlJCKCksIFZSQygpKQo0LzE2IENoZWNraW5nIGNv
bW1pdCAxMzU0YjQ4YTRkY2UgKHRjZy9wcGM6IEVuYWJsZSB0Y2cgYmFja2VuZCB2ZWN0b3IgY29t
cGlsYXRpb24pCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBz
ZXBhcmF0ZSBsaW5lCiMxNTU6IEZJTEU6IHRjZy9wcGMvdGNnLXRhcmdldC5pbmMuYzoyODQyOgor
ICAgIGlmIChod2NhcCAmIC8qIFBQQ19GRUFUVVJFX0hBU19BTFRJVkVDIC0tIE5PVCBZRVQgKi8g
MCkgewoKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlO
VEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTczOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFs
OiAwIGVycm9ycywgMiB3YXJuaW5ncywgMTM4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvMTYgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNS8xNiBDaGVja2luZyBjb21taXQgOTQwZDgwMjc5OTRk
ICh0Y2cvcHBjOiBBZGQgc3VwcG9ydCBmb3IgbG9hZC9zdG9yZS9sb2dpYy9jb21wYXJpc29uKQo2
LzE2IENoZWNraW5nIGNvbW1pdCAwOWRjY2EzYzlmODcgKHRjZy9wcGM6IEFkZCBzdXBwb3J0IGZv
ciB2ZWN0b3IgbWF4aW11bS9taW5pbXVtKQo3LzE2IENoZWNraW5nIGNvbW1pdCA4NTQyMzQ5YTQ1
ZjQgKHRjZy9wcGM6IEFkZCBzdXBwb3J0IGZvciB2ZWN0b3IgYWRkL3N1YnRyYWN0KQo4LzE2IENo
ZWNraW5nIGNvbW1pdCA0ZThjODU2NTE4NmQgKHRjZy9wcGM6IEFkZCBzdXBwb3J0IGZvciB2ZWN0
b3Igc2F0dXJhdGVkIGFkZC9zdWJ0cmFjdCkKOS8xNiBDaGVja2luZyBjb21taXQgNTcwN2NmZjYw
ZmFmICh0Y2cvcHBjOiBQcmVwYXJlIGNhc2UgZm9yIHZlY3RvciBtdWx0aXBseSkKMTAvMTYgQ2hl
Y2tpbmcgY29tbWl0IDlkY2JiYjU2MTA0NiAodGNnL3BwYzogU3VwcG9ydCB2ZWN0b3Igc2hpZnQg
YnkgaW1tZWRpYXRlKQoxMS8xNiBDaGVja2luZyBjb21taXQgOWE5MmE1YmZmZWJkICh0Y2cvcHBj
OiBTdXBwb3J0IHZlY3RvciBtdWx0aXBseSkKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMTMzOiBGSUxFOiB0Y2cvcHBjL3RjZy10YXJnZXQuaW5jLmM6MzIyMDoKK15J
YnJlYWs7JAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxODUgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMTEvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjEyLzE2IENoZWNraW5nIGNv
bW1pdCA1ZWNhMDRhODZhZWEgKHRjZy9wcGM6IFN1cHBvcnQgdmVjdG9yIGR1cDIpCjEzLzE2IENo
ZWNraW5nIGNvbW1pdCBjZGNiNmZkYmUxOTAgKHRjZy9wcGM6IEVuYWJsZSBBbHRpdmVjIGRldGVj
dGlvbikKMTQvMTYgQ2hlY2tpbmcgY29tbWl0IDcwYmFlOGM2YjNkZiAodGNnL3BwYzogVXBkYXRl
IHZlY3RvciBzdXBwb3J0IHRvIHYyLjA2KQoxNS8xNiBDaGVja2luZyBjb21taXQgZDVkZjhjZWMz
NzE4ICh0Y2cvcHBjOiBVcGRhdGUgdmVjdG9yIHN1cHBvcnQgdG8gdjIuMDcpCjE2LzE2IENoZWNr
aW5nIGNvbW1pdCA3MzVlNDI4ZjVmMmEgKHRjZy9wcGM6IFVwZGF0ZSB2ZWN0b3Igc3VwcG9ydCB0
byB2My4wMCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTA2MjkxMzAwMTcuMjk3My0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


