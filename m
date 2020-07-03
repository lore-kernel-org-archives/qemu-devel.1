Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E99C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AAF207DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AAF207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJEK-0002SA-8r
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrJDN-0001e6-LF; Fri, 03 Jul 2020 06:46:41 -0400
Resent-Date: Fri, 03 Jul 2020 06:46:41 -0400
Resent-Message-Id: <E1jrJDN-0001e6-LF@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrJDL-0006Mr-3v; Fri, 03 Jul 2020 06:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593773190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LKqsgcMsTbhOpkIkbqobQSPmhaQToJZdtn+vuaK2xNM0zdyhNnGOTuokILGoTdEYaWREZOqIZ1Eb1KWuoI3c7EU/kHaCeC2ZwhtjOrdCPiq3PzMsBdlmw6dlDJRGKtyhOm8/1QXPOJPAWv9cAkvW/De123bKYXvmaHRJrLrME98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593773190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=kfrsxgJteiFP7qWme6shDSLEb1IURs3X3GXfbOUU3Ig=; 
 b=b3n8sGqE7SV1MBhEo+qHYTMITz3amJilbjs3tr9a81VSH64iFtQbAq07ECPOZ5rmDRAeOHlVjCtbU9LiBxui2t+DAQcmfxGIkw1pM3e7PjObqTBTA4DojcNmPwQhqxRYxJmp/JSIpGQQ+h/x6J/3z59y/mdCQ7QoMxqIIqRhe9g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15937731880911011.6315925782353;
 Fri, 3 Jul 2020 03:46:28 -0700 (PDT)
