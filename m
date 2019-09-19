Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB9FC4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400A221924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400A221924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4jW-0007iC-4H
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB4Te-0007ch-QP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB4Tc-00070K-Ey
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:00:38 -0400
Resent-Date: Thu, 19 Sep 2019 18:00:37 -0400
Resent-Message-Id: <E1iB4Tc-00070K-Ey@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB4Ta-0006xL-Tq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568929522; cv=none; d=zoho.com; s=zohoarc; 
 b=GtoQde5MKAE6XVZf1Q3SdZbzhMtHdfy+EfyJ/M0NSOroZ+iDgZuRFXAJ/NtHKgiqVQQrdZH2KF9BrEjieLcd4ihXV4CBBProO6NRAdJSsbCVoM/vayrR6cnUzcCQIVkRnpd2FFQ0ISALE3VLcVz+o0av0F/LEtshmrRrKnJWNsY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568929522;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=uJlDRFVd4YFxQuABmiwO6OUNGdRvMui5uGwqXcPYV4Q=; 
 b=XctdeEl8sKOZPypmFMuaTJKvIou/l2XKjnMPc9fcgmbl1SgMNUepCtBUjT3pi8LmVhOt11DpXY6XgeljyuEMahFnV50m8p9ML9YC8EVLNyhOx+8CS/lLc/MKFdoUD84xl/4CigYVvgh8mu4yaQZ1iziF9J52i+ucWqULd9npjlM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568929521314583.9665974081732;
 Thu, 19 Sep 2019 14:45:21 -0700 (PDT)
In-Reply-To: <20190919070918.16059-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/4] Ui 20190919 patches
Message-ID: <156892952036.2125.13005753593339332862@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 19 Sep 2019 14:45:21 -0700 (PDT)
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTA3MDkxOC4xNjA1
OS0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDkxOTA3MDkxOC4xNjA1OS0xLWtyYXhlbEByZWRo
YXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUFVMTCAwLzRdIFVpIDIwMTkwOTE5IHBhdGNo
ZXMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhjMjM0MDMgdm5jOiBmaXggbWVtb3J5IGxlYWsgd2hlbiB2
bmMgZGlzY29ubmVjdAo0M2E4YmRiIHVpOiBhZGQgYW4gZW1iZWRkZWQgQmFycmllciBjbGllbnQK
N2RjNmY0YyB2bmM6IGZpeCB3ZWJzb2NrZXQgZmllbGQgaW4gZXZlbnRzCmFjYTZhNGEgdWkvZWds
OiBmaXggZnJhbWVidWZmZXIgcmVhZHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2lu
ZyBjb21taXQgYWNhNmE0YWIxNjkzICh1aS9lZ2w6IGZpeCBmcmFtZWJ1ZmZlciByZWFkcykKMi80
IENoZWNraW5nIGNvbW1pdCA3ZGM2ZjRjYWEyZWYgKHZuYzogZml4IHdlYnNvY2tldCBmaWVsZCBp
biBldmVudHMpCjMvNCBDaGVja2luZyBjb21taXQgNDNhOGJkYjFmN2U2ICh1aTogYWRkIGFuIGVt
YmVkZGVkIEJhcnJpZXIgY2xpZW50KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM2MDogCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDEyMzkgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjQvNCBDaGVja2luZyBjb21t
aXQgOGMyMzQwMzlhMzRlICh2bmM6IGZpeCBtZW1vcnkgbGVhayB3aGVuIHZuYyBkaXNjb25uZWN0
KQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4QikKIzEyMDog
RklMRTogdWkvdm5jLWVuYy10aWdodC5jOjM1NToKKyAgICAgICAgZGF0YSA9ICh1aW50IyNicHAj
I190ICopdnMtPnRpZ2h0LT50aWdodC5idWZmZXI7ICAgICAgICAgICAgICAgIFwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgODY5
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTkw
NzA5MTguMTYwNTktMS1rcmF4ZWxAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


