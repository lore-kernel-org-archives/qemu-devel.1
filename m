Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39FBC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A0920725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 03:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A0920725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtwF-0005c0-Tf
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 23:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWtvE-0004J4-Pe; Thu, 07 May 2020 23:43:36 -0400
Resent-Date: Thu, 07 May 2020 23:43:36 -0400
Resent-Message-Id: <E1jWtvE-0004J4-Pe@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWtvD-00062I-3U; Thu, 07 May 2020 23:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588909389; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YDFMfbgyO8sk60OLEOlchy3b18BGjXkit0fhOZ288ICGqnW8YYeqjAfKhBGZxIQpmHbzZEXBjriN1u3X20mmpGiPOy+IbGJJLRkhuGrznR6zDPob1VydDxMjM9+ZNXhJf2SZ+Pe0VHcCwc4f3sMLX+Ra3twbRNEpaMH9rUw+BPA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588909389;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oRg71rOzN2sAtTx2yd828EvyTMnBcPMu0Q7Ik0aLxTI=; 
 b=XegOHduWdhoajNLHsZTWMFHdzi6cPic+SK+4gHMc+RlGkXi+/Ep54jIJrsShTA/3u92mxH6N51fsS7M0oCQ3VzEtb6eDmNCDxG9OXbx5VcAaFod1WhwcbTrfiyBMoYQbyPNZr5HAXpBZesEshPqaagCy8dbLztICn1EEQ0R4T2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588909387965591.4173727118624;
 Thu, 7 May 2020 20:43:07 -0700 (PDT)
Message-ID: <158890938646.29923.2870364451732664506@45ef0f9c86ae>
In-Reply-To: <20200507114824.788942-1-npiggin@gmail.com>
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: npiggin@gmail.com
Date: Thu, 7 May 2020 20:43:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 23:43:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNzExNDgyNC43ODg5
NDItMS1ucGlnZ2luQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MDcxMTQ4MjQuNzg4OTQyLTEtbnBpZ2dpbkBn
bWFpbC5jb20KU3ViamVjdDogW1BBVENIXSBwcGMvcG52OiBGaXggTk1JIHN5c3RlbSByZXNldCBT
UlIxIHZhbHVlClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpmYmU3MmNiIHBwYy9wbnY6IEZpeCBOTUkgc3lz
dGVtIHJlc2V0IFNSUjEgdmFsdWUKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBjb2RlIGlu
ZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzM1OiBGSUxFOiBody9wcGMvcG52LmM6MTk5MToK
K15JICogUG93ZXItc2F2ZSB3YWtldXBzLCBhcyBpbmRpY2F0ZWQgYnkgbm9uLXplcm8gU1JSMVs0
Njo0N10gcHV0IHRoZSQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzM2OiBGSUxFOiBody9wcGMvcG52LmM6MTk5MjoKK15JICogd2FrZXVwIHJlYXNvbiBpbiBTUlIx
WzQyOjQ1XSwgc3lzdGVtIHJlc2V0IGlzIGluZGljYXRlZCB3aXRoIDBiMDEwMCQKCkVSUk9SOiBj
b2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzM3OiBGSUxFOiBody9wcGMvcG52LmM6
MTk5MzoKK15JICogKFBQQ19CSVQoNDMpKS4kCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMzODogRklMRTogaHcvcHBjL3Budi5jOjE5OTQ6CiteSSAqLyQKCkVSUk9S
OiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNDA6IEZJTEU6IGh3L3BwYy9wbnYuYzoxOTk2Ogor
ICAgICAgICAgICAgd2Fybl9yZXBvcnQoInBwY19jcHVfZG9fc3lzdGVtX3Jlc2V0IGRvZXMgbm90
IHNldCBzeXN0ZW0gcmVzZXQgd2FrZXVwIHJlYXNvbiIpOwoKRVJST1I6IGNvZGUgaW5kZW50IHNo
b3VsZCBuZXZlciB1c2UgdGFicwojNDU6IEZJTEU6IGh3L3BwYy9wbnYuYzoyMDAxOgorXkkgKiBG
b3Igbm9uLXBvd2Vyc2F2ZSBzeXN0ZW0gcmVzZXRzLCBTUlIxWzQyOjQ1XSBhcmUgZGVmaW5lZCB0
byBiZSQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzQ2OiBGSUxF
OiBody9wcGMvcG52LmM6MjAwMjoKK15JICogaW1wbGVtZW50YXRpb24tZGVwZW5kZW50LiBUaGUg
UE9XRVI5IFVzZXIgTWFudWFsIHNwZWNpZmllcyB0aGF0JAoKRVJST1I6IGNvZGUgaW5kZW50IHNo
b3VsZCBuZXZlciB1c2UgdGFicwojNDc6IEZJTEU6IGh3L3BwYy9wbnYuYzoyMDAzOgorXkkgKiBh
biBleHRlcm5hbCAoU0NPTSBkcml2ZW4sIHdoaWNoIG1heSBjb21lIGZyb20gYSBCTUMgbm1pIGNv
bW1hbmQgb3IkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0ODog
RklMRTogaHcvcHBjL3Budi5jOjIwMDQ6CiteSSAqIGFub3RoZXIgQ1BVIHJlcXVlc3RpbmcgYSBO
TUkgSVBJKSBzeXN0ZW0gcmVzZXQgZXhjZXB0aW9uIHNob3VsZCBiZSQKCkVSUk9SOiBjb2RlIGlu
ZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzQ5OiBGSUxFOiBody9wcGMvcG52LmM6MjAwNToK
K15JICogMGIwMDEwIChQUENfQklUKDQ0KSkuJAoKdG90YWw6IDEwIGVycm9ycywgMCB3YXJuaW5n
cywgMzIgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGZiZTcyY2I5ZDQ2NSAocHBjL3BudjogRml4IE5N
SSBzeXN0ZW0gcmVzZXQgU1JSMSB2YWx1ZSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDcx
MTQ4MjQuNzg4OTQyLTEtbnBpZ2dpbkBnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

