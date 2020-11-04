Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D1BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8192087D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8192087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMv4-0002E8-Ez
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaMuD-0001k2-6J; Wed, 04 Nov 2020 12:49:09 -0500
Resent-Date: Wed, 04 Nov 2020 12:49:09 -0500
Resent-Message-Id: <E1kaMuD-0001k2-6J@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaMuA-0002fV-Eu; Wed, 04 Nov 2020 12:49:08 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604512126; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GG7IICktHYuwsbAUsXuLH/4+ZwNCIyIl1r0ZxFaNgE+lpW9nTx1OQJbmp1WCSevU9VSXuhaiyjcMLqg7P0LeZ50sHpSMDwZHlPxowSKw7nUNzxAS7OCP3DRdD0toF++fm8pbqCe62K0BlQ4Jq8wuAukclQGgvBhOd0KHgjy83xY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604512126;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JEwH0nebTje3xO1n7i2JUTpMKrzgCoIPvdugZqG854U=; 
 b=DFJJCPpnT9uSGAOZSPoEyZriBmtEqVUXL9pmTyUAaTh78vKIQVPVUfFEXocDZXA/iI+q0RJmRK0f5l6VBbOccUivQpP+6U6gW50EcMm24hD6uhRpMI9wf+TSvfBUFfWgESAhCtPNFq4HHfYYZKFZwHowAVa4NvB05CdnhkLLc3M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604512123981998.150808443765;
 Wed, 4 Nov 2020 09:48:43 -0800 (PST)
Subject: Re: [PATCH 0/5] SCSI: fix transfer limits for SCSI passthrough
Message-ID: <160451212210.17446.5025535715832636959@66eaa9a8a123>
In-Reply-To: <20201104173217.417538-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Wed, 4 Nov 2020 09:48:43 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 11:37:10
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 qemu-block@nongnu.org, pl@kamp.de, qemu-devel@nongnu.org, tom.ty89@gmail.com,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwNDE3MzIxNy40MTc1
MzgtMS1tbGV2aXRza0ByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDExMDQxNzMyMTcuNDE3
NTM4LTEtbWxldml0c2tAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggMC81XSBTQ1NJOiBmaXgg
dHJhbnNmZXIgbGltaXRzIGZvciBTQ1NJIHBhc3N0aHJvdWdoCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
ICBiMTI2NmI2Li4zYzhjMzZjICBtYXN0ZXIgICAgIC0+IG1hc3RlcgogLSBbdGFnIHVwZGF0ZV0g
ICAgICBwYXRjaGV3LzIwMjAxMTA0MTYwMDIxLjIzNDIxMDgtMS1laGFia29zdEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAyMDExMDQxNjAwMjEuMjM0MjEwOC0xLWVoYWJrb3N0QHJlZGhhdC5jb20K
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTEwNDE3MzIxNy40MTc1MzgtMS1tbGV2
aXRza0ByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDExMDQxNzMyMTcuNDE3NTM4LTEtbWxldml0
c2tAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmJkZTYzNzEgYmxv
Y2svc2NzaTogY29ycmVjdGx5IGVtdWxhdGUgdGhlIFZQRCBibG9jayBsaW1pdHMgcGFnZQpjNDE4
MGQ2IGJsb2NrOiB1c2UgYmxrX2dldF9tYXhfaW9jdGxfdHJhbnNmZXIgZm9yIFNDU0kgcGFzc3Ro
cm91Z2gKOWZmN2VkYyBibG9jazogYWRkIG1heF9pb2N0bF90cmFuc2ZlciB0byBCbG9ja0xpbWl0
cwpkZDJmMWY3IGZpbGUtcG9zaXg6IGFkZCBzZ19nZXRfbWF4X3NlZ21lbnRzIHRoYXQgYWN0dWFs
bHkgd29ya3Mgd2l0aCBzZwpmOWFkOTQwIGZpbGUtcG9zaXg6IHNwbGl0IGhkZXZfcmVmcmVzaF9s
aW1pdHMgZnJvbSByYXdfcmVmcmVzaF9saW1pdHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNSBD
aGVja2luZyBjb21taXQgZjlhZDk0MDBlMDExIChmaWxlLXBvc2l4OiBzcGxpdCBoZGV2X3JlZnJl
c2hfbGltaXRzIGZyb20gcmF3X3JlZnJlc2hfbGltaXRzKQoyLzUgQ2hlY2tpbmcgY29tbWl0IGRk
MmYxZjc3YTVkMiAoZmlsZS1wb3NpeDogYWRkIHNnX2dldF9tYXhfc2VnbWVudHMgdGhhdCBhY3R1
YWxseSB3b3JrcyB3aXRoIHNnKQozLzUgQ2hlY2tpbmcgY29tbWl0IDlmZjdlZGMzMTAwMiAoYmxv
Y2s6IGFkZCBtYXhfaW9jdGxfdHJhbnNmZXIgdG8gQmxvY2tMaW1pdHMpCjQvNSBDaGVja2luZyBj
b21taXQgYzQxODBkNmFjY2ZmIChibG9jazogdXNlIGJsa19nZXRfbWF4X2lvY3RsX3RyYW5zZmVy
IGZvciBTQ1NJIHBhc3N0aHJvdWdoKQo1LzUgQ2hlY2tpbmcgY29tbWl0IGJkZTYzNzEzOTUzNiAo
YmxvY2svc2NzaTogY29ycmVjdGx5IGVtdWxhdGUgdGhlIFZQRCBibG9jayBsaW1pdHMgcGFnZSkK
RVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRl
bWVudAojNTE6IEZJTEU6IGh3L3Njc2kvc2NzaS1nZW5lcmljLmM6MTk2OgorICAgICAgICAgICAg
aWYgKHBhZ2VfaWR4ID49IHItPmJ1ZmxlbikKWy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgNTMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8y
MDIwMTEwNDE3MzIxNy40MTc1MzgtMS1tbGV2aXRza0ByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

