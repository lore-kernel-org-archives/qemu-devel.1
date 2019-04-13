Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD7C10F0E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027092084E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 01:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027092084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45051 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF7Mp-0004J6-7z
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 21:22:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hF7Lw-0003ht-W4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hF7Lv-0004a2-LC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:21:08 -0400
Resent-Date: Fri, 12 Apr 2019 21:21:08 -0400
Resent-Message-Id: <E1hF7Lv-0004a2-LC@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hF7Lv-0004ZM-B9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 21:21:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555118435; cv=none; d=zoho.com; s=zohoarc; 
	b=c0dNnZd396C6Q0M6ZD3JwDuDFFt501/A0yTj1jNi75j+W0vWrKAihAgma1q9R2N/K8W+MoCs8/STaW603MQrwPRMF8gjToQv7rinOcH6lP7RfeCiKdXm3S499qNwvtuTXELUlNqw/JsgiiVtL6dfzpBgfoEHgpaxwu0Jb91eujw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555118435;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=UH4bf0uKHsG5NSRzWDVbTfQ63o7ZbFj1Q3r65tf5Lzg=; 
	b=Zi5DgkLwk91YwOkare/8wzT2XMggR9wQ1N2r9FH5PY2ig0x86WoJVEfyHsCkII4h1jqycwUEp3Ihvk2jSbh7MaSRqO/22HJ00h9jQgfxl6YVVhtsr42JSmNA4+mj2LLk+pbYLwv7jvxWNEqhojs6G5QBEk/tnh819gDBNV64Cn0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555118434568853.2432070689388;
	Fri, 12 Apr 2019 18:20:34 -0700 (PDT)
Message-ID: <155511843297.29694.7579426279005745318@76452e4e88f2>
In-Reply-To: <20190413011302.6610-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jbi.octave@gmail.com
Date: Fri, 12 Apr 2019 18:20:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v4 0/3] target/mips: Errors and warnings
 cleanup
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
Cc: fam@euphon.net, jbi.octave@gmail.com, arikalo@wavecomp.com,
	qemu-devel@nongnu.org, amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413012034.KhCZks0h5R7AWp20u8GGv8cqUijLWJUzWMWGzAuxHb4@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxMzAxMTMwMi42NjEw
LTEtamJpLm9jdGF2ZUBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDEzMDExMzAyLjY2MTAtMS1qYmkub2N0YXZl
QGdtYWlsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0IDAvM10gdGFyZ2V0L21p
cHM6IEVycm9ycyBhbmQgd2FybmluZ3MgY2xlYW51cApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MTExMDA4MzYu
NjQ2LTEtZGF2aWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwNDExMTAwODM2LjY0Ni0xLWRh
dmlkQHJlZGhhdC5jb20KIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQx
MTEzNTYwMi4yMTcyNS0xLWFybWJydUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxOTA0MTExMzU2
MDIuMjE3MjUtMS1hcm1icnVAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBw
YXRjaGV3LzIwMTkwNDEzMDExMzAyLjY2MTAtMS1qYmkub2N0YXZlQGdtYWlsLmNvbSAtPiBwYXRj
aGV3LzIwMTkwNDEzMDExMzAyLjY2MTAtMS1qYmkub2N0YXZlQGdtYWlsLmNvbQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmI4MmUwNzlkNWQgdGFyZ2V0L21pcHM6IHdyYXAgbGluZXMg
dG8gZml4IGNoZWNrcGF0Y2ggZXJyb3JzCmUzMzM2ZjQzZWYgdGFyZ2V0L21pcHM6IHJlYWxpZ24g
Y29tbWVudHMgdG8gZml4IGNoZWNrcGF0Y2ggd2FybmluZ3MKMjRlMWM1OTdhOSB0YXJnZXQvbWlw
czogYWRkIG9yIHJlbW92ZSBzcGFjZSB0byBmaXggY2hlY2twYXRjaCBlcnJvcnMKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgMjRlMWM1OTdhOWY1ICh0YXJnZXQvbWlw
czogYWRkIG9yIHJlbW92ZSBzcGFjZSB0byBmaXggY2hlY2twYXRjaCBlcnJvcnMpCkVSUk9SOiBs
aW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNDQ6IEZJTEU6IHRhcmdldC9taXBzL2NwdS5oOjc0Ogor
I2RlZmluZSBTRVRfRlBfQ09ORChudW0sIGVudikgICAgIGRvIHsgKChlbnYpLmZjcjMxKSB8PSAo
KG51bSkgPyAoMSA8PCAoKG51bSkgKyAyNCkpIDogKDEgPDwgMjMpKTsgfSB3aGlsZSAoMCkKCkVS
Uk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNDU6IEZJTEU6IHRhcmdldC9taXBzL2NwdS5o
Ojc1OgorI2RlZmluZSBDTEVBUl9GUF9DT05EKG51bSwgZW52KSAgIGRvIHsgKChlbnYpLmZjcjMx
KSAmPSB+KChudW0pID8gKDEgPDwgKChudW0pICsgMjQpKSA6ICgxIDw8IDIzKSk7IH0gd2hpbGUg
KDApCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU0OiBGSUxFOiB0YXJnZXQvbWlw
cy9jcHUuaDo4MDoKKyNkZWZpbmUgU0VUX0ZQX0NBVVNFKHJlZywgdikgICAgICBkbyB7IChyZWcp
ID0gKChyZWcpICYgfigweDNmIDw8IDEyKSkgfCAoKHYgJiAweDNmKSA8PCAxMik7IH0gd2hpbGUg
KDApCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU1OiBGSUxFOiB0YXJnZXQvbWlw
cy9jcHUuaDo4MToKKyNkZWZpbmUgU0VUX0ZQX0VOQUJMRShyZWcsIHYpICAgICBkbyB7IChyZWcp
ID0gKChyZWcpICYgfigweDFmIDw8ICA3KSkgfCAoKHYgJiAweDFmKSA8PCA3KTsgfSB3aGlsZSAo
MCkKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNTY6IEZJTEU6IHRhcmdldC9taXBz
L2NwdS5oOjgyOgorI2RlZmluZSBTRVRfRlBfRkxBR1MocmVnLCB2KSAgICAgIGRvIHsgKHJlZykg
PSAoKHJlZykgJiB+KDB4MWYgPDwgIDIpKSB8ICgodiAmIDB4MWYpIDw8IDIpOyB9IHdoaWxlICgw
KQoKdG90YWw6IDUgZXJyb3JzLCAwIHdhcm5pbmdzLCAyMzAgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
MS8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzMgQ2hlY2tpbmcgY29tbWl0IGUzMzM2
ZjQzZWZlMCAodGFyZ2V0L21pcHM6IHJlYWxpZ24gY29tbWVudHMgdG8gZml4IGNoZWNrcGF0Y2gg
d2FybmluZ3MpCjMvMyBDaGVja2luZyBjb21taXQgYjgyZTA3OWQ1ZDkxICh0YXJnZXQvbWlwczog
d3JhcCBsaW5lcyB0byBmaXggY2hlY2twYXRjaCBlcnJvcnMpCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDEzMDExMzAyLjY2MTAtMS1qYmku
b2N0YXZlQGdtYWlsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


