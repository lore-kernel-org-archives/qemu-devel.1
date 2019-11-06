Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9539EC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C10217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C10217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMmk-0005N8-Hp
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSMlj-0004Xy-4w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSMlh-0000sA-8Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:58:46 -0500
Resent-Date: Wed, 06 Nov 2019 09:58:46 -0500
Resent-Message-Id: <E1iSMlh-0000sA-8Y@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSMlh-0000ra-0K
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:58:45 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573052316; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hnMs0ySWso8+CaXKGSarKpJQvd243v2gnRMZLH2k7Eg1kdD1qY1FIyBGMZA4I3Zs84Sct5Xd8l1GqPvEUbLyi5rybTDbRK++afWv1e2ejPdp9dF4/G/WV61G4pDjYtLkcPaKHT3eeB39EIf6+rNlzUESX04HscoHv1joEHUDotk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573052316;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=sBgNKr0xAJ+2d+Aq3TtSEybSYG/Bvo4t/z6YBbko7e0=; 
 b=YZDnQCeNawPjjn77uhZl/T9nlTJRT5k2eGpVEiaobLikZ/cnNI/FU4poWJiIKtr51ar7SFfKeRxk4G/th/mbq2iuNikYPqvqFGru8yII0dwVdckxUVvf/nkmiRC5zaZQqRssuVYATGQx1wKE3VAhToxsibtmR5/kfT4fz1argTw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573052313197958.1567331719982;
 Wed, 6 Nov 2019 06:58:33 -0800 (PST)
