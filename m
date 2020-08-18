Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7ABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD64206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WjtbS10U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD64206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89Hy-0004xw-Oi
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k89Gz-0004V5-IG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:36:01 -0400
Received: from mail-dm6nam11on2104.outbound.protection.outlook.com
 ([40.107.223.104]:49338 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k89Gv-0005MT-IK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJBMJp6cjsfQGD2jtwuwCzKyKjokUKVUucsvXNAymOBsh38Q5lC+hN3vt8GIeSMfH7kwCf3hgZUJMskcLvZYy1w82i+IFqJS2Ja+tUW2DFqZw6m8Pht74xSLESqSSyxfH1q7NjNCTKnFYqJDDfxdGilLzMQneh6BLtw+Hj7sOoUp+FdYemNNm9/dmUvL8ZnLFxMd33rDzyToETPGiJwhIM+P/tze56ajm7u+D+bCQ5VKWHaQExV+6MsEADOzu4Zo5nXlQNagv7SdsnAWRhEECwCC5DneIxcmlGlA9tgv0cV5S97fnkaMwicW717f3N95a2wWUOQPcgMNNVkFkGDDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajq19kLfG6fDfxLdgi26zLlxmgMtsmUFQ7HesAArL5A=;
 b=chbHczdPeHEM6jET4xxlq1tPshWQRn9XN7MwuwJKYTwXHPr0Jsm/ct2TjvNuEdUo29XWhpK6KTdnYVxMngVMA2ZXNbbGgq5MfoYv8RXNqZEgoOc/OKPm0InXutD1sj5se8/sZ/ejIV9BHtCXtZpbkfGBM1QSVINuQuwVO8/T37F8iSyIFFWhtoMbMtQ5NQTnVHxHEPgmkVHVvXnP9Eup5Ls4iU9WCS6D9bV1Me2qZAqeDsI/ht6nL6LDeeK4O3j/w0CDE9uiBNo9+I8buODbKHF34oJzF28TCFbznvzbUGQOzWEpaok9AvLtOPi7efSdGm5bJaoiAzd60675XLvSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajq19kLfG6fDfxLdgi26zLlxmgMtsmUFQ7HesAArL5A=;
 b=WjtbS10U/3RE0HG/zNpn5JnTz4PwobpSaT9c9HMr/TZ5FT49AtAqxO/FCQuCbal2eQxcQasXmNdxTs1JrQwNZPUTMds/7PALxND2f3V1OMUgp24U1FMBTEArTp8C67ApVrYEa11q4zGNwb6TOZbh5tXYVMvlCT5BtQ64KiGu6eQ=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB0992.namprd21.prod.outlook.com
 (2603:10b6:805:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.4; Tue, 18 Aug
 2020 21:20:46 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b12a:e7a7:640e:8953%9]) with mapi id 15.20.3326.003; Tue, 18 Aug 2020
 21:20:46 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Stefan Weil <sw@weilnetz.de>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Mike Battista <Mike.Battista@microsoft.com>
CC: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Eduardo
 Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "1879672@bugs.launchpad.net" <1879672@bugs.launchpad.net>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson
 <rth@twiddle.net>
Subject: RE: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX enabled
 binaries
Thread-Index: AQHWZxVKeot30QB7QUymyE/5azx7WKkiVYjwgAPkaYCAAAo9gIAAlicAgACsv4CAAAM7gIAAB7oAgAAFSACAFuSMsA==
Date: Tue, 18 Aug 2020 21:20:45 +0000
Message-ID: <SN4PR2101MB088024FA6D6D3C89998C9BB5C05C0@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
 <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
 <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
 <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <b8afd626-b6ae-d6fa-c8b7-5e5778574c07@redhat.com>
 <82fa39b2-676c-e8c5-72c6-53123983dcda@weilnetz.de>
 <55002560-9741-1e71-85f9-e75d9f0f3bfc@weilnetz.de>
 <fde8dd22-679a-be5e-b36e-d8aeb7e955cc@redhat.com>
 <58f5c48c-cf85-ae2a-ce28-510520c2ae75@weilnetz.de>
 <1eae7ba1-47a2-29f3-9425-aa9d8f617106@redhat.com>
 <7cdc7066-0477-5f8b-9d22-12de97098cfc@weilnetz.de>
In-Reply-To: <7cdc7066-0477-5f8b-9d22-12de97098cfc@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: weilnetz.de; dkim=none (message not signed)
 header.d=none;weilnetz.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:1583:ce33:58ac:34f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9873e688-7811-4402-46f1-08d843bc9270
