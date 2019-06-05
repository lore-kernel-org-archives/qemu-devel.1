Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECEC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 23:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719582070B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 23:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719582070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYeuz-0001Xf-Kg
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 19:02:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYeu1-00010e-Dt
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 19:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYeu0-0001vK-2U
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 19:01:05 -0400
Resent-Date: Wed, 05 Jun 2019 19:01:05 -0400
Resent-Message-Id: <E1hYeu0-0001vK-2U@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYetz-0001qO-TB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 19:01:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559772927; cv=none; d=zoho.com; s=zohoarc; 
	b=hd3tZt7rjEWg6mfZyC8pmojUDJ8ef/V97xOUMpyAglSPQxf9rSEi+sXG+d5x616dctliMA44WsWo1UOtNjd1AeHkEJVhbJW1jIZzU+30cv5Q9tc9m3n21sTYQiwQzItEHRWzU9JlUC5s639c8m1hIqqLTouLaDP7Khp3mV+XNXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559772927;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=xayUvXyC1aHyi3VkEffCsOnZ+wKqgieqliXPEmXwCt8=; 
	b=kOUFcooEMxO+697x3AdVyOmddk/av0dwQ+kpt89AMWA8AGmWmeQxehMzMSycoQO8NR78FaP9897EoDg/q/GNBiA7IJbk7bcA1rT+zuaSxDp5/vEatkrg4aLweag7+osKiS2qM8PtnSVzVuur3vLO/8NZFODuy6BG4wLgd68rBNE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559772925458563.1398641950854;
	Wed, 5 Jun 2019 15:15:25 -0700 (PDT)
