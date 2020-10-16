Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3032C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 19:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0128220EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 19:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128220EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTV6S-0004n4-Ls
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 15:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kTV4G-0003bd-Sg; Fri, 16 Oct 2020 15:07:08 -0400
Resent-Date: Fri, 16 Oct 2020 15:07:08 -0400
Resent-Message-Id: <E1kTV4G-0003bd-Sg@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kTV49-0005Fd-0x; Fri, 16 Oct 2020 15:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602875212; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BxGxbR5CDSwqQhv3+BF05aMM0rnZFtApJP+TwXYiqfoDaqYiNefn7/twMXJnBxMz6T/zuT/d1NoSZWCYGAEQKf+BmIG/1LsK6SRGLbnTI/rmujfosOBKR4k0I6/uTylaHhW5jT3eASObmm4ioZOcrV0eICvftSnFgJNubPyPdYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602875212;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GHHn5V6ndqJabY8GedSN6R4YOjU5m4ryD4lVrmTcBiM=; 
 b=jyhfKtZp2Wmu9ak2eqN0uFVhSsnNf7vMBR9jvrVKKUrJSs/z4Zmq+YHuNR2nWs4/BYHqez0joidUszdWo+VLGj5cZ9YINBwkMvpgTyxEveyg+eqMxy/pLowqJIQTeuUgEgBKiSXGduGJxlLRtu4CBkrctS6p3Ktp75cdc67wC6g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 160287521010412.796348504163348;
 Fri, 16 Oct 2020 12:06:50 -0700 (PDT)
