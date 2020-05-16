Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50FFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 01:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69CC2065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 01:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69CC2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZlUK-0004X6-R7
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 21:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZlTk-00045D-4Z; Fri, 15 May 2020 21:19:04 -0400
Resent-Date: Fri, 15 May 2020 21:19:04 -0400
Resent-Message-Id: <E1jZlTk-00045D-4Z@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZlTi-0002AN-Hb; Fri, 15 May 2020 21:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589591934; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JicxaMVXB8Uuoi6wmLYbfhuVkMac3vdIV5NaniEcREO6cPLBqGxxpKGzW6nEXI4w4BZqv80Zuc0G8dyNtCQ4VH7TQAfd7o4TMX+4dizq5AAdBK6nUVr1+7wrHVTE6UzcVQ7Q+vVoUerhw57hLKJSp8lnuZ499LpwAITeJhooP/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589591934;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=y9BrycBWE5ImzwYlFlu3KmDYdTeTOKmkjBXLxwecZu4=; 
 b=lUfdbEY9darwcGk/ak6aFjbPEnYkrHfnq7gl34q/KBnJPmqiByBMlPa9yYpq6K/CdKaz5j5C/7Ce4cxO1gIito8uBP2gNkP8lvW1S4Xd59B3Lua7OsDJgn9ckj6jZia9XXpaqdE2oAC9krOrmCcd4Pkx3m0aYInfrpwtPi0IJ6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589591932727174.42620339069026;
 Fri, 15 May 2020 18:18:52 -0700 (PDT)
Message-ID: <158959193157.9380.14071749225872082577@45ef0f9c86ae>
In-Reply-To: <20200515151518.83950-1-cohuck@redhat.com>
Subject: Re: [PATCH v2 0/3] s390x: improve documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cohuck@redhat.com
Date: Fri, 15 May 2020 18:18:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 20:23:41
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNTE1MTUxOC44Mzk1
MC0xLWNvaHVja0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUxNTE1MTUxOC44Mzk1MC0xLWNvaHVja0ByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzNdIHMzOTB4OiBpbXByb3ZlIGRvY3VtZW50YXRp
b24KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplZWFhMWMyIGRvY3MvczM5MHg6IGRvY3VtZW50
IHZmaW8tY2N3CmYyZTdlOWYgZG9jcy9zMzkweDogZG9jdW1lbnQgMzI3MApkOTY3NTFiIGRvY3Mv
czM5MHg6IGRvY3VtZW50IHRoZSB2aXJ0dWFsIGNzcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8z
IENoZWNraW5nIGNvbW1pdCBkOTY3NTFiZjM4MmEgKGRvY3MvczM5MHg6IGRvY3VtZW50IHRoZSB2
aXJ0dWFsIGNzcykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
dG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA5MyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzMg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMi8zIENoZWNraW5nIGNvbW1pdCBmMmU3ZTlmZWQ3
MDIgKGRvY3MvczM5MHg6IGRvY3VtZW50IDMyNzApCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzEzOiAKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMzkgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMi8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvMyBDaGVja2lu
ZyBjb21taXQgZWVhYTFjMjI1MWU1IChkb2NzL3MzOTB4OiBkb2N1bWVudCB2ZmlvLWNjdykKV0FS
TklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBu
ZWVkIHVwZGF0aW5nPwojMTM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IHRyYWlsaW5n
IHdoaXRlc3BhY2UKIzc4OiBGSUxFOiBkb2NzL3N5c3RlbS9zMzkweC92ZmlvLWNjdy5yc3Q6NjE6
CisgICAgRGV2aWNlICAgU3ViY2hhbi4gIERldlR5cGUgQ1UgVHlwZSBVc2UgIFBJTSBQQU0gUE9N
ICBDSFBJRHMgICAgICAgICAgICQKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgNzkgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggMy8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUxNTE1MTUx
OC44Mzk1MC0xLWNvaHVja0ByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

