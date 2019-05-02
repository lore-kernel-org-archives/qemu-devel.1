Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259AEC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBA120652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBA120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM88R-0004w7-7v
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:36:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM87M-0004CN-5d
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM87F-0004cW-02
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:34:58 -0400
Resent-Date: Thu, 02 May 2019 05:34:58 -0400
Resent-Message-Id: <E1hM87F-0004cW-02@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hM87A-0004UJ-Lm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556789652; cv=none; d=zoho.com; s=zohoarc; 
	b=cTR49VJ7oEqTXQIHdokLxVtxDmvFhQnNgASCLBW4bdKzneZgP0Z5hNoroZMszFc0e//xVw7z9HSBYkpW9/uwjO0ClPNro2gDdOxDyaBjja8+WCbcwaYGDXqo4WbG8625nyHOutee5clGp+6VJNziVf48bE7pb8hGsixQtVNlStw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556789652;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=nPsck23BNuD+d2bdJ8nU+3HWI4wgNRLRpjUTi5n7ukc=; 
	b=Tpme20TPpWAWBDnbC8aEmQsfqFr4GR+EX8l8AsofPzbCds4zqQgrUYub3IqEVgRppkV/gXNoSzXh/G3ZFmNfEJ7fV5rKSNV4RAclUNnhUKA7eB4prlVHJtSgvGFjplrAqryJde/eYcWW01DskaNm0XeU2nmSh3OGBaySGYDUQXQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556789650367398.23625603817425;
	Thu, 2 May 2019 02:34:10 -0700 (PDT)
In-Reply-To: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Message-ID: <155678964913.10667.9893633582194722553@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: wangjie88@huawei.com
Date: Thu, 2 May 2019 02:34:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH] vhost: fix incorrect print type
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
Cc: fam@euphon.net, mst@redhat.com, eric.fangyi@huawei.com,
	qemu-devel@nongnu.org, wangjie88@huawei.com, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502093410.YWn9UgOt2tZUDLGONqrOgZmV_ayRj_FUL3fzq7SOnbI@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU2NjA1NzczLTQyMDE5LTEt
Z2l0LXNlbmQtZW1haWwtd2FuZ2ppZTg4QGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEg
VEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMTU1NjYwNTc3My00MjAxOS0xLWdpdC1zZW5kLWVtYWlsLXdhbmdqaWU4OEBodWF3
ZWkuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


