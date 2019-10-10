Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E0DC47404
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C64C2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 01:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIMsD-0001Ml-E3
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 21:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIMrR-0000pL-5A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIMrO-0002D5-G1
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 21:03:21 -0400
Resent-Date: Wed, 09 Oct 2019 21:03:21 -0400
Resent-Message-Id: <E1iIMrO-0002D5-G1@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIMrL-0002AK-2m; Wed, 09 Oct 2019 21:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570669368; cv=none; d=zoho.com; s=zohoarc; 
 b=hGS7JRHQ0sgLwmwgp5iyPK1+Zyw+x8OEy85NqyN7WspzHTOjHhj4fcaHL34+tS8PU0pYlYT+bm5ZhquB8RSsY5ViUIAggFnMQC8fhYLxANT0vzgaTLsYQIxqyyRfqLM+L34J7mknwCwZzxuiHcO6J1n+2xubdUh3CyDLU0H62iY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570669368;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=S1CRw0RF9/duYYlb2rnTvHzlKEQGuZ/CCBbO7yY3ffo=; 
 b=E0dRbeC0mUPvKD3ByNW1ItgcB3CCDW0cOoSsbFfkK1M9wAMDqSiRGWf5y06pgz8aFwiQCu7aWUn/PA3x7XOeeGUAHwqnHKUDMZjvrpIMX1D3zcZq+hSq9ehBGhLDUjuoauaEyJdyQtejsop5Go3yvnhsXZq9AOHmITGUQMlAUvo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570669367545610.0982852965093;
 Wed, 9 Oct 2019 18:02:47 -0700 (PDT)
In-Reply-To: <20191009091010.16467-1-ganeshgr@linux.ibm.com>
Subject: Re: [PATCH v15 0/7] target-ppc/spapr: Add FWNMI support in QEMU for
 PowerKVM guests
