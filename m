Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4437C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AFA20809
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YP7Ek+v+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AFA20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGag-00006Q-Dp
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kKGZt-0007hd-EC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:49:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:20365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kKGZo-0004jP-4e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:49:36 -0400
IronPort-SDR: w3XRKqOYHQJr/bNnKRZbJtlhWmpoFCfAW3lFdpXQBo6OUcf+31nvhyD33qa6YNaDBIb4QVxY5c
 ZVx9UzCn6v8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="148080345"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="148080345"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 00:49:26 -0700
IronPort-SDR: 9nCX0QBD7wheHv1eu8wCeb5Oh8Gi2EnrrFS7M+O97/SHhoZXIMzcfuFe2tiH1LmasACBwrUrlZ
 Cgs8hhB8K+yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="453897790"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga004.jf.intel.com with ESMTP; 21 Sep 2020 00:49:26 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 00:49:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Sep 2020 00:49:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 21 Sep 2020 00:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A20xpvxmheH4rSIbNLuhI/YGWTMzp3fagBU1tA8zlHsppiaTcU2Be1LMkBYaJn/NI4snZmuodpfm+XHo7MDmKsxR0ls2qJgDzjTtyo1Gu6nHSmllTiV8eWsqQEoBl7gdg95hU6278n14ZAFPlXEhm/JNOvrPQDmYXNs1ophSvzBkNXhHS9cmuSS9+Stsq0fnZipj6Bwap0tgFAW86co8nVaaNb+yEALTy94VX4rEF0008w3t1glo5T8pCIkbiKgIcDJ2ccgMosXaBV9AslkhRDbxJdiZCg3Sg1biu+Qa2hCGyC1lcg/l1Mb2iHrS98bme9H1CS2VjKuOmR8XXRgXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zulm6MdFKHEN8ps8yFOFhraDKZWVxyrSPMe8ea8e+NY=;
 b=O4BJCYGAAmPNfScqaBkgT8HdqzNKDevdyUcNkbZGjikDmWXdXXVsUvRStY85C1iIXM6gP5lc7PkoCrlI4aRprZyzNZrXYPqTmv+1G4emw3xawlpv9EVwh81qoBFxVdDdI5qKi0gR6XMt5OUnqJlXSgNyMztpb5Br3wnzacpkgYHKU/4GvMF+w/bhEcDWRnyFPQRYCQtXf5jacFuu9IThegq1qG80Fp4KyhfYpC4IfOFPzrXrfWjEA+DD2gTkXxoPGBqfkpmWWbGVmL9YOX7hp5IIdtvuwZrlBoU4TThd+kkFGXVRzYq0GOmLJ6s4dUYpGkCOop0vVWagdcJ+rvTPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zulm6MdFKHEN8ps8yFOFhraDKZWVxyrSPMe8ea8e+NY=;
 b=YP7Ek+v+X4E2s6V0tR+NZAdUPPANPSoS40dTMNOX6B3ameHd/vhK75HbMJXmr4rll0XMGEegP/njXHxzyE7Se5XrbxdE66ZWq7ZTJuDdc80Eh6dBTqYEjWIUb/8frbbziHBR01kELbDzUjcQKOBWRKAv0adD426QlROemJEMKrY=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1317.namprd11.prod.outlook.com (2603:10b6:903:2f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 07:49:22 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::c9f:501b:232d:893a]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::c9f:501b:232d:893a%5]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 07:49:22 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Topic: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Index: AQHV6xfqjs/57yfCb0eiFZpFzYKOh6hhHEKQgQ8ceoCAA8SvIA==
Date: Mon, 21 Sep 2020 07:49:22 +0000
Message-ID: <CY4PR11MB14473A594C244A5B403ADC26803A0@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
 <20200918220255.GB57321@habkost.net>
