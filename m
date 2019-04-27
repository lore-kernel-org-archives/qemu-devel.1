Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB4C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 04:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0CB2077B
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 04:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0CB2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKFKb-00065E-LF
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 00:52:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKFJm-0005iv-Ol
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 00:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKFJl-0001x0-IC
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 00:52:06 -0400
Resent-Date: Sat, 27 Apr 2019 00:52:06 -0400
Resent-Message-Id: <E1hKFJl-0001x0-IC@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hKFJl-0001uV-AK
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 00:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556340682; cv=none; d=zoho.com; s=zohoarc; 
	b=ATseLp4JPesc0fwihLCXc9yx7bRBhLvaAr1Zw+6ktryAP2zUGi4XfxipYbCHzbN0u6j62eDjdUQ+Cwxv584hemLqA/OOUDObnXQ6hFAGOcZ5m0WHkFnChH3AAdakGIcivsPD/SWfNlVhuh/DtkTGAoUcPXczo8+BsE4DZZnqfcQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556340682;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=wxiNfJ/NEWS10fPHrEFwHObw+EXdp6Nn0Ka5I1mlpFk=; 
	b=omS7hW5/Tll8/HZ+0wCtAV+vyMFQ9f57lkKPPv88PRngPW+InQ9Diep9grlWGZ4EsDgSh8tdDmkiBggx197qL1OgEvgXZc0RMklKdMTKdDBHuv3GyuLLOrmN6WhHWjHRr3O3V6kJxZq9v4ETJxkxH6/AzWqfGz8N3KegdYiumnc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556340680213998.6261578673107;
	Fri, 26 Apr 2019 21:51:20 -0700 (PDT)
In-Reply-To: <20190424103747.10173-1-thuth@redhat.com>
Message-ID: <155634067827.10667.1234958122204251178@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Fri, 26 Apr 2019 21:51:20 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/6] tests/qemu-iotests: Run basic iotests
 during "make check"
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
Cc: fam@euphon.net, kwolf@redhat.com, emaste@freebsd.org, qemu-block@nongnu.org,
	philmd@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	alex.bennee@linaro.org, lwhsu@freebsd.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427045120.alzA7zKel8D28xOWBvVb8MRzeO1I2CruBVnjE_Zdk2E@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNDEwMzc0Ny4xMDE3
My0xLXRodXRoQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0
MjQxMDM3NDcuMTAxNzMtMS10aHV0aEByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


