Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C20C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD944206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD944206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7f8-0007OH-O0
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kc7dM-0005F0-Ia
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:55:00 -0500
Resent-Date: Mon, 09 Nov 2020 08:55:00 -0500
Resent-Message-Id: <E1kc7dM-0005F0-Ia@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kc7dJ-0005m3-Vn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:55:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604930087; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IlJZ0pap/XCj+rJkBr5Pp3NH3s2W1tcs44kFW19GdaAViLJHzvtPKsbeeqbBpQLbdCUE+4ZeeU+oK+NHZUts/9VLJKuHibVWg07v1hAZ1vEUJ5NM1g9+a5o+m+dFQOMcb28yldEUOMMW/+lcxxu0vTvfx1FVAJ0VkBt4x7rhWhE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604930087;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GCsFFJ7L/yKTOS5+FRLEHYGat1UOpXCUB1O3WzST8OM=; 
 b=LXOe7KsWcVt5RAnE/l0Wrya61HRpAgwEjsG810Drl+qLt1XbPMh4162qgvgrT+z0P0jjrKX2fmyEaI38CVGBRV9E3zu049p0sg5uS2AX8zXd6wTTOiG0MS/xNoPCYsrua9igrzwKGYQ45xHlwI5L5OWwcMMPmhNttIc9Z+RhwzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604930085749420.9155269202298;
 Mon, 9 Nov 2020 05:54:45 -0800 (PST)
