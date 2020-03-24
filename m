Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E36C20786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E36C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhdY-0001Eq-LZ
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jGhaM-0004o0-9W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jGhaL-0007q9-60
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:19:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:15487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jGhaK-0007pr-Tt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:19:05 -0400
IronPort-SDR: p4boZQlgbCcJEfVMymPBMbjB8a6mYRPLbG3XZdTwKEojBIXL+jHFzCllVHj7zbe+7rv3unaPaR
 2nTrv4k8Zh7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 04:19:03 -0700
IronPort-SDR: H+pji3yQ8v4Usbv7c8Q43RSLYLQWzfSoZ9yDokfdhYLywsvyUPwWr65OVvLnAVwmX7QNbvbfFo
 e/aMqcwipizA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="447845405"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga006.fm.intel.com with ESMTP; 24 Mar 2020 04:19:03 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 04:19:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.144]) with mapi id 14.03.0439.000;
 Tue, 24 Mar 2020 19:18:59 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 09/22] vfio/common: check PASID alloc/free availability
Thread-Topic: [PATCH v1 09/22] vfio/common: check PASID alloc/free availability
Thread-Index: AQHWAEW15Jx0RCLPSU2RY4n7wVdCtqhWOBCAgAFjAVA=
Date: Tue, 24 Mar 2020 11:18:58 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A200444@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-10-git-send-email-yi.l.liu@intel.com>
 <20200323220653.GT127076@xz-x1>
In-Reply-To: <20200323220653.GT127076@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.151
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDI0LCAyMDIwIDY6MDcgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA5LzIyXSB2ZmlvL2NvbW1vbjogY2hlY2sgUEFT
SUQgYWxsb2MvZnJlZSBhdmFpbGFiaWxpdHkNCj4gDQo+IE9uIFN1biwgTWFyIDIyLCAyMDIwIGF0
IDA1OjM2OjA2QU0gLTA3MDAsIExpdSBZaSBMIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4g
QEAgLTEyNTYsMTEgKzEzMzQsMTkgQEAgc3RhdGljIGludCB2ZmlvX2luaXRfY29udGFpbmVyKFZG
SU9Db250YWluZXINCj4gKmNvbnRhaW5lciwgaW50IGdyb3VwX2ZkLA0KPiA+ICAgICAgfQ0KPiA+
DQo+ID4gICAgICBpZiAoaW9tbXVfdHlwZSA9PSBWRklPX1RZUEUxX05FU1RJTkdfSU9NTVUpIHsN
Cj4gPiAtICAgICAgICAvKg0KPiA+IC0gICAgICAgICAqIFRPRE86IGNvbmZpZyBmbGFncyBwZXIg
aG9zdCBJT01NVSBuZXN0aW5nIGNhcGFiaWxpdHkNCj4gPiAtICAgICAgICAgKiBlLmcuIGNoZWNr
IGlmIFZGSU9fVFlQRTFfTkVTVElOR19JT01NVSBzdXBwb3J0cyBQQVNJRA0KPiA+IC0gICAgICAg
ICAqIGFsbG9jL2ZyZWUNCj4gPiAtICAgICAgICAgKi8NCj4gPiArICAgICAgICBzdHJ1Y3QgdmZp
b19pb21tdV90eXBlMV9pbmZvX2NhcF9uZXN0aW5nIG5lc3RpbmcgPSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLm5lc3RpbmdfY2FwYWJpbGl0aWVzID0g
MHgwLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5zdGFn
ZTFfZm9ybWF0cyA9IDAsIH07DQo+ID4gKw0KPiA+ICsgICAgICAgIHJldCA9IHZmaW9fZ2V0X25l
c3RpbmdfaW9tbXVfY2FwKGNvbnRhaW5lciwgJm5lc3RpbmcpOw0KPiA+ICsgICAgICAgIGlmIChy
ZXQpIHsNCj4gPiArICAgICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gZ2V0IG5lc3RpbmcgaW9t
bXUgY2FwIik7DQo+ID4gKyAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgfQ0K
PiA+ICsNCj4gPiArICAgICAgICBmbGFncyB8PSAobmVzdGluZy5uZXN0aW5nX2NhcGFiaWxpdGll
cyAmIFZGSU9fSU9NTVVfUEFTSURfUkVRUykgPw0KPiA+ICsgICAgICAgICAgICAgICAgIEhPU1Rf
SU9NTVVfUEFTSURfUkVRVUVTVCA6IDA7DQo+IA0KPiBJIHJlcGxpZWQgaW4gdGhlIHByZXZpb3Vz
IHBhdGNoIGJ1dCBJIGZvcmdvdCB0byB1c2UgcmVwbHktYWxsLi4uDQo+IA0KPiBBbnl3YXkgSSds
bCBjb21tZW50IGFnYWluIGhlcmUgLSBJIHRoaW5rIGl0J2xsIGJlIHNsaWdodGx5IGJldHRlciB3
ZQ0KPiB1c2UgdGhlIHByZXZpb3VzIHBhdGNoIHRvIG9ubHkgb2ZmZXIgdGhlIHZmaW8gc3BlY2lm
aWMgaG9va3MsIGFuZCB0aGlzDQo+IHBhdGNoIHRvIGRvIGFsbCB0aGUgcmVzdCBpbmNsdWRpbmcg
aG9zdF9pb21tdV9jdHhfaW5pdCgpIGJlbG93LCB3aGljaA0KPiB3aWxsIGF2b2lkIGNyZWF0aW5n
IHRoZSBob3N0X2lvbW11X2N0eF9pbml0KCkuDQoNCkdvdCBpdC4gTGV0IG1lIGRvIGl0IGluIG5l
eHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNCllpIExpdQ0K

