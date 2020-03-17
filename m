Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A02020724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A02020724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEmV-0001s8-FA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jEEW4-0005vO-Lk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jEEW3-00015E-7U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:28 -0400
Resent-Date: Tue, 17 Mar 2020 11:52:28 -0400
Resent-Message-Id: <E1jEEW3-00015E-7U@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jEEVv-0000i9-SZ; Tue, 17 Mar 2020 11:52:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584460312; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HnZ1yt7HzBj8jDV5ZCrChn+wn9LLu/Ma6JAXDfXue6YKXAu9AGgRg0bSIB1Iy0bhB9lUIaGCY0SMVLNMLfqDY4PzzEnf132XQ04SilnWVU8hVQBcZ5u7jL5pgaNNa9l1LQB3cxyn+g8dXU4qkiUeYbar3m8S4AoYJDjT2rl5m1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584460312;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Qgu46knYNDbTExpY0tb+sCbrjE8nlFmWNQQJ7wv3T50=; 
 b=R7ASTLJLDMkqlduhBcshXJHNSXTH/Cp9EnsOv+tOyg7p+5QLENTaFCdTfm/t2uSoZh+fLx5t+Qbtd67f/ABZHPbUmz0xTbzPHBehN/S5msaXFWoDUgSEIaMiPDNbQACXcuOI6UeUiVkhRr+2vyE2/10utTQpB08QKEiN5c86lCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584460310010321.3983906756298;
 Tue, 17 Mar 2020 08:51:50 -0700 (PDT)
In-Reply-To: <158444819283.31599.12155058652686614304.stgit@jupiter>
Subject: Re: [PATCH] ppc/spapr: Set the effective address provided flag in mc
 error log.
Message-ID: <158446030854.25100.12364998990821380964@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mahesh@linux.ibm.com
Date: Tue, 17 Mar 2020 08:51:50 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: aik@ozlabs.ru, groug@kaod.org, npiggin@gmail.com, qemu-devel@nongnu.org,
 ganeshgr@linux.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg0NDQ4MTkyODMuMzE1OTku
MTIxNTUwNTg2NTI2ODY2MTQzMDQuc3RnaXRAanVwaXRlci8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBwcGMvc3BhcHI6IFNldCB0
aGUgZWZmZWN0aXZlIGFkZHJlc3MgcHJvdmlkZWQgZmxhZyBpbiBtYyBlcnJvciBsb2cuCk1lc3Nh
Z2UtaWQ6IDE1ODQ0NDgxOTI4My4zMTU5OS4xMjE1NTA1ODY1MjY4NjYxNDMwNC5zdGdpdEBqdXBp
dGVyClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApn
aXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjJkOGFkYSBwcGMvc3BhcHI6IFNldCB0aGUg
ZWZmZWN0aXZlIGFkZHJlc3MgcHJvdmlkZWQgZmxhZyBpbiBtYyBlcnJvciBsb2cuCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM1
NzogRklMRTogaHcvcHBjL3NwYXByX2V2ZW50cy5jOjczOToKK15Jc3dpdGNoIChleHRfZWxvZy0+
bWMuZXJyb3JfdHlwZSkgeyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzU4OiBGSUxFOiBody9wcGMvc3BhcHJfZXZlbnRzLmM6NzQwOgorXkljYXNlIFJUQVNfTE9H
X1Y2X01DX1RZUEVfVUU6JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFi
cwojNTk6IEZJTEU6IGh3L3BwYy9zcGFwcl9ldmVudHMuYzo3NDE6CiteSV5JZXh0X2Vsb2ctPm1j
LnN1Yl9lcnJfdHlwZSB8PSBSVEFTX0xPR19WNl9NQ19VRV9FQV9BRERSX1BST1ZJREVEOyQKCkVS
Uk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzYwOiBGSUxFOiBody9wcGMv
c3BhcHJfZXZlbnRzLmM6NzQyOgorXkleSWJyZWFrOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzYxOiBGSUxFOiBody9wcGMvc3BhcHJfZXZlbnRzLmM6NzQzOgor
XkljYXNlIFJUQVNfTE9HX1Y2X01DX1RZUEVfU0xCOiQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzYyOiBGSUxFOiBody9wcGMvc3BhcHJfZXZlbnRzLmM6NzQ0Ogor
XkljYXNlIFJUQVNfTE9HX1Y2X01DX1RZUEVfRVJBVDokCgpFUlJPUjogY29kZSBpbmRlbnQgc2hv
dWxkIG5ldmVyIHVzZSB0YWJzCiM2MzogRklMRTogaHcvcHBjL3NwYXByX2V2ZW50cy5jOjc0NToK
K15JY2FzZSBSVEFTX0xPR19WNl9NQ19UWVBFX1RMQjokCgpFUlJPUjogY29kZSBpbmRlbnQgc2hv
dWxkIG5ldmVyIHVzZSB0YWJzCiM2NDogRklMRTogaHcvcHBjL3NwYXByX2V2ZW50cy5jOjc0NjoK
K15JXklleHRfZWxvZy0+bWMuc3ViX2Vycl90eXBlIHw9IFJUQVNfTE9HX1Y2X01DX0VBX0FERFJf
UFJPVklERUQ7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjU6
IEZJTEU6IGh3L3BwYy9zcGFwcl9ldmVudHMuYzo3NDc6CiteSV5JYnJlYWs7JAoKRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjY6IEZJTEU6IGh3L3BwYy9zcGFwcl9l
dmVudHMuYzo3NDg6CiteSWRlZmF1bHQ6JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojNjc6IEZJTEU6IGh3L3BwYy9zcGFwcl9ldmVudHMuYzo3NDk6CiteSV5JYnJl
YWs7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjg6IEZJTEU6
IGh3L3BwYy9zcGFwcl9ldmVudHMuYzo3NTA6CiteSX0kCgp0b3RhbDogMTIgZXJyb3JzLCAwIHdh
cm5pbmdzLCA1MCBsaW5lcyBjaGVja2VkCgpDb21taXQgNjJkOGFkYWMwNjg4IChwcGMvc3BhcHI6
IFNldCB0aGUgZWZmZWN0aXZlIGFkZHJlc3MgcHJvdmlkZWQgZmxhZyBpbiBtYyBlcnJvciBsb2cu
KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg0NDQ4MTkyODMuMzE1OTkuMTIxNTUwNTg2NTI2ODY2
MTQzMDQuc3RnaXRAanVwaXRlci90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

