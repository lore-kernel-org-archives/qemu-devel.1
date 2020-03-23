Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB7C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343662073C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343662073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGSwB-0005n6-8M
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGSvY-0005EX-Gj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGSvW-0001Af-Ep
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:40:00 -0400
Resent-Date: Mon, 23 Mar 2020 15:40:00 -0400
Resent-Message-Id: <E1jGSvW-0001Af-Ep@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGSvW-0001A5-78; Mon, 23 Mar 2020 15:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584992388; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Smk4mDWKaKyDKqXZQOR0vaxYZ8gdZxS0o/0GBAFipSreGA9nYGImmY6jPIgoxvLUjqReYgyTAIuOdTcCpUv/H0n/UtZ7xygoFdd4MmrMGFnMU5jgbNo4dcZs2cdfI6iEh9OWfYIBcwVdSO972YKI3IIhGvfYF27lC2W74IpxGuM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584992388;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1b/ZWqEbKQh1wWyq2RdBFWNssRbgtdKRcnNim3lZeq8=; 
 b=Fk2sSrOVLJjv/dmeAx/SNiaQbrpZe7B+UVUCZmie9X3sGYmapGcABBl3pv2NiErZ5OluHRQfo4ltxJbkRcHtiNsjEYQ/KZ8NFbFENrEB5067nijm+vmJTySPrIEThIEYPFkLw/YZFHvRuvjdI73qCiz4UGSE3tmEtW7S0d1Dp78=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158499238385560.67236955972862;
 Mon, 23 Mar 2020 12:39:43 -0700 (PDT)
