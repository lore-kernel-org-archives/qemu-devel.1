Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A21C4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8DF206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 18:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8DF206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL9py-00089J-7z
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 14:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL9bH-0001Wv-5U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:34:43 -0400
Resent-Date: Wed, 23 Sep 2020 14:34:43 -0400
Resent-Message-Id: <E1kL9bH-0001Wv-5U@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL9bE-0001DZ-Uw
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 14:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600886073; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nHJIMnzGUz+PoWc1/8bI/XoQYcRJlYzhRqef3VYR0O/9iE5ygqrodYxYzDSwjrnjQF6sbHsMafixNq7rdHiZ3fjW/zva/jLTKJHKfohKLcpbUVH57ILQSt7eLtdTsnJXr6IyOQ3vo8MCMrnb9SWneCQ1QaRDSR4RFZhlwXX1k4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600886073;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qv2S0aIxHzTqxQUJ1hK4yvxSpm8uJNbeYMHFl0eRBeI=; 
 b=kcvBse+21TNJjWuPoSzx2J2z/5B4OTy3T5hXzCatGxxaHsTB8vlLEpctkzHbWsFR1geFqaTG7vCZU653iHRCgGYazi8fdENuFHUysfFwN293yVits0Z4H1s2GLtHe8z0CrBeN/hyuyHNTUTPixyZeGOHKEWDDQMUbYC0AYJrDzI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 16008860718901005.8400749495094;
 Wed, 23 Sep 2020 11:34:31 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] qemu/atomic.h: rename atomic_ to qatomic_
Message-ID: <160088607066.24678.12741892390996077474@66eaa9a8a123>
In-Reply-To: <20200923151901.745277-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Wed, 23 Sep 2020 11:34:31 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 14:34:38
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMzE1MTkwMS43NDUy
NzctMS1waGlsbWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTIzMTUxOTAxLjc0NTI3
Ny0xLXBoaWxtZEByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCB2NCAwLzJdIHFlbXUvYXRvbWlj
Lmg6IHJlbmFtZSBhdG9taWNfIHRvIHFhdG9taWNfCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDkyMzE1MTkwMS43NDUyNzctMS1waGls
bWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwOTIzMTUxOTAxLjc0NTI3Ny0xLXBoaWxtZEBy
ZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMTY2MWEyYyBxZW11L2F0
b21pYy5oOiByZW5hbWUgYXRvbWljXyB0byBxYXRvbWljXwpiMjc5ODBiIHFlbXUvYXRvbWljOiBV
cGRhdGUgY29kaW5nIHN0eWxlIHRvIG1ha2UgY2hlY2twYXRjaC5wbCBoYXBwaWVyCgo9PT0gT1VU
UFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IGIyNzk4MGJmMWRiNSAocWVtdS9hdG9t
aWM6IFVwZGF0ZSBjb2Rpbmcgc3R5bGUgdG8gbWFrZSBjaGVja3BhdGNoLnBsIGhhcHBpZXIpCkVS
Uk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywgcGxlYXNlIGFkZCBhIGNvbW1l
bnQKIzIzOiBGSUxFOiBpbmNsdWRlL3FlbXUvYXRvbWljLmg6MzI4OgorI2RlZmluZSBhdG9taWNf
cmVhZF9fbm9jaGVjayhwKSAgICgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUgKikgKHApKQoK
RVJST1I6IFVzZSBvZiB2b2xhdGlsZSBpcyB1c3VhbGx5IHdyb25nLCBwbGVhc2UgYWRkIGEgY29t
bWVudAojMjQ6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozMjk6CisjZGVmaW5lIGF0b21p
Y19zZXRfX25vY2hlY2socCwgaSkgKCgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUgKikgKHAp
KSA9IChpKSkKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNTAgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0
IDE2NjFhMmM0OGU2YyAocWVtdS9hdG9taWMuaDogcmVuYW1lIGF0b21pY18gdG8gcWF0b21pY18p
CkVSUk9SOiBNYWNyb3Mgd2l0aCBtdWx0aXBsZSBzdGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNsb3Nl
ZCBpbiBhIGRvIC0gd2hpbGUgbG9vcAojMjgwMTogRklMRTogaW5jbHVkZS9xZW11L2F0b21pYy5o
OjE1MjoKKyNkZWZpbmUgcWF0b21pY19yY3VfcmVhZF9fbm9jaGVjayhwdHIsIHZhbHB0cikgICAg
ICAgICAgIFwKKyAgICBfX2F0b21pY19sb2FkKHB0ciwgdmFscHRyLCBfX0FUT01JQ19SRUxBWEVE
KTsgICAgICAgIFwKICAgICBzbXBfcmVhZF9iYXJyaWVyX2RlcGVuZHMoKTsKCkVSUk9SOiBVc2Ug
b2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywgcGxlYXNlIGFkZCBhIGNvbW1lbnQKIzI5NDY6
IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozMzM6CisjZGVmaW5lIHFhdG9taWNfcmVhZF9f
bm9jaGVjayhwKSAgICgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUgKikgKHApKQoKRVJST1I6
IFVzZSBvZiB2b2xhdGlsZSBpcyB1c3VhbGx5IHdyb25nLCBwbGVhc2UgYWRkIGEgY29tbWVudAoj
Mjk0NzogRklMRTogaW5jbHVkZS9xZW11L2F0b21pYy5oOjMzNDoKKyNkZWZpbmUgcWF0b21pY19z
ZXRfX25vY2hlY2socCwgaSkgKCgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUgKikgKHApKSA9
IChpKSkKCkVSUk9SOiBtZW1vcnkgYmFycmllciB3aXRob3V0IGNvbW1lbnQKIzMwMjQ6IEZJTEU6
IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozOTU6CisjZGVmaW5lIHFhdG9taWNfeGNoZyhwdHIsIGkp
ICAgIChzbXBfbWIoKSwgX19zeW5jX2xvY2tfdGVzdF9hbmRfc2V0KHB0ciwgaSkpCgp0b3RhbDog
NCBlcnJvcnMsIDAgd2FybmluZ3MsIDYyNjkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyMzE1MTkwMS43NDUyNzctMS1waGlsbWRAcmVkaGF0LmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

