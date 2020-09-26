Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39333C4727C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 01:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A576220878
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 01:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A576220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLyfA-00041S-IH
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 21:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLyeP-0003XO-W0
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 21:05:22 -0400
Resent-Date: Fri, 25 Sep 2020 21:05:21 -0400
Resent-Message-Id: <E1kLyeP-0003XO-W0@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLyeN-0001sd-Lq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 21:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601082312; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dwRvJmsPKB2u732dfn+GHiBm2K+G1wWrjhlDC7Ihr6NY2uAnQVGTo8bTYJO/guphRGq6k4ZBERLLQ/ppSZXywObqfpqi8QpQOMgSdSobX7Bw7sAtpOcfCRPEo3TIhG8VcQQH6HcR48GFqVmPZPy+b5SKAiaDDyu61i2WwUKft+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601082312;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ZJMSQsK6dJkdcLPZ6vEUzH8W3RxJxM+NU+5qxuN2c3U=; 
 b=EJEgomD+9yUfQwG1B1TXDqFLJIkGVSHS2iZ/14wAzqKYYonZbdXKBXw4CwfP2zGOm7Mt0te7MERRDDfhfBXTyCQHhis5WpFtOQHDOyJOxmn67bO5aAGhmpRjky4ecomJShDHYK2j9V602NwDdzdDFI/8PLwulMS8Xvd0QV9ut4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601082311717768.3493973390165;
 Fri, 25 Sep 2020 18:05:11 -0700 (PDT)
