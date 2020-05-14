Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FF820671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 18:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FF820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZIqQ-0004oz-0t
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZIpI-0003vA-9F; Thu, 14 May 2020 14:43:25 -0400
Resent-Date: Thu, 14 May 2020 14:43:24 -0400
Resent-Message-Id: <E1jZIpI-0003vA-9F@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZIpG-0006ZL-AA; Thu, 14 May 2020 14:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589481789; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WUldbOk4B83Hi8w7Rx6oSJNbJVU6qQpHB4QFneQgDAc3I/PgLeFKtqt7jnjKf9YQHQc9FBH/0hjfagzXJrds8CbXbAVIbUF0fR5WBfpdNaLm/xfTSVO1PIds6ocJdCLvxlIwDGwLKbHqFUJ+97yeHY4b0IusuNu2i4dgBLLBRdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589481789;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dQ8RG5zxOyzCCWdnXk0Fb4Ls4reH9nnAgTGgS/LQGkE=; 
 b=BUjr4KX5FEuih5qGrjawE1TBJJV1YwY+GpQslnDOVjNR1C4kucbWPohyBifGAoAOhZWp/VzandHg6UiD5UVpN5IMtgwKlIzLb2evRQwQj3J4Fs2KZ8zbEck9fYlIez6iHFs1BRTPzoDuL1JePxgcMoRhaBeuXEb4SKUWzgls0Eg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589481787681304.22793860692127;
 Thu, 14 May 2020 11:43:07 -0700 (PDT)
