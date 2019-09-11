Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD219C4360D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 03:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A96D21928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 03:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96D21928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7tbl-00066x-BN
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 23:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7taX-0005ek-TY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 23:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7taW-0001wK-BQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 23:46:37 -0400
Resent-Date: Tue, 10 Sep 2019 23:46:37 -0400
Resent-Message-Id: <E1i7taW-0001wK-BQ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7taW-0001vc-3t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 23:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568173587; cv=none; d=zoho.com; s=zohoarc; 
 b=S6wpLjEVq8e6F7pA9/rQ8PNUwzO/Mx0zRl5ggThD+Xdc7ZBpYxUFTa0yVifoBMmsQfd2lLEeEvPHuogW40K1/YAJ5Ew9HKt6h242CBLBhn+rjhgXXQ68TkReefQQe3QON4KbB3k4dl27k0PQAEuziDXLfDVbwlw0F2pwIjsc328=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568173587;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=uPpAmENuFKwu4InUd5nsYCjwbsdf9Wop/1KTK5+ZGSM=; 
 b=nqGb2B+cmNlh4lRaoSy/YZgYW18126uP7+7AYop7fDbTbPhlbeTe75TS6hJ4Q1GHO7k066mnjUqrMGF5W4tt1gaQQFg5MlzpUCqJYk/vii+RZR0XDG+LRYPHOqkjozz/pAQ0YBeXkS+miznGTvTundHi5LhhEfUYaNCPQY9I31E=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568173585875467.9677205117699;
 Tue, 10 Sep 2019 20:46:25 -0700 (PDT)
In-Reply-To: <20190911014353.5926-1-richard.henderson@linaro.org>
Message-ID: <156817358470.15929.4218507075303277574@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 10 Sep 2019 20:46:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/3] cputlb: Adjust tlb bswap implementation
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMTAxNDM1My41OTI2
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpsaWJ1ZGV2ICAg
ICAgICAgICBubwpkZWZhdWx0IGRldmljZXMgICB5ZXMKCndhcm5pbmc6IFB5dGhvbiAyIHN1cHBv
cnQgaXMgZGVwcmVjYXRlZAp3YXJuaW5nOiBQeXRob24gMyB3aWxsIGJlIHJlcXVpcmVkIGZvciBi
dWlsZGluZyBmdXR1cmUgdmVyc2lvbnMgb2YgUUVNVQoKTk9URTogY3Jvc3MtY29tcGlsZXJzIGVu
YWJsZWQ6ICAnY2MnCiAgR0VOICAgICBhYXJjaDY0LXNvZnRtbXUvY29uZmlnLWRldmljZXMubWFr
LnRtcAotLS0KTWVtb3J5IGNvbnRlbnQgaW5jb25zaXN0ZW5jeSBhdCA0MDE4ZjAwMCBmaXJzdF9i
eXRlID0gZTQgbGFzdF9ieXRlID0gZTQgY3VycmVudCA9IGU1IGhpdF9lZGdlID0gMApNZW1vcnkg
Y29udGVudCBpbmNvbnNpc3RlbmN5IGF0IDQwMTkwMDAwIGZpcnN0X2J5dGUgPSBlNCBsYXN0X2J5
dGUgPSBlNCBjdXJyZW50ID0gZTUgaGl0X2VkZ2UgPSAwCmFuZCBpbiBhbm90aGVyIDI1MTk5IHBh
Z2VzKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0LmM6MzQy
OmNoZWNrX2d1ZXN0c19yYW06IGFzc2VydGlvbiBmYWlsZWQ6IChiYWQgPT0gMCkKRVJST1IgLSBC
YWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0LmM6
MzQyOmNoZWNrX2d1ZXN0c19yYW06IGFzc2VydGlvbiBmYWlsZWQ6IChiYWQgPT0gMCkKbWFrZTog
KioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LXRocm90
dGxlCi0tLQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAyNTIKUGFzc2VkIGFsbCAxMDYgdGVzdHMK
KioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL2Jvb3Qtc2VjdG9yLmM6MTYxOmJvb3Rf
c2VjdG9yX3Rlc3Q6IGFzc2VydGlvbiBmYWlsZWQgKHNpZ25hdHVyZSA9PSBTSUdOQVRVUkUpOiAo
MHgwMDAwMDAwMCA9PSAweDAwMDBkZWFkKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3Fl
bXUtdGVzdC9zcmMvdGVzdHMvYm9vdC1zZWN0b3IuYzoxNjE6Ym9vdF9zZWN0b3JfdGVzdDogYXNz
ZXJ0aW9uIGZhaWxlZCAoc2lnbmF0dXJlID09IFNJR05BVFVSRSk6ICgweDAwMDAwMDAwID09IDB4
MDAwMGRlYWQpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkiLCBsaW5lIDY1OSwgaW4gPG1vZHVsZT4KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTExMDE0MzUzLjU5MjYtMS1yaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=


