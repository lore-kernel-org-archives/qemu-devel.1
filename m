Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AFAC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895ED20851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="KD1C/SOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895ED20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=eltan.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34227 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTm8z-0001S2-SK
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:44:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hTm5h-0007Bg-Gy
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>) id 1hTm5g-0007Ab-Dr
	for qemu-devel@nongnu.org; Thu, 23 May 2019 07:40:57 -0400
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:53254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wvervoorn@eltan.com>)
	id 1hTm5f-00077x-Sd; Thu, 23 May 2019 07:40:56 -0400
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by
	cpsmtpb-ews10.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514); 
	Thu, 23 May 2019 13:40:53 +0200
X-Brand: +YTO/YbK+g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e3=10;e2=11);EVW:Whi
	te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=TPaUtGta c=1 sm=1 tr=0 cx=a_idp_e
	a=WB5lYbMG1jvHJ1f8o08CVQ==:117 a=WB5lYbMG1jvHJ1f8o08CVQ==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=eIHzyqS2sMcA:10 a=IkcTkHD0fZMA:10
	a=xqWC_Br6kY4A:10 a=E5NmQfObTbMA:10 a=aow-egSQAAAA:8 a=X5F7dNyOAAAA:8
	a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=cre2tbgM96jQD9YEl9MA:9
	a=Qt0Ucy6LjH6A6fkE:21 a=RkVXGLHpRJMArvYm:21 a=QEXdDO2ut3YA:10
	a=gFNbaldVC-z-bsjSTzMo:22 a=pS7LufLo7ZPxIL5li5Lt:22
	a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.14]) by cpsps-ews15.kpnxchange.com
	over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
	Thu, 23 May 2019 13:40:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:content-type:message-id:date:subject:to:from;
	bh=oMRyc9CyXFua+RUa4rV9+v7moo678/vNAmuZhcYTAag=;
	b=KD1C/SOB0pAa/Ih9kDnJQervdfRIxw0NH/KmEOpnx2qtfJlZrJbUvArXH/4HESnd7wfYmbJ05dqLn
	YxAUzbNEkVt7+L2Z0D7bSDhmFYXNoBF0zEdKrfV5tWzhFW5fZVD9aSlSAWY9DqsfiUCA4kWqdNz06y
	rf/6hdg1RDudGE+U=
Received: from Eltsrv03.Eltan.local (unknown [84.85.114.86])
	by smtp.kpnmail.nl (Halon) with ESMTPS
	id 9e6e7701-7d4f-11e9-aeb7-00505699d6e5;
	Thu, 23 May 2019 13:40:52 +0200 (CEST)
Received: from Eltsrv03.Eltan.local (192.168.100.3) by Eltsrv03.Eltan.local
	(192.168.100.3) with Microsoft SMTP Server (TLS) id 15.0.847.32;
	Thu, 23 May 2019 13:40:03 +0200
Received: from Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8]) by
	Eltsrv03.Eltan.local ([fe80::24e7:1cc6:a76a:a3a8%12]) with mapi id
	15.00.0847.040; Thu, 23 May 2019 13:40:03 +0200
From: Wim Vervoorn <wvervoorn@eltan.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: aspeed qemu question
Thread-Index: AdULwnm8cADYiO1ZRNGvxixzeWIzuQAJZaCAACbA8VAAASgwgACVvbogAJv1XjD///KugP//2OwA
Date: Thu, 23 May 2019 11:40:03 +0000
Message-ID: <9fbccaac3e144ff48c72968899719b40@Eltsrv03.Eltan.local>
References: <d0fea426e8b245769f3022dad121c17e@Eltsrv03.Eltan.local>
	<9b49eb14-6dc8-29df-c617-8080551b4f6c@kaod.org>
In-Reply-To: <9b49eb14-6dc8-29df-c617-8080551b4f6c@kaod.org>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.100.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginalArrivalTime: 23 May 2019 11:40:52.0888 (UTC)
	FILETIME=[60603980:01D5115C]
