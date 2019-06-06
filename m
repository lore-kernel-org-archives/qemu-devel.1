Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE4C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5211204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5211204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ0Mv-0000Mp-IZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57339)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hZ0Lx-0008K9-IS
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hZ0Lw-0004vR-Bd
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:55:21 -0400
Resent-Date: Thu, 06 Jun 2019 17:55:21 -0400
Resent-Message-Id: <E1hZ0Lw-0004vR-Bd@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hZ0Ls-0004nq-8B; Thu, 06 Jun 2019 17:55:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559858073; cv=none; d=zoho.com; s=zohoarc; 
 b=ed9/H523oPLfjE1XCDtoRhQcFiBA1h2F5nwFXIYRMRUtoudr4Wc78yqSv0afWxyGHN/s8jUhpak4RJX6OMRwyPLlO+usZbwSWWIpzG+Z1WrLrQ+B5cvMah4Rfoare0hLaYFo+IV4S90sis5s3fXQ/rIkRrk40a3xIGQfiY0thoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1559858073;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=korqaB03mGwoMVMfIvMdVncQcagZ+hzfYU/vusChsOs=; 
 b=ZC6mbt4rAEBKsZyXL5u3AQseTrSjZKmSPCgwVsbIn97a5GymQgW2h6TLx1a3epdOV1tr3/ztF9/qRjlOziB4Nt2lbJJ5g7qyw84EGd7WUOQBFpjH3Pe0pTuOZpNdcvbPkbC/Pqi3qsLVSmYl962rfKh6v5XSgUJMrSmKtMHH3lI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1559858071457973.4278767955967;
 Thu, 6 Jun 2019 14:54:31 -0700 (PDT)
In-Reply-To: <20190606184159.979-1-jsnow@redhat.com>
Message-ID: <155985807005.32260.10872733081564625715@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Thu, 6 Jun 2019 14:54:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/5] block/dirty-bitmap: check number and
 size constraints against queued bitmaps
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 aliang@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwNjE4NDE1OS45Nzkt
MS1qc25vd0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvNV0gYmxvY2svZGlydHktYml0
bWFwOiBjaGVjayBudW1iZXIgYW5kIHNpemUgY29uc3RyYWludHMgYWdhaW5zdCBxdWV1ZWQgYml0
bWFwcwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA2MDYxODQxNTkuOTc5LTEtanNub3dA
cmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
ICAgICAgIHBhdGNoZXcvMjAxOTA2MDYxODQxNTkuOTc5LTEtanNub3dAcmVkaGF0LmNvbSAtPiBw
YXRjaGV3LzIwMTkwNjA2MTg0MTU5Ljk3OS0xLWpzbm93QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo2ZDAwZGM5NWRkIGJsb2NrL3Fjb3cyLWJpdG1hcDogQ291bnQg
cXVldWVkIGJpdG1hcHMgdG93YXJkcyBkaXJlY3Rvcnlfc2l6ZQphYWYxNzIzNDMxIGJsb2NrL3Fj
b3cyLWJpdG1hcDogQ291bnQgcXVldWVkIGJpdG1hcHMgdG93YXJkcyBuYl9iaXRtYXBzCjQ3NWY1
ZWVmNjQgYmxvY2svZGlydHktYml0bWFwOiByZXdvcmsgYmRydl9yZW1vdmVfcGVyc2lzdGVudF9k
aXJ0eV9iaXRtYXAKMDY5OGU0NjI2NiBibG9jay9kaXJ0eS1iaXRtYXA6IFJlZmFjdG9yIGJkcnZf
Y2FuX3N0b3JlX25ld19iaXRtYXAKZTk0ZjQ0Y2I4OCBibG9jay9xY293Mi1iaXRtYXA6IGFsbG93
IGJpdG1hcF9saXN0X2xvYWQgdG8gcmV0dXJuIGFuIGVycm9yIGNvZGUKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvNSBDaGVja2luZyBjb21taXQgZTk0ZjQ0Y2I4OGJiIChibG9jay9xY293Mi1iaXRt
YXA6IGFsbG93IGJpdG1hcF9saXN0X2xvYWQgdG8gcmV0dXJuIGFuIGVycm9yIGNvZGUpCkVSUk9S
OiBkbyBub3QgdXNlIGFzc2lnbm1lbnQgaW4gaWYgY29uZGl0aW9uCiMxNTE6IEZJTEU6IGJsb2Nr
L3Fjb3cyLWJpdG1hcC5jOjExMzA6CisgICAgaWYgKChyZXQgPSBiaXRtYXBfbGlzdF9sb2FkKGJz
LCAmYm1fbGlzdCwgZXJycCkpKSB7CgpFUlJPUjogZG8gbm90IHVzZSBhc3NpZ25tZW50IGluIGlm
IGNvbmRpdGlvbgojMTY0OiBGSUxFOiBibG9jay9xY293Mi1iaXRtYXAuYzoxMTg5OgorICAgIGlm
ICgocmV0ID0gYml0bWFwX2xpc3RfbG9hZChicywgJmJtX2xpc3QsIGVycnApKSkgewoKdG90YWw6
IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNjYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS81IGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzUgQ2hlY2tpbmcgY29tbWl0IDA2OThlNDYyNjYxZCAo
YmxvY2svZGlydHktYml0bWFwOiBSZWZhY3RvciBiZHJ2X2Nhbl9zdG9yZV9uZXdfYml0bWFwKQpF
UlJPUjogZG8gbm90IHVzZSBhc3NpZ25tZW50IGluIGlmIGNvbmRpdGlvbgojMTY2OiBGSUxFOiBi
bG9jay9xY293Mi1iaXRtYXAuYzoxNjU2OgorICAgIGlmICgocmV0ID0gYml0bWFwX2xpc3RfbG9h
ZChicywgJmJtX2xpc3QsIGVycnApKSkgewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAy
MDAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoz
LzUgQ2hlY2tpbmcgY29tbWl0IDQ3NWY1ZWVmNjRhNyAoYmxvY2svZGlydHktYml0bWFwOiByZXdv
cmsgYmRydl9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXApCkVSUk9SOiBkbyBub3QgdXNl
IGFzc2lnbm1lbnQgaW4gaWYgY29uZGl0aW9uCiM5MTogRklMRTogYmxvY2svcWNvdzItYml0bWFw
LmM6MTQyMToKKyAgICBpZiAoKHJldCA9IGJpdG1hcF9saXN0X2xvYWQoYnMsICZibV9saXN0LCBl
cnJwKSkpIHsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTQzIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDMvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNC81IENoZWNraW5nIGNvbW1p
dCBhYWYxNzIzNDMxNDggKGJsb2NrL3Fjb3cyLWJpdG1hcDogQ291bnQgcXVldWVkIGJpdG1hcHMg
dG93YXJkcyBuYl9iaXRtYXBzKQpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMp
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDk3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQv
NSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS81IENoZWNraW5nIGNvbW1pdCA2ZDAwZGM5
NWRkYzAgKGJsb2NrL3Fjb3cyLWJpdG1hcDogQ291bnQgcXVldWVkIGJpdG1hcHMgdG93YXJkcyBk
aXJlY3Rvcnlfc2l6ZSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTA2MDYxODQxNTkuOTc5LTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


