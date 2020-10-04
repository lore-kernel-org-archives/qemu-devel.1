Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBBC41604
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 01:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5134E2067B
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 01:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5134E2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOsvZ-0007QP-FR
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 21:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kOsuw-0006yZ-5b; Sat, 03 Oct 2020 21:34:26 -0400
Resent-Date: Sat, 03 Oct 2020 21:34:26 -0400
Resent-Message-Id: <E1kOsuw-0006yZ-5b@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kOsut-0006WF-87; Sat, 03 Oct 2020 21:34:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601775254; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GbP3OjEwioBMUkQQgZzSXSmcPB4vrrNJh/t/wmixtlWxt1AWWOwQ0z8rnArX08uDEjyslucWkqqsoEBhYuiOOOuh1dGcs/KgtQP+w25jD4RKbNCCh5kQC1tBgKQ5yKrJ9HYSaEuIYNTBgt1yf8K9mCzJOLLIjVgVtTUpP2j364Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601775254;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qP6eFw5QB3XpjDG2uZHfNvhpVsh0ZqBaXOGEW6To/ho=; 
 b=FEyWY1+PdRZr9gfx9hYHpHBwgxHRVrN1i/SJXjr4yQMqh5mFMrM1yoWAMs2gesnMfluduOhvJkVfDT6b2l19dkfkbe7iKKeqJ93C63lQH2mYxZKTaj193Gl5klDy+79uSe8S2rho87pqNNBA0AHyN6onGuGINK6IpvCTQY2xFmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 16017752529961010.0460134216532;
 Sat, 3 Oct 2020 18:34:12 -0700 (PDT)
Subject: Re: [PATCH v10 0/8] linux-user: User support for AArch64 BTI
Message-ID: <160177525160.12501.2417388489163376608@66eaa9a8a123>
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 3 Oct 2020 18:34:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 21:06:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwMjIxNTk1NS4yNTQ4
NjYtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMDIy
MTU5NTUuMjU0ODY2LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFU
Q0ggdjEwIDAvOF0gbGludXgtdXNlcjogVXNlciBzdXBwb3J0IGZvciBBQXJjaDY0IEJUSQoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwplYWY1ZWRiIHRlc3RzL3RjZy9hYXJjaDY0OiBBZGQgYnRpIHNtb2tlIHRlc3QKYzc0ZTIwMiBs
aW51eC11c2VyL2VsZmxvYWQ6IFBhcnNlIE5UX0dOVV9QUk9QRVJUWV9UWVBFXzAgbm90ZXMKN2U3
YzUzNCBsaW51eC11c2VyL2VsZmxvYWQ6IE1vdmUgUFRfSU5URVJQIGRldGVjdGlvbiB0byBmaXJz
dCBsb29wCjFkZWQyY2QgbGludXgtdXNlci9lbGZsb2FkOiBBZGp1c3QgaXRlcmF0aW9uIG92ZXIg
cGhkcgo5YTMxM2IzIGxpbnV4LXVzZXIvZWxmbG9hZDogRml4IGNvZGluZyBzdHlsZSBpbiBsb2Fk
X2VsZl9pbWFnZQpkZGMyN2I3IGluY2x1ZGUvZWxmOiBBZGQgZGVmaW5lcyByZWxhdGVkIHRvIEdO
VSBwcm9wZXJ0eSBub3RlcyBmb3IgQUFyY2g2NAplY2E0MjQwIGxpbnV4LXVzZXI6IFNldCBQQUdF
X1RBUkdFVF8xIGZvciBUQVJHRVRfUFJPVF9CVEkKNmIzZThlMyBsaW51eC11c2VyL2FhcmNoNjQ6
IFJlc2V0IGJ0eXBlIGZvciBzaWduYWxzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tp
bmcgY29tbWl0IDZiM2U4ZTM2OTYxMyAobGludXgtdXNlci9hYXJjaDY0OiBSZXNldCBidHlwZSBm
b3Igc2lnbmFscykKMi84IENoZWNraW5nIGNvbW1pdCBlY2E0MjQwNjc0NTkgKGxpbnV4LXVzZXI6
IFNldCBQQUdFX1RBUkdFVF8xIGZvciBUQVJHRVRfUFJPVF9CVEkpCjMvOCBDaGVja2luZyBjb21t
aXQgZGRjMjdiNzU1NDlkIChpbmNsdWRlL2VsZjogQWRkIGRlZmluZXMgcmVsYXRlZCB0byBHTlUg
cHJvcGVydHkgbm90ZXMgZm9yIEFBcmNoNjQpCjQvOCBDaGVja2luZyBjb21taXQgOWEzMTNiMzAy
NjVjIChsaW51eC11c2VyL2VsZmxvYWQ6IEZpeCBjb2Rpbmcgc3R5bGUgaW4gbG9hZF9lbGZfaW1h
Z2UpCjUvOCBDaGVja2luZyBjb21taXQgMWRlZDJjZGNkOGVkIChsaW51eC11c2VyL2VsZmxvYWQ6
IEFkanVzdCBpdGVyYXRpb24gb3ZlciBwaGRyKQo2LzggQ2hlY2tpbmcgY29tbWl0IDdlN2M1MzQz
ZGRlNSAobGludXgtdXNlci9lbGZsb2FkOiBNb3ZlIFBUX0lOVEVSUCBkZXRlY3Rpb24gdG8gZmly
c3QgbG9vcCkKNy84IENoZWNraW5nIGNvbW1pdCBjNzRlMjAyMzYxYTkgKGxpbnV4LXVzZXIvZWxm
bG9hZDogUGFyc2UgTlRfR05VX1BST1BFUlRZX1RZUEVfMCBub3RlcykKOC84IENoZWNraW5nIGNv
bW1pdCBlYWY1ZWRiNTBkZTYgKHRlc3RzL3RjZy9hYXJjaDY0OiBBZGQgYnRpIHNtb2tlIHRlc3Qp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzMyOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBleHRl
cm5zIHNob3VsZCBiZSBhdm9pZGVkIGluIC5jIGZpbGVzCiMxMTc6IEZJTEU6IHRlc3RzL3RjZy9h
YXJjaDY0L2J0aS1jcnQuaW5jLmM6MTM6CitpbnQgbWFpbih2b2lkKTsKCnRvdGFsOiAxIGVycm9y
cywgMSB3YXJuaW5ncywgMTM2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDEwMDIyMTU5NTUuMjU0ODY2LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

