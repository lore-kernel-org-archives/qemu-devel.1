Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A2C7618E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 07:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E451820838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 07:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E451820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmvYm-0002XB-Rh
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 03:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hmvYb-00028Y-VE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 03:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hmvYa-0006Lo-Iq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 03:37:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:40287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hmvYa-0006Eb-93
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 03:37:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jul 2019 00:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; d="scan'208";a="250754479"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga001.jf.intel.com with ESMTP; 15 Jul 2019 00:36:59 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jul 2019 00:36:57 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jul 2019 00:36:57 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.110]) with mapi id 14.03.0439.000;
 Mon, 15 Jul 2019 15:36:55 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: 'Jason Wang' <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-dev <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH V2] net/colo-compare.c: Fix memory leak
 and code style issue.
Thread-Index: AQHVMkRVre1oFuzpr0u+Ffrjw6TuIabCueOAgADCIXCAASxlgIABhCUA
Date: Mon, 15 Jul 2019 07:36:54 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061C73BA@shsmsx102.ccr.corp.intel.com>
References: <20190704083647.30614-1-chen.zhang@intel.com>
 <ad2627e3-8198-42f2-a89d-8e6a5596ef20@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78061C2546@shsmsx102.ccr.corp.intel.com>
 <5cf779de-9d97-63f4-00d5-560202890af0@redhat.com>
