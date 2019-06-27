Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA0CC48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E3220656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E3220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQC2-0000AW-PB
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 04:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hgQAB-0006lr-AT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hgQA9-0001YR-Ld
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:53:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:15064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hgQA8-0001Sg-5m
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:53:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jun 2019 01:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,423,1557212400"; d="scan'208";a="156170465"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 27 Jun 2019 01:53:39 -0700
Received: from fmsmsx122.amr.corp.intel.com (10.18.125.37) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 01:53:39 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx122.amr.corp.intel.com (10.18.125.37) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Jun 2019 01:53:38 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.33]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.185]) with mapi id 14.03.0439.000;
 Thu, 27 Jun 2019 16:53:37 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela
 <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>
Thread-Topic: [Qemu-devel] [PATCH V2 4/5] COLO-compare: Add colo-compare
 remote notify support
Thread-Index: AQHVHuNZ6tkO+DuwDEiRvbaeRiD1i6auU7CAgAD0CMA=
Date: Thu, 27 Jun 2019 08:53:36 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806197E2F@shsmsx102.ccr.corp.intel.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
 <20190609164433.5866-5-chen.zhang@intel.com>
 <e56908b7-3671-0ac8-6fbc-4d412a2755e6@redhat.com>
In-Reply-To: <e56908b7-3671-0ac8-6fbc-4d412a2755e6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjE4YzE3ZjktZDA4Ni00MGVjLTk2Y2YtMDJmZjU4MmUwMmRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSkN5cFB4VStLeTZ2b2NRWitpckF2ZmVCTHZpaFJWSmZVdTU4MmxQXC9INzloUWw0MzhCY3g1dTlNc29ER3FKZjMifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH V2 4/5] COLO-compare: Add colo-compare
 remote notify support
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
bzpqYXNvd2FuZ0ByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyNywgMjAxOSA5
OjU4IEFNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+Ow0KPiBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0
IDxkZ2lsYmVydEByZWRoYXQuY29tPjsgSnVhbiBRdWludGVsYQ0KPiA8cXVpbnRlbGFAcmVkaGF0
LmNvbT47IHpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47DQo+
IHFlbXUtZGV2IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBTdGVmYW5vIFN0YWJlbGxpbmkNCj4g
PHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBQYXVsIER1cnJhbnQgPHBhdWwuZHVycmFudEBjaXRy
aXguY29tPg0KPiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggVjIgNC81XSBDT0xPLWNvbXBhcmU6IEFkZCBjb2xv
LWNvbXBhcmUNCj4gcmVtb3RlIG5vdGlmeSBzdXBwb3J0DQo+IA0KPiANCj4gT24gMjAxOS82LzEw
IOS4iuWNiDEyOjQ0LCBaaGFuZyBDaGVuIHdyb3RlOg0KPiA+IEZyb206IFpoYW5nIENoZW4gPGNo
ZW4uemhhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBtYWtlIGNvbG8tY29tcGFy
ZSBjYW4gc2VuZCBtZXNzYWdlIHRvIHJlbW90ZSBDT0xPIGZyYW1lKFhlbikNCj4gd2hlbiBvY2N1
ciBjaGVja3BvaW50Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56
aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBuZXQvY29sby1jb21wYXJlLmMgfCA1NCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL25ldC9jb2xvLWNvbXBhcmUuYyBiL25ldC9jb2xvLWNvbXBhcmUuYyBp
bmRleA0KPiA+IDE2Mjg1ZjRhOTYuLjUxNmI2NTFlY2QgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2Nv
bG8tY29tcGFyZS5jDQo+ID4gKysrIGIvbmV0L2NvbG8tY29tcGFyZS5jDQo+ID4gQEAgLTEyMCwx
MSArMTIwLDYgQEAgZW51bSB7DQo+ID4gICAgICAgU0VDT05EQVJZX0lOLA0KPiA+ICAgfTsNCj4g
Pg0KPiA+IC1zdGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkodm9p
ZCkNCj4gPiAtew0KPiA+IC0gICAgbm90aWZpZXJfbGlzdF9ub3RpZnkoJmNvbG9fY29tcGFyZV9u
b3RpZmllcnMsDQo+ID4gLSAgICAgICAgICAgICAgICBtaWdyYXRlX2dldF9jdXJyZW50KCkpOw0K
PiA+IC19DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgY29tcGFyZV9jaHJfc2VuZChDb21wYXJlU3Rh
dGUgKnMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgdWludDhfdCAq
YnVmLCBAQCAtMTMyLDYgKzEyNywyNyBAQA0KPiA+IHN0YXRpYyBpbnQgY29tcGFyZV9jaHJfc2Vu
ZChDb21wYXJlU3RhdGUgKnMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3Qgdm5ldF9oZHJfbGVuLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgbm90aWZ5X3JlbW90ZV9mcmFtZSk7DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgbm90aWZ5X3Jl
bW90ZV9mcmFtZShDb21wYXJlU3RhdGUgKnMpIHsNCj4gPiArICAgIGNoYXIgbXNnW10gPSAiRE9f
Q0hFQ0tQT0lOVCI7DQo+ID4gKyAgICBpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICByZXQg
PSBjb21wYXJlX2Nocl9zZW5kKHMsICh1aW50OF90ICopbXNnLCBzdHJsZW4obXNnKSwgMCwgdHJ1
ZSk7DQo+ID4gKyAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgIGVycm9yX3JlcG9ydCgi
Tm90aWZ5IFhlbiBDT0xPLWZyYW1lIGZhaWxlZCIpOw0KPiA+ICsgICAgfQ0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkoQ29t
cGFyZVN0YXRlICpzKSB7DQo+ID4gKyAgICBpZiAocy0+bm90aWZ5X2Rldikgew0KPiA+ICsgICAg
ICAgIG5vdGlmeV9yZW1vdGVfZnJhbWUocyk7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsgICAg
ICAgIG5vdGlmaWVyX2xpc3Rfbm90aWZ5KCZjb2xvX2NvbXBhcmVfbm90aWZpZXJzLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKSk7DQo+ID4g
KyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgZ2ludCBzZXFfc29ydGVyKFBhY2tl
dCAqYSwgUGFja2V0ICpiLCBncG9pbnRlciBkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVj
dCB0Y3BfaGRyICphdGNwLCAqYnRjcDsNCj4gPiBAQCAtNDM1LDcgKzQ1MSw3IEBAIHNlYzoNCj4g
PiAgICAgICAgICAgcWVtdV9oZXhkdW1wKChjaGFyICopc3BrdC0+ZGF0YSwgc3RkZXJyLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgImNvbG8tY29tcGFyZSBzcGt0Iiwgc3BrdC0+c2l6ZSk7
DQo+ID4NCj4gPiAtICAgICAgICBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkoKTsN
Cj4gPiArICAgICAgICBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkocyk7DQo+ID4g
ICAgICAgfQ0KPiA+ICAgfQ0KPiA+DQo+ID4gQEAgLTU3Nyw3ICs1OTMsNyBAQCB2b2lkIGNvbG9f
Y29tcGFyZV91bnJlZ2lzdGVyX25vdGlmaWVyKE5vdGlmaWVyDQo+ICpub3RpZnkpDQo+ID4gICB9
DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgY29sb19vbGRfcGFja2V0X2NoZWNrX29uZV9jb25uKENv
bm5lY3Rpb24gKmNvbm4sDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2b2lkICp1c2VyX2RhdGEpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIENvbXBhcmVTdGF0ZSAqcykNCj4gPiAgIHsNCj4gPiAgICAgICBHTGlz
dCAqcmVzdWx0ID0gTlVMTDsNCj4gPiAgICAgICBpbnQ2NF90IGNoZWNrX3RpbWUgPSBSRUdVTEFS
X1BBQ0tFVF9DSEVDS19NUzsgQEAgLTU4OCw3ICs2MDQsNw0KPiA+IEBAIHN0YXRpYyBpbnQgY29s
b19vbGRfcGFja2V0X2NoZWNrX29uZV9jb25uKENvbm5lY3Rpb24gKmNvbm4sDQo+ID4NCj4gPiAg
ICAgICBpZiAocmVzdWx0KSB7DQo+ID4gICAgICAgICAgIC8qIERvIGNoZWNrcG9pbnQgd2lsbCBm
bHVzaCBvbGQgcGFja2V0ICovDQo+ID4gLSAgICAgICAgY29sb19jb21wYXJlX2luY29uc2lzdGVu
Y3lfbm90aWZ5KCk7DQo+ID4gKyAgICAgICAgY29sb19jb21wYXJlX2luY29uc2lzdGVuY3lfbm90
aWZ5KHMpOw0KPiA+ICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiBA
QCAtNjA4LDcgKzYyNCw3IEBAIHN0YXRpYyB2b2lkIGNvbG9fb2xkX3BhY2tldF9jaGVjayh2b2lk
ICpvcGFxdWUpDQo+ID4gICAgICAgICogSWYgd2UgZmluZCBvbmUgb2xkIHBhY2tldCwgc3RvcCBm
aW5kaW5nIGpvYiBhbmQgbm90aWZ5DQo+ID4gICAgICAgICogQ09MTyBmcmFtZSBkbyBjaGVja3Bv
aW50Lg0KPiA+ICAgICAgICAqLw0KPiA+IC0gICAgZ19xdWV1ZV9maW5kX2N1c3RvbSgmcy0+Y29u
bl9saXN0LCBOVUxMLA0KPiA+ICsgICAgZ19xdWV1ZV9maW5kX2N1c3RvbSgmcy0+Y29ubl9saXN0
LCBzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgKEdDb21wYXJlRnVuYyljb2xvX29s
ZF9wYWNrZXRfY2hlY2tfb25lX2Nvbm4pOw0KPiA+ICAgfQ0KPiA+DQo+ID4gQEAgLTYzNyw3ICs2
NTMsOCBAQCBzdGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVfcGFja2V0KENvbXBhcmVTdGF0ZSAqcywN
Cj4gQ29ubmVjdGlvbiAqY29ubiwNCj4gPiAgICAgICAgICAgICAgICAqLw0KPiA+ICAgICAgICAg
ICAgICAgdHJhY2VfY29sb19jb21wYXJlX21haW4oInBhY2tldCBkaWZmZXJlbnQiKTsNCj4gPiAg
ICAgICAgICAgICAgIGdfcXVldWVfcHVzaF9oZWFkKCZjb25uLT5wcmltYXJ5X2xpc3QsIHBrdCk7
DQo+ID4gLSAgICAgICAgICAgIGNvbG9fY29tcGFyZV9pbmNvbnNpc3RlbmN5X25vdGlmeSgpOw0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgY29sb19jb21wYXJlX2luY29uc2lzdGVuY3lfbm90aWZ5
KHMpOw0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgIH0NCj4gPiAgICAg
ICB9DQo+ID4gQEAgLTk4OSw3ICsxMDA2LDI0IEBAIHN0YXRpYyB2b2lkDQo+ID4gY29tcGFyZV9z
ZWNfcnNfZmluYWxpemUoU29ja2V0UmVhZFN0YXRlICpzZWNfcnMpDQo+ID4NCj4gPiAgIHN0YXRp
YyB2b2lkIGNvbXBhcmVfbm90aWZ5X3JzX2ZpbmFsaXplKFNvY2tldFJlYWRTdGF0ZSAqbm90aWZ5
X3JzKQ0KPiA+ICAgew0KPiA+ICsgICAgQ29tcGFyZVN0YXRlICpzID0gY29udGFpbmVyX29mKG5v
dGlmeV9ycywgQ29tcGFyZVN0YXRlLA0KPiA+ICsgbm90aWZ5X3JzKTsNCj4gPiArDQo+ID4gICAg
ICAgLyogR2V0IFhlbiBjb2xvLWZyYW1lJ3Mgbm90aWZ5IGFuZCBoYW5kbGUgdGhlIG1lc3NhZ2Ug
Ki8NCj4gPiArICAgIGNoYXIgKmRhdGEgPSBnX21lbWR1cChub3RpZnlfcnMtPmJ1Ziwgbm90aWZ5
X3JzLT5wYWNrZXRfbGVuKTsNCj4gPiArICAgIGNoYXIgbXNnW10gPSAiQ09MT19DT01QQVJFX0dF
VF9YRU5fSU5JVCI7DQo+ID4gKyAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgIGlmICghc3Ry
Y21wKGRhdGEsICJDT0xPX1VTRVJTUEFDRV9QUk9YWV9JTklUIikpIHsNCj4gPiArICAgICAgICBy
ZXQgPSBjb21wYXJlX2Nocl9zZW5kKHMsICh1aW50OF90ICopbXNnLCBzdHJsZW4obXNnKSwgMCwg
dHJ1ZSk7DQo+ID4gKyAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiArICAgICAgICAgICAgZXJy
b3JfcmVwb3J0KCJOb3RpZnkgWGVuIENPTE8tZnJhbWUgSU5JVCBmYWlsZWQiKTsNCj4gPiArICAg
ICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKCFzdHJjbXAoZGF0YSwgIkNP
TE9fQ0hFQ0tQT0lOVCIpKSB7DQo+ID4gKyAgICAgICAgLyogY29sby1jb21wYXJlIGRvIGNoZWNr
cG9pbnQsIGZsdXNoIHByaSBwYWNrZXQgYW5kIHJlbW92ZSBzZWMgcGFja2V0DQo+ICovDQo+ID4g
KyAgICAgICAgZ19xdWV1ZV9mb3JlYWNoKCZzLT5jb25uX2xpc3QsIGNvbG9fZmx1c2hfcGFja2V0
cywgcyk7DQo+ID4gKyAgICB9DQo+ID4gICB9DQo+IA0KPiANCj4gVGhpcyBwcm90b2NvbCBsb29r
cyB0b28gc2ltcGxlLCBpcyB0aGlzIGFjY2VwdGVkIGJ5IFhlbj8NCg0KWWVzLCB0aGF0IFhlbiBw
YXRjaCBmcm9tIGxvbmcgdGltZSBhZ28uLi4uDQpDdXJyZW50bHksIE91ciB0YXJnZXQgaXMgbWFr
ZSBYZW4gQ09MTyBjYW4gcnVubmluZywgYW5kIHdlIGNhbiBvcHRpbWl6ZSB0aGUgcHJvdG9jb2wg
aW4gdGhlIGZ1dHVyZS4NCg0KUmVsYXRlZCBYZW4gY29kZToNCmh0dHBzOi8vZ2l0aHViLmNvbS94
ZW4tcHJvamVjdC94ZW4vYmxvYi9tYXN0ZXIvdG9vbHMvbGlieGwvbGlieGxfY29sb19wcm94eS5j
DQoNCg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gDQo+ID4NCj4g
PiAgIC8qDQo=

