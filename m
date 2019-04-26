Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5F2C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BA0214C6
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BA0214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4uM-0000D3-Jl
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:45:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hK4tV-0008Ij-4B
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hK4tT-0002tF-NI
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:44:17 -0400
Resent-Date: Fri, 26 Apr 2019 13:44:17 -0400
Resent-Message-Id: <E1hK4tT-0002tF-NI@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hK4tT-0002Pw-FR
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:44:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556300625; cv=none; d=zoho.com; s=zohoarc; 
	b=Pa72uXLirczr0xOzqoOwPljOFfKxvhQH354nzLKre/RO7xUMwBvpc1dTM11GiFITUwKx4xcfrjKpsmL6OAd0KGIsk9P00jTa/a1d1TrRS6rmvviv6QEybA00P2RRd++me0GTK8nfveMszil3gZy8FguEUDTuZ4BvqMYnr7CZ35k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556300625;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=T7Ibd7c9WYGIes4uzwD46tCMln38wW/5Z/6Ox/2Cv7s=; 
	b=bF7pLQtQvq8s/bN9tRN34m1EdhnV6olQKWRAUtzyYI80a6SwO3RMA9kDoVSckGHL+tjYFgaoyAB9W4bcAMugozFCR+SvBw6sOSzjTMd7omnBCGdFjMlb8etSeqRaY5BUSuaNV7kx5yTOAhzk9bzHw3cwDSgLaeXeJCFrz79kpYQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 155630062041243.039113296879464;
	Fri, 26 Apr 2019 10:43:40 -0700 (PDT)
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
Message-ID: <155630061924.10667.8214400027023709083@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 26 Apr 2019 10:43:40 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PULL 00/15] tcg patch queue
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
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426174340.WXVkLcStUEwWWLEycjYE1IxxtdUCn_iy7uJ_X_jfQdA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNjE3MjQyMS4yNzEz
My0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDQyNjE3
MjQyMS4yNzEzMy0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQVUxMIDAwLzE1XSB0Y2cgcGF0Y2ggcXVldWUKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MjYxNzI0MjEuMjcxMzMtMS1y
aWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAxOTA0MjYxNzI0MjEuMjcx
MzMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKM2I1ZmJhZDI3YSBjcHV0bGI6IEZpeCBpb19yZWFkeCgpIHRvIHJlc3BlY3QgdGhl
IGFjY2Vzc190eXBlCmI1NTM4YzQ0MWIgdGNnL2FybTogUmVzdHJpY3QgY29uc3RhbnQgcG9vbCBk
aXNwbGFjZW1lbnQgdG8gMTIgYml0cwpkNDJjNjUxOTIzIHRjZy9wcGM6IEFsbG93IHRoZSBjb25z
dGFudCBwb29sIHRvIG92ZXJmbG93IGF0IDMyawowYzFiODY4N2IxIHRjZzogUmVzdGFydCBUQiBn
ZW5lcmF0aW9uIGFmdGVyIG91dC1vZi1saW5lIGxkc3Qgb3ZlcmZsb3cKZTIxYjA1ZmJjOCB0Y2c6
IFJlc3RhcnQgVEIgZ2VuZXJhdGlvbiBhZnRlciBjb25zdGFudCBwb29sIG92ZXJmbG93CjdjNTY3
ZmEwMzggdGNnOiBSZXN0YXJ0IFRCIGdlbmVyYXRpb24gYWZ0ZXIgcmVsb2NhdGlvbiBvdmVyZmxv
dwo4ZWM2MDY5MmZjIHRjZzogUmVzdGFydCBhZnRlciBUQiBjb2RlIGdlbmVyYXRpb24gb3ZlcmZs
b3cKZTIwNDIyMjM4MiB0Y2c6IEhvaXN0IG1heF9pbnNucyBjb21wdXRhdGlvbiB0byB0Yl9nZW5f
Y29kZQo0OThjNDU1Mzk1IHRjZy9hYXJjaDY0OiBTdXBwb3J0IElOREVYX29wX2V4dHJhY3QyX3tp
MzIsIGk2NH0KZTEzMjU3NzQwMCB0Y2cvYXJtOiBTdXBwb3J0IElOREVYX29wX2V4dHJhY3QyX2kz
MgpjMzEyZmRkYzcyIHRjZy9pMzg2OiBTdXBwb3J0IElOREVYX29wX2V4dHJhY3QyX3tpMzIsIGk2
NH0KMjkzMTFhYzA5ZSB0Y2c6IFVzZSBleHRyYWN0MiBpbiB0Y2dfZ2VuX2RlcG9zaXRfe2kzMiwg
aTY0fQoxZGNmNGFiNGYxIHRjZzogVXNlIGRlcG9zaXQgYW5kIGV4dHJhY3QyIGluIHRjZ19nZW5f
c2hpZnRpX2k2NAoxYWMyYWUyNTFiIHRjZzogQWRkIElOREVYX29wX2V4dHJhY3QyX3tpMzIsaTY0
fQoxMmU4NGE1NDBkIHRjZzogSW1wbGVtZW50IHRjZ19nZW5fZXh0cmFjdDJfe2kzMiwgaTY0fQoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNSBDaGVja2luZyBjb21taXQgMTJlODRhNTQwZDIxICh0
Y2c6IEltcGxlbWVudCB0Y2dfZ2VuX2V4dHJhY3QyX3tpMzIsIGk2NH0pCjIvMTUgQ2hlY2tpbmcg
Y29tbWl0IDFhYzJhZTI1MWIyMSAodGNnOiBBZGQgSU5ERVhfb3BfZXh0cmFjdDJfe2kzMixpNjR9
KQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4RSkKIzExMTog
RklMRTogdGNnL29wdGltaXplLmM6MTIwNToKKyAgICAgICAgQ0FTRV9PUF8zMl82NChleHRyYWN0
Mik6CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAw
IHdhcm5pbmdzLCAyMDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMy8xNSBDaGVja2luZyBjb21taXQgMWRjZjRhYjRmMWQzICh0Y2c6IFVzZSBk
ZXBvc2l0IGFuZCBleHRyYWN0MiBpbiB0Y2dfZ2VuX3NoaWZ0aV9pNjQpCjQvMTUgQ2hlY2tpbmcg
Y29tbWl0IDI5MzExYWMwOWViMCAodGNnOiBVc2UgZXh0cmFjdDIgaW4gdGNnX2dlbl9kZXBvc2l0
X3tpMzIsIGk2NH0pCjUvMTUgQ2hlY2tpbmcgY29tbWl0IGMzMTJmZGRjNzI5ZiAodGNnL2kzODY6
IFN1cHBvcnQgSU5ERVhfb3BfZXh0cmFjdDJfe2kzMiwgaTY0fSkKRVJST1I6IHNwYWNlcyByZXF1
aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeEUpCiM0ODogRklMRTogdGNnL2kzODYvdGNnLXRh
cmdldC5pbmMuYzoyNTkxOgorICAgIE9QXzMyXzY0KGV4dHJhY3QyKToKICAgICAgICAgICAgICAg
ICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDUxIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDUvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjYvMTUgQ2hlY2tpbmcgY29t
bWl0IGUxMzI1Nzc0MDA1OCAodGNnL2FybTogU3VwcG9ydCBJTkRFWF9vcF9leHRyYWN0Ml9pMzIp
CjcvMTUgQ2hlY2tpbmcgY29tbWl0IDQ5OGM0NTUzOTVkYyAodGNnL2FhcmNoNjQ6IFN1cHBvcnQg
SU5ERVhfb3BfZXh0cmFjdDJfe2kzMiwgaTY0fSkKOC8xNSBDaGVja2luZyBjb21taXQgZTIwNDIy
MjM4MmVmICh0Y2c6IEhvaXN0IG1heF9pbnNucyBjb21wdXRhdGlvbiB0byB0Yl9nZW5fY29kZSkK
OS8xNSBDaGVja2luZyBjb21taXQgOGVjNjA2OTJmY2U0ICh0Y2c6IFJlc3RhcnQgYWZ0ZXIgVEIg
Y29kZSBnZW5lcmF0aW9uIG92ZXJmbG93KQoxMC8xNSBDaGVja2luZyBjb21taXQgN2M1NjdmYTAz
ODZkICh0Y2c6IFJlc3RhcnQgVEIgZ2VuZXJhdGlvbiBhZnRlciByZWxvY2F0aW9uIG92ZXJmbG93
KQoxMS8xNSBDaGVja2luZyBjb21taXQgZTIxYjA1ZmJjODUzICh0Y2c6IFJlc3RhcnQgVEIgZ2Vu
ZXJhdGlvbiBhZnRlciBjb25zdGFudCBwb29sIG92ZXJmbG93KQoxMi8xNSBDaGVja2luZyBjb21t
aXQgMGMxYjg2ODdiMTkyICh0Y2c6IFJlc3RhcnQgVEIgZ2VuZXJhdGlvbiBhZnRlciBvdXQtb2Yt
bGluZSBsZHN0IG92ZXJmbG93KQoxMy8xNSBDaGVja2luZyBjb21taXQgZDQyYzY1MTkyM2FhICh0
Y2cvcHBjOiBBbGxvdyB0aGUgY29uc3RhbnQgcG9vbCB0byBvdmVyZmxvdyBhdCAzMmspCjE0LzE1
IENoZWNraW5nIGNvbW1pdCBiNTUzOGM0NDFiMTIgKHRjZy9hcm06IFJlc3RyaWN0IGNvbnN0YW50
IHBvb2wgZGlzcGxhY2VtZW50IHRvIDEyIGJpdHMpCjE1LzE1IENoZWNraW5nIGNvbW1pdCAzYjVm
YmFkMjdhNDggKGNwdXRsYjogRml4IGlvX3JlYWR4KCkgdG8gcmVzcGVjdCB0aGUgYWNjZXNzX3R5
cGUpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwNDI2MTcyNDIxLjI3MTMzLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


