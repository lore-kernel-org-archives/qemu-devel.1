Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CAEC04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87FF217D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="T4ovA8nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87FF217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=eltan.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3ud-0005df-Ud
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:30:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hSzBM-0004kk-2A
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hSzBL-0007Cw-2C
	for qemu-devel@nongnu.org; Tue, 21 May 2019 03:27:32 -0400
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:59494)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>)
	id 1hSzBC-00077J-H2; Tue, 21 May 2019 03:27:23 -0400
Received: from cpsps-ews26.kpnxchange.com ([10.94.84.192]) by
	cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514); 
	Tue, 21 May 2019 09:27:18 +0200
X-Brand: 7abm2Q==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e3=10;e2=11);EVW:Whi
	te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=RugU0xuK c=1 sm=1 tr=0 cx=a_idp_e
	a=WB5lYbMG1jvHJ1f8o08CVQ==:117 a=WB5lYbMG1jvHJ1f8o08CVQ==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=eIHzyqS2sMcA:10 a=IkcTkHD0fZMA:10
	a=xqWC_Br6kY4A:10 a=E5NmQfObTbMA:10 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8
	a=KKAkSRfTAAAA:8 a=X5F7dNyOAAAA:8 a=69wJf7TsAAAA:8
	a=rz7K1-tS9dIF2Q5L5vwA:9 a=Qi8iTSwQ1jAtfPGZ:21 a=dNiXiHrTzfZl5jbE:21
	a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22 a=cvBusfyB2V15izCimMoJ:22
	a=pS7LufLo7ZPxIL5li5Lt:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.14]) by cpsps-ews26.kpnxchange.com
	over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	Tue, 21 May 2019 09:27:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:content-type:message-id:date:subject:to:from;
	bh=CzT8Co39mEFzGYDt/cuJo1yardRv23aflTQ4l2JQRWk=;
	b=T4ovA8nurR1ieWeuQV35O66Q93VyE9kPEAQomE048eSrjEjAwG8M3SRrYUnQfkWZzpsRHA1OLky0Q
	NRuBbDL3FnoowVLfeX9frSBumZKnlVn5E32+81GIIC0F254dia8kjhl4F2tDDlFfAKHmrsSQ78jA0a
	0TWFvA1W4/IMewfU=
Received: from Eltsrv03.Eltan.local (unknown [84.85.114.86])
	by smtp.kpnmail.nl (Halon) with ESMTPS
	id dd01405b-7b99-11e9-aeb7-00505699d6e5;
	Tue, 21 May 2019 09:27:18 +0200 (CEST)
Received: from Eltsrv03.Eltan.local (192.168.100.3) by Eltsrv03.Eltan.local
	(192.168.100.3) with Microsoft SMTP Server (TLS) id 15.0.847.32;
	Tue, 21 May 2019 09:27:11 +0200
Received: from Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8]) by
	Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8%12]) with mapi id
	15.00.0847.040; Tue, 21 May 2019 09:26:54 +0200
From: Wim Vervoorn <wvervoorn@eltan.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Jason Wang
	<jasowang@redhat.com>
Thread-Topic: [PATCH] ftgmac100: do not link to netdev
Thread-Index: AQHVDzeM3eYrciCzgECTQUdGproJhqZ1Ll9Q
Date: Tue, 21 May 2019 07:26:53 +0000
Message-ID: <ce3a871593c44d248a30320febd649fd@Eltsrv03.Eltan.local>
References: <20190520181111.20407-1-clg@kaod.org>
In-Reply-To: <20190520181111.20407-1-clg@kaod.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.100.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginalArrivalTime: 21 May 2019 07:27:18.0226 (UTC)
	FILETIME=[9EE78B20:01D50FA6]
