Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F580C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7940620B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7940620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYIm-0004qI-Mu
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1htYHk-00042h-Ss
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1htYHj-00038b-Nf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:11:56 -0400
Resent-Date: Fri, 02 Aug 2019 10:11:56 -0400
Resent-Message-Id: <E1htYHj-00038b-Nf@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1htYHj-00037W-GB; Fri, 02 Aug 2019 10:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564755103; cv=none; d=zoho.com; s=zohoarc; 
 b=WVxRMvmIIYHBytcXF6TNEyc94sejFfEfMIKcNEOtvz8wbxugRK97USCNwFjr24i6/0rCors+1aafr2Ih88i3+07QfQ/TC58SbiNT4chpD/+EvL7sbBnV/viX5hH5CvfM0yVCQooBs45IilRks+FuzaraqN6vOGHfwlt1JvgJmzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564755103;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=SwBoc33d1lFh1XPJnReIFytkv2E/s4dECBD6d2oolGQ=; 
 b=GOAXYu0SsvNefVdS/oHH8cGDqJQ0ngjrHI55l/UVJqRQUYJwis6J9c2OAlB4bVU8MvJfMC9R9wrPQ8Hz+rn/tj+f9Nz9kleQekp/zgGtAtoGRHdXbuY9N33oKTEcjkR4LRjXQan9cgkgLxcHJIKvBGVz7/JD4qe7WbUx5W3GerA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156475510112582.96841681330557;
 Fri, 2 Aug 2019 07:11:41 -0700 (PDT)
Message-ID: <156475509960.31476.347774062561552000@c4a48874b076>
In-Reply-To: <20190802133241.29298-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Fri, 2 Aug 2019 07:11:41 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH for-4.2 v3 0/2] s390: stop abusing
 memory_region_allocate_system_memory()
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwMjEzMzI0MS4yOTI5
OC0xLWltYW1tZWRvQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxk
IHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBi
ZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8g
YSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMg
YnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09
PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1FID09PSIKdW5hbWUg
LWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0kUFdEL2J1aWxk
Cm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNSQy9jb25maWd1
cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6IHdlIG5lZWQgcmVs
aWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0YWxsCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgogIENDICAgICAgczM5MHgtc29mdG1tdS90YXJnZXQvczM5MHgvc2ln
cC5vCiAgQ0MgICAgICBzMzkweC1zb2Z0bW11L3RhcmdldC9zMzkweC9rdm0ubwovdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtYmNmeGJrZWcvc3JjL3RhcmdldC9zMzkweC9rdm0uYzogSW4gZnVu
Y3Rpb24g4oCYa3ZtX2FyY2hfaW5pdOKAmToKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWJj
Znhia2VnL3NyYy90YXJnZXQvczM5MHgva3ZtLmM6MzUwOjU6IGVycm9yOiBpbXBsaWNpdCBkZWNs
YXJhdGlvbiBvZiBmdW5jdGlvbiDigJhrdm1fc2V0X21heF9tZW1zbG90X3NpemXigJk7IGRpZCB5
b3UgbWVhbiDigJhrdm1fZ2V0X21heF9tZW1zbG90c+KAmT8gWy1XZXJyb3I9aW1wbGljaXQtZnVu
Y3Rpb24tZGVjbGFyYXRpb25dCiAgMzUwIHwgICAgIGt2bV9zZXRfbWF4X21lbXNsb3Rfc2l6ZShL
Vk1fU0xPVF9NQVhfQllURVMpOwogICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4K
ICAgICAgfCAgICAga3ZtX2dldF9tYXhfbWVtc2xvdHMKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWJjZnhia2VnL3NyYy90YXJnZXQvczM5MHgva3ZtLmM6MzUwOjU6IGVycm9yOiBuZXN0ZWQg
ZXh0ZXJuIGRlY2xhcmF0aW9uIG9mIOKAmGt2bV9zZXRfbWF4X21lbXNsb3Rfc2l6ZeKAmSBbLVdl
cnJvcj1uZXN0ZWQtZXh0ZXJuc10KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBl
cnJvcnMKbWFrZVsxXTogKioqIFsvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYmNmeGJrZWcv
c3JjL3J1bGVzLm1hazo2OTogdGFyZ2V0L3MzOTB4L2t2bS5vXSBFcnJvciAxCm1ha2U6ICoqKiBb
TWFrZWZpbGU6NDcyOiBzMzkweC1zb2Z0bW11L2FsbF0gRXJyb3IgMgoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA4MDIxMzMyNDEuMjky
OTgtMS1pbWFtbWVkb0ByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


