Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47396C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 04:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83010206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 04:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="XDP1h06j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83010206F4
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPeW6-0000u9-EU
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 00:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <precinct@mail.ustc.edu.cn>)
 id 1kPeUd-0000Rl-Ak
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 00:22:27 -0400
Received: from email6.ustc.edu.cn ([2001:da8:d800::8]:54230 helo=ustc.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <precinct@mail.ustc.edu.cn>) id 1kPeUY-0005t2-B7
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 00:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID; bh=8Fpqhoq6Zn4PB+hJzX4hjhEcsS0CUlF6sMvW
 UMt/17U=; b=XDP1h06jWWFvlSLXaAziVzqVJEDSSr/a/rLMscKIMsLO9mSjkQfG
 N6r+Hk+P6WkOsyhCn2WM4LYrBlVOIwdKllUP9krt6Tts+m7nYjub2JdocjQ1sTcz
 bvfK5dJQEh9/FhFyZNUJtwltchKnlrC8kwK2RGReh7sRHDgyA3r5TrY=
Received: by ajax-webmail-newmailweb.ustc.edu.cn (Coremail) ; Tue, 6 Oct
 2020 12:21:01 +0800 (GMT+08:00)
X-Originating-IP: [123.114.243.19]
Date: Tue, 6 Oct 2020 12:21:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
To: "Fan Yang" <Fan_Yang@sjtu.edu.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, 
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Akkarit Sangpetch" <asangpet@andrew.cmu.edu>, 
 "Alexander Bulekov" <alxndr@bu.edu>, 
 "Alex Barcelo" <abarcelo@ac.upc.edu>, 
 "Brian Wheeler" <bdwheele@indiana.edu>, 
 "Chen Wei-Ren" <chenwj@iis.sinica.edu.tw>, 
 "Christoffer Dall" <cdall@cs.columbia.edu>, 
 "Colin Lord" <cdlord2@illinois.edu>, 
 "Dayeol Lee" <dayeol@berkeley.edu>, "Gabriel Somlo" <somlo@cmu.edu>, 
 "Guan Xuetao" <gxt@mprc.pku.edu.cn>, linzhecheng <linzc@zju.edu.cn>, 
 =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, 
 "Mike Nawrocki" <michael.nawrocki@gtri.gatech.edu>, 
 "Mike Ryan" <mikeryan@isi.edu>, 
 "Nickolai Zeldovich" <nickolai@csail.mit.edu>, 
 "Stephen Checkoway" <stephen.checkoway@oberlin.edu>, 
 "Viktor Prutyanov" <viktor.prutyanov@phystech.edu>, 
 "Vince Weaver" <vince@csl.cornell.edu>, 
 "Zhang Mengchi" <zhangmengchi@mprc.pku.edu.cn>, 
 "Alex Richardson" <Alexander.Richardson@cl.cam.ac.uk>, 
 "Bastian Koppelmann" <kbastian@mail.uni-paderborn.de>, 
 "Hesham Almatary" <Hesham.Almatary@cl.cam.ac.uk>, 
 "Timothy Edward Baldwin" <T.E.Baldwin99@members.leeds.ac.uk>, 
 "Pavel Pisa" <pisa@cmp.felk.cvut.cz>, 
 =?UTF-8?Q?C=C3=A9sar_Belley?= <cesar.belley@lse.epita.fr>, 
 "Amir Charif" <amir.charif@cea.fr>, 
 "Fabrice Desclaux" <fabrice.desclaux@cea.fr>
Subject: Re: Re: [RFC PATCH 2/2] contrib/gitdm: Add more academic domains
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190610(cb3344cf) Copyright (c) 2002-2020 www.mailtech.cn ustc-xl
In-Reply-To: <351A36BA-E9CD-41C5-B014-059CBFD66802@sjtu.edu.cn>
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-3-f4bug@amsat.org>
 <351A36BA-E9CD-41C5-B014-059CBFD66802@sjtu.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <50fbc424.91e6.174fc242731.Coremail.precinct@mail.ustc.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LkAmygBXX7eu8HtfkTMFAA--.1W
X-CM-SenderInfo: 5suhuxxqfwqzxdloh3xvwfhvlgxou0/1tbiAQsRCVQhnxuCuAAGsf
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=2001:da8:d800::8;
 envelope-from=precinct@mail.ustc.edu.cn; helo=ustc.edu.cn
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: precinct@mail.ustc.edu.cn
From: precinct--- via <qemu-devel@nongnu.org>

