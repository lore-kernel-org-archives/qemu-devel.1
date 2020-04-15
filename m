Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93EC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478752076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yc1FWcX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478752076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjLD-0005KB-ES
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cristian.ancuta@intel.com>) id 1jOjKG-00046a-Mt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cristian.ancuta@intel.com>) id 1jOjKE-0000SN-U8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:47:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:41473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cristian.ancuta@intel.com>)
 id 1jOjKD-0000QV-Pn
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:47:38 -0400
IronPort-SDR: sHunO4rbaT5O+u/0S466T87C5TGCJvjHQSg0V01G8NTkqEi5uz3i+UU/TkPj7XQaoU+APQCKtL
 0kw7U9wBaWtg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 07:47:32 -0700
IronPort-SDR: RBmwrDxU+rR/VQFUJvPfthqWpHgpW0p6FnBUTaCTcxFFB7Fs6CByQvqnz3x7NqM5QyhHALa7v3
 d9PbjBeONUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="273638001"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga008.jf.intel.com with ESMTP; 15 Apr 2020 07:47:32 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 07:47:32 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 07:47:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 15 Apr 2020 07:47:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTqs7Guz21P/prqlSF9f7CvLB8nKWkUnNuvinPNi/zOQNw3erTyXS/K8Dns4bOwrPR1hGAOctzljDACRt2U8oRRVYrKGHxQ+DCI4K/hus9WUchJXNyCt2PDZt7zFAM5LWol6OzP5Gqbv4TWV9aeIrwg4zxz3ERfFUntTy64cq4T5wJ0Zq3pKc6jQgQLrnUpyNkie+7Dtaq1rZqTpnxyB4JG1pCu8ESMRFy1l2tMQV+LRrRFxwRfn7FUaN3mY1urQc34hb0M427ODdNahE0TQurRXok6q8CkW6XUbA4t9WjN47SZXI4P8YsEf0BHK5fPyqXnGRtE7t/lWEp5PspmEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSw38EaNhotCq8tofcvqNbb84aUCnhlImF+Dfg+OWdU=;
 b=Y81daV574i6QCGZ/OPMQ/gJfurnYocU5645DIdIrQe8AGR5TsacO5XBwY4TXkDE9jouKZhdNeUascFx+GWIqLOcc6asHyh5j64CvRLIqSbiAtGE6TbmXmg1bsNjbozX+ucNFP+XLQdzIIgC2OT9+9khBYw+ssiWGj4sForDuaXJBPkj+igG2EHwikzOETpabEHaJsBYgjYipWvU7TZWSM0x0hqBYbeKJyh3M2rmo6GoISi2w5YoG2jwKFWwDFSLDOG2hPLHnW7XbBA0DDT3Fzd7+SUGOS3F1IuUG9ZMCAVhQyD+qOFrB/gRbWcVMRNIf6y9eE9IvodWFoWCDocvGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSw38EaNhotCq8tofcvqNbb84aUCnhlImF+Dfg+OWdU=;
 b=yc1FWcX7igeU4bjdrr4RUWWnmY06Px7aJVvkERp8T8LJeMsFj6zveotu5eqehi9+apRT6eLDzmP+Z2rSyNkVOCM16khzy68ibr1td1eagP++RMgkfnFymICPJX4lL/+r+cEMeR6Dr0VSY9SJ7HD75ZJ7mTmQHaHP+MqaahWHzmI=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (2603:10b6:5:19b::16)
 by DM6PR11MB4281.namprd11.prod.outlook.com (2603:10b6:5:204::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 14:47:30 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d46c:b97b:c9cc:c005]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::d46c:b97b:c9cc:c005%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 14:47:30 +0000
