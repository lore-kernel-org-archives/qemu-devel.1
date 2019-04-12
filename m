Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C97C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527C720850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527C720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39675 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyyD-0005W8-JF
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:24:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEyx0-0004VF-8S
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEywy-0002Wt-IB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:22:50 -0400
Resent-Date: Fri, 12 Apr 2019 12:22:49 -0400
Resent-Message-Id: <E1hEywy-0002Wt-IB@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hEywy-0002Ul-7a; Fri, 12 Apr 2019 12:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555086150; cv=none; d=zoho.com; s=zohoarc; 
	b=DLx9hXgZ02Tvc4Twzjpne5rEwu+ZgHTy0FehFqWqIwFf/ZpS1EoFKuRQ3b+98ktUnQsiQEa4SehrzyaH0j3uHkTwF4peK9/7bioGcmT9xuc8PsyUgtH6jQcAQ0yEJ/LfP6pz+olZEb7q+T8q6ueHbe/REoKd1YKbYBSwXq2DwkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555086150;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=J3h19ZVidT7NF+J6wJZgLOb5IRrOzfvBudQ2anZp9o8=; 
	b=Og1wxWlb/o7HwX8FbtT073Z+/6bsa7t0fdnijnrtlM1VdqwzI8esodU8cUlvMtdd7ma1B/3gHqBuMV9A78et7Q4iDF80tFH7B/yA9kFuk4mg2b8/YWRQ6ITwqpqrUTHyqelD6YyDMT9KO6Y6+NNNCDJq9hrXsTUM39OzH9axyAY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555086149490144.02467124688724;
	Fri, 12 Apr 2019 09:22:29 -0700 (PDT)
Message-ID: <155508614786.29694.6898774797090055516@76452e4e88f2>
In-Reply-To: <20190412153647.19027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Fri, 12 Apr 2019 09:22:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v5 00/13] vhost-user for input & GPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	kraxel@redhat.com, marcandre.lureau@redhat.com,
	pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412162229.4ietRRNEqZMDon9Sb2aZRnJWb1aoC1Fq6do4-9nWiUk@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxMjE1MzY0Ny4xOTAy
Ny0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMg
YW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91
IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJH
RVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9jb250cmliL3Zo
b3N0LXVzZXItZ3B1L3ZpcmdsLmM6MTY6CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUt
dGVzdC9zcmMvY29udHJpYi92aG9zdC11c2VyLWdwdS92aXJnbC5oOjE3OgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL2NvbnRyaWIvdmhvc3QtdXNlci1ncHUvdnVncHUu
aDoyNToKL3RtcC9xZW11LXRlc3Qvc3JjL2NvbnRyaWIvdmhvc3QtdXNlci1ncHUvZHJtLmg6MTU6
MTA6IGZhdGFsIGVycm9yOiAnaTkxNV9kcm0uaCcgZmlsZSBub3QgZm91bmQKI2luY2x1ZGUgPGk5
MTVfZHJtLmg+CiAgICAgICAgIF5+fn5+fn5+fn5+fgogIENDICAgICAgYmxvY2tqb2IubwotLS0K
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9jb250cmliL3Zob3N0LXVzZXItZ3B1L21haW4uYzoy
MToKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9jb250cmliL3Zob3N0
LXVzZXItZ3B1L3Z1Z3B1Lmg6MjU6Ci90bXAvcWVtdS10ZXN0L3NyYy9jb250cmliL3Zob3N0LXVz
ZXItZ3B1L2RybS5oOjE1OjEwOiBmYXRhbCBlcnJvcjogJ2k5MTVfZHJtLmgnIGZpbGUgbm90IGZv
dW5kCiNpbmNsdWRlIDxpOTE1X2RybS5oPgogICAgICAgICBefn5+fn5+fn5+fn4KL3RtcC9xZW11
LXRlc3Qvc3JjL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmM6NTQ2OjMyOiBl
cnJvcjogdGFraW5nIGFkZHJlc3Mgb2YgcGFja2VkIG1lbWJlciAncGF5bG9hZCcgb2YgY2xhc3Mg
b3Igc3RydWN0dXJlICdWaG9zdFVzZXJNc2cnIG1heSByZXN1bHQgaW4gYW4gdW5hbGlnbmVkIHBv
aW50ZXIgdmFsdWUgWy1XZXJyb3IsLVdhZGRyZXNzLW9mLXBhY2tlZC1tZW1iZXJdCiAgICBWaG9z
dFVzZXJNZW1vcnkgKm1lbW9yeSA9ICZ2bXNnLT5wYXlsb2FkLm1lbW9yeTsKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9jb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jOjY4ODozMjogZXJyb3I6IHRh
a2luZyBhZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgJ3BheWxvYWQnIG9mIGNsYXNzIG9yIHN0cnVj
dHVyZSAnVmhvc3RVc2VyTXNnJyBtYXkgcmVzdWx0IGluIGFuIHVuYWxpZ25lZCBwb2ludGVyIHZh
bHVlIFstV2Vycm9yLC1XYWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyXQogICAgVmhvc3RVc2VyTWVt
b3J5ICptZW1vcnkgPSAmdm1zZy0+cGF5bG9hZC5tZW1vcnk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvY29udHJp
Yi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzo4MTc6Mzc6IGVycm9yOiB0YWtpbmcgYWRk
cmVzcyBvZiBwYWNrZWQgbWVtYmVyICdwYXlsb2FkJyBvZiBjbGFzcyBvciBzdHJ1Y3R1cmUgJ1Zo
b3N0VXNlck1zZycgbWF5IHJlc3VsdCBpbiBhbiB1bmFsaWduZWQgcG9pbnRlciB2YWx1ZSBbLVdl
cnJvciwtV2FkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcl0KICAgIHN0cnVjdCB2aG9zdF92cmluZ19h
ZGRyICp2cmEgPSAmdm1zZy0+cGF5bG9hZC5hZGRyOwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn4KMyBlcnJvcnMgZ2VuZXJhdGVkLgoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MTIx
NTM2NDcuMTkwMjctMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVzdGluZy5hc2FuLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