X-RcptDomain: nongnu.org
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 213.75.39.4
X-Mailman-Approved-At: Tue, 21 May 2019 08:26:01 -0400
Subject: Re: [Qemu-devel] [PATCH] ftgmac100: do not link to netdev
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8gQ8OpZHJpYywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGhlbHAuIEl0IGlzIHdvcmtp
bmcgbm93IQ0KDQpCZXN0IFJlZ2FyZHMsDQpXaW0gVmVydm9vcm4NCg0KDQoNCiJUSElTIE1FU1NB
R0UgQ09OVEFJTlMgQ09ORklERU5USUFMIElORk9STUFUSU9OLiBVTkxFU1MgWU9VIEFSRSBUSEUg
SU5URU5ERUQgUkVDSVBJRU5UIE9GIFRISVMgTUVTU0FHRSwgQU5ZIFVTRSBPRiBUSElTIE1FU1NB
R0UgSVMgU1RSSUNUTFkgUFJPSElCSVRFRC4gSUYgWU9VIEhBVkUgUkVDRUlWRUQgVEhJUyBNRVNT
QUdFIElOIEVSUk9SLCBQTEVBU0UgSU1NRURJQVRFTFkgTk9USUZZIFRIRSBTRU5ERVIgQlkgVEVM
RVBIT05FICszMS0oMCk3My01OTQ0NjY0IE9SIFJFUExZIEVNQUlMLCBBTkQgSU1NRURJQVRFTFkg
REVMRVRFIFRISVMgTUVTU0FHRSBBTkQgQUxMIENPUElFUy4iwqANCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEPDqWRyaWMgTGUgR29hdGVyIFttYWlsdG86Y2xnQGthb2Qub3Jn
XSANClNlbnQ6IE1vbmRheSwgTWF5IDIwLCAyMDE5IDg6MTEgUE0NClRvOiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPg0KQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz47IFdpbSBWZXJ2b29ybiA8d3ZlcnZvb3JuQGVsdGFuLmNvbT47IEFuZHJldyBKZWZm
ZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgcWVt
dS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQGthb2Qub3JnPg0KU3ViamVjdDogW1BBVENIXSBmdGdtYWMxMDA6IGRvIG5vdCBsaW5r
IHRvIG5ldGRldg0KDQpxZGV2X3NldF9uaWNfcHJvcGVydGllcygpIGlzIGFscmVhZHkgdXNlZCBp
biB0aGUgQXNwZWVkIFNvQyBsZXZlbCB0byBiaW5kIHRoZSBmdGdtYWMxMDAgZGV2aWNlIHRvIHRo
ZSBuZXRkZXYuDQoNClRoaXMgaXMgZml4aW5nIHN1cHBvcnQgZm9yIG11bHRpcGxlIG5ldCBkZXZp
Y2VzLg0KDQpTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0K
LS0tDQogaHcvbmV0L2Z0Z21hYzEwMC5jIHwgMiAtLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvbmV0L2Z0Z21hYzEwMC5jIGIvaHcvbmV0L2Z0Z21h
YzEwMC5jIGluZGV4IDc5MDQzMDM0NmI1MS4uZDk5ODZjNmJhYTkyIDEwMDY0NA0KLS0tIGEvaHcv
bmV0L2Z0Z21hYzEwMC5jDQorKysgYi9ody9uZXQvZnRnbWFjMTAwLmMNCkBAIC0xMDE2LDggKzEw
MTYsNiBAQCBzdGF0aWMgdm9pZCBmdGdtYWMxMDBfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBF
cnJvciAqKmVycnApDQogICAgIHN5c2J1c19pbml0X2lycShzYmQsICZzLT5pcnEpOw0KICAgICBx
ZW11X21hY2FkZHJfZGVmYXVsdF9pZl91bnNldCgmcy0+Y29uZi5tYWNhZGRyKTsNCiANCi0gICAg
cy0+Y29uZi5wZWVycy5uY3NbMF0gPSBuZF90YWJsZVswXS5uZXRkZXY7DQotDQogICAgIHMtPm5p
YyA9IHFlbXVfbmV3X25pYygmbmV0X2Z0Z21hYzEwMF9pbmZvLCAmcy0+Y29uZiwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG9iamVjdF9nZXRfdHlwZW5hbWUoT0JKRUNUKGRldikpLCBERVZJ
Q0UoZGV2KS0+aWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICBzKTsNCi0tDQoyLjIwLjEN
Cg0KDQoNCg==

