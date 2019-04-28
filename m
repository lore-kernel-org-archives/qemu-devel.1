Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6636C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 16:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A7D20656
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 16:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A7D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKmbc-0005Hh-95
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 12:24:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKma1-0003sx-Tw
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKmNx-0004LI-DT
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 12:10:39 -0400
Resent-Date: Sun, 28 Apr 2019 12:10:38 -0400
Resent-Message-Id: <E1hKmNx-0004LI-DT@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hKmNx-0004Kv-89
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 12:10:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556467806; cv=none; d=zoho.com; s=zohoarc; 
	b=cY5RTwwbw7K23ULVWCaDz61MjnNtNNzVLYIb8KMbS+dkZVHcL8K6T7vgsvGx7h1YgX7u0lIMu8T+VQVpRWfjbX1umJltK26etXlYOK5GohR3eMkP8UVAYxeEKi1QVwRegQoQiZytp+PMzcDT+XSWhvMEb12FCVCWRd4VLuuasKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556467806;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=HiG11F9Wp5zhJ9bbTU396VpYrkBNfOTpi8w+iSNwzVQ=; 
	b=LrG4q0a11K0HTEwCvR0gd2j93TeGg4HufcdUCfwAcs5a9ywXm/jrHC0ppC0NTbNWS+GblGKC87G9jloo3VHljZIwYocQPx8mZDeSe/zb2ylhK4XTJGuocrxFbVjxmQWfWWM6M8OA4hfQDrE4FSWI/w4gzoA+Z+qr0OHrGamr6Xg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556467804717944.3095360534309;
	Sun, 28 Apr 2019 09:10:04 -0700 (PDT)
In-Reply-To: <20190428155451.15653-1-thuth@redhat.com>
Message-ID: <155646780285.10667.18275282182893876584@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Sun, 28 Apr 2019 09:10:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic
 iotests during "make check"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, emaste@freebsd.org, qemu-block@nongnu.org,
	alex.bennee@linaro.org, qemu-devel@nongnu.org,
	cfergeau@redhat.com, armbru@redhat.com, wainersm@redhat.com,
	mreitz@redhat.com, philmd@redhat.com, lwhsu@freebsd.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428161004.3wWMZIDZVw7mbuX0dad4NEM76M7boVbWEASPTBHACOs@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyODE1NTQ1MS4xNTY1