In-Reply-To: <20200319131921.2367-1-frankja@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] s390x: Protected Virtualization support
Message-ID: <158499238242.8863.16290762018805329885@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Mon, 23 Mar 2020 12:39:43 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxOTEzMTkyMS4yMzY3
LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjExIDAwLzE2XSBzMzkweDogUHJvdGVjdGVk
IFZpcnR1YWxpemF0aW9uIHN1cHBvcnQKTWVzc2FnZS1pZDogMjAyMDAzMTkxMzE5MjEuMjM2Ny0x
LWZyYW5ramFAbGludXguaWJtLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMzQ5NmNkMCBzMzkweDog
QWRkIHVucGFjayBmYWNpbGl0eSBmZWF0dXJlIHRvIEdBMQowM2Q0MGMxIGRvY3M6IHN5c3RlbTog
QWRkIHByb3R2aXJ0IGRvY3MKNGY3NGUyYSBzMzkweDogcHJvdHZpcnQ6IEhhbmRsZSBTSUdQIHN0
b3JlIHN0YXR1cyBjb3JyZWN0bHkKMjQzZTY4MSBzMzkweDogcHJvdHZpcnQ6IE1vdmUgSU8gY29u
dHJvbCBzdHJ1Y3R1cmVzIG92ZXIgU0lEQQowNWFhMmEyIHMzOTB4OiBwcm90dmlydDogRGlzYWJs
ZSBhZGRyZXNzIGNoZWNrcyBmb3IgUFYgZ3Vlc3QgSU8gZW11bGF0aW9uCjk0MzAwNTkgczM5MHg6
IHByb3R2aXJ0OiBNb3ZlIGRpYWcgMzA4IGRhdGEgb3ZlciBTSURBCmNhN2UxNTAgczM5MHg6IHBy
b3R2aXJ0OiBTZXQgZ3Vlc3QgSVBMIFBTVwo3MjE0ZWNkIHMzOTB4OiBwcm90dmlydDogU0NMUCBp
bnRlcnByZXRhdGlvbgo2MDg0ZmEwIHMzOTB4OiBwcm90dmlydDogTW92ZSBTVFNJIGRhdGEgb3Zl
ciBTSURBRAoxMmEyODQ4IHMzOTB4OiBBZGQgU0lEQSBtZW1vcnkgb3BzCmYwNTFjNWEgczM5MHg6
IHByb3R2aXJ0OiBLVk0gaW50ZXJjZXB0IGNoYW5nZXMKNGExMzE5MSBzMzkweDogcHJvdHZpcnQ6
IEluaGliaXQgYmFsbG9vbiB3aGVuIHN3aXRjaGluZyB0byBwcm90ZWN0ZWQgbW9kZQpkMWFmYTM5
IHMzOTB4OiBwcm90dmlydDogQWRkIG1pZ3JhdGlvbiBibG9ja2VyCjJiNzlmMGUgczM5MHg6IHBy
b3R2aXJ0OiBTdXBwb3J0IHVucGFjayBmYWNpbGl0eQpjZGRjMTU1IFN5bmMgcHYKNDgxYzY0ZiBz
MzkweDogTW92ZSBkaWFnbm9zZSAzMDggc3ViY29kZXMgYW5kIHJjcyBpbnRvIGlwbC5oCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzE2IENoZWNraW5nIGNvbW1pdCA0ODFjNjRmMjUxYTAgKHMzOTB4
OiBNb3ZlIGRpYWdub3NlIDMwOCBzdWJjb2RlcyBhbmQgcmNzIGludG8gaXBsLmgpCjIvMTYgQ2hl
Y2tpbmcgY29tbWl0IGNkZGMxNTU3NWIwOSAoU3luYyBwdikKMy8xNiBDaGVja2luZyBjb21taXQg
MmI3OWYwZTQ0ZGM3IChzMzkweDogcHJvdHZpcnQ6IFN1cHBvcnQgdW5wYWNrIGZhY2lsaXR5KQpX
QVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJT
IG5lZWQgdXBkYXRpbmc/CiMzMjY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzY2NDogRklMRTogaW5jbHVkZS9ody9zMzkweC9wdi5oOjQ4
Ogorc3RhdGljIGlubGluZSBpbnQgczM5MF9wdl9zZXRfc2VjX3Bhcm1zKHVpbnQ2NF90IG9yaWdp
biwgdWludDY0X3QgbGVuZ3RoKSB7IHJldHVybiAwOyB9CgpFUlJPUjogbGluZSBvdmVyIDkwIGNo
YXJhY3RlcnMKIzY2NTogRklMRTogaW5jbHVkZS9ody9zMzkweC9wdi5oOjQ5Ogorc3RhdGljIGlu
bGluZSBpbnQgczM5MF9wdl91bnBhY2sodWludDY0X3QgYWRkciwgdWludDY0X3Qgc2l6ZSwgdWlu
dDY0X3QgdHdlYWspIHsgcmV0dXJuIDA7IH0KCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiM3NjU6IEZJTEU6IHRhcmdldC9zMzkweC9kaWFnLmM6MTIyOgorICAgICAgICB2YWxpZCA9
IHN1YmNvZGUgPT0gRElBRzMwOF9QVl9TRVQgPyBpcGxiX3ZhbGlkX3B2KGlwbGIpIDogaXBsYl92
YWxpZChpcGxiKTsKCnRvdGFsOiAxIGVycm9ycywgMyB3YXJuaW5ncywgNzMxIGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDMvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvMTYgQ2hlY2tpbmcg
Y29tbWl0IGQxYWZhMzllYmY1MyAoczM5MHg6IHByb3R2aXJ0OiBBZGQgbWlncmF0aW9uIGJsb2Nr
ZXIpCjUvMTYgQ2hlY2tpbmcgY29tbWl0IDRhMTMxOTFiMTU1MSAoczM5MHg6IHByb3R2aXJ0OiBJ
bmhpYml0IGJhbGxvb24gd2hlbiBzd2l0Y2hpbmcgdG8gcHJvdGVjdGVkIG1vZGUpCjYvMTYgQ2hl
Y2tpbmcgY29tbWl0IGYwNTFjNWE2MTE4ZiAoczM5MHg6IHByb3R2aXJ0OiBLVk0gaW50ZXJjZXB0
IGNoYW5nZXMpCkVSUk9SOiBzd2l0Y2ggYW5kIGNhc2Ugc2hvdWxkIGJlIGF0IHRoZSBzYW1lIGlu
ZGVudAojNTA6IEZJTEU6IHRhcmdldC9zMzkweC9rdm0uYzoxNzAxOgogICAgIHN3aXRjaCAoaWNw
dF9jb2RlKSB7ClsuLi5dCisgICAgICAgIGNhc2UgSUNQVF9QVl9JTlNUUjoKKyAgICAgICAgY2Fz
ZSBJQ1BUX1BWX0lOU1RSX05PVElGSUNBVElPTjoKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgMTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi8xNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKNy8xNiBDaGVja2luZyBjb21taXQgMTJhMjg0ODI3MDY2IChzMzkweDogQWRkIFNJREEgbWVt
b3J5IG9wcykKOC8xNiBDaGVja2luZyBjb21taXQgNjA4NGZhMDgxNDU0IChzMzkweDogcHJvdHZp
cnQ6IE1vdmUgU1RTSSBkYXRhIG92ZXIgU0lEQUQpCjkvMTYgQ2hlY2tpbmcgY29tbWl0IDcyMTRl
Y2RlMjYyMyAoczM5MHg6IHByb3R2aXJ0OiBTQ0xQIGludGVycHJldGF0aW9uKQoxMC8xNiBDaGVj
a2luZyBjb21taXQgY2E3ZTE1MDMxM2M5IChzMzkweDogcHJvdHZpcnQ6IFNldCBndWVzdCBJUEwg
UFNXKQoxMS8xNiBDaGVja2luZyBjb21taXQgOTQzMDA1OTdiY2Y5IChzMzkweDogcHJvdHZpcnQ6
IE1vdmUgZGlhZyAzMDggZGF0YSBvdmVyIFNJREEpCjEyLzE2IENoZWNraW5nIGNvbW1pdCAwNWFh
MmEyYzc0Y2EgKHMzOTB4OiBwcm90dmlydDogRGlzYWJsZSBhZGRyZXNzIGNoZWNrcyBmb3IgUFYg
Z3Vlc3QgSU8gZW11bGF0aW9uKQoxMy8xNiBDaGVja2luZyBjb21taXQgMjQzZTY4MWNkYTcxIChz
MzkweDogcHJvdHZpcnQ6IE1vdmUgSU8gY29udHJvbCBzdHJ1Y3R1cmVzIG92ZXIgU0lEQSkKMTQv
MTYgQ2hlY2tpbmcgY29tbWl0IDRmNzRlMmFmZGI2MCAoczM5MHg6IHByb3R2aXJ0OiBIYW5kbGUg
U0lHUCBzdG9yZSBzdGF0dXMgY29ycmVjdGx5KQoxNS8xNiBDaGVja2luZyBjb21taXQgMDNkNDBj
MTg4NWZjIChkb2NzOiBzeXN0ZW06IEFkZCBwcm90dmlydCBkb2NzKQpXQVJOSU5HOiBhZGRlZCwg
bW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/
CiMxNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3Ms
IDY4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDE1LzE2IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
CjE2LzE2IENoZWNraW5nIGNvbW1pdCAzNDk2Y2QwNWFiOGEgKHMzOTB4OiBBZGQgdW5wYWNrIGZh
Y2lsaXR5IGZlYXR1cmUgdG8gR0ExKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMxOTEzMTkyMS4yMzY3LTEtZnJhbmtqYUBsaW51eC5pYm0u
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

