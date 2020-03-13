Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D70C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C82206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C82206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmir-0004YI-JY
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCmi3-00048P-W7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCmi2-0004Vr-2G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:58:51 -0400
Resent-Date: Fri, 13 Mar 2020 11:58:51 -0400
Resent-Message-Id: <E1jCmi2-0004Vr-2G@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCmi1-0004EB-QS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584115112; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LOIQ+6PXj1Y2WuxmbGWuFJhvnvfCXnCgO47pR65Wx7kACoCPzBANur/ECNPUdsA9I83OGEMk+Bd9TTWNZsmJewldx9ntAJ4D82Uzp5aftzeYxdTCgVKU8ibbmePNZCtGsbpdmdasYHMPWfMW8zeb1iwtRYnz7nhAfFVKvNVqECI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584115112;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TVxEMwsY4DhqBHIChRhVi7c1d1hdxjO75f/4GhADQ/s=; 
 b=Ci24CsmCUgr8m7OR4uHklqEv61P13COyEJWHSbQwSqgTmaUxqY6txHFxv3TirRsK9C0FHgi87uf9oCBXN4WFScd+vFI+eK+nSikAoHiOXml4EDWUy6inrUJKWF7hzgWpvzfMrLdFBnDDYZGEasq6zSoj9Ond8BA3XEjmqwlZNVo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584115110089173.95595230830554;
 Fri, 13 Mar 2020 08:58:30 -0700 (PDT)
In-Reply-To: <20200313145009.144820-1-liran.alon@oracle.com>
Subject: Re: [PATCH v2 0/3]: acpi: Add Windows ACPI Emulated Device Table
 (WAET)
Message-ID: <158411510863.16773.11681485784155170393@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Fri, 13 Mar 2020 08:58:30 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMzE0NTAwOS4xNDQ4
MjAtMS1saXJhbi5hbG9uQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MiAwLzNdOiBhY3BpOiBBZGQgV2luZG93
cyBBQ1BJIEVtdWxhdGVkIERldmljZSBUYWJsZSAoV0FFVCkKTWVzc2FnZS1pZDogMjAyMDAzMTMx
NDUwMDkuMTQ0ODIwLTEtbGlyYW4uYWxvbkBvcmFjbGUuY29tClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwpl
OTEyOWZiIGFjcGk6IHVuaXQtdGVzdDogVXBkYXRlIFdBRVQgQUNQSSBUYWJsZSBleHBlY3RlZCBi
aW5hcmllcwo3NmVhYTdhIGFjcGk6IEFkZCBXaW5kb3dzIEFDUEkgRW11bGF0ZWQgRGV2aWNlIFRh
YmxlIChXQUVUKQowNDFkZmFlIGFjcGk6IHVuaXQtdGVzdDogSWdub3JlIGRpZmYgaW4gV0FFVCBB
Q1BJIHRhYmxlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IDA0MWRm
YWVmZDM3ZSAoYWNwaTogdW5pdC10ZXN0OiBJZ25vcmUgZGlmZiBpbiBXQUVUIEFDUEkgdGFibGUp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzE3OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVy
cm9ycywgMSB3YXJuaW5ncywgMyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzMgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KMi8zIENoZWNraW5nIGNvbW1pdCA3NmVhYTdhYzZlZjQgKGFjcGk6IEFk
ZCBXaW5kb3dzIEFDUEkgRW11bGF0ZWQgRGV2aWNlIFRhYmxlIChXQUVUKSkKRVJST1I6IGxpbmUg
b3ZlciA5MCBjaGFyYWN0ZXJzCiM0MzogRklMRTogaHcvaTM4Ni9hY3BpLWJ1aWxkLmM6MjUyMDoK
KyAqIFNwZWM6IGh0dHA6Ly9kb3dubG9hZC5taWNyb3NvZnQuY29tL2Rvd25sb2FkLzcvRS83LzdF
NzY2MkNGLUNCRUEtNDcwQi1BOTdFLUNFN0NFMEQ5OERDMi9XQUVULmRvY3gKCldBUk5JTkc6IEJs
b2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2MTogRklM
RTogaHcvaTM4Ni9hY3BpLWJ1aWxkLmM6MjUzODoKKyAgICBidWlsZF9hcHBlbmRfaW50X25vcHJl
Zml4KHRhYmxlX2RhdGEsIDEgPDwgMSAvKiBBQ1BJIFBNIHRpbWVyIGdvb2QgKi8sIDQpOwoKdG90
YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA0MyBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzMgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMyBDaGVja2luZyBjb21taXQgZTkxMjlmYmQ1Y2Yy
IChhY3BpOiB1bml0LXRlc3Q6IFVwZGF0ZSBXQUVUIEFDUEkgVGFibGUgZXhwZWN0ZWQgYmluYXJp
ZXMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwMzEzMTQ1MDA5LjE0NDgyMC0xLWxpcmFuLmFsb25Ab3JhY2xlLmNvbS90ZXN0aW5nLmNoZWNr
cGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

