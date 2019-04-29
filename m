Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F744C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CCE20651
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CCE20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL7ra-0004Sd-CT
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:06:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hL7qY-0003hU-Ry
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hL7qX-0004mz-GL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:05:34 -0400
Resent-Date: Mon, 29 Apr 2019 11:05:34 -0400
Resent-Message-Id: <E1hL7qX-0004mz-GL@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hL7qV-0004gD-Eb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556550308; cv=none; d=zoho.com; s=zohoarc; 
	b=Zug8XO2tHcekxeu5vyITVZ3IDM5GBeWzr31iwCH2aRE4Ynmz8nF/9spPjyWIJ8xennfigVkePQMBdQEs/LOVcKZdVbmwgDV6/WoMZxfiXfMAiXltNwzaLjo8sJix7/VtILbJYxmObt0M8rFQv7esFItcsBTl4hD/ScKhEiDSXS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556550308;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=H0ubxXvYGfmUxhDKhLXmUsiNJbuT5bJsvUs+qo7iljw=; 
	b=R+xYz21Nh0DrsUpfpIJ09fZlAf4Sajw3fAZAiOuu6VUB+Iu8qjrIr/8wTol2Vzo4P8+rpDUBN2Y6IY7s0HaOCoLhQyU77SMhAf36FuSccpR5xVPSTYhZQT/7wofOxVnPfL/iPrSY+t1mqZUnuXln6FXkUoVGlUTmWyosBrzVr5A=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 15565503068331010.1197245218011;
	Mon, 29 Apr 2019 08:05:06 -0700 (PDT)
In-Reply-To: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
Message-ID: <155655030568.10667.13700938703853199260@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: longpeng2@huawei.com
Date: Mon, 29 Apr 2019 08:05:06 -0700 (PDT)
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
Message-ID: <20190429150506.7kRSBAXVUv8MaDyHsnR6x498NIcNu7jEQBSYAy5KSJw@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU2NTIzNTY5LTQ0NDgwLTEt
Z2l0LXNlbmQtZW1haWwtbG9uZ3BlbmcyQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVz
dC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8xNTU2NTIzNTY5LTQ0NDgwLTEtZ2l0LXNlbmQtZW1haWwtbG9uZ3BlbmcyQGh1YXdl
aS5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


