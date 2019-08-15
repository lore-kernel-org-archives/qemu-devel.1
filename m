Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED82C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 06:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08D92084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 06:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08D92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy94I-0001H7-Ra
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 02:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1hy92R-0000iW-BC
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hy92P-0007lJ-EB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:15:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:40790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hy92P-0007j3-5N
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 02:15:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 23:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; d="scan'208";a="176787964"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2019 23:14:56 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 23:14:56 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 23:14:55 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.112]) with mapi id 14.03.0439.000;
 Thu, 15 Aug 2019 14:14:53 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "lukasstraub2@web.de"
 <lukasstraub2@web.de>
Thread-Topic: [Qemu-devel] [PATCH 0/3] colo: Add support for continious
 replication
Thread-Index: AQHVUuGxp19J4eqmPk6hnKC7q05296b7BOeAgAC2ajA=
Date: Thu, 15 Aug 2019 06:14:52 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780621DA35@shsmsx102.ccr.corp.intel.com>
References: <cover.1565814686.git.lukasstraub2@web.de>
 <156583922839.3056.7768886745241439528@5dec9699b7de>
In-Reply-To: <156583922839.3056.7768886745241439528@5dec9699b7de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzJmODI3MTctMDEwMC00NWI2LTg2NGUtMjNjZjRlNGMzZjQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK0lOTm5BVE83bWhpV1wvajEzVEFOVXhcL3J1Y21YU280RGhcLzNaQklnTVpOcER6NXUwZEpGVXZVa3dUVlZrcStwVCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH 0/3] colo: Add support for continious
 replication
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

SGkgTHVrYXMsDQoNClBsZWFzZSBmaXggdGhpcyBpc3N1ZSBhbmQgYWRkIG1vcmUgY29tbWVudHMg
aW4gdGhlIGNvbW1pdCBsb2cuDQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IG5vLXJlcGx5QHBhdGNoZXcub3JnIFttYWlsdG86bm8t
cmVwbHlAcGF0Y2hldy5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTUsIDIwMTkgMTE6
MjAgQU0NCj4gVG86IGx1a2Fzc3RyYXViMkB3ZWIuZGUNCj4gQ2M6IFpoYW5nLCBDaGVuIDxjaGVu
LnpoYW5nQGludGVsLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBSZTog
W1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzNdIGNvbG86IEFkZCBzdXBwb3J0IGZvciBjb250aW5pb3Vz
DQo+IHJlcGxpY2F0aW9uDQo+IA0KPiBQYXRjaGV3IFVSTDoNCj4gaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9RRU1VL2NvdmVyLjE1NjU4MTQ2ODYuZ2l0Lmx1a2Fzc3RyYXViMkB3ZWIuZGUvDQo+IA0KPiAN
Cj4gDQo+IEhpLA0KPiANCj4gVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHgg
aG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuDQo+IA0KPiA9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09DQo+ICMhL2Jpbi9iYXNoDQo+ICMgVGVzdGluZyBzY3JpcHQgd2lsbCBiZSBp
bnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aCAjIEhFQUQgcG9pbnRpbmcgdG8NCj4g
YSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiDQo+
ICMgYnJhbmNoDQo+IHNldCAtZQ0KPiANCj4gZWNobw0KPiBlY2hvICI9PT0gRU5WID09PSINCj4g
ZW52DQo+IA0KPiBlY2hvDQo+IGVjaG8gIj09PSBQQUNLQUdFUyA9PT0iDQo+IHJwbSAtcWENCj4g
DQo+IGVjaG8NCj4gZWNobyAiPT09IFVOQU1FID09PSINCj4gdW5hbWUgLWENCj4gDQo+IENDPSRI
T01FL2Jpbi9jYw0KPiBJTlNUQUxMPSRQV0QvaW5zdGFsbA0KPiBCVUlMRD0kUFdEL2J1aWxkDQo+
IG1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTA0KPiBTUkM9JFBXRA0KPiBjZCAkQlVJTEQNCj4gJFNS
Qy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwgbWFrZSAtajQgIyBYWFg6IHdl
IG5lZWQgcmVsaWFibGUNCj4gY2xlYW4gdXAgIyBtYWtlIGNoZWNrIC1qNCBWPTEgbWFrZSBpbnN0
YWxsID09PSBURVNUIFNDUklQVCBFTkQgPT09DQo+IA0KPiAgICAgICAgICAgICAgICAgIGZyb20g
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLQ0KPiA2amk2cWZpMi9zcmMvaW5jbHVkZS9uZXQv
ZmlsdGVyLmg6MTMsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtNmppNnFmaTIvc3JjL25ldC9maWx0ZXIuYzoxNDoNCj4gL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLTZqaTZxZmkyL3NyYy9uZXQvZmlsdGVyLmM6IEluIGZ1bmN0aW9uDQo+IOKA
mG5ldGZpbHRlcl9jb21wbGV0ZeKAmToNCj4gL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZq
aTZxZmkyL3NyYy9pbmNsdWRlL3FlbXUvcXVldWUuaDo0MTI6NDQ6IGVycm9yOg0KPiDigJhwb3Np
dGlvbuKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJy
b3I9bWF5YmUtDQo+IHVuaW5pdGlhbGl6ZWRdDQo+ICAgNDEyIHwgICAgICAgICAobGlzdGVsbSkt
PmZpZWxkLnRxZV9jaXJjLnRxbF9wcmV2ID0gJihlbG0pLT5maWVsZC50cWVfY2lyYzsgICAgICAg
ICBcDQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4NCj4gL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZqaTZxZmkyL3NyYy9uZXQvZmlsdGVy
LmM6MjM3OjIxOiBub3RlOiDigJhwb3NpdGlvbuKAmQ0KPiB3YXMgZGVjbGFyZWQgaGVyZQ0KPiAN
Cj4gDQo+IFRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQNCj4gaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvY292ZXIuMTU2NTgxNDY4Ni5naXQubHVrYXNzdHJhdWIyQHdlYi5kZS90ZXN0aW5nLnMz
DQo+IDkweC8/dHlwZT1tZXNzYWdlLg0KPiAtLS0NCj4gRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLg0KPiBQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ0K