Message-ID: <157066936591.7138.5367488692731550059@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ganeshgr@linux.ibm.com
Date: Wed, 9 Oct 2019 18:02:47 -0700 (PDT)
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
Cc: arawinda.p@gmail.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org, ganeshgr@linux.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwOTA5MTAxMC4xNjQ2
Ny0xLWdhbmVzaGdyQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MTUgMC83XSB0YXJnZXQtcHBjL3NwYXBy
OiBBZGQgRldOTUkgc3VwcG9ydCBpbiBRRU1VIGZvciBQb3dlcktWTSBndWVzdHMKVHlwZTogc2Vy
aWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMDA5MDkxMDEwLjE2NDY3LTEtZ2FuZXNoZ3JAbGludXguaWJt
LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwpkMzcyNTJjIHBwYzogc3BhcHI6IEFjdGl2YXRlIHRoZSBGV05NSSBmdW5jdGlv
bmFsaXR5CmMzNTI2MzcgbWlncmF0aW9uOiBJbmNsdWRlIG1pZ3JhdGlvbiBzdXBwb3J0IGZvciBt
YWNoaW5lIGNoZWNrIGhhbmRsaW5nCmMxZTA0NzIgcHBjOiBzcGFwcjogSGFuZGxlICJpYm0sIG5t
aS1yZWdpc3RlciIgYW5kICJpYm0sIG5taS1pbnRlcmxvY2siIFJUQVMgY2FsbHMKZGFmZDNhYiB0
YXJnZXQvcHBjOiBCdWlsZCBydGFzIGVycm9yIGxvZyB1cG9uIGFuIE1DRQoxZGU5NzVmIHRhcmdl
dC9wcGM6IEhhbmRsZSBOTUkgZ3Vlc3QgZXhpdApjNDk0ODcxIHBwYzogc3BhcHI6IEludHJvZHVj
ZSBGV05NSSBjYXBhYmlsaXR5CmJiZDhkNWYgV3JhcHBlciBmdW5jdGlvbiB0byB3YWl0IG9uIGNv
bmRpdGlvbiBmb3IgdGhlIG1haW4gbG9vcCBtdXRleAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS83
IENoZWNraW5nIGNvbW1pdCBiYmQ4ZDVmNGQ3N2IgKFdyYXBwZXIgZnVuY3Rpb24gdG8gd2FpdCBv
biBjb25kaXRpb24gZm9yIHRoZSBtYWluIGxvb3AgbXV0ZXgpCjIvNyBDaGVja2luZyBjb21taXQg
YzQ5NDg3MTYxMGI4IChwcGM6IHNwYXByOiBJbnRyb2R1Y2UgRldOTUkgY2FwYWJpbGl0eSkKV0FS
TklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzU3OiBGSUxFOiBody9wcGMvc3BhcHJfY2Fw
cy5jOjUxMToKKyAgICAgICAgd2Fybl9yZXBvcnQoIkZpcm13YXJlIEFzc2lzdGVkIE5vbi1NYXNr
YWJsZSBJbnRlcnJ1cHRzIG5vdCBzdXBwb3J0ZWQgaW4gVENHIik7Cgp0b3RhbDogMCBlcnJvcnMs
IDEgd2FybmluZ3MsIDk3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNyBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgozLzcgQ2hlY2tpbmcgY29tbWl0IDFkZTk3NWY5OWU0NSAodGFyZ2V0L3BwYzog
SGFuZGxlIE5NSSBndWVzdCBleGl0KQo0LzcgQ2hlY2tpbmcgY29tbWl0IGRhZmQzYWIwZmNkZCAo
dGFyZ2V0L3BwYzogQnVpbGQgcnRhcyBlcnJvciBsb2cgdXBvbiBhbiBNQ0UpCkVSUk9SOiBzcGFj
ZSByZXF1aXJlZCBhZnRlciB0aGF0IGNsb3NlIGJyYWNlICd9JwojOTg6IEZJTEU6IGh3L3BwYy9z
cGFwcl9ldmVudHMuYzoyODI6CisgIFJUQVNfTE9HX0lOSVRJQVRPUl9DUFUsIFJUQVNfTE9HX1NF
VkVSSVRZX0VSUk9SX1NZTkMsIH19OwoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQg
Y2xvc2UgYnJhY2UgJ30nCiMxMjc6IEZJTEU6IGh3L3BwYy9zcGFwcl9ldmVudHMuYzozMTE6Cisg
IFJUQVNfTE9HX0lOSVRJQVRPUl9DUFUsIFJUQVNfTE9HX1NFVkVSSVRZX0VSUk9SX1NZTkMsIH19
OwoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAzMDQgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
NC83IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzcgQ2hlY2tpbmcgY29tbWl0IGMxZTA0
NzI2NDJiMSAocHBjOiBzcGFwcjogSGFuZGxlICJpYm0sIG5taS1yZWdpc3RlciIgYW5kICJpYm0s
IG5taS1pbnRlcmxvY2siIFJUQVMgY2FsbHMpCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2
ZXIgdXNlIHRhYnMKIzM5OiBGSUxFOiBody9wcGMvc3BhcHJfY2Fwcy5jOjUxMzoKK15JaWYgKCFr
dm1wcGNfc2V0X2Z3bm1pKCkpIHskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiM0MDogRklMRTogaHcvcHBjL3NwYXByX2NhcHMuYzo1MTQ6CiteSSAgICAvKiBSZWdp
c3RlciBpYm0sbm1pLXJlZ2lzdGVyIGFuZCBpYm0sbm1pLWludGVybG9jayBSVEFTIGNhbGxzICov
JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDE6IEZJTEU6IGh3
L3BwYy9zcGFwcl9jYXBzLmM6NTE1OgorXkkgICAgc3BhcHJfZndubWlfcmVnaXN0ZXIoKTskCgpF
UlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MjogRklMRTogaHcvcHBj
L3NwYXByX2NhcHMuYzo1MTY6CiteSX0gZWxzZSB7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3Vs
ZCBuZXZlciB1c2UgdGFicwojNDM6IEZJTEU6IGh3L3BwYy9zcGFwcl9jYXBzLmM6NTE3OgorXkkg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNl
IHRhYnMKIzQ1OiBGSUxFOiBody9wcGMvc3BhcHJfY2Fwcy5jOjUxOToKK15JfSQKCnRvdGFsOiA2
IGVycm9ycywgMCB3YXJuaW5ncywgMTAxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvNyBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKNi83IENoZWNraW5nIGNvbW1pdCBjMzUyNjM3Mzk3Y2EgKG1p
Z3JhdGlvbjogSW5jbHVkZSBtaWdyYXRpb24gc3VwcG9ydCBmb3IgbWFjaGluZSBjaGVjayBoYW5k
bGluZykKNy83IENoZWNraW5nIGNvbW1pdCBkMzcyNTJjNzYzMjAgKHBwYzogc3BhcHI6IEFjdGl2
YXRlIHRoZSBGV05NSSBmdW5jdGlvbmFsaXR5KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAwOTA5MTAxMC4xNjQ2Ny0xLWdhbmVzaGdyQGxp
bnV4LmlibS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


