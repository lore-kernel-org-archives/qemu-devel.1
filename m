Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE506C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8882E20866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8882E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb3zE-0007qY-Jn
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hb3uV-0005Nk-AZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hb3uR-0007wR-OH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:07:30 -0400
Resent-Date: Wed, 12 Jun 2019 10:07:28 -0400
Resent-Message-Id: <E1hb3uR-0007wR-OH@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21501)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hb3uO-0007sN-Vb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560348378; cv=none; d=zoho.com; s=zohoarc; 
 b=MbFy9QNBjlOGYgC7bvSu15ubAA4aE2AhT9fLgcf50nvl9AhMeMoebfCeGM+nWpQHBkyi57CY3s/wxwTO46eKP5u6JrWgL1vV4GswrDMmeXRSyvS3/w0zhpg42ACyI6MuDp+/aSJk5TI0JTeoM9U7R+/oqVbm6z/X652LtmsbkKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560348378;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=KHWeLwDY9DOzzMln0Gvm3zjxUOH+dCdwxd+0wsJCrhE=; 
 b=mLujrpSUDDbfmi2RJ4mhBAdFvwEJto2vklCFOz9bPbpa4FGqb8WbD/qdDMhlq7dUApREuj0rNWt+GG79CxL24+1A9XBhszsrZs8joS3W9cB+jUZYKT7mqHHuYnwFKPgscJYxPjXIgoKUHeO3SxUFiCQc+uJ8h25VOsqtO2mnF4g=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560348376243614.669213973121;
 Wed, 12 Jun 2019 07:06:16 -0700 (PDT)
In-Reply-To: <20190612120421.20336-1-stefanha@redhat.com>
Message-ID: <156034837501.31589.6169189435622024069@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Wed, 12 Jun 2019 07:06:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v4] virtio-scsi: restart DMA after iothread
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
Cc: kwolf@redhat.com, fam@euphon.net, mst@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxMjEyMDQyMS4yMDMz
Ni0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjRdIHZpcnRpby1zY3Np
OiByZXN0YXJ0IERNQSBhZnRlciBpb3RocmVhZApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAx
OTA2MTIxMjA0MjEuMjAzMzYtMS1zdGVmYW5oYUByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9q
ZWN0L3FlbXUKICAgMjE5ZGNhNjFlYi4uNTljNThmOTZiMiAgbWFzdGVyICAgICAtPiBtYXN0ZXIK
RnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWdd
ICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDYxMjEyMDQyMS4yMDMzNi0xLXN0ZWZhbmhhQHJl
ZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDYxMjEyMDQyMS4yMDMzNi0xLXN0ZWZhbmhhQHJlZGhh
dC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkMWQ0OTA3MWZmIHZpcnRpby1z
Y3NpOiByZXN0YXJ0IERNQSBhZnRlciBpb3RocmVhZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJS
T1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVu
dGhlc2lzICcoJwojODg6IEZJTEU6IHZsLmM6MTQ3MjoKKyAgICBRVEFJTFFfRU5UUlkgKHZtX2No
YW5nZV9zdGF0ZV9lbnRyeSkgZW50cmllczsKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdl
ZW4gZnVuY3Rpb24gbmFtZSBhbmQgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzEwMTogRklMRTogdmwu
YzoxNDg0OgorICAgIGUgPSBnX21hbGxvYzAoc2l6ZW9mICgqZSkpOwoKRVJST1I6IHNwYWNlIHBy
b2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJwoj
MTM2OiBGSUxFOiB2bC5jOjE1MTA6CisgICAgUVRBSUxRX1JFTU9WRSAoJnZtX2NoYW5nZV9zdGF0
ZV9oZWFkLCBlLCBlbnRyaWVzKTsKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVu
Y3Rpb24gbmFtZSBhbmQgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzE2MjogRklMRTogdmwuYzozMDM2
OgorICAgIFFUQUlMUV9JTklUICgmdm1fY2hhbmdlX3N0YXRlX2hlYWQpOwoKdG90YWw6IDQgZXJy
b3JzLCAwIHdhcm5pbmdzLCAxMjIgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGQxZDQ5MDcxZmY2ZSAo
dmlydGlvLXNjc2k6IHJlc3RhcnQgRE1BIGFmdGVyIGlvdGhyZWFkKSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MDYxMjEyMDQyMS4yMDMzNi0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


