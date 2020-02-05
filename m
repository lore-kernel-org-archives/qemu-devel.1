Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B03C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8EF20661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8EF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHg6-0007Z8-0v
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1izHfN-00079j-KC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1izHfM-0006Ng-4k
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:12:17 -0500
Resent-Date: Wed, 05 Feb 2020 05:12:17 -0500
Resent-Message-Id: <E1izHfM-0006Ng-4k@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1izHfL-0006CK-V6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:12:16 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580897521535737.9748064229339;
 Wed, 5 Feb 2020 02:12:01 -0800 (PST)
In-Reply-To: <20200205095737.20153-1-felipe@nutanix.com>
Subject: Re: [PATCH v2] fence: introduce a file-based self-fence mechanism
Message-ID: <158089751996.7235.4126644910662428713@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: felipe@nutanix.com
Date: Wed, 5 Feb 2020 02:12:01 -0800 (PST)
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, felipe@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIwNTA5NTczNy4yMDE1
My0xLWZlbGlwZUBudXRhbml4LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyXSBmZW5jZTogaW50cm9kdWNlIGEgZmlsZS1i
YXNlZCBzZWxmLWZlbmNlIG1lY2hhbmlzbQpNZXNzYWdlLWlkOiAyMDIwMDIwNTA5NTczNy4yMDE1
My0xLWZlbGlwZUBudXRhbml4LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDAyMDUwOTU3MzcuMjAxNTMtMS1mZWxpcGVA
bnV0YW5peC5jb20gLT4gcGF0Y2hldy8yMDIwMDIwNTA5NTczNy4yMDE1My0xLWZlbGlwZUBudXRh
bml4LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY2Mjg1MWQgZmVuY2U6IGlu
dHJvZHVjZSBhIGZpbGUtYmFzZWQgc2VsZi1mZW5jZSBtZWNoYW5pc20KCj09PSBPVVRQVVQgQkVH
SU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJ
TlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzU1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9S
OiB1c2UgUUVNVSBpbnN0ZWFkIG9mIFFlbXUgb3IgUUVtdQojMjEyOiBGSUxFOiBiYWNrZW5kcy9m
aWxlLWZlbmNlLmM6MTUzOgorICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJFcnJvciBjcmVhdGlu
ZyBRZW11IHRpbWVyIik7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDQxNiBsaW5lcyBj
aGVja2VkCgpDb21taXQgZjYyODUxZDk2NzVlIChmZW5jZTogaW50cm9kdWNlIGEgZmlsZS1iYXNl
ZCBzZWxmLWZlbmNlIG1lY2hhbmlzbSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMDUwOTU3
MzcuMjAxNTMtMS1mZWxpcGVAbnV0YW5peC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

