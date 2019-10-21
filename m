Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C73CA9EAD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 00:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D72218BA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 00:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D72218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMLDS-00016a-P4
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 20:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMLCk-0000W5-8f
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 20:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMLCi-0004Ed-Eb
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 20:05:45 -0400
Resent-Date: Sun, 20 Oct 2019 20:05:45 -0400
Resent-Message-Id: <E1iMLCi-0004Ed-Eb@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMLCi-0004Bl-9E; Sun, 20 Oct 2019 20:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571616217; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c0hdCroMceelOhNHGjbW3Nkhv968urpaa3LBqAfZ57/M1W86uGl8hbReYRcro9P4C3/H+MNZCYaHk+ORKfLK+kQ+HewE0sGRTxdvRgtLzEeRMIfXb6ToYU7tlhOP+YxI3Q81UfFJgLxOkXkfXDnc5t1vK/5RrL8dlut9Kh2t/D0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571616217;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fn7GmEww2gpSYqsaWCHP9MpM9RYXjoGDEsfbpreh0T0=; 
 b=mTCY0LbX2aMXeV8fXUOmwyfIJCS9yHe0PYeo7kGpihoZ4RiznlZgR17hwggE1/vkxC9RtCQVMLpLWxTDFzDXTuk8nSveWctZYQ1fmbmk4R1i6ewGq0O9lnlH2l4y1BVxWQCGsvFePcnL7MZIczQriWCwqLbXBavoSv0NW0ZAUC0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571616216340740.5402175982862;
 Sun, 20 Oct 2019 17:03:36 -0700 (PDT)
In-Reply-To: <20191020225650.3671-1-philmd@redhat.com>
Subject: Re: [PATCH 00/21] hw: Let the machine be the owner of the system
 memory
Message-ID: <157161621211.24734.2944105976047321291@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Sun, 20 Oct 2019 17:03:36 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: pburton@wavecomp.com, jan.kiszka@web.de, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, edgar.iglesias@gmail.com, robh@kernel.org,
 andrew.smirnov@gmail.com, deller@gmx.de, mst@redhat.com, armbru@redhat.com,
 hpoussin@reactos.org, antonynpavlov@gmail.com, aleksandar.rikalo@rt-rk.com,
 david@gibson.dropbear.id.au, philmd@redhat.com, atar4qemu@gmail.com,
 joel@jms.id.au, ehabkost@redhat.com, alistair@alistair23.me,
 leif.lindholm@linaro.org, b.galvani@gmail.com, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, chouteau@adacore.com, pbonzini@redhat.com,
 rth@twiddle.net, radoslaw.biernacki@linaro.org, huth@tuxfamily.org,
 Andrew.Baumann@microsoft.com, jcd@tribudubois.net, andrew@aj.id.au,
 michael@walle.cc, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 imammedo@redhat.com, aurelien@aurel32.net, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMDIyNTY1MC4zNjcx
