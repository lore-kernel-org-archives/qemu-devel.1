Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18098C3A589
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF4D22DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF4D22DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ucloud.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0GwW-0003wY-29
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 23:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <owen.si@ucloud.cn>) id 1i0Gvl-0002rJ-2Z
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <owen.si@ucloud.cn>) id 1i0Gvh-00081h-Ev
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:04:58 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:12280)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <owen.si@ucloud.cn>) id 1i0Gvg-0007uE-S2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:04:57 -0400
Received: from SKY-20190329ATQ (unknown [117.48.120.186])
 by m9785.mail.qiye.163.com (Hmail) with ESMTPA id A6B5E5C1640;
 Wed, 21 Aug 2019 11:04:46 +0800 (CST)
Date: Wed, 21 Aug 2019 11:04:46 +0800
From: "owen.si@ucloud.cn" <owen.si@ucloud.cn>
To: "Eduardo Habkost" <ehabkost@redhat.com>
References: <20190819100924.14968-1-owen.si@ucloud.cn>, 
 <20190820212306.GM3908@habkost.net>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.10.151[cn]
Mime-Version: 1.0
Message-ID: <2019082111044638341815@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVSEtJS0tLT0tIT0tPSU9ZV1koWU
 FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6Lww5ITg#OT8cTCxLDk8x
 Mz4aCglVSlVKTk1NSE5NTUNMSktCVTMWGhIXVRQMHhVVCBI7DhgXFA4fVRgVRVlXWRILWUFZSkpM
 VU9DVUpJS1VKQ01ZV1kIAVlBQ05JSjcG
X-HM-Tid: 0a6cb222476b2087kuqya6b5e5c1640
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.97.85
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] Revert "i386: correct cpu_x86_cpuid(0xd)"
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIGZvciB5b3UgcmVwbHksIHdlIGhhdmUgc29tZSBob3N0cyBydW5uaW5nIHdpdGggbGVn
YWN5IGtlcm5lbCwgZGlmZmljdWx0IHRvIHVwZ3JhZGUsIGFuZCBpIHdhbnQgdG8gcnVuIHRoZSBs
YXRlc3QgcWVtdS4NCkRvZXMgUUVNVSBzdXBwb3J0IHJ1bm5pbmcgd2l0aCBsZWdhY3kga2VybmVs
KGt2bSkgaW4gZGVzaWduPw0KDQoNCg0Kb3dlbi5zaUB1Y2xvdWQuY24NCiANCkZyb206IEVkdWFy
ZG8gSGFia29zdA0KRGF0ZTogMjAxOS0wOC0yMSAwNToyMw0KVG86IEJpbmdzb25nIFNpDQpDQzog
cWVtdS1kZXZlbA0KU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0hdIFJldmVydCAiaTM4
NjogY29ycmVjdCBjcHVfeDg2X2NwdWlkKDB4ZCkiDQpPbiBNb24sIEF1ZyAxOSwgMjAxOSBhdCAw
NjowOToyNFBNICswODAwLCBCaW5nc29uZyBTaSB3cm90ZToNCj4gVGhpcyByZXZlcnRzIGNvbW1p
dCBkZTJlNjhjOTAyZjdiNmU0MzhiMGZhM2NmZWRkNzRhMDZhMjA3MDRmLg0KPiANCj4gSW5pdGlh
bCB2YWx1ZSBvZiBlbnYtPnhjcjAgPT0gMCwgdGhlbiBDUFVJRChFQVg9MHhkLEVDWD0wKS5FQlgg
PT0gMCwgYWZ0ZXIga3ZtDQo+IHVwc3RyZWFtIGNvbW1pdCA0MTJhM2M0MSwgSXQgaXMgb2suDQo+
IE9uIGhvc3QgYmVmb3JlIGNvbW1pdCA0MTJhM2M0MSwgc29tZSBsZWdhY3kgZ3Vlc3QsIGkuZS4g
Q2VudE9TIDYsIGdldA0KPiB4c3RhdGVfc2l6ZSA9PSAwLCB3aWxsIGNyYXNoIHRoZSBndWVzdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpbmdzb25nIFNpIDxvd2VuLnNpQHVjbG91ZC5jbj4NCiAN
CmNwdV94ODZfY3B1aWQoKSBpcyBhbHNvIHVzZWQgYnkgVENHLCBhbmQgbmVlZHMgdG8gcmV0dXJu
IHRoZQ0KY29ycmVjdCBkYXRhIGRlcGVuZGluZyBvbiB4Y3IwLiAgSWYgeW91IHdhbnQgdG8gd29y
ayBhcm91bmQgYSBLVk0NCmJ1ZyBieSBpZ25vcmluZyB4Y3IwLCBpdCBuZWVkcyB0byBiZSBjb25k
aXRpb25hbCBvbg0Ka3ZtX2VuYWJsZWQoKS4NCiANCkJ1dCBldmVuIGlmIHdlIHlvdSBtYWtlIHRo
aXMgY29uZGl0aW9uYWwgb24ga3ZtX2VuYWJsZWQoKSwgSQ0KZG9uJ3QgdW5kZXJzdGFuZCB3aHkg
UUVNVSB3b3VsZCBuZWVkIGEgd29ya2Fyb3VuZCBmb3IgYSBLVk0gYnVnDQp0aGF0IHdhcyBmaXhl
ZCBtb3JlIHRoYW4gNCB5ZWFycyBhZ28uDQogDQo+IC0tLQ0KPiAgdGFyZ2V0L2kzODYvY3B1LmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuYyBiL3RhcmdldC9pMzg2L2NwdS5j
DQo+IGluZGV4IGZmNjVlMTEwMDguLjY5NTYyZTIxZWQgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9p
Mzg2L2NwdS5jDQo+ICsrKyBiL3RhcmdldC9pMzg2L2NwdS5jDQo+IEBAIC00NDE2LDcgKzQ0MTYs
NyBAQCB2b2lkIGNwdV94ODZfY3B1aWQoQ1BVWDg2U3RhdGUgKmVudiwgdWludDMyX3QgaW5kZXgs
IHVpbnQzMl90IGNvdW50LA0KPiAgICAgICAgICAgICAgKmVjeCA9IHhzYXZlX2FyZWFfc2l6ZSh4
ODZfY3B1X3hzYXZlX2NvbXBvbmVudHMoY3B1KSk7DQo+ICAgICAgICAgICAgICAqZWF4ID0gZW52
LT5mZWF0dXJlc1tGRUFUX1hTQVZFX0NPTVBfTE9dOw0KPiAgICAgICAgICAgICAgKmVkeCA9IGVu
di0+ZmVhdHVyZXNbRkVBVF9YU0FWRV9DT01QX0hJXTsNCj4gLSAgICAgICAgICAgICplYnggPSB4
c2F2ZV9hcmVhX3NpemUoZW52LT54Y3IwKTsNCj4gKyAgICAgICAgICAgICplYnggPSAqZWN4Ow0K
PiAgICAgICAgICB9IGVsc2UgaWYgKGNvdW50ID09IDEpIHsNCj4gICAgICAgICAgICAgICplYXgg
PSBlbnYtPmZlYXR1cmVzW0ZFQVRfWFNBVkVdOw0KPiAgICAgICAgICB9IGVsc2UgaWYgKGNvdW50
IDwgQVJSQVlfU0laRSh4ODZfZXh0X3NhdmVfYXJlYXMpKSB7DQo+IC0tIA0KPiAyLjIyLjANCj4g
DQo+IA0KIA0KLS0gDQpFZHVhcmRvDQo=
