Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DDDC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 15:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E2B206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="unxHnlRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E2B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1judlX-0007cr-Mt
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 11:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1judkj-0006sN-Uc; Sun, 12 Jul 2020 11:18:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:2631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1judkh-0006ha-0L; Sun, 12 Jul 2020 11:18:53 -0400
IronPort-SDR: xs2i8uEmFEwI3O1D9b5J3QLbhSJmz2JdH9wEtettuZEEHY+AjDhLHGNUiYrAHedq24XYBPj/aS
 KgxVIBwxzMuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="233364227"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; d="scan'208";a="233364227"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 08:18:45 -0700
IronPort-SDR: dQIiCWBqfovboFwhSfqBNLYsq90zqURWFhpwCd/L/EuZI4dcX1k9bujd5NfxIQVbXo5hKmeYg/
 Kz4QJ5vBNY0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; d="scan'208";a="389972749"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2020 08:18:44 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 12 Jul 2020 08:18:41 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 12 Jul 2020 08:18:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 12 Jul 2020 08:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYLwqyDg98T0vQ1NV+TuIMxry6PvGlKoK7VMGc4CjLA0WJpk5LJLBU0HuwV+q2iWxeq94ltkfUwBEHgXZXPXTdM99+NbUIrOj6PmAU2F1O7xy3MqSfENUMoiI9MSikNaUUuhisGvoYBRlzelUKmjHYaWJAYVUqiUrsA5RTqsrlXXDsvsY8LCJomCAC70u1ybt3UvaYCeNW3ivMm47nQDGU7LbfMzsEi5R6AbXL3cWLkYj9s44zvQjTAhW4IYt/7fq14CKZNfWl63xc/eAm8g6kX4DG7zY4z2FXFlcpGKO3jQ8U9wFO0vgMG1Gxh/9yfITcXAqHlFKFcDhNhCq0RpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=710SgNskQh5VLJo3kctnMwqUGbkLMjClZnTtk63etB4=;
 b=SOflKpYnqN5vMLfwB8wUrCY/h06+x/saDrHx0zp4+TsfRQonQCFR5Rx5FlrYkb/a0iN0n7wEf6i5vzAbJ1QBjmsrEE3YpKikh393BbRepGQHzPQHnVdTFwlK4+b9H76WNZw408pwbpd6qBpnELIbCN2bSKjra0RyxrIOGJVdRcT0QeNNgsTuKwMQbB0glx6l4CTRTfVN7B9zSO6PqbzjGeGUwCELrs0OfVSuJvvw/T2BTwSWTdqbulO1wCOTSm+i6OBr/+aus6Rs3Hh1/IRS7TlaayZRO8JiVoL7Q8I9z1j+xjohtOC80wH0tXK6zzdZXVtoOyPg28Bhav1pDXhOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=710SgNskQh5VLJo3kctnMwqUGbkLMjClZnTtk63etB4=;
 b=unxHnlRAla/67kwlC7rlRuXQAiEbrzu2HEu+v2HNNHml8Hh2IgymnFEvHpvFKAUadY9zdCxgtkJWInMZLMFOzwSZMDTiCT6k/+fwh+PQjK4t+UsVbYqGIQxtwU03gFCRKIKUcATstxTmd1gbQEACoTOh6KYhhEl7FoXP0J+xQEQ=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM5PR11MB1497.namprd11.prod.outlook.com (2603:10b6:4:c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Sun, 12 Jul 2020 15:18:38 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3174.025; Sun, 12 Jul 2020
 15:18:38 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v2 1/4] target/nios2: add DISAS_NORETURN case for nothing
 more to generate
Thread-Topic: [PATCH v2 1/4] target/nios2: add DISAS_NORETURN case for nothing
 more to generate
Thread-Index: AQHWVtFJcXtr6siA1E2uzooVXgBR0KkCumyAgAFWEhA=
Date: Sun, 12 Jul 2020 15:18:38 +0000
Message-ID: <DM5PR11MB18332E2147DF63FE3FE2E34E8D630@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200710233433.19729-1-wentong.wu@intel.com>
 <CAFEAcA9BfSCUi_LyCkvT7+V1cfhWgbUe2X9du0j-KnUf2bswnw@mail.gmail.com>