In-Reply-To: <20190605205706.569-1-richard.henderson@linaro.org>
Message-ID: <155977292443.32260.7266600611008191698@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 5 Jun 2019 15:15:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v6 0/6] linux-user/aarch64: Support PROT_BTI
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwNTIwNTcwNi41Njkt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY2IDAvNl0g
bGludXgtdXNlci9hYXJjaDY0OiBTdXBwb3J0IFBST1RfQlRJClR5cGU6IHNlcmllcwpNZXNzYWdl
LWlkOiAyMDE5MDYwNTIwNTcwNi41NjktMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hl
dy8yMDE5MDYwNTIwNTcwNi41NjktMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIC0+IHBh
dGNoZXcvMjAxOTA2MDUyMDU3MDYuNTY5LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjYwMzhjZTJlMGUgdGVzdHMvdGNnL2FhcmNo
NjQ6IEFkZCBidGkgc21va2UgdGVzdApiMTZhZDViZDdiIGxpbnV4LXVzZXI6IFBhcnNlIE5UX0dO
VV9QUk9QRVJUWV9UWVBFXzAgbm90ZXMKNjhmZWZlZjcxNyBpbmNsdWRlL2VsZjogQWRkIGRlZmlu
ZXMgcmVsYXRlZCB0byBub3RlcyBmb3IgR05VIHN5c3RlbXMKOTUxNjY5ZDUyMyBsaW51eC11c2Vy
OiBTZXQgUEFHRV9UQVJHRVRfMSBmb3IgVEFSR0VUX1BST1RfQlRJCjZlYzQ0ZWRkYTUgbGludXgt
dXNlcjogVmFsaWRhdGUgbW1hcC9tcHJvdGVjdCBwcm90IHZhbHVlCjRlYjc3NTU2YWQgbGludXgt
dXNlci9hYXJjaDY0OiBSZXNldCBidHlwZSBmb3Igc3lzY2FsbHMgYW5kIHNpZ25hbHMKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvNiBDaGVja2luZyBjb21taXQgNGViNzc1NTZhZDFlIChsaW51eC11
c2VyL2FhcmNoNjQ6IFJlc2V0IGJ0eXBlIGZvciBzeXNjYWxscyBhbmQgc2lnbmFscykKMi82IENo
ZWNraW5nIGNvbW1pdCA2ZWM0NGVkZGE1YTAgKGxpbnV4LXVzZXI6IFZhbGlkYXRlIG1tYXAvbXBy
b3RlY3QgcHJvdCB2YWx1ZSkKMy82IENoZWNraW5nIGNvbW1pdCA5NTE2NjlkNTIzMWIgKGxpbnV4
LXVzZXI6IFNldCBQQUdFX1RBUkdFVF8xIGZvciBUQVJHRVRfUFJPVF9CVEkpCjQvNiBDaGVja2lu
ZyBjb21taXQgNjhmZWZlZjcxN2JlIChpbmNsdWRlL2VsZjogQWRkIGRlZmluZXMgcmVsYXRlZCB0
byBub3RlcyBmb3IgR05VIHN5c3RlbXMpCjUvNiBDaGVja2luZyBjb21taXQgYjE2YWQ1YmQ3YjVj
IChsaW51eC11c2VyOiBQYXJzZSBOVF9HTlVfUFJPUEVSVFlfVFlQRV8wIG5vdGVzKQo2LzYgQ2hl
Y2tpbmcgY29tbWl0IDYwMzhjZTJlMGU0NCAodGVzdHMvdGNnL2FhcmNoNjQ6IEFkZCBidGkgc21v
a2UgdGVzdCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBN
QUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNTA6IEZJTEU6IHRlc3RzL3Rj
Zy9hYXJjaDY0L2J0aS0xLmM6MTM6CiteSWhpbnReSSMzNFxuXCQKCkVSUk9SOiBjb2RlIGluZGVu
dCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzUxOiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9idGkt
MS5jOjE0OgorXkliXklza2lwMl9zaWdpbGwyXG5cJAoKRVJST1I6IGV4dGVybnMgc2hvdWxkIGJl
IGF2b2lkZWQgaW4gLmMgZmlsZXMKIzEzMzogRklMRTogdGVzdHMvdGNnL2FhcmNoNjQvYnRpLWNy
dC5pbmMuYzoxMzoKK2ludCBtYWluKHZvaWQpOwoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBu
ZXZlciB1c2UgdGFicwojMTgwOiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9idGktY3J0LmluYy5j
OjYwOgorXkkuYWxpZ25eSTNcblwkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiMxODE6IEZJTEU6IHRlc3RzL3RjZy9hYXJjaDY0L2J0aS1jcnQuaW5jLmM6NjE6Cite
SS5sb25nXkk0XG5cJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MTgyOiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9idGktY3J0LmluYy5jOjYyOgorICAgICAgICAu
bG9uZ15JMTZcblwkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMx
ODM6IEZJTEU6IHRlc3RzL3RjZy9hYXJjaDY0L2J0aS1jcnQuaW5jLmM6NjM6CisgICAgICAgIC5s
b25nXkk1XG5cJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTg0
OiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9idGktY3J0LmluYy5jOjY0OgorICAgICAgICAuc3Ry
aW5nXklcIkdOVVwiXG5cJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFi
cwojMTg1OiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9idGktY3J0LmluYy5jOjY1OgorXkkubG9u
Z15JMHhjMDAwMDAwMFxuXCQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzE4NjogRklMRTogdGVzdHMvdGNnL2FhcmNoNjQvYnRpLWNydC5pbmMuYzo2NjoKK15JLmxv
bmdeSTRcblwkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxODc6
IEZJTEU6IHRlc3RzL3RjZy9hYXJjaDY0L2J0aS1jcnQuaW5jLmM6Njc6CiteSS5sb25nXkkxXG5c
JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTg5OiBGSUxFOiB0
ZXN0cy90Y2cvYWFyY2g2NC9idGktY3J0LmluYy5jOjY5OgorXkkucHJldmlvdXMiKTskCgp0b3Rh
bDogMTIgZXJyb3JzLCAxIHdhcm5pbmdzLCAxNTMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi82IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYwNTIwNTcwNi41NjktMS1yaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


