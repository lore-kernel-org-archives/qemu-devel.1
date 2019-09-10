Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E7C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A502089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A502089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7iCL-0000YB-AI
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7iBF-00086Q-1r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7iBD-0002Je-B1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:35:44 -0400
Resent-Date: Tue, 10 Sep 2019 11:35:44 -0400
Resent-Message-Id: <E1i7iBD-0002Je-B1@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7iBD-0002HI-2T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:35:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568129697; cv=none; d=zoho.com; s=zohoarc; 
 b=H9jIciNrD1uaqf9CWy/Au9eW9ko4EF6/4j7EqwXMhY1Zr4Fga2dBne+b55eL5F4x3cRu43hAyq/jLem+aUmtUAy02dxIb4OD6iI5QqLYPb+3+nUtH71pE4UIoNqL0SQwcnCDIEbrOfxfQDReb5roZQnZhN9A8rcUyHPRXc+nwBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568129697;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ppU7iMJm6yN8g2SnO/le4m7il55rr3yjSyxDs1wENAc=; 
 b=OQKVNADLBLrbuUHLkYENQc9faYoSCnYKebELlcHfY/hz2K2CRwCKg3K6W1kuwoP9I3BydwloSB3BgWvtIaC2AZrHlDmszh6AVsq8fbU2NVntLyy+7ZYqs3Zi6MUKB1AedmKZ/AoXWDSS0aInq3esKmcQDsUV41FENnOIysfXmFE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568129694141879.5348139758887;
 Tue, 10 Sep 2019 08:34:54 -0700 (PDT)
In-Reply-To: <20190910113323.17324-1-laurent@vivier.eu>
Message-ID: <156812969067.15880.16310464239099431797@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 10 Sep 2019 08:34:54 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v10 0/9] hw/m68k: add Apple Machintosh
 Quadra 800 machine
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
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 mreitz@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDExMzMyMy4xNzMy
NC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxMCAwLzldIGh3L202OGs6
IGFkZCBBcHBsZSBNYWNoaW50b3NoIFF1YWRyYSA4MDAgbWFjaGluZQpNZXNzYWdlLWlkOiAyMDE5
MDkxMDExMzMyMy4xNzMyNC0xLWxhdXJlbnRAdml2aWVyLmV1ClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKZTYxZWU1MiBody9tNjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKMTc1YWI5
MSBody9tNjhrOiBhZGQgYSBkdW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyCjU4NjY3MjAgaHcv
bTY4azogYWRkIE51YnVzIHN1cHBvcnQgZm9yIG1hY2ZiIHZpZGVvIGNhcmQKNGYzMGZiNSBody9t
NjhrOiBhZGQgTnVidXMgc3VwcG9ydApmYTZlODQ3IGh3L202OGs6IGFkZCBtYWNmYiB2aWRlbyBj
YXJkCjM2M2FmNTggaHcvbTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9ydCBmb3IgdmlhCjNj
MDU4MGQgaHcvbTY4azogYWRkIHZpYSBzdXBwb3J0CjA2NjQ4YTIgZHA4MzkzeDogbWFuYWdlIGJp
ZyBlbmRpYW4gYnVzCjBiYTlkODUgZXNwOiBhZGQgcHNldWRvLURNQSBhcyB1c2VkIGJ5IE1hY2lu
dG9zaAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCAwYmE5ZDg1YWVl
NzAgKGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gpCjIvOSBDaGVja2lu
ZyBjb21taXQgMDY2NDhhMmY5ZDQyIChkcDgzOTN4OiBtYW5hZ2UgYmlnIGVuZGlhbiBidXMpCjMv
OSBDaGVja2luZyBjb21taXQgM2MwNTgwZGZiOTNkIChody9tNjhrOiBhZGQgdmlhIHN1cHBvcnQp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzc3OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBzcGFj
ZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyYmJyAoY3R4Old4VykKIzQyNjogRklMRTogaHcvbWlz
Yy9tYWNfdmlhLmM6MzQ1OgorICAgICAgICBpZiAoISh2MXMtPmxhc3RfYiAmIFZJQTFCX3ZSVEND
bGspICYmIChzLT5iICYgVklBMUJfdlJUQ0NsaykpIHsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDg2NyBs
aW5lcyBjaGVja2VkCgpQYXRjaCAzLzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvOSBD
aGVja2luZyBjb21taXQgMzYzYWY1OGFlY2QxIChody9tNjhrOiBpbXBsZW1lbnQgQURCIGJ1cyBz
dXBwb3J0IGZvciB2aWEpCjUvOSBDaGVja2luZyBjb21taXQgZmE2ZTg0NzQ0MGIzIChody9tNjhr
OiBhZGQgbWFjZmIgdmlkZW8gY2FyZCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjg6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MTggbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggNS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvOSBDaGVja2luZyBjb21t
aXQgNGYzMGZiNWY0MjhhIChody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydCkKV0FSTklORzogYWRk
ZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0
aW5nPwojNjI6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5p
bmdzLCA1MzIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCjcvOSBDaGVja2luZyBjb21taXQgNTg2NjcyMGQ0Mjc1IChody9tNjhrOiBhZGQgTnVidXMg
c3VwcG9ydCBmb3IgbWFjZmIgdmlkZW8gY2FyZCkKOC85IENoZWNraW5nIGNvbW1pdCAxNzVhYjkx
NDUxMTIgKGh3L202OGs6IGFkZCBhIGR1bW15IFNXSU0gZmxvcHB5IGNvbnRyb2xsZXIpCldBUk5J
Tkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVl
ZCB1cGRhdGluZz8KIzUzOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywg
MSB3YXJuaW5ncywgNTkxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgo5LzkgQ2hlY2tpbmcgY29tbWl0IGU2MWVlNTI0MzE0ZCAoaHcvbTY4azogZGVm
aW5lIE1hY2ludG9zaCBRdWFkcmEgODAwKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRl
ZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM3MDogCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUxOCBsaW5lcyBjaGVj
a2VkCgpQYXRjaCA5LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTAxMTMzMjMuMTczMjQt
MS1sYXVyZW50QHZpdmllci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


