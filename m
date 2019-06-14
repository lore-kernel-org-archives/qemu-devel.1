Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E652EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0BC217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0BC217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbsBn-0007Ay-3k
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hbsB1-0006lO-1G
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 15:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hbsAz-0002pa-EY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 15:47:54 -0400
Resent-Date: Fri, 14 Jun 2019 15:47:54 -0400
Resent-Message-Id: <E1hbsAz-0002pa-EY@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hbsAz-0002o4-0w
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 15:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560541668; cv=none; d=zoho.com; s=zohoarc; 
 b=A77wn4luHBFt/d63FcujGXSFI82Ii5XliBt7VviJnCcGFmqwQgW3l7iYwGQr59Prc2DthCdkspV+AqkLSWp6JYPD0uvTO4Jvr9k1c8W8WbyX82kktO++DOzsJ4Tf7poqm+6KGqaPLElT9FweXCKilwO7PndhKOSGew42rnQqm6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560541668;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=UOJBCfW5Snc+p9dNkAJUzYhluCS944BcWFbkOLjGyXw=; 
 b=LP2ajslmo9/cVBQUWryg1M7liymMW9KLY9G6p8IDLsQiRi5wg6wP5ulfQPvbF4Af8n6YyU+y21zS6ETrcOE7Iepv+DxM1pSikyuBQM65+VkJ730I8FJS1NVf4J14vDyA4mTD92RsX2nMYYLk+TS8Qq/C8bO6HpDIouQ9Mr+kahw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156054166693236.67260611033964;
 Fri, 14 Jun 2019 12:47:46 -0700 (PDT)
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
Message-ID: <156054166606.13573.5298444342662423519@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 14 Jun 2019 12:47:46 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH  v3 00/50] tcg plugin support
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNDE3MTIwMC4yMTA3
OC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUg
bWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQt
c29mdG1tdS9iYWxsb29uLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2lvcG9ydC5vCiAgQ0Mg
ICAgICB4ODZfNjQtc29mdG1tdS9udW1hLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTAy
OjU6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdjc2gnCiAgICBjc2ggaGFu
ZGxlOwogICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvZGlzYXMuYzo1MDM6NTogZXJyb3I6IHVzZSBv
ZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ2NzX2luc24nCiAgICBjc19pbnNuICppbnNuOwogICAg
XgovdG1wL3FlbXUtdGVzdC9zcmMvZGlzYXMuYzo1MDM6MTQ6IGVycm9yOiB1c2Ugb2YgdW5kZWNs
YXJlZCBpZGVudGlmaWVyICdpbnNuJzsgZGlkIHlvdSBtZWFuICdpbmZvJz8KICAgIGNzX2luc24g
Kmluc247CiAgICAgICAgICAgICBefn5+CiAgICAgICAgICAgICBpbmZvCi90bXAvcWVtdS10ZXN0
L3NyYy9kaXNhcy5jOjQ5OTo1Mzogbm90ZTogJ2luZm8nIGRlY2xhcmVkIGhlcmUKc3RhdGljIGJv
b2wgcGx1Z2luX2NhcF9kaXNhc19pbnNuKGRpc2Fzc2VtYmxlX2luZm8gKmluZm8sIHVpbnQ2NF90
IHBjLCBzaXplX3Qgc2l6ZSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTA4Ojk6IGVycm9yOiBp
bXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnY2FwX2Rpc2FzX3N0YXJ0JyBpcyBpbnZh
bGlkIGluIEM5OSBbLVdlcnJvciwtV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAg
aWYgKGNhcF9kaXNhc19zdGFydChpbmZvLCAmaGFuZGxlKSAhPSBDU19FUlJfT0spIHsKICAgICAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUwODo5OiBlcnJvcjogdGhpcyBmdW5jdGlv
biBkZWNsYXJhdGlvbiBpcyBub3QgYSBwcm90b3R5cGUgWy1XZXJyb3IsLVdzdHJpY3QtcHJvdG90
eXBlc10KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTA4OjMyOiBlcnJvcjogdXNlIG9mIHVu
ZGVjbGFyZWQgaWRlbnRpZmllciAnaGFuZGxlJwogICAgaWYgKGNhcF9kaXNhc19zdGFydChpbmZv
LCAmaGFuZGxlKSAhPSBDU19FUlJfT0spIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTA4OjQzOiBlcnJvcjogdXNlIG9mIHVuZGVj
bGFyZWQgaWRlbnRpZmllciAnQ1NfRVJSX09LJwogICAgaWYgKGNhcF9kaXNhc19zdGFydChpbmZv
LCAmaGFuZGxlKSAhPSBDU19FUlJfT0spIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvZGlzYXMuYzo1MTE6NTogZXJyb3I6IHVz
ZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ2luc24nCiAgICBpbnNuID0gY2FwX2luc247CiAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUxMToxMjogZXJyb3I6IHVzZSBvZiB1bmRl
Y2xhcmVkIGlkZW50aWZpZXIgJ2NhcF9pbnNuJwogICAgaW5zbiA9IGNhcF9pbnNuOwogICAgICAg
ICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Rpc2FzLmM6NTE3OjEzOiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2NzX2Rpc2FzbScgaXMgaW52YWxpZCBpbiBDOTkgWy1X
ZXJyb3IsLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgIGNvdW50ID0gY3NfZGlz
YXNtKGhhbmRsZSwgY2J1Ziwgc2l6ZSwgMCwgMSwgJmluc24pOwogICAgICAgICAgICBeCi90bXAv
cWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUxNzoxMzogZXJyb3I6IHRoaXMgZnVuY3Rpb24gZGVjbGFy
YXRpb24gaXMgbm90IGEgcHJvdG90eXBlIFstV2Vycm9yLC1Xc3RyaWN0LXByb3RvdHlwZXNdCi90
bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUxNzoyMzogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVk
IGlkZW50aWZpZXIgJ2hhbmRsZScKICAgIGNvdW50ID0gY3NfZGlzYXNtKGhhbmRsZSwgY2J1Ziwg
c2l6ZSwgMCwgMSwgJmluc24pOwogICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVz
dC9zcmMvZGlzYXMuYzo1MTc6NTA6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVy
ICdpbnNuJwogICAgY291bnQgPSBjc19kaXNhc20oaGFuZGxlLCBjYnVmLCBzaXplLCAwLCAxLCAm
aW5zbik7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUyMDozNzogZXJyb3I6IHVzZSBvZiB1bmRlY2xh
cmVkIGlkZW50aWZpZXIgJ2luc24nCiAgICAgICAgZ19zdHJpbmdfcHJpbnRmKHMsICIlcyAlcyIs
IGluc24tPm1uZW1vbmljLCBpbnNuLT5vcF9zdHIpOwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9kaXNhcy5jOjUyMDo1MzogZXJyb3I6IHVz
ZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ2luc24nCiAgICAgICAgZ19zdHJpbmdfcHJpbnRm
KHMsICIlcyAlcyIsIGluc24tPm1uZW1vbmljLCBpbnNuLT5vcF9zdHIpOwogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9z
cmMvZGlzYXMuYzo1MjU6NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
ICdjc19jbG9zZScgaXMgaW52YWxpZCBpbiBDOTkgWy1XZXJyb3IsLVdpbXBsaWNpdC1mdW5jdGlv
bi1kZWNsYXJhdGlvbl0KICAgIGNzX2Nsb3NlKCZoYW5kbGUpOwogICAgXgovdG1wL3FlbXUtdGVz
dC9zcmMvZGlzYXMuYzo1MjU6NTogZXJyb3I6IHRoaXMgZnVuY3Rpb24gZGVjbGFyYXRpb24gaXMg
bm90IGEgcHJvdG90eXBlIFstV2Vycm9yLC1Xc3RyaWN0LXByb3RvdHlwZXNdCi90bXAvcWVtdS10
ZXN0L3NyYy9kaXNhcy5jOjUyNToxNTogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZp
ZXIgJ2hhbmRsZScKICAgIGNzX2Nsb3NlKCZoYW5kbGUpOwogICAgICAgICAgICAgIF4KMTggZXJy
b3JzIGdlbmVyYXRlZC4KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNjE0MTcxMjAwLjIxMDc4LTEtYWxleC5iZW5uZWVAbGluYXJvLm9y
Zy90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


