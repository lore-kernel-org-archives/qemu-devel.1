Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC201C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8516520853
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8516520853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjX9h-000768-P0
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 20:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjX8z-0006gG-94
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 20:02:01 -0400
Resent-Date: Thu, 11 Jun 2020 20:02:01 -0400
Resent-Message-Id: <E1jjX8z-0006gG-94@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjX8w-0005de-Uq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 20:02:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591920110; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ExvQDYhg/AdGDFT9GPWKVVeTZrsvYsBhpA1SvHk4OOnGrbIyDB17Obecy55Q5VNU+6XpQFjsE4RqmuI6sQsAkkREIl1J88Us8XROX1LkZ4srhtO0tYVMaoyduF6PVEwKJW4p/SY32SfcpHN/TpugCXoe0NH1D1ITb5DcQ4WFPaQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591920110;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KGrJZYSSejqzSAWzW6C1mOOlDWq62bhNdg02j7y4YP4=; 
 b=IIvvN0FPC8zv9EhBER8N7LYm83a66wlE+oq06pt3Nw6hJR6h3FID4yZnqf74FTT4+5v5sCb/1wzqOiMnk0zGsblwab9Lrr0XECm0Cn3lBAmMJFmNWvrjIyUBIHsEr1anVNncN3PSUOJtvWe/osF9fVMdpdjcCNSx2LxHy8KnEVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591920109024709.779771451084;
 Thu, 11 Jun 2020 17:01:49 -0700 (PDT)
Message-ID: <159192010800.1247.9525195647123498948@45ef0f9c86ae>
In-Reply-To: <20200611165112.30979-1-mst@redhat.com>
Subject: Re: [PATCH] tests: disassemble-asm.sh: generate AML in readable format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Thu, 11 Jun 2020 17:01:49 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 19:16:13
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMTE2NTExMi4zMDk3
OS0xLW1zdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDYxMTE2NTExMi4zMDk3OS0xLW1zdEByZWRoYXQuY29t
ClN1YmplY3Q6IFtQQVRDSF0gdGVzdHM6IGRpc2Fzc2VtYmxlLWFzbS5zaDogZ2VuZXJhdGUgQU1M
IGluIHJlYWRhYmxlIGZvcm1hdApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTY1NzFlNiB0ZXN0czogZGlz
YXNzZW1ibGUtYXNtLnNoOiBnZW5lcmF0ZSBBTUwgaW4gcmVhZGFibGUgZm9ybWF0Cgo9PT0gT1VU
UFVUIEJFR0lOID09PQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxNjogCm5ldyBmaWxlIG1vZGUgMTAwNzU1
CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzA6IEZJTEU6IHRlc3RzL2RhdGEv
YWNwaS9kaXNhc3NlbWxlLWFtbC5zaDoxMDoKKyAgICAgICAgZWNobyAiVXNhZ2U6IC4vdGVzdHMv
ZGF0YS9hY3BpL2Rpc2Fzc2VtbGUtYW1sLnNoIFstbyA8b3V0cHV0LWRpcmVjdG9yeT5dIgoKRVJS
T1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzMzOiBGSUxFOiB0ZXN0cy9kYXRhL2FjcGkvZGlzYXNz
ZW1sZS1hbWwuc2g6MTM6CisgICAgJAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzcwOiBG
SUxFOiB0ZXN0cy9kYXRhL2FjcGkvZGlzYXNzZW1sZS1hbWwuc2g6NTA6CisgICAgICAgIGlhc2wg
LWQgLXAgJHthc2x9ICR7ZXh0cmF9ICR7YW1sfSAkCgp0b3RhbDogMiBlcnJvcnMsIDIgd2Fybmlu
Z3MsIDUyIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA5NjU3MWU2MzFiZmIgKHRlc3RzOiBkaXNhc3Nl
bWJsZS1hc20uc2g6IGdlbmVyYXRlIEFNTCBpbiByZWFkYWJsZSBmb3JtYXQpIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNjExMTY1MTEyLjMwOTc5LTEtbXN0QHJlZGhhdC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

