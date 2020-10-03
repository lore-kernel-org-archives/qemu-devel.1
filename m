Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6159C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DC92067C
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC92067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdu9-0002RN-1L
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kOdtP-00022A-Pd
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:31:51 -0400
Resent-Date: Sat, 03 Oct 2020 05:31:51 -0400
Resent-Message-Id: <E1kOdtP-00022A-Pd@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kOdtN-0000DA-8b
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:31:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601717500; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DrMJE9r23cgmwtG8ouHr6yCyEEIowLbHhRP92jPHGiy9NlUi33F1phlseSlab/ZzOiDL/yCiNkY5Ps2IP6W09WUDev5f861eLXaVPHlM7Wxmo1BQOi/V2agzl+uqHdd+KMTYfrkxWf60FxJ2D+IUxkFm2NLKn/vMQasMlKjVx7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601717500;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=byw1FRhYSfQSCXrZSRRlENHgMog3XeRovH8qSj05YY0=; 
 b=i0DU4a5e+hiw/wYB1vCrlET+jwtZlbl9dHNBhKG6bVaZjDdlY6qaq5kUma0oSBJZIo4q/qIDfY7K5hXVS8VaiuTpjDMofeN9ydDMayBCLDtH4wk8I6q9ZI9Sjktio0KQ1K/pmqOGB0zFC7V6aRLCxQ3tviwlFliVsbXb5kcoUDs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601717498918941.9607573602891;
 Sat, 3 Oct 2020 02:31:38 -0700 (PDT)
