Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4919C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8976F20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8976F20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxvL-0006Of-SZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqxuB-0005Qu-LK; Thu, 02 Jul 2020 08:01:27 -0400
Resent-Date: Thu, 02 Jul 2020 08:01:27 -0400
Resent-Message-Id: <E1jqxuB-0005Qu-LK@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqxu8-0002Vr-GN; Thu, 02 Jul 2020 08:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593691271; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Mgt/JL0P9biH/gVpBwozbrJw9ioLT+vhR6oUK6k5zwMcMnm3+J/2FEAZ5FVNgFScJfGC0FHXGwvPEoTeB1fi2lZJhmtc+lYMs1nQrUa3hKHuL28G3mOExfqK5W1uOQ7jUOCJ/+CYKmujytmspr4Zeogzs+jbzTgUtZU+qHuDgOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593691271;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QsOC28AjYnVCCHhXHRh2DajXoESHnlD4bztbPBD7nAk=; 
 b=dRvUel1FmyaS6cEyrFV+P2PCAlF22feZ31mZSjoPSYUQB56izzpwHHElhCpib8TOH/Ql9GIDb8tXhYEHqoWR3830lYXIrMpO8UM/wPSCcyoh23WPdR/B4sfgASFL8RIRWlWjWjiKrGMEcY2mYrGNdDJcyNVb37A9UN7JFb9JOy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593691269883741.2742744887503;
 Thu, 2 Jul 2020 05:01:09 -0700 (PDT)
