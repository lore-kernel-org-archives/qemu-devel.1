Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A1C4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A662080C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A662080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMraE-0001ke-1m
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMrYx-0000Pe-9o; Mon, 28 Sep 2020 07:43:23 -0400
Resent-Date: Mon, 28 Sep 2020 07:43:23 -0400
Resent-Message-Id: <E1kMrYx-0000Pe-9o@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMrYu-0006y6-JY; Mon, 28 Sep 2020 07:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601293394; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nSWxRWWN46vpUv7AjjRasehN58PVgFx//Lf4kOUxhmMPerrRI1l2FjCZkYXOZLwYCOGFeKb2KNI5doANqJfR+lOh6hFCHg0iBEQfUNfOLr8Z1RSPiGgPu5RTJY+hD48yWjG9JOe7DvkhqwgGjnaRTBV9Ffesxca/tIvktxI+ZsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601293394;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+m7IGoVzsKDVozFaJnPHxISyEsSnBE1c4L8JJrhEjU8=; 
 b=e3fmPxM2s0S+QcTBalkW/CsQtFOULLIuXTBO1xU0nSWWi39hCMPjdMiPFMChccjKdhASboHG/tAQdAtyCv93rrrnwK3Mr9gB2huJz8Xv9DYKQ7NnHQNqPNgjLbH/uwjO+gELd8qdJ/PVTBhbutYK0/izbpZPYgSMgwihwi/08oI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601293392237749.6817197566769;
 Mon, 28 Sep 2020 04:43:12 -0700 (PDT)
Subject: Re: [RFC PATCH v6 0/2] Add file-backed and write-once features to OTP
Message-ID: <160129339083.10465.9119328542748826342@66eaa9a8a123>
In-Reply-To: <20200928101146.12786-1-green.wan@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: green.wan@sifive.com
Date: Mon, 28 Sep 2020 04:43:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 07:08:07
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, green.wan@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyODEwMTE0Ni4xMjc4
Ni0xLWdyZWVuLndhbkBzaWZpdmUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkMgbGlua2VyIGZvciB0aGUg
aG9zdCBtYWNoaW5lOiBjYyBsZC5iZmQgMi4yNy00MwpIb3N0IG1hY2hpbmUgY3B1IGZhbWlseTog
eDg2XzY0Ckhvc3QgbWFjaGluZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdB
Uk5JTkc6IE1vZHVsZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJk
cyBjb21wYXRpYmlsaXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQ
cm9ncmFtIHNoIGZvdW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmlu
L3B5dGhvbjMpCkNvbmZpZ3VyaW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQpV
c2luZyBleHBlY3RlZCBmaWxlICd0ZXN0cy9kYXRhL2FjcGkvdmlydC9EU0RULm1lbWhwJwpzb2Nr
ZXRfYWNjZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUKKioKRVJS
T1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9x
bXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQg
Pj0gMCkKLi4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxsX3FlbXUoKSB0cmll
ZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAx
IChleHBlY3RlZCAwKQpFUlJPUiBxdGVzdC14ODZfNjQ6IGJpb3MtdGFibGVzLXRlc3QgLSBCYWls
IG91dCEgRVJST1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRf
d2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBz
LT5xbXBfZmQgPj0gMCkKICBURVNUICAgIGlvdGVzdC1xY293MjogMDI0Cm1ha2U6ICoqKiBbcnVu
LXRlc3QtMTM4XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyNQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAw
MjcKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9j
ZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcics
ICdydW4nLCAnLS1ybScsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MWE0MzUx
ZmIzZjkwNDg5ZWJmY2E3NjNiNDVmM2Q1ZTEnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VY
VFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RF
QlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2Nh
Y2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFy
L3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAta3UzenE1
eXovc3JjL2RvY2tlci1zcmMuMjAyMC0wOS0yOC0wNy4yNS4zMy4xOTMzMjovdmFyL3RtcC9xZW11
Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2sn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MWE0MzUxZmIzZjkwNDg5ZWJmY2E3NjNiNDVmM2Q1ZTEK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAta3UzenE1eXovc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE3bTM1LjMw
MXMKdXNlciAgICAwbTE1LjkyMXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI4MTAxMTQ2LjEyNzg2LTEtZ3JlZW4ud2FuQHNpZml2
ZS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

