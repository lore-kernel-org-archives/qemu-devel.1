Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621E920720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621E920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIjB-0002ST-Kw
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrIi6-0000HJ-4U; Fri, 03 Jul 2020 06:14:22 -0400
Resent-Date: Fri, 03 Jul 2020 06:14:22 -0400
Resent-Message-Id: <E1jrIi6-0000HJ-4U@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrIi1-0007A6-Kl; Fri, 03 Jul 2020 06:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593771249; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ne+F7/gXdOsGREPyMIGhOTK8DE5YvDkpwNhLvXiPkq4U164ZbOWr3jCiHQf0cPtofOu52FFGFuTTDcLSft6S448EYzuIUEtqQq4S3INUNByzKsJF4oXAKmVATSWmQR5HloA/SBaiaev+pvMvNhUcU00ju+4L6ZneOGdgQahc7+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593771249;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=O+CZkMQ9CMxBaBxsxIu8fuEt3ChbD2v1qS6GeHHMTIA=; 
 b=gdVCcPzmYYaignGccG7DOZbbwYY/JqROF5xvyA6QlZ3i4HGjen2OZosA/Le2keXqqbpjZvW83B+AVLrOhBJa2JUijFBLZ8qABZy6lN3uaj3BBp/2VR4IBjdRnHjy+9c2g8qfG7fDxRKNTE6E1c2+UMYdzKXcXgy+g2roSoklks8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593771247704719.1417020596072;
 Fri, 3 Jul 2020 03:14:07 -0700 (PDT)
Message-ID: <159377124646.11379.2784795370937297646@d1fd068a5071>
Subject: Re: [PULL 0/7] Block layer patches
In-Reply-To: <20200703092143.165594-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Fri, 3 Jul 2020 03:14:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:31:20
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMzA5MjE0My4xNjU1
OTQtMS1rd29sZkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCAwLzddIEJsb2NrIGxheWVyIHBhdGNoZXMKVHlwZTog
c2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNzAzMDkyMTQzLjE2NTU5NC0xLWt3b2xmQHJlZGhhdC5j
b20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3
LzIwMjAwNzAzMDkyMTQzLjE2NTU5NC0xLWt3b2xmQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIw
MDcwMzA5MjE0My4xNjU1OTQtMS1rd29sZkByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKNjVlNmYxNSBpb3Rlc3RzOiBGaXggMDUxIG91dHB1dCBhZnRlciBxZGV2X2lu
aXRfbm9mYWlsKCkgcmVtb3ZhbApjZmQ3OGNlIGlvdGVzdHMucHk6IERvIG5vdCB3YWl0KCkgYmVm
b3JlIGNvbW11bmljYXRlKCkKMGQwYTc5OCB2dmZhdDogRml4IGFycmF5X3JlbW92ZV9zbGljZSgp
CjU3N2M0MTEgdnZmYXQ6IENoZWNrIHRoYXQgdXBkYXRlZCBmaWxlbmFtZXMgYXJlIHZhbGlkCjAz
OTdjNTQgcWVtdS1zdG9yYWdlLWRhZW1vbjogYWRkIG1pc3NpbmcgY2xlYW51cCBjYWxscwpmNDZm
YzMwIHFlbXUtc3RvcmFnZS1kYWVtb246IHJlbWVtYmVyIHRvIGFkZCBxZW11X29iamVjdF9vcHRz
CmFlZGE1MDcgcWVtdS1pbWcgY29udmVydDogRG9uJ3QgcHJlLXplcm8gaW1hZ2VzCgo9PT0gT1VU
UFVUIEJFR0lOID09PQoxLzcgQ2hlY2tpbmcgY29tbWl0IGFlZGE1MDdkOGQ4YyAocWVtdS1pbWcg
Y29udmVydDogRG9uJ3QgcHJlLXplcm8gaW1hZ2VzKQoyLzcgQ2hlY2tpbmcgY29tbWl0IGY0NmZj
MzAxODc1NyAocWVtdS1zdG9yYWdlLWRhZW1vbjogcmVtZW1iZXIgdG8gYWRkIHFlbXVfb2JqZWN0
X29wdHMpCjMvNyBDaGVja2luZyBjb21taXQgMDM5N2M1NDFhODVlIChxZW11LXN0b3JhZ2UtZGFl
bW9uOiBhZGQgbWlzc2luZyBjbGVhbnVwIGNhbGxzKQo0LzcgQ2hlY2tpbmcgY29tbWl0IDU3N2M0
MTFlOTI2OCAodnZmYXQ6IENoZWNrIHRoYXQgdXBkYXRlZCBmaWxlbmFtZXMgYXJlIHZhbGlkKQpF
UlJPUjogIihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgojMzQ6IEZJTEU6IGJsb2NrL3Z2ZmF0
LmM6NTI2OgorICAgIGlmICghc3RyY21wKChjb25zdCBjaGFyKiluYW1lLCAiLiIpIHx8ICFzdHJj
bXAoKGNvbnN0IGNoYXIqKW5hbWUsICIuLiIpKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDQyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKNS83IENoZWNraW5nIGNvbW1pdCAwZDBhNzk4ZGI4MTQgKHZ2ZmF0OiBGaXggYXJyYXlfcmVt
b3ZlX3NsaWNlKCkpCjYvNyBDaGVja2luZyBjb21taXQgY2ZkNzhjZTNjZjA3IChpb3Rlc3RzLnB5
OiBEbyBub3Qgd2FpdCgpIGJlZm9yZSBjb21tdW5pY2F0ZSgpKQo3LzcgQ2hlY2tpbmcgY29tbWl0
IDY1ZTZmMTVhZDlhYiAoaW90ZXN0czogRml4IDA1MSBvdXRwdXQgYWZ0ZXIgcWRldl9pbml0X25v
ZmFpbCgpIHJlbW92YWwpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNzAzMDkyMTQzLjE2NTU5NC0xLWt3b2xmQHJlZGhhdC5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

