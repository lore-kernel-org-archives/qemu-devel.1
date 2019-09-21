Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C61C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 06:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24182184C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 06:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24182184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBYzS-0007bG-3M
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 02:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBYyn-00079V-Tk
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 02:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBYym-0000YY-81
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 02:34:49 -0400
Resent-Date: Sat, 21 Sep 2019 02:34:49 -0400
Resent-Message-Id: <E1iBYym-0000YY-81@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBYym-0000YC-0A
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 02:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569047644; cv=none; d=zoho.com; s=zohoarc; 
 b=MIJeFJWwVXrKBKoIHQGgCzNGOG+d2AKc6wwFVNCvA4fqP7LdB5g1DjU8vZ/nUsllfBHssqhX+F1yXRkOUkTyl+SfhkrMQNeEXV2dlWBM/xZxp2o86C02h4MuTmUd6ODjcryWysEt5DAYAESbvYLzCtmz1FBe5hj4pKv65Bck64c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569047644;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=aN0UyKfx4jkQXAMDsTjtoayMHwkO9tSmVmzHlZHFEUY=; 
 b=hVO9THZdKE/JbSTHO51jZVTdvQ5gczIKFZ4AaCZe8orWcjvzO6vdIZakvJjYYx+xZBzI3vO4hy8stit1aocT/MZf4AEDALnEM/92QhRSX1fJUIncX3wD+skrelB/LSLr3fx9bHyKZCZiOp5xZFObf9IYyEEePeeKFF4hXorT1xY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569047642527842.811066983448;
 Fri, 20 Sep 2019 23:34:02 -0700 (PDT)
In-Reply-To: <20190920113329.16787-1-philmd@redhat.com>
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Message-ID: <156904764058.6626.16718843426590409762@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 20 Sep 2019 23:34:02 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, thuth@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 sw@weilnetz.de, philmd@redhat.com, qemu-devel@nongnu.org,
 juterry@microsoft.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyMDExMzMyOS4xNjc4
Ny0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDkyMDExMzMyOS4xNjc4Ny0xLXBoaWxtZEByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzNdIHRlc3Rpbmc6IEJ1aWxkIFdIUFggZW5hYmxl
ZCBiaW5hcmllcwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODdlYWRkYiAuc2hpcHBhYmxlLnltbDogQnVp
bGQgV0hQWCBlbmFibGVkIGJpbmFyaWVzCmU1ZDRiOTEgdGVzdHMvZG9ja2VyOiBBZGQgZmVkb3Jh
LXdpbjEwc2RrLWNyb3NzIGltYWdlCjUyY2ExNDAgdGFyZ2V0L2kzODY6IEZpeCBicm9rZW4gYnVp
bGQgd2l0aCBXSFBYIGVuYWJsZWQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBj
b21taXQgNTJjYTE0MDk3YjAxICh0YXJnZXQvaTM4NjogRml4IGJyb2tlbiBidWlsZCB3aXRoIFdI
UFggZW5hYmxlZCkKMi8zIENoZWNraW5nIGNvbW1pdCBlNWQ0YjkxYjU4Y2EgKHRlc3RzL2RvY2tl
cjogQWRkIGZlZG9yYS13aW4xMHNkay1jcm9zcyBpbWFnZSkKV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzg6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM4
MzogRklMRTogdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL3dpbjEwc2RrLWRsLnNoOjEyOgorQkFT
RV9VUkw9JChjdXJsIC0tc2lsZW50IC0taW5jbHVkZSAnaHR0cDovL2dvLm1pY3Jvc29mdC5jb20v
ZndsaW5rLz9wcmQ9MTE5NjYmcHZlcj0xLjAmcGxjaWQ9MHg0MDkmY2xjaWQ9MHg0MDkmYXI9V2lu
ZG93czEwJnNhcj1TREsmbzE9MTAuMC4xODM2Mi4xJyB8IHNlZCAtbkUgJ3NfTG9jYXRpb246ICgu
KikvXHJfXDFfcCcpL0luc3RhbGxlcnMKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwoj
ODg6IEZJTEU6IHRlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy93aW4xMHNkay1kbC5zaDoxNzoKKyAg
ICBDQUJfTkFNRT0kKG1zaWV4dHJhY3QgV2luZG93c1wgU0RLXCBEZXNrdG9wXCBIZWFkZXJzXCB4
ODYteDg2X2VuLXVzLm1zaSAzPiYxIDI+JjMgMz4mLXwgc2VkIC1uRSAic18uKkVycm9yIG9wZW5p
bmcgZmlsZSAkUFdELyguKik6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnlfXDFfcCIpCgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojOTU6IEZJTEU6IHRlc3RzL2RvY2tlci9kb2Nr
ZXJmaWxlcy93aW4xMHNkay1kbC5zaDoyNDoKK2ZvciBpbmMgaW4gIiR7V0lORElSfS9Qcm9ncmFt
IEZpbGVzL1dpbmRvd3MgS2l0cy8xMC9JbmNsdWRlLzEwLjAuMTgzNjIuMC91bSIvV2luSHYqOyBk
bwoKdG90YWw6IDIgZXJyb3JzLCAyIHdhcm5pbmdzLCA1OCBsaW5lcyBjaGVja2VkCgpQYXRjaCAy
LzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMyBDaGVja2luZyBjb21taXQgODdlYWRk
YmRkMzk4ICguc2hpcHBhYmxlLnltbDogQnVpbGQgV0hQWCBlbmFibGVkIGJpbmFyaWVzKQo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkyMDEx
MzMyOS4xNjc4Ny0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