In-Reply-To: <5cf779de-9d97-63f4-00d5-560202890af0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODMwNzQwMmYtOTBjZC00ZmE3LTgyYzktOTFiYWM5OTgzNmI4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaWI4VkYxalhcL1ZSalRVdFZ4ZmJvMEorMXg0aHFEbkNWemJSWjZqb0dWVEE0TXZoK2lsQ043THBoamxsYWREVkwifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH V2] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphc29uIFdhbmcgW21haWx0
bzpqYXNvd2FuZ0ByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAxMSwgMjAxOSA0
OjE4IEFNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc+OyBxZW11LWRldiA8cWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZz4N
Cj4gQ2M6IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UWVtdS1kZXZlbF0gW1BBVENIIFYyXSBuZXQvY29sby1jb21wYXJlLmM6IEZpeCBtZW1vcnkgbGVh
aw0KPiBhbmQgY29kZSBzdHlsZSBpc3N1ZS4NCj4gDQo+IA0KPiBPbiAyMDE5LzcvMTAg5LiL5Y2I
Mzo1MCwgWmhhbmcsIENoZW4gd3JvdGU6DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogSmFzb24gV2FuZyBbbWFpbHRvOmphc293YW5nQHJlZGhhdC5jb21d
DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgOSwgMjAxOSAxMDo0OCBQTQ0KPiA+PiBUbzogWmhh
bmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlhbg0KPiA+PiA8bGl6aGlq
aWFuQGNuLmZ1aml0c3UuY29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnPjsNCj4gPj4gcWVtdS1kZXYgPHFlbXUtIGRldmVsQG5vbmdudS5vcmc+DQo+ID4+IENjOiBa
aGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCBWMl0gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5DQo+ID4+IGxl
YWsgYW5kIGNvZGUgc3R5bGUgaXNzdWUuDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDIwMTkvNy80IOS4
i+WNiDQ6MzYsIFpoYW5nIENoZW4gd3JvdGU6DQo+ID4+PiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVu
LnpoYW5nQGludGVsLmNvbT4NCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNoIHRvIGZpeCB0aGUgb3Jp
Z2luICJjaGFyICpkYXRhIiBtZW5vcnkgbGVhaywgY29kZSBzdHlsZQ0KPiA+Pj4gaXNzdWUgYW5k
IGFkZCBuZWNlc3NhcnkgY2hlY2sgaGVyZS4NCj4gPj4+IFJlcG9ydGVkLWJ5OiBDb3Zlcml0eSAo
Q0lEIDE0MDI3ODUpDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hl
bi56aGFuZ0BpbnRlbC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIG5ldC9jb2xvLWNvbXBhcmUu
YyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYg
LS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9uZXQvY29sby1jb21wYXJlLmMgaW5kZXgNCj4g
Pj4+IDkwOWRkNmM2ZWIuLmVkMzQ5ZjVmNmEgMTAwNjQ0DQo+ID4+PiAtLS0gYS9uZXQvY29sby1j
b21wYXJlLmMNCj4gPj4+ICsrKyBiL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+Pj4gQEAgLTEyNyw2
ICsxMjcsMTcgQEAgc3RhdGljIGludCBjb21wYXJlX2Nocl9zZW5kKENvbXBhcmVTdGF0ZSAqcywN
Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCB2bmV0X2hkcl9s
ZW4sDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBub3RpZnlfcmVt
b3RlX2ZyYW1lKTsNCj4gPj4+DQo+ID4+PiArc3RhdGljIGJvb2wgcGFja2V0X21hdGNoZXNfc3Ry
KGNvbnN0IGNoYXIgKnN0ciwNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dWludDhfdCAqYnVmLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCBwYWNrZXRfbGVuKSB7DQo+ID4+PiArICAgIGlmIChwYWNrZXRfbGVuIDw9IHN0cmxlbihz
dHIpKSB7DQo+ID4+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4+PiArICAgIH0NCj4gPj4+
ICsNCj4gPj4+ICsgICAgcmV0dXJuICFtZW1jbXAoc3RyLCBidWYsIHN0cmxlbihzdHIpICsgMSk7
DQo+ID4+DQo+ID4+IFRoaXMgYXNzdW1lcyBidWYgaXMgTlVMTCB0ZXJtaW5hdGVkICh5b3UgcGFz
cyBub3RpZnlfcnMtPmJ1Zikgd2hpY2gNCj4gPj4gaXMgbm90IGNvcnJlY3QgSSB0aGluaz8NCj4g
PiBZZXMsIHlvdSBhcmUgcmlnaHQuDQo+ID4gSG93IGFib3V0IHRoaXM6DQo+ID4NCj4gPiBzdGF0
aWMgYm9vbCBwYWNrZXRfbWF0Y2hlc19zdHIoY29uc3QgY2hhciAqc3RyLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqYnVmLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFja2V0X2xlbikgew0KPiA+ICAgICAgaWYgKHBh
Y2tldF9sZW4gIT0gc3RybGVuKHN0cikgfHwgIWJ1Zikgew0KPiA+ICAgICAgICAgIHJldHVybiBm
YWxzZTsNCj4gPiAgICAgIH0NCj4gDQo+IA0KPiBXaGVuIGNhbiB3ZSBoaXQgIWJ1Zj8NCg0KSSBy
ZS1jaGVja2VkIHRoZSBjb2RlLCBsb29rcyB0aGUgIm5ldF9maWxsX3JzdGF0ZSgpIiBjYW4gZW5z
dXJlIGJ1ZiBpcyBub3QgZW1wdHksDQpJIHdpbGwgcmVtb3ZlIHRoZSAhYnVmIHRvIHNlbmQgbmV4
dCB2ZXJzaW9uLg0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiANCj4gVGhhbmtzDQo+IA0KPiAN
Cj4gPg0KPiA+ICAgICAgcmV0dXJuICFtZW1jbXAoc3RyLCBidWYsIHN0cmxlbihzdHIpKTsgfQ0K
PiA+DQo+ID4gVGhhbmtzDQo+ID4gWmhhbmcgQ2hlbg0KPiA+DQo+ID4NCj4gPj4gVGhhbmtzDQo+
ID4+DQo+ID4+DQo+ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gICAgc3RhdGljIHZvaWQgbm90aWZ5
X3JlbW90ZV9mcmFtZShDb21wYXJlU3RhdGUgKnMpDQo+ID4+PiAgICB7DQo+ID4+PiAgICAgICAg
Y2hhciBtc2dbXSA9ICJET19DSEVDS1BPSU5UIjsgQEAgLTEwMDgsMjEgKzEwMTksMjQgQEAgc3Rh
dGljDQo+ID4+PiB2b2lkDQo+ID4+IGNvbXBhcmVfbm90aWZ5X3JzX2ZpbmFsaXplKFNvY2tldFJl
YWRTdGF0ZSAqbm90aWZ5X3JzKQ0KPiA+Pj4gICAgew0KPiA+Pj4gICAgICAgIENvbXBhcmVTdGF0
ZSAqcyA9IGNvbnRhaW5lcl9vZihub3RpZnlfcnMsIENvbXBhcmVTdGF0ZSwNCj4gPj4+IG5vdGlm
eV9ycyk7DQo+ID4+Pg0KPiA+Pj4gLSAgICAvKiBHZXQgWGVuIGNvbG8tZnJhbWUncyBub3RpZnkg
YW5kIGhhbmRsZSB0aGUgbWVzc2FnZSAqLw0KPiA+Pj4gLSAgICBjaGFyICpkYXRhID0gZ19tZW1k
dXAobm90aWZ5X3JzLT5idWYsIG5vdGlmeV9ycy0+cGFja2V0X2xlbik7DQo+ID4+PiAtICAgIGNo
YXIgbXNnW10gPSAiQ09MT19DT01QQVJFX0dFVF9YRU5fSU5JVCI7DQo+ID4+PiArICAgIGNvbnN0
IGNoYXIgbXNnW10gPSAiQ09MT19DT01QQVJFX0dFVF9YRU5fSU5JVCI7DQo+ID4+PiAgICAgICAg
aW50IHJldDsNCj4gPj4+DQo+ID4+PiAtICAgIGlmICghc3RyY21wKGRhdGEsICJDT0xPX1VTRVJT
UEFDRV9QUk9YWV9JTklUIikpIHsNCj4gPj4+ICsgICAgaWYgKHBhY2tldF9tYXRjaGVzX3N0cigi
Q09MT19VU0VSU1BBQ0VfUFJPWFlfSU5JVCIsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbm90aWZ5X3JzLT5idWYsDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
bm90aWZ5X3JzLT5wYWNrZXRfbGVuKSkgew0KPiA+Pj4gICAgICAgICAgICByZXQgPSBjb21wYXJl
X2Nocl9zZW5kKHMsICh1aW50OF90ICopbXNnLCBzdHJsZW4obXNnKSwgMCwgdHJ1ZSk7DQo+ID4+
PiAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4+PiAgICAgICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoIk5vdGlmeSBYZW4gQ09MTy1mcmFtZSBJTklUIGZhaWxlZCIpOw0KPiA+Pj4gICAgICAg
ICAgICB9DQo+ID4+PiAtICAgIH0NCj4gPj4+IC0NCj4gPj4+IC0gICAgaWYgKCFzdHJjbXAoZGF0
YSwgIkNPTE9fQ0hFQ0tQT0lOVCIpKSB7DQo+ID4+PiArICAgIH0gZWxzZSBpZiAocGFja2V0X21h
dGNoZXNfc3RyKCJDT0xPX0NIRUNLUE9JTlQiLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBub3RpZnlfcnMtPmJ1ZiwNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbm90aWZ5X3JzLT5wYWNrZXRfbGVuKSkgew0KPiA+Pj4gICAgICAgICAg
ICAvKiBjb2xvLWNvbXBhcmUgZG8gY2hlY2twb2ludCwgZmx1c2ggcHJpIHBhY2tldCBhbmQNCj4g
Pj4+IHJlbW92ZSBzZWMgcGFja2V0DQo+ID4+ICovDQo+ID4+PiAgICAgICAgICAgIGdfcXVldWVf
Zm9yZWFjaCgmcy0+Y29ubl9saXN0LCBjb2xvX2ZsdXNoX3BhY2tldHMsIHMpOw0KPiA+Pj4gKyAg
ICB9IGVsc2Ugew0KPiA+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDT0xPIGNvbXBhcmUgZ290
IHVuc3VwcG9ydGVkIGluc3RydWN0aW9uICclcyciLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgIChjaGFyICopbm90aWZ5X3JzLT5idWYpOw0KPiA+Pj4gICAgICAgIH0NCj4gPj4+ICAgIH0N
Cj4gPj4+DQo=

