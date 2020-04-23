Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB41C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE6B2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE6B2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbwE-0007q4-KR
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbty-0004Yj-Cd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbtx-0005HZ-TC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:28:26 -0400
Resent-Date: Thu, 23 Apr 2020 09:28:26 -0400
Resent-Message-Id: <E1jRbtx-0005HZ-TC@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRbtu-00059t-1m; Thu, 23 Apr 2020 09:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587648496; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gcbR2ScVvM4EY6Do7yeawkCS0yQmuV/zPhE3MjQ81IBF9dSIO6tWUEZ1yTuukyr+l8Jk/wF+9qg/gMA6ABI1GCvgTnicw6/HGxewwqRhSJH7mtPQH268273B5TELwWD/oTxuThkp3I1G8WWGknPBm7XHP+pMU9jdbZw8HvWabP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587648496;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ur3hqtb17TzFPGHLOzvMsQ9llrrWlj7fP8hZyM0E274=; 
 b=ce2rZEWsYUMc3hmeotuPZkpUbK8UFihjT8s4eta3jRneL55Kg0I8gxIXbFrlAk66VCD+y1WMiKUaaUZehSmTFL7k/4XnID/xVDScdwQYKyKVMRwpC3Zcy1Mw7WWnH/2jUu1njL5u5GMYnfAVNvZ8BPZ6rILTDyGNTuxCAzfzuiU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587648493698884.5510476696185;
 Thu, 23 Apr 2020 06:28:13 -0700 (PDT)
In-Reply-To: <20200423110915.10527-1-peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 ID_AA64DFR0
Message-ID: <158764849257.10590.5081716484542096155@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Thu, 23 Apr 2020 06:28:13 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 09:27:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzExMDkxNS4xMDUy
Ny0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSB0YXJnZXQvYXJtOiBVc2UgY29ycmVj
dCB2YXJpYWJsZSBmb3Igc2V0dGluZyAnbWF4JyBjcHUncyBJRF9BQTY0REZSMApNZXNzYWdlLWlk
OiAyMDIwMDQyMzExMDkxNS4xMDUyNy0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwpUeXBlOiBz
ZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CmVycm9yOiBSUEMgZmFpbGVkOyBy
ZXN1bHQ9MjIsIEhUVFAgY29kZSA9IDUwNApmYXRhbDogVGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1
bmV4cGVjdGVkbHkKZXJyb3I6IENvdWxkIG5vdCBmZXRjaCAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBG
aWxlICJwYXRjaGV3LXRlc3Rlci9zcmMvcGF0Y2hldy1jbGkiLCBsaW5lIDUyMSwgaW4gdGVzdF9v
bmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZiwg
VHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRlc3Rlci9zcmMvcGF0Y2hldy1jbGkiLCBsaW5lIDQ4LCBp
biBnaXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0PWxvZ2YsIHN0ZGVycj1sb2dmKQogIEZpbGUgIi9v
cHQvcmgvcmgtcHl0aG9uMzYvcm9vdC91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHki
LCBsaW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0
JywgJ3JlbW90ZScsICdhZGQnLCAnLWYnLCAnLS1taXJyb3I9ZmV0Y2gnLCAnM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICdodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hl
dy1wcm9qZWN0L3FlbXUnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMS4KCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQy
MzExMDkxNS4xMDUyNy0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

