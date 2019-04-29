Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55C1C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD132087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD132087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAZ9-0001A1-2t
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:59:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLAY1-0000d0-Is
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLAY0-000695-G6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:58:37 -0400
Resent-Date: Mon, 29 Apr 2019 13:58:37 -0400
Resent-Message-Id: <E1hLAY0-000695-G6@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLAY0-00068X-6p
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556560695; cv=none; d=zoho.com; s=zohoarc; 
	b=CKHxJk/6T/h770eiu8xu2ZyS4bQVyLF+z0f3Zm0Y0r5wKOd8/yn9PJZefptNzf7I//JetytzLv3ThrbtRgBmim9mrgy5mMKIpn7wQIxSlu28feiJRS5DDFB9XwagGIM5nmARu6Voph9TZNrbcRnVe+dACA/VSApp7p5vcnRTgHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556560695;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=rbkwtC3dOxnO50l9HHg2q/+WCBmt5MvvTJD5YqB1vW0=; 
	b=HeYivoaqDZn0pwp28tGvHnr7KQ8UWY75Jpjwi0EZsLyVyl2jEF8/F0m1kmRS/jrxptwZD+41YnzcjpuNer+eTV18Y8FtpTsf3tOgiR2sw8bzJPbI+6Z0ARE3VhjQerSNYx4QM8h+aPGVdfjvSrLmRKGxELZ5I4U/3l61fY67peU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556560692403844.0908159496498;
	Mon, 29 Apr 2019 10:58:12 -0700 (PDT)
In-Reply-To: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
Message-ID: <155656069051.10667.7616511989657327762@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: longpeng2@huawei.com
Date: Mon, 29 Apr 2019 10:58:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
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
Cc: fam@euphon.net, longpeng2@huawei.com, arei.gonglei@huawei.com,
	kraxel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429175812.AqlDKrX5x11VmxOJ6x9-DUqfPgBLHKKvAUjavp30Qko@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU2NTIzNTY5LTQ0NDgwLTEt
Z2l0LXNlbmQtZW1haWwtbG9uZ3BlbmcyQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEg
VEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMTU1NjUyMzU2OS00NDQ4MC0xLWdpdC1zZW5kLWVtYWlsLWxvbmdwZW5nMkBodWF3
ZWkuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


