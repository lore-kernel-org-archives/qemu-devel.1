Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D798C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AF1207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AF1207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorO5-0006iV-OP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jorJO-00079d-2N
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:34:46 -0400
Resent-Date: Fri, 26 Jun 2020 12:34:46 -0400
Resent-Message-Id: <E1jorJO-00079d-2N@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jorJK-0004sE-98
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 12:34:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593189270; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YLv8AcwpHc0UqoI39QZGGl1/9h3SD3GwZ0dgel2WjuYiqqR5WN8yaYBpsrVomtT+4RqTKYqLPUhNIbr3MBy48CxU8ydteiS31j+b84gHGyK4dsFAp293JeoG4sJMnuNts+jJe1WbcMmwCYLAbFkbMguWd2zl6IDCVBKuTUl7cb8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593189270;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=v38oQLpMogAXielcbiSJWfPMnOPrzcRY8f3K+r4wfzk=; 
 b=KY6XyhVcLJWI3wjeTBK0/GmTUXa3CU1UM2WXmKDYWI/b6fCR2e96sfGk5/VLRgbnjLU/k0EE4UMp/feCoaQYInfgMK+8V28rAxnm5k1nsIZLanNnvgYKvJ01VdM2TvAXnR9KBsHDjXOcxaIFm/cKIsjKzujxMry6bMSsI8NF7t4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593189266781262.608807512598;
 Fri, 26 Jun 2020 09:34:26 -0700 (PDT)
Message-ID: <159318926545.28361.4987154757127294444@d1fd068a5071>
Subject: Re: [PATCH v2 0/3] trace: Add a trace backend for the recorder library
In-Reply-To: <20200626162706.3304357-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dinechin@redhat.com
Date: Fri, 26 Jun 2020 09:34:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 12:34:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: armbru@redhat.com, mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNjE2MjcwNi4zMzA0
MzU3LTEtZGluZWNoaW5AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAvM10gdHJhY2U6IEFkZCBhIHRyYWNl
IGJhY2tlbmQgZm9yIHRoZSByZWNvcmRlciBsaWJyYXJ5ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlk
OiAyMDIwMDYyNjE2MjcwNi4zMzA0MzU3LTEtZGluZWNoaW5AcmVkaGF0LmNvbQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9q
ZWN0L3FlbXUKICAgMTBmN2ZmYS4uODdmYjk1MiAgbWFzdGVyICAgICAtPiBtYXN0ZXIKIC0gW3Rh
ZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDYyNjE1MTQyNC4zMDExNy0xLXBldGVyLm1heWRl
bGxAbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIwMjAwNjI2MTUxNDI0LjMwMTE3LTEtcGV0ZXIubWF5
ZGVsbEBsaW5hcm8ub3JnCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA2MjYxNjI3
MDYuMzMwNDM1Ny0xLWRpbmVjaGluQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDYyNjE2Mjcw
Ni4zMzA0MzU3LTEtZGluZWNoaW5AcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCjg1MGJlZDUgdHJhY2U6IEV4YW1wbGUgb2YgImNlbnRyYWxpemVkIiByZWNvcmRlciB0
cmFjaW5nCjFmOWE4ZGEgdHJhY2U6IEFkZCBzdXBwb3J0IGZvciByZWNvcmRlciBiYWNrLWVuZAo3
NmRkN2M2IE1ha2VmaWxlOiBDb21wdXRlIGxpYnJhcmllcyBmb3IgbGlicWVtdXV0aWwuYSBhbmQg
bGlidmhvc3QtdXNlci5hCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0
IDc2ZGQ3YzY3ZmU1ZSAoTWFrZWZpbGU6IENvbXB1dGUgbGlicmFyaWVzIGZvciBsaWJxZW11dXRp
bC5hIGFuZCBsaWJ2aG9zdC11c2VyLmEpCjIvMyBDaGVja2luZyBjb21taXQgMWY5YThkYWVhNmVi
ICh0cmFjZTogQWRkIHN1cHBvcnQgZm9yIHJlY29yZGVyIGJhY2stZW5kKQpXQVJOSU5HOiBhZGRl
ZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRp
bmc/CiMxMzA6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNo
YXJhY3RlcnMKIzE4MjogRklMRTogc2NyaXB0cy90cmFjZXRvb2wvYmFja2VuZC9yZWNvcmRlci5w
eTo0ODoKKyAgICAgICAgb3V0KCdSRUNPUkRFUl9ERUZJTkUoJShuYW1lKXMsIDgsICJUcmFjZXRv
b2wgcmVjb3JkZXIgZm9yICUoYXBpKXMoJShhcmdzKXMpIik7JywKCkVSUk9SOiBkbyBub3QgdXNl
IEM5OSAvLyBjb21tZW50cwojMjQ3OiBGSUxFOiB0cmFjZS9yZWNvcmRlci5jOjE4OgorICAgIC8v
IEFsbG93IGEgZHVtcCBpbiBjYXNlIHdlIHJlY2VpdmUgc29tZSB1bmhhbmRsZWQgc2lnbmFsCgpF
UlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzI0ODogRklMRTogdHJhY2UvcmVjb3Jk
ZXIuYzoxOToKKyAgICAvLyBGb3IgZXhhbXBsZSwgc2VuZCBVU1IyIHRvIGEgaHVuZyBwcm9jZXNz
IHRvIGdldCBhIGR1bXAKCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFy
bXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzI0OTogRklMRTogdHJhY2UvcmVjb3JkZXIuYzoyMDoKKyAg
ICBpZiAoZ2V0ZW52KCJSRUNPUkRFUl9UUkFDRVMiKSkKWy4uLl0KCkVSUk9SOiBzcGFjZSByZXF1
aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzI1MDogRklMRTogdHJhY2UvcmVjb3JkZXIu
YzoyMToKKyAgICAgICAgcmVjb3JkZXJfZHVtcF9vbl9jb21tb25fc2lnbmFscygwLDApOwogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogZG8gbm90IHVz
ZSBDOTkgLy8gY29tbWVudHMKIzI4MTogRklMRTogdHJhY2UvcmVjb3JkZXIuaDoyNDoKKy8vIERp
c2FibGUgcmVjb3JkZXIgbWFjcm9zCgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMK
IzI4OTogRklMRTogdHJhY2UvcmVjb3JkZXIuaDozMjoKKyNlbmRpZiAvLyBDT05GSUdfVFJBQ0Vf
UkVDT1JERVIKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMjkxOiBGSUxFOiB0
cmFjZS9yZWNvcmRlci5oOjM0OgorI2VuZGlmIC8vIFRSQUNFX1JFQ09SREVSX0gKCkVSUk9SOiBk
byBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMzEyOiBGSUxFOiB1dGlsL21vZHVsZS5jOjE1ODoK
KyAgICAgICAgLy8gTmV3IHJlY29yZGVycyBtYXkgaGF2ZSBiZWVuIHB1bGxlZCBpbiwgYWN0aXZh
dGUgdGhlbSBpZiBuZWNlc3NhcnkKCnRvdGFsOiA4IGVycm9ycywgMiB3YXJuaW5ncywgMjM3IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8zIENo
ZWNraW5nIGNvbW1pdCA4NTBiZWQ1MjNlNjMgKHRyYWNlOiBFeGFtcGxlIG9mICJjZW50cmFsaXpl
ZCIgcmVjb3JkZXIgdHJhY2luZykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA2MjYxNjI3MDYuMzMwNDM1Ny0xLWRpbmVjaGluQHJlZGhhdC5j
b20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

