Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5694C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA84206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA84206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgvLI-0007hi-Ru
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 15:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgvKh-00075z-DG; Thu, 04 Jun 2020 15:15:19 -0400
Resent-Date: Thu, 04 Jun 2020 15:15:19 -0400
Resent-Message-Id: <E1jgvKh-00075z-DG@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgvKf-0008K4-MM; Thu, 04 Jun 2020 15:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591298099; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ONBaQabV8LC943gydGvp5srln8S41j/TymytrxsCOXPc6TgxE4pPnrF/bC5e2mf7iXvpohB8cRr9ba/Gjo+hL87+mclUUtqYA4SMmwmHxi2/JQ7s0UES8FmPz7Jc3njFhYYkWEHA/It9BuCtJBVPpxFhxUfDUajwZsUa110Kly0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591298099;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HdbDKBDrrQY3lCKSlgoZblygKmav4LDp/g6bPmZEIF0=; 
 b=Lwu5FF+PFUI6ieSjH5RR4w8A8e4tMDR1leQRmXVTvfgl0jnawyDd1VNfVsI9vjzs0B88rW2m0Bla8W+INTaYp9BkR0rYM8uY7K8+rA1nNDPhiBPKH1kw/rrh7EpVzbsaTJNTb5a3m1rN/IRqf29BHshbS2/RIE1wtyeTBOAwtRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591298096482378.06810511120545;
 Thu, 4 Jun 2020 12:14:56 -0700 (PDT)