In-Reply-To: <CAFEAcA9BfSCUi_LyCkvT7+V1cfhWgbUe2X9du0j-KnUf2bswnw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77e714b5-01c8-4009-7f53-08d82676da97
x-ms-traffictypediagnostic: DM5PR11MB1497:
x-microsoft-antispam-prvs: <DM5PR11MB1497B7DFA89822FCE45667AB8D630@DM5PR11MB1497.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kb9/kZC9wHwONsGWKxFknth28ul7qdHU2U+hBi9eWM7n3KddwGPok1uHfuNPW3DxNv2/+YuQSY007fZu8gaXjGlNK8jrRR66F+W+0DRUzsz26uDXNX3y0xfE7qlnlJXgsCQSf1p50GoPidRTt+V/t8N6njI/KJNWEC9JoLrnJOOnmKa4RinlhtL4po1/ayhU/7fKIP35kw4up2ZTPZFe2sLTGAbp9Rn8MXeTq++3d0y48tMCVrrvtmzsBTI6owghpwggCvkFLP9gnkOykjF/h8QFpe++aeuFUoIbXHGuWk69gxtPXaRn7yMBVbnQojBs0CNtzCD+ACAOux6AOa4CUMuwdCC3zJzz+OLouGuq0cnmCn1z1v2/BfteS/9QiFi22QEMsXP24V/EzaX3M7Z8fQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(71200400001)(7696005)(6916009)(52536014)(5660300002)(33656002)(316002)(55016002)(83380400001)(8936002)(8676002)(4326008)(966005)(478600001)(54906003)(86362001)(76116006)(9686003)(26005)(66946007)(186003)(64756008)(2906002)(6506007)(66556008)(66446008)(53546011)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: DPJkoY+04056Hh9sj+l86cSixp/0KdDKuQXUwc7H1Rcr1KRmIV6zPF6c7Sr6188GLA5uB+/5B66fJ9OHC6b9bC8/KL4UmlJq9c/s49cBXWG1TfN+2439j3KKL8RR01SMD+UC/gImUYCOo87U+esOu//VxFI8apxxL8VztElXgRl4EBiK0px5lurnNQiEjfY43doxLAScwfrFo4cNly2FBAPKn9+lJErReIairJuW1BZzcxLvIwrIv1Nn/fC6gQ3se0d42gu3yB+KgInQCrfsmQMoZ5M/mZwqkbJHqDMSp2U2ROgipt0c/XMQFIWtJo9aMMq+hzarwNB7u1XOismpc/nAg/ygexJVbVmrj0YKpz9tWAeN4fJ1JZwK9mysoKJL8d0CaDskv3g12ENHX/i/ND/jFj7SPcIZWpe/f98OoZpmJiUjPzVVGWacfbUQiCNR4iO69Dq4D11lHDg+YLavAsdnx0ie7mrUL8VjrnRkwr+n6OUxjXwJWoAgm2sOkD5o
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e714b5-01c8-4009-7f53-08d82676da97
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2020 15:18:38.7443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrDxH2FYtWt/bVU8VgHDmjMPb567jrOr09xciRkqgPJ8uM52s9/cezLVPyjOzA3O48uzO0d+e8CE1Enon/A8jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1497
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wentong.wu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 11:18:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Chris Wulff <crwulff@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmc+IA0KPiBTZW50OiBTdW5kYXksIEp1bHkgMTIsIDIwMjAgMjo1
MCBBTQ0KPiBUbzogV3UsIFdlbnRvbmcgPHdlbnRvbmcud3VAaW50ZWwuY29tPg0KPiBDYzogUUVN
VSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBRRU1VIFRyaXZpYWwgPHFlbXUt
dHJpdmlhbEBub25nbnUub3JnPjsgQ2hyaXMgV3VsZmYgPGNyd3VsZmZAZ21haWwuY29tPjsgTWFy
ZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS80XSB0
YXJnZXQvbmlvczI6IGFkZCBESVNBU19OT1JFVFVSTiBjYXNlIGZvciBub3RoaW5nIG1vcmUgdG8g
Z2VuZXJhdGUNCj4gDQo+IE9uIEZyaSwgMTAgSnVsIDIwMjAgYXQgMTY6NDYsIFdlbnRvbmcgV3Ug
PHdlbnRvbmcud3VAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBESVNBU19OT1JFVFVS
TiBjYXNlIGZvciBub3RoaW5nIG1vcmUgdG8gZ2VuZXJhdGUgYmVjYXVzZSBhdCANCj4gPiBydW50
aW1lIGV4ZWN1dGlvbiB3aWxsIG5ldmVyIHJldHVybiBmcm9tIHNvbWUgaGVscGVyIGNhbGwuIEFu
ZCBhdCB0aGUgDQo+ID4gc2FtZSB0aW1lIHJlcGxhY2UgRElTQVNfVVBEQVRFIGluIHRfZ2VuX2hl
bHBlcl9yYWlzZV9leGNlcHRpb24gYW5kIA0KPiA+IGdlbl9leGNlcHRpb24gd2l0aCB0aGUgbmV3
bHkgYWRkZWQgRElTQVNfTk9SRVRVUk4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW50b25n
IFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT4NCj4gDQo+IEhpOyBJJ20gZ29pbmcgdG8gcGljayB0
aGVzZSB1cCBhbmQgZ2V0IHRoZW0gaW50byBtYXN0ZXIuDQo+IA0KPiBBIGNvdXBsZSBvZiBub3Rl
cyBiZWxvdyBmb3IgaWYgeW91IHBsYW4gdG8gc3VibWl0IG1vcmUgcGF0Y2hlcyB0byBRRU1VIGlu
IGZ1dHVyZTogdGhlc2UgYXJlIHJlYWxseSBqdXN0IG1pbm9yIHdvcmtmbG93IHRoaW5ncywgYnV0
IHRoZXkgZG8gaGVscCBtYWtlIG91ciBsaXZlcyBlYXNpZXIgaW4gZ2V0dGluZyBjb2RlIHN1Ym1p
c3Npb25zIGludG8gdGhlIHRyZWUuDQoNClRoYW5rcyBQZXRlciwgSSB3aWxsIGZvbGxvdyB0aGUg
cHJvY2VzcyB0byBzdWJtaXQgbW9yZSBwYXRjaGVzIHRvIFFFTVUgcHJvamVjdCwgYW5kIEkgcmVh
bGx5IGxlYXJuIGEgbG90ISBUaGFua3MNCg0KPiBJZiBwZW9wbGUgcHJvdmlkZSB5b3Ugd2l0aCBh
IFJldmlld2VkLWJ5OiB0YWcgZm9yIGEgcGF0Y2gsIGFuZCB5b3UgZG9uJ3QgY2hhbmdlIGl0IHdo
ZW4geW91IHNlbmQgb3V0IGFuIHVwZGF0ZWQgdmVyc2lvbiwgaXQncyBoZWxwZnVsIGlmIHlvdSBp
bmNsdWRlIHRoYXQgdGFnIGluIHRoZSBjb21taXQgbWVzc2FnZSBvZiB0aGUgcmV2aXNlZCB2ZXJz
aW9uIHlvdSBzZW5kIG91dC4gVGhpcyBzYXZlcyBwZW9wbGUgaGF2aW5nIHRvIHJlbWVtYmVyIHdo
ZXRoZXIgdGhleSdkIHJldmlld2VkIHNvbWV0aGluZyBvciBub3QsIGFuZCBtZWFucyB0aGF0IHdo
ZW4gYXBwbHlpbmcgSSBkb24ndCBoYXZlIHRvIGdvIGJhY2sgYW5kIGxvb2sgYXQgb2xkIHZlcnNp
b25zIHRvIHNlZSB3aG8gcmV2aWV3ZWQgd2hhdC4NCj4NCj4gUGF0Y2ggc2VyaWVzIGFyZSBtdWNo
IGVhc2llciBmb3Igb3VyIHRvb2xpbmcgdG8gZGVhbCB3aXRoIGlmIHlvdSBzZW5kIHRoZW0gb3V0
IHdpdGggYSBjb3ZlciBsZXR0ZXIgZW1haWwgKGEgMC9uIGVtYWlsIHdoaWNoIGFsbCB0aGUgb3Ro
ZXIgZW1haWxzIGFyZSBmb2xsb3d1cHMgdG87IGdpdCBmb3JtYXQtcGF0Y2ggaGFzIGEgJy0tY292
ZXItbGV0dGVyJyBvcHRpb24gd2hpY2ggd2lsbCBkbyB0aGUgcmlnaHQgdGhpbmcgaGVyZSkuDQo+
IA0KPiBXZSBkb2N1bWVudCB0aGlzIGtpbmQgb2Ygd29ya2Zsb3cgc3R1ZmYgaGVyZToNCj4gaHR0
cHM6Ly93aWtpLnFlbXUub3JnL0NvbnRyaWJ1dGUvU3VibWl0QVBhdGNoDQo+DQo+IHRoYW5rcw0K
PiAtLSBQTU0NCg==

