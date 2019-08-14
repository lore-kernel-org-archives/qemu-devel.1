Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2231CC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D2F2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D2F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxte4-0006wX-4c
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 09:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1hxtdF-0006Qm-2Y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hxtdD-0002Fr-T0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:48:05 -0400
Resent-Date: Wed, 14 Aug 2019 09:48:04 -0400
Resent-Message-Id: <E1hxtdD-0002Fr-T0@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hxtdD-0002FM-Lt
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:48:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565790441; cv=none; d=zoho.com; s=zohoarc; 
 b=f/bnoA3Gdpqe2HdTGBLd3mtDF+S9TohIUs2n9VX+n2HoW3H9EFqlAb+rhirVcg77hAFl5uhiH2ODWTYjAcfNbpcG6Yseynzf2x9mZNoQN93myiL5GeN74gH+zcNdxoiReW48Qlr7l5GIAz5h6LqlYFQwoZphIgv/lX6VzSp/uMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565790441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=X45gYtG7Qwd6bkeyC5w7mSLp7u0Wd+YMV7hB0I96c/I=; 
 b=BBOhnlxtrsGUGW9EF1RcJ3RIhSBeQWK29fya3WUHasH8ErfaJXICIBvpVAc0r1Jr2DG5EDZwjn8hTgseOP4WgIBI+k/bXVDvBWm+lu83hm60/xs8ahbTgtLqBVhncWJRas35hRx1oMHIMjm8ILQUZI2UF27SHfmgEODuUqL+XN0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565790440534923.2350541650668;
 Wed, 14 Aug 2019 06:47:20 -0700 (PDT)
In-Reply-To: <20190814071433.22243-1-rashmica.g@gmail.com>
Message-ID: <156579043881.3056.6789768802915366209@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rashmica.g@gmail.com
Date: Wed, 14 Aug 2019 06:47:20 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Add Aspeed GPIO controller model
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
 aik@ozlabs.ru, qemu-arm@nongnu.org, joel@jms.id.au, rashmica.g@gmail.com,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgxNDA3MTQzMy4yMjI0
My0xLXJhc2htaWNhLmdAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWls
ZCB0ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwg
YmUgaW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRv
IGEgY29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgoj
IGJyYW5jaApzZXQgLWUKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9
PT0gUEFDS0FHRVMgPT09IgpycG0gLXFhCgplY2hvCmVjaG8gIj09PSBVTkFNRSA9PT0iCnVuYW1l
IC1hCgpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWls
ZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmln
dXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJl
bGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFsbAo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGFybS1zb2Z0bW11L2h3L2dwaW8vYXNwZWVkX2dw
aW8ubwogIENDICAgICAgYWxwaGEtc29mdG1tdS9ody92aXJ0aW8vdmhvc3QtdXNlci1ibGstcGNp
Lm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90Y2cvdGNnLW9wLXZlYy5vCi92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1ieTRpcTRleC9zcmMvaHcvZ3Bpby9hc3BlZWRfZ3Bpby5jOjgzNzo2
OiBlcnJvcjog4oCYQXNwZWVkR1BJT0NvbnRyb2xsZXLigJkge2FrYSDigJhjb25zdCBzdHJ1Y3Qg
QXNwZWVkR1BJT0NvbnRyb2xsZXLigJl9IGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYbWVtX3NpemXi
gJkKICA4MzcgfCAgICAgLm1lbV9zaXplICAgICAgID0gR1BJT18zXzZWX01FTV9TSVpFLAogICAg
ICB8ICAgICAgXn5+fn5+fn4KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWJ5NGlxNGV4L3Ny
Yy9ody9ncGlvL2FzcGVlZF9ncGlvLmM6ODQ0OjY6IGVycm9yOiDigJhBc3BlZWRHUElPQ29udHJv
bGxlcuKAmSB7YWthIOKAmGNvbnN0IHN0cnVjdCBBc3BlZWRHUElPQ29udHJvbGxlcuKAmX0gaGFz
IG5vIG1lbWJlciBuYW1lZCDigJhtZW1fc2l6ZeKAmQogIDg0NCB8ICAgICAubWVtX3NpemUgICAg
ICAgPSBHUElPXzFfOFZfTUVNX1NJWkUsCiAgICAgIHwgICAgICBefn5+fn5+fgptYWtlWzFdOiAq
KiogWy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ieTRpcTRleC9zcmMvcnVsZXMubWFrOjY5
OiBody9ncGlvL2FzcGVlZF9ncGlvLm9dIEVycm9yIDEKLS0tCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvaHcvZ3Bpby9iY20yODM1X2dwaW8ubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3
L2dwaW8vbnJmNTFfZ3Bpby5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvZ3Bpby9hc3Bl
ZWRfZ3Bpby5vCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ieTRpcTRleC9zcmMvaHcvZ3Bp
by9hc3BlZWRfZ3Bpby5jOjgzNzo2OiBlcnJvcjog4oCYQXNwZWVkR1BJT0NvbnRyb2xsZXLigJkg
e2FrYSDigJhjb25zdCBzdHJ1Y3QgQXNwZWVkR1BJT0NvbnRyb2xsZXLigJl9IGhhcyBubyBtZW1i
ZXIgbmFtZWQg4oCYbWVtX3NpemXigJkKICA4MzcgfCAgICAgLm1lbV9zaXplICAgICAgID0gR1BJ
T18zXzZWX01FTV9TSVpFLAogICAgICB8ICAgICAgXn5+fn5+fn4KL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWJ5NGlxNGV4L3NyYy9ody9ncGlvL2FzcGVlZF9ncGlvLmM6ODQ0OjY6IGVycm9y
OiDigJhBc3BlZWRHUElPQ29udHJvbGxlcuKAmSB7YWthIOKAmGNvbnN0IHN0cnVjdCBBc3BlZWRH
UElPQ29udHJvbGxlcuKAmX0gaGFzIG5vIG1lbWJlciBuYW1lZCDigJhtZW1fc2l6ZeKAmQogIDg0
NCB8ICAgICAubWVtX3NpemUgICAgICAgPSBHUElPXzFfOFZfTUVNX1NJWkUsCiAgICAgIHwgICAg
ICBefn5+fn5+fgptYWtlWzFdOiAqKiogWy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ieTRp
cTRleC9zcmMvcnVsZXMubWFrOjY5OiBody9ncGlvL2FzcGVlZF9ncGlvLm9dIEVycm9yIDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
ODE0MDcxNDMzLjIyMjQzLTEtcmFzaG1pY2EuZ0BnbWFpbC5jb20vdGVzdGluZy5zMzkweC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


