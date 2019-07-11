Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E065C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 18:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01754208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 18:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01754208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hldr0-0003TL-0r
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 14:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hldqm-000357-VY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 14:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hldqk-0001xk-Sp
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 14:31:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:21132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hldqg-0001h9-5J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 14:31:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jul 2019 11:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; d="scan'208";a="156903440"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 11 Jul 2019 11:31:07 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 11:31:06 -0700
Received: from fmsmsx104.amr.corp.intel.com ([169.254.3.188]) by
 fmsmsx124.amr.corp.intel.com ([169.254.8.213]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 11:31:06 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 2/2] create_config: remove
 $(CONFIG_SOFTMMU) hack
Thread-Index: AQHVOA1I3C1yJ6eLHkW/FCIDwa24EqbGMsmA
Date: Thu, 11 Jul 2019 18:31:05 +0000
Message-ID: <1f13d98cdb16cf47b15b6500ff4aa3a019f17f63.camel@intel.com>
References: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
 <1562865736-3546-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1562865736-3546-3-git-send-email-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.131.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2603496518F8C24BB1CDDF8B6FF480B7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH 2/2] create_config: remove
 $(CONFIG_SOFTMMU) hack
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
Cc: "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bGd0bSwgdGhhbmtzIFBhb2xvDQoNCg0KUmV2aWV3ZWQtYnk6IEp1bGlvIE1vbnRlcyA8anVsaW8u
bW9udGVzQGludGVsLmNvbT4NClRlc3RlZC1ieTogSnVsaW8gTW9udGVzIDxqdWxpby5tb250ZXNA
aW50ZWwuY29tPg0KDQpPbiBUaHUsIDIwMTktMDctMTEgYXQgMTk6MjIgKzAyMDAsIFBhb2xvIEJv
bnppbmkgd3JvdGU6DQo+IENPTkZJR19UUE0gaXMgZGVmaW5lZCB0byBhIHJhdGhlciB3ZWlyZCAk
KENPTkZJR19TT0ZUTU1VKSBzbyB0aGF0IGl0DQo+IGV4cGFuZHMgdG8gdGhlIHJpZ2h0IHRoaW5n
IGluIGh3L01ha2VmaWxlLm9ianMuICBUaGlzIGhvd2V2ZXIgaXMgbm90DQo+IG5lZWRlZCBhbnlt
b3JlIGFuZCBpdCBoYXMgYSBjb3JyZXNwb25kaW5nIGhhY2sgaW4gY3JlYXRlX2NvbmZpZw0KPiB0
byB0dXJuIGl0IGludG8gIiNkZWZpbmUgQ09ORklHX1RQTSAxIi4gIENsZWFuIHVwLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gLS0t
DQo+ICBjb25maWd1cmUgICAgICAgICAgICAgfCAyICstDQo+ICBzY3JpcHRzL2NyZWF0ZV9jb25m
aWcgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9jb25maWd1cmUNCj4gaW5kZXgg
NDk4M2M4Yi4uZWI2MzVjMyAxMDA3NTUNCj4gLS0tIGEvY29uZmlndXJlDQo+ICsrKyBiL2NvbmZp
Z3VyZQ0KPiBAQCAtNzE1OSw3ICs3MTU5LDcgQEAgaWYgdGVzdCAiJGxpdmVfYmxvY2tfbWlncmF0
aW9uIiA9ICJ5ZXMiIDsgdGhlbg0KPiAgZmkNCj4gIA0KPiAgaWYgdGVzdCAiJHRwbSIgPSAieWVz
IjsgdGhlbg0KPiAtICBlY2hvICdDT05GSUdfVFBNPSQoQ09ORklHX1NPRlRNTVUpJyA+PiAkY29u
ZmlnX2hvc3RfbWFrDQo+ICsgIGVjaG8gJ0NPTkZJR19UUE09eScgPj4gJGNvbmZpZ19ob3N0X21h
aw0KPiAgZmkNCj4gIA0KPiAgZWNobyAiVFJBQ0VfQkFDS0VORFM9JHRyYWNlX2JhY2tlbmRzIiA+
PiAkY29uZmlnX2hvc3RfbWFrDQo+IGRpZmYgLS1naXQgYS9zY3JpcHRzL2NyZWF0ZV9jb25maWcg
Yi9zY3JpcHRzL2NyZWF0ZV9jb25maWcNCj4gaW5kZXggMDBlODZjOC4uNmQ4ZjA4YiAxMDA3NTUN
Cj4gLS0tIGEvc2NyaXB0cy9jcmVhdGVfY29uZmlnDQo+ICsrKyBiL3NjcmlwdHMvY3JlYXRlX2Nv
bmZpZw0KPiBAQCAtNTQsNyArNTQsNyBAQCBjYXNlICRsaW5lIGluDQo+ICAgICAgZG9uZQ0KPiAg
ICAgIGVjaG8gIiAgICBOVUxMIg0KPiAgICAgIDs7DQo+IC0gQ09ORklHXyo9JyQoQ09ORklHX1NP
RlRNTVUpJ3xDT05GSUdfKj15KSAjIGNvbmZpZ3VyYXRpb24NCj4gKyBDT05GSUdfKj15KSAjIGNv
bmZpZ3VyYXRpb24NCj4gICAgICBuYW1lPSR7bGluZSU9Kn0NCj4gICAgICBlY2hvICIjZGVmaW5l
ICRuYW1lIDEiDQo+ICAgICAgOzsNCg==

