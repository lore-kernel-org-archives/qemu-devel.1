Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F39C2BA16
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 07:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC9720747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 07:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC9720747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM4oD-0007Z9-E6
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 03:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM4nb-0007AD-LR
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM4na-0004TK-7V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:06:59 -0400
Resent-Date: Wed, 08 Apr 2020 03:06:59 -0400
Resent-Message-Id: <E1jM4na-0004TK-7V@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM4nZ-0004Q2-W9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 03:06:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586329598; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cMVoGQDK/6aUGzmpHh7DdPtiraTGIZ8YrEVmmZKQN/hiK0TY8Sjc3THPBsMnMlg1dRbaXifrbsWEQFgtaCHlcr0D4ozjmhGkvd0+mLIhlfn5rajApD0Uads2r+/FNCwIPq/uNenfwUmPUu+d/zFu1ShGtAB5CG3qGWUQxlLPz0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586329598;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w6w2vg8tTsytb3PiqobEZLf2bYUPHZ52UrB9jygclOo=; 
 b=TPsNtjK8ksttICVqoMc7prquashodefvOe8vmHqrd+fKZrtraIqWmZyO6mLRi/z4mBKwjS0ySWCLxcGoHPJDhP0aHlzJ6vyPIrw6sF+MesdOwaEpf4WXohKp5NZZbMhajiQjekzoKe/HEwcrohw0uY3l2N4eEl/viMyNmNUGO7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586329596259856.3412752115337;
 Wed, 8 Apr 2020 00:06:36 -0700 (PDT)
In-Reply-To: <20200408070231.20265-1-cfontana@suse.de>
Subject: Re: [PATCH] Makefile: libfdt: build only the strict necessary
Message-ID: <158632959483.16886.907739858138361292@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Wed, 8 Apr 2020 00:06:36 -0700 (PDT)
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
NS0xLWNmb250YW5hQHN1c2UuZGUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4
Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09Cgo9PT0g
T1VUUFVUIEJFR0lOID09PQpNYWtlZmlsZTo1MzI6IGR0Yy9saWJmZHQvTWFrZWZpbGUubGliZmR0
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CmNjIC1ub3N0ZGxpYiAgLW8gZHRjL2xpYmZkdC9N
YWtlZmlsZS5saWJmZHQubW8gCmNjOiBmYXRhbCBlcnJvcjogbm8gaW5wdXQgZmlsZXMKY29tcGls
YXRpb24gdGVybWluYXRlZC4KbWFrZTogKioqIFtkdGMvbGliZmR0L01ha2VmaWxlLmxpYmZkdC5t
b10gRXJyb3IgNApNYWtlZmlsZTo1MzI6IGR0Yy9saWJmZHQvTWFrZWZpbGUubGliZmR0OiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAgTEQgICAgICBkdGMvbGliZmR0L01ha2VmaWxlLmxpYmZk
dC5tbwpjYzogZmF0YWwgZXJyb3I6IG5vIGlucHV0IGZpbGVzCmNvbXBpbGF0aW9uIHRlcm1pbmF0
ZWQuCm1ha2U6ICoqKiBbZHRjL2xpYmZkdC9NYWtlZmlsZS5saWJmZHQubW9dIEVycm9yIDQKCnJl
YWwgICAgMG0wLjU4NXMKdXNlciAgICAwbTAuMzg0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDgwNzAyMzEuMjAyNjUtMS1jZm9u
dGFuYUBzdXNlLmRlL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

