Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06656C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2802465B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2802465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwaR6-0007YK-3L
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iwaQO-0006xp-SC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iwaQN-0002DX-FT
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:37:40 -0500
Resent-Date: Tue, 28 Jan 2020 18:37:40 -0500
Resent-Message-Id: <E1iwaQN-0002DX-FT@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iwaQN-00027U-88; Tue, 28 Jan 2020 18:37:39 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580254644812732.4225024727649;
 Tue, 28 Jan 2020 15:37:24 -0800 (PST)
In-Reply-To: <20200128223955.464556-1-keithp@keithp.com>
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub
Message-ID: <158025464355.18399.14248917557467290837@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Tue, 28 Jan 2020 15:37:24 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: keithp@keithp.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 Alistair.Francis@wdc.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyODIyMzk1NS40NjQ1
NTYtMS1rZWl0aHBAa2VpdGhwLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwMTI4MjIzOTU1LjQ2NDU1
Ni0xLWtlaXRocEBrZWl0aHAuY29tClN1YmplY3Q6IFtQQVRDSF0gcmlzY3Y6IFNlcGFyYXRlIEZQ
VSByZWdpc3RlciBzaXplIGZyb20gY29yZSByZWdpc3RlciBzaXplIGluIGdkYnN0dWIKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXct
cHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMTU4MDI0MjE2MS0yMDMz
My0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tIC0+IHBhdGNo
ZXcvMTU4MDI0MjE2MS0yMDMzMy0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNA
cnQtcmsuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDAxMjgyMjM5NTUuNDY0
NTU2LTEta2VpdGhwQGtlaXRocC5jb20gLT4gcGF0Y2hldy8yMDIwMDEyODIyMzk1NS40NjQ1NTYt
MS1rZWl0aHBAa2VpdGhwLmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwMTI4
MjMxODQwLjUwODk4Ni0xLWtlaXRocEBrZWl0aHAuY29tIC0+IHBhdGNoZXcvMjAyMDAxMjgyMzE4
NDAuNTA4OTg2LTEta2VpdGhwQGtlaXRocC5jb20KICogW25ldyB0YWddICAgICAgICAgcGF0Y2hl
dy8yMDIwMDEyODIzMzIxNi41MTUxNzEtMS1rZWl0aHBAa2VpdGhwLmNvbSAtPiBwYXRjaGV3LzIw
MjAwMTI4MjMzMjE2LjUxNTE3MS0xLWtlaXRocEBrZWl0aHAuY29tClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKYTJjMjc3YiByaXNjdjogU2VwYXJhdGUgRlBVIHJlZ2lzdGVyIHNpemUg
ZnJvbSBjb3JlIHJlZ2lzdGVyIHNpemUgaW4gZ2Ric3R1YgoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
RVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRl
bWVudAojNDU6IEZJTEU6IHRhcmdldC9yaXNjdi9nZGJzdHViLmM6MzA2OgorICAgICAgICBpZiAo
ZW52LT5taXNhICYgUlZEKQpbLi4uXQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1NCBs
aW5lcyBjaGVja2VkCgpDb21taXQgYTJjMjc3YjhlYjM5IChyaXNjdjogU2VwYXJhdGUgRlBVIHJl
Z2lzdGVyIHNpemUgZnJvbSBjb3JlIHJlZ2lzdGVyIHNpemUgaW4gZ2Ric3R1YikgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAyMDAxMjgyMjM5NTUuNDY0NTU2LTEta2VpdGhwQGtlaXRocC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

