Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA8C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB8D2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB8D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJDj-0007Mb-3A
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kYJD5-0006wL-1z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 21:28:07 -0400
Resent-Date: Thu, 29 Oct 2020 21:28:07 -0400
Resent-Message-Id: <E1kYJD5-0006wL-1z@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kYJD2-0006vV-53
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 21:28:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604021275; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gpnMDyyNcQjpzjoUOcz3LghC1fP/5Wv1tX37EYdP68UTfqQoifcxB2oEzQt8gU/LLix3F4OrKWE+nY450r2IN6dOyj7Rj+RozUHGAhiL44U2vrQ4zfcaImYf4plTjK16HBr2JA5ZgtsvkKcrSkw+gJ+Udt3RldClnSm2/rOLpy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604021275;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vDwRo61S9KVEDsC7JWYLpWS2AkeK5OKWx81CQYtHkjA=; 
 b=U3tVoN4zHv+yRyn3FJPXYTXw194viDzwMBBGtpyzOJx/r5RQCHI/VXPG0FVZB8YGVL91DVwU4vh05PaV2pCzst+a2/XPtFF69EA8gA4tvyRsyZoHrVEuL3mSkuXpRUcs0oZao3QFnEd8nu4VQhFK5WIe9zIHA6egko+UYCcfBtg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604021273556322.8437319851022;
 Thu, 29 Oct 2020 18:27:53 -0700 (PDT)
