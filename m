Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B80C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E4121743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E4121743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLV86-0002LK-2H
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:57:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLUuq-000822-VO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLUuo-00025R-RL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
Resent-Date: Tue, 30 Apr 2019 11:43:32 -0400
Resent-Message-Id: <E1hLUuo-00025R-RL@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLUu7-0001VZ-RB; Tue, 30 Apr 2019 11:42:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556638947; cv=none; d=zoho.com; s=zohoarc; 
	b=flh+1NQ+jQndwybZQZu+btFkZ38sgpmKX0TMaH9Snv5+tW2AuAkSvfp+P6MqAvc45Loa1xtYmqLc2DI9/Zq/1dRrxdVDPkZElkxv/mlWUGUv3STRe9xL++GYaiQc2gF4D4eMdnKQ/2X/eGtLMtLT11fhnB7CnYISarbqjAEm+EY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556638947;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=xIZA6At+pC/SJkdnbsNxxiyAEomACcsYMUbIpvpXpK4=; 
	b=jVCmRmS74jMQ7nmyIX79cHpUpxBoEsTMEHOXWTfsCridMr0bcgn896TjBXuHNRr++5ruJKGqzdX+KD0dQudpLp9uEeYyu5tACg8cFiHvWndmP9cTUdhiTo/I2tJIH4gHx6Q7WIx1bIze7q5KM1/TrJXOQMdJRtxO1cKvTYTC9Ag=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556638945084225.8461772506937;
	Tue, 30 Apr 2019 08:42:25 -0700 (PDT)
In-Reply-To: <20190429105741.31033-1-kwolf@redhat.com>
Message-ID: <155663894367.10667.5396049439602349313@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Tue, 30 Apr 2019 08:42:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix qcow2_make_empty() with
 external data file
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
	qemu-stable@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430154225.MGkCIvGcm_JKFfbhabI_Ef-DLiI2iEdZAk6LATBkM1g@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTEwNTc0MS4zMTAz
My0xLWt3b2xmQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0
MjkxMDU3NDEuMzEwMzMtMS1rd29sZkByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


