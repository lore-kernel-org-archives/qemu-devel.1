Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFCCC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3029620859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 10:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3029620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43135 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVCdF-0003Kz-CH
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 06:13:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVCcP-00031m-HW
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVCcN-00048g-LT
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:12:37 -0400
Resent-Date: Mon, 27 May 2019 06:12:37 -0400
Resent-Message-Id: <E1hVCcN-00048g-LT@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hVCcM-00046j-6Z
	for qemu-devel@nongnu.org; Mon, 27 May 2019 06:12:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558945558; cv=none; d=zoho.com; s=zohoarc; 
	b=J+4BazHW6C9A36lGuEhorRLJ4Yw2Bn/3rGgkZviWEQZyznQRW5/F4OnBBbtYkpKoQDPsmBLZ3s9JtwsERh/YFBp6Xo/IFjPit96U9XzEmcuZxajpKqz1hzvgk5+hvUbryMmUB7jvENRWJDyKKEPKdqNFLa66wyrsNnqlYThk35g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558945558;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=AcVOnz5i1XhSUTWzaydLEREbAJbbKvvTzabnmmgSE1E=; 
	b=i7TJ+MRhyLUsfAzJlhxc1w9MnOYzSqITZsxMaZHQuQaKFbtBqmz0tosI4GG46iv14V9jg+Ctic8dticUTKiDdAo2x39xRlWBQ1nu/o+4elLF3sRCMuyMmzHLGsgSFz7mE99AIDFhEdOmoc4i6f5P3IXkZ0udDL8bVmRbHiBrFwA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558945556868746.2980381314221;
	Mon, 27 May 2019 01:25:56 -0700 (PDT)
Message-ID: <155894555550.3183.17796312000148467282@d1b27de2824c>
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mehta.aaru20@gmail.com
Date: Mon, 27 May 2019 01:25:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add support for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com, saket.sinha89@gmail.com, stefanha@redhat.com,
	jusual@mail.ru, mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyNzA4MDMyNy4xMDc4
MC0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjMgMC84XSBBZGQg
c3VwcG9ydCBmb3IgaW9fdXJpbmcKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNTI3MDgw
MzI3LjEwNzgwLTEtbWVodGEuYWFydTIwQGdtYWlsLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3NWZjN2YxIGJsb2NrL2Zp
bGVwb3NpeDogZXh0ZW5kIHRvIHVzZSBpb191cmluZwpkMDNhZTM5IGJsb2NrZGV2OiBhY2NlcHQg
aW9fdXJpbmcgYXMgb3B0aW9uCmNhZTMwZWUgdXRpbC9hc3luYzogYWRkIGFpbyBpbnRlcmZhY2Vz
IGZvciBpb191cmluZwpmM2JlODA3IHN0dWJzOiBhZGQgc3R1YnMgZm9yIGlvX3VyaW5nIGludGVy
ZmFjZQo4NWMwM2RlIGJsb2NrL2lvX3VyaW5nOiBpbXBsZW1lbnRzIGludGVyZmFjZXMgZm9yIGlv
X3VyaW5nCjVjNGExNGEgYmxvY2svYmxvY2s6IGFkZCBCRFJWIGZsYWcgZm9yIGlvX3VyaW5nCjlh
NjU5NGQgcWFwaS9ibG9jay1jb3JlOiBhZGQgb3B0aW9uIGZvciBpb191cmluZwo0NjBjNzJkIGNv
bmZpZ3VyZTogcGVybWl0IHVzZSBvZiBpb191cmluZwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS84
IENoZWNraW5nIGNvbW1pdCA0NjBjNzJkMWE4ZGYgKGNvbmZpZ3VyZTogcGVybWl0IHVzZSBvZiBp
b191cmluZykKMi84IENoZWNraW5nIGNvbW1pdCA5YTY1OTRkYWE3NmMgKHFhcGkvYmxvY2stY29y
ZTogYWRkIG9wdGlvbiBmb3IgaW9fdXJpbmcpCjMvOCBDaGVja2luZyBjb21taXQgNWM0YTE0YTMw
MWY1IChibG9jay9ibG9jazogYWRkIEJEUlYgZmxhZyBmb3IgaW9fdXJpbmcpCjQvOCBDaGVja2lu
ZyBjb21taXQgODVjMDNkZTE2MTg2IChibG9jay9pb191cmluZzogaW1wbGVtZW50cyBpbnRlcmZh
Y2VzIGZvciBpb191cmluZykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShz
KSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNDk6IApuZXcgZmlsZSBtb2RlIDEw
MDY0NAoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAn
KCcKIzE5NjogRklMRTogYmxvY2svaW9fdXJpbmcuYzoxNDM6CisgICAgd2hpbGUoIXMtPmlvX3Eu
aW5fcXVldWUpIHsKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMyMDk6IEZJTEU6IGJsb2Nr
L2lvX3VyaW5nLmM6MTU2OgorICAgICAgICBpZiAocmV0IDw9IDApIHsgJAoKdG90YWw6IDIgZXJy
b3JzLCAxIHdhcm5pbmdzLCAzODcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC84IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo1LzggQ2hlY2tpbmcgY29tbWl0IGYzYmU4MDcwOGFkMSAoc3R1YnM6
IGFkZCBzdHVicyBmb3IgaW9fdXJpbmcgaW50ZXJmYWNlKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQg
b3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzNTog
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDQ2IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDUvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo2LzggQ2hl
Y2tpbmcgY29tbWl0IGNhZTMwZWUxMzg4ZiAodXRpbC9hc3luYzogYWRkIGFpbyBpbnRlcmZhY2Vz
IGZvciBpb191cmluZykKNy84IENoZWNraW5nIGNvbW1pdCBkMDNhZTM5YzMzMWMgKGJsb2NrZGV2
OiBhY2NlcHQgaW9fdXJpbmcgYXMgb3B0aW9uKQo4LzggQ2hlY2tpbmcgY29tbWl0IDc1ZmM3ZjFk
OGEzZSAoYmxvY2svZmlsZXBvc2l4OiBleHRlbmQgdG8gdXNlIGlvX3VyaW5nKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDUyNzA4MDMyNy4x
MDc4MC0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


