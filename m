Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEBCC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD93217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 09:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD93217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSHyo-0006mq-Ga
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 04:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSHxl-0005vg-VS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSHxk-0003rK-7O
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:50:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:21604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSHxj-0003kZ-IP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 04:50:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 01:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="212731022"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga001.fm.intel.com with ESMTP; 06 Nov 2019 01:50:43 -0800
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 01:50:43 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 01:50:42 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.225]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 17:50:39 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be string
 option
Thread-Topic: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be
 string option
Thread-Index: AQHVimsn7SVAI/DYekGpKA287OuKO6d17oaAgAZs2aD//7jAAIAB5aQQ
Date: Wed, 6 Nov 2019 09:50:38 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EF0E9@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-4-git-send-email-yi.l.liu@intel.com>
 <20191101145753.GC8888@xz-x1.metropole.lan>
 <A2975661238FB949B60364EF0F2C25743A0EE30A@SHSMSX104.ccr.corp.intel.com>
 <20191105125000.GE12619@xz-x1>
In-Reply-To: <20191105125000.GE12619@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2RiMTg0YzMtZjU3Ni00NmFkLWI1NWItMmM5NGVmODIyMWM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiajZSc1ZOMHRxXC95ZWJrQURyMG04UCtjZGs3KzBsQmJwTGZhRGFOeEZrSFwvVVJTaWw3bXVrRVN4ZW8wbVI4aFQ1In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVz
ZGF5LCBOb3ZlbWJlciA1LCAyMDE5IDg6NTAgUE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MiAwMy8yMl0gaW50ZWxfaW9tbXU6IG1v
ZGlmeSB4LXNjYWxhYmxlLW1vZGUgdG8gYmUgc3RyaW5nIG9wdGlvbg0KPiANCj4gT24gVHVlLCBO
b3YgMDUsIDIwMTkgYXQgMDk6MTQ6MDhBTSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+ID4g
U29tZXRoaW5nIGxpa2U6DQo+ID4gPg0KPiA+ID4gICAtIHMtPnNjYWxhYmxlX21vZGVfc3RyIHRv
IGtlZXAgdGhlIHN0cmluZw0KPiA+ID4gICAtIHMtPnNjYWxhYmxlX21vZGUgc3RpbGwgYXMgYSBi
b29sIHRvIGNhY2hlIHRoZSBnbG9iYWwgZW5hYmxlbWVudA0KPiA+ID4gICAtIHMtPnNjYWxhYmxl
X21vZGVybiBhcyBhIGJvb2wgdG8ga2VlcCB0aGUgbW9kZQ0KPiA+ID4NCj4gPiA+ID8NCj4gPg0K
PiA+IFNvIHgtc2NhbGFibGUtbW9kZSBpcyBzdGlsbCBhIHN0cmluZyBvcHRpb24sIGp1c3QgdG8g
aGF2ZSBhIG5ldyBmaWVsZCB0byBzdG9yZSBpdD8NCj4gDQo+IFllcC4gIEknZCBzYXkgbWF5YmUg
d2Ugc2hvdWxkIHN0YXJ0IHRvIGFsbG93IHRvIGRlZmluZSBzb21lIHVuaW9uLWlzaCBwcm9wZXJ0
aWVzLCBidXQNCj4gZm9yIG5vdyBJIHRoaW5rIHN0cmluZyBpcyBvay4NCg0Kb2ssIGxldCBtZSBt
YWtlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KWWkgTGl1DQo=