Subject: Re: [PATCH v6 00/10] Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <160171749798.28192.3331559370932014575@66eaa9a8a123>
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Sat, 3 Oct 2020 02:31:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 05:31:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwMjE3MzU1OC4yMzI5
NjAtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMDIxNzM1NTguMjMy
OTYwLTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjYgMDAvMTBdIEZpeCBz
Y3NpIGRldmljZXMgcGx1Zy91bnBsdWcgcmFjZXMgdy5yLnQgdmlydGlvLXNjc2kgaW90aHJlYWQK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA5Mjky
MjQzNTUuMTIyNDAxNy0xLXBoaWxtZEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA5MjkyMjQz
NTUuMTIyNDAxNy0xLXBoaWxtZEByZWRoYXQuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNo
ZXcvMjAyMDEwMDMwMjQxMjMuMTkzODQwLTEtZWhhYmtvc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3
LzIwMjAxMDAzMDI0MTIzLjE5Mzg0MC0xLWVoYWJrb3N0QHJlZGhhdC5jb20KIC0gW3RhZyB1cGRh
dGVdICAgICAgcGF0Y2hldy8yMDIwMTAwMzAyNTQyNC4xOTkyOTEtMS1laGFia29zdEByZWRoYXQu
Y29tIC0+IHBhdGNoZXcvMjAyMDEwMDMwMjU0MjQuMTk5MjkxLTEtZWhhYmtvc3RAcmVkaGF0LmNv
bQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDAzMDg1MDU0LjMzMjk5Mi0xLXBi
b256aW5pQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMTAwMzA4NTA1NC4zMzI5OTItMS1wYm9u
emluaUByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDEwMDMwODUw
NTQuMzMyOTkyLTItcGJvbnppbmlAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAxMDAzMDg1MDU0
LjMzMjk5Mi0yLXBib256aW5pQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo3MjM1NWVjIHNjc2kvc2NzaV9idXM6IGZpeCByYWNlcyBpbiBSRVBPUlQgTFVOUwo3OGJh
ZjBjIHZpcnRpby1zY3NpOiB1c2Ugc2NzaV9kZXZpY2VfZ2V0CjAzYjRiYzQgc2NzaS9zY3NpX2J1
czogQWRkIHNjc2lfZGV2aWNlX2dldAoyYTYxNWVmIHNjc2kvc2NzaS1idXM6IHNjc2lfZGV2aWNl
X2ZpbmQ6IGRvbid0IHJldHVybiB1bnJlYWxpemVkIGRldmljZXMKNTlkYmJkYiBkZXZpY2UtY29y
ZTogdXNlIGF0b21pY19zZXQgb24gLnJlYWxpemVkIHByb3BlcnR5CjBmN2ZmMGUgZGV2aWNlLWNv
cmU6IHVzZSBSQ1UgZm9yIGxpc3Qgb2YgY2hpbGRyZW4gb2YgYSBidXMKNWQxN2E5ZSBkZXZpY2Vf
Y29yZTogdXNlIGRyYWluX2NhbGxfcmN1IGluIGluIHFtcF9kZXZpY2VfYWRkCjdmZGE0Y2Igc2Nz
aS9zY3NpX2J1czogc3dpdGNoIHNlYXJjaCBkaXJlY3Rpb24gaW4gc2NzaV9kZXZpY2VfZmluZAo3
ZDhjM2U4IHNjc2k6IHN3aXRjaCB0byBidXMtPmNoZWNrX2FkZHJlc3MKN2FhY2FiMCBxZGV2OiBh
ZGQgImNoZWNrIGlmIGFkZHJlc3MgZnJlZSIgY2FsbGJhY2sgZm9yIGJ1c2VzCgo9PT0gT1VUUFVU
IEJFR0lOID09PQoxLzEwIENoZWNraW5nIGNvbW1pdCA3YWFjYWIwYzBkMWIgKHFkZXY6IGFkZCAi
Y2hlY2sgaWYgYWRkcmVzcyBmcmVlIiBjYWxsYmFjayBmb3IgYnVzZXMpCjIvMTAgQ2hlY2tpbmcg
Y29tbWl0IDdkOGMzZTg1MjY3YSAoc2NzaTogc3dpdGNoIHRvIGJ1cy0+Y2hlY2tfYWRkcmVzcykK
RVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNTM6IEZJTEU6IGh3L3Nj
c2kvc2NzaS1idXMuYzoxMzc6CiteSV5JXkleSSAgICAgaW50IGNoYW5uZWwsIGludCB0YXJnZXQs
IGludCBsdW4sJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNTQ6
IEZJTEU6IGh3L3Njc2kvc2NzaS1idXMuYzoxMzg6CiteSV5JXkleSSAgICAgU0NTSURldmljZSAq
KnBfZGV2KSQKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM2OTogRklMRTogaHcv
c2NzaS9zY3NpLWJ1cy5jOjE1MzoKK3N0YXRpYyBib29sIHNjc2lfYnVzX2NoZWNrX2FkZHJlc3Mo
QnVzU3RhdGUgKnFidXMsIERldmljZVN0YXRlICpxZGV2LCBFcnJvciAqKmVycnApCgpXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojODk6IEZJTEU6IGh3L3Njc2kvc2NzaS1idXMuYzox
NzM6CisgICAgICAgIGlmICghc2NzaV9idXNfaXNfYWRkcmVzc19mcmVlKGJ1cywgZGV2LT5jaGFu
bmVsLCBkZXYtPmlkLCBkZXYtPmx1biwgJmQpKSB7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hh
cmFjdGVycwojMTI4OiBGSUxFOiBody9zY3NpL3Njc2ktYnVzLmM6MTk1OgorICAgICAgICAgICAg
aXNfZnJlZSA9IHNjc2lfYnVzX2lzX2FkZHJlc3NfZnJlZShidXMsIGRldi0+Y2hhbm5lbCwgKytp
ZCwgZGV2LT5sdW4sIE5VTEwpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE0
MTogRklMRTogaHcvc2NzaS9zY3NpLWJ1cy5jOjIwNToKKyAgICAgICAgICAgIGlzX2ZyZWUgPSBz
Y3NpX2J1c19pc19hZGRyZXNzX2ZyZWUoYnVzLCBkZXYtPmNoYW5uZWwsIGRldi0+aWQsICsrbHVu
LCBOVUxMKTsKCnRvdGFsOiAyIGVycm9ycywgNCB3YXJuaW5ncywgMTgyIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDIvMTAgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMTAgQ2hlY2tpbmcgY29t
bWl0IDdmZGE0Y2IyYmEzZCAoc2NzaS9zY3NpX2J1czogc3dpdGNoIHNlYXJjaCBkaXJlY3Rpb24g
aW4gc2NzaV9kZXZpY2VfZmluZCkKNC8xMCBDaGVja2luZyBjb21taXQgNWQxN2E5ZTA2MTM2IChk
ZXZpY2VfY29yZTogdXNlIGRyYWluX2NhbGxfcmN1IGluIGluIHFtcF9kZXZpY2VfYWRkKQo1LzEw
IENoZWNraW5nIGNvbW1pdCAwZjdmZjBlNjdmMWMgKGRldmljZS1jb3JlOiB1c2UgUkNVIGZvciBs
aXN0IG9mIGNoaWxkcmVuIG9mIGEgYnVzKQo2LzEwIENoZWNraW5nIGNvbW1pdCA1OWRiYmRiOGRj
N2YgKGRldmljZS1jb3JlOiB1c2UgYXRvbWljX3NldCBvbiAucmVhbGl6ZWQgcHJvcGVydHkpCjcv
MTAgQ2hlY2tpbmcgY29tbWl0IDJhNjE1ZWY4N2VjMCAoc2NzaS9zY3NpLWJ1czogc2NzaV9kZXZp
Y2VfZmluZDogZG9uJ3QgcmV0dXJuIHVucmVhbGl6ZWQgZGV2aWNlcykKOC8xMCBDaGVja2luZyBj
b21taXQgMDNiNGJjNDNjODg2IChzY3NpL3Njc2lfYnVzOiBBZGQgc2NzaV9kZXZpY2VfZ2V0KQo5
LzEwIENoZWNraW5nIGNvbW1pdCA3OGJhZjBjMjcyYTAgKHZpcnRpby1zY3NpOiB1c2Ugc2NzaV9k
ZXZpY2VfZ2V0KQoxMC8xMCBDaGVja2luZyBjb21taXQgNzIzNTVlY2Y3ZTdlIChzY3NpL3Njc2lf
YnVzOiBmaXggcmFjZXMgaW4gUkVQT1JUIExVTlMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAxMDAyMTczNTU4LjIzMjk2MC0xLXBib256aW5p
QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

