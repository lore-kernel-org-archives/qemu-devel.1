Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191DBECE599
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 03:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEBC20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 03:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEBC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKwJQ-0005UK-2o
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 23:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKwIm-0004uR-8A
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 23:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKwIk-0002cA-MY
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 23:18:11 -0400
Resent-Date: Wed, 16 Oct 2019 23:18:11 -0400
Resent-Message-Id: <E1iKwIk-0002cA-MY@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKwIk-0002bo-Em
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 23:18:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571279557; cv=none; d=zoho.com; s=zohoarc; 
 b=mUnNux7o3ORMrppgxtGR8lC+/T9JFskDFkSm9sSRz7oF9kJcsHFUbAKqtPW3qjmNNKBlEQ1jWEz/FwSlNDY40SFIizpeqvRpFFv4TYeHym9aVyTUBLjVPD1WZZwpAKWawpVxFtr7QvuasPrGBvEEUFEwEWsz2Ob4VMJmZRvdgME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571279557;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9z0lrA0jdjvRxBYQrseoJ3L0hvAZwodoi0YFlIrvouY=; 
 b=MqjEUVREKSdOiujZb4OyTXsYNaVYgu7ewQBTXe88Seolkc+ZsZizp2osZBbdqgf1BSzeB6uimZC4GIzHa55s7sMIXcABl5vYjR5mqeHszcUVwH76HNywAnuxNo/0WYKhDjcRU15Vm0CwcyhUOZmrpsxpQJdBW7pvbhZ9KDWwI/4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571279555862317.1057361649091;
 Wed, 16 Oct 2019 19:32:35 -0700 (PDT)
In-Reply-To: <20191017004633.13229-1-richardw.yang@linux.intel.com>
Subject: Re: [Patch v2] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
Message-ID: <157127955407.19066.17686745347793772900@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richardw.yang@linux.intel.com
Date: Wed, 16 Oct 2019 19:32:35 -0700 (PDT)
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
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, richardw.yang@linux.intel.com, stefanha@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNzAwNDYzMy4xMzIy
OS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUGF0Y2ggdjJdIGNoZWNrcGF0Y2g6IHN1
Z2d1ZXN0IHRvIHVzZSBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUgaW5zdGVhZCBvZiBnZXRwYWdl
c2l6ZSgpIG9yIHN5c2NvbmYoX1NDX1BBR0VTSVpFKQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDog
MjAxOTEwMTcwMDQ2MzMuMTMyMjktMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbQoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwozNzUxZDc2IGNoZWNrcGF0Y2g6IHN1Z2d1ZXN0IHRvIHVzZSBxZW11X3JlYWxfaG9zdF9wYWdl
X3NpemUgaW5zdGVhZCBvZiBnZXRwYWdlc2l6ZSgpIG9yIHN5c2NvbmYoX1NDX1BBR0VTSVpFKQoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMyMjog
RklMRTogc2NyaXB0cy9jaGVja3BhdGNoLnBsOjI5MTk6CisgICAgICAgICAgICAgICAgICAgICAg
IEVSUk9SKCJ1c2UgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplIGluc3RlYWQgb2YgZ2V0cGFnZXNp
emUoKVxuIiAuICRoZXJlY3Vycik7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI1
OiBGSUxFOiBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6MjkyMjoKKyAgICAgICAgICAgICAgICAgICAg
ICAgRVJST1IoInVzZSBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUgaW5zdGVhZCBvZiBzeXNjb25m
KF9TQ19QQUdFU0laRSlcbiIgLiAkaGVyZWN1cnIpOwoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxMiBsaW5lcyBjaGVja2VkCgpDb21taXQgMzc1MWQ3NjMzNjUzIChjaGVja3BhdGNoOiBz
dWdndWVzdCB0byB1c2UgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplIGluc3RlYWQgb2YgZ2V0cGFn
ZXNpemUoKSBvciBzeXNjb25mKF9TQ19QQUdFU0laRSkpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkxMDE3MDA0NjMzLjEzMjI5LTEtcmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


