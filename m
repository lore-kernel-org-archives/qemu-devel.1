Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B343C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF49420786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF49420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhXi-0001U7-12
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jGhWz-0000zy-7N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jGhWu-0006tB-QC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:15:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:40357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jGhWu-0006rx-Ij
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:15:32 -0400
IronPort-SDR: DFVIl2F/x7khh4mSaGtOB/P1yLrTSijfCpWa7gSCmOUg+otiv0aTqreONiJR9rdjmMOpKTPV8T
 bB1VXv8Q4ifg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 04:15:28 -0700
IronPort-SDR: 678v82/alUVzFTy+u3Bejw0KCWb489DGlS0xnQb2rQ8SX/PA15ZPsvxnnO1GoIE0TdlgmtTbQG
 vpqq6oe/1L7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="293034864"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2020 04:15:28 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 04:15:28 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 04:15:27 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Tue, 24 Mar 2020 19:15:24 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 07/22] intel_iommu: add set/unset_iommu_context callback
Thread-Topic: [PATCH v1 07/22] intel_iommu: add set/unset_iommu_context
 callback
Thread-Index: AQHWAEW1iID+2pWxMk+TzTXpt3GsyKhWLYeAgAFYgbA=
Date: Tue, 24 Mar 2020 11:15:24 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A20041A@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-8-git-send-email-yi.l.liu@intel.com>
 <20200323212911.GQ127076@xz-x1>
