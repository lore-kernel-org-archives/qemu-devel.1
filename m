Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4CC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 22:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB2C216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 22:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB2C216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ow7-0004J9-GF
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 18:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7ovA-0003aB-Lc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 18:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7ov8-000070-VL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 18:47:36 -0400
Resent-Date: Tue, 10 Sep 2019 18:47:36 -0400
Resent-Message-Id: <E1i7ov8-000070-VL@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7ov8-00005i-Nm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 18:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568154738; cv=none; d=zoho.com; s=zohoarc; 
 b=mkvmSZAoRWf66BeJDtbROleZebf32PeUtE6DcnLwTRpXxRoZHPRmk7nig+Ik3+pBma3bkpe0X+aJGr1azeD94v83jDhw0HEu6HEfhco2Yxop/ykxQPuzqTuoXnHQ+xKIqrdkqfs3AHXYDFrT02Wte6w4xaHO4f7P2LbB6X3DSUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568154738;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Sz943Uff+JMiEezd/gmNCBN5uiCwq+ZhZaLDf36Rfac=; 
 b=aLI28nNTaMaCyFWlDBPhpRtu7R/vdCpukfP72TBiVz3Dh2GFh+l5DVuVlcPm5jOrnA0UrLDBmTKCWZ2G9Qnz+9QG7HGLq3p/LfEOV1SHB2aPJFhJvW26VpTGhUzJjfFrX5sBaepwkbFzRXFqLH6XEfxIJL1rUGJZpoXMMaDx+Gk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568154736286786.8955354625843;
 Tue, 10 Sep 2019 15:32:16 -0700 (PDT)
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
Message-ID: <156815473524.15929.1966362255562245492@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 10 Sep 2019 15:32:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v2 00/16] qapi: Schema language cleanups &
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDA2MzcyNC4yODQ3
MC0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyIDAwLzE2XSBxYXBpOiBT
Y2hlbWEgbGFuZ3VhZ2UgY2xlYW51cHMgJiBkb2MgaW1wcm92ZW1lbnRzCk1lc3NhZ2UtaWQ6IDIw
MTkwOTEwMDYzNzI0LjI4NDcwLTEtYXJtYnJ1QHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwphMTY1M2Q1IHFhcGk6IFR3ZWFrIGNvZGUgdG8gbWF0Y2ggZG9jcy9kZXZlbC9xYXBp
LWNvZGUtZ2VuLnR4dAowOTlhYTBlIGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogSW1wcm92ZSBR
QVBJIHNjaGVtYSBsYW5ndWFnZSBkb2MKODMxY2VjYSBkb2NzL2RldmVsL3FhcGktY29kZS1nZW46
IFJld3JpdGUgaW50cm9kdWN0aW9uIHRvIHNjaGVtYQpiMmQyMTczIGRvY3MvZGV2ZWwvcWFwaS1j
b2RlLWdlbjogUmV3cml0ZSBjb21wYXRpYmlsaXR5IGNvbnNpZGVyYXRpb25zCmUzZmVlNWYgZG9j
cy9kZXZlbC9xYXBpLWNvZGUtZ2VuOiBSZW9yZGVyIHNlY3Rpb25zIGZvciByZWFkYWJpbGl0eQo1
YTMwMjZhIHFhcGk6IEFkanVzdCBmcm9udGVuZCBlcnJvcnMgdG8gc2F5IGVudW0gdmFsdWUsIG5v
dCBtZW1iZXIKZGEzZTVjZSBxYXBpOiBQZXJtaXQgb21pdHRpbmcgYWxsIGZsYXQgdW5pb24gYnJh
bmNoZXMKMjlhNzhkYyBxYXBpOiBQZXJtaXQgYWx0ZXJuYXRlcyB3aXRoIGp1c3Qgb25lIGJyYW5j
aAoxNjkwZjkwIHFhcGk6IFBlcm1pdCAnYm94ZWQnIHdpdGggZW1wdHkgdHlwZQo0ZGIxMDFiIHFh
cGk6IERyb3Agc3VwcG9ydCBmb3IgZXNjYXBlIHNlcXVlbmNlcyBvdGhlciB0aGFuIFxcCjIyNmEw
MjEgcWFwaTogUmVzdHJpY3Qgc3RyaW5ncyB0byBwcmludGFibGUgQVNDSUkKYjdiZjM1MSB0ZXN0
cy9xYXBpLXNjaGVtYTogRGVtb25zdHJhdGUgYmFkIHJlcG9ydGluZyBvZiBmdW5ueSBjaGFyYWN0
ZXJzCmU0YmJjNTQgZG9jcy9kZXZlbC9xYXBpLWNvZGUtZ2VuOiBNaW5vciBzcGVjaWZpY2F0aW9u
IGZpeGVzCmFmYmE4ODEgcWFwaTogRHJvcCBzdXBwb3J0IGZvciBib3hlZCBhbHRlcm5hdGUgYXJn
dW1lbnRzCjE5ODhmZmYgcWFwaTogRHJvcCBjaGVja190eXBlKCkncyByZWR1bmRhbnQgcGFyYW1l
dGVyIEBhbGxvd19vcHRpb25hbAoyZjRhMjEwIHNjcmlwdHMvZ2l0Lm9yZGVyZmlsZTogTWF0Y2gg
UUFQSSBzY2hlbWEgbW9yZSBwcmVjaXNlbHkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hl
Y2tpbmcgY29tbWl0IDJmNGEyMTA1YzVlMyAoc2NyaXB0cy9naXQub3JkZXJmaWxlOiBNYXRjaCBR
QVBJIHNjaGVtYSBtb3JlIHByZWNpc2VseSkKMi8xNiBDaGVja2luZyBjb21taXQgMTk4OGZmZjY5
M2ExIChxYXBpOiBEcm9wIGNoZWNrX3R5cGUoKSdzIHJlZHVuZGFudCBwYXJhbWV0ZXIgQGFsbG93
X29wdGlvbmFsKQozLzE2IENoZWNraW5nIGNvbW1pdCBhZmJhODgxYjc3ZDQgKHFhcGk6IERyb3Ag
c3VwcG9ydCBmb3IgYm94ZWQgYWx0ZXJuYXRlIGFyZ3VtZW50cykKNC8xNiBDaGVja2luZyBjb21t
aXQgZTRiYmM1NDc5ODEwIChkb2NzL2RldmVsL3FhcGktY29kZS1nZW46IE1pbm9yIHNwZWNpZmlj
YXRpb24gZml4ZXMpCjUvMTYgQ2hlY2tpbmcgY29tbWl0IGI3YmYzNTEyYzllYiAodGVzdHMvcWFw
aS1zY2hlbWE6IERlbW9uc3RyYXRlIGJhZCByZXBvcnRpbmcgb2YgZnVubnkgY2hhcmFjdGVycykK
Ni8xNiBDaGVja2luZyBjb21taXQgMjI2YTAyMWU0MzViIChxYXBpOiBSZXN0cmljdCBzdHJpbmdz
IHRvIHByaW50YWJsZSBBU0NJSSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmls
ZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojOTg6IApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAoKRVJST1I6IEludmFsaWQgVVRGLTgsIHBhdGNoIGFuZCBjb21taXQgbWVzc2FnZSBz
aG91bGQgYmUgZW5jb2RlZCBpbiBVVEYtOAojMTE1OiBGSUxFOiB0ZXN0cy9xYXBpLXNjaGVtYS9z
dHJpbmctY29kZS1wb2ludC0xMjcuanNvbjoyOgoreyAnY29tbWFuZCc6ICfijKYnIH0KICAgICAg
ICAgICAgICAgXgoKRVJST1I6IEludmFsaWQgVVRGLTgsIHBhdGNoIGFuZCBjb21taXQgbWVzc2Fn
ZSBzaG91bGQgYmUgZW5jb2RlZCBpbiBVVEYtOAojMTQxOiBGSUxFOiB0ZXN0cy9xYXBpLXNjaGVt
YS9zdHJpbmctY29kZS1wb2ludC0zMS5qc29uOjI6Cit7ICdjb21tYW5kJzogJ+KQnycgfQogICAg
ICAgICAgICAgICBeCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDY3IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDYvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjcvMTYgQ2hlY2tpbmcg
Y29tbWl0IDRkYjEwMWI2MGRjZSAocWFwaTogRHJvcCBzdXBwb3J0IGZvciBlc2NhcGUgc2VxdWVu
Y2VzIG90aGVyIHRoYW4gXFwpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUo
cyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzY5OiAKZGVsZXRlZCBmaWxlIG1v
ZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDQ5IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDcvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC8xNiBDaGVja2luZyBjb21t
aXQgMTY5MGY5MDhlOWM5IChxYXBpOiBQZXJtaXQgJ2JveGVkJyB3aXRoIGVtcHR5IHR5cGUpCldB
Uk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMg
bmVlZCB1cGRhdGluZz8KIzEyOTogCmRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAg
ZXJyb3JzLCAxIHdhcm5pbmdzLCAxMjkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xNiBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgo5LzE2IENoZWNraW5nIGNvbW1pdCAyOWE3OGRjMzU3NGYgKHFh
cGk6IFBlcm1pdCBhbHRlcm5hdGVzIHdpdGgganVzdCBvbmUgYnJhbmNoKQoxMC8xNiBDaGVja2lu
ZyBjb21taXQgZGEzZTVjZTg0NDVkIChxYXBpOiBQZXJtaXQgb21pdHRpbmcgYWxsIGZsYXQgdW5p
b24gYnJhbmNoZXMpCjExLzE2IENoZWNraW5nIGNvbW1pdCA1YTMwMjZhODliNmMgKHFhcGk6IEFk
anVzdCBmcm9udGVuZCBlcnJvcnMgdG8gc2F5IGVudW0gdmFsdWUsIG5vdCBtZW1iZXIpCjEyLzE2
IENoZWNraW5nIGNvbW1pdCBlM2ZlZTVmMmFlYmMgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjog
UmVvcmRlciBzZWN0aW9ucyBmb3IgcmVhZGFiaWxpdHkpCjEzLzE2IENoZWNraW5nIGNvbW1pdCBi
MmQyMTczZjY4MTIgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogUmV3cml0ZSBjb21wYXRpYmls
aXR5IGNvbnNpZGVyYXRpb25zKQoxNC8xNiBDaGVja2luZyBjb21taXQgODMxY2VjYWUyMmIxIChk
b2NzL2RldmVsL3FhcGktY29kZS1nZW46IFJld3JpdGUgaW50cm9kdWN0aW9uIHRvIHNjaGVtYSkK
MTUvMTYgQ2hlY2tpbmcgY29tbWl0IDA5OWFhMGUyNjQ5NiAoZG9jcy9kZXZlbC9xYXBpLWNvZGUt
Z2VuOiBJbXByb3ZlIFFBUEkgc2NoZW1hIGxhbmd1YWdlIGRvYykKMTYvMTYgQ2hlY2tpbmcgY29t
bWl0IGExNjUzZDVhNzM4OCAocWFwaTogVHdlYWsgY29kZSB0byBtYXRjaCBkb2NzL2RldmVsL3Fh
cGktY29kZS1nZW4udHh0KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDE5MDkxMDA2MzcyNC4yODQ3MC0xLWFybWJydUByZWRoYXQuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


