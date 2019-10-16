Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7436ECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 00:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EF520663
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 00:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EF520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKXIF-00087w-0H
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 20:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKXHZ-0007Zz-Qj
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 20:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKXHY-0003o0-EX
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 20:35:17 -0400
Resent-Date: Tue, 15 Oct 2019 20:35:17 -0400
Resent-Message-Id: <E1iKXHY-0003o0-EX@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKXHY-0003nu-7A
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 20:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571185197; cv=none; d=zoho.com; s=zohoarc; 
 b=gvuo+qct+twvfQejJNkcwPEbBeQDpM/0ny2gisEnUgXHJ72s4ZLHFuLFxTn4nbjcis2Bfm8vZcgZFm0pKrLR+nx7r8WtSfn0KgHdlFowmh/my1eQfBYoLpTUm61WQlchho8GsH4HFj4iDWtroTkldkppb4pMtLuOTvGWf9GTScM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571185197;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/77PyzsDKfJhzB+98nlpPFhZ4sN5tYgNXRp5zMUo+E4=; 
 b=ghS8IEqL59LIewDrtU/Z2fXpJj+mSPlr9k2gDx77tlVK/nLED74WlKMjlSnjTy5HaKyst37xTITzhz5MsX3Wgx1HLzHxfspHu2EFVA8IRXAST5C9Ts8myJ2SEfAqD+Z8xz0Va8+7GRXu+wSKsUnNwzxcdGX2Y69XmVQnSiWrPkA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571185195725717.8055131402828;
 Tue, 15 Oct 2019 17:19:55 -0700 (PDT)
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
Subject: Re: [PATCH v2 00/21] iotests: Allow ./check -o data_file
Message-ID: <157118519444.5946.8808407300812393372@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 15 Oct 2019 17:19:55 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNTE0MjcyOS4xODEy
My0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjIgMDAvMjFdIGlvdGVzdHM6IEFsbG93IC4vY2hl
Y2sgLW8gZGF0YV9maWxlClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAxNTE0MjcyOS4x
ODEyMy0xLW1yZWl0ekByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjdlNzU5MTYgaW90ZXN0czogQWxsb3cgY2hl
Y2sgLW8gZGF0YV9maWxlCmEyMTkxOGQgaW90ZXN0czogRGlzYWJsZSBkYXRhX2ZpbGUgd2hlcmUg
aXQgY2Fubm90IGJlIHVzZWQKMWViNzIwOSBpb3Rlc3RzOiBNYWtlIDE5OCB3b3JrIHdpdGggZGF0
YV9maWxlCjAyNDUzZmYgaW90ZXN0czogTWFrZSAxMzcgd29yayB3aXRoIGRhdGFfZmlsZQpjZGI2
NTFjIGlvdGVzdHM6IE1ha2UgMTEwIHdvcmsgd2l0aCBkYXRhX2ZpbGUKMWIzMGU5MCBpb3Rlc3Rz
OiBNYWtlIDA5MSB3b3JrIHdpdGggZGF0YV9maWxlCjI2ZWJmZmEgaW90ZXN0czogQXZvaWQgY3Av
bXYgb2YgdGVzdCBpbWFnZXMKNWQ2YmE3OSBpb3Rlc3RzOiBVc2UgX3JtX3Rlc3RfaW1nIGZvciBk
ZWxldGluZyB0ZXN0IGltYWdlcwo0YzIwZmEwIGlvdGVzdHM6IEF2b2lkIHFlbXUtaW1nIGNyZWF0
ZQo5NDQ1NTViIGlvdGVzdHM6IERyb3AgSU1HT1BUUyB1c2UgaW4gMjY3CjkwMzdiODMgaW90ZXN0
czogUmVwbGFjZSBJTUdPUFRTPScnIGJ5IC0tbm8tb3B0cwplNjIyODJiIGlvdGVzdHM6IFJlcGxh
Y2UgSU1HT1BUUz0gYnkgLW8KMjZkMzliNSBpb3Rlc3RzOiBJbmplY3Qgc3BhY2UgaW50byAtb2Nv
bXBhdD0wLjEwIGluIDA1MQo5OWQxMjllIGlvdGVzdHM6IEFkZCAtbyBhbmQgLS1uby1vcHRzIHRv
IF9tYWtlX3Rlc3RfaW1nCjMwMWYyYzMgaW90ZXN0czogTGV0IF9tYWtlX3Rlc3RfaW1nIHBhcnNl
IGl0cyBwYXJhbWV0ZXJzCjUzYThkZWEgaW90ZXN0czogRHJvcCBjb21wYXQ9MS4xIGluIDA1MAo4
NWIxOGY4IGlvdGVzdHM6IFJlcGxhY2UgSU1HT1BUUyBieSBfdW5zdXBwb3J0ZWRfaW1nb3B0cwo0
NzZmYjIzIGlvdGVzdHM6IEZpbHRlciByZWZjb3VudF9vcmRlciBpbiAwMzYKNjdiOTExOSBpb3Rl
c3RzOiBBZGQgX2ZpbHRlcl9qc29uX2ZpbGVuYW1lCmZiZjk0MDIgaW90ZXN0cy9xY293Mi5weTog
U3BsaXQgZmVhdHVyZSBmaWVsZHMgaW50byBiaXRzCmFmZTM0ODYgaW90ZXN0cy9xY293Mi5weTog
QWRkIGR1bXAtaGVhZGVyLWV4dHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMjEgQ2hlY2tpbmcg
Y29tbWl0IGFmZTM0ODY2MTY3MiAoaW90ZXN0cy9xY293Mi5weTogQWRkIGR1bXAtaGVhZGVyLWV4
dHMpCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzI6IEZJTEU6IHRlc3RzL3FlbXUt
aW90ZXN0cy9xY293Mi5weToyMzc6CisgICAgWyAnZHVtcC1oZWFkZXItZXh0cycsICAgICBjbWRf
ZHVtcF9oZWFkZXJfZXh0cywgICAgIDAsICdEdW1wIGltYWdlIGhlYWRlciBleHRlbnNpb25zJyBd
LAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNyBsaW5lcyBjaGVja2VkCgpQYXRjaCAx
LzIxIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIxIENoZWNraW5nIGNvbW1pdCBmYmY5
NDAyNTVkMDUgKGlvdGVzdHMvcWNvdzIucHk6IFNwbGl0IGZlYXR1cmUgZmllbGRzIGludG8gYml0
cykKMy8yMSBDaGVja2luZyBjb21taXQgNjdiOTExOTAzMmFkIChpb3Rlc3RzOiBBZGQgX2ZpbHRl
cl9qc29uX2ZpbGVuYW1lKQo0LzIxIENoZWNraW5nIGNvbW1pdCA0NzZmYjIzM2M3NzcgKGlvdGVz
dHM6IEZpbHRlciByZWZjb3VudF9vcmRlciBpbiAwMzYpCjUvMjEgQ2hlY2tpbmcgY29tbWl0IDg1
YjE4ZjgzYTgyNiAoaW90ZXN0czogUmVwbGFjZSBJTUdPUFRTIGJ5IF91bnN1cHBvcnRlZF9pbWdv
cHRzKQo2LzIxIENoZWNraW5nIGNvbW1pdCA1M2E4ZGVhOGZiN2IgKGlvdGVzdHM6IERyb3AgY29t
cGF0PTEuMSBpbiAwNTApCjcvMjEgQ2hlY2tpbmcgY29tbWl0IDMwMWYyYzMyMjA0YyAoaW90ZXN0
czogTGV0IF9tYWtlX3Rlc3RfaW1nIHBhcnNlIGl0cyBwYXJhbWV0ZXJzKQo4LzIxIENoZWNraW5n
IGNvbW1pdCA5OWQxMjllOTFkYmUgKGlvdGVzdHM6IEFkZCAtbyBhbmQgLS1uby1vcHRzIHRvIF9t
YWtlX3Rlc3RfaW1nKQo5LzIxIENoZWNraW5nIGNvbW1pdCAyNmQzOWI1OWRmZTEgKGlvdGVzdHM6
IEluamVjdCBzcGFjZSBpbnRvIC1vY29tcGF0PTAuMTAgaW4gMDUxKQoxMC8yMSBDaGVja2luZyBj
b21taXQgZTYyMjgyYjJhZDM4IChpb3Rlc3RzOiBSZXBsYWNlIElNR09QVFM9IGJ5IC1vKQoxMS8y
MSBDaGVja2luZyBjb21taXQgOTAzN2I4MzQyNWM0IChpb3Rlc3RzOiBSZXBsYWNlIElNR09QVFM9
JycgYnkgLS1uby1vcHRzKQoxMi8yMSBDaGVja2luZyBjb21taXQgOTQ0NTU1YjVjMjgzIChpb3Rl
c3RzOiBEcm9wIElNR09QVFMgdXNlIGluIDI2NykKMTMvMjEgQ2hlY2tpbmcgY29tbWl0IDRjMjBm
YTA5YjZjNSAoaW90ZXN0czogQXZvaWQgcWVtdS1pbWcgY3JlYXRlKQoxNC8yMSBDaGVja2luZyBj
b21taXQgNWQ2YmE3OTEyMDRiIChpb3Rlc3RzOiBVc2UgX3JtX3Rlc3RfaW1nIGZvciBkZWxldGlu
ZyB0ZXN0IGltYWdlcykKMTUvMjEgQ2hlY2tpbmcgY29tbWl0IDI2ZWJmZmFmYmQ4NyAoaW90ZXN0
czogQXZvaWQgY3AvbXYgb2YgdGVzdCBpbWFnZXMpCjE2LzIxIENoZWNraW5nIGNvbW1pdCAxYjMw
ZTkwMzU5MDggKGlvdGVzdHM6IE1ha2UgMDkxIHdvcmsgd2l0aCBkYXRhX2ZpbGUpCjE3LzIxIENo
ZWNraW5nIGNvbW1pdCBjZGI2NTFjM2MyMmIgKGlvdGVzdHM6IE1ha2UgMTEwIHdvcmsgd2l0aCBk
YXRhX2ZpbGUpCjE4LzIxIENoZWNraW5nIGNvbW1pdCAwMjQ1M2ZmNzEzMTEgKGlvdGVzdHM6IE1h
a2UgMTM3IHdvcmsgd2l0aCBkYXRhX2ZpbGUpCjE5LzIxIENoZWNraW5nIGNvbW1pdCAxZWI3MjA5
MTBhNjUgKGlvdGVzdHM6IE1ha2UgMTk4IHdvcmsgd2l0aCBkYXRhX2ZpbGUpCjIwLzIxIENoZWNr
aW5nIGNvbW1pdCBhMjE5MThkY2RmOTIgKGlvdGVzdHM6IERpc2FibGUgZGF0YV9maWxlIHdoZXJl
IGl0IGNhbm5vdCBiZSB1c2VkKQoyMS8yMSBDaGVja2luZyBjb21taXQgN2U3NTkxNjk2MzgyIChp
b3Rlc3RzOiBBbGxvdyBjaGVjayAtbyBkYXRhX2ZpbGUpCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDE1MTQyNzI5LjE4MTIzLTEtbXJlaXR6
QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


