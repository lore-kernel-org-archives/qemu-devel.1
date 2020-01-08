Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD11C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0B02067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0B02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDbX-00079e-Or
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipDas-0006dZ-6A
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipDaq-0004Nd-Gk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:50:01 -0500
Resent-Date: Wed, 08 Jan 2020 10:50:01 -0500
Resent-Message-Id: <E1ipDaq-0004Nd-Gk@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipDaq-0004MI-8X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:50:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578498590; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nmcXanjY5txLQIQZbRUX13m/PwG6DHCNTdPGZMSBUbJiO7tAF0liR3x5IpowQPejs19sJz1qUiJHpSbTTOSa8MV008odPrRmychOT2tPngQ9GijQjFXPt88Zjk2qyVDJNSVurmUI24v3Vm5JTjXq4/RZc5uzdaGlbN9jxtZFW1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578498590;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=bPOOfAsk2mhKfU7sbKaGZCBqFCNRMTQqAzO6OlqZpbg=; 
 b=PFnu6EKs6OlYmbXhKrUxDFBUaJ5UUri8OA9WdtWwhwn4N+UMXex+ggTkHhZOaM9pavjw5OjndNDjKv6aydMebmRQor0xSlOpHPbNbBNI8csEsrz/Kqj0Iy3dNAa5COQpbFh8Vn3Xq5G7W6HuayP9NkGKOl5stYvOEzI2rO6rA7k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15784985864537.151675586080842;
 Wed, 8 Jan 2020 07:49:46 -0800 (PST)
In-Reply-To: <20200108125658.208480-2-afscoelho@gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
Message-ID: <157849858535.6292.9449517604780054721@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: afscoelho@gmail.com
Date: Wed, 8 Jan 2020 07:49:46 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwODEyNTY1OC4yMDg0
ODAtMi1hZnNjb2VsaG9AZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHZpcnRpbzogUHJldmVudCBkb3VibGUgc3dh
cCBkdWUgdG8gdGFyZ2V0IHByZSAxLjAgVmlydElPClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAy
MDIwMDEwODEyNTY1OC4yMDg0ODAtMi1hZnNjb2VsaG9AZ21haWwuY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzY0MmY3M2M3OGE5OTI1OGRjMTM0ZTM4
NzlhMDI4N2RiOGVmMTc2YzAuMTU3ODQ5NzI0NS5naXQudGdvbGVtYmlAcmVkaGF0LmNvbSAtPiBw
YXRjaGV3LzY0MmY3M2M3OGE5OTI1OGRjMTM0ZTM4NzlhMDI4N2RiOGVmMTc2YzAuMTU3ODQ5NzI0
NS5naXQudGdvbGVtYmlAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjFkM2NiMmIgdmlydGlvOiBQcmV2ZW50IGRvdWJsZSBzd2FwIGR1ZSB0byB0YXJnZXQgcHJlIDEu
MCBWaXJ0SU8KCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYt
Ynk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzAgbGluZXMgY2hlY2tl
ZAoKQ29tbWl0IDFkM2NiMmI0MzZmMCAodmlydGlvOiBQcmV2ZW50IGRvdWJsZSBzd2FwIGR1ZSB0
byB0YXJnZXQgcHJlIDEuMCBWaXJ0SU8pIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTA4MTI1
NjU4LjIwODQ4MC0yLWFmc2NvZWxob0BnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


