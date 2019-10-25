Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB029CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB52F21872
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB52F21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAIf-0004VM-Rj
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iO9AI-0001cw-DM
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iO9AG-00087V-MB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:38:41 -0400
Resent-Date: Fri, 25 Oct 2019 19:38:41 -0400
Resent-Message-Id: <E1iO9AG-00087V-MB@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iO9AG-000876-Gz; Fri, 25 Oct 2019 19:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572046698; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YmMG0WAeiuC3nYh54bo0mK4uuU081Up1jejCHeD3/rpOwDj222b87h6G4Z1jveR8FHq2LSvtXKCxzh282CwUXVPF6Imigyjh6H5qAwlbwZlf516P3Bu8XXkwENrGSiGkl1Y8Il1BYAgLAHPLq6KHAMEtq042MA/G2nlnQ95jVAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572046698;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=AdTgeT1R0hv76y7kXaz1wUQ2rOEVfoauxbHVLc+e2O8=; 
 b=Mm5ieEPkpRP4lbsDcWf4rxTxnfg3aWFONHPMgr0JjmMqqfdPk/q8vdTMEmbGiJhjIUKU+/K9PyZRtq2xWSfO4UKVqwmWYgryY8rfq7cshzfHcGqDdu4h0GvcokEvhvqqIaZ1BrBRtTxxJ89hcNnm73l8aH38FSOzMCcOfndWTtY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572046697249500.1252944150184;
 Fri, 25 Oct 2019 16:38:17 -0700 (PDT)
In-Reply-To: <1571996163-27688-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Subject: Re: [PATCH 0/4] SCSI COMPARE_AND_WRITE support
Message-ID: <157204669580.8606.13428122663229251872@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: baiyaowei@cmss.chinamobile.com
Date: Fri, 25 Oct 2019 16:38:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, yangjun@cmss.chinamobile.com,
 baiyaowei@cmss.chinamobile.com, pbonzini@redhat.com, dillaman@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxOTk2MTYzLTI3Njg4LTEt
Z2l0LXNlbmQtZW1haWwtYmFpeWFvd2VpQGNtc3MuY2hpbmFtb2JpbGUuY29tLwoKCgpIaSwKClRo
aXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBv
dXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC80XSBT
Q1NJIENPTVBBUkVfQU5EX1dSSVRFIHN1cHBvcnQKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1
NzE5OTYxNjMtMjc2ODgtMS1naXQtc2VuZC1lbWFpbC1iYWl5YW93ZWlAY21zcy5jaGluYW1vYmls
ZS5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjlkZWM1NTYgc2NzaS1kaXNrOiBhZGQgRlVBIHN1cHBvcnQgZm9y
IENPTVBBUkVfQU5EX1dSSVRFCjhlZTBiMjUgaHcvc2NzaTogYWRkIFNDU0kgQ09NUEFSRV9BTkRf
V1JJVEUgc3VwcG9ydAo2YzJiZDUxIGJsb2NrL3JiZDogaW1wbGVtZW50IGJkcnZfYWlvX2NvbXBh
cmVfYW5kX3dyaXRlIGludGVyZmFjZQpmMmNhZmNhIGJsb2NrOiBhZGQgU0NTSSBDT01QQVJFX0FO
RF9XUklURSBzdXBwb3J0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0
IGYyY2FmY2E5ODQwMCAoYmxvY2s6IGFkZCBTQ1NJIENPTVBBUkVfQU5EX1dSSVRFIHN1cHBvcnQp
CjIvNCBDaGVja2luZyBjb21taXQgNmMyYmQ1MWVkZTE0IChibG9jay9yYmQ6IGltcGxlbWVudCBi
ZHJ2X2Fpb19jb21wYXJlX2FuZF93cml0ZSBpbnRlcmZhY2UpCkVSUk9SOiBicmFjZXMge30gYXJl
IG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzU5OiBGSUxFOiBibG9j
ay9yYmQuYzo4MDg6CisgICAgaWYgKExJQlJCRF9IQVZFX0NPTVBBUkVfQU5EX1dSSVRFKQpbLi4u
XQoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM4NzogRklMRTogYmxvY2svcmJkLmM6
MTAxNToKKyAgICAgICAgciA9IHJiZF9haW9fY29tcGFyZV9hbmRfd3JpdGUocy0+aW1hZ2UsIG9m
Ziwgc2l6ZS8yLCByY2ItPmJ1ZiwgKHJjYi0+YnVmICsgc2l6ZS8yKSwgYywgMCwgMCk7CgpFUlJP
Ujogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcvJyAoY3R4OlZ4VikKIzg3OiBGSUxFOiBi
bG9jay9yYmQuYzoxMDE1OgorICAgICAgICByID0gcmJkX2Fpb19jb21wYXJlX2FuZF93cml0ZShz
LT5pbWFnZSwgb2ZmLCBzaXplLzIsIHJjYi0+YnVmLCAocmNiLT5idWYgKyBzaXplLzIpLCBjLCAw
LCAwKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJy8nIChjdHg6VnhW
KQojODc6IEZJTEU6IGJsb2NrL3JiZC5jOjEwMTU6CisgICAgICAgIHIgPSByYmRfYWlvX2NvbXBh
cmVfYW5kX3dyaXRlKHMtPmltYWdlLCBvZmYsIHNpemUvMiwgcmNiLT5idWYsIChyY2ItPmJ1ZiAr
IHNpemUvMiksIGMsIDAsIDApOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKV0FS
TklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzk4OiBGSUxFOiBibG9jay9yYmQuYzoxMDgy
OgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLAoKdG90YWw6IDQgZXJyb3JzLCAxIHdhcm5pbmdz
LCA5MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjMvNCBDaGVja2luZyBjb21taXQgOGVlMGIyNWQzZDgzIChody9zY3NpOiBhZGQgU0NTSSBDT01Q
QVJFX0FORF9XUklURSBzdXBwb3J0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyMTk6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxOTAgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjQvNCBDaGVja2luZyBjb21t
aXQgOWRlYzU1NmI3NTJjIChzY3NpLWRpc2s6IGFkZCBGVUEgc3VwcG9ydCBmb3IgQ09NUEFSRV9B
TkRfV1JJVEUpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzE1NzE5OTYxNjMtMjc2ODgtMS1naXQtc2VuZC1lbWFpbC1iYWl5YW93ZWlAY21zcy5jaGlu
YW1vYmlsZS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


