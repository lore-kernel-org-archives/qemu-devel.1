Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BABFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 01:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F361A2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 01:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F361A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ2ok-0007nY-0u
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 21:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZ2o6-00071Y-SY
 for qemu-devel@nongnu.org; Wed, 13 May 2020 21:37:07 -0400
Resent-Date: Wed, 13 May 2020 21:37:06 -0400
Resent-Message-Id: <E1jZ2o6-00071Y-SY@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZ2o5-0000kc-Nx
 for qemu-devel@nongnu.org; Wed, 13 May 2020 21:37:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589420220; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KA9D0GObSRmmfpaLZ0VjJt0WjFNvj9eTQnidTesXIj9t+PwbXOsSJDKTpcMdagn0zALFsGma0C3gKOKXk2MGc7SYVRMulEdLUMkgV+yem5C04IrvXsuVWw5eyL3KTpMdbyoer3yqRn3w/Hbwt9S55wtn3TWuXYkQRfCGjLcZJhw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589420220;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=27VV1POJLKgi4XfYxyu8S9vq01zznOnYT137/LTkBno=; 
 b=ECLv9AKM2at/dmnb/AWPm4+UGd/7k70d003uiNzW+lKM3sJtb/Cgv7geTqSA/RJiO84erc3S0VszFviZcEj0LyxJujuAcPN3aLE6TLIAsKjIL3S/apcm3b8QDdGUBwPAhUoLdNPaJfvZlH6Mu7OdKjQqbt9/zHuaX1LrT5FlTZY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589420218017872.2463296342837;
 Wed, 13 May 2020 18:36:58 -0700 (PDT)
