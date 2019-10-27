Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E72CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 03:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCF520717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 03:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF520717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOZXv-0002DH-31
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 23:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iOZXE-0000xq-5g
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 23:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iOZXC-0006DL-EM
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 23:48:07 -0400
Resent-Date: Sat, 26 Oct 2019 23:48:07 -0400
Resent-Message-Id: <E1iOZXC-0006DL-EM@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iOZXC-0006Ce-4s; Sat, 26 Oct 2019 23:48:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572148049; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BOvceUtwjmmd95QHUWvST1e0/SjU7llfD0kSWZgm6CN629+gdwU1GSz3yjd9uhcfBJY4jOyk5/45613GybBN6g/VNwtyJuZ3oaFVy0viSrYGsqVSbJLKYmM66WXnqdOJpBUKwIrSc+7w81pP9kULH5NaJ17yt0LZPRIjaeu4Kks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572148049;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=h7x9Tk1+6Ur7TWsgnjQVL4jkkEiMQ3Z0Xu6xUlbuumo=; 
 b=IwCWJ/MC7EnLLVM1QtgCnfIWU0p9bddIzsuxQchO2TGISptCqIbu0QtuTrWtWzX5QSasZC2zOmnuv6CkrotPuGZ8e6tUPwet/oJXwMKrINs2NlYn+kI1iZ2qQ8a1eH15Inm6xdjYiGl0IBUnAEzIjS5F7h6l1HLrSwvlFYTwDKk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572148047542462.07605722344124;
 Sat, 26 Oct 2019 20:47:27 -0700 (PDT)
In-Reply-To: <20191026164546.30020-1-laurent@vivier.eu>
Subject: Re: [PATCH v15 00/11] hw/m68k: add Apple Machintosh Quadra 800 machine
Message-ID: <157214804554.8606.15788168693862921301@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Sat, 26 Oct 2019 20:47:27 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 laurent@vivier.eu, aurelien@aurel32.net, hpoussin@reactos.org,
 kraxel@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, philmd@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNjE2NDU0Ni4zMDAy
MC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjE1IDAwLzExXSBody9tNjhrOiBhZGQgQXBwbGUg
TWFjaGludG9zaCBRdWFkcmEgODAwIG1hY2hpbmUKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIw
MTkxMDI2MTY0NTQ2LjMwMDIwLTEtbGF1cmVudEB2aXZpZXIuZXUKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjZhMzM3
MTUgQm9vdExpbnV4Q29uc29sZVRlc3Q6IFRlc3QgdGhlIFF1YWRyYSA4MDAKMDBmY2I1ZSBody9t
NjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKMGZkMzIwYSBody9tNjhrOiBhZGQgYSBk
dW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyCmIyNzY5ZWQgaHcvbTY4azogYWRkIE51YnVzIG1h
Y2ZiIHZpZGVvIGNhcmQKNGQ0YjYyNCBody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydAowYWVhMGU2
IGh3L202OGs6IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZpYQpiMTdlZDFmIGh3L202
OGs6IGFkZCBWSUEgc3VwcG9ydApjN2U4MTlmIGRwODM5M3g6IG1hbmFnZSBiaWcgZW5kaWFuIGJ1
cwo2Y2NhZWJkIGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gKMDFjYjQ5
MiBlc3A6IG1vdmUgZ2V0X2NtZCgpIHBvc3QtRE1BIGNvZGUgdG8gZ2V0X2NtZF9jYigpCjU1ZTc4
ZDkgZXNwOiBtb3ZlIGhhbmRsZV90aV9jbWQoKSBjbGVhbnVwIGNvZGUgdG8gZXNwX2RvX2RtYSgp
LgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2luZyBjb21taXQgNTVlNzhkOWQ5Y2Rl
IChlc3A6IG1vdmUgaGFuZGxlX3RpX2NtZCgpIGNsZWFudXAgY29kZSB0byBlc3BfZG9fZG1hKCku
KQoyLzExIENoZWNraW5nIGNvbW1pdCAwMWNiNDkyYjBlNmIgKGVzcDogbW92ZSBnZXRfY21kKCkg
cG9zdC1ETUEgY29kZSB0byBnZXRfY21kX2NiKCkpCjMvMTEgQ2hlY2tpbmcgY29tbWl0IDZjY2Fl
YmQ4ZWVmNyAoZXNwOiBhZGQgcHNldWRvLURNQSBhcyB1c2VkIGJ5IE1hY2ludG9zaCkKNC8xMSBD
aGVja2luZyBjb21taXQgYzdlODE5ZjZmMjZmIChkcDgzOTN4OiBtYW5hZ2UgYmlnIGVuZGlhbiBi
dXMpCjUvMTEgQ2hlY2tpbmcgY29tbWl0IGIxN2VkMWZhZjUzMiAoaHcvbTY4azogYWRkIFZJQSBz
dXBwb3J0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1B
SU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM4MzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJP
Ujogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0ICcmJicgKGN0eDpXeFcpCiM0NTU6IEZJTEU6
IGh3L21pc2MvbWFjX3ZpYS5jOjM2ODoKKyAgICAgICAgaWYgKCEodjFzLT5sYXN0X2IgJiBWSUEx
Ql92UlRDQ2xrKSAmJiAocy0+YiAmIFZJQTFCX3ZSVENDbGspKSB7CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdz
LCA5MTIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKNi8xMSBDaGVja2luZyBjb21taXQgMGFlYTBlNmNjNzg3IChody9tNjhrOiBpbXBsZW1lbnQg
QURCIGJ1cyBzdXBwb3J0IGZvciB2aWEpCjcvMTEgQ2hlY2tpbmcgY29tbWl0IDRkNGI2MjQ4NWMx
NCAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzY0OiAKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTMxIGxpbmVz
IGNoZWNrZWQKClBhdGNoIDcvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC8xMSBDaGVj
a2luZyBjb21taXQgYjI3NjllZDg4MjRmIChody9tNjhrOiBhZGQgTnVidXMgbWFjZmIgdmlkZW8g
Y2FyZCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlO
VEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNzU6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6
IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1OTcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xMSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgo5LzExIENoZWNraW5nIGNvbW1pdCAwZmQzMjBhMGI5NmUg
KGh3L202OGs6IGFkZCBhIGR1bW15IFNXSU0gZmxvcHB5IGNvbnRyb2xsZXIpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzYyOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJu
aW5ncywgNTkzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDkvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KMTAvMTEgQ2hlY2tpbmcgY29tbWl0IDAwZmNiNWU2NjE5NiAoaHcvbTY4azogZGVmaW5l
IE1hY2ludG9zaCBRdWFkcmEgODAwKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM3MTogCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUzNyBsaW5lcyBjaGVja2Vk
CgpQYXRjaCAxMC8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoxMS8xMSBDaGVja2luZyBj
b21taXQgNmEzMzcxNTNkMjcxIChCb290TGludXhDb25zb2xlVGVzdDogVGVzdCB0aGUgUXVhZHJh
IDgwMCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTEwMjYxNjQ1NDYuMzAwMjAtMS1sYXVyZW50QHZpdmllci5ldS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