In-Reply-To: <20200323212911.GQ127076@xz-x1>
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
X-Received-From: 134.134.136.24
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDI0LCAyMDIwIDU6MjkgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA3LzIyXSBpbnRlbF9pb21tdTogYWRkIHNldC91
bnNldF9pb21tdV9jb250ZXh0DQo+IGNhbGxiYWNrDQo+IA0KPiBPbiBTdW4sIE1hciAyMiwgMjAy
MCBhdCAwNTozNjowNEFNIC0wNzAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFk
ZHMgc2V0L3Vuc2V0X2lvbW11X2NvbnRleHQoKSBpbXBlbGVtZW50YXRpb24gaW4gSW50ZWwNCj4g
PiB2SU9NTVUuIEZvciBJbnRlbCBwbGF0Zm9ybSwgcGFzcy10aHJvdWdoIG1vZHVsZXMgKGUuZy4g
VkZJTykgY291bGQNCj4gPiBzZXQgSG9zdElPTU1VQ29udGV4dCB0byBJbnRlbCB2SU9NTVUgZW11
bGF0b3IuDQo+ID4NCj4gPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+
ID4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6
IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiBDYzogWWkgU3VuIDx5aS55LnN1bkBs
aW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+DQo+ID4gQ2M6IFJpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+DQo+ID4gQ2M6
IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9pMzg2L2lu
dGVsX2lvbW11LmMgICAgICAgICB8IDcwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0NCj4gPiAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAxNyAr
KysrKysrKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gaW5kZXggNGIyMjkxMC4uOGQ5MjA0ZiAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4gPiBAQCAtMzM1NCwyMyArMzM1NCwzNSBAQCBzdGF0aWMgY29uc3QgTWVtb3J5
UmVnaW9uT3BzIHZ0ZF9tZW1faXJfb3BzID0NCj4gew0KPiA+ICAgICAgfSwNCj4gPiAgfTsNCj4g
Pg0KPiA+IC1WVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUg
KnMsIFBDSUJ1cyAqYnVzLCBpbnQNCj4gZGV2Zm4pDQo+ID4gKy8qKg0KPiA+ICsgKiBGZXRjaCBh
IFZUREJ1cyBpbnN0YW5jZSBmb3IgZ2l2ZW4gUENJQnVzLiBJZiBubyBleGlzdGluZyBpbnN0YW5j
ZSwNCj4gPiArICogYWxsb2NhdGUgb25lLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIFZUREJ1cyAq
dnRkX2ZpbmRfYWRkX2J1cyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzKQ0KPiA+ICB7
DQo+ID4gICAgICB1aW50cHRyX3Qga2V5ID0gKHVpbnRwdHJfdClidXM7DQo+ID4gICAgICBWVERC
dXMgKnZ0ZF9idXMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9hc19ieV9idXNwdHIsICZr
ZXkpOw0KPiA+IC0gICAgVlREQWRkcmVzc1NwYWNlICp2dGRfZGV2X2FzOw0KPiA+IC0gICAgY2hh
ciBuYW1lWzEyOF07DQo+ID4NCj4gPiAgICAgIGlmICghdnRkX2J1cykgew0KPiA+ICAgICAgICAg
IHVpbnRwdHJfdCAqbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPiA+ICAg
ICAgICAgICpuZXdfa2V5ID0gKHVpbnRwdHJfdClidXM7DQo+ID4gICAgICAgICAgLyogTm8gY29y
cmVzcG9uZGluZyBmcmVlKCkgKi8NCj4gPiAtICAgICAgICB2dGRfYnVzID0gZ19tYWxsb2MwKHNp
emVvZihWVERCdXMpICsgc2l6ZW9mKFZUREFkZHJlc3NTcGFjZSAqKSAqIFwNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFBDSV9ERVZGTl9NQVgpOw0KPiA+ICsgICAgICAgIHZ0ZF9i
dXMgPSBnX21hbGxvYzAoc2l6ZW9mKFZUREJ1cykgKyBQQ0lfREVWRk5fTUFYICogXA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHNpemVvZihWVERBZGRyZXNzU3BhY2UgKikgKyBc
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKFZUREhvc3RJT01NVUNv
bnRleHQgKikpKTsNCj4gDQo+IElJUkMgSSBjb21tZW50ZWQgb24gdGhpcyBiZWZvcmUuLi4gIFNo
b3VsZG4ndCBzaXplb2YoVlREQnVzKSBiZQ0KPiBlbm91Z2g/DQoNClJpZ2h0LiBNeSBiYWQuIFdp
bGwgZG8gaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+ID4gICAgICAgICAgdnRkX2J1cy0+YnVzID0g
YnVzOw0KPiA+ICAgICAgICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2FzX2J5X2J1c3B0
ciwgbmV3X2tleSwgdnRkX2J1cyk7DQo+ID4gICAgICB9DQo+ID4gKyAgICByZXR1cm4gdnRkX2J1
czsNCj4gPiArfQ0KPiA+ICsNCj4gPiArVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMo
SW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywgaW50DQo+IGRldmZuKQ0KPiA+ICt7DQo+
ID4gKyAgICBWVERCdXMgKnZ0ZF9idXM7DQo+ID4gKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9k
ZXZfYXM7DQo+ID4gKyAgICBjaGFyIG5hbWVbMTI4XTsNCj4gPg0KPiA+ICsgICAgdnRkX2J1cyA9
IHZ0ZF9maW5kX2FkZF9idXMocywgYnVzKTsNCj4gPiAgICAgIHZ0ZF9kZXZfYXMgPSB2dGRfYnVz
LT5kZXZfYXNbZGV2Zm5dOw0KPiA+DQo+ID4gICAgICBpZiAoIXZ0ZF9kZXZfYXMpIHsNCj4gPiBA
QCAtMzQzNiw2ICszNDQ4LDUyIEBAIFZUREFkZHJlc3NTcGFjZQ0KPiAqdnRkX2ZpbmRfYWRkX2Fz
KEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsIGludCBkZXZmbikNCj4gPiAgICAgIHJl
dHVybiB2dGRfZGV2X2FzOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCB2dGRfZGV2X3Nl
dF9pb21tdV9jb250ZXh0KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4sDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVDb250ZXh0ICpob3N0X2ljeCkNCj4g
PiArew0KPiA+ICsgICAgSW50ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KPiA+ICsgICAgVlRE
QnVzICp2dGRfYnVzOw0KPiA+ICsgICAgVlRESG9zdElPTU1VQ29udGV4dCAqdnRkX2Rldl9pY3g7
DQo+ID4gKw0KPiA+ICsgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQQ0lfREVWRk5f
TUFYKTsNCj4gPiArDQo+ID4gKyAgICB2dGRfYnVzID0gdnRkX2ZpbmRfYWRkX2J1cyhzLCBidXMp
Ow0KPiA+ICsNCj4gPiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPiA+ICsgICAgdnRkX2Rldl9p
Y3ggPSB2dGRfYnVzLT5kZXZfaWN4W2RldmZuXTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXZ0ZF9k
ZXZfaWN4KSB7DQo+IA0KPiBXZSBjYW4gYXNzZXJ0IHRoaXMgZGlyZWN0bHkgSSB0aGluaywgaW4g
Y2FzZSB3ZSBhY2NpZGVudGFsbHkgc2V0IHRoZQ0KPiBjb250ZXh0IHR3aWNlIHdpdGhvdXQgbm90
aWNlLg0KDQpnb29kIGlkZWEuIHdpbGwgYWRkIGl0Lg0KDQo+IA0KPiA+ICsgICAgICAgIHZ0ZF9i
dXMtPmRldl9pY3hbZGV2Zm5dID0gdnRkX2Rldl9pY3ggPQ0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgIGdfbWFsbG9jMChzaXplb2YoVlRESG9zdElPTU1VQ29udGV4dCkpOw0KPiA+ICsgICAgICAg
IHZ0ZF9kZXZfaWN4LT52dGRfYnVzID0gdnRkX2J1czsNCj4gPiArICAgICAgICB2dGRfZGV2X2lj
eC0+ZGV2Zm4gPSAodWludDhfdClkZXZmbjsNCj4gPiArICAgICAgICB2dGRfZGV2X2ljeC0+aW9t
bXVfc3RhdGUgPSBzOw0KPiA+ICsgICAgICAgIHZ0ZF9kZXZfaWN4LT5ob3N0X2ljeCA9IGhvc3Rf
aWN4Ow0KPiA+ICsgICAgfQ0KPiA+ICsgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4gPiArDQo+
ID4gKyAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgdnRkX2Rl
dl91bnNldF9pb21tdV9jb250ZXh0KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludA0KPiBk
ZXZmbikNCj4gPiArew0KPiA+ICsgICAgSW50ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KPiA+
ICsgICAgVlREQnVzICp2dGRfYnVzOw0KPiA+ICsgICAgVlRESG9zdElPTU1VQ29udGV4dCAqdnRk
X2Rldl9pY3g7DQo+ID4gKw0KPiA+ICsgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQ
Q0lfREVWRk5fTUFYKTsNCj4gPiArDQo+ID4gKyAgICB2dGRfYnVzID0gdnRkX2ZpbmRfYWRkX2J1
cyhzLCBidXMpOw0KPiA+ICsNCj4gPiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPiA+ICsNCj4g
PiArICAgIHZ0ZF9kZXZfaWN4ID0gdnRkX2J1cy0+ZGV2X2ljeFtkZXZmbl07DQo+ID4gKyAgICBn
X2ZyZWUodnRkX2Rldl9pY3gpOw0KPiANCj4gQmV0dGVyIHNldCBpdCBhcyBOVUxMLCBhbmQgY2Fu
IGFsc28gZHJvcCB2dGRfZGV2X2ljeCB3aGljaCBzZWVtcw0KPiBtZWFuaW5nbGVzcy4uDQoNCnJp
Z2h0LiBpdCdzIG1pc3NlZC4NCg0KPiAgICAgICAgZ19mcmVlKHZ0ZF9idXMtPmRldl9pY3hbZGV2
Zm5dKTsNCj4gICAgICAgIHZ0ZF9idXMtPmRldl9pY3hbZGV2Zm5dID0gTlVMTDsNCj4gDQo+ID4g
Kw0KPiA+ICsgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3Rh
dGljIHVpbnQ2NF90IGdldF9uYXR1cmFsbHlfYWxpZ25lZF9zaXplKHVpbnQ2NF90IHN0YXJ0LA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qg
c2l6ZSwgaW50IGdhdykNCj4gPiAgew0KPiA+IEBAIC0zNzMxLDYgKzM3ODksOCBAQCBzdGF0aWMg
QWRkcmVzc1NwYWNlICp2dGRfaG9zdF9kbWFfaW9tbXUoUENJQnVzDQo+ICpidXMsIHZvaWQgKm9w
YXF1ZSwgaW50IGRldmZuKQ0KPiA+DQo+ID4gIHN0YXRpYyBQQ0lJT01NVU9wcyB2dGRfaW9tbXVf
b3BzID0gew0KPiA+ICAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1hX2lvbW11
LA0KPiA+ICsgICAgLnNldF9pb21tdV9jb250ZXh0ID0gdnRkX2Rldl9zZXRfaW9tbXVfY29udGV4
dCwNCj4gPiArICAgIC51bnNldF9pb21tdV9jb250ZXh0ID0gdnRkX2Rldl91bnNldF9pb21tdV9j
b250ZXh0LA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmln
KEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
DQo+ID4gaW5kZXggMzg3MDA1Mi4uOWI0ZmMwYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+ID4gQEAgLTY0LDYgKzY0LDcgQEAgdHlwZWRlZiB1bmlvbiBWVERfSVJfVGFibGVFbnRy
eSBWVERfSVJfVGFibGVFbnRyeTsNCj4gPiAgdHlwZWRlZiB1bmlvbiBWVERfSVJfTVNJQWRkcmVz
cyBWVERfSVJfTVNJQWRkcmVzczsNCj4gPiAgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSUREaXJFbnRy
eSBWVERQQVNJRERpckVudHJ5Ow0KPiA+ICB0eXBlZGVmIHN0cnVjdCBWVERQQVNJREVudHJ5IFZU
RFBBU0lERW50cnk7DQo+ID4gK3R5cGVkZWYgc3RydWN0IFZUREhvc3RJT01NVUNvbnRleHQgVlRE
SG9zdElPTU1VQ29udGV4dDsNCj4gPg0KPiA+ICAvKiBDb250ZXh0LUVudHJ5ICovDQo+ID4gIHN0
cnVjdCBWVERDb250ZXh0RW50cnkgew0KPiA+IEBAIC0xMTIsMTAgKzExMywyMCBAQCBzdHJ1Y3Qg
VlREQWRkcmVzc1NwYWNlIHsNCj4gPiAgICAgIElPVkFUcmVlICppb3ZhX3RyZWU7ICAgICAgICAg
IC8qIFRyYWNlcyBtYXBwZWQgSU9WQSByYW5nZXMgKi8NCj4gPiAgfTsNCj4gPg0KPiA+ICtzdHJ1
Y3QgVlRESG9zdElPTU1VQ29udGV4dCB7DQo+ID4gKyAgICBWVERCdXMgKnZ0ZF9idXM7DQo+ID4g
KyAgICB1aW50OF90IGRldmZuOw0KPiA+ICsgICAgSG9zdElPTU1VQ29udGV4dCAqaG9zdF9pY3g7
DQo+ID4gKyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11X3N0YXRlOw0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiAgc3RydWN0IFZUREJ1cyB7DQo+ID4gLSAgICBQQ0lCdXMqIGJ1czsJCS8qIEEgcmVmZXJl
bmNlIHRvIHRoZSBidXMgdG8gcHJvdmlkZSB0cmFuc2xhdGlvbg0KPiBmb3IgKi8NCj4gPiArICAg
IC8qIEEgcmVmZXJlbmNlIHRvIHRoZSBidXMgdG8gcHJvdmlkZSB0cmFuc2xhdGlvbiBmb3IgKi8N
Cj4gPiArICAgIFBDSUJ1cyAqYnVzOw0KPiA+ICAgICAgLyogQSB0YWJsZSBvZiBWVERBZGRyZXNz
U3BhY2Ugb2JqZWN0cyBpbmRleGVkIGJ5IGRldmZuICovDQo+ID4gLSAgICBWVERBZGRyZXNzU3Bh
Y2UgKmRldl9hc1tdOw0KPiA+ICsgICAgVlREQWRkcmVzc1NwYWNlICpkZXZfYXNbUENJX0RFVkZO
X01BWF07DQo+ID4gKyAgICAvKiBBIHRhYmxlIG9mIFZUREhvc3RJT01NVUNvbnRleHQgb2JqZWN0
cyBpbmRleGVkIGJ5IGRldmZuICovDQo+ID4gKyAgICBWVERIb3N0SU9NTVVDb250ZXh0ICpkZXZf
aWN4W1BDSV9ERVZGTl9NQVhdOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBWVERJT1RMQkVu
dHJ5IHsNCj4gPiBAQCAtMjcxLDYgKzI4Miw4IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0K
PiA+ICAgICAgLyoNCj4gPiAgICAgICAqIFByb3RlY3RzIElPTU1VIHN0YXRlcyBpbiBnZW5lcmFs
LiAgQ3VycmVudGx5IGl0IHByb3RlY3RzIHRoZQ0KPiA+ICAgICAgICogcGVyLUlPTU1VIElPVExC
IGNhY2hlLCBhbmQgY29udGV4dCBlbnRyeSBjYWNoZSBpbiBWVERBZGRyZXNzU3BhY2UuDQo+ID4g
KyAgICAgKiBQcm90ZWN0IHRoZSB1cGRhdGUvdXNhZ2Ugb2YgSG9zdElPTU1VQ29udGV4dCBwb2lu
dGVyIGNhY2hlZCBpbg0KPiA+ICsgICAgICogVlREQnVzLT5kZXZfaWN4IGFycmF5IGFzIGFycmF5
IGVsZW1lbnRzIG1heSBiZSB1cGRhdGVkIGJ5IGhvdHBsdWcNCj4gDQo+IEkgdGhpbmsgdGhlIGNv
bnRleHQgdXBkYXRlIGRvZXMgbm90IG5lZWQgdG8gYmUgdXBkYXRlZCwgYmVjYXVzZSB0aGV5DQo+
IHNob3VsZCBhbHdheXMgYmUgd2l0aCB0aGUgQlFMLCByaWdodD8NCg0KSG1tbW0sIG1heWJlIEkg
dXNlZCBiYWQgZGVzY3JpcHRpb24uIE15IHB1cnBvc2UgaXMgdG8gcHJvdGVjdCB0aGUgc3RvcmVk
DQpIb3N0SU9NTVVDb250ZXh0IHBvaW50ZXIgaW4gdklPTU1VLiBXaXRoIHBjaV9kZXZpY2Vfc2V0
L3Vuc2V0X2lvbW11X2NvbnRleHQsDQp2SU9NTVUgaGF2ZSBhIGNvcHkgb2YgSG9zdElPTU1VQ29u
dGV4dC4gSWYgVkZJTyBjb250YWluZXIgaXMgcmVsZWFzZWQNCihlLmcuIGhvdHB1bGcgb3V0IGRl
dmljZSksIEhvc3RJT01NVUNvbnRleHQgd2lsbCBhbG9zIGJlIHJlbGVhc2VkLiBUaGlzDQp3aWxs
IHRyaWdnZXIgdGhlIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfY29udGV4dCgpIHRvIGNsZWFuIHRo
ZSBjb3B5LiBUbw0KYXZvaWQgdXNpbmcgYSBzdGFsZWQgSG9zdElPTU1VQ29udGV4dCBpbiB2SU9N
TVUsIHZJT01NVSBzaG91bGQgaGF2ZSBhDQpsb2NrIHRvIGJsb2NrIHRoZSBwY2lfZGV2aWNlX3Vu
c2V0X2lvbW11X2NvbnRleHQoKSBjYWxsaW5nIHVudGlsIG90aGVyDQp0aHJlYWRzIGZpbmlzaGVk
IHRoZWlyIEhvc3RJT01NVUNvbnRleHQgdXNhZ2UuIERvIHlvdSB3YW50IGEgZGVzY3JpcHRpb24N
CnVwZGF0ZSBoZXJlIG9yIG90aGVyIHByZWZlcmVuY2U/DQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==

