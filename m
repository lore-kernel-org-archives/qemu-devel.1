Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002BFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 04:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C090422316
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 04:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C090422316
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWulV-0002ik-SP
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 23:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iWukr-0002Hq-Q0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iWukq-0006Wh-Ar
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:04:41 -0500
Resent-Date: Mon, 18 Nov 2019 23:04:41 -0500
Resent-Message-Id: <E1iWukq-0006Wh-Ar@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iWukq-0006W3-2k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:04:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574136265; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q9qyvop7LEp9Q2X4N395iUYO/LV9ugIsZ/4sz5VCnIo4Z23Ch8YgABWeomQSW1LsxZm3/+bU6Ml0/CiPgN5Lo7Dwal6s8vSHj3AvYYINyTu5xRi03c07XqHo9YYavWb7NdH/uW72PNXNKwdwQOAoYKJla9iKlM6Li7PnSBDGpbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574136265;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GI5SWRvB75dnjiOK7rHXcmxBQEINBOkbgLC1MFx+hrM=; 
 b=KYXW8CnWf9zBEv/YLb+ff3A/X8cZekeN5fgUAhYw0iGXkP9hUF8kwBX/11gDpse5N8V7oj9gJgD9UHT/yTcAvMJMGDi1tFz9bsiGd/PSc3qINwsaKuYDMOlVvoZSdkHI/2xNXglnDP8nNCMlQqKrHE+PB0bf+3odu+YRRKOa3Ik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574136263378725.9584793739349;
 Mon, 18 Nov 2019 20:04:23 -0800 (PST)
In-Reply-To: <20191119022640.11021-1-michan@redhat.com>
Subject: Re: [PATCH v4] Implement backend program convention command for
 vhost-user-blk
Message-ID: <157413626220.27250.4280058310420645706@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: chanmickyyun@gmail.com
Date: Mon, 18 Nov 2019 20:04:23 -0800 (PST)
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
Cc: michan@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 chanmickyyun@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExOTAyMjY0MC4xMTAy
MS0xLW1pY2hhbkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjRdIEltcGxlbWVudCBiYWNrZW5kIHByb2dyYW0g
Y29udmVudGlvbiBjb21tYW5kIGZvciB2aG9zdC11c2VyLWJsawpUeXBlOiBzZXJpZXMKTWVzc2Fn
ZS1pZDogMjAxOTExMTkwMjI2NDAuMTEwMjEtMS1taWNoYW5AcmVkaGF0LmNvbQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowMzZl
YTQ1IEltcGxlbWVudCBiYWNrZW5kIHByb2dyYW0gY29udmVudGlvbiBjb21tYW5kIGZvciB2aG9z
dC11c2VyLWJsawoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IHN1c3BlY3QgY29kZSBpbmRl
bnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDgsIDExKQojOTI6IEZJTEU6IGNvbnRyaWIv
dmhvc3QtdXNlci1ibGsvdmhvc3QtdXNlci1ibGsuYzo2MzA6CisgICAgICAgIGlmIChsc29jayA8
IDApIHsKKyAgICAgICAgICAgZXhpdChFWElUX0ZBSUxVUkUpOwoKRVJST1I6IHNwYWNlIHJlcXVp
cmVkIGJlZm9yZSB0aGUgb3BlbiBicmFjZSAneycKIzk1OiBGSUxFOiBjb250cmliL3Zob3N0LXVz
ZXItYmxrL3Zob3N0LXVzZXItYmxrLmM6NjMzOgorICAgIH0gZWxzZSBpZihvcHRfZmRudW0gPCAw
KXsKCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gcGFyZW50aGVzaXMgJygn
CiM5NTogRklMRTogY29udHJpYi92aG9zdC11c2VyLWJsay92aG9zdC11c2VyLWJsay5jOjYzMzoK
KyAgICB9IGVsc2UgaWYob3B0X2ZkbnVtIDwgMCl7Cgp0b3RhbDogMyBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDE0MyBsaW5lcyBjaGVja2VkCgpDb21taXQgMDM2ZWE0NTdiNDNhIChJbXBsZW1lbnQgYmFj
a2VuZCBwcm9ncmFtIGNvbnZlbnRpb24gY29tbWFuZCBmb3Igdmhvc3QtdXNlci1ibGspIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTE5MDIyNjQwLjExMDIxLTEtbWljaGFuQHJlZGhhdC5jb20v
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


