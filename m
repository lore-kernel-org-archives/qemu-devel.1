Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50885C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FEC20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FEC20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9LA-00030H-83
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yadong.qi@intel.com>) id 1iY41x-0007TX-NV
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yadong.qi@intel.com>) id 1iY41v-0006E6-Ps
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:11:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:41277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yadong.qi@intel.com>) id 1iY41v-0006BL-I5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 03:11:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Nov 2019 00:10:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; d="scan'208";a="358064271"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga004.jf.intel.com with ESMTP; 22 Nov 2019 00:10:58 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 00:10:57 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 00:10:57 -0800
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.60]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.215]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 16:10:56 +0800
From: "Qi, Yadong" <yadong.qi@intel.com>
To: Peter Xu <peterx@redhat.com>, "Zhang, Qi1" <qi1.zhang@intel.com>
Subject: RE: [PATCH v2 1/2] intel_iommu: split the resevred fields arrays
 into two ones
Thread-Topic: [PATCH v2 1/2] intel_iommu: split the resevred fields arrays
 into two ones
Thread-Index: AQHVnvNLAxHfUS6liUe0mpSogunjTqeW1viQ
Date: Fri, 22 Nov 2019 08:10:55 +0000
Message-ID: <C69EF7F3128A684C897EAA242006F9A2526930ED@SHSMSX103.ccr.corp.intel.com>
References: <cover.1570503331.git.qi1.zhang@intel.com>
 <d3aa65ad0510cdafd5d7dcbc54bc250feb6aa59b.1570503331.git.qi1.zhang@intel.com>
 <20191119160607.GK9053@xz-x1>
