Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECFB207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 13:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECFB207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwK6-0008DH-Bt
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdwJZ-0007ni-KE
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:41:49 -0400
Resent-Date: Wed, 27 May 2020 09:41:49 -0400
Resent-Message-Id: <E1jdwJZ-0007ni-KE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdwJX-0006wo-Kf
 for qemu-devel@nongnu.org; Wed, 27 May 2020 09:41:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590586885; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kWQq5A3RNS9oAbW0E2fqo4uNuUDR+WiGj/zFgsae+wyM+/UQoCKCgDQVblnJI9kkDWO3I+eGPCLNHf21RzCG/SVOSWRiGagq7/xVKPDyUQE+gPMD5Ad41tsrn3HfT8tq+mtJ/bUJMXqbAh9CJua0dKLJelrEYMZV3w4GRocJwmg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590586885;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7pLJQooeO8RmaF61bBEnyduWippjbeDUtEUePOub8zs=; 
 b=OqwQIDVArGcYJ6chaOg0Ar4ILlo81xIG8iH1WAhr7jSpbzEPjMcwKCYl0MX1v1aZVTECORd1d81C6mMC7dKEhCHkto0zJ1veNWrrLdjiaGTIj8Jew3f+Jjj4JH6hqiIwUQB1BwI/Q1Z+q4A9nMe4KNHvgcQtj9gtoY0IbDAGFAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590586881896415.8310295949061;
 Wed, 27 May 2020 06:41:21 -0700 (PDT)
Message-ID: <159058688028.16318.18277405305142866353@45ef0f9c86ae>
In-Reply-To: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
Subject: Re: [PATCH v2 00/11] Record/replay acceptance tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Pavel.Dovgaluk@gmail.com
Date: Wed, 27 May 2020 06:41:21 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 09:41:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, crosa@redhat.com,
 pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTkwNTc1NDM4NDAuMTY4MTgu
