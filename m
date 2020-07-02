Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFF2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9148620675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9148620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxNg-0005CX-OY
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqxEP-0004Ri-Ih
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:18:17 -0400
Resent-Date: Thu, 02 Jul 2020 07:18:17 -0400
Resent-Message-Id: <E1jqxEP-0004Ri-Ih@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqxEM-0004t7-Oq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:18:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593688682; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W8aIdI39o1ar70+//6t52AlnzvzH3y6/C/Z9gwLYXFo73c9LSILReu93ViCAc+5AL4vB5nkLvazBuVIcWrmEfrJOG4ikASUbTdgziT36K0Vwa7YqyS2ivU9GTNJeb0FmarD47RfGklVJ1gClFtWupXFg1XGgxZrXRFK1mZhtVFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593688682;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=8cWA2B2ZLyaq+5/pZjLvCJoSL0C8tLvKVvDOGd5RsQ8=; 
 b=WePxmjbKjB+uAnPkYSfiyWWApq5TyqJB/tI+MVzTxEoPzOPJ+7yExJ3J7ysYYgnbc11nz0wNYi3dALi/XF5q3aykYQ4dQ0OlTPrNOx0AitR664M5SQblnNY1nUXAk98GF8IjmVqZMhGG/JNOJY4abkDUdnnauA4+4lrGLKm4t34=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593688680070235.23267218737737;
 Thu, 2 Jul 2020 04:18:00 -0700 (PDT)
Message-ID: <159368867881.4269.16096527388554272035@d1fd068a5071>
Subject: Re: [PATCH] linux-user: Fix "print_fdset()" in "strace.c" to not
 print ", " after last value
In-Reply-To: <20200702102749.22178-1-Filip.Bozuta@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Filip.Bozuta@syrmia.com
Date: Thu, 2 Jul 2020 04:18:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 07:18:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, Filip.Bozuta@syrmia.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMjEwMjc0OS4yMjE3
OC0xLUZpbGlwLkJvenV0YUBzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIGxpbnV4LXVzZXI6IEZpeCAicHJpbnRf
ZmRzZXQoKSIgaW4gInN0cmFjZS5jIiB0byBub3QgcHJpbnQgIiwgIiBhZnRlciBsYXN0IHZhbHVl
ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcwMjEwMjc0OS4yMjE3OC0xLUZpbGlwLkJv
enV0YUBzeXJtaWEuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJv
bSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAg
ICAgICAgcGF0Y2hldy8yMDIwMDcwMjEwMjc0OS4yMjE3OC0xLUZpbGlwLkJvenV0YUBzeXJtaWEu
Y29tIC0+IHBhdGNoZXcvMjAyMDA3MDIxMDI3NDkuMjIxNzgtMS1GaWxpcC5Cb3p1dGFAc3lybWlh
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmRmZjA2NzQgbGludXgtdXNlcjog
Rml4ICJwcmludF9mZHNldCgpIiBpbiAic3RyYWNlLmMiIHRvIG5vdCBwcmludCAiLCAiIGFmdGVy
IGxhc3QgdmFsdWUKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1v
ZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjEgbGluZXMgY2hl
Y2tlZAoKQ29tbWl0IGRmZjA2NzQ2OTZjZSAobGludXgtdXNlcjogRml4ICJwcmludF9mZHNldCgp
IiBpbiAic3RyYWNlLmMiIHRvIG5vdCBwcmludCAiLCAiIGFmdGVyIGxhc3QgdmFsdWUpIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAyMTAyNzQ5LjIyMTc4LTEtRmlsaXAuQm96dXRhQHN5cm1p
YS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