Subject: Re: [PATCH v2 00/19] Mirror map JIT memory for TCG
Message-ID: <160402127240.32349.10909935342581472360@66eaa9a8a123>
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Thu, 29 Oct 2020 18:27:53 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 21:28:02
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
Cc: pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org, j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAzMDAwNDkyMS43MjEw
OTYtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMzAw
MDQ5MjEuNzIxMDk2LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFU
Q0ggdjIgMDAvMTldIE1pcnJvciBtYXAgSklUIG1lbW9yeSBmb3IgVENHCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDMwMDA0OTIxLjcyMTA5Ni0x
LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDIwMTAzMDAwNDkyMS43
MjEwOTYtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKMWNhZTBhYSB0Y2cvYWFyY2g2NDogU3VwcG9ydCBzcGxpdC1yd3ggY29kZSBn
ZW5lcmF0aW9uCjJhOGJiNmYgdGNnL2FhcmNoNjQ6IEltcGxlbWVudCBmbHVzaF9pZGNhY2hlX3Jh
bmdlIG1hbnVhbGx5CjVhYWM5MzcgdGNnL2FhcmNoNjQ6IFVzZSBCIG5vdCBCTCBmb3IgdGNnX291
dF9nb3RvX2xvbmcKOWY4MTI3NSB0Y2cvaTM4NjogU3VwcG9ydCBzcGxpdC1yd3ggY29kZSBnZW5l
cmF0aW9uCjVhMTFkZDAgdGNnOiBSZXR1cm4gdGhlIHJ4IG1pcnJvciBvZiBUcmFuc2xhdGlvbkJs
b2NrIGZyb20gZXhpdF90YgphZjcxMzMwIFJGQzogYWNjZWwvdGNnOiBTdXBwb3J0IHNwbGl0LXJ3
eCBmb3IgZGFyd2luL2lPUyB3aXRoIHZtX3JlbWFwCmJmNjA5NjUgYWNjZWwvdGNnOiBTdXBwb3J0
IHNwbGl0LXJ3eCBmb3IgbGludXggd2l0aCBtZW1mZAo5MGMxZTc3IHRjZzogQWRkIC0tYWNjZWwg
dGNnLHNwbGl0LXJ3eCBwcm9wZXJ0eQpkNDgwNWI4IHRjZzogVXNlIEVycm9yIHdpdGggYWxsb2Nf
Y29kZV9nZW5fYnVmZmVyCjliZmFmYzYgdGNnOiBNYWtlIHRiIGFyZyB0byBzeW5jaHJvbml6ZV9m
cm9tX3RiIGNvbnN0CjI3ZWJmYzkgdGNnOiBNYWtlIERpc2FzQ29udGV4dEJhc2UudGIgY29uc3QK
NWE3YmM1MSB0Y2c6IEFkanVzdCB0Yl90YXJnZXRfc2V0X2ptcF90YXJnZXQgZm9yIHNwbGl0IHJ3
eAo2YTdjMmM2IHRjZzogQWRqdXN0IHRjZ19yZWdpc3Rlcl9qaXQgZm9yIGNvbnN0CjUxYTA4ODQg
dGNnOiBBZGp1c3QgdGNnX291dF9sYWJlbCBmb3IgY29uc3QKNzlmMGM4ZSB0Y2c6IEFkanVzdCB0
Y2dfb3V0X2NhbGwgZm9yIGNvbnN0CmNkMTNiY2YgdGNnOiBJbnRyb2R1Y2UgdGNnX21pcnJvcl9y
d190b19yeC90Y2dfbWlycm9yX3J4X3RvX3J3CjQzYTQ3MjcgdGNnOiBNb3ZlIHRjZyBlcGlsb2d1
ZSBwb2ludGVyIG91dCBvZiBUQ0dDb250ZXh0CjVjNWI4NWEgdGNnOiBNb3ZlIHRjZyBwcm9sb2d1
ZSBwb2ludGVyIG91dCBvZiBUQ0dDb250ZXh0CmUzMjBjNTEgdGNnOiBFbmhhbmNlIGZsdXNoX2lj
YWNoZV9yYW5nZSB3aXRoIHNlcGFyYXRlIGRhdGEgcG9pbnRlcgoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KMS8xOSBDaGVja2luZyBjb21taXQgZTMyMGM1MWUzZTRhICh0Y2c6IEVuaGFuY2UgZmx1c2hf
aWNhY2hlX3JhbmdlIHdpdGggc2VwYXJhdGUgZGF0YSBwb2ludGVyKQoyLzE5IENoZWNraW5nIGNv
bW1pdCA1YzViODVhMWEwMjQgKHRjZzogTW92ZSB0Y2cgcHJvbG9ndWUgcG9pbnRlciBvdXQgb2Yg
VENHQ29udGV4dCkKMy8xOSBDaGVja2luZyBjb21taXQgNDNhNDcyNzVlNjBlICh0Y2c6IE1vdmUg
dGNnIGVwaWxvZ3VlIHBvaW50ZXIgb3V0IG9mIFRDR0NvbnRleHQpCjQvMTkgQ2hlY2tpbmcgY29t
bWl0IGNkMTNiY2Y0OGYzNiAodGNnOiBJbnRyb2R1Y2UgdGNnX21pcnJvcl9yd190b19yeC90Y2df
bWlycm9yX3J4X3RvX3J3KQo1LzE5IENoZWNraW5nIGNvbW1pdCA3OWYwYzhlOGRkMDQgKHRjZzog
QWRqdXN0IHRjZ19vdXRfY2FsbCBmb3IgY29uc3QpCjYvMTkgQ2hlY2tpbmcgY29tbWl0IDUxYTA4
ODQ0NjY1OSAodGNnOiBBZGp1c3QgdGNnX291dF9sYWJlbCBmb3IgY29uc3QpCjcvMTkgQ2hlY2tp
bmcgY29tbWl0IDZhN2MyYzYxYWM3YyAodGNnOiBBZGp1c3QgdGNnX3JlZ2lzdGVyX2ppdCBmb3Ig
Y29uc3QpCjgvMTkgQ2hlY2tpbmcgY29tbWl0IDVhN2JjNTEwMDY4MCAodGNnOiBBZGp1c3QgdGJf
dGFyZ2V0X3NldF9qbXBfdGFyZ2V0IGZvciBzcGxpdCByd3gpCjkvMTkgQ2hlY2tpbmcgY29tbWl0
IDI3ZWJmYzljNzcxMCAodGNnOiBNYWtlIERpc2FzQ29udGV4dEJhc2UudGIgY29uc3QpCjEwLzE5
IENoZWNraW5nIGNvbW1pdCA5YmZhZmM2YTFlNjYgKHRjZzogTWFrZSB0YiBhcmcgdG8gc3luY2hy
b25pemVfZnJvbV90YiBjb25zdCkKMTEvMTkgQ2hlY2tpbmcgY29tbWl0IGQ0ODA1YjhjN2JhOSAo
dGNnOiBVc2UgRXJyb3Igd2l0aCBhbGxvY19jb2RlX2dlbl9idWZmZXIpCjEyLzE5IENoZWNraW5n
IGNvbW1pdCA5MGMxZTc3Mzc3OGQgKHRjZzogQWRkIC0tYWNjZWwgdGNnLHNwbGl0LXJ3eCBwcm9w
ZXJ0eSkKMTMvMTkgQ2hlY2tpbmcgY29tbWl0IGJmNjA5NjViNzE1YyAoYWNjZWwvdGNnOiBTdXBw
b3J0IHNwbGl0LXJ3eCBmb3IgbGludXggd2l0aCBtZW1mZCkKMTQvMTkgQ2hlY2tpbmcgY29tbWl0
IGFmNzEzMzBhOWI3NyAoUkZDOiBhY2NlbC90Y2c6IFN1cHBvcnQgc3BsaXQtcnd4IGZvciBkYXJ3
aW4vaU9TIHdpdGggdm1fcmVtYXApCkVSUk9SOiBleHRlcm5zIHNob3VsZCBiZSBhdm9pZGVkIGlu
IC5jIGZpbGVzCiMzOTogRklMRTogYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYzoxMTk1OgorZXh0
ZXJuIGtlcm5fcmV0dXJuX3QgbWFjaF92bV9yZW1hcCh2bV9tYXBfdCB0YXJnZXRfdGFzaywKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgODYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTQvMTkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjE1LzE5IENoZWNraW5nIGNvbW1pdCA1YTExZGQw
NjMxNjUgKHRjZzogUmV0dXJuIHRoZSByeCBtaXJyb3Igb2YgVHJhbnNsYXRpb25CbG9jayBmcm9t
IGV4aXRfdGIpCjE2LzE5IENoZWNraW5nIGNvbW1pdCA5ZjgxMjc1NGM2YzIgKHRjZy9pMzg2OiBT
dXBwb3J0IHNwbGl0LXJ3eCBjb2RlIGdlbmVyYXRpb24pCjE3LzE5IENoZWNraW5nIGNvbW1pdCA1
YWFjOTM3NzU0Y2MgKHRjZy9hYXJjaDY0OiBVc2UgQiBub3QgQkwgZm9yIHRjZ19vdXRfZ290b19s
b25nKQoxOC8xOSBDaGVja2luZyBjb21taXQgMmE4YmI2ZjNlNzFlICh0Y2cvYWFyY2g2NDogSW1w
bGVtZW50IGZsdXNoX2lkY2FjaGVfcmFuZ2UgbWFudWFsbHkpCjE5LzE5IENoZWNraW5nIGNvbW1p
dCAxY2FlMGFhNDI4NDAgKHRjZy9hYXJjaDY0OiBTdXBwb3J0IHNwbGl0LXJ3eCBjb2RlIGdlbmVy
YXRpb24pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAxMDMwMDA0OTIxLjcyMTA5Ni0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

