Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569A5C06510
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 03:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBA62189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 03:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBA62189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hisg2-0006BK-HF
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 23:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hisfY-0005mX-P4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hisfX-000483-Fv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:44:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:31130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hisfX-00043w-7r
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 23:44:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Jul 2019 20:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; d="scan'208";a="362834933"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2019 20:44:14 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jul 2019 20:44:12 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.240]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 11:44:12 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Li
 Zhijian" <lizhijian@cn.fujitsu.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] net/colo-compare.c: Fix memory leak and
 code style issue.
Thread-Index: AQHVMUCopfg6F+XrzUC+6h46ZejGq6a4EbMAgAHBIbA=
Date: Thu, 4 Jul 2019 03:44:11 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061B8149@shsmsx102.ccr.corp.intel.com>
References: <20190703013805.2722-1-chen.zhang@intel.com>
 <bab54e27-0e4f-3701-1562-92b062f37415@redhat.com>
In-Reply-To: <bab54e27-0e4f-3701-1562-92b062f37415@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTMzNWM2NjEtZDFlYS00NmNmLWI0NmQtYWQ2YmQyMWE5ZWJjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYjgrajhiMEtSM1RibDNha2J2S0pINGViVm52RlFieGJhOWVkYXpvWXlcLzlsazd0ekFMOWk4ZzFqRHJ5R2c2bFkifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Fix memory leak and
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgW21haWx0bzpwaGlsbWRAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDMsIDIwMTkgNDo1NiBQTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwu
Y29tPjsgTGkgWmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsNCj4gUGV0ZXIgTWF5
ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgSmFzb24gV2FuZw0KPiA8amFzb3dhbmdA
cmVkaGF0LmNvbT47IHFlbXUtZGV2IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBaaGFu
ZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxd
IFtQQVRDSF0gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5IGxlYWsgYW5kDQo+IGNvZGUg
c3R5bGUgaXNzdWUuDQo+IA0KPiBPbiA3LzMvMTkgMzozOCBBTSwgWmhhbmcgQ2hlbiB3cm90ZToN
Cj4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IEFk
ZHJlc3MgUGV0ZXIncyBjb21tZW50cyBpbiBwYXRjaCAiQ09MTy1jb21wYXJlOkFkZCBjb2xvLWNv
bXBhcmUNCj4gPiByZW1vdGUgbm90aWZ5IHN1cHBvcnQiLg0KPiANCj4gVGhpcyBjb21tZW50IGlz
IG5vdCB1c2VmdWwgaW4gdGhlIGdpdCBoaXN0b3J5IChubyByZWZlcmVuY2UpLg0KPiANCj4gWW91
IG1pZ2h0IHJld29yZCBoaW0sIHVzZSBmdWxsIGNvbWVudCwgb3Igc2ltcGx5Og0KPiANCj4gUmVw
b3J0ZWQtYnk6IENvdmVyaXR5IChDSUQgMTQwMjc4NSkNCg0KT0ssIEkgd2lsbCBmaXggaXQgaW4g
bmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0
L2NvbG8tY29tcGFyZS5jIHwgMTMgKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25l
dC9jb2xvLWNvbXBhcmUuYyBiL25ldC9jb2xvLWNvbXBhcmUuYyBpbmRleA0KPiA+IDkwOWRkNmM2
ZWIuLjM2M2IxZWRkMTEgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4g
KysrIGIvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gQEAgLTEwMDgsMjEgKzEwMDgsMjAgQEAgc3Rh
dGljIHZvaWQNCj4gPiBjb21wYXJlX25vdGlmeV9yc19maW5hbGl6ZShTb2NrZXRSZWFkU3RhdGUg
Km5vdGlmeV9ycykgIHsNCj4gPiAgICAgIENvbXBhcmVTdGF0ZSAqcyA9IGNvbnRhaW5lcl9vZihu
b3RpZnlfcnMsIENvbXBhcmVTdGF0ZSwNCj4gPiBub3RpZnlfcnMpOw0KPiA+DQo+ID4gLSAgICAv
KiBHZXQgWGVuIGNvbG8tZnJhbWUncyBub3RpZnkgYW5kIGhhbmRsZSB0aGUgbWVzc2FnZSAqLw0K
PiA+IC0gICAgY2hhciAqZGF0YSA9IGdfbWVtZHVwKG5vdGlmeV9ycy0+YnVmLCBub3RpZnlfcnMt
PnBhY2tldF9sZW4pOw0KPiA+IC0gICAgY2hhciBtc2dbXSA9ICJDT0xPX0NPTVBBUkVfR0VUX1hF
Tl9JTklUIjsNCj4gPiArICAgIGNvbnN0IGNoYXIgbXNnW10gPSAiQ09MT19DT01QQVJFX0dFVF9Y
RU5fSU5JVCI7DQo+ID4gICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gLSAgICBpZiAoIXN0cmNtcChk
YXRhLCAiQ09MT19VU0VSU1BBQ0VfUFJPWFlfSU5JVCIpKSB7DQo+ID4gKyAgICBpZiAoIXN0cmNt
cCgoY2hhciAqKW5vdGlmeV9ycy0+YnVmLCAiQ09MT19VU0VSU1BBQ0VfUFJPWFlfSU5JVCIpKQ0K
PiA+ICsgew0KPiA+ICAgICAgICAgIHJldCA9IGNvbXBhcmVfY2hyX3NlbmQocywgKHVpbnQ4X3Qg
Kiltc2csIHN0cmxlbihtc2cpLCAwLCB0cnVlKTsNCj4gPiAgICAgICAgICBpZiAocmV0IDwgMCkg
ew0KPiA+ICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIk5vdGlmeSBYZW4gQ09MTy1mcmFtZSBJ
TklUIGZhaWxlZCIpOw0KPiA+ICAgICAgICAgIH0NCj4gPiAtICAgIH0NCj4gPiAtDQo+ID4gLSAg
ICBpZiAoIXN0cmNtcChkYXRhLCAiQ09MT19DSEVDS1BPSU5UIikpIHsNCj4gPiArICAgIH0gZWxz
ZSBpZiAoIXN0cmNtcCgoY2hhciAqKW5vdGlmeV9ycy0+YnVmLCAiQ09MT19DSEVDS1BPSU5UIikp
IHsNCj4gPiAgICAgICAgICAvKiBjb2xvLWNvbXBhcmUgZG8gY2hlY2twb2ludCwgZmx1c2ggcHJp
IHBhY2tldCBhbmQgcmVtb3ZlIHNlYyBwYWNrZXQNCj4gKi8NCj4gPiAgICAgICAgICBnX3F1ZXVl
X2ZvcmVhY2goJnMtPmNvbm5fbGlzdCwgY29sb19mbHVzaF9wYWNrZXRzLCBzKTsNCj4gPiArICAg
IH0gZWxzZSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDT0xPIGNvbXBhcmUgZ290IHVu
c3VwcG9ydGVkIGluc3RydWN0aW9uICclcyciLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAo
Y2hhciAqKW5vdGlmeV9ycy0+YnVmKTsNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4NCg==