Message-ID: <159129809507.14650.2042831377861611531@45ef0f9c86ae>
In-Reply-To: <20200604174135.11042-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 00/12] iotests: Dump QCOW2 dirty bitmaps metadata
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Thu, 4 Jun 2020 12:14:56 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 15:15:15
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNDE3NDEzNS4xMTA0
Mi0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDQxNzQxMzUuMTEwNDItMS12c2Vt
ZW50c292QHZpcnR1b3p6by5jb20KU3ViamVjdDogW1BBVENIIHY0IDAwLzEyXSBpb3Rlc3RzOiBE
dW1wIFFDT1cyIGRpcnR5IGJpdG1hcHMgbWV0YWRhdGEKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVs
bCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwpmZjNkMGUwIHFjb3cyX2Zvcm1hdC5weTogZHVtcCBiaXRtYXBzIGhlYWRlciBleHRlbnNpb24K
MWNhNGI0YiBxY293MjogUWNvd0hlYWRlckV4dGVuc2lvbiBwcmludCBuYW1lcyBmb3IgZXh0ZW5z
aW9uIG1hZ2ljcwo0ODk0Zjg1IHFjb3cyX2Zvcm1hdDogcmVmYWN0b3IgUWNvd0hlYWRlckV4dGVu
c2lvbiBhcyBhIHN1YmNsYXNzIG9mIFFjb3cyU3RydWN0CjVkMmQzZWEgcWNvdzJfZm9ybWF0LnB5
OiBRY293SGVhZGVyRXh0ZW5zaW9uOiBhZGQgZHVtcCBtZXRob2QKNzg0OGY1MiBxY293Ml9mb3Jt
YXQucHk6IGFkZCBmaWVsZC1mb3JtYXR0aW5nIGNsYXNzCjRmMDQ3M2YgcWNvdzJfZm9ybWF0LnB5
OiBzZXBhcmF0ZSBnZW5lcmljIGZ1bmN0aW9uYWxpdHkgb2Ygc3RydWN0dXJlIGNsYXNzZXMKNzg5
NjRkMiBxY293Ml9mb3JtYXQucHk6IHVzZSBzdHJpbmdzIHRvIHNwZWNpZnkgYy10eXBlIG9mIHN0
cnVjdCBmaWVsZHMKNDkyYjc1MyBxY293Ml9mb3JtYXQucHk6IHVzZSBtb2Rlcm4gc3RyaW5nIGZv
cm1hdHRpbmcKN2ZlZjczNyBxY293Ml9mb3JtYXQucHk6IHVzZSB0dXBsZXMgaW5zdGVhZCBvZiBs
aXN0cyBmb3IgZmllbGRzCjhmYWU0YWIgcWNvdzJfZm9ybWF0LnB5OiBkcm9wIG5ldyBsaW5lIHBy
aW50aW5nIGF0IGVuZCBvZiBkdW1wKCkKYzBiNGU0YiBxY293Mi5weTogbW92ZSBxY293MiBmb3Jt
YXQgY2xhc3NlcyB0byBzZXBhcmF0ZSBtb2R1bGUKMzI2NjhiYSBxY293Mi5weTogcHl0aG9uIHN0
eWxlIGZpeGVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEyIENoZWNraW5nIGNvbW1pdCAzMjY2
OGJhOTRjZjEgKHFjb3cyLnB5OiBweXRob24gc3R5bGUgZml4ZXMpCkVSUk9SOiBsaW5lIG92ZXIg
OTAgY2hhcmFjdGVycwojMjE5OiBGSUxFOiB0ZXN0cy9xZW11LWlvdGVzdHMvcWNvdzIucHk6MjU2
OgorICAgIFsnZHVtcC1oZWFkZXInLCAgICAgICAgICBjbWRfZHVtcF9oZWFkZXIsICAgICAgICAg
IDAsICdEdW1wIGltYWdlIGhlYWRlciBhbmQgaGVhZGVyIGV4dGVuc2lvbnMnXSwKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMjA6IEZJTEU6IHRlc3RzL3FlbXUtaW90ZXN0cy9x
Y293Mi5weToyNTc6CisgICAgWydkdW1wLWhlYWRlci1leHRzJywgICAgIGNtZF9kdW1wX2hlYWRl
cl9leHRzLCAgICAgMCwgJ0R1bXAgaW1hZ2UgaGVhZGVyIGV4dGVuc2lvbnMnXSwKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMjE6IEZJTEU6IHRlc3RzL3FlbXUtaW90ZXN0cy9x
Y293Mi5weToyNTg6CisgICAgWydzZXQtaGVhZGVyJywgICAgICAgICAgIGNtZF9zZXRfaGVhZGVy
LCAgICAgICAgICAgMiwgJ1NldCBhIGZpZWxkIGluIHRoZSBoZWFkZXInXSwKCldBUk5JTkc6IGxp
bmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMjI6IEZJTEU6IHRlc3RzL3FlbXUtaW90ZXN0cy9xY293
Mi5weToyNTk6CisgICAgWydhZGQtaGVhZGVyLWV4dCcsICAgICAgIGNtZF9hZGRfaGVhZGVyX2V4
dCwgICAgICAgMiwgJ0FkZCBhIGhlYWRlciBleHRlbnNpb24nXSwKCkVSUk9SOiBsaW5lIG92ZXIg
OTAgY2hhcmFjdGVycwojMjIzOiBGSUxFOiB0ZXN0cy9xZW11LWlvdGVzdHMvcWNvdzIucHk6MjYw
OgorICAgIFsnYWRkLWhlYWRlci1leHQtc3RkaW8nLCBjbWRfYWRkX2hlYWRlcl9leHRfc3RkaW8s
IDEsICdBZGQgYSBoZWFkZXIgZXh0ZW5zaW9uLCBkYXRhIGZyb20gc3RkaW4nXSwKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMjQ6IEZJTEU6IHRlc3RzL3FlbXUtaW90ZXN0cy9x
Y293Mi5weToyNjE6CisgICAgWydkZWwtaGVhZGVyLWV4dCcsICAgICAgIGNtZF9kZWxfaGVhZGVy
X2V4dCwgICAgICAgMSwgJ0RlbGV0ZSBhIGhlYWRlciBleHRlbnNpb24nXSwKCnRvdGFsOiAyIGVy
cm9ycywgNCB3YXJuaW5ncywgMjE3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMTIgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCjIvMTIgQ2hlY2tpbmcgY29tbWl0IGMwYjRlNGJjYzY5MiAocWNv
dzIucHk6IG1vdmUgcWNvdzIgZm9ybWF0IGNsYXNzZXMgdG8gc2VwYXJhdGUgbW9kdWxlKQpXQVJO
SU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5l
ZWQgdXBkYXRpbmc/CiMxODY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCAzMjQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xMiBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgozLzEyIENoZWNraW5nIGNvbW1pdCA4ZmFlNGFiNmIwNTggKHFjb3cyX2Zv
cm1hdC5weTogZHJvcCBuZXcgbGluZSBwcmludGluZyBhdCBlbmQgb2YgZHVtcCgpKQo0LzEyIENo
ZWNraW5nIGNvbW1pdCA3ZmVmNzM3NjFlNjMgKHFjb3cyX2Zvcm1hdC5weTogdXNlIHR1cGxlcyBp
bnN0ZWFkIG9mIGxpc3RzIGZvciBmaWVsZHMpCjUvMTIgQ2hlY2tpbmcgY29tbWl0IDQ5MmI3NTNk
MzEwZSAocWNvdzJfZm9ybWF0LnB5OiB1c2UgbW9kZXJuIHN0cmluZyBmb3JtYXR0aW5nKQo2LzEy
IENoZWNraW5nIGNvbW1pdCA3ODk2NGQyMDZjYWIgKHFjb3cyX2Zvcm1hdC5weTogdXNlIHN0cmlu
Z3MgdG8gc3BlY2lmeSBjLXR5cGUgb2Ygc3RydWN0IGZpZWxkcykKNy8xMiBDaGVja2luZyBjb21t
aXQgNGYwNDczZjNjZjdmIChxY293Ml9mb3JtYXQucHk6IHNlcGFyYXRlIGdlbmVyaWMgZnVuY3Rp
b25hbGl0eSBvZiBzdHJ1Y3R1cmUgY2xhc3NlcykKOC8xMiBDaGVja2luZyBjb21taXQgNzg0OGY1
MjgzODYzIChxY293Ml9mb3JtYXQucHk6IGFkZCBmaWVsZC1mb3JtYXR0aW5nIGNsYXNzKQo5LzEy
IENoZWNraW5nIGNvbW1pdCA1ZDJkM2VhNDRkOTMgKHFjb3cyX2Zvcm1hdC5weTogUWNvd0hlYWRl
ckV4dGVuc2lvbjogYWRkIGR1bXAgbWV0aG9kKQoxMC8xMiBDaGVja2luZyBjb21taXQgNDg5NGY4
NTllNjNkIChxY293Ml9mb3JtYXQ6IHJlZmFjdG9yIFFjb3dIZWFkZXJFeHRlbnNpb24gYXMgYSBz
dWJjbGFzcyBvZiBRY293MlN0cnVjdCkKMTEvMTIgQ2hlY2tpbmcgY29tbWl0IDFjYTRiNGI3OTVk
OCAocWNvdzI6IFFjb3dIZWFkZXJFeHRlbnNpb24gcHJpbnQgbmFtZXMgZm9yIGV4dGVuc2lvbiBt
YWdpY3MpCjEyLzEyIENoZWNraW5nIGNvbW1pdCBmZjNkMGUwZjQ3MWEgKHFjb3cyX2Zvcm1hdC5w
eTogZHVtcCBiaXRtYXBzIGhlYWRlciBleHRlbnNpb24pCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjA0MTc0MTM1LjExMDQyLTEtdnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

