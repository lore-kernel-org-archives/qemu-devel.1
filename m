Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C247FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930F62075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930F62075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjHpH-0006zO-QE
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 03:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjHof-0006St-Ow
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 03:40:01 -0400
Resent-Date: Thu, 11 Jun 2020 03:40:01 -0400
Resent-Message-Id: <E1jjHof-0006St-Ow@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjHod-0006o8-6V
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 03:40:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591861186; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Y9g31Say+rgju2s6ODU7fBG3kNuXIHT53vksJjXQIKqez9m/zULcRLD2SFfAQt3ucF4cZTdTdJmvOevNCu/JgPVkFgWU1iQVi7+gKc/y3M6D5o6MZhaepBGM7uMy2YScGnPA9X1AuBbgfx+SIK2J+EzljpW1ZAW+2/UUnw/3bwM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591861186;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=VTa/tWMd/BWqDEhtmGThTR16+ANC4Vc0mp9th3H/Eak=; 
 b=LqoWNI+AkDGKIZWoJm+dvdgjtDY73F4H1wTEiqK3NzegV6iMQY7VtCEYQZqbqsDxK5uVdo64JpE7lbBKS4Kywdlcx5l2dZEo6xpG4eCijRpERZb+oIHj1Uq9LAhE/x8zQzNh4znW2TZ3y0p0Ercjno5/fmiA+VGP65Kia+WIj9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591861185006310.3483483061244;
 Thu, 11 Jun 2020 00:39:45 -0700 (PDT)
Message-ID: <159186118366.32061.11810142383812381547@45ef0f9c86ae>
In-Reply-To: <20200611061355.31967-1-alxndr@bu.edu>
Subject: Re: [PATCH v3] fuzz: add oss-fuzz build-script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Thu, 11 Jun 2020 00:39:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 02:55:58
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMTA2MTM1NS4zMTk2
Ny0xLWFseG5kckBidS5lZHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNjExMDYxMzU1LjMxOTY3LTEtYWx4bmRyQGJ1LmVkdQpT
dWJqZWN0OiBbUEFUQ0ggdjNdIGZ1eno6IGFkZCBvc3MtZnV6eiBidWlsZC1zY3JpcHQKVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIw
MjAwNjExMDU1ODA3LjE1OTIxLTEtaHV0aEB0dXhmYW1pbHkub3JnIC0+IHBhdGNoZXcvMjAyMDA2
MTEwNTU4MDcuMTU5MjEtMS1odXRoQHR1eGZhbWlseS5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0Jwo5NGEyNTY4IGZ1eno6IGFkZCBvc3MtZnV6eiBidWlsZC1zY3JpcHQKCj09PSBP
VVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyks
IGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI4OiAKbmV3IGZpbGUgbW9kZSAxMDA3
NTUKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxMDg6IEZJTEU6IHNjcmlwdHMvb3NzLWZ1
enovYnVpbGQuc2g6NzY6Citmb3IgaSBpbiAkKGxkZCAuL2kzODYtc29mdG1tdS9xZW11LWZ1enot
aTM4NiB8IGN1dCAtZjMgLWQnICcpOyBkbyAkCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3Ms
IDEwNiBsaW5lcyBjaGVja2VkCgpDb21taXQgOTRhMjU2OGRhYjRlIChmdXp6OiBhZGQgb3NzLWZ1
enogYnVpbGQtc2NyaXB0KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxMTA2MTM1NS4zMTk2
Ny0xLWFseG5kckBidS5lZHUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

