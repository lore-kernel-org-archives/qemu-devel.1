Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E21C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9417207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9417207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyPJ-0003UQ-0K
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqyOT-0002qF-Ig; Thu, 02 Jul 2020 08:32:45 -0400
Resent-Date: Thu, 02 Jul 2020 08:32:45 -0400
Resent-Message-Id: <E1jqyOT-0002qF-Ig@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqyOO-0001FO-Sr; Thu, 02 Jul 2020 08:32:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593693146; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jebZ0ScDr2hG1pHeMIlQQDuqb4emFuhRPxe/q/dJkdKuKJPBnHrdL7Yhyjj7MWdvb9xVHfOFVrY5pXbBolohBB1udLu4NF8fUhGr1kyvvs5x8VyGvx+KYcDe4Vgdi3g2LTkk9J+lnjhgcH5ZfLgNv8TmVcOVHAOkCFMZZyZY93Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593693146;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=O4LCOBFIT9peooAyFXLB3yEH8dJOp73ZfYgXHnNoqHw=; 
 b=Dv3NJNrvC6IOvD5wMHgLw0bgnc+hII/29oQAbHouMDKq/nW2blenPIZHP0zL0ymu6eU0ipepq/gTXjr5fUgO5T1zj44NYBzFVH+beMB4nYvHOmlWyEEMGNnZ1t6COi7fdy57MDAx1YcB3/ZrV8SeJ/pDQRkYOX/A5azULA0zn8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159369314352155.33479301254374;
 Thu, 2 Jul 2020 05:32:23 -0700 (PDT)
