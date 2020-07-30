Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E65520829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jJVdrVBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E65520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Gjz-0007bf-CK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 18:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k1GjP-0007Ad-0b
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:08:55 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com
 ([40.107.69.120]:50658 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k1GjM-0000iT-N4
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:08:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV8u6x9morv0rpQwwL+1m74iC/6FZKV/Q8NOg1nUeJ2HRUc9vhR0mn7Ph+o8aBzJ/UunHvMQTYg10+lP+5KO3f13ces14rQ6azFl7OP38z1Rh5LowH1HKBs67PFPtdxXDoL4SWwjmsPe3vap7x1f3ixHgVSwo8NsWNc2vatK1dTqkx9nl3lmkQcvgpsNQFG6y78pN9o0ADo7YOxVVyoTEI5iScvT+TOLaI1S0WuEk8x9bLo+7a/6CWLPZRjYiRv3AP47c09FPe+hezD4AnCgZY4+ULADvh9l7i9zjHQCjTtF9LbR0T8DuL1bKgCL2aPZsSclXwk99zKEc7t9DyNffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/O7/6xeslJQEpWWWtqoLirWpiUJhWrUDk+iy7fr9eQ=;
 b=EWTNBGqr+AVdnJQIdJPdZLL6035WKxj8ocZku6hE3hnsvQG4Sw0ym0K07A+Ao94Rvc8jWKnzPzf3y7FJq+GHXpvpoaD5MuAWmsmo2q4U4UsZIpTXtMNm6iEOsLuPUOSpATNYqJ/m2NJGe2ygSiRULaMdUAWt5xbq7rUvHHWvf1WzAKa44KaqwZzPMWQpyrxfTQsDC9rmi2bJzO6R6Yelrhaoe6czBin/Slt+fWgV/bYUJw2EulhySSLfYCcJ0K3EacsShffgiXJd3WWsZzWhOAWBDDxv1z2eC4i+36kBqeXZOXjth5GIrmJcCb9JSwtNotWC7I2Zln8whI1LpuQ5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/O7/6xeslJQEpWWWtqoLirWpiUJhWrUDk+iy7fr9eQ=;
 b=jJVdrVBB3AKvu2/3tc0nnMPhk94nJX2FgmJMZ/EC5wMFfoKvpLegnI/LdveHwPJxFve5Qw3v46pNMnwKqacAttsR5Yc4kHN/MfYXB7lM+oCR/KwcqM3Qkrgk+yg613ya0QdmxNZTWDXRWcTAcdYh2JmcF3QJJliVV/lk3in0vkQ=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1136.namprd21.prod.outlook.com
 (2603:10b6:805:4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.1; Thu, 30 Jul
 2020 21:53:47 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35%8]) with mapi id 15.20.3239.016; Thu, 30 Jul 2020
 21:53:47 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <bonzini@gnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [EXTERNAL] Re: qemu repo lockdown message for a WHPX PR
Thread-Topic: [EXTERNAL] Re: qemu repo lockdown message for a WHPX PR
Thread-Index: AdZlFApWhEK0UloZS9GdU/X2cvsH+AA0sUKAADUxpNA=
Date: Thu, 30 Jul 2020 21:53:47 +0000
Message-ID: <SN4PR2101MB08802D6D26E0B811065DDF36C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <c0ff07b6-87bb-f0da-d345-71e62e6c8ef6@gnu.org>
In-Reply-To: <c0ff07b6-87bb-f0da-d345-71e62e6c8ef6@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gnu.org; dkim=none (message not signed)
 header.d=none;gnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c5c8:1863:df3a:3ff6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edb750ee-e79a-46dc-273b-08d834d3097a
