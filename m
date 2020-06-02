Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1932206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1932206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1kh-0005Hr-1E
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1k2-0004qW-6R
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:53:46 -0400
Resent-Date: Tue, 02 Jun 2020 03:53:46 -0400
Resent-Message-Id: <E1jg1k2-0004qW-6R@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1k1-0002Q8-2P
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591084415; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FH+Z62KYIUBJfHAoh9YlLCFWtgLtJQW10itLV7Dh5QZU2HJRO9F7g+5kw06UdoT/ni4u/gS3h965OtpTgJebRk2aa7aqDMM6wTq4OED5QGsAPbA2H3HX/BmNlRoCfURNpBhTffm4d/uq9CgAcbG3lkti1q7jtiHCz5x2gNeio9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591084415;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=07TVsQbukaoObCGnKcmgj0bVqrCOtLwIXqC+DrnF1RM=; 
 b=MyhHtK0VrDz462Mymc7L1+UottKcG4LwYl8b8bmFEMN+/mOvigGq+n/34+puWBrF42Dcu8A1lDr3B0Gt01tbkNnLGIip/dNb+r9mhV+XXUxRefrzB5Nj+7fOUNi3FgthdVnSz2bomHGWOpbT2o35zvm1wArr1uV8Smrp+UQI42M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591084415176573.207229800983;
 Tue, 2 Jun 2020 00:53:35 -0700 (PDT)
Message-ID: <159108441403.18153.17592020440370222944@45ef0f9c86ae>
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
Subject: Re: [PATCH 0/4] Add Support for GET LBA STATUS 16 command in scsi
 emulation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lma@suse.com
Date: Tue, 2 Jun 2020 00:53:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:52:38
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 lma@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMjA3NDIwMS4xMDg3
OS0xLWxtYUBzdXNlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUg
Y29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0
aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDIwNzQyMDEuMTA4NzktMS1sbWFAc3VzZS5jb20KU3Vi
amVjdDogW1BBVENIIDAvNF0gQWRkIFN1cHBvcnQgZm9yIEdFVCBMQkEgU1RBVFVTIDE2IGNvbW1h
bmQgaW4gc2NzaSBlbXVsYXRpb24KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmYyMWZkNTQgc2NzaS1kaXNr
OiBBZGQgc3VwcG9ydCBmb3IgdGhlIEdFVCBMQkEgU1RBVFVTIDE2IGNvbW1hbmQKMWNmNTE1YyBi
bG9jazogQWRkIGJsb2NrIGFjY291bnRpbmcgY29kZSBmb3IgR0VUIExCQSBTVEFUVVMKZmI0YWY1
NiBibG9jazogQWRkIEdFVCBMQkEgU1RBVFVTIHN1cHBvcnQKM2UxMmIwMCBibG9jazogQWRkIGJk
cnZfY29fZ2V0X2xiYV9zdGF0dXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBj
b21taXQgM2UxMmIwMGMwMzgwIChibG9jazogQWRkIGJkcnZfY29fZ2V0X2xiYV9zdGF0dXMpCkVS
Uk9SOiBzdXBlcmZsdW91cyB0cmFpbGluZyBzZW1pY29sb24KIzQ3OiBGSUxFOiBibG9jay9pby5j
OjIyMTU6CisgICAgICAgICAgICAgICAgd2FudGVkX2JpdDEgPSBCRFJWX0JMT0NLX1pFUk8gPj4g
MTs7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDQ5IGxpbmVzIGNoZWNrZWQKClBhdGNo
IDEvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi80IENoZWNraW5nIGNvbW1pdCBmYjRh
ZjU2NzllMjkgKGJsb2NrOiBBZGQgR0VUIExCQSBTVEFUVVMgc3VwcG9ydCkKMy80IENoZWNraW5n
IGNvbW1pdCAxY2Y1MTVjMDRhMzEgKGJsb2NrOiBBZGQgYmxvY2sgYWNjb3VudGluZyBjb2RlIGZv
ciBHRVQgTEJBIFNUQVRVUykKNC80IENoZWNraW5nIGNvbW1pdCBmMjFmZDU0MGNjMDMgKHNjc2kt
ZGlzazogQWRkIHN1cHBvcnQgZm9yIHRoZSBHRVQgTEJBIFNUQVRVUyAxNiBjb21tYW5kKQpXQVJO
SU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQoj
ODE6IEZJTEU6IGh3L3Njc2kvc2NzaS1kaXNrLmM6MTkzMjoKKyAgICAvKiA4ICsgMTYgaXMgdGhl
IGxlbmd0aCBpbiBieXRlcyBvZiByZXNwb25zZSBoZWFkZXIgYW5kCgp0b3RhbDogMCBlcnJvcnMs
IDEgd2FybmluZ3MsIDExMSBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzQgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAyMDA2MDIwNzQyMDEuMTA4NzktMS1sbWFAc3VzZS5jb20vdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

