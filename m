Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C5C49ED6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 04:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEE620693
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 04:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEE620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8zmz-0000ne-9B
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 00:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i8zmD-0000Hh-5B
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i8zmB-0005Oq-Dq
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:35:12 -0400
Resent-Date: Sat, 14 Sep 2019 00:35:12 -0400
Resent-Message-Id: <E1i8zmB-0005Oq-Dq@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i8zmB-0005E5-5e
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 00:35:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568429378; cv=none; d=zoho.com; s=zohoarc; 
 b=OCR8d45O5zuaVEu/R69m8agr6Hxdo4tKDizU3Cditrnux9/8YKHaecO8ODSFnZZD3VxVoDB4ZiBDETHS1I+CkWGvoSkRN4k9CpRIbJAwMAOIxTRO5zELn6ASaqWyNW8L/aVYYLcsXwSn8Y4rzn7SyBbNxawZedV9wtkdPFJ+Kq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568429378;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=D2awET0OCR4/t/8ySFsGLAkJjz2h4OdVW0bJnhDz0iw=; 
 b=E4BOOxjJ+jasCBVVXnZi759iYtbL/Jl3UK2zhKJNChbPG7B+yr1LLXr3vytvR6dxLvpQz5aGBYsRD//tM9YHzcl6MCvz0po+MHkFnK8K3tj8bXkVhZwSyKa4F/4Pc7VHxE4F4YmIiHdJlsDOYtqFP6uMd5IKBkSXfmE16bNkgGY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156842937672858.46839278150367;
 Fri, 13 Sep 2019 19:49:36 -0700 (PDT)