X-RcptDomain: nongnu.org
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 213.75.39.15
Subject: Re: [Qemu-devel] aspeed qemu question
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8gQ8OpZHJpYywNCg0KSG93IHN0dXBpZCBvZiBtZS4gSSBvdmVybG9va2VkIHRoYXQgdGhl
IFNQSSBpcyBmb3IgdGhlIGhvc3QgZmxhc2ggZGV2aWNlLiANCg0KVGhlIHJlbWFpbmRlciBvZiB0
aGUgc29sdXRpb24gd2FzIGNsZWFyIGFuZCB1bmRlcnN0b29kLg0KDQpCZXN0IHJlZ2FyZHMgYW5k
IHRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLA0KDQpXaW0NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEPDqWRyaWMgTGUgR29hdGVyIFttYWlsdG86Y2xnQGthb2Qub3Jn
XSANClNlbnQ6IFRodXJzZGF5LCBNYXkgMjMsIDIwMTkgMToxNCBQTQ0KVG86IFdpbSBWZXJ2b29y
biA8d3ZlcnZvb3JuQGVsdGFuLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1A
bm9uZ251Lm9yZzsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBKZWZmZXJ5
IDxhbmRyZXdAYWouaWQuYXU+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+DQpTdWJqZWN0OiBSZTogYXNwZWVkIHFlbXUgcXVlc3Rpb24NCg0KT24gNS8yMy8xOSAxMjow
NSBQTSwgV2ltIFZlcnZvb3JuIHdyb3RlOg0KPiBIZWxsbyBDw6lkcmljLA0KPiANCj4gSSBoYXZl
IGFub3RoZXIgcXVlc3Rpb24gcmVnYXJkaW5nIHRoZSBBU1BFRUQgUWVtdSBzdXBwb3J0LiBUaGlz
IGlzIHJlZ2FyZGluZyB0aGUgU1BJIHN1cHBvcnQuDQo+IA0KPiBJIG5vdGljZWQgdGhhdCBpbiBn
ZW5lcmFsIHRoZSBmbWNfbW9kZWwgYW5kIHRoZSBzcGlfbW9kZWwgZm9yIHRoZSANCj4gZmxhc2gg
ZGV2aWNlIGFyZSBkaWZmZXJlbnQgZXZlbiB0aG91Z2ggdGhlcmUgaXMgb25seSBvbmUgZmxhc2gg
ZGV2aWNlIGNvbm5lY3RlZC4NCg0KVGhlIGZsYXNoIGRldmljZXMgYXJlIGNyZWF0ZWQgYnV0IG5v
dCBhdHRhY2hlZCB0byBhIGZpbGUgYmFja2VuZCB1bmxlc3MgeW91IGRlZmluZSBpdCBvbiB0aGUg
Y29tbWFuZCBsaW5lIHdpdGggLWRyaXZlIG9wdGlvbnMgOg0KDQoJLWRyaXZlIGZpbGU9JGZsYXNo
ZmlsZSxmb3JtYXQ9cmF3LGlmPW10ZA0KDQpUaGUgZmlyc3QgbXRkIGRyaXZlIGNvcnJlc3BvbmRz
IHRvIHRoZSBmbGFzaCBjaGlwIGF0dGFjaGVkIHRvIHRoZSBGTUMgY29udHJvbGxlciAoQk1DIEZp
cm13YXJlKSwgdGhlIHNlY29uZCBpcyB0aGUgZmxhc2ggYXR0YWNoZWQgdG8gdGhlIFNQSTEgY29u
dHJvbGxlciAoSG9zdCBGaXJtd2FyZSkNCg0KPiBJIHdvdWxkIGV4cGVjdCB0aGF0IGluIHRoaXMg
Y2FzZSB0aGUgbW9kZWxzIHVzZWQgd291bGQgYmUgaWRlbnRpY2FsLg0KDQpUaGUgZmxhc2ggZGV2
aWNlIG1vZGVscyBhcmUgZGVmaW5lZCBhdCB0aGUgbWFjaGluZSBsZXZlbCBpbg0KaHcvYXJtL2Fz
cGVlZC5jOg0KDQogICAgfSwgew0KICAgICAgICAubmFtZSAgICAgID0gTUFDSElORV9UWVBFX05B
TUUoIndpdGhlcnNwb29uLWJtYyIpLA0KICAgICAgICAuZGVzYyAgICAgID0gIk9wZW5QT1dFUiBX
aXRoZXJzcG9vbiBCTUMgKEFSTTExNzYpIiwNCiAgICAgICAgLnNvY19uYW1lICA9ICJhc3QyNTAw
LWExIiwNCiAgICAgICAgLmh3X3N0cmFwMSA9IFdJVEhFUlNQT09OX0JNQ19IV19TVFJBUDEsDQog
ICAgICAgIC5mbWNfbW9kZWwgPSAibXgyNWwyNTYzNWUiLA0KICAgICAgICAuc3BpX21vZGVsID0g
Im14NjZsMWc0NWciLA0KICAgICAgICAubnVtX2NzICAgID0gMiwNCiAgICAgICAgLmkyY19pbml0
ICA9IHdpdGhlcnNwb29uX2JtY19pMmNfaW5pdCwNCiAgICAgICAgLnJhbSAgICAgICA9IDUxMiAq
IE1pQiwNCiAgICB9LA0KDQo+IENhbiB5b3UgZXhwbGFpbiBob3cgdGhpcyBpcyB3b3JrcyBhbmQg
aG93IEkgc2VsZWN0IHRoZSBjb3JyZWN0IG1vZGVsIA0KPiBmb3IgdGhlIGZtYyBhbmQgZm9yIHRo
ZSBzcGkgY29udHJvbGxlci4NCg0KWW91IG5lZWQgdG8gZGVmaW5lIGEgbmV3IG1hY2hpbmUgKGJv
YXJkKSBpZiB5b3Ugd2FudCBkaWZmZXJlbnQgZmxhc2ggbW9kZWxzLg0KDQpDLiANCg0KDQo=

