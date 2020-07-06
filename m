Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3553FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12ECB20723
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12ECB20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVB5-0003rs-7B
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsVAP-0003Pt-1p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 13:44:33 -0400
Resent-Date: Mon, 06 Jul 2020 13:44:33 -0400
Resent-Message-Id: <E1jsVAP-0003Pt-1p@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsVAM-00063W-KP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 13:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594057464; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bZJO/R3hr8pH5XpXjWUz2o+cHyM0+/+FVpWyYt1IQvuciQTHTxm1uTVjiLCBGjmpZSaAdHLsoMjLJ7VIvQYDwjH9iC9AeC4MIvVjwZGxkDDTrT/dXf6k1NwCmQ7e5Jy59zds2IJhvyaNW8ZbXMomOAIC99e4QWu0ost3dqUwC50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594057464;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=37hWl3l5jvASc7bAVb1yHg1Egnmrj3/UuEhNTf/hpoo=; 
 b=j9+wIyTH0wV+Hn1aGHEfYPGszCkP5ziaT4C6Gk/ovd1S9o7kfrm5SrJmq/SXl1sEuEpJ2PFRIXTTbGGjfXertVZxdO4w9lZcxVTB1vkeWbBOMTKMn0MdlCp68Tt+BznxxlW45Ta3gkAX02R6nY19kZGSuYzh51nq7NemT4hkVAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594057462713733.2240573743182;
 Mon, 6 Jul 2020 10:44:22 -0700 (PDT)
Message-ID: <159405746133.7847.6146784276688587643@d1fd068a5071>
Subject: Re: [PATCH v3 0/2] trace: Add a trace backend for the recorder library
In-Reply-To: <20200706170255.1165105-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dinechin@redhat.com
Date: Mon, 6 Jul 2020 10:44:22 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:33:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, armbru@redhat.com,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwNjE3MDI1NS4xMTY1
MTA1LTEtZGluZWNoaW5AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYzIDAvMl0gdHJhY2U6IEFkZCBhIHRyYWNl
IGJhY2tlbmQgZm9yIHRoZSByZWNvcmRlciBsaWJyYXJ5ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlk
OiAyMDIwMDcwNjE3MDI1NS4xMTY1MTA1LTEtZGluZWNoaW5AcmVkaGF0LmNvbQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyNmVm
MzNiIHRyYWNlOiBFeGFtcGxlIG9mIG5vbi10cmFjaW5nIHJlY29yZGVyIHVzZQo2NGVlMjBiIHRy
YWNlOiBBZGQgc3VwcG9ydCBmb3IgcmVjb3JkZXIgYmFjay1lbmQKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvMiBDaGVja2luZyBjb21taXQgNjRlZTIwYjMwNGFiICh0cmFjZTogQWRkIHN1cHBvcnQg
Zm9yIHJlY29yZGVyIGJhY2stZW5kKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxNDg6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBh
IHNlcGFyYXRlIGxpbmUKIzI2NzogRklMRTogdHJhY2UvcmVjb3JkZXIuYzoyMDoKKyAgICAvKiBB
bGxvdyBhIGR1bXAgaW4gY2FzZSB3ZSByZWNlaXZlIHNvbWUgdW5oYW5kbGVkIHNpZ25hbAoKV0FS
TklORzogQmxvY2sgY29tbWVudHMgdXNlICogb24gc3Vic2VxdWVudCBsaW5lcwojMjY4OiBGSUxF
OiB0cmFjZS9yZWNvcmRlci5jOjIxOgorICAgIC8qIEFsbG93IGEgZHVtcCBpbiBjYXNlIHdlIHJl
Y2VpdmUgc29tZSB1bmhhbmRsZWQgc2lnbmFsCisgICAgICAgRm9yIGV4YW1wbGUsIHNlbmQgVVNS
MiB0byBhIGh1bmcgcHJvY2VzcyB0byBnZXQgYSBkdW1wICovCgpXQVJOSU5HOiBCbG9jayBjb21t
ZW50cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzI2ODogRklMRTogdHJh
Y2UvcmVjb3JkZXIuYzoyMToKKyAgICAgICBGb3IgZXhhbXBsZSwgc2VuZCBVU1IyIHRvIGEgaHVu
ZyBwcm9jZXNzIHRvIGdldCBhIGR1bXAgKi8KCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21t
ZW50cwojMzEwOiBGSUxFOiB0cmFjZS9yZWNvcmRlci5oOjMyOgorI2VuZGlmIC8vIFRSQUNFX1JF
Q09SREVSX0gKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMzMxOiBGSUxFOiB1
dGlsL21vZHVsZS5jOjE1ODoKKyAgICAgICAgLy8gTmV3IHJlY29yZGVycyBtYXkgaGF2ZSBiZWVu
IHB1bGxlZCBpbiwgYWN0aXZhdGUgdGhlbSBpZiBuZWNlc3NhcnkKCnRvdGFsOiAyIGVycm9ycywg
NCB3YXJuaW5ncywgMjQ1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMi8yIENoZWNraW5nIGNvbW1pdCAyNmVmMzNiM2Y5ZTEgKHRyYWNlOiBFeGFt
cGxlIG9mIG5vbi10cmFjaW5nIHJlY29yZGVyIHVzZSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MDYxNzAyNTUuMTE2NTEwNS0xLWRpbmVj
aGluQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