In-Reply-To: <20190913201349.24332-1-armbru@redhat.com>
Message-ID: <156842937572.31080.2162917881478968917@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Fri, 13 Sep 2019 19:49:36 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v3 00/16] qapi: Schema language cleanups &
 doc improvements
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMzIwMTM0OS4yNDMz
Mi0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzIDAwLzE2XSBxYXBpOiBT
Y2hlbWEgbGFuZ3VhZ2UgY2xlYW51cHMgJiBkb2MgaW1wcm92ZW1lbnRzCk1lc3NhZ2UtaWQ6IDIw
MTkwOTEzMjAxMzQ5LjI0MzMyLTEtYXJtYnJ1QHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
Cjk0OTE3ODcgcWFwaTogVHdlYWsgY29kZSB0byBtYXRjaCBkb2NzL2RldmVsL3FhcGktY29kZS1n
ZW4udHh0CjZmYjRhMjcgZG9jcy9kZXZlbC9xYXBpLWNvZGUtZ2VuOiBJbXByb3ZlIFFBUEkgc2No
ZW1hIGxhbmd1YWdlIGRvYwphNDc0NDk0IGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogUmV3cml0
ZSBpbnRyb2R1Y3Rpb24gdG8gc2NoZW1hCjY2NDAyNzIgZG9jcy9kZXZlbC9xYXBpLWNvZGUtZ2Vu
OiBSZXdyaXRlIGNvbXBhdGliaWxpdHkgY29uc2lkZXJhdGlvbnMKZDNjZWM3OCBkb2NzL2RldmVs
L3FhcGktY29kZS1nZW46IFJlb3JkZXIgc2VjdGlvbnMgZm9yIHJlYWRhYmlsaXR5CmI0OGFiYTMg
cWFwaTogQWRqdXN0IGZyb250ZW5kIGVycm9ycyB0byBzYXkgZW51bSB2YWx1ZSwgbm90IG1lbWJl
cgo3MGNlNjE5IHFhcGk6IFBlcm1pdCBvbWl0dGluZyBhbGwgZmxhdCB1bmlvbiBicmFuY2hlcwo0
ZWNkNjg4IHFhcGk6IFBlcm1pdCBhbHRlcm5hdGVzIHdpdGgganVzdCBvbmUgYnJhbmNoCjZmYjhm
OWUgcWFwaTogUGVybWl0ICdib3hlZCcgd2l0aCBlbXB0eSB0eXBlCmM1ZTkwOTcgcWFwaTogRHJv
cCBzdXBwb3J0IGZvciBlc2NhcGUgc2VxdWVuY2VzIG90aGVyIHRoYW4gXFwKMTEzODM2ZiBxYXBp
OiBSZXN0cmljdCBzdHJpbmdzIHRvIHByaW50YWJsZSBBU0NJSQpmZTc2MGYzIHRlc3RzL3FhcGkt
c2NoZW1hOiBEZW1vbnN0cmF0ZSBiYWQgcmVwb3J0aW5nIG9mIGZ1bm55IGNoYXJhY3RlcnMKNzc2
ZGY3YyBkb2NzL2RldmVsL3FhcGktY29kZS1nZW46IE1pbm9yIHNwZWNpZmljYXRpb24gZml4ZXMK
MTgxYTQzOCBxYXBpOiBEcm9wIHN1cHBvcnQgZm9yIGJveGVkIGFsdGVybmF0ZSBhcmd1bWVudHMK
NTdmOTc0MCBxYXBpOiBEcm9wIGNoZWNrX3R5cGUoKSdzIHJlZHVuZGFudCBwYXJhbWV0ZXIgQGFs
bG93X29wdGlvbmFsCjc5NzVjNWQgc2NyaXB0cy9naXQub3JkZXJmaWxlOiBNYXRjaCBRQVBJIHNj
aGVtYSBtb3JlIHByZWNpc2VseQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNiBDaGVja2luZyBj
b21taXQgNzk3NWM1ZDY5Y2NhIChzY3JpcHRzL2dpdC5vcmRlcmZpbGU6IE1hdGNoIFFBUEkgc2No
ZW1hIG1vcmUgcHJlY2lzZWx5KQoyLzE2IENoZWNraW5nIGNvbW1pdCA1N2Y5NzQwYjVkNmMgKHFh
cGk6IERyb3AgY2hlY2tfdHlwZSgpJ3MgcmVkdW5kYW50IHBhcmFtZXRlciBAYWxsb3dfb3B0aW9u
YWwpCjMvMTYgQ2hlY2tpbmcgY29tbWl0IDE4MWE0Mzg0ZThiOCAocWFwaTogRHJvcCBzdXBwb3J0
IGZvciBib3hlZCBhbHRlcm5hdGUgYXJndW1lbnRzKQo0LzE2IENoZWNraW5nIGNvbW1pdCA3NzZk
ZjdjZDQ1YzYgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogTWlub3Igc3BlY2lmaWNhdGlvbiBm
aXhlcykKNS8xNiBDaGVja2luZyBjb21taXQgZmU3NjBmMzk0NjFjICh0ZXN0cy9xYXBpLXNjaGVt
YTogRGVtb25zdHJhdGUgYmFkIHJlcG9ydGluZyBvZiBmdW5ueSBjaGFyYWN0ZXJzKQo2LzE2IENo
ZWNraW5nIGNvbW1pdCAxMTM4MzZmMzFkZDUgKHFhcGk6IFJlc3RyaWN0IHN0cmluZ3MgdG8gcHJp
bnRhYmxlIEFTQ0lJKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxMDk6IApuZXcgZmlsZSBtb2RlIDEwMDY0
NAoKRVJST1I6IEludmFsaWQgVVRGLTgsIHBhdGNoIGFuZCBjb21taXQgbWVzc2FnZSBzaG91bGQg
YmUgZW5jb2RlZCBpbiBVVEYtOAojMTI2OiBGSUxFOiB0ZXN0cy9xYXBpLXNjaGVtYS9zdHJpbmct
Y29kZS1wb2ludC0xMjcuanNvbjoyOgoreyAnY29tbWFuZCc6ICfijKYnIH0KICAgICAgICAgICAg
ICAgXgoKRVJST1I6IEludmFsaWQgVVRGLTgsIHBhdGNoIGFuZCBjb21taXQgbWVzc2FnZSBzaG91
bGQgYmUgZW5jb2RlZCBpbiBVVEYtOAojMTUyOiBGSUxFOiB0ZXN0cy9xYXBpLXNjaGVtYS9zdHJp
bmctY29kZS1wb2ludC0zMS5qc29uOjI6Cit7ICdjb21tYW5kJzogJ+KQnycgfQogICAgICAgICAg
ICAgICBeCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDc2IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDYvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjcvMTYgQ2hlY2tpbmcgY29tbWl0
IGM1ZTkwOTc1YzhjNSAocWFwaTogRHJvcCBzdXBwb3J0IGZvciBlc2NhcGUgc2VxdWVuY2VzIG90
aGVyIHRoYW4gXFwpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzc0OiAKZGVsZXRlZCBmaWxlIG1vZGUgMTAw
NjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUzIGxpbmVzIGNoZWNrZWQKClBhdGNo
IDcvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC8xNiBDaGVja2luZyBjb21taXQgNmZi
OGY5ZTdiYWE3IChxYXBpOiBQZXJtaXQgJ2JveGVkJyB3aXRoIGVtcHR5IHR5cGUpCldBUk5JTkc6
IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1
cGRhdGluZz8KIzEzMDogCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCAxMjkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xNiBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo5LzE2IENoZWNraW5nIGNvbW1pdCA0ZWNkNjg4Y2Q2YTEgKHFhcGk6IFBl
cm1pdCBhbHRlcm5hdGVzIHdpdGgganVzdCBvbmUgYnJhbmNoKQoxMC8xNiBDaGVja2luZyBjb21t
aXQgNzBjZTYxOWNmNmFmIChxYXBpOiBQZXJtaXQgb21pdHRpbmcgYWxsIGZsYXQgdW5pb24gYnJh
bmNoZXMpCjExLzE2IENoZWNraW5nIGNvbW1pdCBiNDhhYmEzYTMzOGMgKHFhcGk6IEFkanVzdCBm
cm9udGVuZCBlcnJvcnMgdG8gc2F5IGVudW0gdmFsdWUsIG5vdCBtZW1iZXIpCjEyLzE2IENoZWNr
aW5nIGNvbW1pdCBkM2NlYzc4Njk3MjIgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogUmVvcmRl
ciBzZWN0aW9ucyBmb3IgcmVhZGFiaWxpdHkpCjEzLzE2IENoZWNraW5nIGNvbW1pdCA2NjQwMjcy
OWQxMzkgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogUmV3cml0ZSBjb21wYXRpYmlsaXR5IGNv
bnNpZGVyYXRpb25zKQoxNC8xNiBDaGVja2luZyBjb21taXQgYTQ3NDQ5NGEwMTBiIChkb2NzL2Rl
dmVsL3FhcGktY29kZS1nZW46IFJld3JpdGUgaW50cm9kdWN0aW9uIHRvIHNjaGVtYSkKMTUvMTYg
Q2hlY2tpbmcgY29tbWl0IDZmYjRhMjczZTFmNiAoZG9jcy9kZXZlbC9xYXBpLWNvZGUtZ2VuOiBJ
bXByb3ZlIFFBUEkgc2NoZW1hIGxhbmd1YWdlIGRvYykKMTYvMTYgQ2hlY2tpbmcgY29tbWl0IDk0
OTE3ODdkMzY4OSAocWFwaTogVHdlYWsgY29kZSB0byBtYXRjaCBkb2NzL2RldmVsL3FhcGktY29k
ZS1nZW4udHh0KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MDkxMzIwMTM0OS4yNDMzMi0xLWFybWJydUByZWRoYXQuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


