Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0336C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A368520720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A368520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cea.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9mJ-0001l9-Rh
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olivier.lahaye@cea.fr>)
 id 1jY9TE-0003zn-T8; Mon, 11 May 2020 10:31:52 -0400
Received: from cirse-smtp-out.extra.cea.fr ([132.167.192.148]:43106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olivier.lahaye@cea.fr>)
 id 1jY9TC-0002Je-Vg; Mon, 11 May 2020 10:31:52 -0400
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
 by cirse-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 04BEVjKW030521; Mon, 11 May 2020 16:31:45 +0200
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id 59757210E9F;
 Mon, 11 May 2020 16:31:45 +0200 (CEST)
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr
 [132.166.192.12])
 by pisaure.intra.cea.fr (Postfix) with ESMTP id 42DE5210E8C;
 Mon, 11 May 2020 16:31:45 +0200 (CEST)
Received: from EXCAH-A0.intra.cea.fr (excah-a0.intra.cea.fr [132.166.88.74])
 by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 04BEVjkQ024686; Mon, 11 May 2020 16:31:45 +0200
Received: from EXDAG0-A3.intra.cea.fr ([fe80::25a1:c396:2106:4c5b]) by
 EXCAH-A0.intra.cea.fr ([fe80::446e:fe1a:2892:9de1%10]) with mapi id
 14.03.0487.000; Mon, 11 May 2020 16:31:45 +0200
From: LAHAYE Olivier <olivier.lahaye@cea.fr>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, B3r3n
 <B3r3n@argosnet.com>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Qemu, VNC and non-US keymaps
Thread-Topic: Qemu, VNC and non-US keymaps
Thread-Index: AQHWJ5+fVD6rkJq73keSL9W8GvQa16iizwAAgAAjigA=
Date: Mon, 11 May 2020 14:31:45 +0000
Message-ID: <336D5401-9C4F-4C18-B8DF-AFCC7233155E@cea.fr>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
In-Reply-To: <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.22.0.200209
x-originating-ip: [132.166.88.106]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.100.1062-23234.003
x-tm-as-result: No--14.501800-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A5AF00DCE606D49A82DDC5911A48488@cea.fr>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=132.167.192.148;
 envelope-from=olivier.lahaye@cea.fr; helo=cirse-smtp-out.extra.cea.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 10:31:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2020 10:50:27 -0400
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

