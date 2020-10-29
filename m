Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C5C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4233120724
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 15:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4233120724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9X6-0004Le-7X
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 11:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kY9UD-00015p-2v
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:05:09 -0400
Resent-Date: Thu, 29 Oct 2020 11:05:09 -0400
Resent-Message-Id: <E1kY9UD-00015p-2v@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kY9UA-0002iw-HI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 11:05:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603983861; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UmV/hA888rD+rsfXSi++kQRJXr4Hgj3UXAClKSxYsYuZshUc/DuVjRQKbt6e69FoIlBSrKef6836U6R0QvcSZfBEJtAYoYAjzgdsy/4wTNC2jTt3tyLWYd0td8GKNa7xMiEVRFFhSQD36MJ01L47+KLQ/TsMZpkRfb70CU7cGhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603983861;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=UL0Z1qFkMjIUvUNUyH+XNnuq06hy46PDbPIGwbfLf1w=; 
 b=FW9Mr+XwNsKEYW9L3OrD9It8VcseJtbyDF5Mj1q0xA2K1nLkwQkPk9nfJrL3SvpVRE2miWLS6sqCfBxx15vSP7ajTp4u1lS7ivZhnNZvEmSmhlkV8DELxxE8ZVS0JvQSdtuMGG2fkG95QYeBJ5CwTnJvNe549z15c7FGlRpjMws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603983857141794.961034360629;
 Thu, 29 Oct 2020 08:04:17 -0700 (PDT)
Subject: Re: [PATCH] spaces are required in some places
Message-ID: <160398385565.11191.16172040000588233087@66eaa9a8a123>
In-Reply-To: <34e5417e-f81d-e399-ae2c-0f27467a5f43@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: chaihaoyu1@huawei.com
Date: Thu, 29 Oct 2020 08:04:17 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 11:05:03
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
Cc: alex.chen@huawei.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 hunongda@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8zNGU1NDE3ZS1mODFkLWUzOTkt
YWUyYy0wZjI3NDY3YTVmNDNAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDM0ZTU0MTdlLWY4MWQt
ZTM5OS1hZTJjLTBmMjc0NjdhNWY0M0BodWF3ZWkuY29tClN1YmplY3Q6IFtQQVRDSF0gc3BhY2Vz
IGFyZSByZXF1aXJlZCBpbiBzb21lIHBsYWNlcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiZDkyYmViIHNwYWNlcyBhcmUgcmVx
dWlyZWQgaW4gc29tZSBwbGFjZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBUaGUgY29y
cmVjdCBmb3JtIGlzICJTaWduZWQtb2ZmLWJ5IgojNzogCiAgICBzaWduZWQtb2ZmLWJ5OiBIYW95
dSBDaGFpPGNoYWloYW95dTFAaHVhd2VpLmNvbT4KCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFy
YWN0ZXJzCiM2ODogRklMRTogc29mdG1tdS9tZW1vcnkuYzoyMzgzOgorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVvZigqbXItPmlvZXZlbnRmZHMpICogbXItPmlvZXZlbnRm
ZF9uYiArIDEpOwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MCBsaW5lcyBjaGVja2Vk
CgpDb21taXQgYmQ5MmJlYjY1NzNjIChzcGFjZXMgYXJlIHJlcXVpcmVkIGluIHNvbWUgcGxhY2Vz
KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8zNGU1NDE3ZS1mODFkLWUzOTktYWUyYy0wZjI3NDY3YTVm
NDNAaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

