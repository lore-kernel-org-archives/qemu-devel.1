Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B07C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 03:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D577214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 03:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D577214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSYNU-0003ZJ-BT
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 22:22:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSYMe-00037Y-SK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 22:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSYMd-0000Uq-8x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 22:21:40 -0500
Resent-Date: Wed, 06 Nov 2019 22:21:40 -0500
Resent-Message-Id: <E1iSYMd-0000Uq-8x@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSYMd-0000U1-1G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 22:21:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573096876; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EWaTl7K88seRMKVH77fktRHDqDN5Bee5dGRRkXc5pSaQTUYE7FEP8eeSVn0UpIPC4raz1epWnaopw76wus6YkwU+5S7Lt0DNLLKeEw0oyLYDl9nVGCNCKkt1cFWnlb5VY2At/2Yzaz0s1cpPDN86Vwg1kfR8MSI4fvkw8jMUbjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573096876;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w4ETJD7FxRuc0U3Pt0nEbf9uBzHndE8hEIGojRv+xFE=; 
 b=LFV+V351g9LkN0bYA4jarfhDRWY1E74fLvA5q4tpuAQSItx4MJw84hHW9u+xNK/wZQKVTHV5J0EPEZwGzU41nTYbdIc5QUKax30COWPiySB/ZMlG0DGVw5mMSRtDvUbWv327FuFhjyekxXV0PfXAUbIeDTgKL1bgiBXrna59zd4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573096874796981.800034185325;
 Wed, 6 Nov 2019 19:21:14 -0800 (PST)
In-Reply-To: <MW2PR2101MB1116E938A5BE3174EF5EC9B9C0790@MW2PR2101MB1116.namprd21.prod.outlook.com>
Subject: Re: [PATCH] WHPX: support for xcr0
Message-ID: <157309687370.21358.9964434548287998422@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sunilmut@microsoft.com
Date: Wed, 6 Nov 2019 19:21:14 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9NVzJQUjIxMDFNQjExMTZFOTM4
QTVCRTMxNzRFRjVFQzlCOUMwNzkwQE1XMlBSMjEwMU1CMTExNi5uYW1wcmQyMS5wcm9kLm91dGxv
b2suY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5
bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJq
ZWN0OiBbUEFUQ0hdIFdIUFg6IHN1cHBvcnQgZm9yIHhjcjAKVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IE1XMlBSMjEwMU1CMTExNkU5MzhBNUJFMzE3NEVGNUVDOUI5QzA3OTBATVcyUFIyMTAxTUIx
MTE2Lm5hbXByZDIxLnByb2Qub3V0bG9vay5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFt
Ci4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmYxYjRjN2EgV0hQWDog
c3VwcG9ydCBmb3IgeGNyMAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3NpbmcgU2ln
bmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMzcgbGlu
ZXMgY2hlY2tlZAoKQ29tbWl0IGYxYjRjN2FlOWM1MyAoV0hQWDogc3VwcG9ydCBmb3IgeGNyMCkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvTVcyUFIyMTAxTUIxMTE2RTkzOEE1QkUzMTc0RUY1RUM5QjlD
MDc5MEBNVzJQUjIxMDFNQjExMTYubmFtcHJkMjEucHJvZC5vdXRsb29rLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


