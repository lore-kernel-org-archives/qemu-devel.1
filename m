Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84C9C49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC57C20863
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 01:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC57C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8EIe-0005c1-Ud
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 21:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i8EI2-0004y3-MW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i8EI1-0001zg-6K
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:52:54 -0400
Resent-Date: Wed, 11 Sep 2019 21:52:54 -0400
Resent-Message-Id: <E1i8EI1-0001zg-6K@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i8EI0-0001z1-VY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 21:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568253157; cv=none; d=zoho.com; s=zohoarc; 
 b=L+/NfoXqJnpZJbuAHclbWeG9ofjNm7WY0O84Lp7o8agMcHQKGRll2a76V9C7yn/+BgsoxRiyD5LPHTY/rhoEpTGpUmeeXvcxkX2QPVMFf5PRrDbGfdgcnP2hdcCDLvAcJhNvotQezITvidxYxAdFjzQ9q1CdxAOgfpMaF1RNwww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568253157;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3uVsgc8pmHAAA5k8PY+NEQe8SmP6sixQ0bb4svDuPN0=; 
 b=LczNekE2VvpHbY1VrY0VpSa3ecIQ0ajNzzoeBs0Knu+fQ5WJaCbwxTMuOtJW9b8DEhLCitJfRL0dFgpF5aMbs2EW5nJAiiVkXIwHvi7l9LxOcn6f9zEjmkn/D8DHKKNe4iisvvYhsEiIy2qnDy3Ien9OeX5AclGnZdKKAmp2gjI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568253155127305.55835350682594;
 Wed, 11 Sep 2019 18:52:35 -0700 (PDT)
In-Reply-To: <20190912014442.5757-1-jsnow@redhat.com>
Message-ID: <156825315333.21839.4459418365355602992@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Wed, 11 Sep 2019 18:52:35 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
Subject: Re: [Qemu-devel] [PATCH] docker: add sanitizers back to clang build
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
Cc: fam@euphon.net, jsnow@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMjAxNDQ0Mi41NzU3
LTEtanNub3dAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gZG9ja2VyOiBhZGQgc2FuaXRp
emVycyBiYWNrIHRvIGNsYW5nIGJ1aWxkCk1lc3NhZ2UtaWQ6IDIwMTkwOTEyMDE0NDQyLjU3NTct
MS1qc25vd0ByZWRoYXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTA5MTIwMTQ0NDIuNTc1Ny0xLWpzbm93
QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDkxMjAxNDQ0Mi41NzU3LTEtanNub3dAcmVkaGF0
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk2ZDQ0YjkgZG9ja2VyOiBhZGQg
c2FuaXRpemVycyBiYWNrIHRvIGNsYW5nIGJ1aWxkCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJP
UjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDEyIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA5NmQ0NGI5ZjdmNjYgKGRvY2tlcjogYWRk
IHNhbml0aXplcnMgYmFjayB0byBjbGFuZyBidWlsZCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA5MTIwMTQ0NDIuNTc1Ny0xLWpzbm93QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


