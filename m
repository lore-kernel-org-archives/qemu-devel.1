Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA41C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A5F217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A5F217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56Wm-0007Zq-DU
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i56Vq-000775-Fz
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i56Vl-0003zA-SH
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:58:14 -0400
Resent-Date: Tue, 03 Sep 2019 06:58:11 -0400
Resent-Message-Id: <E1i56Vl-0003zA-SH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i56Vj-0003tE-Vg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567508059; cv=none; d=zoho.com; s=zohoarc; 
 b=iKgKWeYxnJny65O653p5Up2+dIs1haeNC/R5y01OvMWmTcp3UDQElOpE5q1CieAJHUq6XR7aHq/8jabNY1Pa0c6NQdn2uEbWB5oRnOylJYxktDFhOG/S6aVr8rhHw5DSYFCx904O5+ECa/XDCArEWdXnwjQuyHh0xy+5lvA08DI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567508059;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=d5IhP7zezyFuTIk47aaaUxzKth7CF6DXlg6DaFbRG14=; 
 b=L7dwccGgmeLNlONa6yHTcsohY9XMaMYRL9/USpc/kxOq49uc2s1EUppLn2qNz+qJQEzowx1melyLEr41Y44XkhHSjrdbw4TYTk9kHjw0JoGanRoPfVZOt4tjDHSWRhJz7O/b+6UHG4YfJQ9zkwKRDk6zttV+U/1PwsdhB1OF2U0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567508057035631.2385260108742;
 Tue, 3 Sep 2019 03:54:17 -0700 (PDT)
In-Reply-To: <cover.1567500411.git.lukasstraub2@web.de>
Message-ID: <156750805552.17101.2070848121573617872@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lukasstraub2@web.de
Date: Tue, 3 Sep 2019 03:54:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v3 0/4] colo: Add support for continious
 replication
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, chen.zhang@intel.com,
 xiechanglong.d@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTY3NTAwNDExLmdp
dC5sdWthc3N0cmF1YjJAd2ViLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzIDAvNF0gY29sbzogQWRk
IHN1cHBvcnQgZm9yIGNvbnRpbmlvdXMgcmVwbGljYXRpb24KVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IGNvdmVyLjE1Njc1MDA0MTEuZ2l0Lmx1a2Fzc3RyYXViMkB3ZWIuZGUKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMGExY2Yy
NyBjb2xvOiBVcGRhdGUgRG9jdW1lbnRhdGlvbiBmb3IgY29udGluaW91cyByZXBsaWNhdGlvbgpj
Nzg5Mjg3IG5ldC9maWx0ZXIuYzogQWRkIE9wdGlvbnMgdG8gaW5zZXJ0IGZpbHRlcnMgYW55d2hl
cmUgaW4gdGhlIGZpbHRlciBsaXN0CjgxZDA2MDcgdGVzdHMvdGVzdC1yZXBsaWNhdGlvbi5jOiBB
ZGQgdGVzdCBmb3IgaWdub3JpbmcgcmVxdWVzdHMgYWZ0ZXIgZmFpbG92ZXIKYTE3N2Y4NiBibG9j
ay9yZXBsaWNhdGlvbi5jOiBJZ25vcmUgcmVxdWVzdHMgYWZ0ZXIgZmFpbG92ZXIKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgYTE3N2Y4NjIxMWE3IChibG9jay9yZXBs
aWNhdGlvbi5jOiBJZ25vcmUgcmVxdWVzdHMgYWZ0ZXIgZmFpbG92ZXIpCjIvNCBDaGVja2luZyBj
b21taXQgODFkMDYwNzMyNzgxICh0ZXN0cy90ZXN0LXJlcGxpY2F0aW9uLmM6IEFkZCB0ZXN0IGZv
ciBpZ25vcmluZyByZXF1ZXN0cyBhZnRlciBmYWlsb3ZlcikKRVJST1I6IHNwYWNlIHByb2hpYml0
ZWQgYWZ0ZXIgdGhhdCBvcGVuIHBhcmVudGhlc2lzICcoJwojNDE6IEZJTEU6IHRlc3RzL3Rlc3Qt
cmVwbGljYXRpb24uYzo1MTQ6CisgICAgcmVwbGljYXRpb25fc3RvcF9hbGwoIHRydWUsICZsb2Nh
bF9lcnIpOwoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCBvcGVuIHBhcmVudGhl
c2lzICcoJwojNTU6IEZJTEU6IHRlc3RzL3Rlc3QtcmVwbGljYXRpb24uYzo1Mjg6CisgICAgcmVw
bGljYXRpb25fc3RvcF9hbGwoIHRydWUsICZsb2NhbF9lcnIpOwoKdG90YWw6IDIgZXJyb3JzLCAw
IHdhcm5pbmdzLCA2NCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzQgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KCjMvNCBDaGVja2luZyBjb21taXQgYzc4OTI4Nzg1YTlmIChuZXQvZmlsdGVyLmM6
IEFkZCBPcHRpb25zIHRvIGluc2VydCBmaWx0ZXJzIGFueXdoZXJlIGluIHRoZSBmaWx0ZXIgbGlz
dCkKNC80IENoZWNraW5nIGNvbW1pdCAwYTFjZjI3MDcwZGUgKGNvbG86IFVwZGF0ZSBEb2N1bWVu
dGF0aW9uIGZvciBjb250aW5pb3VzIHJlcGxpY2F0aW9uKQo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTY3NTAwNDExLmdpdC5sdWthc3N0
cmF1YjJAd2ViLmRlL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


