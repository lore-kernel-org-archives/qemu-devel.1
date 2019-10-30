Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC04CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 19:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308A0205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 19:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308A0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPtri-00077j-8Z
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 15:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iPtno-0003eT-T7
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 15:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iPtnm-0001rw-GE
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 15:38:43 -0400
Resent-Date: Wed, 30 Oct 2019 15:38:43 -0400
Resent-Message-Id: <E1iPtnm-0001rw-GE@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iPtnm-0001hV-72; Wed, 30 Oct 2019 15:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572464302; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EcwmKOv8PdnW7TId1m/wWiNsa42C/GjvZTZNW0ViNjUF6+tEJcVNqZL6befxqw/Lep70325Qau4se21gZDRJw8jWCCMst8kDa6pD1ChK3GFCFqfuKg/pEr1EcqhmS6SdHfa1GG2we7wjYSzuyNuomb2rd5uI3fwfJRuhlGMe2F4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572464302;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Hx99WKGkpJbBfvde4ZLJqSg5oB4vlIZz9wNIN6nRpRc=; 
 b=EK+qcLyrR+DiMY3howGbx0jtzeOCBI7X7x6KLqp80hkjk8OusdIZLQa76uVV3AA878lHUlVJPBJqf2GRv7M1hs1Ho1dF4IwCUH3OKrxMbe/zDLRV+ffPyfCBZ35n+cQBb8UB2fAyNX4QQYUyzblVsZPr1xzNLZGnyPvmCgJACU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572464301052377.1088871142439;
 Wed, 30 Oct 2019 12:38:21 -0700 (PDT)
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <157246429967.32191.8943981260424940794@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@gibson.dropbear.id.au
Date: Wed, 30 Oct 2019 12:38:21 -0700 (PDT)
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
Cc: david@redhat.com, groug@kaod.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, imammedo@redhat.com, jdenemar@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAzMDE2MzI0My4xMDY0
NC0xLWRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBzcGFwci9rdm06IFNldCBkZWZh
dWx0IGNwdSBtb2RlbCBmb3IgYWxsIG1hY2hpbmUgY2xhc3NlcwpUeXBlOiBzZXJpZXMKTWVzc2Fn
ZS1pZDogMjAxOTEwMzAxNjMyNDMuMTA2NDQtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKNDU4MWEyYSBzcGFwci9rdm06IFNldCBkZWZhdWx0IGNwdSBtb2RlbCBmb3IgYWxsIG1h
Y2hpbmUgY2xhc3NlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3NpbmcgU2lnbmVk
LW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1MCBsaW5lcyBj
aGVja2VkCgpDb21taXQgNDU4MWEyYTY3NGY0IChzcGFwci9rdm06IFNldCBkZWZhdWx0IGNwdSBt
b2RlbCBmb3IgYWxsIG1hY2hpbmUgY2xhc3NlcykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEw
MzAxNjMyNDMuMTA2NDQtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUvdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


