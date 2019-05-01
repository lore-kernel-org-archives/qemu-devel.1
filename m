Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C928C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6DC20866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6DC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLt7f-0002lF-3S
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:34:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLt6D-00026y-4B
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLt6B-0007z6-Qm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:32:53 -0400
Resent-Date: Wed, 01 May 2019 13:32:53 -0400
Resent-Message-Id: <E1hLt6B-0007z6-Qm@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLt6B-0007u7-4A
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556729235; cv=none; d=zoho.com; s=zohoarc; 
	b=BsfRVV/cK6CFGM3az/6QZyaDEdrzMgitQQTBanOf//6oke/1tn/crZ8vvePyJvp5E5A2Dkal8ve7F5GMYYsIxz15ptrwegZeIn18rCLAE2b9WqdO+GN9C9Ka7EfPUmrsHMOp44fhomERNq4iRXceZIjNg4KSVRfGZBePrP0FryI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556729235;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=uANLrLMFSC1h2wWDHs/d0U1+Las+9gUZeFXV9kRbZKg=; 
	b=C6yQLyG4QqOzVbGbmGFUSw/wDXV9n+SB9zvtA1cNOT6ajHNpaknH4n94PxHl9ovDAJfUJiTv+YWwHkTBIhhMqRCeFMEYL0tRu+wlByMzFnDVh2wvmkBKWGAhq5iD+1YkJtGMIzCXmQa2ShvaoM12eyl6EEaJiPmuQnzZgeWT1jw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556729234816432.34705452457945;
	Wed, 1 May 2019 09:47:14 -0700 (PDT)
In-Reply-To: <20190429235109.20307-1-brogers@suse.com>
Message-ID: <155672923359.10667.8343395282332271077@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: brogers@suse.com
Date: Wed, 1 May 2019 09:47:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: handle invalid cdb length
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
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-devel@nongnu.org,
	brogers@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501164714.P8zPcPFX9Whmu7ete1kDj--ywNSk8qyil_BsMQpyRCs@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTIzNTEwOS4yMDMw
Ny0xLWJyb2dlcnNAc3VzZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0
MjkyMzUxMDkuMjAzMDctMS1icm9nZXJzQHN1c2UuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