From: "Ancuta, Cristian" <cristian.ancuta@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: Qemu system mode emulation for heterogeneous SOC
Thread-Topic: Qemu system mode emulation for heterogeneous SOC
Thread-Index: AdYSoRX9rk1WIYP3T5WiHSq+TxQdbQAYSaEAAAX3ceAABFElgAAB4yDw
Date: Wed, 15 Apr 2020 14:47:30 +0000
Message-ID: <DM6PR11MB3963BC6578738E8AF9114A27F4DB0@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <DM6PR11MB3963D92BC26FB661C7640D61F4DA0@DM6PR11MB3963.namprd11.prod.outlook.com>
 <CAFEAcA9sKn_ZKoN5OmQT2PnZ51xk_6O3+ZS7g3ZU4BwcK4Aytw@mail.gmail.com>
 <DM6PR11MB3963EDAD9124ABE0CFD97FE1F4DB0@DM6PR11MB3963.namprd11.prod.outlook.com>
 <CAFEAcA-fAqqRqm2zpY85oHZNdBGT2+1g8Q2gXGJhosoO=wTqBg@mail.gmail.com>
In-Reply-To: <CAFEAcA-fAqqRqm2zpY85oHZNdBGT2+1g8Q2gXGJhosoO=wTqBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=cristian.ancuta@intel.com; 
x-originating-ip: [134.191.233.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d779ea-7b75-4f8a-1c6f-08d7e14bec9b
x-ms-traffictypediagnostic: DM6PR11MB4281:
x-microsoft-antispam-prvs: <DM6PR11MB42812298AEE91B2E5B68F358F4DB0@DM6PR11MB4281.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(346002)(366004)(39860400002)(376002)(136003)(6506007)(4326008)(33656002)(86362001)(5660300002)(478600001)(9686003)(55016002)(7696005)(2906002)(52536014)(53546011)(71200400001)(316002)(8676002)(6916009)(66556008)(26005)(66476007)(66946007)(81156014)(66446008)(64756008)(186003)(76116006)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StSlDqGKnppcid6RUpiyzXuOnKyRXxpE6KH00ESOye4CFm4fsBBVdjiYYESDLnpPkHx1BXYNm4M68deV58+R9aeznXNd/UUDCW5OGbr812SXarYMyt5AZxk7/GDS2LFccHhXVpR6upKRgtUKrp4yVYu6PKIwiCleqWCXoAEcPbdmQhTKaJNIxuNCy2XsR3SRUE0j5YZlT4NVyPZjhQKWxZLVcCzXXlapw2rqxhOSnaYOnGuLqwb9AeY/JbIO+SiO3XMnRGpSZRsMk6e6ooT2ttGzf9jgV0O7dBa0WXI8rdKxe3I2XIwxWpImdH5u/HpH903JDJd/vkdKREQQTY+SyXZKcKVCBKOexj3NRkc5Ie9EF9k/90Ken7JBnZK8i8SVf8utx4d16bpCB7dv9jTr93ZrXUBxq91o9ahFm6QCc9tQBkZZcoSHZsWUOwMU+udZ
x-ms-exchange-antispam-messagedata: OAR5Ic602Djh6gkLuZKf4FWXlfZgbqO2y4YbahUt8C4GmJxpvzAC8xpDTLYcc80rpL7G3MJbxBSesQLP2d5qbaUf3g6d5By5VDox6G+HLtElIBkNt+1ALlqIloxodPmo1x/4L6KY6qfnRuR245xZ9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d779ea-7b75-4f8a-1c6f-08d7e14bec9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 14:47:30.3760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaOTYCd4E/9ERY57TQimEI92Vh87yzACUQ12Ezc7xxaqzCEzdLgezuXuDF3GLS8+s/vBXE2lxbbXXXHEDumPJ+eTSN27OPvDLK84KCsUR6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4281
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBBbG1vc3QgYWxsIG9mIHRoZXNlIGFyZSAiYWxsIENQVXMgYXJlIGlkZW50aWNhbCBhbmQgc2Vl
IGJhc2ljYWxseSB0aGUgc2FtZSB2aWV3IG9mIHRoZSBzeXN0ZW0iIHNldHVwcyINCk9uIGEgc2Vj
b25kIHRob3VnaHQsIHRoYXQgc2V0dXAgd291bGQgc3VmZmljZSBmb3IgbXkgdXNlIGNhc2UuIEhl
dGVyb2dlbmVvdXMgd2FzIGp1c3QgYSAibmljZSB0byBoYXZlIi4NCg0KVGhhbmtzLA0KQ3Jpc3Rp
YW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE1LCAyMDIw
IDQ6NDAgUE0NClRvOiBBbmN1dGEsIENyaXN0aWFuIDxjcmlzdGlhbi5hbmN1dGFAaW50ZWwuY29t
Pg0KQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDogUmU6IFFlbXUgc3lzdGVtIG1v
ZGUgZW11bGF0aW9uIGZvciBoZXRlcm9nZW5lb3VzIFNPQw0KDQpPbiBXZWQsIDE1IEFwciAyMDIw
IGF0IDE0OjI3LCBBbmN1dGEsIENyaXN0aWFuIDxjcmlzdGlhbi5hbmN1dGFAaW50ZWwuY29tPiB3
cm90ZToNCj4gU28ganVzdCB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBNTUlPIHN0dWZm
IGNvcnJlY3RseSwgdGhlcmUncyBubyB1c2VyIG1vZGUgc3VwcG9ydCBiZWNhdXNlIHVzZXIgbW9k
ZSBhcHBsaWNhdGlvbnMgYXJlIHRhbGtpbmcgdG8gaGFyZHdhcmUgdGhyb3VnaCB0aGUgT1MgZHJp
dmVycyBhbmQgc3lzY2FsbHMgKHdoaWNoIHdvdWxkIHJ1biBpbiBzeXN0ZW0gbW9kZSkgYW55d2F5
Pw0KDQpDb3JyZWN0Lg0KDQo+IEFsc28sIGlzIHRoZXJlIGEgbXVsdGkgY29yZSBib2FyZCBpbiB0
aGUgc291cmNlIHRyZWUgdGhhdCBJIGNvdWxkIGxvb2sgYXQgdG8gZ2V0IG1lIHN0YXJ0ZWQgPw0K
DQpMb3RzOyBhbnkgYm9hcmQgdGhhdCBzZXRzIGl0cyBtYXhfY3B1cyBmaWVsZCB0byBzb21ldGhp
bmcgb3RoZXIgdGhhbiAxLg0KQWxtb3N0IGFsbCBvZiB0aGVzZSBhcmUgImFsbCBDUFVzIGFyZSBp
ZGVudGljYWwgYW5kIHNlZSBiYXNpY2FsbHkgdGhlIHNhbWUgdmlldyBvZiB0aGUgc3lzdGVtIiBz
ZXR1cHMuIEFib3V0IHRoZSBvbmx5IGhldGVyb2dlbm91cyBib2FyZCBJIHRoaW5rIGlzIHhsbngt
emN1MTAyICh3aGljaCBoYXMgc29tZSBBLWNsYXNzIGFuZCBzb21lIFItY2xhc3MgQXJtIGNvcmVz
KS4NCg0KPiBBbmQgaWYgdGhlcmUgaXMsIHdoZW4gZW11bGF0aW5nIG11bHRpcGxlIGd1ZXN0IGNv
cmVzLCBkbyB0aGV5IGVhY2ggZ2V0IHRoZWlyIG93biB0aHJlYWRzLCBvciBhcmUgdGhleSBydW4g
aW4gYSByb3VuZC1yb2JpbiBmYXNoaW9uIG9uIHRoZSBzYW1lIHFlbXUgdGhyZWFkPw0KDQpUaGF0
IGRlcGVuZHMuIEJ5IGRlZmF1bHQsIGlmIHRoaXMgaG9zdC1hbmQtZ3Vlc3QtYXJjaGl0ZWN0dXJl
IGNvbWJpbmF0aW9uIGNhbiBoYW5kbGUgaXQgdGhlbiB3ZSB3aWxsIGNyZWF0ZSBvbmUgaG9zdCB0
aHJlYWQgcGVyIHZDUFUgKHRoZXJlJ3MgYSBjb21tYW5kIGxpbmUgZmxhZyB0byB0dXJuIHRoaXMg
b2ZmLCBJIGZvcmdldCBpdHMgbmFtZSkuIE90aGVyd2lzZSB3ZSBmYWxsIGJhY2sgdG8gb25lIHRo
cmVhZCBhbmQgcm91bmQtcm9iaW4uDQoNCnRoYW5rcw0KLS0gUE1NDQo=