Message-ID: <160493008457.17418.6072484315307260437@b92d57cec08d>
Subject: Re: [PATCH v2 for-5.2 0/6] Deprecate or forbid crazy QemuOpts cases
In-Reply-To: <20201109133931.979563-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Mon, 9 Nov 2020 05:54:45 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 08:54:53
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwOTEzMzkzMS45Nzk1
NjMtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMTEwOTEzMzkzMS45Nzk1NjMtMS1wYm9uemlu
aUByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiBmb3ItNS4yIDAvNl0gRGVwcmVjYXRlIG9y
IGZvcmJpZCBjcmF6eSBRZW11T3B0cyBjYXNlcwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8
IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0
aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDExMDQxNzI1MTIuMjM4MTY1Ni0x
LWVoYWJrb3N0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMTEwNDE3MjUxMi4yMzgxNjU2LTEt
ZWhhYmtvc3RAcmVkaGF0LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMTA1
MTcxMTI2Ljg4MDE0LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIw
MjAxMTA1MTcxMTI2Ljg4MDE0LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwogLSBbdGFn
IHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMTA1MjIxOTA1LjEzNTAtMS1kYnVvbm9AbGludXgu
dm5ldC5pYm0uY29tIC0+IHBhdGNoZXcvMjAyMDExMDUyMjE5MDUuMTM1MC0xLWRidW9ub0BsaW51
eC52bmV0LmlibS5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTEwNjEyNDI0
MS4xNjk1MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbSAtPiBwYXRjaGV3LzIwMjAxMTA2MTI0
MjQxLjE2OTUwLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tCiAqIFtuZXcgdGFnXSAgICAgICAg
IHBhdGNoZXcvMjAyMDExMDkxMzM5MzEuOTc5NTYzLTEtcGJvbnppbmlAcmVkaGF0LmNvbSAtPiBw
YXRjaGV3LzIwMjAxMTA5MTMzOTMxLjk3OTU2My0xLXBib256aW5pQHJlZGhhdC5jb20KIC0gW3Rh
ZyB1cGRhdGVdICAgICAgcGF0Y2hldy81RkE0MTQ0OC40MDQwNDA0QGh1YXdlaS5jb20gLT4gcGF0
Y2hldy81RkE0MTQ0OC40MDQwNDA0QGh1YXdlaS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0Jwo1MGM4OGI4IHFlbXUtb3B0aW9uOiB3YXJuIGZvciBzaG9ydC1mb3JtIGJvb2xlYW4g
b3B0aW9ucwo1YWIyMjIwIHFlbXUtb3B0aW9uOiBtb3ZlIGhlbHAgaGFuZGxpbmcgdG8gZ2V0X29w
dF9uYW1lX3ZhbHVlCmZjMjYxOWQgcWVtdS1vcHRpb246IGNsZWFuIHVwIGlkIHZzLiBsaXN0LT5t
ZXJnZV9saXN0cwplMTc2MTdmIHFlbXUtb3B0aW9uOiByZXN0cmljdCBxZW11X29wdHNfc2V0IHRv
IG1lcmdlLWxpc3RzIFFlbXVPcHRzCjc3MzlmMDYgcWVtdS1vcHRpb246IHBhc3MgUWVtdU9wdHNM
aXN0IHRvIG9wdHNfYWNjZXB0c19hbnkKYzE2NzZlNSBxZW11LW9wdGlvbjogc2ltcGxpZnkgc2Vh
cmNoIGZvciBlbmQgb2Yga2V5Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29t
bWl0IGMxNjc2ZTUxNDI4NiAocWVtdS1vcHRpb246IHNpbXBsaWZ5IHNlYXJjaCBmb3IgZW5kIG9m
IGtleSkKMi82IENoZWNraW5nIGNvbW1pdCA3NzM5ZjA2MGM1NjcgKHFlbXUtb3B0aW9uOiBwYXNz
IFFlbXVPcHRzTGlzdCB0byBvcHRzX2FjY2VwdHNfYW55KQozLzYgQ2hlY2tpbmcgY29tbWl0IGUx
NzYxN2ZkNTA4MSAocWVtdS1vcHRpb246IHJlc3RyaWN0IHFlbXVfb3B0c19zZXQgdG8gbWVyZ2Ut
bGlzdHMgUWVtdU9wdHMpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzMjogRklM
RTogaW5jbHVkZS9xZW11L29wdGlvbi5oOjEyMjoKK2Jvb2wgcWVtdV9vcHRzX3NldChRZW11T3B0
c0xpc3QgKmxpc3QsIGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0IGNoYXIgKnZhbHVlLCBFcnJvciAq
KmVycnApOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzQ2OiBGSUxFOiBzb2Z0
bW11L3ZsLmM6MzExMDoKKyAgICAgICAgICAgICAgICBxZW11X29wdHNfc2V0KHFlbXVfZmluZF9v
cHRzKCJtYWNoaW5lIiksICJrZXJuZWwiLCBvcHRhcmcsICZlcnJvcl9hYm9ydCk7CgpXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNTE6IEZJTEU6IHNvZnRtbXUvdmwuYzozMTEzOgor
ICAgICAgICAgICAgICAgIHFlbXVfb3B0c19zZXQocWVtdV9maW5kX29wdHMoIm1hY2hpbmUiKSwg
ImluaXRyZCIsIG9wdGFyZywgJmVycm9yX2Fib3J0KTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBj
aGFyYWN0ZXJzCiM1NjogRklMRTogc29mdG1tdS92bC5jOjMxMTY6CisgICAgICAgICAgICAgICAg
cWVtdV9vcHRzX3NldChxZW11X2ZpbmRfb3B0cygibWFjaGluZSIpLCAiYXBwZW5kIiwgb3B0YXJn
LCAmZXJyb3JfYWJvcnQpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzYxOiBG
SUxFOiBzb2Z0bW11L3ZsLmM6MzExOToKKyAgICAgICAgICAgICAgICBxZW11X29wdHNfc2V0KHFl
bXVfZmluZF9vcHRzKCJtYWNoaW5lIiksICJkdGIiLCBvcHRhcmcsICZlcnJvcl9hYm9ydCk7CgpF
UlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzcxOiBGSUxFOiBzb2Z0bW11L3ZsLmM6MzIy
OToKKyAgICAgICAgICAgICAgICBxZW11X29wdHNfc2V0KHFlbXVfZmluZF9vcHRzKCJtYWNoaW5l
IiksICJmaXJtd2FyZSIsIG9wdGFyZywgJmVycm9yX2Fib3J0KTsKCldBUk5JTkc6IGxpbmUgb3Zl
ciA4MCBjaGFyYWN0ZXJzCiMxNTI6IEZJTEU6IHV0aWwvcWVtdS1vcHRpb24uYzo2ODQ6Citib29s
IHFlbXVfb3B0c19zZXQoUWVtdU9wdHNMaXN0ICpsaXN0LCBjb25zdCBjaGFyICpuYW1lLCBjb25z
dCBjaGFyICp2YWx1ZSwgRXJyb3IgKiplcnJwKQoKdG90YWw6IDEgZXJyb3JzLCA2IHdhcm5pbmdz
LCAxMjAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cgo0LzYgQ2hlY2tpbmcgY29tbWl0IGZjMjYxOWQ2ZTQ0YyAocWVtdS1vcHRpb246IGNsZWFuIHVw
IGlkIHZzLiBsaXN0LT5tZXJnZV9saXN0cykKNS82IENoZWNraW5nIGNvbW1pdCA1YWIyMjIwMzAy
YmEgKHFlbXUtb3B0aW9uOiBtb3ZlIGhlbHAgaGFuZGxpbmcgdG8gZ2V0X29wdF9uYW1lX3ZhbHVl
KQo2LzYgQ2hlY2tpbmcgY29tbWl0IDUwYzg4YjhmNzkyOSAocWVtdS1vcHRpb246IHdhcm4gZm9y
IHNob3J0LWZvcm0gYm9vbGVhbiBvcHRpb25zKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojODE6IEZJTEU6IHV0aWwvcWVtdS1vcHRpb24uYzo4MDM6CisgICAgICAgICAgICAgICAg
d2Fybl9yZXBvcnQoInNob3J0LWZvcm0gYm9vbGVhbiBvcHRpb24gJyVzJXMnIGRlcHJlY2F0ZWQi
LCBwcmVmaXgsICpuYW1lKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMDA6
IEZJTEU6IHV0aWwvcWVtdS1vcHRpb24uYzo4MzQ6CisgICAgICAgIHAgPSBnZXRfb3B0X25hbWVf
dmFsdWUocCwgZmlyc3RuYW1lLCB3YXJuX29uX2ZsYWcsIGhlbHBfd2FudGVkLCAmb3B0aW9uLCAm
dmFsdWUpOwoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdzLCAxMjcgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggNi82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAxMTA5MTMzOTMxLjk3OTU2My0xLXBi
b256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

