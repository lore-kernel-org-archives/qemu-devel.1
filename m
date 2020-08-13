Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99BBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B830420781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B830420781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AnX-0006sD-Pg
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6Ami-0005E7-S9
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:48:36 -0400
Resent-Date: Thu, 13 Aug 2020 06:48:36 -0400
Resent-Message-Id: <E1k6Ami-0005E7-S9@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6Amg-0000HG-IZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:48:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597315708; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NIKrrMTJ2JOKZhdZRwVqBn4GZXQr81TMXw4T3/AqovElNvbxTnDUT73LjWPnABpddd5BOGhVQSGAWagMisMEIHagv2mHKVYx00asHm6vy8E2PkbxWw7t4KCGOwmYcuQJhxmS3tMM5afcadk6+2qb/rXeuH+q4L/FOAbrWp91uYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597315708;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=07sfufhI58aE0j2sMc/WJttX/M+erbDFQRB3znXYSsc=; 
 b=D3z4VgkBQq+VnByia5F4xolqSTyeRj8LJrpaB3XLwrDuZ3vYgbyOyWe/Vay6uQSjZ7bOQKe3T6Z2uzyoXIAJ13Jrfaymp5+g557IP9VlBLlUPdbhTJbxgsM8VM1UJEjj6BUHlPsWAFbcZWZfOuq9Y4sHj3dGHa3iRElgrKMUsno=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597315705951294.3500448539313;
 Thu, 13 Aug 2020 03:48:25 -0700 (PDT)
