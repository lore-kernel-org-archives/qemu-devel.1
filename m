Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B22C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2895B22518
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2895B22518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOjA-0008G4-Cq
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvOhO-0006pW-Jl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:26:34 -0400
Resent-Date: Tue, 14 Jul 2020 13:26:34 -0400
Resent-Message-Id: <E1jvOhO-0006pW-Jl@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvOhM-0006LE-3k
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594747522; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AQyyjcuE6I1HJ2Jg7yYV53V/0qp1JPJzMl2Z2UU2YmcvjaB/UFmp1WiuD+DO3sif9qT+9ZRIpIIP5GvtSaKucgAXJyQ0YqHmusrzeRZKMGgkjViy42i8/QA5JcZ6UFuT8ubATubp0+JmpzQB2K8qoV1Z3ZMWcSLCDR6muvYvlYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594747522;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LoZ+0dQBcIBXtbVbQNx9IrZKYdMrcg/HxMG+mlpMGrA=; 
 b=ZSTw63724Xn+1ww7JpdGQFWaHm0uFO0unCWmjdgCTh5KfaOYmXEdIPULBDJbPXEYW9skt8JERIy2dduTLvpECcrFgJnU7bp6CIsJxWYvtJ2EcntH3X1TV/6b515Dzy5/D8eRB6jqq9fndm4K3tJ8+uyPhwShcObcjrjYHyZZGVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594747520014195.42650242856485;
 Tue, 14 Jul 2020 10:25:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] Add list_fn_callees.py and list_helpers.py scripts
Message-ID: <159474751838.11884.932010559811209900@07a7f0d89f7d>
In-Reply-To: <20200714164156.9353-1-ahmedkhaledkaraman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ahmedkhaledkaraman@gmail.com
Date: Tue, 14 Jul 2020 10:25:20 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:50:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, ahmedkhaledkaraman@gmail.com,
 aleksandar.qemu.devel@gmail.com, crosa@redhat.com, alex.bennee@linaro.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDE2NDE1Ni45MzUz
LTEtYWhtZWRraGFsZWRrYXJhbWFuQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNzE0MTY0
MTU2LjkzNTMtMS1haG1lZGtoYWxlZGthcmFtYW5AZ21haWwuY29tClN1YmplY3Q6IFtQQVRDSCAw
LzJdIEFkZCBsaXN0X2ZuX2NhbGxlZXMucHkgYW5kIGxpc3RfaGVscGVycy5weSBzY3JpcHRzCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgMWE1M2RmZS4uYmVmZjQ3YSAgbWFzdGVyICAgICAt
PiBtYXN0ZXIKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpmOTY0NGU4IHNjcmlwdHMv
cGVyZm9ybWFuY2U6IEFkZCBsaXN0X2hlbHBlcnMucHkgc2NyaXB0CmFhNjZlYjAgc2NyaXB0cy9w
ZXJmb3JtYW5jZTogQWRkIGxpc3RfZm5fY2FsbGVlcy5weSBzY3JpcHQKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvMiBDaGVja2luZyBjb21taXQgYWE2NmViMDVkYmZiIChzY3JpcHRzL3BlcmZvcm1h
bmNlOiBBZGQgbGlzdF9mbl9jYWxsZWVzLnB5IHNjcmlwdCkKRVJST1I6IE1pc3NpbmcgU2lnbmVk
LW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMjggbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tp
bmcgY29tbWl0IGY5NjQ0ZTgzNjU4ZiAoc2NyaXB0cy9wZXJmb3JtYW5jZTogQWRkIGxpc3RfaGVs
cGVycy5weSBzY3JpcHQpCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjA3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMiBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MTQxNjQxNTYuOTM1My0xLWFobWVka2hhbGVka2Fy
YW1hbkBnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

