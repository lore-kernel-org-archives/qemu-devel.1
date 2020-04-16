Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE62C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3CF206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3CF206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPC9G-0000na-4m
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 17:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jPC8O-0008T1-Mc
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jPC8N-0004XD-34
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:33:20 -0400
Resent-Date: Thu, 16 Apr 2020 17:33:20 -0400
Resent-Message-Id: <E1jPC8N-0004XD-34@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jPC8M-0004WU-Ra
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:33:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587072788; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TCASvUki+pq+qUCPygNeTJtfFIcHVncuUY3vsw4K5sMijgTqsisiKPGjhnRdPOXQ6GUYSQOrEzolsXJ8WLt7IgonU+ekR2oM7VQ6SjF1ZfCqWKFE7Oy/3Sg9dtJEMCSaHn4opW4z5X0QGJQdQi0vPtLGlbuRrTPwNMdQlR/N6Hg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587072788;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4oPLJosxG7lHkd47nb4tQebVWnffZbcKvXz9Y7zfC0w=; 
 b=YyhTJA41yMiWewXIBiZHHH346kx99uwW95KDCGpZUGZoMoOx2WY8lcgEeSIdLRkrt9M4oMhb2yvjHtDHDfv2zmYemyY9UDac3sJR95TI+JQD7JQvdekdc5ReduEJI0ad/J2vLP/RK83dwegiaJC9hPD13/hMvLhnU2SHU27ocOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587072787347972.7866598241501;
 Thu, 16 Apr 2020 14:33:07 -0700 (PDT)
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
Subject: Re: [PATCH 0/4] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <158707278589.15335.6263551213569071566@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Thu, 16 Apr 2020 14:33:07 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, mlevitsk@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNjIwMzYyNC4zMjM2
Ni0xLW1sZXZpdHNrQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzRdIFJGQy9XSVA6IEZpeCBzY3NpIGRldmlj
ZXMgcGx1Zy91bnBsdWcgcmFjZXMgdy5yLnQgdmlydGlvLXNjc2kgaW90aHJlYWQKTWVzc2FnZS1p
ZDogMjAyMDA0MTYyMDM2MjQuMzIzNjYtMS1tbGV2aXRza0ByZWRoYXQuY29tClR5cGU6IHNlcmll
cwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJh
c2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20v
cGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDQx
NjIxMjM0OS43MzE0MDQtMS1lYmxha2VAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNDE2MjEy
MzQ5LjczMTQwNC0xLWVibGFrZUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKNWU0NzE1NSB2aXJ0aW8tc2NzaTogZG9uJ3QgdG91Y2ggc2NzaSBkZXZpY2VzIHRoYXQg
YXJlIG5vdCB5ZXQgcmVhbGl6ZWQKN2E0ZTIwYiBkZXZpY2UtY29yZTogdXNlIGF0b21pY19zZXQg
b24gLnJlYWxpemVkIHByb3BlcnR5CmM4YzZkNzIgZGV2aWNlLWNvcmU6IHVzZSBSQ1UgZm9yIGxp
c3Qgb2YgY2hpbGRzIG9mIGEgYnVzCjdiM2NhNjMgc2NzaS9zY3NpX2J1czogc3dpdGNoIHNlYXJj
aCBkaXJlY3Rpb24gaW4gc2NzaV9kZXZpY2VfZmluZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS80
IENoZWNraW5nIGNvbW1pdCA3YjNjYTYzNmJlMmYgKHNjc2kvc2NzaV9idXM6IHN3aXRjaCBzZWFy
Y2ggZGlyZWN0aW9uIGluIHNjc2lfZGV2aWNlX2ZpbmQpCjIvNCBDaGVja2luZyBjb21taXQgYzhj
NmQ3MjMwNjAyIChkZXZpY2UtY29yZTogdXNlIFJDVSBmb3IgbGlzdCBvZiBjaGlsZHMgb2YgYSBi
dXMpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gYnJhY2UgJ3snCiMzNDog
RklMRTogaHcvY29yZS9idXMuYzo1MjoKKyAgICBXSVRIX1JDVV9SRUFEX0xPQ0tfR1VBUkQoKXsK
CkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gYnJhY2UgJ3snCiM4ODogRklM
RTogaHcvY29yZS9idXMuYzoyMDA6CisgICAgICAgIFdJVEhfUkNVX1JFQURfTE9DS19HVUFSRCgp
ewoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNTUgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
Mi80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzQgQ2hlY2tpbmcgY29tbWl0IDdhNGUy
MGJmOWQyNSAoZGV2aWNlLWNvcmU6IHVzZSBhdG9taWNfc2V0IG9uIC5yZWFsaXplZCBwcm9wZXJ0
eSkKNC80IENoZWNraW5nIGNvbW1pdCA1ZTQ3MTU1Nzk0YmYgKHZpcnRpby1zY3NpOiBkb24ndCB0
b3VjaCBzY3NpIGRldmljZXMgdGhhdCBhcmUgbm90IHlldCByZWFsaXplZCkKV0FSTklORzogQmxv
Y2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzMzOiBGSUxF
OiBody9zY3NpL3ZpcnRpby1zY3NpLmM6NDk6CisgICAgLyogVGhpcyBmdW5jdGlvbiBtaWdodCBy
dW4gb24gdGhlIElPIHRocmVhZCBhbmQgd2UgbWlnaHQgcmFjZSBhZ2FpbnN0Cgp0b3RhbDogMCBl
cnJvcnMsIDEgd2FybmluZ3MsIDMwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDQxNjIwMzYyNC4zMjM2Ni0xLW1sZXZpdHNrQHJlZGhhdC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

