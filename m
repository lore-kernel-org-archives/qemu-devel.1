Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE6CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441A32064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441A32064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMb8y-0003uC-Ey
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMb68-0000QQ-2w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMb66-0003hr-3d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:03:59 -0400
Resent-Date: Mon, 21 Oct 2019 13:03:59 -0400
Resent-Message-Id: <E1iMb66-0003hr-3d@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMb60-0003dM-6s; Mon, 21 Oct 2019 13:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571677418; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Qc+UmjQUtpPsk0lsNxoAE0Xw/eUe5MUYWbMYgLaBk37RDCSVXF0WBK7nfq03ENAB+C3MK5Y91iaGDvQp1vPChPSCdPFl8CFbp+thvJfytEQgsAuHgvnMtF/P4hYiQTf2IeBX3hDenZc7dBKm4vZDVAlryVXvOf/pjm+p9tWO9DI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571677418;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=x8PhomlkcZdsfUe1Qix0job82w2xWEuKybRDOwGwbdU=; 
 b=fTb1kcHatiKIEZdV1x4xE4ke4Gi+TzNLlsdZ/d4iPfsrUHe8X5Lm0p+TfBltTbJWxJhJsYuBoF6jMYY9BwKqV/3RoGLzumlfLZfCqi3HJ1b+c/oH3gAD3nejbv8n6odY69G00S80T6r6YL8z2c7WF+Z0OT77JrAO2zyGPIiRACs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157167741687699.73257232055425;
 Mon, 21 Oct 2019 10:03:36 -0700 (PDT)
In-Reply-To: <20191021105350.1710-1-thuth@redhat.com>
Subject: Re: [PATCH v2 0/6] Enable more iotests during "make check-block"
Message-ID: <157167741552.7343.12701515937803148890@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 21 Oct 2019 10:03:36 -0700 (PDT)
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMTEwNTM1MC4xNzEw
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAvNl0gRW5hYmxlIG1vcmUgaW90ZXN0cyBkdXJp
bmcgIm1ha2UgY2hlY2stYmxvY2siClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAyMTEw
NTM1MC4xNzEwLTEtdGh1dGhAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKZmF0YWw6IGdpdCBmZXRjaF9wYWNrOiBleHBlY3RlZCBBQ0svTkFLLCBnb3QgJ0VSUiB1cGxv
YWQtcGFjazogbm90IG91ciByZWYgYTRlN2YzOWMzYTlmMmViN2U1ZmRjYTZiZmE2YWJiODJlMTJl
ZTQyYicKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5CmVycm9yOiBD
b3VsZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIv
c3JjL3BhdGNoZXctY2xpIiwgbGluZSA1MjEsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVw
byhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YsIFRydWUpCiAgRmlsZSAicGF0Y2hl
dy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA0OCwgaW4gZ2l0X2Nsb25lX3JlcG8KICAg
IHN0ZG91dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIvb3B0L3JoL3JoLXB5dGhvbjM2L3Jv
b3QvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5IiwgbGluZSAyOTEsIGluIGNoZWNr
X2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nl
c3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdyZW1vdGUnLCAnYWRkJywg
Jy1mJywgJy0tbWlycm9yPWZldGNoJywgJzNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQnLCAnaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11J10nIHJl
dHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEuCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMjExMDUzNTAuMTcxMC0xLXRodXRo
QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