SSBoYXZlIGEgc2ltaWxhciBwcm9ibGVtIHdpdGggcWVtdSAoYWxsIHZlcnNpb25zIGluY2x1ZGlu
ZyA1LjAuMCkgb24gTWFjT1MtMTAuMTQuNiAobWFjIGJvb2sgcHJvIDIwMTd3aXRoIHRvdWNoIGJh
cikuDQoNClVzaW5nIC1rIGZyLW1hYyB0aGUgIkAiLyIjIiBrZXkgaXMgZGVhZC4NClNob3drZXkg
ZG9lc24ndCBkZXRlY3QgdGhlIGtleS4NCk1vcmVvdmVyLCB0aGUgIyBhbmQgQCBzeW1ib2xzIGFy
ZSBtYXBwZWQgb24gdGhlICI8IiAvICI+IiBrZXkgYW5kIHRodXMgSSBtaXNzIHRoZSByZWRpcmVj
dGlvbiBvcGVyYXRvciBpbiBzaGVsbC4NCg0KQ2hlZXJzLA0KDQpPbGl2aWVyLg0KDQrvu79MZSAx
MS8wNS8yMDIwIDE2OjI1LCDCqyBRZW11LWRpc2N1c3MgYXUgbm9tIGRlIFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIMK7IDxxZW11LWRpc2N1c3MtYm91bmNlcytvbGl2aWVyLmxhaGF5ZT1jZWEuZnJA
bm9uZ251Lm9yZyBhdSBub20gZGUgcGhpbG1kQHJlZGhhdC5jb20+IGEgw6ljcml0IDoNCg0KICAg
IENjJ2luZyBtb3JlIGRldmVsb3BlcnMuDQogICAgDQogICAgT24gNS8xMS8yMCA0OjE3IFBNLCBC
M3IzbiB3cm90ZToNCiAgICA+IERlYXIgYWxsLA0KICAgID4gDQogICAgPiBJIGFtIHN0cnVnZ2xp
bmcgZm9yIGRheXMvd2Vla3Mgd2l0aCBRZW11IGFuZCBpdHMgVk5DIGFjY2Vzc2VzLi4ud2l0aCAN
CiAgICA+IG5vbi1VUyBrZXltYXBzLg0KICAgID4gDQogICAgPiBMZXQgbWUgc3VtbSB0aGUgZmFj
dHM6DQogICAgPiAtIEkgYW0gdXNpbmcgYSBmcmVuY2gga2V5Ym9hcmQgb3ZlciBhIFVidW50dSAx
OC4wNC4NCiAgICA+IC0gSSBpbnN0YWxsZWQgYSBzaW1wbGUgRGViaWFuIGluIGEgUWVtdSBWTSwg
Y29uZmlndXJlZCB3aXRoIEZSIGtleWJvYXJkIA0KICAgID4gKEFaRVJUWSkuDQogICAgPiAtIEkg
YW0gbGF1bmNoaW5nIHRoZSBRZW11IFZNIHdpdGggdGhlICctayBmcicga2V5bWFwaW5nIChvcmln
aW5hbCkNCiAgICA+IC0gSSB0ZXN0ZWQgd2l0aCBRZW11IDMuMS4xLCA0LjIuMCAmIDUuMC4wLg0K
ICAgID4gDQogICAgPiBJIGZhaWwgdG8gaGF2ZSB0aGUgQWx0R3Iga2V5cywgY3JpdGljYWwgdG8g
ZnJlbmNoZXMgKHBpcGUsIGJhY2tzbGFzaCwgDQogICAgPiBkYXNoIGV0YykuDQogICAgPiBjaGVj
a2luZyB3aXRoIHNob3drZXksIEkgc2VlIHRoZSBrZXlzIGFycml2aW5nIHByb3Blcmx5ICgyOSs1
NiwgMjkrMTAwLCANCiAgICA+IGV0YykuDQogICAgPiANCiAgICA+IENvbnNpZGVyaW5nIGl0IG1p
Z2h0IGJlIGEgZGViaWFuIGlzc3VlIGFzIHdlbGwsIEkgdXBkYXRlZCB0aGUgDQogICAgPiBxZW11
L2tleW1hcHMvZnIgZmlsZSB0byBoYXZlIGJhciBkaXJlY3RseSB3aXRoIHRoZSA2IGtleSAobm9y
bWFsbHkgYmFyIA0KICAgID4gaXMgQWx0R3IgKyA2KS4NCiAgICA+IEZvciBhbiB1bmtub3duIHJl
YXNvbiwgdGhlICc2JyB0aGVuIG5vIGxvbmdlciB3b3JrcyAoc2hvd2tleSBzaG93cyANCiAgICA+
IG5vdGhpbmcgYXMgd2VsbCkuDQogICAgPiANCiAgICA+IFRoZXJlIG1pZ2h0IGJlIHNvbWV0aGlu
ZyBJIG1pc3MsIGFuZCB0aGUgbWlnaHQgYWxzbyBiZSBzb21lIGJ1ZyANCiAgICA+IHNvbWV3aGVy
ZSwgb3Igc29tZSBtaXNzaW5ncy4NCiAgICA+IEZvciBleGFtcGxlLCBtYXliZSBYMTEgbXVzdCBi
ZSBpbnN0YWxsZWQsIGV2ZW4gaXQgdW51c2VkIChWTkMgY2xpZW50IA0KICAgID4gY29ubmVjdHMg
dG8gUWVtdSBWTkMgcG9ydCBkaXJlY3RseSksIG9yIHdoYXRldmVyLg0KICAgID4gDQogICAgPiBB
bnkgaGVscCBhcHByZWNpYXRlZCA6LSkNCiAgICA+IA0KICAgID4gVGhhbmtzDQogICAgPiANCiAg
ICA+IEJyZ3Jkcw0KICAgID4gDQogICAgPiANCiAgICANCiAgICANCiAgICANCg0K