In-Reply-To: <20191119160607.GK9053@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzUxNDY5ODEtNzIyMi00YjRlLTllMWUtOTlhOGRlMGU0ZjFhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV0pyMjJ2ajZGS0grQVhnWlVIQk1WNENIOW9yRURRN1hiTmwxbnhOQThyeHg3RHRzZXlpSngyNGlUenUrVmZ6aiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
X-Mailman-Approved-At: Fri, 22 Nov 2019 08:44:30 -0500
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyMCwgMjAxOSAxMjowNiBB
TQ0KPiBUbzogWmhhbmcsIFFpMSA8cWkxLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgZWhhYmtvc3RAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207DQo+IHBi
b256aW5pQHJlZGhhdC5jb207IFFpLCBZYWRvbmcgPHlhZG9uZy5xaUBpbnRlbC5jb20+OyBydGhA
dHdpZGRsZS5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGludGVsX2lvbW11OiBz
cGxpdCB0aGUgcmVzZXZyZWQgZmllbGRzIGFycmF5cyBpbnRvDQo+IHR3byBvbmVzDQo+IA0KPiBP
biBUdWUsIE5vdiAxOSwgMjAxOSBhdCAwODoyODoxM1BNICswODAwLCBxaTEuemhhbmdAaW50ZWwu
Y29tIHdyb3RlOg0KPiA+IEBAIC0zNTQ3LDE1ICszNTQ4LDE3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9p
bml0KEludGVsSU9NTVVTdGF0ZSAqcykNCj4gPiAgICAgIC8qDQo+ID4gICAgICAgKiBSc3ZkIGZp
ZWxkIG1hc2tzIGZvciBzcHRlDQo+ID4gICAgICAgKi8NCj4gPiAtICAgIHZ0ZF9wYWdpbmdfZW50
cnlfcnN2ZF9maWVsZFswXSA9IH4wVUxMOw0KPiA+IC0gICAgdnRkX3BhZ2luZ19lbnRyeV9yc3Zk
X2ZpZWxkWzFdID0gVlREX1NQVEVfUEFHRV9MMV9SU1ZEX01BU0socy0NCj4gPmF3X2JpdHMpOw0K
PiA+IC0gICAgdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkWzJdID0gVlREX1NQVEVfUEFHRV9M
Ml9SU1ZEX01BU0socy0NCj4gPmF3X2JpdHMpOw0KPiA+IC0gICAgdnRkX3BhZ2luZ19lbnRyeV9y
c3ZkX2ZpZWxkWzNdID0gVlREX1NQVEVfUEFHRV9MM19SU1ZEX01BU0socy0NCj4gPmF3X2JpdHMp
Ow0KPiA+IC0gICAgdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkWzRdID0gVlREX1NQVEVfUEFH
RV9MNF9SU1ZEX01BU0socy0NCj4gPmF3X2JpdHMpOw0KPiA+IC0gICAgdnRkX3BhZ2luZ19lbnRy
eV9yc3ZkX2ZpZWxkWzVdID0gVlREX1NQVEVfTFBBR0VfTDFfUlNWRF9NQVNLKHMtDQo+ID5hd19i
aXRzKTsNCj4gPiAtICAgIHZ0ZF9wYWdpbmdfZW50cnlfcnN2ZF9maWVsZFs2XSA9IFZURF9TUFRF
X0xQQUdFX0wyX1JTVkRfTUFTSyhzLQ0KPiA+YXdfYml0cyk7DQo+ID4gLSAgICB2dGRfcGFnaW5n
X2VudHJ5X3JzdmRfZmllbGRbN10gPSBWVERfU1BURV9MUEFHRV9MM19SU1ZEX01BU0socy0NCj4g
PmF3X2JpdHMpOw0KPiA+IC0gICAgdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkWzhdID0gVlRE
X1NQVEVfTFBBR0VfTDRfUlNWRF9NQVNLKHMtDQo+ID5hd19iaXRzKTsNCj4gPiArICAgIHZ0ZF9z
cHRlX3JzdmRbMF0gPSB+MFVMTDsNCj4gPiArICAgIHZ0ZF9zcHRlX3JzdmRbMV0gPSBWVERfU1BU
RV9QQUdFX0wxX1JTVkRfTUFTSyhzLT5hd19iaXRzKTsNCj4gPiArICAgIHZ0ZF9zcHRlX3JzdmRb
Ml0gPSBWVERfU1BURV9QQUdFX0wyX1JTVkRfTUFTSyhzLT5hd19iaXRzKTsNCj4gPiArICAgIHZ0
ZF9zcHRlX3JzdmRbM10gPSBWVERfU1BURV9QQUdFX0wzX1JTVkRfTUFTSyhzLT5hd19iaXRzKTsN
Cj4gPiArICAgIHZ0ZF9zcHRlX3JzdmRbNF0gPSBWVERfU1BURV9QQUdFX0w0X1JTVkRfTUFTSyhz
LT5hd19iaXRzKTsNCj4gPiArDQo+ID4gKyAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzBdID0gfjBV
TEw7DQo+ID4gKyAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzFdID0gVlREX1NQVEVfTFBBR0VfTDFf
UlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPiA+ICsgICAgdnRkX3NwdGVfcnN2ZF9sYXJnZVsyXSA9
IFZURF9TUFRFX0xQQUdFX0wyX1JTVkRfTUFTSyhzLT5hd19iaXRzKTsNCj4gPiArICAgIHZ0ZF9z
cHRlX3JzdmRfbGFyZ2VbM10gPSBWVERfU1BURV9MUEFHRV9MM19SU1ZEX01BU0socy0+YXdfYml0
cyk7DQo+ID4gKyAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzRdID0gVlREX1NQVEVfTFBBR0VfTDRf
UlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPiANCj4gVGhpcyBsb29rcyBnb29kIHRvIG1lIGluIGdl
bmVyYWwsIGJ1dC4uLiBTaW5jZSB3ZSdyZSBhdCBpdCwgZG8geW91IHRoaW5rIHdlIGNhbg0KPiBk
aXJlY3RseSBkcm9wIFZURF9TUFRFX0xQQUdFX0wxX1JTVkRfTUFTSyBhbmQNCj4gVlREX1NQVEVf
TFBBR0VfTDRfUlNWRF9NQVNLPyAgQXJlIHRoZXkgcmVhbGx5IHVzZWZ1bD8NCg0KWWVzLCB0aGUg
TFBBR0VfTDEgYW5kIExQQUdFX0w0IGFyZSB1c2VsZXNzLiAgSSB3aWxsIHRyeSB0byBtYWtlIHRo
ZSBjaGFuZ2UuDQoNCg0KQmVzdCBSZWdhcmQNCllhZG9uZw0KDQo=