Message-ID: <159369126861.4269.14279677267141769902@d1fd068a5071>
Subject: Re: [PULL SUBSYSTEM s390x 00/11] s390-ccw bios update
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Thu, 2 Jul 2020 05:01:09 -0700 (PDT)
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
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpG
cm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10g
ICAgICAgICBwYXRjaGV3LzIwMjAwNzAyMTE1MDQ1LjYxNzEtMS10aHV0aEByZWRoYXQuY29tIC0+
IHBhdGNoZXcvMjAyMDA3MDIxMTUwNDUuNjE3MS0xLXRodXRoQHJlZGhhdC5jb20KU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowZDFlMzg5IHBjLWJpb3MvczM5MDogVXBkYXRlIHMzOTAt
Y2N3IGJpb3MgYmluYXJpZXMgd2l0aCB0aGUgbGF0ZXN0IGNoYW5nZXMKYjg1M2QyYSBwYy1iaW9z
L3MzOTAtY2N3OiBHZW5lcmF0ZSBhbmQgaW5jbHVkZSBkZXBlbmRlbmN5IGZpbGVzIGluIHRoZSBN
YWtlZmlsZQpiMjNiNmIxIHBjLWJpb3M6IHMzOTB4OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGlj
aXQKNmI4YzEzMCBwYy1iaW9zOiBzMzkweDogVXNlIGViY2RpYzJhc2NpaSB0YWJsZQplMjE2OGU2
IHBjLWJpb3M6IHMzOTB4OiBNb3ZlIHBhbmljKCkgaW50byBoZWFkZXIgYW5kIGFkZCBpbmZpbml0
ZSBsb29wCjdhMjQwMGQgcGMtYmlvczogczM5MHg6IFVzZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2li
bGUgYW5kIGludHJvZHVjZSBQU1dfTUFTS19TSE9SVF9BRERSCjI2N2M0MTggcGMtYmlvczogczM5
MHg6IFJlbmFtZSBQU1dfTUFTS19aTU9ERSB0byBQU1dfTUFTS182NAo2YmQzZTZjIHBjLWJpb3M6
IHMzOTB4OiBHZXQgcmlkIG9mIG1hZ2ljIG9mZnNldHMgaW50byB0aGUgbG93Y29yZQpiZWNkM2Nh
IHBjLWJpb3M6IHMzOTB4OiBNb3ZlIHNsZWVwIGFuZCB5aWVsZCB0byBoZWxwZXIuaAowNjFlOWYz
IHBjLWJpb3M6IHMzOTB4OiBDb25zb2xpZGF0ZSB0aW1pbmcgZnVuY3Rpb25zIGludG8gdGltZS5o
CjdlNTZmNGYgcGMtYmlvczogczM5MHg6IGNpby5jIGNsZWFudXAgYW5kIGNvbXBpbGUgZml4Cgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzExIENoZWNraW5nIGNvbW1pdCA3ZTU2ZjRmZWJmODMgKHBj
LWJpb3M6IHMzOTB4OiBjaW8uYyBjbGVhbnVwIGFuZCBjb21waWxlIGZpeCkKMi8xMSBDaGVja2lu
ZyBjb21taXQgMDYxZTlmMzUyYTNlIChwYy1iaW9zOiBzMzkweDogQ29uc29saWRhdGUgdGltaW5n
IGZ1bmN0aW9ucyBpbnRvIHRpbWUuaCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojOTc6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxNDIgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgozLzExIENoZWNraW5nIGNv
bW1pdCBiZWNkM2NhN2NhYWYgKHBjLWJpb3M6IHMzOTB4OiBNb3ZlIHNsZWVwIGFuZCB5aWVsZCB0
byBoZWxwZXIuaCkKNC8xMSBDaGVja2luZyBjb21taXQgNmJkM2U2YzQ0MWExIChwYy1iaW9zOiBz
MzkweDogR2V0IHJpZCBvZiBtYWdpYyBvZmZzZXRzIGludG8gdGhlIGxvd2NvcmUpCkVSUk9SOiBz
cGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzQ6IEZJTEU6IHBjLWJp
b3MvczM5MC1jY3cvY2lvLmg6MTI3OgorICAgICAgICAgICAgX191MTYgY3NzaWQ6ODsKICAgICAg
ICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAn
OicgKGN0eDpWeFYpCiMzNTogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMjg6CisgICAg
ICAgICAgICBfX3UxNiByZXNlcnZlZDo0OwogICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpF
UlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzM2OiBGSUxF
OiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEyOToKKyAgICAgICAgICAgIF9fdTE2IG06MTsKICAg
ICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6
JyAoY3R4OlZ4VikKIzM3OiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEzMDoKKyAgICAg
ICAgICAgIF9fdTE2IHNzaWQ6MjsKICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3Bh
Y2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzM4OiBGSUxFOiBwYy1iaW9z
L3MzOTAtY2N3L2Npby5oOjEzMToKKyAgICAgICAgICAgIF9fdTE2IG9uZToxOwogICAgICAgICAg
ICAgICAgICAgICAgXgoKdG90YWw6IDUgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNyBsaW5lcyBjaGVj
a2VkCgpQYXRjaCA0LzExIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzExIENoZWNraW5n
IGNvbW1pdCAyNjdjNDE4MGEzNzQgKHBjLWJpb3M6IHMzOTB4OiBSZW5hbWUgUFNXX01BU0tfWk1P
REUgdG8gUFNXX01BU0tfNjQpCjYvMTEgQ2hlY2tpbmcgY29tbWl0IDdhMjQwMGRmYTIyYiAocGMt
YmlvczogczM5MHg6IFVzZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2libGUgYW5kIGludHJvZHVjZSBQ
U1dfTUFTS19TSE9SVF9BRERSKQo3LzExIENoZWNraW5nIGNvbW1pdCBlMjE2OGU2NjFmOGQgKHBj
LWJpb3M6IHMzOTB4OiBNb3ZlIHBhbmljKCkgaW50byBoZWFkZXIgYW5kIGFkZCBpbmZpbml0ZSBs
b29wKQo4LzExIENoZWNraW5nIGNvbW1pdCA2YjhjMTMwZTViMzggKHBjLWJpb3M6IHMzOTB4OiBV
c2UgZWJjZGljMmFzY2lpIHRhYmxlKQo5LzExIENoZWNraW5nIGNvbW1pdCBiMjNiNmIxMThmMDQg
KHBjLWJpb3M6IHMzOTB4OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGljaXQpCjEwLzExIENoZWNr
aW5nIGNvbW1pdCBiODUzZDJhZGM2MTIgKHBjLWJpb3MvczM5MC1jY3c6IEdlbmVyYXRlIGFuZCBp
bmNsdWRlIGRlcGVuZGVuY3kgZmlsZXMgaW4gdGhlIE1ha2VmaWxlKQoxMS8xMSBDaGVja2luZyBj
b21taXQgMGQxZTM4OTA0Yzk5IChwYy1iaW9zL3MzOTA6IFVwZGF0ZSBzMzkwLWNjdyBiaW9zIGJp
bmFyaWVzIHdpdGggdGhlIGxhdGVzdCBjaGFuZ2VzKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcwMjExNTA0NS42MTcxLTEtdGh1dGhAcmVk
aGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

