Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF63CCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 14:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD2E21897
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 14:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD2E21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMCIN-0005Wp-JN
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMCHF-0004Tv-Q1
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMCHE-00053c-7U
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:33:49 -0400
Resent-Date: Sun, 20 Oct 2019 10:33:49 -0400
Resent-Message-Id: <E1iMCHE-00053c-7U@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMCHC-000515-Mf
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:33:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571582006; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ifmr7R6OyBTuQ0s8yGGVeXiNY1O8yT5WGjg15iNxfSf3/1BrN2zqZhMDk4MxoCPK7WkYHYXc/C6HStyo3xm2okqvA4iXM3XcSW8sYZi1e4jSCsRbD1PaStxEM3QR10rL+AMqOaaZm8J+Y1vX9XjanjBip9SV4rJSoN+SylnO0CE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571582006;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=a9Xdko9DUlVX9SvWXalB5bn4F2GDHr0Lkxph0vso+VE=; 
 b=C/46+5/W/lg/hJIYOKGe+yfpT1+TBbPlMXyKK/XRHKozFXFTv7SsQN6eg3FNsLn6ddZ62SjEeimFlmFDonmQZyS4TRfMnoh06jFoWu/d8H71t/YQAi0VZ4/M1QcTC573eOdI+1ymZSUKJtqEZi+NKqFWQXXehuqpLhaAKfeeSBk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571582005932930.6814308052217;
 Sun, 20 Oct 2019 07:33:25 -0700 (PDT)
In-Reply-To: <20191020135628.16255-1-dietmar@proxmox.com>
Subject: Re: [PATCH ] yield_until_fd_readable: make it work with any AioContect
Message-ID: <157158200489.24734.4969096704390911333@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dietmar@proxmox.com
Date: Sun, 20 Oct 2019 07:33:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMDEzNTYyOC4xNjI1
NS0xLWRpZXRtYXJAcHJveG1veC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCBdIHlpZWxkX3VudGlsX2ZkX3JlYWRhYmxlOiBt
YWtlIGl0IHdvcmsgd2l0aCBhbnkgQWlvQ29udGVjdApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDog
MjAxOTEwMjAxMzU2MjguMTYyNTUtMS1kaWV0bWFyQHByb3htb3guY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmVhZDRiNWYg
eWllbGRfdW50aWxfZmRfcmVhZGFibGU6IG1ha2UgaXQgd29yayB3aXRoIGFueSBBaW9Db250ZWN0
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQx
OiBGSUxFOiB1dGlsL3FlbXUtY29yb3V0aW5lLWlvLmM6NzM6CisgICAgYWlvX3NldF9mZF9oYW5k
bGVyKGN0eCwgZmQsIGZhbHNlLCBOVUxMLCAodm9pZCAoKikodm9pZCAqKSlxZW11X2Nvcm91dGlu
ZV9lbnRlciwgTlVMTCwgcWVtdV9jb3JvdXRpbmVfc2VsZigpKTsKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMjggbGluZXMgY2hlY2tlZAoKQ29tbWl0IGVhZDRiNWZjODE3MyAoeWllbGRf
dW50aWxfZmRfcmVhZGFibGU6IG1ha2UgaXQgd29yayB3aXRoIGFueSBBaW9Db250ZWN0KSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyMDEzNTYyOC4xNjI1NS0xLWRpZXRtYXJAcHJveG1veC5j
b20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