Message-ID: <159377318691.13189.6290462505379040707@d1fd068a5071>
Subject: Re: [PULL 00/14] s390x update
In-Reply-To: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cohuck@redhat.com
Date: Fri, 3 Jul 2020 03:46:28 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:31:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMzEwMDY1MC42MjEy
MTItMS1jb2h1Y2tAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMDAvMTRdIHMzOTB4IHVwZGF0ZQpUeXBlOiBzZXJp
ZXMKTWVzc2FnZS1pZDogMjAyMDA3MDMxMDA2NTAuNjIxMjEyLTEtY29odWNrQHJlZGhhdC5jb20K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKZWJhNWE1YSBzMzkweC9wY2k6IGZpeCBzZXRfaW5kX2F0b21pYwo2N2IxMWMxIHZpcnRp
by1jY3c6IGZpeCB2aXJ0aW9fc2V0X2luZF9hdG9taWMKZmRjNzFmOCB0YXJnZXQvczM5MHg6IEZp
eCBTUVhCUgpmOTY2YzE5IHBjLWJpb3MvczM5MDogVXBkYXRlIHMzOTAtY2N3IGJpb3MgYmluYXJp
ZXMgd2l0aCB0aGUgbGF0ZXN0IGNoYW5nZXMKZDQ5OGU4NSBwYy1iaW9zL3MzOTAtY2N3OiBHZW5l
cmF0ZSBhbmQgaW5jbHVkZSBkZXBlbmRlbmN5IGZpbGVzIGluIHRoZSBNYWtlZmlsZQpjZjQyMzcw
IHBjLWJpb3M6IHMzOTB4OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGljaXQKMzBhMzE0NiBwYy1i
aW9zOiBzMzkweDogVXNlIGViY2RpYzJhc2NpaSB0YWJsZQo2YTg4MzhmIHBjLWJpb3M6IHMzOTB4
OiBNb3ZlIHBhbmljKCkgaW50byBoZWFkZXIgYW5kIGFkZCBpbmZpbml0ZSBsb29wCmM2MjFmZDIg
cGMtYmlvczogczM5MHg6IFVzZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2libGUgYW5kIGludHJvZHVj
ZSBQU1dfTUFTS19TSE9SVF9BRERSCjBhYzUwMDkgcGMtYmlvczogczM5MHg6IFJlbmFtZSBQU1df
TUFTS19aTU9ERSB0byBQU1dfTUFTS182NAplM2QyNTM4IHBjLWJpb3M6IHMzOTB4OiBHZXQgcmlk
IG9mIG1hZ2ljIG9mZnNldHMgaW50byB0aGUgbG93Y29yZQo4OGI3YjU5IHBjLWJpb3M6IHMzOTB4
OiBNb3ZlIHNsZWVwIGFuZCB5aWVsZCB0byBoZWxwZXIuaAozYWFiZjFlIHBjLWJpb3M6IHMzOTB4
OiBDb25zb2xpZGF0ZSB0aW1pbmcgZnVuY3Rpb25zIGludG8gdGltZS5oCmIzZjc2ZjQgcGMtYmlv
czogczM5MHg6IGNpby5jIGNsZWFudXAgYW5kIGNvbXBpbGUgZml4Cgo9PT0gT1VUUFVUIEJFR0lO
ID09PQoxLzE0IENoZWNraW5nIGNvbW1pdCBiM2Y3NmY0ZWNmOGYgKHBjLWJpb3M6IHMzOTB4OiBj
aW8uYyBjbGVhbnVwIGFuZCBjb21waWxlIGZpeCkKMi8xNCBDaGVja2luZyBjb21taXQgM2FhYmYx
ZWYxNGIyIChwYy1iaW9zOiBzMzkweDogQ29uc29saWRhdGUgdGltaW5nIGZ1bmN0aW9ucyBpbnRv
IHRpbWUuaCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBN
QUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojOTc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90
YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxNDIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xNCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgozLzE0IENoZWNraW5nIGNvbW1pdCA4OGI3YjU5YmYz
YzcgKHBjLWJpb3M6IHMzOTB4OiBNb3ZlIHNsZWVwIGFuZCB5aWVsZCB0byBoZWxwZXIuaCkKNC8x
NCBDaGVja2luZyBjb21taXQgZTNkMjUzODk2OWQzIChwYy1iaW9zOiBzMzkweDogR2V0IHJpZCBv
ZiBtYWdpYyBvZmZzZXRzIGludG8gdGhlIGxvd2NvcmUpCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQg
YXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzQ6IEZJTEU6IHBjLWJpb3MvczM5MC1jY3cvY2lv
Lmg6MTI3OgorICAgICAgICAgICAgX191MTYgY3NzaWQ6ODsKICAgICAgICAgICAgICAgICAgICAg
ICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMz
NTogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMjg6CisgICAgICAgICAgICBfX3UxNiBy
ZXNlcnZlZDo0OwogICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzM2OiBGSUxFOiBwYy1iaW9zL3MzOTAt
Y2N3L2Npby5oOjEyOToKKyAgICAgICAgICAgIF9fdTE2IG06MTsKICAgICAgICAgICAgICAgICAg
ICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzM3
OiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEzMDoKKyAgICAgICAgICAgIF9fdTE2IHNz
aWQ6MjsKICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFy
b3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzM4OiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5o
OjEzMToKKyAgICAgICAgICAgIF9fdTE2IG9uZToxOwogICAgICAgICAgICAgICAgICAgICAgXgoK
dG90YWw6IDUgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNyBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzE0
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzE0IENoZWNraW5nIGNvbW1pdCAwYWM1MDA5
MDUxMWEgKHBjLWJpb3M6IHMzOTB4OiBSZW5hbWUgUFNXX01BU0tfWk1PREUgdG8gUFNXX01BU0tf
NjQpCjYvMTQgQ2hlY2tpbmcgY29tbWl0IGM2MjFmZDIxNTY0YSAocGMtYmlvczogczM5MHg6IFVz
ZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2libGUgYW5kIGludHJvZHVjZSBQU1dfTUFTS19TSE9SVF9B
RERSKQo3LzE0IENoZWNraW5nIGNvbW1pdCA2YTg4MzhmMGU0MDcgKHBjLWJpb3M6IHMzOTB4OiBN
b3ZlIHBhbmljKCkgaW50byBoZWFkZXIgYW5kIGFkZCBpbmZpbml0ZSBsb29wKQo4LzE0IENoZWNr
aW5nIGNvbW1pdCAzMGEzMTQ2NTBhYWMgKHBjLWJpb3M6IHMzOTB4OiBVc2UgZWJjZGljMmFzY2lp
IHRhYmxlKQo5LzE0IENoZWNraW5nIGNvbW1pdCBjZjQyMzcwNTYyNmEgKHBjLWJpb3M6IHMzOTB4
OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGljaXQpCjEwLzE0IENoZWNraW5nIGNvbW1pdCBkNDk4
ZTg1ZGEyOGQgKHBjLWJpb3MvczM5MC1jY3c6IEdlbmVyYXRlIGFuZCBpbmNsdWRlIGRlcGVuZGVu
Y3kgZmlsZXMgaW4gdGhlIE1ha2VmaWxlKQoxMS8xNCBDaGVja2luZyBjb21taXQgZjk2NmMxOTM0
NWQ0IChwYy1iaW9zL3MzOTA6IFVwZGF0ZSBzMzkwLWNjdyBiaW9zIGJpbmFyaWVzIHdpdGggdGhl
IGxhdGVzdCBjaGFuZ2VzKQoxMi8xNCBDaGVja2luZyBjb21taXQgZmRjNzFmOGMzNWQ2ICh0YXJn
ZXQvczM5MHg6IEZpeCBTUVhCUikKMTMvMTQgQ2hlY2tpbmcgY29tbWl0IDY3YjExYzExZmZiMyAo
dmlydGlvLWNjdzogZml4IHZpcnRpb19zZXRfaW5kX2F0b21pYykKMTQvMTQgQ2hlY2tpbmcgY29t
bWl0IGViYTVhNWE2NTQwYiAoczM5MHgvcGNpOiBmaXggc2V0X2luZF9hdG9taWMpCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAzMTAwNjUw
LjYyMTIxMi0xLWNvaHVja0ByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