Subject: Re: [PATCH 00/17] crypto/cipher: Class hierarchy cleanups
Message-ID: <159731570548.15736.11623744411793807532@66eaa9a8a123>
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Thu, 13 Aug 2020 03:48:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 04:40:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzAzMjUzNy4yODg4
NTkzLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwODEz
MDMyNTM3LjI4ODg1OTMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN1YmplY3Q6IFtQ
QVRDSCAwMC8xN10gY3J5cHRvL2NpcGhlcjogQ2xhc3MgaGllcmFyY2h5IGNsZWFudXBzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDgx
MzAzMjUzNy4yODg4NTkzLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyAtPiBwYXRjaGV3
LzIwMjAwODEzMDMyNTM3LjI4ODg1OTMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYTM5ZDQ5NCBjcnlwdG8vZ2NyeXB0OiBTcGxp
dCBRQ3J5cHRvQ2lwaGVyR2NyeXB0IGludG8gc3ViY2xhc3NlcwpjYTc4N2Q5IGNyeXB0by9uZXR0
bGU6IFNwbGl0IFFDcnlwdG9DaXBoZXJOZXR0bGUgaW50byBzdWJjbGFzc2VzCjgxYmYxOWIgY3J5
cHRvL2J1aWx0aW46IFNwbGl0IFFDcnlwdG9DaXBoZXJCdWlsdGluIGludG8gc3ViY2xhc3Nlcwox
MWFlZDc0IGNyeXB0by9idWlsdGluOiBTcGxpdCBhbmQgc2ltcGxpZnkgQUVTX2VuY3J5cHRfY2Jj
CmM2MjgxNTAgY3J5cHRvL2J1aWx0aW46IE1vdmUgQUVTX2NiY19lbmNyeXB0IGludG8gY2lwaGVy
LWJ1aWx0aW4uaW5jLmMKMzcwNzM3MCBjcnlwdG8vYnVpbHRpbjogTWVyZ2UgcWNyeXB0b19jaXBo
ZXJfYWVzX3tlY2IsIHh0c31fe2VuLCBkZX1jcnlwdAplZmUxMDA1IGNyeXB0by9idWlsdGluOiBS
ZW1vdmUgb2RkLXNpemVkIEFFUyBibG9jayBoYW5kbGluZwo2MjhhYThhIGNyeXB0bzogQ29uc3Rp
ZnkgY2lwaGVyIGRhdGEgdGFibGVzCjAxZjEyMTUgY3J5cHRvOiBNb3ZlIGNpcGhlci0+ZHJpdmVy
IGluaXQgdG8gcWNyeXB0b18qX2NpcGhlcl9jdHhfbmV3CjkzZGMzOGEgY3J5cHRvOiBBbGxvY2F0
ZSBRQ3J5cHRvQ2lwaGVyIHdpdGggdGhlIHN1YmNsYXNzCjgxYWFhNTQgY3J5cHRvOiBVc2UgdGhl
IGNvcnJlY3QgY29uc3QgdHlwZSBmb3IgZHJpdmVyCjhjNDM3NzUgY3J5cHRvL25ldHRsZTogRml4
IHh0c19lbmNyeXB0IGFyZ3VtZW50cwpmN2MwZjA0IGNyeXB0bzogUmVtb3ZlIHJlZHVuZGFudCBp
bmNsdWRlcwo0OTBmZDFiIGNyeXB0bzogUmVuYW1lIGNpcGhlciBpbmNsdWRlIGZpbGVzIHRvIC5p
bmMuYwo0YmExMzZmIGNyeXB0bzogQXNzdW1lIGJsb2Nrc2l6ZSBpcyBhIHBvd2VyIG9mIDIKYmYz
MDVlMiBjcnlwdG86IE1vdmUgUUNyeXB0b0NpcGhlckRyaXZlciB0eXBlZGVmIHRvIHFlbXUvdHlw
ZWRlZnMuaAo2ODA5NTRlIGNyeXB0bzogTW92ZSBRQ3J5cHRvQ2lwaGVyIHR5cGVkZWYgdG8gcWVt
dS90eXBlZGVmcy5oCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzE3IENoZWNraW5nIGNvbW1pdCA2
ODA5NTRlMTliNDQgKGNyeXB0bzogTW92ZSBRQ3J5cHRvQ2lwaGVyIHR5cGVkZWYgdG8gcWVtdS90
eXBlZGVmcy5oKQoyLzE3IENoZWNraW5nIGNvbW1pdCBiZjMwNWUyOGZiNjUgKGNyeXB0bzogTW92
ZSBRQ3J5cHRvQ2lwaGVyRHJpdmVyIHR5cGVkZWYgdG8gcWVtdS90eXBlZGVmcy5oKQozLzE3IENo
ZWNraW5nIGNvbW1pdCA0YmExMzZmZDUwZjUgKGNyeXB0bzogQXNzdW1lIGJsb2Nrc2l6ZSBpcyBh
IHBvd2VyIG9mIDIpCjQvMTcgQ2hlY2tpbmcgY29tbWl0IDQ5MGZkMWJmNjM2OCAoY3J5cHRvOiBS
ZW5hbWUgY2lwaGVyIGluY2x1ZGUgZmlsZXMgdG8gLmluYy5jKQpXQVJOSU5HOiBhZGRlZCwgbW92
ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMx
NjogCnJlbmFtZSBmcm9tIGNyeXB0by9jaXBoZXItYnVpbHRpbi5jCgp0b3RhbDogMCBlcnJvcnMs
IDEgd2FybmluZ3MsIDE0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvMTcgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KNS8xNyBDaGVja2luZyBjb21taXQgZjdjMGYwNDg3N2JkIChjcnlwdG86IFJl
bW92ZSByZWR1bmRhbnQgaW5jbHVkZXMpCjYvMTcgQ2hlY2tpbmcgY29tbWl0IDhjNDM3NzUyMzUw
NCAoY3J5cHRvL25ldHRsZTogRml4IHh0c19lbmNyeXB0IGFyZ3VtZW50cykKNy8xNyBDaGVja2lu
ZyBjb21taXQgODFhYWE1NDg1NWM1IChjcnlwdG86IFVzZSB0aGUgY29ycmVjdCBjb25zdCB0eXBl
IGZvciBkcml2ZXIpCjgvMTcgQ2hlY2tpbmcgY29tbWl0IDkzZGMzOGEyYTQ2OCAoY3J5cHRvOiBB
bGxvY2F0ZSBRQ3J5cHRvQ2lwaGVyIHdpdGggdGhlIHN1YmNsYXNzKQo5LzE3IENoZWNraW5nIGNv
bW1pdCAwMWYxMjE1NzNjOGIgKGNyeXB0bzogTW92ZSBjaXBoZXItPmRyaXZlciBpbml0IHRvIHFj
cnlwdG9fKl9jaXBoZXJfY3R4X25ldykKMTAvMTcgQ2hlY2tpbmcgY29tbWl0IDYyOGFhOGFjNWZi
YyAoY3J5cHRvOiBDb25zdGlmeSBjaXBoZXIgZGF0YSB0YWJsZXMpCjExLzE3IENoZWNraW5nIGNv
bW1pdCBlZmUxMDA1OTViNjEgKGNyeXB0by9idWlsdGluOiBSZW1vdmUgb2RkLXNpemVkIEFFUyBi
bG9jayBoYW5kbGluZykKMTIvMTcgQ2hlY2tpbmcgY29tbWl0IDM3MDczNzBmNGY1MiAoY3J5cHRv
L2J1aWx0aW46IE1lcmdlIHFjcnlwdG9fY2lwaGVyX2Flc197ZWNiLCB4dHN9X3tlbiwgZGV9Y3J5
cHQpCjEzLzE3IENoZWNraW5nIGNvbW1pdCBjNjI4MTUwNGYxZGYgKGNyeXB0by9idWlsdGluOiBN
b3ZlIEFFU19jYmNfZW5jcnlwdCBpbnRvIGNpcGhlci1idWlsdGluLmluYy5jKQoxNC8xNyBDaGVj
a2luZyBjb21taXQgMTFhZWQ3NGJmNDUzIChjcnlwdG8vYnVpbHRpbjogU3BsaXQgYW5kIHNpbXBs
aWZ5IEFFU19lbmNyeXB0X2NiYykKMTUvMTcgQ2hlY2tpbmcgY29tbWl0IDgxYmYxOWJkZTU0YiAo
Y3J5cHRvL2J1aWx0aW46IFNwbGl0IFFDcnlwdG9DaXBoZXJCdWlsdGluIGludG8gc3ViY2xhc3Nl
cykKMTYvMTcgQ2hlY2tpbmcgY29tbWl0IGNhNzg3ZDljMzRkNCAoY3J5cHRvL25ldHRsZTogU3Bs
aXQgUUNyeXB0b0NpcGhlck5ldHRsZSBpbnRvIHN1YmNsYXNzZXMpCkVSUk9SOiBNYWNyb3Mgd2l0
aCBtdWx0aXBsZSBzdGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBhIGRvIC0gd2hpbGUg
bG9vcAojMjU3OiBGSUxFOiBjcnlwdG8vY2lwaGVyLW5ldHRsZS5pbmMuYzoyNTU6CisjZGVmaW5l
IERFRklORV9YVFMoTkFNRSwgVFlQRSwgQkxFTiwgRU5DUllQVCwgREVDUllQVCkgICAgICAgICAg
XAorICAgIFFFTVVfQlVJTERfQlVHX09OKEJMRU4gIT0gWFRTX0JMT0NLX1NJWkUpOyAgICAgICAg
ICAgICAgICAgIFwKKyAgICBERUZJTkVfX1hUUyhOQU1FLCBUWVBFLCBCTEVOLCBFTkNSWVBULCBE
RUNSWVBUKSAgICAgICAgICAgICBcCitzdGF0aWMgY29uc3Qgc3RydWN0IFFDcnlwdG9DaXBoZXJE
cml2ZXIgTkFNRSMjX2RyaXZlcl94dHMgPSB7ICAgXAorICAgIC5jaXBoZXJfZW5jcnlwdCA9IE5B
TUUjI19lbmNyeXB0X3h0cywgICAgICAgICAgICAgICAgICAgICAgIFwKKyAgICAuY2lwaGVyX2Rl
Y3J5cHQgPSBOQU1FIyNfZGVjcnlwdF94dHMsICAgICAgICAgICAgICAgICAgICAgICBcCisgICAg
LmNpcGhlcl9zZXRpdiA9IE5BTUUjI19zZXRpdiwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAorICAgIC5jaXBoZXJfZnJlZSA9IHFjcnlwdG9fY2lwaGVyX2N0eF9mcmVlLCAgICAgICAg
ICAgICAgICAgICAgIFwKK307Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDk3MyBsaW5l
cyBjaGVja2VkCgpQYXRjaCAxNi8xNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMTcvMTcg
Q2hlY2tpbmcgY29tbWl0IGEzOWQ0OTRhOTNjZSAoY3J5cHRvL2djcnlwdDogU3BsaXQgUUNyeXB0
b0NpcGhlckdjcnlwdCBpbnRvIHN1YmNsYXNzZXMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODEzMDMyNTM3LjI4ODg1OTMtMS1yaWNoYXJk
LmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

