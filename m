Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5845AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 23:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CED620772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 23:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CED620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhM9T-00033S-DK
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 19:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jhM8x-0002eJ-6M
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 19:52:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:46368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jhM8v-0003HC-FD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 19:52:58 -0400
IronPort-SDR: ud3HoEryyMfOx4BVHF21QlYxGulSYdz80O0CsYCNpt9zcVhyCl7UyywPVPXRT0FBZSmaTkN6Z3
 wbKadchcGw9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 16:52:49 -0700
IronPort-SDR: Bd1vBLOnlsnctHM+2fypAlAw651OknfA/Yt30XYjVypNia7i99Nz9ZIqAAX6dnCc3iH0wYdznx
 X1wL7ZlqrIsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; d="scan'208";a="305223535"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2020 16:52:49 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 5 Jun 2020 16:52:48 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.6]) with mapi id 14.03.0439.000;
 Fri, 5 Jun 2020 16:52:48 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH v4 2/3] hw/acpi/nvdimm: add a helper to augment SRAT
 generation
Thread-Topic: [PATCH v4 2/3] hw/acpi/nvdimm: add a helper to augment SRAT
 generation
Thread-Index: AQHWNUA2VG31lbrZsEq/gWF/hD043ajIwgEAgADwkICAAH2JgIABA5GA
Date: Fri, 5 Jun 2020 23:52:48 +0000
Message-ID: <8f0d9907c4e5f100465eb30c2eb7c9b395c23fa6.camel@intel.com>
References: <20200528223437.12568-1-vishal.l.verma@intel.com>
 <20200528223437.12568-3-vishal.l.verma@intel.com>
 <20200604123326.38f7a368@redhat.com>
 <73b11cd452acffc18f7083f1ea7e5ca22cade31f.camel@intel.com>
 <20200605102345.52b2008a@redhat.com>
In-Reply-To: <20200605102345.52b2008a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8C8ADA9B8A9D346A9895A428FD8D99B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=vishal.l.verma@intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 19:52:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDIwLTA2LTA1IGF0IDEwOjIzICswMjAwLCBJZ29yIE1hbW1lZG92IHdyb3RlOg0K
DQo+ID4gPiA+IFRoZSByZWxldmFudCBjb21tYW5kIGxpbmUgb3B0aW9ucyB0byBleGVyY2lzZSB0
aGlzIGFyZSBiZWxvdy4gTm9kZXMgMC0xDQo+ID4gPiA+IGNvbnRhaW4gQ1BVcyBhbmQgcmVndWxh
ciBtZW1vcnksIGFuZCBub2RlcyAyLTMgYXJlIHRoZSBOVkRJTU0gYWRkcmVzcw0KPiA+ID4gPiBz
cGFjZS4NCj4gPiA+ID4gDQo+ID4gPiA+ICAgLW51bWEgbm9kZSxub2RlaWQ9MCxtZW09MjA0OE0s
DQo+ID4gPiA+ICAgLW51bWEgbm9kZSxub2RlaWQ9MSxtZW09MjA0OE0sICANCj4gPiA+IA0KPiA+
ID4gcGxzIG5vdGUgdGhhdCAnbWVtJyBpcyBhYm91dCB0byBiZSBkaXNhYmxlZCBmb3IgbmV3IG1h
Y2hpbmUgdHlwZXMgaW4gZmF2b3Igb2YgbWVtZGV2DQo+ID4gPiBzbyB0aGlzIENMSSB3b24ndCB3
b3JrLg0KPiA+ID4gSXQgd291bGQgYmUgbmljZSB0byB1cGRhdGUgY29tbWl0IG1lc3NhZ2Ugd2l0
aCBtZW1kZXYgdmFyaWFudCBvZiBDTEkgIA0KPiA+IA0KPiA+IEkgc2F3IHRoZSB3YXJuaW5ncyBw
cmludGVkIC0gSSBkaWQgdHJ5IHRvIHVzZSBtZW1kZXZzLCBidXQgaXQgZGlkbid0DQo+ID4gcXVp
dGUgd29yayB3aXRoIG15IHVzZSBjYXNlLiBJJ20gc3VwcGx5aW5nIG1lbT0wIGZvciB0aGUgcG1l
bS9udmRpbW0NCj4gPiBkZXZpY2VzIHRoYXQgSSB3YW50IHRvIGdpdmUgYSBzcGVjaWZpYyBudW1h
IG5vZGUsIGJ1dCBub3QgZ2l2ZSB0aGVtIGFueQ0KPiA+IG1vcmUgcmVndWxhciBtZW1vcnkgYXNp
ZGUgZnJvbSB0aGUgbnZkaW1tIGl0c2VsZiAoc2VlIG5vZGVzIDQgYW5kIDUNCj4gPiBiZWxvdyku
IEFuZCBmb3Igc29tZSByZWFzb24gSSBjb3VsZG4ndCBkbyB0aGF0IHdpdGggbWVtZGV2cy4NCj4g
aXQgc2hvdWxkIHdvcmsgc2luY2UgNC4xDQo+IA0KPiBoZXJlIGlzIGV4YW1wbGUgDQo+IHFlbXUt
c3lzdGVtLXg4Nl82NCAtb2JqZWN0IG1lbW9yeS1iYWNrZW5kLXJhbSxpZD1tZW0wLHNpemU9MUcg
LW0gMUcgXA0KPiAgLW51bWEgbm9kZSxtZW1kZXY9bWVtMCAtbnVtYSBub2RlIC1tb25pdG9yIHN0
ZGlvDQo+IA0KPiBRRU1VIDUuMC41MCBtb25pdG9yIC0gdHlwZSAnaGVscCcgZm9yIG1vcmUgaW5m
b3JtYXRpb24NCj4gKHFlbXUpIFZOQyBzZXJ2ZXIgcnVubmluZyBvbiA6OjE6NTkwMA0KPiBpbmZv
IG51bWENCj4gMiBub2Rlcw0KPiBub2RlIDAgY3B1czogMA0KPiBub2RlIDAgc2l6ZTogMTAyNCBN
Qg0KPiBub2RlIDAgcGx1Z2dlZDogMCBNQg0KPiBub2RlIDEgY3B1czoNCj4gbm9kZSAxIHNpemU6
IDAgTUINCj4gbm9kZSAxIHBsdWdnZWQ6IDAgTUINCj4gKHFlbXUpDQo+IA0KDQpQZXJmZWN0IGdv
dCBpdCB3b3JraW5nLCBUaGFua3MgSWdvciENCg0KSSdsbCBzZW5kIGEgdjUgd2l0aCB0aGUgdXBk
YXRlZCBjb21taXQgbWVzc2FnZSBhbmQgYWRkIHlvdXIgcmV2aWV3ZWQtYnkuDQoNCi1WaXNoYWwN
Cg==

