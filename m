Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DEC20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DEC20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0Rf-0007cu-A4
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jo0R7-0007CE-Mg
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:07:13 -0400
Resent-Date: Wed, 24 Jun 2020 04:07:13 -0400
Resent-Message-Id: <E1jo0R7-0007CE-Mg@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jo0R4-0001zB-HA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:07:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592986019; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nUo5TVEFlfEa4eZU/yRx5ghYA1wMpiHDxK8DvRYIDpUqaOYiBs7QtlHpx6NM1vlUW4aTc6SAO5KzXfN4ZLKj+vhK7it0+vugS6NEBLgg0KbzmUP2ESoX6XlxET/+TdasQlFpeGcXZUM/KCdXtOCVI4gykOiqOB8XNwnxAAWoU9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592986019;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=J96pVYwc6utNWyDUOcJc/VVTn6LwrZY030mZ28h1f1E=; 
 b=Xp17wV+fyy0YwQc8XaR6LOakcqq7p/XD3whMvPng9KXFCgliRuXgIqg3c5jMg+xRH13lvcKLE0M32LjolymZwMNpJxaiIPOGLYuWJbQPY2w1fNY001kEBM4Hut91J6XsSnJnImsuHYYzGm74SpCKL+wO1RkmxSk7coFbJUW2veM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592986014877280.0745077150997;
 Wed, 24 Jun 2020 01:06:54 -0700 (PDT)
