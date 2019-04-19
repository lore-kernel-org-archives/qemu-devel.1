Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D1C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E34A21908
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34A21908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHRw2-00025W-PQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 07:44:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hHRv5-0001TF-DL
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hHRfu-0003FK-HZ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:27:23 -0400
Resent-Date: Fri, 19 Apr 2019 07:27:23 -0400
Resent-Message-Id: <E1hHRfu-0003FK-HZ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hHRfu-0003Co-8X
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555670485; cv=none; d=zoho.com; s=zohoarc; 
	b=J+GMLxsAF5p3QGuoaH1N/wqwa2HBjDVOz+X7r5CGr6fXC//nFmUsb4dIzFGGfxI8xK3r187jkILzwCgw43ONhPQlFU4whYaziqZrw+om9Td0l5o6b3UkoJ6s+Uh+I8772s5XSBHc6ADunpuMZnAbuXnA/gYeBvg0Ry3fwNFE258=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555670485;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=i8zaLQ52Y1RB7MyCDchA6E/CMhuTI8yHPpQrSfj+yUI=; 
	b=NzmcHSzKp8qWUznTOE1It46UdeF3kC/m7VF8nTA1uKhrRN4a2CnIalsv5llzVQYbc7J4X5omSibltuTnHnJSt509a0bNIPZb9FnGLamzKFvpjy2nbNEE6w8d5/wRuxVXVJVshJg+WvRGFvCLSXlwNsXyCUGbw4uyEeKqc8kDSdM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 15556704838091016.8947978222806;
	Fri, 19 Apr 2019 03:41:23 -0700 (PDT)
In-Reply-To: <20190419103722.17062-1-shahab.vahedi@gmail.com>
Message-ID: <155567048223.24.9366683312010640413@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shahab.vahedi@gmail.com
Date: Fri, 19 Apr 2019 03:41:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
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
Cc: fam@euphon.net, shahab.vahedi@gmail.com, rth@twiddle.net,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419104123.uAMgN0XEvGUY0e33fHWhWHiU-HJSK218XaVhq5doYxE@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxOTEwMzcyMi4xNzA2
Mi0xLXNoYWhhYi52YWhlZGlAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA0MTkxMDM3MjIu
MTcwNjItMS1zaGFoYWIudmFoZWRpQGdtYWlsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BB
VENIXSBjcHV0bGI6IEZpeCBpb19yZWFkeCgpIHRvIHJlc3BlY3QgdGhlIGFjY2Vzc190eXBlCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkw
NDE5MTAzNzIyLjE3MDYyLTEtc2hhaGFiLnZhaGVkaUBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE5
MDQxOTEwMzcyMi4xNzA2Mi0xLXNoYWhhYi52YWhlZGlAZ21haWwuY29tClN3aXRjaGVkIHRvIGEg
bmV3IGJyYW5jaCAndGVzdCcKZjQ0NDY5NzZlYyBjcHV0bGI6IEZpeCBpb19yZWFkeCgpIHRvIHJl
c3BlY3QgdGhlIGFjY2Vzc190eXBlCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2Ug
cHJvaGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKIzMzOiBGSUxFOiBh
Y2NlbC90Y2cvY3B1dGxiLmM6ODg1OgorICAgICAgICAgICAgKGFjY2Vzc190eXBlID09IE1NVV9E
QVRBX0xPQUQgKSA/IGVudHJ5LT5hZGRyX3JlYWQgIDoKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMTUgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGY0NDQ2OTc2ZWMyMyAoY3B1dGxiOiBGaXgg
aW9fcmVhZHgoKSB0byByZXNwZWN0IHRoZSBhY2Nlc3NfdHlwZSkgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTA0MTkxMDM3MjIuMTcwNjItMS1zaGFoYWIudmFoZWRpQGdtYWlsLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


