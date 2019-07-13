Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00464C742A7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 12:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FA22083B
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 12:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FA22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmH5d-00048K-2g
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 08:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hmH5Q-0003fn-PO
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 08:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hmH5P-0007Tx-FW
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 08:25:08 -0400
Resent-Date: Sat, 13 Jul 2019 08:25:08 -0400
Resent-Message-Id: <E1hmH5P-0007Tx-FW@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hmH5P-0007Sh-5d
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 08:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563020688; cv=none; d=zoho.com; s=zohoarc; 
 b=VkZY+/pXyOiNCEcH6rG8Lesxh6RtkSty5GWQFCWKUTsxDayvFO6d80BFnQtMJXulSmVIVWz4tExWkE5a9sQUCpNjzLrvrkdOxaL8AtNDB7gLPabuTBdTorCtO9Gno0rwdv3ak35XpBXymR6MCoNDRaeg2GBr3AYvnmaE5Rgd+8Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563020688;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=h65oDD5nBFe5gQmf4LNYIUPgtBFEYio+H89rt44jsa4=; 
 b=cm3YwNeclvmlBrZK3hkbeAi74b8UFsdm3WqzxDL5cQR8DdqOnJV6hOIqRjyRz3yw7aFsxzPVGi/Swfkjf5kND420nDCRuCtot261oh72klKA7ug28KQ/Irk4SmECLyb4n3rxdfawBN13aIY4bKJxDoYhhh65Irqmu70/ZSSPDdE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563020686926394.8155946908548;
 Sat, 13 Jul 2019 05:24:46 -0700 (PDT)
Message-ID: <156302068569.12463.17823158690472274941@c4a48874b076>
In-Reply-To: <20190712104617.94707-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sgarzare@redhat.com
Date: Sat, 13 Jul 2019 05:24:46 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] gluster: fix .bdrv_reopen_prepare when
 backing file is a JSON object
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
Cc: kwolf@redhat.com, integration@gluster.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMjEwNDYxNy45NDcw
Ny0xLXNnYXJ6YXJlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFr
ZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhdWRpby9ub2F1
ZGlvLm8KICBDQyAgICAgIGF1ZGlvL3dhdmF1ZGlvLm8KICBDQyAgICAgIGF1ZGlvL21peGVuZy5v
Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9nbHVzdGVyLmM6OTM4OjIwOiBlcnJvcjogYWRkcmVz
cyBvZiBhcnJheSAnc3RhdGUtPmJzLT5maWxlbmFtZScgd2lsbCBhbHdheXMgZXZhbHVhdGUgdG8g
J3RydWUnIFstV2Vycm9yLC1XcG9pbnRlci1ib29sLWNvbnZlcnNpb25dCiAgICBpZiAoc3RhdGUt
PmJzLT5maWxlbmFtZSAmJiAhc3Ryc3RhcnQoc3RhdGUtPmJzLT5maWxlbmFtZSwgImpzb246Iiwg
TlVMTCkpIHsKICAgICAgICB+fn5+fn5+fn5+fl5+fn5+fn5+IH5+CjEgZXJyb3IgZ2VuZXJhdGVk
LgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTA3MTIxMDQ2MTcuOTQ3MDctMS1zZ2FyemFyZUByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