In-Reply-To: <20200918220255.GB57321@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 627e5f18-f21f-4874-878a-08d85e02da9b
x-ms-traffictypediagnostic: CY4PR11MB1317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1317F1FFDBBDC395654A9B42803A0@CY4PR11MB1317.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uu9WGgvRH4WG4v2PsIBr7k4voWq0+TEigfQB9clQEoeH8Z8qnW7dtQQwGloRxobtMdt8D6xEuEWGhSrRRpI/l7JhCtR6Pn3quvRqHNUrfgHr++N5mx+fRLPf66hRUSha59Ku+1/zDliz6RZJ7lSpyUn2t8xSFWtN/IVW1VSRfyjeLz/ACDYtTAz6+5E+BXMi+vOP+0i9fhv6JKTwSuflQZEm3RhW9lFigJEgwTGmQSmDBbW2n7nrW5dRHye+9cpA57j3DXNiM308mQM9NAk1FIVeyT64zEic29UPM8FpDAheVbXsGYdQWQH8q94Pbwl/Bn5YGvzldgkdGw60oqteEZxKZUfe3AE+rEEOaLPbivaSvfXBHu5PxX8xaI0T8r2NrErff/KyDRU2YKDSNWRvOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(64756008)(66556008)(66476007)(66946007)(66446008)(71200400001)(76116006)(86362001)(52536014)(966005)(186003)(7696005)(8676002)(6916009)(2906002)(54906003)(8936002)(6506007)(478600001)(316002)(53546011)(26005)(55016002)(9686003)(33656002)(5660300002)(83380400001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /fQORKSkDICZiw1be1Xf1f2t/wpKr/e+H8b07NLiQ8sX+PT6u/0Bz4jQ1BotA20SNSlkIigc9lNkorUUB+HTH3POUCrE4cUFW4Cz0EkTeldi+JrjvL0RiukJfCsHyFFRsvCfV4Tu9CJ/GfUUTr/VyKFMUfV+cm1IikQbWT/5FBIpSk9qM7W1JUECEwJF2ag2XceI7LfAy97y0xyx0Xor+vP8ISyUfSbHzkMcUoN62azFnT1R2ImZO6g142TaXTmg/m/oaaT1ZrcjUAHgwEci/PqhZ3taUgRbOzK9G8pdNlrBwnaigVBbzTWpWE3NetJhyXA4yESgtxdxYLc4jYqiGcv5AA29re/I2uFst4zUJ6WfbMY/vIaaozBerm69C1OdJLsUS9XD/Kc/tdw0gzq/kkySnPEgkeUavqzGr2tzDcCiuRc3ejOSJfLMai/de2sUmrFDMuznVFx3I5SHhR+v/LwUz63+Fao73sWzpO/PeAxdQIyFNfJe4HUyysIUglrBYZzD3pnYvEHYTcGuba+BZtecbk6SorWAKYhlFm4IgYoP1BDQxeTpkhDBLg3Vj+o+qLvHfY3vdQSm76TtT9xga0/vmvg2tXHv0lC1oFYJM9Z9LRNV3K3NrCteaF8IIQfl2miPL5bp81K7mZpfK+p/Xg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627e5f18-f21f-4874-878a-08d85e02da9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 07:49:22.2916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmSvO0nXQtT3j1OajwNnDjSK035474kjGWDPZmhL49M16V71M77zvLiANR3sVC6o3URWzmpLtrIMo0JBfZjjpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1317
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=luwei.kang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:49:27
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
Cc: "Strong, Beeman" <beeman.strong@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRWR1YXJkbywNCiAgICBUaGlzIHBhdGNoIHNldCB3aWxsIHJlbW92ZSBzb21lIGxpbWl0YXRp
b25zIG9mIEludGVsIFBUIENQVUlEIGluZm9ybWF0aW9uLg0KICAgIDEuIFRoZSAiSVAgcGF5bG9h
ZHMiIGZlYXR1cmUgd2lsbCBkaXNhYmxlIHRoZSBJbnRlbCBQVCBpbiBndWVzdHMgYW5kIGl0IHdp
bGwgYmUgY29taW5nIHNvb24uDQogICAgMi4gVG8gbWFrZSB0aGUgbGl2ZSBtaWdyYXRpb24gc2Fm
ZSwgd2Ugc2V0IHRoZSBJbnRlbCBQVCBDUFVJRCBhcyBhIGNvbnN0YW50IHZhbHVlKEljZWxha2Ug
c2VydmVyIENQVUlEKS4gSXQgd2lsbCBtYXNrIG9mZiB0aGUgbmV3IGZlYXR1cmUgb2YgSW50ZWwg
UFQuDQoNCiAgICBBYm91dCB0aGlzIGlzc3VlIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9z
aG93X2J1Zy5jZ2k/aWQ9MTg1Mzk3MiwgSW50ZWwgUFQgaXMgZGlzYWJsZWQgaW4gdGhlIGd1ZXN0
IGJ5IGRlZmF1bHQsIHdlIHNob3VsZCB1c2UgIi1jcHUgSWNlbGFrZS1TZXJ2ZXIsK2ludGVsLXB0
IiB0byBlbmFibGUgdGhlIEludGVsIFBULg0KDQpUaGFua3MsDQpMdXdlaSBLYW5nDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29z
dEByZWRoYXQuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDE5LCAyMDIwIDY6MDMg
QU0NCj4gVG86IEthbmcsIEx1d2VpIDxsdXdlaS5rYW5nQGludGVsLmNvbT4NCj4gQ2M6IHBib256
aW5pQHJlZGhhdC5jb207IHJ0aEB0d2lkZGxlLm5ldDsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBT
dHJvbmcsDQo+IEJlZW1hbiA8YmVlbWFuLnN0cm9uZ0BpbnRlbC5jb20+OyBKaXJpIERlbmVtYXJr
DQo+IDxqZGVuZW1hckByZWRoYXQuY29tPjsgUm9iZXJ0IEhvbyA8cm9iZXJ0Lmh1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzNdIFJlbW92ZSB0aGUgbGltaXRh
dGlvbiBvZiBJbnRlbCBQVCBDUFVJRCBpbmZvDQo+IA0KPiBIaSBMdXdlaSBLYW5nLA0KPiANCj4g
SSB3YXMgbG9va2luZyBmb3IgaW5mbyBvbiBpbnRlbC1wdCBhbmQganVzdCBzYXcgdGhpcyBzZXJp
ZXMsIGFuZCBpdCB3YXMgbmV2ZXINCj4gcmV2aWV3ZWQgb3IgbWVyZ2VkIChzb3JyeSBmb3IgbWlz
c2luZyBpdCEpLiAgSXMgdGhpcyBzdGlsbCB0aGUgYXBwcm9hY2ggd2Ugd2FudCB0bw0KPiBmb2xs
b3cgZm9yIGludGVsLXB0Pw0KPiANCj4gSSdtIENDaW5nIEppcmkgRGVuZW1hcmsgYmVjYXVzZSB0
aGlzIG1pZ2h0IGJlIHJlbGV2YW50IGZvciBhIGxpYnZpcnQgaXNzdWUgcmVsYXRlZA0KPiB0byBp
bnRlbC1wdCB3ZSB3ZXJlIGludmVzdGlnYXRpbmdbMV0uDQo+IA0KPiBbMV0gaHR0cHM6Ly9idWd6
aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xODUzOTcyDQo+IA0KPiANCj4gT24gTW9u
LCBNYXIgMzAsIDIwMjAgYXQgMDk6NTY6MDlBTSArMDAwMCwgS2FuZywgTHV3ZWkgd3JvdGU6DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogS2FuZywgTHV3ZWkg
PGx1d2VpLmthbmdAaW50ZWwuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjUs
IDIwMjAgNTozOCBBTQ0KPiA+ID4gVG86IHBib256aW5pQHJlZGhhdC5jb207IHJ0aEB0d2lkZGxl
Lm5ldDsgZWhhYmtvc3RAcmVkaGF0LmNvbQ0KPiA+ID4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
ZzsgU3Ryb25nLCBCZWVtYW4NCj4gPGJlZW1hbi5zdHJvbmdAaW50ZWwuY29tPjsNCj4gPiA+IEth
bmcsIEx1d2VpIDxsdXdlaS5rYW5nQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2
MSAwLzNdIFJlbW92ZSB0aGUgbGltaXRhdGlvbiBvZiBJbnRlbCBQVCBDUFVJRCBpbmZvDQo+ID4g
Pg0KPiA+ID4gVGhlIEludGVsIFBUIGZlYXR1cmUgaW5jbHVkZXMgc29tZQ0KPiA+ID4gc3ViLWZl
YXR1cmVzKENQVUlELihFQVg9MTRILEVDWD0wSCkpDQo+ID4gPiBhbmQgdGhlc2Ugc3ViLWZlYXR1
cmVzIGFyZSBkaWZmZXJlbnQgb24gZGlmZmVyZW50IEhXIHBsYXRmb3Jtcy4gVG8NCj4gPiA+IG1h
a2UgdGhlIGxpdmUgbWlncmF0aW9uIHNhZmV0eShnZXQgdGhlIHNhbWUgQ1BVSUQgaW5mbyB3aXRo
IHNhbWUgY3B1DQo+ID4gPiBtb2RlbCBvbiBkaWZmZXJlbnQgSFcgcGxhdGZvcm0pLCB0aGUgY3Vy
cmVudCBJbnRlbCBQVCBDUFVJRA0KPiA+ID4gaW5mb3JtYXRpb24gaXMgc2V0IHRvIGEgY29uc3Rh
bnQgdmFsdWUoZnJvbSBJQ0VMQUtFIFNlcnZlcikuDQo+ID4gPg0KPiA+ID4gSXQgd2lsbCBibG9j
ayB0aGUgbmV3IGZlYXR1cmUgaW4gdGhlIGxhdGVyIEhXIHBsYXRmb3JtLiB3aGF0J3MgbW9yZSwN
Cj4gPiA+IHRoZSBzdXBwb3J0IG9mICJJUCBwYXlsb2FkcyIgd2lsbCBkaXNhYmxlIHRoZSBJbnRl
bCBQVCBpbiBLVk0NCj4gPiA+IGd1ZXN0KHBhdGNoIDEpIGJ1dCBpdCB3aWxsIGNvbWUgc29vbi4N
Cj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoc2V0IHJlbW92ZSB0aGlzIGxpbWl0YXRpb24gYW5kIGV4
cG9zZSBhbGwgdGhlIGNhcGFiaWxpdGllcw0KPiA+ID4gdG8gS1ZNIGd1ZXN0LiBBcyBpdCB3aWxs
IGJyZWFrIHRoZSBsaXZlIG1pZ3JhdGlvbiBzYWZlLCBJbnRlbCBQVA0KPiA+ID4gd2lsbCBiZSBt
YXNrZWQgYXMgdW5taWdyYXRhYmxlLg0KPiA+DQo+ID4gUGluZy4NCj4gPg0KPiA+IFRoYW5rcywN
Cj4gPiBMdXdlaSBLYW5nDQo+ID4NCj4gPiA+DQo+ID4gPiBMdXdlaSBLYW5nICgzKToNCj4gPiA+
ICAgaTM4NjogUmVtb3ZlIHRoZSBsaW1pdGF0aW9uIG9mIElQIHBheWxvYWRzIGZvciBJbnRlbCBQ
VA0KPiA+ID4gICBpMzg2OiBSZW1vdmUgdGhlIENQVUlEIGxpbWl0YXRpb24gb2YgSW50ZWwgUFQN
Cj4gPiA+ICAgaTM4NjogTWFyayB0aGUgJ0lOVEVMX1BUJyBDUFVJRCBiaXQgYXMgdW5taWdyYXRh
YmxlDQo+ID4gPg0KPiA+ID4gIHRhcmdldC9pMzg2L2NwdS5jIHwgNjkNCj4gPiA+ICsrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA2NCBkZWxldGlvbnMoLSkNCj4gPiA+DQo+
ID4gPiAtLQ0KPiA+ID4gMS44LjMuMQ0KPiA+DQo+IA0KPiAtLQ0KPiBFZHVhcmRvDQoNCg==