MTQzOTM0MzM5OTY4OTk1MjE3ODQuc3RnaXRAcGFzaGEtVGhpbmtQYWQtWDI4MC8KCgoKSGksCgpU
aGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUg
b3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTU5MDU3NTQz
ODQwLjE2ODE4LjE0MzkzNDMzOTk2ODk5NTIxNzg0LnN0Z2l0QHBhc2hhLVRoaW5rUGFkLVgyODAK
U3ViamVjdDogW1BBVENIIHYyIDAwLzExXSBSZWNvcmQvcmVwbGF5IGFjY2VwdGFuY2UgdGVzdHMK
VHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8v
Z2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRj
aGV3L2NvdmVyLjE1OTA0Mjk5MDEuZ2l0LmJlcnRvQGlnYWxpYS5jb20gLT4gcGF0Y2hldy9jb3Zl
ci4xNTkwNDI5OTAxLmdpdC5iZXJ0b0BpZ2FsaWEuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKY2VlZDUzYyB0ZXN0cy9hY2NlcHRhbmNlOiBMaW51eCBib290IHRlc3QgZm9yIHJl
Y29yZC9yZXBsYXkKMTRiZjRiYyB0ZXN0cy9hY2NlcHRhbmNlOiByZWZhY3RvciBib290X2xpbnV4
IHRvIGFsbG93IGNvZGUgcmV1c2UKZTE5MmZiMCB0ZXN0cy9hY2NlcHRhbmNlOiByZWNvcmQvcmVw
bGF5IHRlc3RzIHdpdGggYWR2Y2FsIGltYWdlcwowZDQ4YWFjIHRlc3RzL2FjY2VwdGFuY2U6IGFk
ZCByZWNvcmQvcmVwbGF5IHRlc3QgZm9yIG02OGsKMTY2MDM5NSB0ZXN0cy9hY2NlcHRhbmNlOiBh
ZGQgcmVjb3JkL3JlcGxheSB0ZXN0IGZvciBwcGM2NAo4ODFlMWNmIHRlc3RzL2FjY2VwdGFuY2U6
IGFkZCByZWNvcmQvcmVwbGF5IHRlc3QgZm9yIGFybQo5MWMzYzFmIHRlc3RzL2FjY2VwdGFuY2U6
IGFkZCByZWNvcmQvcmVwbGF5IHRlc3QgZm9yIGFhcmNoNjQKMmEyMzZhMCB0ZXN0cy9hY2NlcHRh
bmNlOiBhZGQga2VybmVsIHJlY29yZC9yZXBsYXkgdGVzdCBmb3IgeDg2XzY0CmJkNjhiNzggdGVz
dHMvYWNjZXB0YW5jZTogYWRkIGJhc2UgY2xhc3MgcmVjb3JkL3JlcGxheSBrZXJuZWwgdGVzdHMK
NjlhMThiOSB0ZXN0cy9hY2NlcHRhbmNlOiByZWZhY3RvciBib290X2xpbnV4X2NvbnNvbGUgdGVz
dCB0byBhbGxvdyBjb2RlIHJldXNlCmY3ZGI0OWUgdGVzdHMvYWNjZXB0YW5jZTogYWxsb3cgY29u
c29sZSBpbnRlcmFjdGlvbiB3aXRoIHNwZWNpZmljIFZNcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
MS8xMSBDaGVja2luZyBjb21taXQgZjdkYjQ5ZWY0MDNiICh0ZXN0cy9hY2NlcHRhbmNlOiBhbGxv
dyBjb25zb2xlIGludGVyYWN0aW9uIHdpdGggc3BlY2lmaWMgVk1zKQoyLzExIENoZWNraW5nIGNv
bW1pdCA2OWExOGI5MjQyNmYgKHRlc3RzL2FjY2VwdGFuY2U6IHJlZmFjdG9yIGJvb3RfbGludXhf
Y29uc29sZSB0ZXN0IHRvIGFsbG93IGNvZGUgcmV1c2UpCjMvMTEgQ2hlY2tpbmcgY29tbWl0IGJk
NjhiNzg5MGFlNCAodGVzdHMvYWNjZXB0YW5jZTogYWRkIGJhc2UgY2xhc3MgcmVjb3JkL3JlcGxh
eSBrZXJuZWwgdGVzdHMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyks
IGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM4OiAKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNjQgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
My8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo0LzExIENoZWNraW5nIGNvbW1pdCAyYTIz
NmEwMTFhMWIgKHRlc3RzL2FjY2VwdGFuY2U6IGFkZCBrZXJuZWwgcmVjb3JkL3JlcGxheSB0ZXN0
IGZvciB4ODZfNjQpCjUvMTEgQ2hlY2tpbmcgY29tbWl0IDkxYzNjMWYzODk2OCAodGVzdHMvYWNj
ZXB0YW5jZTogYWRkIHJlY29yZC9yZXBsYXkgdGVzdCBmb3IgYWFyY2g2NCkKNi8xMSBDaGVja2lu
ZyBjb21taXQgODgxZTFjZmQ1MWU5ICh0ZXN0cy9hY2NlcHRhbmNlOiBhZGQgcmVjb3JkL3JlcGxh
eSB0ZXN0IGZvciBhcm0pCjcvMTEgQ2hlY2tpbmcgY29tbWl0IDE2NjAzOTViNTY0NSAodGVzdHMv
YWNjZXB0YW5jZTogYWRkIHJlY29yZC9yZXBsYXkgdGVzdCBmb3IgcHBjNjQpCjgvMTEgQ2hlY2tp
bmcgY29tbWl0IDBkNDhhYWMwZGJmYSAodGVzdHMvYWNjZXB0YW5jZTogYWRkIHJlY29yZC9yZXBs
YXkgdGVzdCBmb3IgbTY4aykKOS8xMSBDaGVja2luZyBjb21taXQgZTE5MmZiMDZhYmM4ICh0ZXN0
cy9hY2NlcHRhbmNlOiByZWNvcmQvcmVwbGF5IHRlc3RzIHdpdGggYWR2Y2FsIGltYWdlcykKMTAv
MTEgQ2hlY2tpbmcgY29tbWl0IDE0YmY0YmM2NTY1NiAodGVzdHMvYWNjZXB0YW5jZTogcmVmYWN0
b3IgYm9vdF9saW51eCB0byBhbGxvdyBjb2RlIHJldXNlKQoxMS8xMSBDaGVja2luZyBjb21taXQg
Y2VlZDUzYzBiYzhkICh0ZXN0cy9hY2NlcHRhbmNlOiBMaW51eCBib290IHRlc3QgZm9yIHJlY29y
ZC9yZXBsYXkpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMg
TUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM4OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVS
Uk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojODM6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2Uv
cmVwbGF5X2xpbnV4LnB5OjQxOgorICAgICAgICB2bS5hZGRfYXJncygnLWRyaXZlJywgJ2RyaXZl
cj1ibGtyZXBsYXksaWQ9ZGlzayVzLXJyLGlmPW5vbmUsaW1hZ2U9ZGlzayVzJyAlIChpZCwgaWQp
KQoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzg0OiBGSUxFOiB0ZXN0cy9hY2Nl
cHRhbmNlL3JlcGxheV9saW51eC5weTo0MjoKKyAgICAgICAgdm0uYWRkX2FyZ3MoJy1kZXZpY2Un
LCAnJXMsZHJpdmU9ZGlzayVzLXJyJXMnICUgKGRldmljZSwgaWQsIGJ1c19zdHJpbmcpKQoKV0FS
TklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzEwNTogRklMRTogdGVzdHMvYWNjZXB0YW5j
ZS9yZXBsYXlfbGludXgucHk6NjM6CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbG9nZ2VyPXNlbGYubG9nLmdldENoaWxkKCdjb25zb2xlJyksCgpFUlJP
UjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzEwNjogRklMRTogdGVzdHMvYWNjZXB0YW5jZS9y
ZXBsYXlfbGludXgucHk6NjQ6CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RvcF9jaGVjaz0obGFtYmRhIDogbm90IHZtLmlzX3J1bm5pbmcoKSkpCgpX
QVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTA5OiBGSUxFOiB0ZXN0cy9hY2NlcHRh
bmNlL3JlcGxheV9saW51eC5weTo2NzoKKyAgICAgICAgICAgIHNlbGYubG9nLmluZm8oJ1ZNIGxh
dW5jaGVkLCB3YWl0aW5nIGZvciBib290IGNvbmZpcm1hdGlvbiBmcm9tIGd1ZXN0JykKCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMTA6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2Uv
cmVwbGF5X2xpbnV4LnB5OjY4OgorICAgICAgICAgICAgY2xvdWRpbml0LndhaXRfZm9yX3Bob25l
X2hvbWUoKCcwLjAuMC4wJywgc2VsZi5waG9uZV9ob21lX3BvcnQpLCBzZWxmLm5hbWUpCgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTEzOiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNl
L3JlcGxheV9saW51eC5weTo3MToKKyAgICAgICAgICAgIHNlbGYubG9nLmluZm8oJ1ZNIGxhdW5j
aGVkLCB3YWl0aW5nIHRoZSByZWNvcmRlZCBleGVjdXRpb24gdG8gYmUgcmVwbGF5ZWQnKQoKdG90
YWw6IDIgZXJyb3JzLCA2IHdhcm5pbmdzLCAxMDQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTEvMTEg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1OTA1NzU0Mzg0MC4xNjgxOC4xNDM5MzQzMzk5Njg5OTUy
MTc4NC5zdGdpdEBwYXNoYS1UaGlua1BhZC1YMjgwL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

