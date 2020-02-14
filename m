Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D45C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 23:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC932086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 23:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC932086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2kUH-0004Af-Ae
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 18:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j2kTl-0003ie-6m
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j2kTj-0000P1-Rj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:34:36 -0500
Resent-Date: Fri, 14 Feb 2020 18:34:36 -0500
Resent-Message-Id: <E1j2kTj-0000P1-Rj@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j2kTj-0000Nd-KD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 18:34:35 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581723271; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ouk8Qr3jMhWOtt8pDWIqfg9E6SDbkP3RhvqrBQ0Cx5F/B/Ver0p8GBcONxOJUcD3qE+5H1Ou1oY6iKMmoeNj1Pmj1ipE6dAHMZPnBxPEteqXBEH3BPTAYsvPYInHzuYXnKh8GpQy10T7wTniMDxhpeJxeGzUt5/OEYwBvP8C/K0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581723271;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LgZBwn9LrN8Q98wKK+ShXZ4nusdA9UAYom7jln0PUeA=; 
 b=cTC5SzhEvBlSk1ZW0db7srWzqXnggtf8XO4QwlLa/iAjw2rBsPiNeoMItXJryHFoa+LGvzn0TYMJcKL+cdlXpoRpwvr8M5uKyKRBm+d9nrIaSOC7Ypg5SONcma3OmEpg1UCHHZTUeyKh0DsO/80afpaDRbO1lJ9MJmyGUcrDSDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581723269668475.35159947764566;
 Fri, 14 Feb 2020 15:34:29 -0800 (PST)
In-Reply-To: <20200214232650.35381-1-kevinb@redhat.com>
Subject: Re: [PATCH] Handle gdb.MemoryError exception in dump-guest-memory.py
Message-ID: <158172326858.6932.4141565337443141392@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kevinb@redhat.com
Date: Fri, 14 Feb 2020 15:34:29 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, kevinb@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNDIzMjY1MC4zNTM4
MS0xLWtldmluYkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIEhhbmRsZSBnZGIuTWVtb3J5RXJyb3IgZXhjZXB0
aW9uIGluIGR1bXAtZ3Vlc3QtbWVtb3J5LnB5Ck1lc3NhZ2UtaWQ6IDIwMjAwMjE0MjMyNjUwLjM1
MzgxLTEta2V2aW5iQHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDIxNDIzMjY1MC4zNTM4MS0x
LWtldmluYkByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDAyMTQyMzI2NTAuMzUzODEtMS1rZXZp
bmJAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmI0MTMwMGEgSGFu
ZGxlIGdkYi5NZW1vcnlFcnJvciBleGNlcHRpb24gaW4gZHVtcC1ndWVzdC1tZW1vcnkucHkKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykK
CnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTMgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGI0
MTMwMGFmMDgxOCAoSGFuZGxlIGdkYi5NZW1vcnlFcnJvciBleGNlcHRpb24gaW4gZHVtcC1ndWVz
dC1tZW1vcnkucHkpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjE0MjMyNjUwLjM1MzgxLTEt
a2V2aW5iQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

