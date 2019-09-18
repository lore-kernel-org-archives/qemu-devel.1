Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA25DC4CED4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 04:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4059214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 04:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PLjV9YIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4059214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAROY-00087f-Om
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 00:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iARNE-0007aM-MT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 00:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iARNC-0000oB-8S
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 00:15:23 -0400
Received: from smtpbg502.qq.com ([203.205.250.69]:36948 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iARN9-0000ek-VE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 00:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1568779685;
 bh=QcEllYwt6LlGpGfp2n6FXVPwgLz1R1ZjVzp8ayJuD7M=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=PLjV9YIkAEpgclEGzt5qBTr4DEVELMLy0KMlD8rRUWjQN9D6pCv0+OJqrog+qkBSX
 /4e99ZYDT8AZusgG8ZFEaciRVJxH+guYHWUvJW9o3ZByZosBO8Jgyllpm/DsFfgc9p
 OgHva1RqS211ryIjHzUbdcVzy441wX9a2aJNwUsU=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <87h85hzqqi.fsf@linaro.org>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
 <tencent_23ACCA1A48AFB09124C52E70@qq.com> <87blvy99y9.fsf@linaro.org>
 <tencent_0E8715864EBBAA153BB730E2@qq.com>
 <87h85hzqqi.fsf@linaro.org>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1568779684t805339
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?QWxleCBCZW5u6WU=?=" <alex.bennee@linaro.org>
Mime-Version: 1.0
Date: Wed, 18 Sep 2019 12:08:03 +0800
X-Priority: 3
Message-ID: <tencent_58B0F07F365894E75B3A12FC@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3849666554
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Wed, 18 Sep 2019 12:08:04 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.69
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
 =?ISO-8859-1?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?= <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWxleCBCZW5u6WUgd3JpdGVzOg0KDQo+IFlvdSB3aWxsIG5lZWQgdG8gdXBkYXRlIGdkYi14
bWwvJEFSQ0gueG1sIGFuZCB0aGUgYXBwcm9wcmlhdGUNCmFyY2hfcmVhZC93cml0ZSByZWdp
c3RlciBmdW5jdGlvbnMgaW4gZ2Ric3R1Yi4NCg0KDQoNCkZvciBzb21lIG15c3RlcmlvdXMg
cmVhc29uIG15IHByZXZpb3VzIGVtYWlscyBkaWRuJ3QgZ28gdG8gdGhlIGxpc3Qgc3VjY2Vz
c2Z1bGx5LiBMZXQgbWUgdHJ5IHNlbmRpbmcgdGhpcyBvbmUgd2l0aG91dCBpbmNsdWRpbmcg
YW55IGNvZGUgb3IgbGluay4NCg0KDQoNClRoZSBNSVBTIHRhcmdldCBkb2Vzbid0IGhhdmUg
bWlwcyoueG1sLCBzbyBJIHRyaWVkIGltcGxlbWVudGluZyBpdCBteXNlbGYuIEFzIHBlciB0
aGUgIlN0YW5kYXJkIFRhcmdldCBGZWF0dXJlcyIgcmVxdWlyZW1lbnQgYnkgR0RCLCBJIGNy
ZWF0ZWQgbWlwcy1jcHUueG1sLCBtaXBzLWNwMC54bWwsIG1pcHMtZnB1LnhtbCwgYW5kIGZp
bmFsbHkgaW5jbHVkZWQgdGhlbSBhbGwgaW4gYSB3cmFwcGVyIG1pcHMueG1sLiBFc3NlbnRp
YWxseSBJIGZvbGxvd2VkIHRoaXMgY29tbWl0OiBiODE1ODE5MmZhZGIzZTM0NjM3MjQ1NmMy
NWNiYmM0YmU1ODRhODVjLiAoWWVzIGl0IGZhaWxlZCBiZWNhdXNlIDxmZWF0dXJlPiBpcyBu
ZXN0ZWQgaW4gPGZlYXR1cmU+LCBzbyBJIG5lc3QgPGZlYXR1cmU+IGluIDx0YXJnZXQ+LikN
Cg0KDQpVbmZvcnR1bmF0ZWx5LCBpdCBkb2Vzbid0IHdvcmsuIEdEQiBqdXN0IGRvZXNuJ3Qg
cmVjb2duaXplIG15IGNoYW5nZS4gSXQgc3RpbGwgZGlzcGxheXMgdGhlIGRlZmF1bHQgcmVn
IG5hbWVzICh6ZXJvLCBhdCwgdjAsIHYxLCBhMCwgYTEsIGV0Yy4pLCBidXQgSSB3YW50IG15
IHIwLCByMSwgLi4uIHIzMS4NCg0KDQpTbywgSSB3ZW50IHRvIHRoZSBpMzg2IHRhcmdldCwg
d2hvc2UgZ2Ric3R1YiBpcyB3b3JraW5nIHByb3Blcmx5LCBhbmQgdHdlYWtlZCB3aXRoIGl0
cyB4bWwgdG8gc2VlIGlmIGNoYW5naW5nIHhtbCByZWcgbmFtZXMgcmVmbGVjdHMgaW4gR0RC
IHNlc3Npb24uIEhvd2V2ZXIsIHdoZW4gSSBjaGFuZ2VkICJyYXgiIHRvICJ6YXgiLCBHREIg
Z2F2ZSBtZSBhICdnJyBwYWNrZXQgZXJyb3IuIEkgYW0gcmVhbGx5IHN0dWNrIGF0IHRoaXMg
cG9pbnQuDQoNCg0KSSByZWFsbHkgd2FudCB0byBwb3N0IG15IGdpdCBkaWZmIGJlbG93LCBi
dXQgbGV0J3Mgc2VlIGlmIG15IG1haWwgY2FuIGdvIHRvIHRoZSBsaXN0IHRoaXMgdGltZS4g
U29ycnkgZm9yIHRoZSBpbmNvbnZlbmllbmNlLg0KDQoNCg0KQ2hlZXJzLA0KDQpMaWJvIFpo
b3UNCg0KDQpQLlMuIFRoZSBkeW5hbWljIHhtbCBnZW5lcmF0aW9uIG9wdGlvbiBpcyB0b28g
ZGlmZmljdWx0IGZvciBtZSBmb3Igbm93LiBJIHdpbGwgc2F2ZSBpdCBhcyBhbiBhbHRlcm5h
dGl2ZSBpbiB0aGUgZnV0dXJlLg==