LTEtcGhpbG1kQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwMC8yMV0gaHc6IExldCB0aGUgbWFjaGluZSBiZSB0
aGUgb3duZXIgb2YgdGhlIHN5c3RlbSBtZW1vcnkKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIw
MTkxMDIwMjI1NjUwLjM2NzEtMS1waGlsbWRAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMjNiNGU5
YSBody9jb3JlOiBBc3NlcnQgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fbWVtb3J5IGhh
cyBtYWNoaW5lIG93bmVyCjY3Y2FhZjAgaHcvc3BhcmM6IExldCB0aGUgbWFjaGluZSBiZSB0aGUg
b3duZXIgb2YgdGhlIHN5c3RlbSBtZW1vcnkKOTYxMGQ2OSBody9wcGM6IExldCB0aGUgbWFjaGlu
ZSBiZSB0aGUgb3duZXIgb2YgdGhlIHN5c3RlbSBtZW1vcnkKM2NmMGM1NSBody9taXBzOiBMZXQg
dGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5CmM2Y2Q0ODYgaHcv
bTY4azogTGV0IHRoZSBtYWNoaW5lIGJlIHRoZSBvd25lciBvZiB0aGUgc3lzdGVtIG1lbW9yeQpk
ZDhlOWE2IGh3L2xtMzI6IExldCB0aGUgbWFjaGluZSBiZSB0aGUgb3duZXIgb2YgdGhlIHN5c3Rl
bSBtZW1vcnkKYzdiOWNjZCBody9pMzg2OiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9m
IHRoZSBzeXN0ZW0gbWVtb3J5CjY1NTE4MmYgaHcvaHBwYTogTGV0IHRoZSBtYWNoaW5lIGJlIHRo
ZSBvd25lciBvZiB0aGUgc3lzdGVtIG1lbW9yeQoyMGRjNjIyIGh3L2NyaXM6IExldCB0aGUgbWFj
aGluZSBiZSB0aGUgb3duZXIgb2YgdGhlIHN5c3RlbSBtZW1vcnkKZmMzYzZkMiBody9hcm06IExl
dCB0aGUgbWFjaGluZSBiZSB0aGUgb3duZXIgb2YgdGhlIHN5c3RlbSBtZW1vcnkKZTlmMWViYyBo
dy9hbHBoYTogTGV0IHRoZSBtYWNoaW5lIGJlIHRoZSBvd25lciBvZiB0aGUgc3lzdGVtIG1lbW9y
eQozZWYxMTFiIGh3L2NvcmU6IExldCB0aGUgbWFjaGluZSBiZSB0aGUgb3duZXIgb2YgdGhlIHN5
c3RlbSBtZW1vcnkKMzFiZDgzOCBodzogTGV0IG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVt
X21lbW9yeSB0YWtlIE1hY2hpbmVTdGF0ZSBhcmd1bWVudApkYWU5ZDExIGh3L2FscGhhL2RwMjY0
OiBDcmVhdGUgdGhlIFJBTSBpbiB0aGUgYm9hcmQKYzMxZWJhMCBodzogRHJvcCBRT00gb3duZXJz
aGlwIG9uIG1lbW9yeV9yZWdpb25fYWxsb2NhdGVfc3lzdGVtX21lbW9yeSgpIGNhbGxzCjcyOGFh
NjUgaHcvYXJtL2RpZ2ljNDogSW5saW5lIGRpZ2ljNF9ib2FyZF9zZXR1cF9yYW0oKSBmdW5jdGlv
bgpjMmE5MDUyIGh3L2FybS9vbWFwMTogQ3JlYXRlIHRoZSBSQU0gaW4gdGhlIGJvYXJkCjRmNDk3
N2YgaHcvYXJtL29tYXAyOiBDcmVhdGUgdGhlIFJBTSBpbiB0aGUgYm9hcmQKZDE5NTliMiBody9h
cm0vY29sbGllOiBDcmVhdGUgdGhlIFJBTSBpbiB0aGUgYm9hcmQKODE1ZjVjMSBody9hcm0vbXBz
MjogVXNlIHRoZSBJRUMgYmluYXJ5IHByZWZpeCBkZWZpbml0aW9ucwoxMDMxOTBmIGh3L2FybS94
aWxpbnhfenlucTogVXNlIHRoZSBJRUMgYmluYXJ5IHByZWZpeCBkZWZpbml0aW9ucwoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS8yMSBDaGVja2luZyBjb21taXQgMTAzMTkwZmQ5YjI4IChody9hcm0v
eGlsaW54X3p5bnE6IFVzZSB0aGUgSUVDIGJpbmFyeSBwcmVmaXggZGVmaW5pdGlvbnMpCjIvMjEg
Q2hlY2tpbmcgY29tbWl0IDgxNWY1YzE2NjkyNCAoaHcvYXJtL21wczI6IFVzZSB0aGUgSUVDIGJp
bmFyeSBwcmVmaXggZGVmaW5pdGlvbnMpCjMvMjEgQ2hlY2tpbmcgY29tbWl0IGQxOTU5YjJkM2U0
OSAoaHcvYXJtL2NvbGxpZTogQ3JlYXRlIHRoZSBSQU0gaW4gdGhlIGJvYXJkKQo0LzIxIENoZWNr
aW5nIGNvbW1pdCA0ZjQ5NzdmYTgyMDUgKGh3L2FybS9vbWFwMjogQ3JlYXRlIHRoZSBSQU0gaW4g
dGhlIGJvYXJkKQo1LzIxIENoZWNraW5nIGNvbW1pdCBjMmE5MDUyNGJkMzMgKGh3L2FybS9vbWFw
MTogQ3JlYXRlIHRoZSBSQU0gaW4gdGhlIGJvYXJkKQo2LzIxIENoZWNraW5nIGNvbW1pdCA3Mjhh
YTY1NjcyZjQgKGh3L2FybS9kaWdpYzQ6IElubGluZSBkaWdpYzRfYm9hcmRfc2V0dXBfcmFtKCkg
ZnVuY3Rpb24pCjcvMjEgQ2hlY2tpbmcgY29tbWl0IGMzMWViYTBkMDI1YiAoaHc6IERyb3AgUU9N
IG93bmVyc2hpcCBvbiBtZW1vcnlfcmVnaW9uX2FsbG9jYXRlX3N5c3RlbV9tZW1vcnkoKSBjYWxs
cykKOC8yMSBDaGVja2luZyBjb21taXQgZGFlOWQxMTFhY2IxIChody9hbHBoYS9kcDI2NDogQ3Jl
YXRlIHRoZSBSQU0gaW4gdGhlIGJvYXJkKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0
aGF0ICcqJyAoY3R4Old4VikKIzI0OiBGSUxFOiBody9hbHBoYS9hbHBoYV9zeXMuaDoxMzoKK1BD
SUJ1cyAqdHlwaG9vbl9pbml0KElTQUJ1cyAqKiwgcWVtdV9pcnEgKiwgQWxwaGFDUFUgKls0XSwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1OSBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzIx
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo5LzIxIENoZWNraW5nIGNvbW1pdCAzMWJkODM4
ZDJkNzkgKGh3OiBMZXQgbWVtb3J5X3JlZ2lvbl9hbGxvY2F0ZV9zeXN0ZW1fbWVtb3J5IHRha2Ug
TWFjaGluZVN0YXRlIGFyZ3VtZW50KQoxMC8yMSBDaGVja2luZyBjb21taXQgM2VmMTExYjZhNjJh
IChody9jb3JlOiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVt
b3J5KQoxMS8yMSBDaGVja2luZyBjb21taXQgZTlmMWViY2IxNjI0IChody9hbHBoYTogTGV0IHRo
ZSBtYWNoaW5lIGJlIHRoZSBvd25lciBvZiB0aGUgc3lzdGVtIG1lbW9yeSkKMTIvMjEgQ2hlY2tp
bmcgY29tbWl0IGZjM2M2ZDIzYjYzZiAoaHcvYXJtOiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93
bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5KQoxMy8yMSBDaGVja2luZyBjb21taXQgMjBkYzYyMmMx
ZGYzIChody9jcmlzOiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0g
bWVtb3J5KQoxNC8yMSBDaGVja2luZyBjb21taXQgNjU1MTgyZjZlNzRhIChody9ocHBhOiBMZXQg
dGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5KQoxNS8yMSBDaGVj
a2luZyBjb21taXQgYzdiOWNjZGE3NDQyIChody9pMzg2OiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhl
IG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5KQoxNi8yMSBDaGVja2luZyBjb21taXQgZGQ4ZTlh
NjZjMWYwIChody9sbTMyOiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0
ZW0gbWVtb3J5KQoxNy8yMSBDaGVja2luZyBjb21taXQgYzZjZDQ4NjZkNmEwIChody9tNjhrOiBM
ZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5KQoxOC8yMSBD
aGVja2luZyBjb21taXQgM2NmMGM1NWZjYzFiIChody9taXBzOiBMZXQgdGhlIG1hY2hpbmUgYmUg
dGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5KQoxOS8yMSBDaGVja2luZyBjb21taXQgOTYx
MGQ2OTA4Y2JjIChody9wcGM6IExldCB0aGUgbWFjaGluZSBiZSB0aGUgb3duZXIgb2YgdGhlIHN5
c3RlbSBtZW1vcnkpCjIwLzIxIENoZWNraW5nIGNvbW1pdCA2N2NhYWYwNTAxOWIgKGh3L3NwYXJj
OiBMZXQgdGhlIG1hY2hpbmUgYmUgdGhlIG93bmVyIG9mIHRoZSBzeXN0ZW0gbWVtb3J5KQoyMS8y
MSBDaGVja2luZyBjb21taXQgMjNiNGU5YTUyMzE4IChody9jb3JlOiBBc3NlcnQgbWVtb3J5X3Jl
Z2lvbl9hbGxvY2F0ZV9zeXN0ZW1fbWVtb3J5IGhhcyBtYWNoaW5lIG93bmVyKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyMDIyNTY1MC4z
NjcxLTEtcGhpbG1kQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


