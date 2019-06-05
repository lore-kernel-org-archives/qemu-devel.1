Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB94C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 22:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9672070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 22:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9672070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYesa-0008N3-5e
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 18:59:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYerh-00083c-Ob
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 18:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYerg-0007pu-Cr
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 18:58:41 -0400
Resent-Date: Wed, 05 Jun 2019 18:58:41 -0400
Resent-Message-Id: <E1hYerg-0007pu-Cr@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYerg-0007mv-4t
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 18:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559775480; cv=none; d=zoho.com; s=zohoarc; 
	b=RxDFDPXRxPfKBrYcU0tqQ52+YG3ixklJtHqXoLaBvwqFro9UnMdIBegySwenWw1Ipiz43u6V93crJPd5FO+PAqbFw3mDWYDRSYEadjh1rgENcNlHB10ssTEQk0BvnvYeOCoEKcPz8f5GDgfDztnPVaHpQfQUHqEp6d/5azavPB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559775480;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=Bg+veaoops8DB5pJAmKcAvwZ5HkcJDla9Icl0ytnYzI=; 
	b=Os462/qO2+FTJg5lZQsWrFEcJThDRBWvF8TuG+6qKyZ1ogPHrwyWCgkRSz1rhDFKS1xnILXeqTB9xtx41iJBm/SMgK7f4103NwFZEn+fK63RzLaTtvfj+440gqUGw2QoMQ0q3O/6egvjpkAbtiIcItcwh8xK7DaZ3F1EqNbb/hs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559775478180500.8245808038928;
	Wed, 5 Jun 2019 15:57:58 -0700 (PDT)
In-Reply-To: <20190605213654.9785-1-ptoscano@redhat.com>
Message-ID: <155977547693.32260.8548021932284388381@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ptoscano@redhat.com
Date: Wed, 5 Jun 2019 15:57:58 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, rjones@redhat.com,
	qemu-devel@nongnu.org, mreitz@redhat.com, ptoscano@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwNTIxMzY1NC45Nzg1
LTEtcHRvc2Nhbm9AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA2MDUyMTM2NTQuOTc4NS0xLXB0b3NjYW5vQHJl
ZGhhdC5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjZdIHNz
aDogc3dpdGNoIGZyb20gbGlic3NoMiB0byBsaWJzc2gKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmFiZWY4MTcgc3No
OiBzd2l0Y2ggZnJvbSBsaWJzc2gyIHRvIGxpYnNzaAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FS
TklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUK
IzY4OiBGSUxFOiBibG9jay9zc2guYzo0NjoKKy8qIFRSQUNFX0xJQlNTSD08bGV2ZWw+IGVuYWJs
ZXMgdHJhY2luZyBpbiBsaWJzc2ggaXRzZWxmLgoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNl
IGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzk1OiBGSUxFOiBibG9jay9zc2guYzo2
NDoKKyAgICAvKiBGaWxlIGF0dHJpYnV0ZXMgYXQgb3Blbi4gIFdlIHRyeSB0byBrZWVwIHRoZSAu
c2l6ZSBmaWVsZAoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBh
IHNlcGFyYXRlIGxpbmUKIzQ4NDogRklMRTogYmxvY2svc3NoLmM6NDkxOgorICAgIC8qIFRyeSB0
byBhdXRoZW50aWNhdGUgd2l0aCBwdWJsaWNrZXksIHVzaW5nIHRoZSBzc2gtYWdlbnQKCldBUk5J
Tkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM1
NTM6IEZJTEU6IGJsb2NrL3NzaC5jOjY2MjoKKyAgICAvKiBUcnkgdG8gZGlzYWJsZSB0aGUgTmFn
bGUgYWxnb3JpdGhtIG9uIFRDUCBzb2NrZXRzIHRvIHJlZHVjZSBsYXRlbmN5LAoKV0FSTklORzog
QmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzU3NTog
RklMRTogYmxvY2svc3NoLmM6Njc5OgorICAgIC8qIE1ha2Ugc3VyZSB3ZSBhcmUgaW4gYmxvY2tp
bmcgbW9kZSBkdXJpbmcgdGhlIGNvbm5lY3Rpb24gYW5kCgpXQVJOSU5HOiBCbG9jayBjb21tZW50
cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojODk1OiBGSUxFOiBibG9jay9z
c2guYzoxMDYyOgorICAgICAgICAvKiBUaGUgc2l6ZSBvZiBTRlRQIHBhY2tldHMgaXMgbGltaXRl
ZCB0byAzMksgYnl0ZXMsIHNvIGxpbWl0CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cwojOTQ3OiBGSUxFOiBibG9jay9zc2guYzoxMTM1OgorICAgICAgICB0cmFjZV9zc2hfd3JpdGVf
YnVmKGJ1ZiwgZW5kX29mX3ZlYyAtIGJ1ZiwgTUlOKGVuZF9vZl92ZWMgLSBidWYsIDEzMTA3Mikp
OwoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRl
IGxpbmUKIzk0ODogRklMRTogYmxvY2svc3NoLmM6MTEzNjoKKyAgICAgICAgLyogQXZvaWQgdG9v
IGxhcmdlIGRhdGEgcGFja2V0cywgYXMgbGlic3NoIGN1cnJlbnRseSBkb2VzIG5vdAoKRVJST1I6
IEhleCBudW1iZXJzIG11c3QgYmUgcHJlZml4ZWQgd2l0aCAnMHgnCiMxMTIyOiBGSUxFOiBibG9j
ay90cmFjZS1ldmVudHM6MTg1Ogorc3NoX2F1dGhfbWV0aG9kcyhpbnQgbWV0aG9kcykgImF1dGgg
bWV0aG9kcz0leCIKCnRvdGFsOiAxIGVycm9ycywgOCB3YXJuaW5ncywgMTE3NSBsaW5lcyBjaGVj
a2VkCgpDb21taXQgYWJlZjgxN2U0ZThmIChzc2g6IHN3aXRjaCBmcm9tIGxpYnNzaDIgdG8gbGli
c3NoKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYwNTIxMzY1NC45Nzg1LTEtcHRvc2Nhbm9A
cmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


