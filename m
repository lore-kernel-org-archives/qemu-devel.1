Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371BAC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE8E2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE8E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zMt-0004RV-8B
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7zM6-0003qs-3Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7zM3-0001Hu-QZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:56:05 -0400
Resent-Date: Wed, 11 Sep 2019 05:56:04 -0400
Resent-Message-Id: <E1i7zM3-0001Hu-QZ@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7zM3-0001HK-JH
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568195742; cv=none; d=zoho.com; s=zohoarc; 
 b=IkXteXgxDQloHxbyrYICUCdsM9PJIsTJK16zVLBRDtXOlItCoNHcI58ofC3kCsinFB9XaYq/cwbphQOlAXzzrNAjG4WGQ9vLh2EK2rvmJdyOlwi7wJpK2UUYfBv4z8bF0lqcFGLGhBhVCgwOAypgqGeB6pBkiiKu0XhrScoCnc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568195742;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=5uPz0gtGSPCivYSw2f3wKlVPyODWMoK8AIIXySQTH7I=; 
 b=UoPZXLwtwqujDFmZ2oiFxOIZ8Mjlyunuu6CTZhZ+E+EezeEvg3Ze4VeFmwGytsoMYpyW71KVJhj29WYVzYUbjgpuERzp1nXx6ItmmgVae2E8s87vXBe6HmB0Q8z8EZ4xgmCO/0mdU7yC1Fupv0ztCsPA7dMmcZTLJL/ZpKhKo68=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568195740721487.3444426741762;
 Wed, 11 Sep 2019 02:55:40 -0700 (PDT)
In-Reply-To: <20190911014353.5926-1-richard.henderson@linaro.org>
Message-ID: <156819573966.18674.9190985644915425776@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 11 Sep 2019 02:55:40 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
YWJsZWQ6ICAnY2MnCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9jb25maWctZGV2aWNlcy5tYWsu
dG1wCi0tLQogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9haGNpLXRlc3QKICBU
RVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtYWlvLW11bHRpdGhyZWFkCmFuZCBpbiBhbm90
aGVyIDI1MjA4IHBhZ2VzKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlv
bi10ZXN0LmM6MzQyOmNoZWNrX2d1ZXN0c19yYW06IGFzc2VydGlvbiBmYWlsZWQ6IChiYWQgPT0g
MCkKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3Jh
dGlvbi10ZXN0LmM6MzQyOmNoZWNrX2d1ZXN0c19yYW06IGFzc2VydGlvbiBmYWlsZWQ6IChiYWQg
PT0gMCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0
cy90ZXN0LXRocm90dGxlCi0tLQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAyNTIKUGFzc2VkIGFs
bCAxMDYgdGVzdHMKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL2Jvb3Qtc2VjdG9y
LmM6MTYxOmJvb3Rfc2VjdG9yX3Rlc3Q6IGFzc2VydGlvbiBmYWlsZWQgKHNpZ25hdHVyZSA9PSBT
SUdOQVRVUkUpOiAoMHgwMDAwMDAwMCA9PSAweDAwMDBkZWFkKQpFUlJPUiAtIEJhaWwgb3V0ISBF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYm9vdC1zZWN0b3IuYzoxNjE6Ym9vdF9zZWN0
b3JfdGVzdDogYXNzZXJ0aW9uIGZhaWxlZCAoc2lnbmF0dXJlID09IFNJR05BVFVSRSk6ICgweDAw
MDAwMDAwID09IDB4MDAwMGRlYWQpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJv
ciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2Rv
Y2tlci9kb2NrZXIucHkiLCBsaW5lIDY1OSwgaW4gPG1vZHVsZT4KCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTExMDE0MzUzLjU5MjYt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRv
czcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


