Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6DDC2BA16
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 07:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52A520747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 07:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52A520747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM4ps-0000zA-1A
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 03:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM4oq-0008PY-8a
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM4op-00055n-2k
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:08:16 -0400
Resent-Date: Wed, 08 Apr 2020 03:08:16 -0400
Resent-Message-Id: <E1jM4op-00055n-2k@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM4oo-00055U-FZ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586329684; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hixr8uPWn5mmYoQc1laYGOYSCovKxmv5ij3DCQoYSQ2wwmYbFrm4JL6rG32hHqj+fhx0Ic4X4K8ZiiG7Vwl7IxxClZY49bg48HFz79u5jsZog/xKYiCMz3wm6rxPldjeNDw+yphFaHHuonrO9jIH65NptTCh7WiDLNWarAiZCFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586329684;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=i8qZzb4duS9Vxq+yjnddufY1yuC+jfw35aFfWYmS0ew=; 
 b=NjNDCyJ77AAyYXJ/ujGBsFpFkWveQeNIrlJDWwJABs+MHg9+ACou14XyouNfcK/eE4QQwkjcZL3cHnB8JQ5cIiG5/zeUuV2IKjiwNBiFaxQBMrqhfQrzv0keXIM/iGNr1MYmZdgFI4Umn4ryQCiclCuzhsw7B2okEwkfPiG062U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586329683194541.3936290233481;
 Wed, 8 Apr 2020 00:08:03 -0700 (PDT)
In-Reply-To: <20200408070231.20265-1-cfontana@suse.de>
Subject: Re: [PATCH] Makefile: libfdt: build only the strict necessary
Message-ID: <158632968186.16886.16142141407932151589@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Wed, 8 Apr 2020 00:08:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, laurent@vivier.eu,
 cfontana@suse.de, alex.bennee@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODA3MDIzMS4yMDI2
NS0xLWNmb250YW5hQHN1c2UuZGUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KTWFrZWZpbGU6NTMyOiBkdGMvbGliZmR0L01ha2VmaWxlLmxpYmZkdDogTm8gc3VjaCBm
aWxlIG9yIGRpcmVjdG9yeQpjYyAtbm9zdGRsaWIgIC1vIGR0Yy9saWJmZHQvTWFrZWZpbGUubGli
ZmR0Lm1vIApjYzogZmF0YWwgZXJyb3I6IG5vIGlucHV0IGZpbGVzCmNvbXBpbGF0aW9uIHRlcm1p
bmF0ZWQuCm1ha2U6ICoqKiBbZHRjL2xpYmZkdC9NYWtlZmlsZS5saWJmZHQubW9dIEVycm9yIDQK
TWFrZWZpbGU6NTMyOiBkdGMvbGliZmR0L01ha2VmaWxlLmxpYmZkdDogTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeQogIExEICAgICAgZHRjL2xpYmZkdC9NYWtlZmlsZS5saWJmZHQubW8KY2M6IGZh
dGFsIGVycm9yOiBubyBpbnB1dCBmaWxlcwpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAq
KiogW2R0Yy9saWJmZHQvTWFrZWZpbGUubGliZmR0Lm1vXSBFcnJvciA0CgpyZWFsICAgIDBtMC41
MTJzCnVzZXIgICAgMG0wLjMyMHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDA4MDcwMjMxLjIwMjY1LTEtY2ZvbnRhbmFAc3VzZS5k
ZS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

