Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F2C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855B021924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855B021924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4ka-0000GY-TZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB4Bm-0003ZO-D2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB4Bl-0006oE-8D
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:42:10 -0400
Resent-Date: Thu, 19 Sep 2019 17:42:10 -0400
Resent-Message-Id: <E1iB4Bl-0006oE-8D@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB4Bk-0006nz-VK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568926590; cv=none; d=zoho.com; s=zohoarc; 
 b=Cx1cPNtbpLRfP3eYsgIQlXFYwO6JbumwNmdKZJ6IWRtm9bLrhULgQPgubqGMDFU3zZbqA2DXfAdSqZldNL+o42WEOZFUC6iTlf+IyAfuixmVjtS3cFJBL+iiR5PpA1y/1DhzwiBS6lS0tLoIpoOtPfXvwSveMncetpT68OiZveU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568926590;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=auxqEA3Xv+6y9bwyggt/NLM33WfUILlFKF+pZ8fHsIQ=; 
 b=VFz+TkAWHL7wE3hkA/j0QIH/E3ceop3HbWG8NtQubsqwHfnLNaQ+Vg96azRur7SFVAIvi5rdD/Oik8A+jbDOsIsFtuVwWjAJn6tKcLilVtIR6UvFys+NOQzicx1dYifvTZjuTzadZUFn3HfvkkLG8f4wyBjOqJIALs8mFkml5s8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568926588938354.4897800261799;
 Thu, 19 Sep 2019 13:56:28 -0700 (PDT)
In-Reply-To: <20190919055002.6729-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 00/21] aspeed: Add support for the AST2600 SoC
Message-ID: <156892658765.2125.17871103047730488122@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: clg@kaod.org
Date: Thu, 19 Sep 2019 13:56:28 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, joel@jms.id.au, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTA1NTAwMi42NzI5
LTEtY2xnQGthb2Qub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLXF1
aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMg
YW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91
IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09SSz0x
CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBORVRX
T1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmxpYnVkZXYgICAgICAgICAgIG5vCmRlZmF1
bHQgZGV2aWNlcyAgIHllcwoKd2FybmluZzogUHl0aG9uIDIgc3VwcG9ydCBpcyBkZXByZWNhdGVk
Cndhcm5pbmc6IFB5dGhvbiAzIHdpbGwgYmUgcmVxdWlyZWQgZm9yIGJ1aWxkaW5nIGZ1dHVyZSB2
ZXJzaW9ucyBvZiBRRU1VCmNyb3NzIGNvbnRhaW5lcnMgIG5vCgpOT1RFOiBndWVzdCBjcm9zcy1j
b21waWxlcnMgZW5hYmxlZDogY2MKLS0tClByb3BlcnR5ICcuY250ZnJxJyBub3QgZm91bmQKQnJv
a2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL2xpYnF0ZXN0LmM6MTQ5OiBraWxsX3Fl
bXUoKSBkZXRlY3RlZCBRRU1VIGRlYXRoIGZyb20gc2lnbmFsIDYgKEFib3J0ZWQpIChjb3JlIGR1
bXBlZCkKRVJST1IgLSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgNiwgZ290IDUpCm1ha2U6
ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3Ig
dW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9x
MzUtdGVzdAoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTA5MTkwNTUwMDIuNjcyOS0xLWNsZ0BrYW9kLm9yZy90ZXN0aW5nLmRvY2tlci1x
dWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