Message-ID: <158948178626.27313.17120759717830756447@45ef0f9c86ae>
In-Reply-To: <20200514123729.156283-1-frankja@linux.ibm.com>
Subject: Re: [PATCH v2 0/9] pc-bios: s390x: Cleanup part 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Thu, 14 May 2020 11:43:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:45:30
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNDEyMzcyOS4xNTYy
ODMtMS1mcmFua2phQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTE0MTIzNzI5LjE1NjI4My0xLWZyYW5r
amFAbGludXguaWJtLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjIgMC85XSBwYy1iaW9zOiBzMzkweDog
Q2xlYW51cCBwYXJ0IDEKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1MDQ5NTE4IHBjLWJpb3M6
IHMzOTB4OiBNYWtlIHUzMiBwdHIgY2hlY2sgZXhwbGljaXQKMTBhZWUyZSBwYy1iaW9zOiBzMzkw
eDogUmVwbGFjZSAweDAwIHdpdGggMHgwIG9yIDAKMTY4NDIxZSBwYy1iaW9zOiBzMzkweDogVXNl
IGViY2RpYzJhc2NpaSB0YWJsZQo1MTA1MWFmIHBjLWJpb3M6IHMzOTB4OiBNb3ZlIHBhbmljKCkg
aW50byBoZWFkZXIgYW5kIGFkZCBpbmZpbml0ZSBsb29wCjljZjRjMWMgcGMtYmlvczogczM5MHg6
IFVzZSBQU1cgbWFza3Mgd2hlcmUgcG9zc2libGUKZTg4NjEzNyBwYy1iaW9zOiBzMzkweDogUmVu
YW1lIGFuZCB1c2UgUFNXX01BU0tfWk1PREUgY29uc3RhbnQKYjEwODAwYSBwYy1iaW9zOiBzMzkw
eDogR2V0IHJpZCBvZiBtYWdpYyBvZmZzZXRzIGludG8gdGhlIGxvd2NvcmUKYTEwNTA4NSBwYy1i
aW9zOiBzMzkweDogQ29uc29saWRhdGUgdGltaW5nIGZ1bmN0aW9ucyBpbnRvIHRpbWUuaAozYTgz
ZWJkIHBjLWJpb3M6IHMzOTB4OiBjaW8uYyBjbGVhbnVwIGFuZCBjb21waWxlIGZpeAoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCAzYTgzZWJkMzI2NDQgKHBjLWJpb3M6
IHMzOTB4OiBjaW8uYyBjbGVhbnVwIGFuZCBjb21waWxlIGZpeCkKRVJST1I6IGNvZGUgaW5kZW50
IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjY6IEZJTEU6IHBjLWJpb3MvczM5MC1jY3cvY2lvLmM6
MzE5OgorICAgICAgICAucGZjaCA9IDEsXkkvKiBRRU1VJ3MgY2lvIGltcGxlbWVudGF0aW9uIHJl
cXVpcmVzIHByZWZldGNoICovJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2Ug
dGFicwojNjc6IEZJTEU6IHBjLWJpb3MvczM5MC1jY3cvY2lvLmM6MzIwOgorICAgICAgICAuYzY0
ID0gMSxeSS8qIFFFTVUncyBjaW8gaW1wbGVtZW50YXRpb24gcmVxdWlyZXMgNjQtYml0IGlkYXdz
ICovJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNjg6IEZJTEU6
IHBjLWJpb3MvczM5MC1jY3cvY2lvLmM6MzIxOgorICAgICAgICAubHBtID0gMHhGRixeSS8qIEFs
bCBwYXRocyBhbGxvd2VkICovJAoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCA2MyBsaW5l
cyBjaGVja2VkCgpQYXRjaCAxLzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvOSBDaGVj
a2luZyBjb21taXQgYTEwNTA4NWIzNzk0IChwYy1iaW9zOiBzMzkweDogQ29uc29saWRhdGUgdGlt
aW5nIGZ1bmN0aW9ucyBpbnRvIHRpbWUuaCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0
ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTAyOiAKbmV3IGZp
bGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTY3IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDIvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgozLzkgQ2hlY2tpbmcg
Y29tbWl0IGIxMDgwMGFmYmRjOCAocGMtYmlvczogczM5MHg6IEdldCByaWQgb2YgbWFnaWMgb2Zm
c2V0cyBpbnRvIHRoZSBsb3djb3JlKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0
ICc6JyAoY3R4OlZ4VikKIzI5OiBGSUxFOiBwYy1iaW9zL3MzOTAtY2N3L2Npby5oOjEyNzoKKyAg
ICAgICAgICAgIF9fdTE2IGNzc2lkOjg7CiAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9S
OiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJzonIChjdHg6VnhWKQojMzA6IEZJTEU6IHBj
LWJpb3MvczM5MC1jY3cvY2lvLmg6MTI4OgorICAgICAgICAgICAgX191MTYgcmVzZXJ2ZWQ6NDsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91
bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzMTogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDox
Mjk6CisgICAgICAgICAgICBfX3UxNiBtOjE7CiAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFYpCiMzMjogRklMRTogcGMt
Ymlvcy9zMzkwLWNjdy9jaW8uaDoxMzA6CisgICAgICAgICAgICBfX3UxNiBzc2lkOjI7CiAgICAg
ICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAn
OicgKGN0eDpWeFYpCiMzMzogRklMRTogcGMtYmlvcy9zMzkwLWNjdy9jaW8uaDoxMzE6CisgICAg
ICAgICAgICBfX3UxNiBvbmU6MTsKICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiA1IGVy
cm9ycywgMCB3YXJuaW5ncywgMzcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy85IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo0LzkgQ2hlY2tpbmcgY29tbWl0IGU4ODYxMzdiMGUzYyAocGMtYmlv
czogczM5MHg6IFJlbmFtZSBhbmQgdXNlIFBTV19NQVNLX1pNT0RFIGNvbnN0YW50KQo1LzkgQ2hl
Y2tpbmcgY29tbWl0IDljZjRjMWM0NjI2YSAocGMtYmlvczogczM5MHg6IFVzZSBQU1cgbWFza3Mg
d2hlcmUgcG9zc2libGUpCjYvOSBDaGVja2luZyBjb21taXQgNTEwNTFhZmU5YTllIChwYy1iaW9z
OiBzMzkweDogTW92ZSBwYW5pYygpIGludG8gaGVhZGVyIGFuZCBhZGQgaW5maW5pdGUgbG9vcCkK
Ny85IENoZWNraW5nIGNvbW1pdCAxNjg0MjFlM2M2NmUgKHBjLWJpb3M6IHMzOTB4OiBVc2UgZWJj
ZGljMmFzY2lpIHRhYmxlKQo4LzkgQ2hlY2tpbmcgY29tbWl0IDEwYWVlMmVhODc3YyAocGMtYmlv
czogczM5MHg6IFJlcGxhY2UgMHgwMCB3aXRoIDB4MCBvciAwKQo5LzkgQ2hlY2tpbmcgY29tbWl0
IDUwNDk1MThlNjU1MiAocGMtYmlvczogczM5MHg6IE1ha2UgdTMyIHB0ciBjaGVjayBleHBsaWNp
dCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA1MTQxMjM3MjkuMTU2MjgzLTEtZnJhbmtqYUBsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

