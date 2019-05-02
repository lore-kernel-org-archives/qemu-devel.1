Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7938DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C65E2063F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 21:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="zIetPpbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C65E2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMIuD-0005hW-8o
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 17:06:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMItP-0005GX-AB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMItO-0000V2-Ag
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:05:23 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMItN-0000RR-AO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556831110;
	bh=53p2yMGcsppza1D6BAGVB1F4zWDVqys/Ywzg4k9yCY0=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=zIetPpbqgJrPeJmOO3o7dfOBl4OKFUD765xPKhPSlX2rwX3opnUL7nn85rT0iZHDz
	m7rEzEf6tQ8EEC0bHbsz1g2mMGg6SEvNCwgcxEvzruZaVGfcyOUOA3XdXyF61/vHDp
	bm+RQcdzGs+US1YfIQTahLBQWSobD3Q9ip5W8Wb0=
X-QQ-FEAT: QahT3sQPRrf5k6Sb+JQVDFGND0HuU3pySSvAtXsBRT3YeCsdPeCkO/oTwkbca
	7OgyzgaOsQbNWyUXMYBbOnXZn4Z0ncCD6JIHFBiGpHppwHkMrI7Kf7eU2xXzYQZsiJP5VOK
	8dRoOrpVNeLXRKR2+15hGWwExkWBybKGxwhZTWmiWIoV72vpsjLvnfJyT/V9bMw2qJSzD+O
	XEG/7KC9Io5Y7ZUx9XxKp1NfT5R7Eex6jrK2ChS0Vu2EScDH0NLA+70vTpR8R97UOGtA1Gt
	I4vZqtuKggcBd1
X-QQ-SSF: 000000000000003000000000000000P
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 183.63.18.252
In-Reply-To: <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
References: <20190430181343.1362-1-driver1998@foxmail.com>
	<141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
X-QQ-STYLE: 
X-QQ-mid: webmail122t1556831108t972951
From: "=?ISO-8859-1?B?ZHJpdmVyMTk5OA==?=" <driver1998@foxmail.com>
To: "=?ISO-8859-1?B?RXJpYyBCbGFrZQ==?=" <eblake@redhat.com>,
	"=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Date: Fri, 3 May 2019 05:05:07 +0800
X-Priority: 3
Message-ID: <tencent_DAABF38404447BB09E9711B789C215AAD109@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 616657046
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 03 May 2019 05:05:08 +0800 (CST)
Feedback-ID: webmail:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 54.207.22.56
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move
 the__USE_MINGW_ANSI_STDIO define up to avoid confliction.
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
Message-ID: <20190502210507.eNL-goYYYRA7CsXXEAZVFk0HoXayh2oj3_O0TgQM9OQ@z>

T24gNS8xLzE5IDI6MzAgQU0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+IFlvdXIgZW50aXJlIHNl
cmllcyBpcyBtaXNzaW5nICdJbi1SZXBseS1UbzonIGFuZCAnUmVmZXJlbmNlczonIGhlYWRl
cnMsDQo+IG1ha2luZyBlYWNoIG1lc3NhZ2Ugc2hvdyB1cCBhcyBpbmRpdmlkdWFsIG5ldyB0
aHJlYWRzIHJhdGhlciB0aGFuDQo+IHByb3Blcmx5IHRocmVhZGVkIHRvIGEgMC80IGNvdmVy
IGxldHRlci4gWW91J2xsIHdhbnQgdG8gZml4IHlvdXIgc2VuZGluZw0KPiBoYWJpdHMgdG8g
YXZvaWQgdGhhdCBwcm9ibGVtIGluIGZ1dHVyZSBzdWJtaXNzaW9ucy4NCg0KSSBhbSB0ZXJy
aWJseSBzb3JyeSBhYm91dCB0aGF0LCB0aGlzIGlzIHRoZSBmaXJzdCB0aW1lIEkgc3VtbWl0
IHBhdGNoZXMsIGFuZCBJIGFtIHN0aWxsIGdldHRpbmcgdXNlZCB0byB0aGUgdG9vbGluZy4N
ClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgb3V0IHRoZSBpc3N1ZSB0aG91Z2guDQoNCj4gSXQn
cyB1bnVzdWFsIHRvIHVzZSBhIHRyYWlsaW5nICcuJyBpbiB0aGUgc3ViamVjdCBsaW5lLiBB
bHNvLCB5b3VyDQo+IHN1YmplY3QgaXMgdmVyeSBsb25nOyBjb21taXQgbWVzc2FnZSBzdW1t
YXJpZXMgc2hvdWxkIHR5cGljYWxseSBiZQ0KPiBhcm91bmQgNjAtNzAgY2hhcmFjdGVycyBi
ZWNhdXNlICdnaXQgbG9nJyBzaG93cyB0aGVtIHdpdGggZnVydGhlcg0KPiBpbmRlbnRhdGlv
biwgd2hlcmUgYW4gODAtY29sdW1uIHRlcm1pbmFsIHdpbmRvdyBtYWtlcyBpdCBoYXJkIHRv
IHNlZSB0aGUNCj4gdGFpbCBhdCBhIGdsYW5jZS4gIEJldHRlciBtaWdodCBiZSBhIHNob3J0
IHN1YmplY3QgbGluZSBleHBsYWluaW5nIHRoZQ0KPiAid2hhdCIsIGFuZCB0aGVuIGEgbm9u
LWVtcHR5IGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5pbmcgdGhlICJ3aHkiDQoNClRoYW5rIHlv
dSBmb3IgcG9pbnRpbmcgb3V0LCBJJ2xsIHVwZGF0ZSB0aGF0IGluIHRoZSB1cGNvbWluZyB2
MyBzZXQuDQoNCj4gUXVlc3Rpb24gLSBkb2VzIGl0IGh1cnQgdG8gbWFrZSB0aGUgZGVmaW5l
IG9mIF9fVVNFX01JTkdXX0FOU0lfU1RESU8NCj4gdW5jb25kaXRpb25hbD8gIEluIG90aGVy
IHdvcmRzLCB3ZSdyZSB1bmxpa2VseSB0byBicmVhayBhbnkgbm9uLW1pbmd3DQo+IHBsYXRm
b3JtIGlmIHdlIGRyb3AgdGhlICNpZmRlZiBfX01JTkdXMzJfXyBsaW5lLg0KDQpJIHBlcnNv
bmFsbHkgaGF2ZSBubyBpZGVhLCBzbyBJJ2xsIGtlZXAgaXQgYXMgaXMu