Message-ID: <159298601343.6613.16642131645368775723@d1fd068a5071>
Subject: Re: [PATCH v5 00/12] pc-bios: s390x: Cleanup part 1
In-Reply-To: <20200624075226.92728-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Wed, 24 Jun 2020 01:06:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 04:07:07
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNDA3NTIyNi45Mjcy
OC0xLWZyYW5ramFAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY1IDAwLzEyXSBwYy1iaW9zOiBzMzkweDog
Q2xlYW51cCBwYXJ0IDEKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNjI0MDc1MjI2Ljky
NzI4LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDYyNDA3NTIyNi45MjcyOC0xLWZyYW5ramFA
bGludXguaWJtLmNvbSAtPiBwYXRjaGV3LzIwMjAwNjI0MDc1MjI2LjkyNzI4LTEtZnJhbmtqYUBs
aW51eC5pYm0uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjc3ODlkMCBwYy1i
aW9zOiBzMzkweDogQ2xlYW51cCBqdW1wIHRvIGlwbCBjb2RlCjg2ODBjYTIgcGMtYmlvczogczM5
MHg6IEZpeCBib290bWFwLmMgcGFzc2luZyBQU1dzIGFzIGFkZHJlc3Nlcwo4MzA0ODNiIHBjLWJp
b3M6IHMzOTB4OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGljaXQKZjMxM2JiMiBwYy1iaW9zOiBz
MzkweDogVXNlIGViY2RpYzJhc2NpaSB0YWJsZQowMDcyOGEyIHBjLWJpb3M6IHMzOTB4OiBNb3Zl
IHBhbmljKCkgaW50byBoZWFkZXIgYW5kIGFkZCBpbmZpbml0ZSBsb29wCmQwMjVhOWMgcGMtYmlv
czogczM5MHg6IFVzZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2libGUgYW5kIGludHJvZHVjZSBQU1df
TUFTS19TSE9SVF9BRERSCmUzM2U5ZmYgcGMtYmlvczogczM5MHg6IFJlbmFtZSBQU1dfTUFTS19a
TU9ERSB0byBQU1dfTUFTS182NApjOThlYzZlIHBjLWJpb3M6IHMzOTB4OiBSZW1vdmUgdW5uZWVk
ZWQgZGFzZC1pcGwuYyByZXNldCBwc3cgbWFzayBjaGFuZ2VzCmYyMmI1NzMgcGMtYmlvczogczM5
MHg6IEdldCByaWQgb2YgbWFnaWMgb2Zmc2V0cyBpbnRvIHRoZSBsb3djb3JlCmFhZmIwMTYgcGMt
YmlvczogczM5MHg6IE1vdmUgc2xlZXAgYW5kIHlpZWxkIHRvIGhlbHBlci5oCjg1NWMxYzkgcGMt
YmlvczogczM5MHg6IENvbnNvbGlkYXRlIHRpbWluZyBmdW5jdGlvbnMgaW50byB0aW1lLmgKYjkw
NmY0MSBwYy1iaW9zOiBzMzkweDogY2lvLmMgY2xlYW51cCBhbmQgY29tcGlsZSBmaXgKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvMTIgQ2hlY2tpbmcgY29tbWl0IGI5MDZmNDFkZjI4ZiAocGMtYmlv
czogczM5MHg6IGNpby5jIGNsZWFudXAgYW5kIGNvbXBpbGUgZml4KQoyLzEyIENoZWNraW5nIGNv
bW1pdCA4NTVjMWM5YmU0ZmUgKHBjLWJpb3M6IHMzOTB4OiBDb25zb2xpZGF0ZSB0aW1pbmcgZnVu
Y3Rpb25zIGludG8gdGltZS5oKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxl
KHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM5NDogCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDE0MiBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAyLzEyIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvMTIgQ2hlY2tpbmcgY29tbWl0
IGFhZmIwMTZmZGZlMCAocGMtYmlvczogczM5MHg6IE1vdmUgc2xlZXAgYW5kIHlpZWxkIHRvIGhl
bHBlci5oKQo0LzEyIENoZWNraW5nIGNvbW1pdCBmMjJiNTczYmM3M2UgKHBjLWJpb3M6IHMzOTB4
OiBHZXQgcmlkIG9mIG1hZ2ljIG9mZnNldHMgaW50byB0aGUgbG93Y29yZSkKRVJST1I6IHNwYWNl
cyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzMDogRklMRTogcGMtYmlvcy9z
MzkwLWNjdy9jaW8uaDoxMjc6CisgICAgICAgICAgICBfX3UxNiBjc3NpZDo4OwogICAgICAgICAg
ICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAo
Y3R4OlZ4VikKIzMxOiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEyODoKKyAgICAgICAg
ICAgIF9fdTE2IHJlc2VydmVkOjQ7CiAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9S
OiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzI6IEZJTEU6IHBj
LWJpb3MvczM5MC1jY3cvY2lvLmg6MTI5OgorICAgICAgICAgICAgX191MTYgbToxOwogICAgICAg
ICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChj
dHg6VnhWKQojMzM6IEZJTEU6IHBjLWJpb3MvczM5MC1jY3cvY2lvLmg6MTMwOgorICAgICAgICAg
ICAgX191MTYgc3NpZDoyOwogICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMg
cmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzQ6IEZJTEU6IHBjLWJpb3MvczM5
MC1jY3cvY2lvLmg6MTMxOgorICAgICAgICAgICAgX191MTYgb25lOjE7CiAgICAgICAgICAgICAg
ICAgICAgICBeCgp0b3RhbDogNSBlcnJvcnMsIDAgd2FybmluZ3MsIDM3IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDQvMTIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvMTIgQ2hlY2tpbmcgY29t
bWl0IGM5OGVjNmViMTAxYiAocGMtYmlvczogczM5MHg6IFJlbW92ZSB1bm5lZWRlZCBkYXNkLWlw
bC5jIHJlc2V0IHBzdyBtYXNrIGNoYW5nZXMpCjYvMTIgQ2hlY2tpbmcgY29tbWl0IGUzM2U5ZmZm
MTQ1YSAocGMtYmlvczogczM5MHg6IFJlbmFtZSBQU1dfTUFTS19aTU9ERSB0byBQU1dfTUFTS182
NCkKNy8xMiBDaGVja2luZyBjb21taXQgZDAyNWE5Y2U0YzY3IChwYy1iaW9zOiBzMzkweDogVXNl
IFBTVyBtYXNrcyB3aGVyZSBwb3NzaWJsZSBhbmQgaW50cm9kdWNlIFBTV19NQVNLX1NIT1JUX0FE
RFIpCjgvMTIgQ2hlY2tpbmcgY29tbWl0IDAwNzI4YTJmZGY5ZSAocGMtYmlvczogczM5MHg6IE1v
dmUgcGFuaWMoKSBpbnRvIGhlYWRlciBhbmQgYWRkIGluZmluaXRlIGxvb3ApCjkvMTIgQ2hlY2tp
bmcgY29tbWl0IGYzMTNiYjI1OTQ4YyAocGMtYmlvczogczM5MHg6IFVzZSBlYmNkaWMyYXNjaWkg
dGFibGUpCjEwLzEyIENoZWNraW5nIGNvbW1pdCA4MzA0ODNiZjk0MGQgKHBjLWJpb3M6IHMzOTB4
OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGljaXQpCjExLzEyIENoZWNraW5nIGNvbW1pdCA4Njgw
Y2EyMTBmNzEgKHBjLWJpb3M6IHMzOTB4OiBGaXggYm9vdG1hcC5jIHBhc3NpbmcgUFNXcyBhcyBh
ZGRyZXNzZXMpCjEyLzEyIENoZWNraW5nIGNvbW1pdCBmNzc4OWQwZTE5MDYgKHBjLWJpb3M6IHMz
OTB4OiBDbGVhbnVwIGp1bXAgdG8gaXBsIGNvZGUpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjI0MDc1MjI2LjkyNzI4LTEtZnJhbmtqYUBs
aW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

