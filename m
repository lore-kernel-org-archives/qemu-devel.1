Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9086C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948BF20769
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2qrwHUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948BF20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbCy-0006up-PJ
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jMbC3-0005Nb-Km
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jMbC2-0006mR-Hh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jMbC2-0006lr-EV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586454141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Cew4RNGN5rN50SNC0GKS+sHQ6cGjmU6UWa34S1QU4Q=;
 b=Q2qrwHUizJ0seT91qcG6H5ZLSAJOu7c9FCCufHSwaXJIVMFLWiioorPiGH1f6N2itC4XLv
 E9iYbpAxhb1alR0n33QcPkOPJAbszPI3UtgwuzLAVXUazlk7rOIpJdjHbYicvKtjMEV3Hk
 KU9fMGbJia1JWqQdUoBiZSItEe4SSYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-oeR2x6MWPXqI1fikD5PO2w-1; Thu, 09 Apr 2020 13:42:18 -0400
X-MC-Unique: oeR2x6MWPXqI1fikD5PO2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 616D6107ACC9;
 Thu,  9 Apr 2020 17:42:17 +0000 (UTC)
Received: from localhost (ovpn-114-141.ams2.redhat.com [10.36.114.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9164F1195BC;
 Thu,  9 Apr 2020 17:42:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/3] Block patches
Date: Thu,  9 Apr 2020 18:42:06 +0100
Message-Id: <20200409174209.321725-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA4YmFjM2JhNTdlZWNjNDY2YjdlNzNk
YWJmN2QxOTMyOGE1OWY2ODRlOgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL3J0aC90YWdzL3B1bGwtcngtMjAyMDA0MDgnIGludG8gc3RhZ2luZyAoMjAyMC0wNC0wOSAx
MzoyMzozMCArMDEwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoK
ICBodHRwczovL2dpdGh1Yi5jb20vc3RlZmFuaGEvcWVtdS5naXQgdGFncy9ibG9jay1wdWxsLXJl
cXVlc3QKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA1NzEwYTNlMDlmOWI4NTgwMWU1
Y2U3MDc5N2E0YTUxMWU1ZmM5ZTJjOgoKICBhc3luYzogdXNlIGV4cGxpY2l0IG1lbW9yeSBiYXJy
aWVycyAoMjAyMC0wNC0wOSAxNjoxNzoxNCArMDEwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KUHVsbCByZXF1ZXN0CgpG
aXhlcyBmb3IgUUVNVSBvbiBhYXJjaDY0IEFSTSBob3N0cyBhbmQgZmRtb24taW9fdXJpbmcuCgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCgpQYW9sbyBCb256aW5pICgyKToKICBhaW8td2FpdDogZGVsZWdhdGUgcG9sbGluZyBv
ZiBtYWluIEFpb0NvbnRleHQgaWYgQlFMIG5vdCBoZWxkCiAgYXN5bmM6IHVzZSBleHBsaWNpdCBt
ZW1vcnkgYmFycmllcnMKClN0ZWZhbiBIYWpub2N6aSAoMSk6CiAgYWlvLXBvc2l4OiBzaWduYWwt
cHJvb2YgZmRtb24taW9fdXJpbmcKCiBpbmNsdWRlL2Jsb2NrL2Fpby13YWl0LmggfCAyMiArKysr
KysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2Jsb2NrL2Fpby5oICAgICAgfCAyOSArKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLQogdXRpbC9haW8tcG9zaXguYyAgICAgICAgIHwgMTYgKysr
KysrKysrKysrKystLQogdXRpbC9haW8td2luMzIuYyAgICAgICAgIHwgMTcgKysrKysrKysrKysr
KystLS0KIHV0aWwvYXN5bmMuYyAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKy0tLS0KIHV0
aWwvZmRtb24taW9fdXJpbmcuYyAgICB8IDEwICsrKysrKysrLS0KIDYgZmlsZXMgY2hhbmdlZCwg
ODAgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pCgotLSAKMi4yNS4xCgo=


