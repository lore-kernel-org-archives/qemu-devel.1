Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C638207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C638207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqy9M-0005o9-UT
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqy7R-00057C-CF; Thu, 02 Jul 2020 08:15:09 -0400
Resent-Date: Thu, 02 Jul 2020 08:15:09 -0400
Resent-Message-Id: <E1jqy7R-00057C-CF@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqy7O-0001Bt-Ag; Thu, 02 Jul 2020 08:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593692096; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m0/s/Nd0FUoyVtgipy4RzZBXL36kgXpdFfESs1jqdP9L4P6sTt3TMp5HAZF11LB54DLQdhorggSWD/9aV2W9kmpomeJ8oxMBeAj64ZWXcl9lQQzvGQU3Ags/KPXP/PASdaqBRnTSSxy4eRS9FwbQuOTsbmwCe15byWNUHGLPUM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593692096;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=coePyPWFAT7yeOKrUX3UDufKdNHJic8gHJxxb+EM7wE=; 
 b=mPxtfift7UeavRGQlyNKDX4PEdmVuDNp0x4NzNcIE0VHO4bUxtq2dBzEd85y1wJd/3zsDtaLvzziYytzfVwDoR3XCzgAS2NAWTG48hE5f3MZAY8Ug7nEjYED+tZldCM5MOSLIn4sDGhJBSAfzV9c/crOL5ZfosorqI51xlizLpE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593692093982729.1294973518096;
 Thu, 2 Jul 2020 05:14:53 -0700 (PDT)