Message-ID: <159369314218.4590.14091589143467710303@d1fd068a5071>
Subject: Re: [PULL SUBSYSTEM s390x 00/11] s390-ccw bios update
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Thu, 2 Jul 2020 05:32:23 -0700 (PDT)
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
dy8yMDIwMDcwMjExNTA0NS42MTcxLTEtdGh1dGhAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAg
ICAgICBwYXRjaGV3LzIwMjAwNzAyMTIyMDQ4LjI3Nzk4LTEta3JheGVsQHJlZGhhdC5jb20gLT4g
cGF0Y2hldy8yMDIwMDcwMjEyMjA0OC4yNzc5OC0xLWtyYXhlbEByZWRoYXQuY29tClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjBiMDc2YyBwYy1iaW9zL3MzOTA6IFVwZGF0ZSBzMzkw
LWNjdyBiaW9zIGJpbmFyaWVzIHdpdGggdGhlIGxhdGVzdCBjaGFuZ2VzCmJmMzgzMDMgcGMtYmlv
cy9zMzkwLWNjdzogR2VuZXJhdGUgYW5kIGluY2x1ZGUgZGVwZW5kZW5jeSBmaWxlcyBpbiB0aGUg
TWFrZWZpbGUKMzJkNDM4ZCBwYy1iaW9zOiBzMzkweDogTWFrZSB1MzIgcHRyIGNoZWNrIGV4cGxp
Y2l0CmQ4YzMyMDAgcGMtYmlvczogczM5MHg6IFVzZSBlYmNkaWMyYXNjaWkgdGFibGUKNjRmM2Y3
NiBwYy1iaW9zOiBzMzkweDogTW92ZSBwYW5pYygpIGludG8gaGVhZGVyIGFuZCBhZGQgaW5maW5p
dGUgbG9vcAo4ZjNkYzZiIHBjLWJpb3M6IHMzOTB4OiBVc2UgUFNXIG1hc2tzIHdoZXJlIHBvc3Np
YmxlIGFuZCBpbnRyb2R1Y2UgUFNXX01BU0tfU0hPUlRfQUREUgo5MzdlYmZmIHBjLWJpb3M6IHMz
OTB4OiBSZW5hbWUgUFNXX01BU0tfWk1PREUgdG8gUFNXX01BU0tfNjQKZThmODY0YyBwYy1iaW9z
OiBzMzkweDogR2V0IHJpZCBvZiBtYWdpYyBvZmZzZXRzIGludG8gdGhlIGxvd2NvcmUKOTYzOGQ1
NCBwYy1iaW9zOiBzMzkweDogTW92ZSBzbGVlcCBhbmQgeWllbGQgdG8gaGVscGVyLmgKNDA5OWY4
MiBwYy1iaW9zOiBzMzkweDogQ29uc29saWRhdGUgdGltaW5nIGZ1bmN0aW9ucyBpbnRvIHRpbWUu
aAo1ZTFkM2ZhIHBjLWJpb3M6IHMzOTB4OiBjaW8uYyBjbGVhbnVwIGFuZCBjb21waWxlIGZpeAoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2luZyBjb21taXQgNWUxZDNmYWZhMTAzIChw
Yy1iaW9zOiBzMzkweDogY2lvLmMgY2xlYW51cCBhbmQgY29tcGlsZSBmaXgpCjIvMTEgQ2hlY2tp
bmcgY29tbWl0IDQwOTlmODJkY2U1MSAocGMtYmlvczogczM5MHg6IENvbnNvbGlkYXRlIHRpbWlu
ZyBmdW5jdGlvbnMgaW50byB0aW1lLmgpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVk
IGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzk3OiAKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTQyIGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDIvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMy8xMSBDaGVja2luZyBj
b21taXQgOTYzOGQ1NDk2M2RmIChwYy1iaW9zOiBzMzkweDogTW92ZSBzbGVlcCBhbmQgeWllbGQg
dG8gaGVscGVyLmgpCjQvMTEgQ2hlY2tpbmcgY29tbWl0IGU4Zjg2NGMxODgzZSAocGMtYmlvczog
czM5MHg6IEdldCByaWQgb2YgbWFnaWMgb2Zmc2V0cyBpbnRvIHRoZSBsb3djb3JlKQpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc6JyAoY3R4OlZ4VikKIzM0OiBGSUxFOiBwYy1i
aW9zL3MzOTAtY2N3L2Npby5oOjEyNzoKKyAgICAgICAgICAgIF9fdTE2IGNzc2lkOjg7CiAgICAg
ICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQg
JzonIChjdHg6VnhWKQojMzU6IEZJTEU6IHBjLWJpb3MvczM5MC1jY3cvY2lvLmg6MTI4OgorICAg
ICAgICAgICAgX191MTYgcmVzZXJ2ZWQ6NDsKICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoK
RVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzNjogRklM
RTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMjk6CisgICAgICAgICAgICBfX3UxNiBtOjE7CiAg
ICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAn
OicgKGN0eDpWeFYpCiMzNzogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMzA6CisgICAg
ICAgICAgICBfX3UxNiBzc2lkOjI7CiAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzODogRklMRTogcGMtYmlv
cy9zMzkwLWNjdy9jaW8uaDoxMzE6CisgICAgICAgICAgICBfX3UxNiBvbmU6MTsKICAgICAgICAg
ICAgICAgICAgICAgIF4KCnRvdGFsOiA1IGVycm9ycywgMCB3YXJuaW5ncywgMzcgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggNC8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS8xMSBDaGVja2lu
ZyBjb21taXQgOTM3ZWJmZmFjMGY2IChwYy1iaW9zOiBzMzkweDogUmVuYW1lIFBTV19NQVNLX1pN
T0RFIHRvIFBTV19NQVNLXzY0KQo2LzExIENoZWNraW5nIGNvbW1pdCA4ZjNkYzZiZTY5ZWEgKHBj
LWJpb3M6IHMzOTB4OiBVc2UgUFNXIG1hc2tzIHdoZXJlIHBvc3NpYmxlIGFuZCBpbnRyb2R1Y2Ug
UFNXX01BU0tfU0hPUlRfQUREUikKNy8xMSBDaGVja2luZyBjb21taXQgNjRmM2Y3Njc1ZDIxIChw
Yy1iaW9zOiBzMzkweDogTW92ZSBwYW5pYygpIGludG8gaGVhZGVyIGFuZCBhZGQgaW5maW5pdGUg
bG9vcCkKOC8xMSBDaGVja2luZyBjb21taXQgZDhjMzIwMDc2ZWE5IChwYy1iaW9zOiBzMzkweDog
VXNlIGViY2RpYzJhc2NpaSB0YWJsZSkKOS8xMSBDaGVja2luZyBjb21taXQgMzJkNDM4ZGIxZWY2
IChwYy1iaW9zOiBzMzkweDogTWFrZSB1MzIgcHRyIGNoZWNrIGV4cGxpY2l0KQoxMC8xMSBDaGVj
a2luZyBjb21taXQgYmYzODMwMzMwZWIxIChwYy1iaW9zL3MzOTAtY2N3OiBHZW5lcmF0ZSBhbmQg
aW5jbHVkZSBkZXBlbmRlbmN5IGZpbGVzIGluIHRoZSBNYWtlZmlsZSkKMTEvMTEgQ2hlY2tpbmcg
Y29tbWl0IGYwYjA3NmMwOWExZiAocGMtYmlvcy9zMzkwOiBVcGRhdGUgczM5MC1jY3cgYmlvcyBi
aW5hcmllcyB3aXRoIHRoZSBsYXRlc3QgY2hhbmdlcykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MDIxMTUwNDUuNjE3MS0xLXRodXRoQHJl
ZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

