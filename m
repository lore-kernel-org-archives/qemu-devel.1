Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E832C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AAF20786
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AAF20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKv1-0006Iq-Fn
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmKnv-0002JT-P5
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:27:51 -0400
Resent-Date: Fri, 19 Jun 2020 13:27:51 -0400
Resent-Message-Id: <E1jmKnv-0002JT-P5@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmKnt-0007Xm-QQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:27:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592587658; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IFGk5aGYfZMzpLHKUC8lxWbFzkizrchUZu55L+AKJQmtm5eurGiw7TKCev4hRxpAorNd5hpGJUbQeolmLMq/OkF5tHk/biqKrHd+Z1897nMJhg1akKQOMcZ0tpc3OKjf+DO5eUlJKO2RFRcwMNOWghkhb8tzrp00/EV0YOVK9g8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592587658;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2CO00ySzz4OJGOrOzmCCB5IZcZgSpcBaOsNkwpHNZsg=; 
 b=Np2/SDzl6m8u2cx+xdj78hq3RqRHGKhcZBWyhgUstMCP37edk2HP7tj/pWF+4YIfLoAHnVi3Xo7YBT2QW+V2oHOzNdtLQpgkSeBuxR+MwfIjCwGZsZHdeyKTEClr840lTNHoEBCFaXFXZjwISdB4xBa/eLS/1jiJNOxu2Rhmzts=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15925876572451021.1280450287483;
 Fri, 19 Jun 2020 10:27:37 -0700 (PDT)
Message-ID: <159258765594.3204.908925626921869039@d1fd068a5071>
Subject: Re: [PATCH v2] docs/devel: add some notes on tcg-icount for developers
In-Reply-To: <20200619170930.11704-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 19 Jun 2020 10:27:37 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 10:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dovgaluk@ispras.ru, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxOTE3MDkzMC4xMTcw
NC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2Ml0gZG9jcy9kZXZlbDogYWRkIHNvbWUg
bm90ZXMgb24gdGNnLWljb3VudCBmb3IgZGV2ZWxvcGVycwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1p
ZDogMjAyMDA2MTkxNzA5MzAuMTE3MDQtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXBy
b2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNjE5MTcxODA5LjMw
OTg0LTEtZGdpbGJlcnRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNjE5MTcxODA5LjMwOTg0
LTEtZGdpbGJlcnRAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmRi
MGQ2ZWMgZG9jcy9kZXZlbDogYWRkIHNvbWUgbm90ZXMgb24gdGNnLWljb3VudCBmb3IgZGV2ZWxv
cGVycwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0
ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjM6IApuZXcgZmls
ZSBtb2RlIDEwMDY0NAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzk3OiBGSUxFOiBkb2Nz
L2RldmVsL3RjZy1pY291bnQucnN0OjcwOgorICAkCgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFj
ZQojOTg6IEZJTEU6IGRvY3MvZGV2ZWwvdGNnLWljb3VudC5yc3Q6NzE6CisuLiBbMV0gc29tZXRp
bWVzIHR3byBpbnN0cnVjdGlvbnMgaWYgZGVhbGluZyB3aXRoIGRlbGF5IHNsb3RzICAkCgpFUlJP
UjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMTEzOiBGSUxFOiBkb2NzL2RldmVsL3RjZy1pY291bnQu
cnN0Ojg2OgorICAgJAoKdG90YWw6IDMgZXJyb3JzLCAxIHdhcm5pbmdzLCA4OSBsaW5lcyBjaGVj
a2VkCgpDb21taXQgZGIwZDZlYzhjMDJiIChkb2NzL2RldmVsOiBhZGQgc29tZSBub3RlcyBvbiB0
Y2ctaWNvdW50IGZvciBkZXZlbG9wZXJzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxOTE3
MDkzMC4xMTcwNC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