Subject: Re: [PATCH v11 00/12] linux-user: User support for AArch64 BTI
Message-ID: <160287520829.1194.14173174275238509522@66eaa9a8a123>
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 16 Oct 2020 12:06:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 15:06:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAxNjE4NDIwNy43ODY2
OTgtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMTYx
ODQyMDcuNzg2Njk4LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFU
Q0ggdjExIDAwLzEyXSBsaW51eC11c2VyOiBVc2VyIHN1cHBvcnQgZm9yIEFBcmNoNjQgQlRJCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDE2MTg0
MjA3Ljc4NjY5OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDIw
MTAxNjE4NDIwNy43ODY2OTgtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYWRkZGViZCB0ZXN0cy90Y2cvYWFyY2g2NDogQWRkIGJ0
aSBzbW9rZSB0ZXN0cwo2ZGU5ZTEyIGxpbnV4LXVzZXIvZWxmbG9hZDogUGFyc2UgR05VX1BST1BF
UlRZX0FBUkNINjRfRkVBVFVSRV8xX0FORAo5YjA1MDc3IGxpbnV4LXVzZXIvZWxmbG9hZDogUGFy
c2UgTlRfR05VX1BST1BFUlRZX1RZUEVfMCBub3RlcwplMDYzZmRlIGxpbnV4LXVzZXIvZWxmbG9h
ZDogVXNlIEVycm9yIGZvciBsb2FkX2VsZl9pbnRlcnAKNWZhNjMwNSBsaW51eC11c2VyL2VsZmxv
YWQ6IFVzZSBFcnJvciBmb3IgbG9hZF9lbGZfaW1hZ2UKMGJkZjNiOSBsaW51eC11c2VyL2VsZmxv
YWQ6IE1vdmUgUFRfSU5URVJQIGRldGVjdGlvbiB0byBmaXJzdCBsb29wCjMxOTI5NDMgbGludXgt
dXNlci9lbGZsb2FkOiBBZGp1c3QgaXRlcmF0aW9uIG92ZXIgcGhkcgpkMzVhYzBlIGxpbnV4LXVz
ZXIvZWxmbG9hZDogRml4IGNvZGluZyBzdHlsZSBpbiBsb2FkX2VsZl9pbWFnZQpmMTAxOWMwIGxp
bnV4LXVzZXIvZWxmbG9hZDogQXZvaWQgbGVha2luZyBpbnRlcnBfbmFtZSB1c2luZyBHTGliIG1l
bW9yeSBBUEkKNDZiOGUwNCBpbmNsdWRlL2VsZjogQWRkIGRlZmluZXMgcmVsYXRlZCB0byBHTlUg
cHJvcGVydHkgbm90ZXMgZm9yIEFBcmNoNjQKMTUxNjJiNCBsaW51eC11c2VyOiBTZXQgUEFHRV9U
QVJHRVRfMSBmb3IgVEFSR0VUX1BST1RfQlRJCjQ5ZWQ3NGIgbGludXgtdXNlci9hYXJjaDY0OiBS
ZXNldCBidHlwZSBmb3Igc2lnbmFscwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMiBDaGVja2lu
ZyBjb21taXQgNDllZDc0YmMxYWVlIChsaW51eC11c2VyL2FhcmNoNjQ6IFJlc2V0IGJ0eXBlIGZv
ciBzaWduYWxzKQoyLzEyIENoZWNraW5nIGNvbW1pdCAxNTE2MmI0ZGNiZWMgKGxpbnV4LXVzZXI6
IFNldCBQQUdFX1RBUkdFVF8xIGZvciBUQVJHRVRfUFJPVF9CVEkpCjMvMTIgQ2hlY2tpbmcgY29t
bWl0IDQ2YjhlMDQ3ODFhMSAoaW5jbHVkZS9lbGY6IEFkZCBkZWZpbmVzIHJlbGF0ZWQgdG8gR05V
IHByb3BlcnR5IG5vdGVzIGZvciBBQXJjaDY0KQo0LzEyIENoZWNraW5nIGNvbW1pdCBmMTAxOWMw
NDE2YzMgKGxpbnV4LXVzZXIvZWxmbG9hZDogQXZvaWQgbGVha2luZyBpbnRlcnBfbmFtZSB1c2lu
ZyBHTGliIG1lbW9yeSBBUEkpCjUvMTIgQ2hlY2tpbmcgY29tbWl0IGQzNWFjMGUxOTMwYiAobGlu
dXgtdXNlci9lbGZsb2FkOiBGaXggY29kaW5nIHN0eWxlIGluIGxvYWRfZWxmX2ltYWdlKQo2LzEy
IENoZWNraW5nIGNvbW1pdCAzMTkyOTQzYjhkNzUgKGxpbnV4LXVzZXIvZWxmbG9hZDogQWRqdXN0
IGl0ZXJhdGlvbiBvdmVyIHBoZHIpCjcvMTIgQ2hlY2tpbmcgY29tbWl0IDBiZGYzYjljMDdmNiAo
bGludXgtdXNlci9lbGZsb2FkOiBNb3ZlIFBUX0lOVEVSUCBkZXRlY3Rpb24gdG8gZmlyc3QgbG9v
cCkKOC8xMiBDaGVja2luZyBjb21taXQgNWZhNjMwNTZlMDg0IChsaW51eC11c2VyL2VsZmxvYWQ6
IFVzZSBFcnJvciBmb3IgbG9hZF9lbGZfaW1hZ2UpCjkvMTIgQ2hlY2tpbmcgY29tbWl0IGUwNjNm
ZGU3ZDRiMSAobGludXgtdXNlci9lbGZsb2FkOiBVc2UgRXJyb3IgZm9yIGxvYWRfZWxmX2ludGVy
cCkKMTAvMTIgQ2hlY2tpbmcgY29tbWl0IDliMDUwNzdmYTJlZCAobGludXgtdXNlci9lbGZsb2Fk
OiBQYXJzZSBOVF9HTlVfUFJPUEVSVFlfVFlQRV8wIG5vdGVzKQoxMS8xMiBDaGVja2luZyBjb21t
aXQgNmRlOWUxMmIyYWRmIChsaW51eC11c2VyL2VsZmxvYWQ6IFBhcnNlIEdOVV9QUk9QRVJUWV9B
QVJDSDY0X0ZFQVRVUkVfMV9BTkQpCjEyLzEyIENoZWNraW5nIGNvbW1pdCBhZGRkZWJkOGE3MDIg
KHRlc3RzL3RjZy9hYXJjaDY0OiBBZGQgYnRpIHNtb2tlIHRlc3RzKQpXQVJOSU5HOiBhZGRlZCwg
bW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/
CiMzNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogZXh0ZXJucyBzaG91bGQgYmUgYXZv
aWRlZCBpbiAuYyBmaWxlcwojMTY1OiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9idGktMi5jOjU2
OgorZXh0ZXJuIGNoYXIgdGVzdF9iZWdpbltdLCB0ZXN0X2VuZFtdOwoKRVJST1I6IHVzZSBxZW11
X3JlYWxfaG9zdF9wYWdlX3NpemUgaW5zdGVhZCBvZiBnZXRwYWdlc2l6ZSgpCiMxOTk6IEZJTEU6
IHRlc3RzL3RjZy9hYXJjaDY0L2J0aS0yLmM6OTA6CisgICAgdm9pZCAqcCA9IG1tYXAoMCwgZ2V0
cGFnZXNpemUoKSwKCkVSUk9SOiBleHRlcm5zIHNob3VsZCBiZSBhdm9pZGVkIGluIC5jIGZpbGVz
CiMyMzY6IEZJTEU6IHRlc3RzL3RjZy9hYXJjaDY0L2J0aS1jcnQuaW5jLmM6MTM6CitpbnQgbWFp
bih2b2lkKTsKCnRvdGFsOiAzIGVycm9ycywgMSB3YXJuaW5ncywgMjQ3IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDEyLzEyIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMTAxNjE4NDIwNy43ODY2OTgt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

