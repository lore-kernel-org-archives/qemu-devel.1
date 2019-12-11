Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD2C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B48221556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B48221556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3Ma-0008Dp-6h
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1if3Lh-0007Iy-5A
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1if3Lf-0003A3-Jn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:52:20 -0500
Resent-Date: Wed, 11 Dec 2019 09:52:20 -0500
Resent-Message-Id: <E1if3Lf-0003A3-Jn@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1if3Lf-00037t-BZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:52:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576075929; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JPWSFYaNBIAkPK4GsxxM70FuvEXIZfuQ4v3YvrHKbQ9vWMZ5cBwtR608tMO2i4R92+TVwNGu3GM94Q175BISHPitVAh9W8e33qDIFMiYBu+rQK8mZ4407N3SU8UK2JGWiYtw4jFPHso8Nb3Pvbf9rX+ATKHZydLcEZX4HjIVMOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1576075929;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PafoABYQeTOT4ziBYq72cRBIpzjYbMkukMCfaND1XKE=; 
 b=Ntvt2SyiKqoCDhgbQ8Aq+1CIbNdL4wPZR5NBNRklAT/UPbZdQ/Dqi7fAHoaL68qRhBqTPo1Km2YI6ckf3ed/Csu6SjQXigyAfaxiyjmFAumEacoUNCwa2M9hvKE/w3XIEy3NR3Elu2nkgV6g5LX6/yxxzqjLiEQ61V1sSzoq/GQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1576075927728957.7024783677376;
 Wed, 11 Dec 2019 06:52:07 -0800 (PST)
In-Reply-To: <1576074600-54759-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [PATCH] ci: build out-of-tree
Message-ID: <157607592675.3982.16415486340044842705@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Wed, 11 Dec 2019 06:52:07 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc2MDc0NjAwLTU0NzU5LTEt
Z2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBjaTogYnVpbGQgb3V0LW9m
LXRyZWUKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzYwNzQ2MDAtNTQ3NTktMS1naXQtc2Vu
ZC1lbWFpbC1wYm9uemluaUByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKZXJyb3I6IHVuYWJsZSB0byB3cml0ZSBmaWxlIGJsb2NrL3Fjb3cyLmMKZmF0YWw6
IHVuYWJsZSB0byBjaGVja291dCB3b3JraW5nIHRyZWUKd2FybmluZzogQ2xvbmUgc3VjY2VlZGVk
LCBidXQgY2hlY2tvdXQgZmFpbGVkLgpZb3UgY2FuIGluc3BlY3Qgd2hhdCB3YXMgY2hlY2tlZCBv
dXQgd2l0aCAnZ2l0IHN0YXR1cycKYW5kIHJldHJ5IHRoZSBjaGVja291dCB3aXRoICdnaXQgY2hl
Y2tvdXQgLWYgSEVBRCcKClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxl
ICJwYXRjaGV3LXRlc3RlcjIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA1MzEsIGluIHRlc3Rfb25l
CiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YsIFRy
dWUpCiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNjIsIGlu
IGdpdF9jbG9uZV9yZXBvCiAgICBzdWJwcm9jZXNzLmNoZWNrX2NhbGwoY2xvbmVfY21kLCBzdGRl
cnI9bG9nZiwgc3Rkb3V0PWxvZ2YpCiAgRmlsZSAiL29wdC9yaC9yaC1weXRob24zNi9yb290L3Vz
ci9saWI2NC9weXRob24zLjYvc3VicHJvY2Vzcy5weSIsIGxpbmUgMjkxLCBpbiBjaGVja19jYWxs
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAnY2xvbmUnLCAnLXEnLCAnL2hvbWUv
cGF0Y2hldzIvLmNhY2hlL3BhdGNoZXctZ2l0LWNhY2hlL2h0dHBzZ2l0aHViY29tcGF0Y2hld3By
b2plY3RxZW11LTNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXZrY294czluL3NyYyddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAxMjguCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMTU3NjA3NDYwMC01NDc1OS0xLWdpdC1zZW5kLWVtYWlsLXBib256
aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


