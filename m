Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A965C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 21:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB71520674
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 21:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB71520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2j3w-0002yj-VQ
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 17:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2j38-0002Z1-12
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 17:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2j36-0008Ua-BK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 17:30:45 -0400
Resent-Date: Tue, 27 Aug 2019 17:30:45 -0400
Resent-Message-Id: <E1i2j36-0008Ua-BK@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2j36-0008Q8-3o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 17:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566941415; cv=none; d=zoho.com; s=zohoarc; 
 b=G3FnpdwiyjksRTaSNdOVDrQTBawL1lMQVt60wHBYsjRlKa/JNFOiDNgdBCrrFqQ0jrk1aOeJmlgxn3qPi1HcmDp42sIQoSlKnmLdE0cwKUGfiUxg9QCzLoCnsFIzrqIZKFuxG6gLslKQrWWhk7iNIUNy1aixfdLlj2nGoMC9qUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566941415;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=TCs/lSCpdlwHC+kETApHyY+LMy3j5Nx7em7La9BTdzA=; 
 b=LPt5wBzm/5DFVzsPYM6GjmMk9aIsqgMZNfRdo9kX+om4Spcfwk1T37zPeshCH2rQLeHQKkanhXRKkv5rGJNF6mbTvh8a6dWmDyoIOdWtf+EIKCbPUrIcIQNvFCuA2hZdFv8OBXPL8d9AgJtcSA8oANNfLMyfuTl4XKEN0EOK2ak=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566941414772842.4404532903651;
 Tue, 27 Aug 2019 14:30:14 -0700 (PDT)
In-Reply-To: <20190827211753.7936-1-sandra@codesourcery.com>
Message-ID: <156694141365.19632.5931521442866569939@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sandra@codesourcery.com
Date: Tue, 27 Aug 2019 14:30:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH V2] gdbstub: Fix handler for 'F' packet
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
Cc: alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyNzIxMTc1My43OTM2
LTEtc2FuZHJhQGNvZGVzb3VyY2VyeS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwODI3MjExNzUzLjc5MzYtMS1zYW5kcmFA
Y29kZXNvdXJjZXJ5LmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRD
SCBWMl0gZ2Ric3R1YjogRml4IGhhbmRsZXIgZm9yICdGJyBwYWNrZXQKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8
IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0
aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYWUzNWUwZiBn
ZGJzdHViOiBGaXggaGFuZGxlciBmb3IgJ0YnIHBhY2tldAoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
RVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQgY2xvc2UgcGFyZW50aGVzaXMgJykn
CiMzNzogRklMRTogZ2Ric3R1Yi5jOjE4Mjc6CisgICAgICAgIGlmIChnZGJfY3R4LT5udW1fcGFy
YW1zID49IDIgKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE3IGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCBhZTM1ZTBmOGI5YjYgKGdkYnN0dWI6IEZpeCBoYW5kbGVyIGZvciAnRicgcGFj
a2V0KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgyNzIxMTc1My43OTM2LTEtc2FuZHJhQGNv
ZGVzb3VyY2VyeS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


