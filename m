Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05691C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 15:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36D220833
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 15:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36D220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42319 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHrYy-0006la-3e
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 11:05:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hHrY7-0006FH-SP
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 11:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hHrY6-0001bi-Go
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 11:05:03 -0400
Resent-Date: Sat, 20 Apr 2019 11:05:03 -0400
Resent-Message-Id: <E1hHrY6-0001bi-Go@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hHrY5-0001Sb-HY
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 11:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555772652; cv=none; d=zoho.com; s=zohoarc; 
	b=K2M/ryuw/SwyA9qlZS0v5+XjWV5Wk31vl8s2F/ur22q/ccvZ29TRhDFv55G0Zimqzvk4EXmjdOEJGko7DFBU5iW714poVpZgLt3Eu+w0fM9SLflZ//V7pex3qfAQWBOG8da9k1koBwONnqWDCKOM5j1dXKaYwDMQYD9gZAknaPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555772652;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=aTkkZ8jiFmFjylbqKVWtYziAoea4G5QCGIHEeAvzPKM=; 
	b=HX8PAWJU5wGhqu26XvScJ2RHfanJSM68Ldhb7EGI500LgKwv/INDY6QwfrJXzn0vjTASXn7PvASVYzrqrBvATzdRQj46tnuuXl62l2j7JoKfVc3v04KjeEzB1oknoRHQkWJs69ZzM/NFPedQxf8+34L/RK48GdQMHNoFaqU2jUQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555772650705244.84447414168903;
	Sat, 20 Apr 2019 08:04:10 -0700 (PDT)
In-Reply-To: <20190420145120.122847-1-liq3ea@163.com>
Message-ID: <155577264895.24.17186415958917619032@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liq3ea@163.com
Date: Sat, 20 Apr 2019 08:04:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/3] hw: edu: some fixes
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
Cc: fam@euphon.net, liq3ea@163.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, jslaby@suse.cz
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420150410.79tUyr2UE4kX4-aWcmpm_7jEObEkE0Eb8r3mlMr5AB4@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMDE0NTEyMC4xMjI4
NDctMS1saXEzZWFAMTYzLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBT
SE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFNJR04g
ICAgb3B0aW9ucm9tL211bHRpYm9vdC5iaW4KICBMSU5LICAgIHFlbXUtZWRpZC5leGUKL3RtcC9x
ZW11LXRlc3Qvc3JjL2h3L21pc2MvZWR1LmM6IEluIGZ1bmN0aW9uICdlZHVfY2hlY2tfcmFuZ2Un
OgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbWlzYy9lZHUuYzoxMTc6MzY6IGVycm9yOiBmb3JtYXQg
JyVseCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIHVuc2lnbmVkIGludCcsIGJ1dCBh
cmd1bWVudCAyIGhhcyB0eXBlICd1aW50NjRfdCcge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGlu
dCd9IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgaHdfZXJyb3IoIkVEVTogRE1BIHJhbmdlIDB4JS44
bHgtMHglLjhseCBvdXQgb2YgYm91bmRzICgweCUuOGx4LTB4JS44bHgpISIsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfn5+fl4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAlLjhsbHgKICAgICAgICAgICAgIGFkZHIsIGVuZDEgLSAxLCBzdGFydCwgZW5kMiAtIDEpOwog
ICAgICAgICAgICAgfn5+fiAgICAgICAgICAgICAgICAgICAgCi90bXAvcWVtdS10ZXN0L3NyYy9o
dy9taXNjL2VkdS5jOjExNzo0NDogZXJyb3I6IGZvcm1hdCAnJWx4JyBleHBlY3RzIGFyZ3VtZW50
IG9mIHR5cGUgJ2xvbmcgdW5zaWduZWQgaW50JywgYnV0IGFyZ3VtZW50IDMgaGFzIHR5cGUgJ3Vp
bnQ2NF90JyB7YWthICdsb25nIGxvbmcgdW5zaWduZWQgaW50J30gWy1XZXJyb3I9Zm9ybWF0PV0K
ICAgICBod19lcnJvcigiRURVOiBETUEgcmFuZ2UgMHglLjhseC0weCUuOGx4IG91dCBvZiBib3Vu
ZHMgKDB4JS44bHgtMHglLjhseCkhIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH5+fn5eCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlLjhs
bHgKICAgICAgICAgICAgIGFkZHIsIGVuZDEgLSAxLCBzdGFydCwgZW5kMiAtIDEpOwogICAgICAg
ICAgICAgICAgICAgfn5+fn5+fn4gICAgICAgICAgICAgICAgICAKL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L21pc2MvZWR1LmM6MTE3OjY3OiBlcnJvcjogZm9ybWF0ICclbHgnIGV4cGVjdHMgYXJndW1l
bnQgb2YgdHlwZSAnbG9uZyB1bnNpZ25lZCBpbnQnLCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSAn
dWludDY0X3QnIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9
XQogICAgIGh3X2Vycm9yKCJFRFU6IERNQSByYW5nZSAweCUuOGx4LTB4JS44bHggb3V0IG9mIGJv
dW5kcyAoMHglLjhseC0weCUuOGx4KSEiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+XgogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlLjhsbHgKICAgICAg
ICAgICAgIGFkZHIsIGVuZDEgLSAxLCBzdGFydCwgZW5kMiAtIDEpOwogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH5+fn5+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAovdG1w
L3FlbXUtdGVzdC9zcmMvaHcvbWlzYy9lZHUuYzoxMTc6NzU6IGVycm9yOiBmb3JtYXQgJyVseCcg
ZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIHVuc2lnbmVkIGludCcsIGJ1dCBhcmd1bWVu
dCA1IGhhcyB0eXBlICd1aW50NjRfdCcge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFst
V2Vycm9yPWZvcm1hdD1dCiAgICAgaHdfZXJyb3IoIkVEVTogRE1BIHJhbmdlIDB4JS44bHgtMHgl
LjhseCBvdXQgb2YgYm91bmRzICgweCUuOGx4LTB4JS44bHgpISIsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+
fl4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAlLjhsbHgKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDIwMTQ1MTIwLjEyMjg0Ny0xLWxpcTNlYUAxNjMu
Y29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


