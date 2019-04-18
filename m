Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D5C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B1620663
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B1620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH9Ro-0003ag-VA
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:59:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH9R1-0003HQ-HV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH9Qz-0000qA-Od
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:58:47 -0400
Resent-Date: Thu, 18 Apr 2019 11:58:46 -0400
Resent-Message-Id: <E1hH9Qz-0000qA-Od@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hH9Qy-0000om-FW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:58:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555603075; cv=none; d=zoho.com; s=zohoarc; 
	b=FQg/SYDcvswEorb8UzyIBVz7JrnewhteTfGHF0QWcC8LowFkUF1ZAAPfNw629eZyvEzxYpGhiyMmytYINkjwANMIaLdmusi/E+VtC37jYm6CQX1zXmwDEynF/LEBjEEmXhU8ZED6WyuyBRgKh8z2/wEbnkePxaMxsR54KCKHdtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555603075;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=zznqN1UB0EPV0cNauhWSCkwN2Fx5sSSrsGE51DGXPd0=; 
	b=Hxuucf4p/CVbbywcj3IGtaUwQijPtgMfoqoD6rk6n1LzbS+0RJa4DF0m+ioFEjROgUNZGwoZA1JSb3Qs6chPXE2SIt7XDQ1czN2/yhIelZb5Y0ja/5NHF6lXF19JdSHGWhzuWcNRHstiKILzUMAIpYz3/tq4amr3WJp2AF6owHU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555603073943226.58312538678433;
	Thu, 18 Apr 2019 08:57:53 -0700 (PDT)
In-Reply-To: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
Message-ID: <155560307223.24.4258448109214289536@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mateja.marjanovic@rt-rk.com
Date: Thu, 18 Apr 2019 08:57:53 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v9 0/6] target/mips: Optimize MSA
 interleave instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, arikalo@wavecomp.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, amarkovic@wavecomp.com, philmd@redhat.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418155753.VtqItvFzig3n-B8vFw6BT74UqWADimMrSpi9E8RJWMc@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU1NjAxMzUwLTQxNzYtMS1n
aXQtc2VuZC1lbWFpbC1tYXRlamEubWFyamFub3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2Fs
bHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2Nr
ZXItdGVzdC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3VibW9kdWxlICdkdGMnIChodHRwczovL2dpdC5xZW11Lm9yZy9naXQv
ZHRjLmdpdCkgcmVnaXN0ZXJlZCBmb3IgcGF0aCAnZHRjJwpDbG9uaW5nIGludG8gJ2R0YycuLi4K
cmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiA0OTMwLCBkb25lLiAgICAgICAgCmVycm9yOiBSUEMg
ZmFpbGVkOyByZXN1bHQ9MTgsIEhUVFAgY29kZSA9IDIwMApmYXRhbDogVGhlIHJlbW90ZSBlbmQg
aHVuZyB1cCB1bmV4cGVjdGVkbHkKZmF0YWw6IHByb3RvY29sIGVycm9yOiBiYWQgcGFjayBoZWFk
ZXIKQ2xvbmUgb2YgJ2h0dHBzOi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0JyBpbnRvIHN1Ym1v
ZHVsZSBwYXRoICdkdGMnIGZhaWxlZApmYWlsZWQgdG8gaW5pdCBzdWJtb2R1bGUgZHRjCiAgQ09Q
WSAgICBSVU5ORVIKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzE1NTU2MDEzNTAtNDE3Ni0xLWdpdC1zZW5kLWVtYWlsLW1hdGVqYS5tYXJqYW5v
dmljQHJ0LXJrLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


