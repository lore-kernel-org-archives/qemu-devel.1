Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490B6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 22:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7BA20732
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 22:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7BA20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm37d-0001QN-DC
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 18:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jm36v-0000mm-UE; Thu, 18 Jun 2020 18:34:18 -0400
Resent-Date: Thu, 18 Jun 2020 18:34:17 -0400
Resent-Message-Id: <E1jm36v-0000mm-UE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jm36t-0000Hc-B7; Thu, 18 Jun 2020 18:34:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592519630; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ico8oLyiOM7NmZgcvE2GzyDV2ptTBc95QTBMRc/WQkCgFoVkmthbnJ7g+fFbo4bZ3pYdtC5HbgI22uN6zIjdwJUMa3BVroThkTK+oKMyPI+4+smjN6QuIjI69fofu190GyMVgdF8Qzs9ucB9AfDH5QQmh8y7KfwAW5MKM/NcbSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592519630;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MAnMsBI+JOweiAiocH3edH0NOJdfcPywtGFaHO5zcn0=; 
 b=LOGDFU0N5YlcWVJhRMLQI+n0opBXj2ZKwzmQXIgQICbmdYWGJMPsNu2UCeWrwrlPxr7RLvVC7YUiibouW+Y2tIxMcQ9pNKeehUS/EUVFkbJTbTXppV8MlDoV8kFFC6IVnSVEbsF4q+ErAgV3vBhe/XgHIOKDz1P0IuC/1j2PfCI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592519628585713.6663667330832;
 Thu, 18 Jun 2020 15:33:48 -0700 (PDT)
Message-ID: <159251962664.26237.5756270018341535155@d1fd068a5071>
Subject: Re: [PATCH v3 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
In-Reply-To: <20200618222258.23287-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: walling@linux.ibm.com
Date: Thu, 18 Jun 2020 15:33:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 12:45:19
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxODIyMjI1OC4yMzI4
Ny0xLXdhbGxpbmdAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYzIDAvOF0gczM5MDogRXh0ZW5kZWQtTGVu
Z3RoIFNDQ0IgJiBESUFHTk9TRSAweDMxOApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA2
MTgyMjIyNTguMjMyODctMS13YWxsaW5nQGxpbnV4LmlibS5jb20KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2pl
Y3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNjE4MjIyMjU4LjIzMjg3
LTEtd2FsbGluZ0BsaW51eC5pYm0uY29tIC0+IHBhdGNoZXcvMjAyMDA2MTgyMjIyNTguMjMyODct
MS13YWxsaW5nQGxpbnV4LmlibS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3
YzA5OWUxIHMzOTA6IGd1ZXN0IHN1cHBvcnQgZm9yIGRpYWdub3NlIDB4MzE4CjExY2YxNzQgczM5
MC9rdm06IGhlYWRlciBzeW5jIGZvciBkaWFnMzE4Cjk4NTg0MTMgczM5MC9zY2xwOiBhZGQgZXh0
ZW5kZWQtbGVuZ3RoIHNjY2Igc3VwcG9ydCBmb3Iga3ZtIGd1ZXN0CmE4ZTYyNzQgczM5MC9zY2xw
OiB1c2UgY3B1IG9mZnNldCB0byBsb2NhdGUgY3B1IGVudHJpZXMKYjgzOTU4NyBzMzkwL3NjbHA6
IHJlYWQgc2NjYiBmcm9tIG1lbSBiYXNlZCBvbiBzY2NiIGxlbmd0aAoyZDc1NGZiIHMzOTAvc2Ns
cDogcmV3b3JrIHNjbHAgYm91bmRhcnkgYW5kIGxlbmd0aCBjaGVja3MKYTdkY2U5YSBzMzkwL3Nj
bHA6IGNoZWNrIHNjY2IgbGVuIGJlZm9yZSBmaWxsaW5nIGluIGRhdGEKZWE3MDBkNCBzMzkwL3Nj
bHA6IGdldCBtYWNoaW5lIG9uY2UgZHVyaW5nIHJlYWQgc2NwL2NwdSBpbmZvCgo9PT0gT1VUUFVU
IEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IGVhNzAwZDRkOGE0NyAoczM5MC9zY2xwOiBn
ZXQgbWFjaGluZSBvbmNlIGR1cmluZyByZWFkIHNjcC9jcHUgaW5mbykKMi84IENoZWNraW5nIGNv
bW1pdCBhN2RjZTlhMWJmMjkgKHMzOTAvc2NscDogY2hlY2sgc2NjYiBsZW4gYmVmb3JlIGZpbGxp
bmcgaW4gZGF0YSkKMy84IENoZWNraW5nIGNvbW1pdCAyZDc1NGZiYjI5ZjYgKHMzOTAvc2NscDog
cmV3b3JrIHNjbHAgYm91bmRhcnkgYW5kIGxlbmd0aCBjaGVja3MpCjQvOCBDaGVja2luZyBjb21t
aXQgYjgzOTU4N2ZjNTJhIChzMzkwL3NjbHA6IHJlYWQgc2NjYiBmcm9tIG1lbSBiYXNlZCBvbiBz
Y2NiIGxlbmd0aCkKNS84IENoZWNraW5nIGNvbW1pdCBhOGU2Mjc0Zjc4NmIgKHMzOTAvc2NscDog
dXNlIGNwdSBvZmZzZXQgdG8gbG9jYXRlIGNwdSBlbnRyaWVzKQo2LzggQ2hlY2tpbmcgY29tbWl0
IDk4NTg0MTM5MWIzNyAoczM5MC9zY2xwOiBhZGQgZXh0ZW5kZWQtbGVuZ3RoIHNjY2Igc3VwcG9y
dCBmb3Iga3ZtIGd1ZXN0KQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTE1OiBG
SUxFOiB0YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzX2RlZi5pbmMuaDoxMDA6CitERUZfRkVBVChF
WFRFTkRFRF9MRU5HVEhfU0NDQiwgImVscyIsIFNURkwsIDE0MCwgIkV4dGVuZGVkLWxlbmd0aCBT
Q0NCIGZhY2lsaXR5IikKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgODAgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggNi84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjcvOCBDaGVja2luZyBj
b21taXQgMTFjZjE3NGIzNDU1IChzMzkwL2t2bTogaGVhZGVyIHN5bmMgZm9yIGRpYWczMTgpCjgv
OCBDaGVja2luZyBjb21taXQgN2MwOTllMTFiMmJhIChzMzkwOiBndWVzdCBzdXBwb3J0IGZvciBk
aWFnbm9zZSAweDMxOCkKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxMDM6IEZJTEU6
IHRhcmdldC9zMzkweC9jcHVfZmVhdHVyZXNfZGVmLmluYy5oOjEyNToKKy8qIEZlYXR1cmVzIGV4
cG9zZWQgdmlhIFNDTFAgU0NDQiBGYWNpbGl0aWVzIGJ5dGUgMTM0IChiaXQgbnVtYmVycyByZWxh
dGl2ZSB0byBieXRlLTEzNCkgKi8KCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMx
MDQ6IEZJTEU6IHRhcmdldC9zMzkweC9jcHVfZmVhdHVyZXNfZGVmLmluYy5oOjEyNjoKK0RFRl9G
RUFUKERJQUdfMzE4LCAiZGlhZzMxOCIsIFNDTFBfRkFDMTM0LCAwLCAiQ29udHJvbCBwcm9ncmFt
IG5hbWUgYW5kIHZlcnNpb24gY29kZXMiKQoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCAx
NjEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYx
ODIyMjI1OC4yMzI4Ny0xLXdhbGxpbmdAbGludXguaWJtLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