Message-ID: <159369209277.4590.10313786667806426346@d1fd068a5071>
Subject: Re: [PULL SUBSYSTEM s390x 00/11] s390-ccw bios update
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Thu, 2 Jul 2020 05:14:53 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 08:01:21
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMjExNTA0NS42MTcx
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BVTEwgU1VCU1lTVEVNIHMzOTB4IDAwLzExXSBzMzkwLWNjdyBi
aW9zIHVwZGF0ZQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA3MDIxMTUwNDUuNjE3MS0x
LXRodXRoQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAg
IHBhdGNoZXcvMjAyMDA3MDIxMTUwNDUuNjE3MS0xLXRodXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hl
dy8yMDIwMDcwMjExNTA0NS42MTcxLTEtdGh1dGhAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjA4MzIyZWQgcGMtYmlvcy9zMzkwOiBVcGRhdGUgczM5MC1jY3cgYmlv
cyBiaW5hcmllcyB3aXRoIHRoZSBsYXRlc3QgY2hhbmdlcwpmYTFiMjRjIHBjLWJpb3MvczM5MC1j
Y3c6IEdlbmVyYXRlIGFuZCBpbmNsdWRlIGRlcGVuZGVuY3kgZmlsZXMgaW4gdGhlIE1ha2VmaWxl
CjJhMTBiMDQgcGMtYmlvczogczM5MHg6IE1ha2UgdTMyIHB0ciBjaGVjayBleHBsaWNpdAplYWJm
ZTgxIHBjLWJpb3M6IHMzOTB4OiBVc2UgZWJjZGljMmFzY2lpIHRhYmxlCmExZjVkNDIgcGMtYmlv
czogczM5MHg6IE1vdmUgcGFuaWMoKSBpbnRvIGhlYWRlciBhbmQgYWRkIGluZmluaXRlIGxvb3AK
MTFlNjYzOSBwYy1iaW9zOiBzMzkweDogVXNlIFBTVyBtYXNrcyB3aGVyZSBwb3NzaWJsZSBhbmQg
aW50cm9kdWNlIFBTV19NQVNLX1NIT1JUX0FERFIKNjk4Y2Y4ZSBwYy1iaW9zOiBzMzkweDogUmVu
YW1lIFBTV19NQVNLX1pNT0RFIHRvIFBTV19NQVNLXzY0CjA5YWJlNGEgcGMtYmlvczogczM5MHg6
IEdldCByaWQgb2YgbWFnaWMgb2Zmc2V0cyBpbnRvIHRoZSBsb3djb3JlCjE4N2U0ZGEgcGMtYmlv
czogczM5MHg6IE1vdmUgc2xlZXAgYW5kIHlpZWxkIHRvIGhlbHBlci5oCjRiMmFlMjMgcGMtYmlv
czogczM5MHg6IENvbnNvbGlkYXRlIHRpbWluZyBmdW5jdGlvbnMgaW50byB0aW1lLmgKYmFmZTQ1
MiBwYy1iaW9zOiBzMzkweDogY2lvLmMgY2xlYW51cCBhbmQgY29tcGlsZSBmaXgKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvMTEgQ2hlY2tpbmcgY29tbWl0IGJhZmU0NTI4YmRhNCAocGMtYmlvczog
czM5MHg6IGNpby5jIGNsZWFudXAgYW5kIGNvbXBpbGUgZml4KQoyLzExIENoZWNraW5nIGNvbW1p
dCA0YjJhZTIzZjQxMzMgKHBjLWJpb3M6IHMzOTB4OiBDb25zb2xpZGF0ZSB0aW1pbmcgZnVuY3Rp
b25zIGludG8gdGltZS5oKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMp
LCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM5NzogCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDE0MiBsaW5lcyBjaGVja2VkCgpQYXRj
aCAyLzExIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvMTEgQ2hlY2tpbmcgY29tbWl0IDE4
N2U0ZGFhYTU2MSAocGMtYmlvczogczM5MHg6IE1vdmUgc2xlZXAgYW5kIHlpZWxkIHRvIGhlbHBl
ci5oKQo0LzExIENoZWNraW5nIGNvbW1pdCAwOWFiZTRhYjJmMWMgKHBjLWJpb3M6IHMzOTB4OiBH
ZXQgcmlkIG9mIG1hZ2ljIG9mZnNldHMgaW50byB0aGUgbG93Y29yZSkKRVJST1I6IHNwYWNlcyBy
ZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzNDogRklMRTogcGMtYmlvcy9zMzkw
LWNjdy9jaW8uaDoxMjc6CisgICAgICAgICAgICBfX3UxNiBjc3NpZDo4OwogICAgICAgICAgICAg
ICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4
OlZ4VikKIzM1OiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEyODoKKyAgICAgICAgICAg
IF9fdTE2IHJlc2VydmVkOjQ7CiAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBz
cGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzY6IEZJTEU6IHBjLWJp
b3MvczM5MC1jY3cvY2lvLmg6MTI5OgorICAgICAgICAgICAgX191MTYgbToxOwogICAgICAgICAg
ICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6
VnhWKQojMzc6IEZJTEU6IHBjLWJpb3MvczM5MC1jY3cvY2lvLmg6MTMwOgorICAgICAgICAgICAg
X191MTYgc3NpZDoyOwogICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVx
dWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzg6IEZJTEU6IHBjLWJpb3MvczM5MC1j
Y3cvY2lvLmg6MTMxOgorICAgICAgICAgICAgX191MTYgb25lOjE7CiAgICAgICAgICAgICAgICAg
ICAgICBeCgp0b3RhbDogNSBlcnJvcnMsIDAgd2FybmluZ3MsIDM3IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDQvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvMTEgQ2hlY2tpbmcgY29tbWl0
IDY5OGNmOGUwYjFmNSAocGMtYmlvczogczM5MHg6IFJlbmFtZSBQU1dfTUFTS19aTU9ERSB0byBQ
U1dfTUFTS182NCkKNi8xMSBDaGVja2luZyBjb21taXQgMTFlNjYzOTgyODM5IChwYy1iaW9zOiBz
MzkweDogVXNlIFBTVyBtYXNrcyB3aGVyZSBwb3NzaWJsZSBhbmQgaW50cm9kdWNlIFBTV19NQVNL
X1NIT1JUX0FERFIpCjcvMTEgQ2hlY2tpbmcgY29tbWl0IGExZjVkNDI4MGMyMiAocGMtYmlvczog
czM5MHg6IE1vdmUgcGFuaWMoKSBpbnRvIGhlYWRlciBhbmQgYWRkIGluZmluaXRlIGxvb3ApCjgv
MTEgQ2hlY2tpbmcgY29tbWl0IGVhYmZlODEyN2I4OCAocGMtYmlvczogczM5MHg6IFVzZSBlYmNk
aWMyYXNjaWkgdGFibGUpCjkvMTEgQ2hlY2tpbmcgY29tbWl0IDJhMTBiMDQ4ODdjNSAocGMtYmlv
czogczM5MHg6IE1ha2UgdTMyIHB0ciBjaGVjayBleHBsaWNpdCkKMTAvMTEgQ2hlY2tpbmcgY29t
bWl0IGZhMWIyNGNhNDBkMyAocGMtYmlvcy9zMzkwLWNjdzogR2VuZXJhdGUgYW5kIGluY2x1ZGUg
ZGVwZW5kZW5jeSBmaWxlcyBpbiB0aGUgTWFrZWZpbGUpCjExLzExIENoZWNraW5nIGNvbW1pdCAw
ODMyMmVkMDFjNDIgKHBjLWJpb3MvczM5MDogVXBkYXRlIHMzOTAtY2N3IGJpb3MgYmluYXJpZXMg
d2l0aCB0aGUgbGF0ZXN0IGNoYW5nZXMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAyMTE1MDQ1LjYxNzEtMS10aHV0aEByZWRoYXQuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

