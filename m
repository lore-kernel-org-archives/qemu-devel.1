Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CEEFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 10:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7E820872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 10:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7E820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKghk-0002Ko-Kv
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKgVV-0003kB-LO
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKgVT-0004bz-F1
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:26:16 -0400
Resent-Date: Wed, 16 Oct 2019 06:26:16 -0400
Resent-Message-Id: <E1iKgVT-0004bz-F1@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKgVT-0004bc-7E
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571221555; cv=none; d=zoho.com; s=zohoarc; 
 b=ac8wwzUCI/u6Mc/JRXwjIatax8iXazv9tGbvHQsgOjD8/xBULUL0juvbaNvEzJO/mRx9Y9X6ibvXsR767PDbNDAmAOhMcmSU/1oAGa4WQOinGuGgtDIrWLLCJZFFThNu7fgPAT2PjIMRCt5BPTN8pKsgXjcnD4rmhYm9FSyNqnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571221555;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xexpKex7QjFMKBi4yvtErZ8AX45OV1QFkSSUVYci4RU=; 
 b=YKM83KYu3Fat1eG/bLIkLlE09AhZpRUMp5rOooZ+h2uXyyA2JakCw52Gbtsx6sClvPmGqzfYddDpZhq4wZp5+9lMr6nHMUnkRq5+4nAHuF/jtkcMyDLc/2Er+Bdf4MQ++LCUljLF8seBwBtptkRuR4+IhwMg/cNUya3Qnb2KUo0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157122155331045.17708430399648;
 Wed, 16 Oct 2019 03:25:53 -0700 (PDT)
In-Reply-To: <20191016012432.22731-1-richardw.yang@linux.intel.com>
Subject: Re: [PATCH] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
Message-ID: <157122155178.13250.10914060468230367742@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richardw.yang@linux.intel.com
Date: Wed, 16 Oct 2019 03:25:53 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 richardw.yang@linux.intel.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNjAxMjQzMi4yMjcz
MS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIGNoZWNrcGF0Y2g6IHN1Z2d1
ZXN0IHRvIHVzZSBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUgaW5zdGVhZCBvZiBnZXRwYWdlc2l6
ZSgpIG9yIHN5c2NvbmYoX1NDX1BBR0VTSVpFKQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAx
OTEwMTYwMTI0MzIuMjI3MzEtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbQoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2
YzNlMDM1IGNoZWNrcGF0Y2g6IHN1Z2d1ZXN0IHRvIHVzZSBxZW11X3JlYWxfaG9zdF9wYWdlX3Np
emUgaW5zdGVhZCBvZiBnZXRwYWdlc2l6ZSgpIG9yIHN5c2NvbmYoX1NDX1BBR0VTSVpFKQoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMyMDogRklM
RTogc2NyaXB0cy9jaGVja3BhdGNoLnBsOjI5MTk6CisgICAgICAgICAgICAgICAgICAgICAgIEVS
Uk9SKCJ1c2UgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplIGluc3RlYWQgb2YgZ2V0cGFnZXNpemUo
KVxuIiAuICRoZXJlY3Vycik7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzIzOiBG
SUxFOiBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6MjkyMjoKKyAgICAgICAgICAgICAgICAgICAgICAg
RVJST1IoInVzZSBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUgaW5zdGVhZCBvZiBzeXNjb25mKF9T
Q19QQUdFU0laRSlcbiIgLiAkaGVyZWN1cnIpOwoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxMiBsaW5lcyBjaGVja2VkCgpDb21taXQgNmMzZTAzNTRhODNmIChjaGVja3BhdGNoOiBzdWdn
dWVzdCB0byB1c2UgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplIGluc3RlYWQgb2YgZ2V0cGFnZXNp
emUoKSBvciBzeXNjb25mKF9TQ19QQUdFU0laRSkpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkx
MDE2MDEyNDMyLjIyNzMxLTEtcmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