x-ms-traffictypediagnostic: SN6PR2101MB0992:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB09923E4DD99C2471D22C3D6DC05C0@SN6PR2101MB0992.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+e+2qfOroyG8d6ix9rOY7e0hioFn38rRlDflRLogOCUwRKfdCwN3e8Fopmfakqd3axLKKt6+YUidCn70QCbT6E9QW0Kuu4gBvGzY13jsfKZ7PjEQkRoy3qfYoz7xhkkxb0U3YrLnCIUxovCHhY/1iZ0vQjOWhGo0BcQWXFyHKcDOVjRxaVLqVKJCIqLUCSG9HHgQCRZsvZ4DTx+7J7JnCgyIoGvfEtpRPDBQJpbrD8quUnk+mpCUrthIKkm2qikTZx8XNkG8d48FefXct97Fo99uJOVY8ftRt/Cqwha9vbQnKZHGNNLq+wpDXpQqUPB+0jq8tTIolYGmG/ln7sbEeaYNrQ8uWhJSQ0BTzszLw4StKK/DV7nujKAvJS6d5GGFR+UiDZx3RULRCzXzqiAog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(86362001)(110136005)(66556008)(64756008)(66476007)(10290500003)(966005)(66446008)(8936002)(8676002)(9686003)(4744005)(82960400001)(6506007)(82950400001)(5660300002)(52536014)(76116006)(33656002)(54906003)(478600001)(7696005)(71200400001)(66946007)(83380400001)(6636002)(186003)(8990500004)(7416002)(2906002)(55016002)(4326008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uMae9xOVrluKc6wp6w+satn0zVT4+1CkX+PwKNrSkJjhuIckcQqpWNvVyFwKq0JkmPOR4EVkvlTuqnG+8EHSxZiSpBOk8+kjoT5zjxFMP2pDNj8fKZx3XnLqeyUURUTi8iDmKSa/+wJAezKrtw+UGsmQecvm9o8doBccVNXPsrplc+wEXunaWcjKgwjnte1ohQez0HPdBnZZMtdPZtYJF/6Oae+DHUboM6k5w3eB0GXU1YcAUpxlwgD0M2HAF72fmsZby/FuMwkzUw71IaIjmGpVlyLYJyefk6eL7xyZ4wa8WV1Zvpg2JCcv+YjVjyu1tpd9foQYKuA7TnfHFdUjuueOmzWB+BzXFO+R5ED4DqyuLHAgnEPEzRozgBF2mawPF6HY7XNnEX2QdeeVdNq5FsZZpdMeaOMT8YKFxhtXTZNloMY5nPl2vEltg1p/IUR2ad6ofJwKT/DN95QaasLAOGmSp/s/Yn6DRJp2mTRbGU3PYqbZNUwBErGYc+xOUVfW0oz2hazCmjngOgTys7WQPs66VBcrXRlmBZL3oBMZaVhNBNOHAskeaA6HA+r8hmM6xw4NGgh3g8UYHtSHyznmjjQC7UX/P01jf20f3lgrmHirXXg9wu1jsfMfHrifxS41oNRm678OE/+Rg5cDArd2k5AZ7HqBsUAgx1jt0mlPGXb28sAxMCChk6e0xGgR/T/HcIWOjBL7my4hOyxIG2SE+Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9873e688-7811-4402-46f1-08d843bc9270
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 21:20:46.1810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0BpThSyKeUeJuIm9vdC0tcSTKQRStjFEWyKmmN9sOdNOlhADRe34DVLMwzPdFZXUDB8zHDi2lpvvIAsXgU0jrMIC4qSUmenhckgO2Tkm2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0992
Received-SPF: pass client-ip=40.107.223.104;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 17:35:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+PiBJdCdzIHN0aWxsIHNoYW1lZnVsIHRoYXQgTVMgaXMgZm9yY2luZyBkZXZlbG9wZXJzIHRv
IHdhc3RlIHRpbWUNCj4gPj4gcmV3cml0aW5nIEFQSSBoZWFkZXJzLCBqdXN0IGJlY2F1c2UgdGhl
IE1TIGxlZ2FsIGRlcGFydG1lbnRzIGFyZSBub3QNCj4gPj4gYWJsZSB0byB1bmRlcnN0YW5kIHRo
ZSBuZWVkcyBvZiBPcGVuIFNvdXJjZSBkZXZlbG9wbWVudC4NCj4gPiBUaGVyZSBoYXMgYmUgYSBi
aWcgc3dpdGNoIGZyb20gTWljcm9zb2Z0IHRvd2FyZCBPcGVuIFNvdXJjZSwgSSBhdHRlbmRlZA0K
PiA+IHNvbWUgb2YgdGhlcmUgdGFsayBhdCB0aGUgT3BlbiBTb3VyY2UgU3VtbWl0IGluIDIwMTgu
IE1heWJlIHdlIHNpbXBseQ0KPiA+IGhhdmVuJ3QgY29udGFjdGVkIHRoZSByaWdodCBwZXJzb25z
IHRvIG1ha2UgdGhlIGNoYW5nZXMuLi4/DQo+IA0KPiANCj4gTWF5YmUsIGJ1dCBpdCBpcyBkaWZm
aWN1bHQgdG8gZmluZCB0aGUgcmlnaHQgcGVyc29uIGluIGEgbGFyZ2UgY29tcGFueQ0KPiBsaWtl
IE1TLCBhbmQgbGVnYWwgZGVwYXJ0bWVudHMgYXJlIG9mdGVuIHNvbWVob3cgc3BlY2lhbC4NCj4g
DQo+IEFuZCB5ZXMsIHRoZXkgbGVhcm5lZCB0aGF0IE9wZW4gU291cmNlIGNhbiBoZWxwIHRoZW0g
Zm9yIHRoZWlyIGJ1c2luZXNzLA0KPiB0b28uDQo+IA0KPiBTdGVmYW4NCg0KTWlrZSBCYXR0aXN0
YSBpcyB0aGUgcHJvZ3JhbSBtYW5hZ2VyIG93bmVyIG9mIHRoZSBTREsgbGljZW5zZSBhbmQgc2hv
dWxkIGJlDQphYmxlIHRvIHRha2UvcmVzcG9uZCB0byBhbnkgZmVlZGJhY2sgYWJvdXQgdGhlIFNE
SyBsaWNlbnNpbmcgZm9yIG9wZW4gc291cmNlDQpwcm9qZWN0cyAoSSBoYXZlIGFkZGVkIGhpbSBo
ZXJlKS4gSGUgaGFzIGFsc28gYmVlbiBhZGRlZCB0byBwcmV2aW91cyB0aHJlYWRzDQphYm91dCB0
aGUgbGljZW5zaW5nIGFuZCBpcyBhbHNvIGluY2x1ZGVkIGluIHRoaXMgY29udmVyc2F0aW9uOg0K
aHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8rYnVnLzE4Nzk2NzINCg0KLSBTdW5pbA0K
IA0KDQo=