Subject: Re: [PATCH 00/10] Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <160108231036.10465.13572953411184844845@66eaa9a8a123>
In-Reply-To: <20200925172604.2142227-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Fri, 25 Sep 2020 18:05:11 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 18:53:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNTE3MjYwNC4yMTQy
MjI3LTEtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTI1MTcyNjA0LjIx
NDIyMjctMS1wYm9uemluaUByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCAwMC8xMF0gRml4IHNj
c2kgZGV2aWNlcyBwbHVnL3VucGx1ZyByYWNlcyB3LnIudCB2aXJ0aW8tc2NzaSBpb3RocmVhZAoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2Ug
PiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKYzNmMGM4ZiBzY3NpL3Njc2lfYnVzOiBmaXggcmFjZXMgaW4gUkVQT1JUIExV
TlMKOWRlNDgzNCB2aXJ0aW8tc2NzaTogdXNlIHNjc2lfZGV2aWNlX2dldAo3ZGE4MmMzIHNjc2kv
c2NzaV9idXM6IEFkZCBzY3NpX2RldmljZV9nZXQKZWI0NjUzMyBzY3NpL3Njc2ktYnVzOiBzY3Np
X2RldmljZV9maW5kOiBkb24ndCByZXR1cm4gdW5yZWFsaXplZCBkZXZpY2VzCjhjMTEyNzMgZGV2
aWNlLWNvcmU6IHVzZSBhdG9taWNfc2V0IG9uIC5yZWFsaXplZCBwcm9wZXJ0eQo5MzlkY2JhIGRl
dmljZS1jb3JlOiB1c2UgUkNVIGZvciBsaXN0IG9mIGNoaWxkcmVuIG9mIGEgYnVzCjAwMDIzMzYg
ZGV2aWNlX2NvcmU6IHVzZSBkcmFpbl9jYWxsX3JjdSBpbiBpbiBobXBfZGV2aWNlX2RlbC9xbXBf
ZGV2aWNlX2FkZAplZmMzNWVmIHNjc2kvc2NzaV9idXM6IHN3aXRjaCBzZWFyY2ggZGlyZWN0aW9u
IGluIHNjc2lfZGV2aWNlX2ZpbmQKMGRlYjJiMCBzY3NpOiBzd2l0Y2ggdG8gYnVzLT5jaGVja19h
ZGRyZXNzCmY1N2UxMDIgcWRldjogYWRkICJjaGVjayBpZiBhZGRyZXNzIGZyZWUiIGNhbGxiYWNr
IGZvciBidXNlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMCBDaGVja2luZyBjb21taXQgZjU3
ZTEwMjA3ZjIxIChxZGV2OiBhZGQgImNoZWNrIGlmIGFkZHJlc3MgZnJlZSIgY2FsbGJhY2sgZm9y
IGJ1c2VzKQoyLzEwIENoZWNraW5nIGNvbW1pdCAwZGViMmIwZDg0NzggKHNjc2k6IHN3aXRjaCB0
byBidXMtPmNoZWNrX2FkZHJlc3MpCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNl
IHRhYnMKIzUzOiBGSUxFOiBody9zY3NpL3Njc2ktYnVzLmM6MTM3OgorXkleSV5JXkkgICAgIGlu
dCBjaGFubmVsLCBpbnQgdGFyZ2V0LCBpbnQgbHVuLCQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzU0OiBGSUxFOiBody9zY3NpL3Njc2ktYnVzLmM6MTM4OgorXkle
SV5JXkkgICAgIFNDU0lEZXZpY2UgKipwX2RldikkCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hh
cmFjdGVycwojNjk6IEZJTEU6IGh3L3Njc2kvc2NzaS1idXMuYzoxNTM6CitzdGF0aWMgYm9vbCBz
Y3NpX2J1c19jaGVja19hZGRyZXNzKEJ1c1N0YXRlICpxYnVzLCBEZXZpY2VTdGF0ZSAqcWRldiwg
RXJyb3IgKiplcnJwKQoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzg5OiBGSUxF
OiBody9zY3NpL3Njc2ktYnVzLmM6MTczOgorICAgICAgICBpZiAoIXNjc2lfYnVzX2lzX2FkZHJl
c3NfZnJlZShidXMsIGRldi0+Y2hhbm5lbCwgZGV2LT5pZCwgZGV2LT5sdW4sICZkKSkgewoKV0FS
TklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzEyODogRklMRTogaHcvc2NzaS9zY3NpLWJ1
cy5jOjE5NToKKyAgICAgICAgICAgIGlzX2ZyZWUgPSBzY3NpX2J1c19pc19hZGRyZXNzX2ZyZWUo
YnVzLCBkZXYtPmNoYW5uZWwsICsraWQsIGRldi0+bHVuLCBOVUxMKTsKCldBUk5JTkc6IGxpbmUg
b3ZlciA4MCBjaGFyYWN0ZXJzCiMxNDE6IEZJTEU6IGh3L3Njc2kvc2NzaS1idXMuYzoyMDU6Cisg
ICAgICAgICAgICBpc19mcmVlID0gc2NzaV9idXNfaXNfYWRkcmVzc19mcmVlKGJ1cywgZGV2LT5j
aGFubmVsLCBkZXYtPmlkLCArK2x1biwgTlVMTCk7Cgp0b3RhbDogMiBlcnJvcnMsIDQgd2Fybmlu
Z3MsIDE4MiBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzEwIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgozLzEwIENoZWNraW5nIGNvbW1pdCBlZmMzNWVmNWEyYWQgKHNjc2kvc2NzaV9idXM6IHN3
aXRjaCBzZWFyY2ggZGlyZWN0aW9uIGluIHNjc2lfZGV2aWNlX2ZpbmQpCjQvMTAgQ2hlY2tpbmcg
Y29tbWl0IDAwMDIzMzY5M2Q5NSAoZGV2aWNlX2NvcmU6IHVzZSBkcmFpbl9jYWxsX3JjdSBpbiBp
biBobXBfZGV2aWNlX2RlbC9xbXBfZGV2aWNlX2FkZCkKNS8xMCBDaGVja2luZyBjb21taXQgOTM5
ZGNiYWI3YTUwIChkZXZpY2UtY29yZTogdXNlIFJDVSBmb3IgbGlzdCBvZiBjaGlsZHJlbiBvZiBh
IGJ1cykKNi8xMCBDaGVja2luZyBjb21taXQgOGMxMTI3MzExODhhIChkZXZpY2UtY29yZTogdXNl
IGF0b21pY19zZXQgb24gLnJlYWxpemVkIHByb3BlcnR5KQo3LzEwIENoZWNraW5nIGNvbW1pdCBl
YjQ2NTMzYjJiNDkgKHNjc2kvc2NzaS1idXM6IHNjc2lfZGV2aWNlX2ZpbmQ6IGRvbid0IHJldHVy
biB1bnJlYWxpemVkIGRldmljZXMpCjgvMTAgQ2hlY2tpbmcgY29tbWl0IDdkYTgyYzNkMTYzZiAo
c2NzaS9zY3NpX2J1czogQWRkIHNjc2lfZGV2aWNlX2dldCkKOS8xMCBDaGVja2luZyBjb21taXQg
OWRlNDgzNGIyODcxICh2aXJ0aW8tc2NzaTogdXNlIHNjc2lfZGV2aWNlX2dldCkKMTAvMTAgQ2hl
Y2tpbmcgY29tbWl0IGMzZjBjOGYxOGYxMCAoc2NzaS9zY3NpX2J1czogZml4IHJhY2VzIGluIFJF
UE9SVCBMVU5TKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDkyNTE3MjYwNC4yMTQyMjI3LTEtcGJvbnppbmlAcmVkaGF0LmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

