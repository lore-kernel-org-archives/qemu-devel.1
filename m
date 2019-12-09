Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F7EC04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC473205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC473205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieOip-0003Nv-VI
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 14:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieOi1-0002is-Fn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieOi0-0003IJ-9C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:28:41 -0500
Resent-Date: Mon, 09 Dec 2019 14:28:41 -0500
Resent-Message-Id: <E1ieOi0-0003IJ-9C@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieOi0-0003Gj-1i; Mon, 09 Dec 2019 14:28:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575919712; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b5gMCZ0w6qHOSAN9xpj+OlkgqfEyriDgNSYhkPzD2j7kOTSZs/DKjcLXlgGbPnP6MfvYM5wna0BULCSmBKymE5OXtWBI0Bwn1Fjru9ZNEo4WFH+waHuPscbxXQNzaCTsD5J+Ba9JOxDvveZjEfteifMhz+Ibm6AeEFeEWX5hIIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575919712;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mirHobHjZMfBqXWfg7dmvpd3KYpMKJU9Y3DgZjCNBPc=; 
 b=YgxIEQNNiMtiXqDht4tuVaXzZoxtqP0RPB8KO4Z1o/gwKmBNQdfArvSOnb5/qPTsbUmVtejghKP8g3sFBpAJwJBfHkG/vTqP2Iq/x1baR2URhR8MRUuDT+a3cFYLemsshbrpMuAJCCaFigCu+Rp2UblsJLFVkggCgzZWvp9Nb+s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575919712344617.065409095935;
 Mon, 9 Dec 2019 11:28:32 -0800 (PST)
In-Reply-To: <20191209143723.6368-1-alex.bennee@linaro.org>
Subject: Re: [PATCH] target/arm: ensure we use current exception state after
 SCR update
Message-ID: <157591971115.7675.4665081235284955931@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Mon, 9 Dec 2019 11:28:32 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTE0MzcyMy42MzY4
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDbG9uZSBvZiAnaHR0cHM6
Ly9naXQucWVtdS5vcmcvZ2l0L2R0Yy5naXQnIGludG8gc3VibW9kdWxlIHBhdGggJ2R0YycgZmFp
bGVkCmZhaWxlZCB0byB1cGRhdGUgc3VibW9kdWxlIGR0YwpTdWJtb2R1bGUgJ2R0YycgKGh0dHBz
Oi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0KSB1bnJlZ2lzdGVyZWQgZm9yIHBhdGggJ2R0YycK
bWFrZVsxXTogKioqIFsvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaDFwM3Y3Y2ovc3JjL2Rv
Y2tlci1zcmMuMjAxOS0xMi0wOS0xNC4yOC4yOC4xODIxMl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWgxcDN2N2NqL3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAwbTMuOTg1cwp1c2VyICAgIDBtMi41ODJzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTIwOTE0MzcyMy42MzY4LTEtYWxleC5iZW5u
ZWVAbGluYXJvLm9yZy90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