x-ms-traffictypediagnostic: SN6PR2101MB1136:
x-microsoft-antispam-prvs: <SN6PR2101MB1136463DD3F8E0E70ED06E9BC0710@SN6PR2101MB1136.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: da6NWGdP1wYn3QRN8WzN0GtYpWJ+PUxp7q+mBB/AVXUOp1/Xn95ENg9XO1SkBKgsMjpC/A8iZJ4CizIQUFYa44WMHSY/hN1NBDu9uAFxLilSeKdYS7fJgpXoUbtSDJuz2vMcSd4+Xc6MZmxRZS8Kdnb3xya0geK9AZfsleNYQq1aVcMN9/Ur+pkQEwl5FkZktPoKqPBbYdFWdlrbvZzWkW7t/4MOKdR4IGU8vcJJPVQXbeIy7UStufZxyA/zfOL5Vf+IYq6ehwdc6kPsOfD7A2V++nrVEyhlHWhOWYVGVf4WH35d3mBHVE2dDUrKK0IqpZIOOveo73OYmgR/m81P649Eyh+ZDcoBcyHFiSfYEA+/MP9qrf8nJO40MS1ARV4ZDzJWbJbQLkI7FYpm4NrrQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(4326008)(6506007)(8676002)(6916009)(9686003)(82950400001)(478600001)(52536014)(8990500004)(82960400001)(86362001)(7696005)(316002)(186003)(2906002)(8936002)(71200400001)(83380400001)(55016002)(76116006)(66946007)(966005)(10290500003)(33656002)(5660300002)(66476007)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: trEImWtrFIXGJv71i3+DkT16e9ymQElBA+239VPlpdBQY8UFVMJlvVfHcYzeYTujEWjVnf+PEM00hwJfsEpajTZjkMsomQ9And1y9FGNC3ubiInmyXfEdp9Ob9k7q13QZO/0y2VYD0gXaig6WDIDW3wBqbM4cXU38tSWNDmjoAh7Pq/OQTlEG7qAeGw+KG0p3ParCOeySP5q7NyverstY6rBC14va/JU6ORVNgsHC7qeo74/VrN1QnA3ATR7nlqkMw9UUvh/YsQR1X+DT7XC7fOC4hHDHAWyt2zikED2dOOtBrhwAwvda7tR24vHHxVjBqZYSd4HV2GTUyl6mz3oj3nZXz2TphHg4OVxJEwUJwqBp/o/kdhd5Q+8cYRiYT1XlcuNACOYh+Ej8e5+nUHu8CUaqqA0s9KzyCe6UJqzL6HDGRmzep+Mg6bnlrk3nOoOgjQ5RTpEF9SEjM57W9VVI6ovVM5eZujRCwS7KpFV62Ju4dIP95IFT3na7qCJQe6+ldrdm8z/+e1RK/Jj49E516Ahxv/1onp7YPSOBIwql1zV4WGfeuuVkgnc7loPlht9AdBd0RaOSD0ytBwVs9XXZ2IE406bGf5amkYvF8es5M4KqdzpmMtbFBaEp7A/D74PofAVHNrFPn6Q4xoF0JvwEgHOb3w2DrNUzLVT8korBtX2s3SdP4ITVNRfWw4kq4P7d9MnhNpDGhEDGWzf/laLQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb750ee-e79a-46dc-273b-08d834d3097a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 21:53:47.3540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GyCfGdX3RTFah2l/+FKPl+I8zbYZe2BFr9btwMt/BQUFSoqvuc7deuwnRK/o/N/mjeWW0VLXpCEZSVkPi7lvgzUOi4bXnnSTyXtUgb+4zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1136
Received-SPF: pass client-ip=40.107.69.120;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 18:08:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

PiANCj4gSSB3YXMgbm90IHJlZmVycmluZyB0byBnaXRodWIgcHVsbCByZXF1ZXN0cywgYnV0IHJh
dGhlciB0byBhIG1haW50YWluZXINCj4gcHVsbCByZXF1ZXN0LiAgVGhpcyBpcyBhbHNvIHNlbnQg
dG8gdGhlIG1haWxpbmcgbGlzdC4gIFRoZXJlIGlzIG5vDQo+IFFFTVUtc3BlY2lmaWMgZG9jdW1l
bnRhdGlvbiBzaW5jZSBtYWludGFpbmVycyBhcmUgZ2VuZXJhbGx5IGV4cGVyaWVuY2VkDQo+IGVu
b3VnaCB0byBoYXZlIG9ic2VydmVkIGhvdyB0aGVzZSBhcmUgc2VudCwgYnV0IHRoZSBMaW51eCBk
b2N1bWVudGF0aW9uDQo+IG1vcmUgb3IgbGVzcyBhcHBsaWVzOg0KPiBodHRwczovL25hbTA2LnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3d3cua2Vy
bmVsLm9yZyUyRmRvYyUyRmh0bWwlMkZsYXRlc3QlMkZtYWludGFpbmVyJQ0KPiAyRnB1bGwtDQo+
IHJlcXVlc3RzLmh0bWwmYW1wO2RhdGE9MDIlN0MwMSU3Q3N1bmlsbXV0JTQwbWljcm9zb2Z0LmNv
bSU3Q2Y2N2QyNjBiMjU1YTQ1NWNmYTFjMDhkODMzZmRmMzMzJTdDNzJmOTg4YmY4NmYxNDENCj4g
YWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzczMTY1MTMwODk3ODE0NDImYW1wO3NkYXRh
PUtiNFpPTFV4ZnE3a3dyRUNHZHlxS3BlRlg5U25JSFNRY2FrNjRhVkFOWXMlMw0KPiBEJmFtcDty
ZXNlcnZlZD0wDQo+IA0KPiBJbiBhbnkgY2FzZSwgSSBzdXNwZWN0IHRoaXMgbWlzdW5kZXJzdGFu
ZGluZyBpcyBhIHNpZ24gdGhhdCBJIHNob3VsZCBiZQ0KPiBoYW5kbGluZyBXSFBYIHBhdGNoZXMg
Zm9yIHNvbWUgbW9yZSB0aW1lLCB3aGljaCBJIHdpbGwgZ2xhZGx5IGRvLiA6KQ0KPiANCj4gVGhh
bmtzIQ0KPiANCj4gUGFvbG8NClRoYW5rcyBmb3IgdGhlIGxpbmtzLiBJIHRoaW5rIEkgdW5kZXJz
dGFuZCBpdC4gVGhlIGlkZWEgaXMgdG8gaG9zdCBhIHB1YmxpYyBXSFBYIHFlbXUgYnJhbmNoIGlu
IG15IHFlbXUgZ2l0aHViIGZvcmssIGhvc3QNCmFsbCB0aGUgc2lnbmVkLW9mZiBXSFBYIHBhdGNo
ZXMgdGhlcmUgYW5kIGV2ZXJ5IG5vdyBhbmQgdGhlbiwgZ2VuZXJhdGUgYSAncHVsbC1yZXF1ZXN0
JyB0byBtZXJnZSB0aG9zZSBwYXRjaGVzIGJhY2sgdG8gdXBzdHJlYW0uDQpEb2VzIHRoYXQgYWxp
Z24gd2l0aCB0aGUgZXhwZWN0YXRpb24gaGVyZT8NCg==

