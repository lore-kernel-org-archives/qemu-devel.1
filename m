Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD7EC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03883206C0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03883206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRaa-0000do-7u
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:21:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hCRZE-0008OK-FW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hCRZ8-00045n-L0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:19:46 -0400
Resent-Date: Fri, 05 Apr 2019 12:19:44 -0400
Resent-Message-Id: <E1hCRZ8-00045n-L0@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hCRYX-0003CJ-Rq
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:19:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554481107; cv=none; d=zoho.com; s=zohoarc; 
	b=V1BPKD8qZn7zV64nSHkGF5a03Ephtot4X1mie01sZTYAWseMl73pCl5ikOawCRz16ADbGcEhYZtvQzIgh4ZKbH2NMmN2K2bcOKzt1Z+zjzvDw4SvcajRYrf1PI3MlF+uPRskhjpsb4dzTmdd/aseMomIU8wi2/EqSmq1DfVN3pM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554481107;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=5DqbwDGhR0C60/Qp5/AahmBibT/aKTfkXooPqFAZYW8=; 
	b=Ma1s+V6fi0WyuynVp2AIU1zK6jCxSfsUfNbYYDFXpwKwTcSWUF9gkiU/LfRdTxhAE04Rh9zHPM3Dz0B9biqtJgycvb4Gw9c0/43qOhSqCrlPk9RQUau0+lAJDZN7urtbIAanphoILmLgFXCWTH/QPwHk2KQYQJ699d7aOt8m0+k=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554481102531886.8267797551797;
	Fri, 5 Apr 2019 09:18:22 -0700 (PDT)
Message-ID: <155448110124.12882.11234669806783181642@76452e4e88f2>
In-Reply-To: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jbi.octave@gmail.com
Date: Fri, 5 Apr 2019 09:18:22 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/4] target/mips: errors and warnings
 cleanups
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
Cc: fam@euphon.net, arikalo@wavecomp.com, qemu-devel@nongnu.org,
	amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405161822.-WzefkLkUN5VsRGtr1B0OSUDr55bAssNXGmjoLnSdco@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwNTE2MDkzOC4yNzQ5
NC0xLWpiaS5vY3RhdmVAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDQwNTE2MDkzOC4yNzQ5NC0xLWpiaS5vY3Rh
dmVAZ21haWwuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjMgMC80XSB0YXJnZXQv
bWlwczogZXJyb3JzIGFuZCB3YXJuaW5ncyBjbGVhbnVwcwpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MDUxNjA5
MzguMjc0OTQtMS1qYmkub2N0YXZlQGdtYWlsLmNvbSAtPiBwYXRjaGV3LzIwMTkwNDA1MTYwOTM4
LjI3NDk0LTEtamJpLm9jdGF2ZUBnbWFpbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo2OGEzM2NhMjFmIHRhcmdldC9taXBzOiByZXBsYWNlIHRhYiBjb2RlIGluZGVudCB3aXRo
IHNwYWNlcyB0byBmaXggY2hlY2twYXRjaCBlcnJvcnMKNTIyNjgwNTUwMCB0YXJnZXQvbWlwczog
d3JhcCBsaW5lcyB0byBmaXggY2hlY2twYXRjaCBlcnJvcnMKYzQzNWJhMGRmMiB0YXJnZXQvbWlw
czogYWRkIG9yIHJlbW92ZSBzcGFjZSB0byBmaXggY2hlY2twYXRjaCBlcnJvcnMKZWZiNDBjZjkx
ZiB0YXJnZXQvbWlwczogcmVhbGlnbiBjb21tZW50cyB0byBmaXggY2hlY2twYXRjaCB3YXJuaW5n
cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCBlZmI0MGNmOTFmNjcg
KHRhcmdldC9taXBzOiByZWFsaWduIGNvbW1lbnRzIHRvIGZpeCBjaGVja3BhdGNoIHdhcm5pbmdz
KQoyLzQgQ2hlY2tpbmcgY29tbWl0IGM0MzViYTBkZjIxNSAodGFyZ2V0L21pcHM6IGFkZCBvciBy
ZW1vdmUgc3BhY2UgdG8gZml4IGNoZWNrcGF0Y2ggZXJyb3JzKQpFUlJPUjogbGluZSBvdmVyIDkw
IGNoYXJhY3RlcnMKIzQyOiBGSUxFOiB0YXJnZXQvbWlwcy9jcHUuaDo3NToKKyNkZWZpbmUgU0VU
X0ZQX0NPTkQobnVtLCBlbnYpICAgICBkbyB7ICgoZW52KS5mY3IzMSkgfD0gKChudW0pID8gKDEg
PDwgKChudW0pICsgMjQpKSA6ICgxIDw8IDIzKSk7IH0gd2hpbGUgKDApCgpFUlJPUjogbGluZSBv
dmVyIDkwIGNoYXJhY3RlcnMKIzQzOiBGSUxFOiB0YXJnZXQvbWlwcy9jcHUuaDo3NjoKKyNkZWZp
bmUgQ0xFQVJfRlBfQ09ORChudW0sIGVudikgICBkbyB7ICgoZW52KS5mY3IzMSkgJj0gfigobnVt
KSA/ICgxIDw8ICgobnVtKSArIDI0KSkgOiAoMSA8PCAyMykpOyB9IHdoaWxlICgwKQoKRVJST1I6
IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1MjogRklMRTogdGFyZ2V0L21pcHMvY3B1Lmg6ODE6
CisjZGVmaW5lIFNFVF9GUF9DQVVTRShyZWcsIHYpICAgICAgZG8geyAocmVnKSA9ICgocmVnKSAm
IH4oMHgzZiA8PCAxMikpIHwgKCh2ICYgMHgzZikgPDwgMTIpOyB9IHdoaWxlICgwKQoKRVJST1I6
IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1MzogRklMRTogdGFyZ2V0L21pcHMvY3B1Lmg6ODI6
CisjZGVmaW5lIFNFVF9GUF9FTkFCTEUocmVnLCB2KSAgICAgZG8geyAocmVnKSA9ICgocmVnKSAm
IH4oMHgxZiA8PCAgNykpIHwgKCh2ICYgMHgxZikgPDwgNyk7IH0gd2hpbGUgKDApCgpFUlJPUjog
bGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU0OiBGSUxFOiB0YXJnZXQvbWlwcy9jcHUuaDo4MzoK
KyNkZWZpbmUgU0VUX0ZQX0ZMQUdTKHJlZywgdikgICAgICBkbyB7IChyZWcpID0gKChyZWcpICYg
figweDFmIDw8ICAyKSkgfCAoKHYgJiAweDFmKSA8PCAyKTsgfSB3aGlsZSAoMCkKCnRvdGFsOiA1
IGVycm9ycywgMCB3YXJuaW5ncywgNjggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi80IGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgozLzQgQ2hlY2tpbmcgY29tbWl0IDUyMjY4MDU1MDBlYyAodGFy
Z2V0L21pcHM6IHdyYXAgbGluZXMgdG8gZml4IGNoZWNrcGF0Y2ggZXJyb3JzKQo0LzQgQ2hlY2tp
bmcgY29tbWl0IDY4YTMzY2EyMWY2MSAodGFyZ2V0L21pcHM6IHJlcGxhY2UgdGFiIGNvZGUgaW5k
ZW50IHdpdGggc3BhY2VzIHRvIGZpeCBjaGVja3BhdGNoIGVycm9ycykKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MDUxNjA5MzguMjc0OTQt
MS1qYmkub2N0YXZlQGdtYWlsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


