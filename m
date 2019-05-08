Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3FC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59D721019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 04:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59D721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pku.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOEC7-0001vO-Kx
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 00:28:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gxt@pku.edu.cn>) id 1hOEBJ-0001eW-OU
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gxt@pku.edu.cn>) id 1hOEBI-0002gt-Nc
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:27:49 -0400
Received: from mx11.pku.edu.cn ([162.105.129.174]:15084 helo=pku.edu.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gxt@pku.edu.cn>) id 1hOEBI-0002dx-5I
	for qemu-devel@nongnu.org; Wed, 08 May 2019 00:27:48 -0400
Received: by ajax-webmail-mailfront04 (Coremail) ; Wed, 8 May 2019 12:27:38
	+0800 (GMT+08:00)
X-Originating-IP: [203.187.182.140]
Date: Wed, 8 May 2019 12:27:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Guan Xuetao" <gxt@pku.edu.cn>
To: "peter maydell" <peter.maydell@linaro.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.7b build 20180509(9e2321e9)
	Copyright (c) 2002-2019 www.mailtech.cn pku.edu.cn
In-Reply-To: <CAFEAcA_jBgEvFTnSu_KMHD6Ofnr05DvX6mTZD1x7-jhdi8sdJg@mail.gmail.com>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-23-richard.henderson@linaro.org>
	<CAFEAcA_jBgEvFTnSu_KMHD6Ofnr05DvX6mTZD1x7-jhdi8sdJg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <688c1a14.5ab49.16a95b26835.Coremail.gxt@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 9IFpogAH0yC6WtJcvPCTAg--.11247W
X-CM-SenderInfo: qqqqliixuslio6sn3hxhgxhubq/1tbiAQAEB1Py8iCO+AAAsH
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 162.105.129.174
Subject: Re: [Qemu-devel] [PATCH 22/26] target/unicore32: Convert to
 CPUClass::tlb_fill
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
Cc: richard henderson <richard.henderson@linaro.org>,
	qemu developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ckl0J3MgT0sgZm9yIHVuaWNvcmUzMiBjb2Rlcy4KClRoYW5rcy4KCkd1YW4gWHVldGFvCgoKPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiUGV0ZXIgTWF5ZGVsbCIgPHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZz4KPiBTZW50IFRpbWU6IDIwMTktMDQtMzAgMTg6MDY6MDMgKFR1
ZXNkYXkpCj4gVG86ICJSaWNoYXJkIEhlbmRlcnNvbiIgPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmc+Cj4gQ2M6ICJRRU1VIERldmVsb3BlcnMiIDxxZW11LWRldmVsQG5vbmdudS5vcmc+LCAi
R3VhbiBYdWV0YW8iIDxneHRAbXByYy5wa3UuZWR1LmNuPgo+IFN1YmplY3Q6IFJlOiBbUWVtdS1k
ZXZlbF0gW1BBVENIIDIyLzI2XSB0YXJnZXQvdW5pY29yZTMyOiBDb252ZXJ0IHRvIENQVUNsYXNz
Ojp0bGJfZmlsbAo+IAo+IE9uIFdlZCwgMyBBcHIgMjAxOSBhdCAwNDo1OCwgUmljaGFyZCBIZW5k
ZXJzb24KPiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4gd3JvdGU6Cj4gPgo+ID4gQ2M6
IEd1YW4gWHVldGFvIDxneHRAbXByYy5wa3UuZWR1LmNuPgo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+Cj4gPiAtLS0KPiA+
ICB0YXJnZXQvdW5pY29yZTMyL2NwdS5oICAgICAgIHwgIDUgKysrLS0KPiA+ICB0YXJnZXQvdW5p
Y29yZTMyL2NwdS5jICAgICAgIHwgIDUgKy0tLS0KPiA+ICB0YXJnZXQvdW5pY29yZTMyL2hlbHBl
ci5jICAgIHwgMjMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICB0YXJnZXQvdW5pY29yZTMy
L29wX2hlbHBlci5jIHwgMTQgLS0tLS0tLS0tLS0tLS0KPiA+ICB0YXJnZXQvdW5pY29yZTMyL3Nv
ZnRtbXUuYyAgIHwgMTkgKysrKysrKysrKysrKysrLS0tLQo+ID4gIDUgZmlsZXMgY2hhbmdlZCwg
MTkgaW5zZXJ0aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pCj4gCj4gUmV2aWV3ZWQtYnk6IFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4KPiAKPiBZb3UgbWlnaHQgbm90ZSBp
biB0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCB3ZSBjYW4ganVzdCBkZWxldGUKPiB0aGUgdXNlci1t
b2RlIChub24tKWhhbmRsaW5nIG9mIHRsYiBmaWxsIGJlY2F1c2Ugd2UKPiBkb24ndCBzdXBwb3J0
IHVuaWNvcmUzMiBsaW51eC11c2VyIGFueSBtb3JlLgo+IAo+IHRoYW5rcwo+IC0tIFBNTQo=

