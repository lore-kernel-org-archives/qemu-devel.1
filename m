Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822C9C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 23:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F4520863
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 23:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F4520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDzsj-0002OE-Gt
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 19:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iDzrq-0001uo-Cs
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 19:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iDzro-00052W-Ly
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 19:41:42 -0400
Resent-Date: Fri, 27 Sep 2019 19:41:42 -0400
Resent-Message-Id: <E1iDzro-00052W-Ly@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iDzro-00052I-EG; Fri, 27 Sep 2019 19:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569627668; cv=none; d=zoho.com; s=zohoarc; 
 b=KRBC2vqnXGY7xhDcgYxWFlv+tE4gdQUw1zUQT80gnJp7AExYtAHJoDlvAWhXR4Fr5o8Ywo+67Rj0fINpPCTXOgiUjB52SfHbdeQNyRx5KNSKpkmsk/9Iaq9MzMgJv2X/+wI5t4kd44oYp1GAtBOBVg6Zn3JbfnkuiBevhV9BGB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569627668;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=BBjSswHDlJTFFe3ATw5pwoQj/uDNvTbwkuN7hzliCjA=; 
 b=k9S7J8TaGjboAoQnXeBjO4nXErO+g2g8X5n6Iz9Grn7UinwGdfUfL/L1zun75cuLF+J4rQ5wkxe/4T/GBUkFr9jUur4C51c6BsyllYhcFIWXNl3kUDzkXz5JwFVxQmSYXVGEjRHotmBhQEKpX1aDSy2bMfU00hCBChSnsIyXJb4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569627666714929.4967157638256;
 Fri, 27 Sep 2019 16:41:06 -0700 (PDT)
Subject: Re: [PATCH v13 0/9] hw/m68k: add Apple Machintosh Quadra 800 machine
In-Reply-To: <20190927090453.24712-1-laurent@vivier.eu>
Message-ID: <156962766429.27524.18268403503063411250@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Fri, 27 Sep 2019 16:41:06 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNzA5MDQ1My4yNDcx
Mi0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA5MjcwOTA0NTMuMjQ3MTIt
MS1sYXVyZW50QHZpdmllci5ldQpTdWJqZWN0OiBbUEFUQ0ggdjEzIDAvOV0gaHcvbTY4azogYWRk
IEFwcGxlIE1hY2hpbnRvc2ggUXVhZHJhIDgwMCBtYWNoaW5lCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjkyMmUyZjEgQm9vdExp
bnV4Q29uc29sZVRlc3Q6IFRlc3QgdGhlIFF1YWRyYSA4MDAKZTNiZDJkNSBody9tNjhrOiBkZWZp
bmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKNWYwNDI2NSBody9tNjhrOiBhZGQgYSBkdW1teSBTV0lN
IGZsb3BweSBjb250cm9sbGVyCmMzOGE1OTcgaHcvbTY4azogYWRkIE51YnVzIG1hY2ZiIHZpZGVv
IGNhcmQKYWRhMGVlMSBody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydAo5NmM5NjVhIGh3L202OGs6
IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZpYQo1MTgyYWNhIGh3L202OGs6IGFkZCBW
SUEgc3VwcG9ydAo3N2YwNTMzIGRwODM5M3g6IG1hbmFnZSBiaWcgZW5kaWFuIGJ1cwphZWE0N2M2
IGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgYWVhNDdjNmJmYzQ4IChlc3A6IGFkZCBwc2V1ZG8t
RE1BIGFzIHVzZWQgYnkgTWFjaW50b3NoKQoyLzkgQ2hlY2tpbmcgY29tbWl0IDc3ZjA1MzM1MmQx
MiAoZHA4MzkzeDogbWFuYWdlIGJpZyBlbmRpYW4gYnVzKQozLzkgQ2hlY2tpbmcgY29tbWl0IDUx
ODJhY2FkZWQ4ZSAoaHcvbTY4azogYWRkIFZJQSBzdXBwb3J0KQpXQVJOSU5HOiBhZGRlZCwgbW92
ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM4
NDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiMzNjg6IEZJTEU6IGh3L21pc2MvbWFjX3ZpYS5jOjI4MDoKK15JXkkgIDE2NjMw
KSAvIDE2NjMwICogMTY2MzApOyQKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQg
JyYmJyAoY3R4Old4VykKIzQ1MDogRklMRTogaHcvbWlzYy9tYWNfdmlhLmM6MzYyOgorICAgICAg
ICBpZiAoISh2MXMtPmxhc3RfYiAmIFZJQTFCX3ZSVENDbGspICYmIChzLT5iICYgVklBMUJfdlJU
Q0NsaykpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0
b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDg4NSBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvOSBDaGVja2luZyBjb21taXQgOTZjOTY1YWEw
NWZiIChody9tNjhrOiBpbXBsZW1lbnQgQURCIGJ1cyBzdXBwb3J0IGZvciB2aWEpCjUvOSBDaGVj
a2luZyBjb21taXQgYWRhMGVlMTMwNzRiIChody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydCkKV0FS
TklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBu
ZWVkIHVwZGF0aW5nPwojNjU6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCA1MzEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS85IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCjYvOSBDaGVja2luZyBjb21taXQgYzM4YTU5NzU3MzRkIChody9tNjhrOiBh
ZGQgTnVidXMgbWFjZmIgdmlkZW8gY2FyZCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0
ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNzY6IApuZXcgZmls
ZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1OTcgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjcvOSBDaGVja2luZyBj
b21taXQgNWYwNDI2NTg0YTEwIChody9tNjhrOiBhZGQgYSBkdW1teSBTV0lNIGZsb3BweSBjb250
cm9sbGVyKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1B
SU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM2MzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3Rh
bDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDU5MSBsaW5lcyBjaGVja2VkCgpQYXRjaCA3LzkgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC85IENoZWNraW5nIGNvbW1pdCBlM2JkMmQ1NzM3Zjkg
KGh3L202OGs6IGRlZmluZSBNYWNpbnRvc2ggUXVhZHJhIDgwMCkKV0FSTklORzogYWRkZWQsIG1v
dmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwoj
NzE6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1
MzAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjkv
OSBDaGVja2luZyBjb21taXQgOTIyZTJmMTA4YmExIChCb290TGludXhDb25zb2xlVGVzdDogVGVz
dCB0aGUgUXVhZHJhIDgwMCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAxOTA5MjcwOTA0NTMuMjQ3MTItMS1sYXVyZW50QHZpdmllci5ldS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


