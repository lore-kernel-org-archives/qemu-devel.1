Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67428C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C4720789
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C4720789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBMS-0005Wl-Ai
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kNBLB-0004o9-TW
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:50:29 -0400
Resent-Date: Tue, 29 Sep 2020 04:50:29 -0400
Resent-Message-Id: <E1kNBLB-0004o9-TW@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kNBL9-0007nV-8l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601369418; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D5kEvAKP5/Zuy2q/r8QMLJ5/IIi91OrlAeJ876GWGyQNPpIFhOThObYvyetNVSI2DRBI/faQ6FA3yhRmOBLyQPqWO5hHpSwh7sJ11kPVynb9KBlXoNd0ohAqdoAKyIPQ9Z4nIz8Ae9h3ZIMzun53rCMuVYUg4o8re87KASOhMKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601369418;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+ozZK8UNLIfihldr9F8JIEfy5Z9Pnoiesc0ytbXffiU=; 
 b=e7ajpH4ZcbNoeq7lbarpY7fpiLFOPqRMuI7k/D0AanKSfWkjmjrPsOldWBuf0txlTKHAgHyvqwiJy2EI9vfLTBh3+9mjOTn4eqec+yJrqPcJjfpLhDsGUL/dMDu/FZuToDqiUsJ8oncKpjWt0ZKPJ/E+t/+2QBwhfSYpEkUWhEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601369415904519.1951096843751;
 Tue, 29 Sep 2020 01:50:15 -0700 (PDT)
Subject: Re: [PULL v4 00/48] virtio,pc,acpi: fixes, tests
Message-ID: <160136941462.23507.9890155163959956647@66eaa9a8a123>
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Tue, 29 Sep 2020 01:50:15 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 04:13:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyOTA3MTk0OC4yODEx
NTctMS1tc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDIGxpbmtlciBmb3IgdGhlIGhvc3Qg
bWFjaGluZTogY2MgbGQuYmZkIDIuMjctNDMKSG9zdCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4Nl82
NApIb3N0IG1hY2hpbmUgY3B1OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjEwOiBXQVJOSU5H
OiBNb2R1bGUgdW5zdGFibGUta2V5dmFsIGhhcyBubyBiYWNrd2FyZHMgb3IgZm9yd2FyZHMgY29t
cGF0aWJpbGl0eSBhbmQgbWlnaHQgbm90IGV4aXN0IGluIGZ1dHVyZSByZWxlYXNlcy4KUHJvZ3Jh
bSBzaCBmb3VuZDogWUVTClByb2dyYW0gcHl0aG9uMyBmb3VuZDogWUVTICgvdXNyL2Jpbi9weXRo
b24zKQpDb25maWd1cmluZyBuaW5qYXRvb2wgdXNpbmcgY29uZmlndXJhdGlvbgotLS0KQ291bGQg
bm90IGFsbG9jYXRlIGR5bmFtaWMgdHJhbnNsYXRvciBidWZmZXIKUnVubmluZyB0ZXN0IHF0ZXN0
LWFhcmNoNjQ6IG51bWEtdGVzdAoqKgpFUlJPUjouLi9zcmMvdGVzdHMvcXRlc3QvdHBtLWVtdS5j
Ojk3OnRwbV9lbXVfY3RybF90aHJlYWQ6IGFzc2VydGlvbiBmYWlsZWQgKGNtZCA9PSBDTURfU0VU
X0RBVEFGRCk6ICgwID09IDE2KQpFUlJPUiBxdGVzdC1hYXJjaDY0OiB0cG0tdGlzLWRldmljZS10
ZXN0IC0gQmFpbCBvdXQhIEVSUk9SOi4uL3NyYy90ZXN0cy9xdGVzdC90cG0tZW11LmM6OTc6dHBt
X2VtdV9jdHJsX3RocmVhZDogYXNzZXJ0aW9uIGZhaWxlZCAoY21kID09IENNRF9TRVRfREFUQUZE
KTogKDAgPT0gMTYpCi4uL3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE2Njoga2lsbF9xZW11
KCkgdHJpZWQgdG8gdGVybWluYXRlIFFFTVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBz
dGF0dXMgMSAoZXhwZWN0ZWQgMCkKbWFrZTogKioqIFtydW4tdGVzdC0xNjBdIEVycm9yIDEKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KQ291bGQgbm90IGFjY2VzcyBL
Vk0ga2VybmVsIG1vZHVsZTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpxZW11LXN5c3RlbS14
ODZfNjQ6IC1hY2NlbCBrdm06IGZhaWxlZCB0byBpbml0aWFsaXplIGt2bTogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQotLS0KVXNpbmcgZXhwZWN0ZWQgZmlsZSAndGVzdHMvZGF0YS9hY3BpL3Zp
cnQvRFNEVC5udW1hbWVtJwpzb2NrZXRfYWNjZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJp
bHkgdW5hdmFpbGFibGUKKioKRVJST1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAx
OnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+
ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKLi4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6
MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBlbmNv
dW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJPUiBxdGVzdC14ODZfNjQ6IGJp
b3MtdGFibGVzLXRlc3QgLSBCYWlsIG91dCEgRVJST1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0
ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFp
bGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKbWFrZTogKioqIFtydW4tdGVzdC0x
MzhdIEVycm9yIDEKQ291bGQgbm90IGFjY2VzcyBLVk0ga2VybmVsIG1vZHVsZTogTm8gc3VjaCBm
aWxlIG9yIGRpcmVjdG9yeQpxZW11LXN5c3RlbS14ODZfNjQ6IC1hY2NlbCBrdm06IGZhaWxlZCB0
byBpbml0aWFsaXplIGt2bTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpxZW11LXN5c3RlbS14
ODZfNjQ6IGZhbGxpbmcgYmFjayB0byB0Y2cKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1ybScsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9M2ZlMzhlN2I2ZmE2NDA5Y2I5N2FjNjFjNzQ4ZDc0NzInLCAnLXUn
LCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLThpZnZ3dGUwL3NyYy9kb2NrZXItc3JjLjIwMjAtMDktMjktMDQu
MzYuNDkuMjAwOTA6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTNmZTM4ZTdi
NmZhNjQwOWNiOTdhYzYxYzc0OGQ3NDcyCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LThpZnZ3dGUwL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAxM20yNC43MTZzCnVzZXIgICAgMG0xNS41MDlzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyOTA3MTk0
OC4yODExNTctMS1tc3RAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

