Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B124C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7470D208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7470D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxYR-0003Ai-IY
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlxYC-0002eI-Cp
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlxYB-0001Va-1u
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:33:32 -0400
Resent-Date: Fri, 12 Jul 2019 11:33:32 -0400
Resent-Message-Id: <E1hlxYB-0001Va-1u@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlxYA-0001Um-QD; Fri, 12 Jul 2019 11:33:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562945591; cv=none; d=zoho.com; s=zohoarc; 
 b=cJTAsDXVvOtItAXjC8x9wcxksjZxLyWiuFGyeQPoDDNNvqUUF918koC9F1JoCI/I8j4WqHtf4ZMuFdiYiygo9mX5EmvGJNwbfRZ/UAAuIQyErSZsmSk+kBxROyuHXBr+z3P+8TXVjMTcqBYqVH3bnvn2kuNuCixnQEmk8/g69J0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562945591;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=euX8ID37FZ3IFdAHlV7SHjGpsKVEmPU2QPD/buaLTyQ=; 
 b=ScP5NE+oCdGA1MD++TrurwcCI36IAwFU321c9GCxrstQzHG2zTjruzwvBl0cbkO1Ci5HiNZvY0yoqAVp47gmwhvy57WOcmSx91itloaB6J/fpW2cGWtStV7wXVmP5Oea4ly3E84e9cCA2TMSpcOJ/yMjAMhmFpeLUmRwgjON4jI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562945590045382.0952046288247;
 Fri, 12 Jul 2019 08:33:10 -0700 (PDT)
Message-ID: <156294558894.12463.7436293434741250585@c4a48874b076>
In-Reply-To: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mdroth@linux.vnet.ibm.com
Date: Fri, 12 Jul 2019 08:33:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] spapr: Implement H_TPM_COMM for
 accessing host TPM device
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
Cc: qemu-ppc@nongnu.org, linuxram@us.ibm.com, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMjAxMTkzNC4yOTg2
My0xLW1kcm90aEBsaW51eC52bmV0LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNzEyMDExOTM0LjI5ODYzLTEtbWRy
b3RoQGxpbnV4LnZuZXQuaWJtLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxd
IFtSRkMgUEFUQ0ggMC8yXSBzcGFwcjogSW1wbGVtZW50IEhfVFBNX0NPTU0gZm9yIGFjY2Vzc2lu
ZyBob3N0IFRQTSBkZXZpY2UKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjEyYjgwNTVhMTkgc3BhcHI6IGluaXRpYWwg
aW1wbGVtZW50YXRpb24gZm9yIEhfVFBNX0NPTU0gaGNhbGwKNDdjODg0MTU2NCBkb2NzL3NwZWNz
OiBpbml0aWFsIHNwZWMgc3VtbWFyeSBmb3IgVWx0cmF2aXNvci1yZWxhdGVkIGhjYWxscwoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCA0N2M4ODQxNTY0NTIgKGRvY3Mv
c3BlY3M6IGluaXRpYWwgc3BlYyBzdW1tYXJ5IGZvciBVbHRyYXZpc29yLXJlbGF0ZWQgaGNhbGxz
KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlO
RVJTIG5lZWQgdXBkYXRpbmc/CiMxODogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBl
cnJvcnMsIDEgd2FybmluZ3MsIDc0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoyLzIgQ2hlY2tpbmcgY29tbWl0IDEyYjgwNTVhMTkwNSAoc3BhcHI6
IGluaXRpYWwgaW1wbGVtZW50YXRpb24gZm9yIEhfVFBNX0NPTU0gaGNhbGwpCldBUk5JTkc6IGxp
bmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM2MzogRklMRTogaHcvcHBjL3NwYXByLmM6MzM1NDoKK3N0
YXRpYyB2b2lkIHNwYXByX3NldF90cG1fZGV2aWNlX2ZpbGUoT2JqZWN0ICpvYmosIGNvbnN0IGNo
YXIgKnZhbHVlLCBFcnJvciAqKmVycnApCgpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRl
ZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM5MDogCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CgpFUlJPUjogRXJyb3IgbWVzc2FnZXMgc2hvdWxkIG5vdCBjb250YWluIG5l
d2xpbmVzCiMxMzc6IEZJTEU6IGh3L3BwYy9zcGFwcl9oY2FsbF90cG0uYzo0MzoKKyAgICAgICAg
ZXJyb3JfcmVwb3J0KCJpbnZhbGlkIFRQTSBpbnB1dCBidWZmZXIgc2l6ZTogIiBUQVJHRVRfRk1U
X2x1ICJcbiIsCgpFUlJPUjogRXJyb3IgbWVzc2FnZXMgc2hvdWxkIG5vdCBjb250YWluIG5ld2xp
bmVzCiMxNDM6IEZJTEU6IGh3L3BwYy9zcGFwcl9oY2FsbF90cG0uYzo0OToKKyAgICAgICAgZXJy
b3JfcmVwb3J0KCJpbnZhbGlkIFRQTSBvdXRwdXQgYnVmZmVyIHNpemU6ICIgVEFSR0VUX0ZNVF9s
dSAiXG4iLAoKRVJST1I6IHN3aXRjaCBhbmQgY2FzZSBzaG91bGQgYmUgYXQgdGhlIHNhbWUgaW5k
ZW50CiMyMDI6IEZJTEU6IGh3L3BwYy9zcGFwcl9oY2FsbF90cG0uYzoxMDg6CisgICAgc3dpdGNo
IChvcCkgeworICAgICAgICBjYXNlIFRQTV9DT01NX09QX0VYRUNVVEU6ClsuLi5dCisgICAgICAg
IGNhc2UgVFBNX0NPTU1fT1BfQ0xPU0VfU0VTU0lPTjoKWy4uLl0KKyAgICAgICAgZGVmYXVsdDoK
CnRvdGFsOiAzIGVycm9ycywgMiB3YXJuaW5ncywgMjIzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIv
MiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA3MTIwMTE5MzQuMjk4NjMtMS1tZHJvdGhAbGlu
dXgudm5ldC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