QWNrZWQtYnk6IFhpbnl1IExpIDxwcmVjaW5jdEBtYWlsLnVzdGMuZWR1LmNuPgoK5ZyoMjAyMC0x
MC0wNiAxMToyMzo0NSxGYW4gWWFuZzxGYW5fWWFuZ0BzanR1LmVkdS5jbj7lhpnpgZPvvJoKPiBB
Y2tlZC1ieTogRmFuIFlhbmcgPEZhbl9ZYW5nQHNqdHUuZWR1LmNuPg0KPiANCj4gT24gTW9uLCBP
Y3QgMDUsIDIwMjAgYXQgNDo0MEFNICswODAw77yMUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0
YnVnQGFtc2F0Lm9yZz4gd3JvdGXvvJoNCj4gDQo+ID4gVGhlcmUgaXMgYSBudW1iZXIgb2YgY29u
dHJpYnV0aW9ucyBmcm9tIHRoZXNlIGFjYWRlbWljIGRvbWFpbnMuDQo+ID4gQWRkIHRoZSBlbnRy
aWVzIHRvIHRoZSBnaXRkbSAnYWNhZGVtaWMnIGRvbWFpbiBtYXAuDQo+ID4gDQo+ID4gQ2M6IEFr
a2FyaXQgU2FuZ3BldGNoIDxhc2FuZ3BldEBhbmRyZXcuY211LmVkdT4NCj4gPiBDYzogQWxleGFu
ZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+DQo+ID4gQ2M6IEFsZXhhbmRlciBPbGVpbmlrIDxh
bHhuZHJAYnUuZWR1Pg0KPiA+IENjOiBBbGV4IEJhcmNlbG8gPGFiYXJjZWxvQGFjLnVwYy5lZHU+
DQo+ID4gQ2M6IEJyaWFuIFdoZWVsZXIgPGJkd2hlZWxlQGluZGlhbmEuZWR1Pg0KPiA+IENjOiBD
aGVuIFdlaS1SZW4gPGNoZW53akBpaXMuc2luaWNhLmVkdS50dz4NCj4gPiBDYzogQ2hyaXN0b2Zm
ZXIgRGFsbCA8Y2RhbGxAY3MuY29sdW1iaWEuZWR1Pg0KPiA+IENjOiBDb2xpbiBMb3JkIDxjZGxv
cmQyQGlsbGlub2lzLmVkdT4NCj4gPiBDYzogRGF5ZW9sIExlZSA8ZGF5ZW9sQGJlcmtlbGV5LmVk
dT4NCj4gPiBDYzogRmFuIFlhbmcgPEZhbl9ZYW5nQHNqdHUuZWR1LmNuPg0KPiA+IENjOiBHYWJy
aWVsIFNvbWxvIDxzb21sb0BjbXUuZWR1Pg0KPiA+IENjOiBHdWFuIFh1ZXRhbyA8Z3h0QG1wcmMu
cGt1LmVkdS5jbj4NCj4gPiBDYzogbGluemhlY2hlbmcgPGxpbnpjQHpqdS5lZHUuY24+DQo+ID4g
Q2M6IExsdcOtcyBWaWxhbm92YSA8dmlsYW5vdmFAYWMudXBjLmVkdT4NCj4gPiBDYzogTWlrZSBO
YXdyb2NraSA8bWljaGFlbC5uYXdyb2NraUBndHJpLmdhdGVjaC5lZHU+DQo+ID4gQ2M6IE1pa2Ug
UnlhbiA8bWlrZXJ5YW5AaXNpLmVkdT4NCj4gPiBDYzogTmlja29sYWkgWmVsZG92aWNoIDxuaWNr
b2xhaUBjc2FpbC5taXQuZWR1Pg0KPiA+IENjOiBTdGVwaGVuIENoZWNrb3dheSA8c3RlcGhlbi5j
aGVja293YXlAb2Jlcmxpbi5lZHU+DQo+ID4gQ2M6IFZpa3RvciBQcnV0eWFub3YgPHZpa3Rvci5w
cnV0eWFub3ZAcGh5c3RlY2guZWR1Pg0KPiA+IENjOiBWaW5jZSBXZWF2ZXIgPHZpbmNlQGNzbC5j
b3JuZWxsLmVkdT4NCj4gPiBDYzogWGlueXUgTGkgPHByZWNpbmN0QG1haWwudXN0Yy5lZHUuY24+
DQo+ID4gQ2M6IFpoYW5nIE1lbmdjaGkgPHpoYW5nbWVuZ2NoaUBtcHJjLnBrdS5lZHUuY24+DQo+
ID4gQ2M6IEFsZXggUmljaGFyZHNvbiA8QWxleGFuZGVyLlJpY2hhcmRzb25AY2wuY2FtLmFjLnVr
Pg0KPiA+IENjOiBCYXN0aWFuIEtvcHBlbG1hbm4gPGtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9y
bi5kZT4NCj4gPiBDYzogSGVzaGFtIEFsbWF0YXJ5IDxIZXNoYW0uQWxtYXRhcnlAY2wuY2FtLmFj
LnVrPg0KPiA+IENjOiBUaW1vdGh5IEVkd2FyZCBCYWxkd2luIDxULkUuQmFsZHdpbjk5QG1lbWJl
cnMubGVlZHMuYWMudWs+DQo+ID4gQ2M6IFBhdmVsIFBpc2EgPHBpc2FAY21wLmZlbGsuY3Z1dC5j
ej4NCj4gPiBDYzogQ8Opc2FyIEJlbGxleSA8Y2VzYXIuYmVsbGV5QGxzZS5lcGl0YS5mcj4NCj4g
PiBDYzogQW1pciBDaGFyaWYgPGFtaXIuY2hhcmlmQGNlYS5mcj4NCj4gPiBDYzogRmFicmljZSBE
ZXNjbGF1eCA8ZmFicmljZS5kZXNjbGF1eEBjZWEuZnI+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz4NCj4gPiAtLS0NCj4gPiBUbyB0
aGUgZGV2ZWxvcGVycyBDYydlZDogSWYgeW91IGFncmVlIHdpdGggdGhlIGVudHJ5IG9mIHlvdXIN
Cj4gPiBkb21haW4sIHBsZWFzZSByZXBseSB3aXRoIGEgUmV2aWV3ZWQtYnkvQWNrZWQtYnkgdGFn
LiBJZiB5b3UNCj4gPiBkaXNhZ3JlZSBvciBkb2Vzbid0IGNhcmUsIHBsZWFzZSBlaXRoZXIgcmVw
bHkgd2l0aCBOYWNrLWJ5IG9yDQo+ID4gaWdub3JlIHRoaXMgcGF0Y2guDQo+ID4gSSdsbCByZXBv
c3QgaW4gMiB3ZWVrcyBhcyBmb3JtYWwgcGF0Y2ggKG5vdCBSRkMpIHdpdGggb25seSB0aGUNCj4g
PiBlbnRyaWVzIGFja2VkIGJ5IHRoZWlyIGF1dGhvci4NCj4gPiBPbmUgUmV2aWV3ZWQtYnkvQWNr
LWJ5IGZyb20gc29tZW9uZSBmcm9tIGEgZG9tYWluIHNob3VsZCBiZQ0KPiA+IHN1ZmZpY2llbnQg
dG8gZ2V0IHRoZSBkb21haW4gaW5jbHVkZWQgaW4gdGhlIGZpbmFsIHBhdGNoLg0KPiA+IC0tLQ0K
PiA+IGNvbnRyaWIvZ2l0ZG0vZ3JvdXAtbWFwLWFjYWRlbWljcyB8IDEwICsrKysrKysrKy0NCj4g
PiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvZ2l0ZG0vZ3JvdXAtbWFwLWFjYWRlbWljcyBiL2NvbnRy
aWIvZ2l0ZG0vZ3JvdXAtbWFwLWFjYWRlbWljcw0KPiA+IGluZGV4IGM3YjBkZDQ2YTMuLmZkNDJi
YjgwNjkgMTAwNjQ0DQo+ID4gLS0tIGEvY29udHJpYi9naXRkbS9ncm91cC1tYXAtYWNhZGVtaWNz
DQo+ID4gKysrIGIvY29udHJpYi9naXRkbS9ncm91cC1tYXAtYWNhZGVtaWNzDQo+ID4gQEAgLTEx
LDkgKzExLDE3IEBAIGlzcHJhcy5ydQ0KPiA+IHBhdmVsLmRvdmdhbHVrQGdtYWlsLmNvbQ0KPiA+
IA0KPiA+ICMgQ29sdW1iaWEgVW5pdmVyc2l0eQ0KPiA+IC1jcy5jb2x1bWJpYS5lZHUNCj4gPiBj
b3RhQGJyYWFwLm9yZw0KPiA+IA0KPiA+IGppYXh1bi55YW5nQGZseWdvYXQuY29tDQo+ID4gDQo+
ID4gYXJ0ZW0uay5waXNhcmVua29AZ21haWwuY29tDQo+ID4gKw0KPiA+ICt1bmktcGFkZXJib3Ju
LmRlDQo+ID4gK2VkdQ0KPiA+ICthYy51aw0KPiA+ICtlZHUuY24NCj4gPiArZWR1LnR3DQo+ID4g
K2NtcC5mZWxrLmN2dXQuY3oNCj4gPiArZXBpdGEuZnINCj4gPiArY2VhLmZyDQo+ID4gLS0gDQo+
ID4gMi4yNi4yDQo+IA0KPiANCgo=