Message-ID: <158942021704.13639.11632435484259378730@45ef0f9c86ae>
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/8] plugins/next (cleanup, cpu_index and lockstep)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 13 May 2020 18:36:58 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 20:56:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMzE3MzIwMC4xMTgz
MC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTEzMTczMjAwLjExODMwLTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFUQ0ggIHYxIDAvOF0gcGx1Z2lucy9uZXh0IChj
bGVhbnVwLCBjcHVfaW5kZXggYW5kIGxvY2tzdGVwKQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjZlZGQ3OTUgcGx1Z2luczogbmV3IGxvY2tzdGVwIHBsdWdpbiBmb3IgZGVidWdnaW5nIFRDRyBj
aGFuZ2VzCjQyMDJhNzMgdGVzdHMvdGNnOiBhZGQgbmV3IHRocmVhZGNvdW50IHRlc3QKMWY2ZjY2
NyBsaW51eC11c2VyOiBwcm9wZXJseSAidW5yZWFsaXplIiB2Q1BVIG9iamVjdAo2MjAwZGQ3IGNw
dXMtY29tbW9uOiBlbnN1cmUgYXV0by1hc3NpZ25lZCBjcHVfaW5kZXhlcyBkb24ndCBjbGFzaAo4
ODg0MDhmIE1BSU5UQUlORVJTOiB1cGRhdGUgdGhlIG9ycGhhbmVkIGNwdXMtY29tbW9uLmMgZmls
ZQo2Yzc4MTE2IHFlbXUvcWVtdS1wbHVnaW46IE1ha2UgcWVtdV9wbHVnaW5faHdhZGRyX2lzX2lv
KCkgaHdhZGRyIGFyZ3VtZW50IGNvbnN0CmNlNDMwZTAgcWVtdS9wbHVnaW46IE1vdmUgIUNPTkZJ
R19QTFVHSU4gc3R1YnMgYWx0b2dldGhlcgplNjlhOWNjIHFlbXUvcGx1Z2luOiBUcml2aWFsIGNv
ZGUgbW92ZW1lbnQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgZTY5
YTljYzY2ZTQ0IChxZW11L3BsdWdpbjogVHJpdmlhbCBjb2RlIG1vdmVtZW50KQoyLzggQ2hlY2tp
bmcgY29tbWl0IGNlNDMwZTAxZTFiMyAocWVtdS9wbHVnaW46IE1vdmUgIUNPTkZJR19QTFVHSU4g
c3R1YnMgYWx0b2dldGhlcikKMy84IENoZWNraW5nIGNvbW1pdCA2Yzc4MTE2MGM0Y2QgKHFlbXUv
cWVtdS1wbHVnaW46IE1ha2UgcWVtdV9wbHVnaW5faHdhZGRyX2lzX2lvKCkgaHdhZGRyIGFyZ3Vt
ZW50IGNvbnN0KQo0LzggQ2hlY2tpbmcgY29tbWl0IDg4ODQwOGYwZTcwMiAoTUFJTlRBSU5FUlM6
IHVwZGF0ZSB0aGUgb3JwaGFuZWQgY3B1cy1jb21tb24uYyBmaWxlKQo1LzggQ2hlY2tpbmcgY29t
bWl0IDYyMDBkZDc2OWUzMiAoY3B1cy1jb21tb246IGVuc3VyZSBhdXRvLWFzc2lnbmVkIGNwdV9p
bmRleGVzIGRvbid0IGNsYXNoKQo2LzggQ2hlY2tpbmcgY29tbWl0IDFmNmY2Njc5MWE4ZiAobGlu
dXgtdXNlcjogcHJvcGVybHkgInVucmVhbGl6ZSIgdkNQVSBvYmplY3QpCjcvOCBDaGVja2luZyBj
b21taXQgNDIwMmE3M2VjYjBlICh0ZXN0cy90Y2c6IGFkZCBuZXcgdGhyZWFkY291bnQgdGVzdCkK
V0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVS
UyBuZWVkIHVwZGF0aW5nPwojMzA6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IG9wZW4g
YnJhY2UgJ3snIGZvbGxvd2luZyBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgZ28gb24gdGhlIG5leHQg
bGluZQojNjI6IEZJTEU6IHRlc3RzL3RjZy9tdWx0aWFyY2gvdGhyZWFkY291bnQuYzoyODoKK3N0
YXRpYyB2b2lkICp0aHJlYWRfZm4odm9pZCogdmFyZykgIHsKCkVSUk9SOiAiZm9vKiBiYXIiIHNo
b3VsZCBiZSAiZm9vICpiYXIiCiM2MzogRklMRTogdGVzdHMvdGNnL211bHRpYXJjaC90aHJlYWRj
b3VudC5jOjI5OgorICAgIFRocmVhZEFyZyogYXJnID0gdmFyZzsKCkVSUk9SOiBvcGVuIGJyYWNl
ICd7JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUK
IzY5OiBGSUxFOiB0ZXN0cy90Y2cvbXVsdGlhcmNoL3RocmVhZGNvdW50LmM6MzU6CitpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsKCkVSUk9SOiAiZm9vKiBiYXIiIHNob3VsZCBiZSAi
Zm9vICpiYXIiCiM3OTogRklMRTogdGVzdHMvdGNnL211bHRpYXJjaC90aHJlYWRjb3VudC5jOjQ1
OgorICAgICAgICBUaHJlYWRBcmcqIGFyZyA9IGNhbGxvYyhzaXplb2YoVGhyZWFkQXJnKSwgMSk7
Cgp0b3RhbDogNCBlcnJvcnMsIDEgd2FybmluZ3MsIDcwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDcv
OCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOC84IENoZWNraW5nIGNvbW1pdCA2ZWRkNzk1
ZGQwYTQgKHBsdWdpbnM6IG5ldyBsb2Nrc3RlcCBwbHVnaW4gZm9yIGRlYnVnZ2luZyBUQ0cgY2hh
bmdlcykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlO
VEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6
ICJmb28gKiBiYXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCiMxNjM6IEZJTEU6IHRlc3RzL3BsdWdp
bi9sb2Nrc3RlcC5jOjEwMzoKK3N0YXRpYyBpbmxpbmUgY29uc3QgY2hhciAqIG9yZF9pbmQoaW50
IG4pIHsKCkVSUk9SOiBvcGVuIGJyYWNlICd7JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRp
b25zIGdvIG9uIHRoZSBuZXh0IGxpbmUKIzE2MzogRklMRTogdGVzdHMvcGx1Z2luL2xvY2tzdGVw
LmM6MTAzOgorc3RhdGljIGlubGluZSBjb25zdCBjaGFyICogb3JkX2luZChpbnQgbikgewoKV0FS
TklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzIyMDogRklMRTogdGVzdHMvcGx1Z2luL2xv
Y2tzdGVwLmM6MTYwOgorICAgICAgICAgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihvdXQsICIg
IHByZXZpb3VzbHkgQCAlIzAxNmx4LyVsZCAoJWxkIGluc25zKVxuIiwKCkVSUk9SOiBkbyBub3Qg
dXNlIEM5OSAvLyBjb21tZW50cwojMjkyOiBGSUxFOiB0ZXN0cy9wbHVnaW4vbG9ja3N0ZXAuYzoy
MzI6CisgICAgLy8gc2F2ZSBhIHJlZmVyZW5jZSBzbyB3ZSBjYW4gZnJlZSBsYXRlcgoKdG90YWw6
IDMgZXJyb3JzLCAyIHdhcm5pbmdzLCAzNjAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84IGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUxMzE3MzIwMC4xMTgzMC0xLWFsZXguYmVubmVlQGxpbmFy
by5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