My0xLXRodXRoQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDQyODE1NTQ1MS4xNTY1My0x
LXRodXRoQHJlZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MiAwLzhdIHRl
c3RzL3FlbXUtaW90ZXN0czogUnVuIGJhc2ljIGlvdGVzdHMgZHVyaW5nICJtYWtlIGNoZWNrIgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2Ug
PiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5
MDQyODE1NTQ1MS4xNTY1My0xLXRodXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyODE1
NTQ1MS4xNTY1My0xLXRodXRoQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo3YmIwOWUwOGEzIHRlc3RzOiBSdW4gdGhlIGlvdGVzdHMgZHVyaW5nICJtYWtlIGNoZWNr
IiBhZ2FpbgozZDkwNWEwOTFlIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cDogUmUtdXNlIHRoZSAi
YXV0byIgZ3JvdXAgZm9yIHRlc3RzIHRoYXQgY2FuIGFsd2F5cyBydW4KNTY1MDAzYWM4YSB0ZXN0
cy9xZW11LWlvdGVzdHM6IFJlbW92ZSB0aGUgIl9zdXBwb3J0ZWRfb3MgTGludXgiIGxpbmUgZnJv
bSBtYW55IHRlc3RzCmZiMjdkYmEzZDkgY2lycnVzIC8gdHJhdmlzOiBBZGQgZ251LXNlZCBhbmQg
YmFzaCBmb3IgbWFjT1MgYW5kIEZyZWVCU0QKMDJhYzhhNGJmNiB0ZXN0cy9xZW11LWlvdGVzdHM6
IERvIG5vdCBoYXJkLWNvZGUgdGhlIHBhdGggdG8gYmFzaAozNGM2YTg5MWVhIHRlc3RzL3FlbXUt
aW90ZXN0cy9jaGVjazogUGljayBhIGRlZmF1bHQgbWFjaGluZSBpZiBuZWNlc3NhcnkKZDA5MWVk
ZjdjMSB0ZXN0cy9xZW11LWlvdGVzdHMvMDA1OiBBZGQgYSBzYW5pdHkgY2hlY2sgZm9yIGxhcmdl
IHNwYXJzZSBmaWxlIHN1cHBvcnQKM2NmNGNhYTE5MyB0ZXN0cy9xZW11LWlvdGVzdHM6IEZpeCBv
dXRwdXQgb2YgcWVtdS1pbyByZWxhdGVkIHRlc3RzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzgg
Q2hlY2tpbmcgY29tbWl0IDNjZjRjYWExOTNjYyAodGVzdHMvcWVtdS1pb3Rlc3RzOiBGaXggb3V0
cHV0IG9mIHFlbXUtaW8gcmVsYXRlZCB0ZXN0cykKMi84IENoZWNraW5nIGNvbW1pdCBkMDkxZWRm
N2MxZWYgKHRlc3RzL3FlbXUtaW90ZXN0cy8wMDU6IEFkZCBhIHNhbml0eSBjaGVjayBmb3IgbGFy
Z2Ugc3BhcnNlIGZpbGUgc3VwcG9ydCkKMy84IENoZWNraW5nIGNvbW1pdCAzNGM2YTg5MWVhNmUg
KHRlc3RzL3FlbXUtaW90ZXN0cy9jaGVjazogUGljayBhIGRlZmF1bHQgbWFjaGluZSBpZiBuZWNl
c3NhcnkpCjQvOCBDaGVja2luZyBjb21taXQgMDJhYzhhNGJmNjA4ICh0ZXN0cy9xZW11LWlvdGVz
dHM6IERvIG5vdCBoYXJkLWNvZGUgdGhlIHBhdGggdG8gYmFzaCkKNS84IENoZWNraW5nIGNvbW1p
dCBmYjI3ZGJhM2Q5ZjAgKGNpcnJ1cyAvIHRyYXZpczogQWRkIGdudS1zZWQgYW5kIGJhc2ggZm9y
IG1hY09TIGFuZCBGcmVlQlNEKQo2LzggQ2hlY2tpbmcgY29tbWl0IDU2NTAwM2FjOGE3MCAodGVz
dHMvcWVtdS1pb3Rlc3RzOiBSZW1vdmUgdGhlICJfc3VwcG9ydGVkX29zIExpbnV4IiBsaW5lIGZy
b20gbWFueSB0ZXN0cykKNy84IENoZWNraW5nIGNvbW1pdCAzZDkwNWEwOTFlNjQgKHRlc3RzL3Fl
bXUtaW90ZXN0cy9ncm91cDogUmUtdXNlIHRoZSAiYXV0byIgZ3JvdXAgZm9yIHRlc3RzIHRoYXQg
Y2FuIGFsd2F5cyBydW4pCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxMjU6IEZJTEU6IHRl
c3RzL3FlbXUtaW90ZXN0cy9ncm91cDoxMTU6CiswOTMgJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAyOTQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNy84IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo4LzggQ2hlY2tpbmcgY29tbWl0IDdiYjA5ZTA4YTNiMSAodGVzdHM6IFJ1biB0aGUg
aW90ZXN0cyBkdXJpbmcgIm1ha2UgY2hlY2siIGFnYWluKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQg
b3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxMjY6
IApkZWxldGVkIGZpbGUgbW9kZSAxMDA3NTUKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywg
ODUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDI4
MTU1NDUxLjE1NjUzLTEtdGh1dGhAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