In-Reply-To: <20191106113318.10226-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/12] linux-user sparc fixes
Message-ID: <157305231198.21358.3677677989885907371@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 6 Nov 2019 06:58:33 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNjExMzMxOC4xMDIy
Ni0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MyAwMC8xMl0gbGludXgtdXNl
ciBzcGFyYyBmaXhlcwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMDYxMTMzMTguMTAy
MjYtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBb
dGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkxMTA2MTMwMzA5LjY3MzctMS1qYW5kcnl1a0Bn
bWFpbC5jb20gLT4gcGF0Y2hldy8yMDE5MTEwNjEzMDMwOS42NzM3LTEtamFuZHJ5dWtAZ21haWwu
Y29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAxOTExMDYxNDE0MjQuMjcyNDQtMS1l
ZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE5MTEwNjE0MTQyNC4yNzI0NC0x
LWVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIw
MTkxMTA2MTQ1MTI3LjIzNzAwLTEtbWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20gLT4gcGF0Y2hl
dy8yMDE5MTEwNjE0NTEyNy4yMzcwMC0xLW1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMzM0ODZlZSBsaW51eC11c2VyL2FscGhhOiBTZXQg
cjIwIHNlY29uZGFyeSByZXR1cm4gdmFsdWUKNGM1Zjk3MCBsaW51eC11c2VyL3NwYXJjOiBGaXgg
Y3B1X2Nsb25lX3JlZ3NfKgozOGMwNjQyIGxpbnV4LXVzZXI6IEludHJvZHVjZSBjcHVfY2xvbmVf
cmVnc19wYXJlbnQKOGZkMTBiMiBsaW51eC11c2VyOiBSZW5hbWUgY3B1X2Nsb25lX3JlZ3MgdG8g
Y3B1X2Nsb25lX3JlZ3NfY2hpbGQKMWM2ZWJjYiBsaW51eC11c2VyL3NwYXJjNjQ6IEZpeCB0YXJn
ZXRfc2lnbmFsX2ZyYW1lCmIxMjU3ZWYgbGludXgtdXNlci9zcGFyYzogRml4IFdSRUcgdXNhZ2Ug
aW4gc2V0dXBfZnJhbWUKNWY0MDI1MiBsaW51eC11c2VyL3NwYXJjOiBVc2UgV1JFR19TUCBjb25z
dGFudCBpbiBzcGFyYy9zaWduYWwuYwoyZTdmZmU2IGxpbnV4LXVzZXIvc3BhcmM6IEJlZ2luIHVz
aW5nIFdSRUcgY29uc3RhbnRzIGluIHNwYXJjL3NpZ25hbC5jCmI4N2YzMWRiIGxpbnV4LXVzZXIv
c3BhcmM6IFVzZSBXUkVHIGNvbnN0YW50cyBpbiBzcGFyYy90YXJnZXRfY3B1LmgKMDhmZGI0MyB0
YXJnZXQvc3BhcmM6IERlZmluZSBhbiBlbnVtZXJhdGlvbiBmb3IgYWNjZXNzaW5nIGVudi0+cmVn
d3B0cgo3ZTg3NmRkIHRlc3RzL3RjZy9tdWx0aWFyY2gvbGludXgtdGVzdDogRml4IGVycm9yIGNo
ZWNrIGZvciBzaG1hdAo0ZGFlNTRkIHNjcmlwdHMvcWVtdS1iaW5mbXQtY29uZjogVXBkYXRlIGZv
ciBzcGFyYzY0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEyIENoZWNraW5nIGNvbW1pdCA0ZGFl
NTRkNmFmYjMgKHNjcmlwdHMvcWVtdS1iaW5mbXQtY29uZjogVXBkYXRlIGZvciBzcGFyYzY0KQpX
QVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzY6IEZJTEU6IHNjcmlwdHMvcWVtdS1i
aW5mbXQtY29uZi5zaDo0MToKK3NwYXJjNjRfbWFnaWM9J1x4N2ZFTEZceDAyXHgwMlx4MDFceDAw
XHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMFx4MDBceDAwXHgwMlx4MDBceDJiJwoKRVJST1I6
IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMzNzogRklMRTogc2NyaXB0cy9xZW11LWJpbmZtdC1j
b25mLnNoOjQyOgorc3BhcmM2NF9tYXNrPSdceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHgw
MFx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmZceGZmXHhmZlx4ZmVceGZmXHhmZicKCnRvdGFs
OiAxIGVycm9ycywgMSB3YXJuaW5ncywgMjAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8xMiBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi8xMiBDaGVja2luZyBjb21taXQgN2U4NzZkZDkxY2I1
ICh0ZXN0cy90Y2cvbXVsdGlhcmNoL2xpbnV4LXRlc3Q6IEZpeCBlcnJvciBjaGVjayBmb3Igc2ht
YXQpCjMvMTIgQ2hlY2tpbmcgY29tbWl0IDA4ZmRiNDM5NTIzMSAodGFyZ2V0L3NwYXJjOiBEZWZp
bmUgYW4gZW51bWVyYXRpb24gZm9yIGFjY2Vzc2luZyBlbnYtPnJlZ3dwdHIpCjQvMTIgQ2hlY2tp
bmcgY29tbWl0IGI4N2YzMWRiODMxYSAobGludXgtdXNlci9zcGFyYzogVXNlIFdSRUcgY29uc3Rh
bnRzIGluIHNwYXJjL3RhcmdldF9jcHUuaCkKNS8xMiBDaGVja2luZyBjb21taXQgMmU3ZmZlNjFj
NTEyIChsaW51eC11c2VyL3NwYXJjOiBCZWdpbiB1c2luZyBXUkVHIGNvbnN0YW50cyBpbiBzcGFy
Yy9zaWduYWwuYykKNi8xMiBDaGVja2luZyBjb21taXQgNWY0MDI1Mjg2ZTJjIChsaW51eC11c2Vy
L3NwYXJjOiBVc2UgV1JFR19TUCBjb25zdGFudCBpbiBzcGFyYy9zaWduYWwuYykKNy8xMiBDaGVj
a2luZyBjb21taXQgYjEyNTdlZmM3YzZkIChsaW51eC11c2VyL3NwYXJjOiBGaXggV1JFRyB1c2Fn
ZSBpbiBzZXR1cF9mcmFtZSkKOC8xMiBDaGVja2luZyBjb21taXQgMWM2ZWJjYjk2NTRiIChsaW51
eC11c2VyL3NwYXJjNjQ6IEZpeCB0YXJnZXRfc2lnbmFsX2ZyYW1lKQo5LzEyIENoZWNraW5nIGNv
bW1pdCA4ZmQxMGIyNzIzMjIgKGxpbnV4LXVzZXI6IFJlbmFtZSBjcHVfY2xvbmVfcmVncyB0byBj
cHVfY2xvbmVfcmVnc19jaGlsZCkKMTAvMTIgQ2hlY2tpbmcgY29tbWl0IDM4YzA2NDI5ZmIxZSAo
bGludXgtdXNlcjogSW50cm9kdWNlIGNwdV9jbG9uZV9yZWdzX3BhcmVudCkKMTEvMTIgQ2hlY2tp
bmcgY29tbWl0IDRjNWY5NzBhM2M3YSAobGludXgtdXNlci9zcGFyYzogRml4IGNwdV9jbG9uZV9y
ZWdzXyopCjEyLzEyIENoZWNraW5nIGNvbW1pdCAzMzQ4NmVlMjRlNWMgKGxpbnV4LXVzZXIvYWxw
aGE6IFNldCByMjAgc2Vjb25kYXJ5IHJldHVybiB2YWx1ZSkKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMDYxMTMzMTguMTAyMjYtMS1yaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


