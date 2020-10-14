Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DA3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0642222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Y9t07HkF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="reFba8g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0642222C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnHz-0001uK-8j
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kSnGG-0000rj-Pj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:20:37 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:10799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kSnG8-0000aW-LD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=3398; q=dns/txt; s=iport;
 t=1602706828; x=1603916428;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Mf4I+vaG2/0TtrPvjVtnp5IMdFRbkxixdf8H1m6VnRQ=;
 b=Y9t07HkFVJk3Cou7GfGaKNxWsv6iyz22SP8mjCmK+xkx+Z/uTfUk7Tys
 5cYVZELQZ00lF4TudRIhW03VDPCLI90HHhorCjVBAhhY4NMTRXbrQsYa3
 IZSrLaqH3HdJQhvJOZHqqF6Fn0P0nV0CSkTozGD07yAletmZWdkUQn2Hy k=;
IronPort-PHdr: =?us-ascii?q?9a23=3ASUX/RxQKLD/mTHC5wM6aEEclMtpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBNmJ4vdfgvaQtLrvCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNFTXuXSuqzkIFU?=
 =?us-ascii?q?a3OQ98PO+gHInUgoy+3Pyz/JuGZQJOiXK9bLp+IQ/wox/Ws5wdgJBpLeA6zR?=
 =?us-ascii?q?6arw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B5AABVXIdf/4MNJK1gHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgTwGAQELAYFRUQdwWS8siAMDjVGBAokPjmqBLoElA1ULAQE?=
 =?us-ascii?q?BDQEBJQgCBAEBhEoCggICJTUIDgIDAQELAQEFAQEBAgEGBG2FXAyFcgEBAQE?=
 =?us-ascii?q?BAQESLgEBNwEPAgEIEQQBAQEuIREdCAIEAQ0FCBqDBYJLAw4gAQ6fawKBOYh?=
 =?us-ascii?q?hdIE0gwEBAQWBMwETQYMVDQuCEAMGgTgBgnGKRBuCAIERQ4IYBy4+ghpCAgG?=
 =?us-ascii?q?BXgKDSIItkBuCdwGHa5weVAqCaokEhlyGA4UtgxWKCJQmkymKcYJskkwCBAI?=
 =?us-ascii?q?EBQIOAQEFgVUBOIFXcBWDJFAXAg2OH4NxilZ0AgE1AgYBCQEBAwl8jUwBAQ?=
X-IronPort-AV: E=Sophos;i="5.77,375,1596499200"; d="scan'208";a="576426180"
Received: from alln-core-1.cisco.com ([173.36.13.131])
 by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 14 Oct 2020 20:20:26 +0000
Received: from XCH-RCD-002.cisco.com (xch-rcd-002.cisco.com [173.37.102.12])
 by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 09EKKQj7022621
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
 Wed, 14 Oct 2020 20:20:26 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-RCD-002.cisco.com
 (173.37.102.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 14 Oct 2020 15:20:25 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 14 Oct 2020 15:20:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 14 Oct 2020 15:20:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjPA0mXDJd03ZbsV/WjYuBGbr0PUxG6L1uH81pub45hQiAjtSGr2ohDOQIbXMSpvnOaJ562T0faJZ8+1bALi+T/OFgvMnZQ+u0HUC7VG984iFkub/w/5Kz4sj2fPGE42e/BwSg3LT+qFk54e6Gcfm3gaFdZpG1bu4+BNkAtjODjE3Qsvf+NM0R6B+UjF8R8T6Pqmvu4wj/n57McJM8IH05FozUIiN197NMk80+0WJjKHnj2HbrBm7wdF6qRyuaq4uFX4PrJOxwNeL8/Ubv6r5q/jCc/j9ec+tXPwqIwmG5qMflv7CG1mEQibYH52fQ9DtAze8BqOE4eRhQ9AYZWyTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/Js7oweBX85zDDQqMV4IXrZ+wDWE0sJvgtMA0flc88=;
 b=URvRrZ6jmrRRgL/rkpVlUcp3ow7yBsHZ99F5UqMH6ejcHWbP5vMBi/dKhOJ0Pr8E2EcrvQg6Hp3/cyN4pqppT8PtcjxTZhzU2Rv22c6F3wkKXJ7PnFoRLT4YMaqDCcpBm3tDCDXAYAVZvKkHZNPJakBWvqQf6BYTQTTi1FOx9f32O0VzUoDgwSsLdeAFB9X03TAArCjmNaTqb8Ersmh5vw4coMW+W0KlKg3AF317nODUzzja7zBpjwTvgkosEEdgppjsk4aUaSygJ3yEiJFuirt4mNEBlJx+QilKFLCPUROUBn/077vYdkrD0mloEuojHU6WLUIwxHhPSiL5mPMzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com; 
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/Js7oweBX85zDDQqMV4IXrZ+wDWE0sJvgtMA0flc88=;
 b=reFba8g5vwzZqi5UnEdhaN38LHDjOkBm7A0jk64yJWNdHo+/92BwK9u/dq7M/yy/VUG5ahlvqCIkFPnujEftYWSq3JijPHcwC7kk2pa/6fuTcKg5jA2NXig+MgPC10rs2Af/2IABUu0AzxT0HfVlI7uNs2HszP3RVn22xTByEtA=
Received: from BYAPR11MB3047.namprd11.prod.outlook.com (2603:10b6:a03:8b::32)
 by BY5PR11MB3927.namprd11.prod.outlook.com (2603:10b6:a03:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 14 Oct
 2020 20:20:24 +0000
Received: from BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca]) by BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca%3]) with mapi id 15.20.3455.029; Wed, 14 Oct 2020
 20:20:24 +0000
To: =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, "Richard
 Purdie" <richard.purdie@linuxfoundation.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Khem Raj
 <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
Thread-Topic: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a
 CPU property
Thread-Index: AQHWoWRm6e3gfSLGnk2rivp8VwQya6mWJVfpgACLHgCAAIBJgIAAMsjK
Date: Wed, 14 Oct 2020 20:20:24 +0000
Message-ID: <BYAPR11MB30471BC8B9D3B5F3E678F547CD050@BYAPR11MB3047.namprd11.prod.outlook.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
 <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>,
 <ea0ed6c7-1e3a-f7ee-a962-b471555e362d@amsat.org>
In-Reply-To: <ea0ed6c7-1e3a-f7ee-a962-b471555e362d@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1003::3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fa6a8d0-d170-49a0-5689-08d8707e9541
x-ms-traffictypediagnostic: BY5PR11MB3927:
x-microsoft-antispam-prvs: <BY5PR11MB39279E5F2AF7120B0D69E868CD050@BY5PR11MB3927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SO2XO717wH9o7bo55swmpbtw9DgPOI4tKHHrQg6pFT462p62NsdA52Rng8A9QL1KhzTNkww7BPJoEs98dCvm2sTwclPdphRhKWBdLSKjXzTAv4cv/loDM4d3Puhy01ccl9zN7P0utzdqqeG7UC/mIpd4xgAu0CAWUSSuDVYI7pPuE5TYPcWnMMyaW1Aj6Spha8oNVFamhE4NlVxtx+5U+E/Fpdh2VuNwEqXd2JHg1HFjRixVivK7YR+h/WisTi/acS6guj3ytOIAi5+fSimKCybqP89JNHUhw5575qjCq0rQ2GZYMGsJTFK+A5Et1Xl3o+kgPMj0fs4LVMZW3IXjf1G0lnEt60QIcVzsdcRwsH7ZmV9mZyPFi5n8TWuPsPv2KPJvfiripoR+u/ANfijOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3047.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(4326008)(186003)(478600001)(110136005)(83380400001)(316002)(966005)(4001150100001)(54906003)(55016002)(83080400001)(33656002)(9686003)(8936002)(8676002)(66556008)(66946007)(66446008)(71200400001)(64756008)(7696005)(5660300002)(66476007)(86362001)(53546011)(2906002)(52536014)(6506007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: KCkVySPzgKWttWqaWexeybVyQZUPafq0cdembKa5IBs4FAoDyYBb49gSPBOB5QbAB6Bt8zpsD2ivSJDezvm8YiM5PI5G6ZauoO4w8V4asV83M1CJmr7XmKOOZ3gefYw0L9zr+p8z0GPzihgpw9lTs+kEmlXkWmuVoJqBiQEPoyJrSwGcH5EZjzJnPFPWxf5FrhifOkGglspMEPCjGEMehm5v7YxWXrZwb4XFpAyfgbdLrfqwhBTlYHOWBaiKpxZ7y1hamfl8BS4GYOMrZYgQqkaAuPEcHxpCJ0DbL4ngItCIFTOfOoSCt1ES5coyNt2XIpbeGj4ckr7+9G//o2rt5DCA47kGcd8NcqOKBsPuYGSPt07T76NPaXxWUqUXop2rfUhD6DWoPIy0Tjl7ECKCZ8+i8CWnyzw1hgFVLW2+FuAbYopWzZQiulG8WX8VVdV8qez0ColaLhi4DaL6A7+Fj49ozGP7diTGEuImVgZ2Vfg2mNStbqTjRkoW4Ue6k3nhTqoPaKbbZz3UzOiCAfoZpQAiMCiZwjfpGxWm0pmQ/HD58H+g9qr9Jn6qaKDU3aNaRCcFZUWN5kU8fe8dsIxi/GG/+NlxOs/Lc3D+lqHnvDRO5zJlttENlv1fkSB3xTTp7G9EbYUpRlXELq5wCAc30J/pfm++ev+ZyPuL38dsYFc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa6a8d0-d170-49a0-5689-08d8707e9541
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 20:20:24.3643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULlmGEsQGh6LCBtCbjFlh/oHJomBbvws556xcJ3zkqvoP9/mJjgrSi1Ew5HRbCvIygcTyE9SysoUHRKsAGNv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3927
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.12, xch-rcd-002.cisco.com
X-Outbound-Node: alln-core-1.cisco.com
Received-SPF: pass client-ip=173.37.142.92; envelope-from=kamensky@cisco.com;
 helo=alln-iport-5.cisco.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 16:20:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to: "Victor Kamensky (kamensky)" <kamensky@cisco.com>
From: "Victor Kamensky (kamensky)" via <qemu-devel@nongnu.org>

In order just to keep on the same thread, here is piece of information=0A=
I found:=0A=
=0A=
I looked at "MIPS32=AE 34Kf=99 Processor Core Datasheet" [1]=0A=
=0A=
Page 8 in "Joint TLB (JTLB)" section says:=0A=
=0A=
"The JTLB is a fully associative TLB cache containing 16, 32,=0A=
or 64-dual-entries mapping up to 128 virtual pages to their=0A=
corresponding physical addresses."=0A=
=0A=
So "34Kf-64tlb" cpu model I proposed turns out not to be "fictitious"=0A=
after all. Having 64 TLBs is all within this CPU spec. It is not clear=0A=
why original 34Kf model choose worst case scenario wrt=0A=
TLB numbers. Commit log where 34Kf was introduced does not=0A=
have much details.=0A=
=0A=
So IMO on 34Kf route we have the following choices:=0A=
=0A=
1) I can rephrase commit message and resubmit commit for=0A=
"34Kf-64tlb" cpu model, if it could be merged=0A=
=0A=
2) We can bump up number of TLBs to 64 in existing 34Kf model=0A=
since it is within the spec.=0A=
=0A=
3) Use Phil's series and tlb-entries cpu parameter would cover all=0A=
3 variants of 16,32,64 TLBs allowed by 34Kf data sheet spec.=0A=
=0A=
Please see inline wrt asked '-cpu P5600' testing. Look for 'victor2>'=0A=
=0A=
[1] https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00419-2B-=
34Kf-DTS-01.20.pdf=0A=
=0A=
________________________________________=0A=
From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on behalf=
 of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>=0A=
Sent: Wednesday, October 14, 2020 7:53 AM=0A=
To: Richard Purdie; Victor Kamensky (kamensky); qemu-devel@nongnu.org=0A=
Cc: Aleksandar Rikalo; Khem Raj; Aleksandar Markovic; Aurelien Jarno; Richa=
rd Henderson=0A=
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a =
CPU property=0A=
=0A=
On 10/14/20 9:14 AM, Richard Purdie wrote:=0A=
> On Wed, 2020-10-14 at 01:36 +0000, Victor Kamensky (kamensky) wrote:=0A=
>> Thank you very much for looking at this. I gave a spin to=0A=
>> your 3 patch series in original setup, and as expected with=0A=
>> '-cpu 34Kf,tlb-entries=3D64' option it works great.=0A=
>>=0A=
>> If nobody objects, and your patches could be merged, we=0A=
>> would greatly appreciate it.=0A=
>=0A=
> Speaking as one of the Yocto Project maintainers, this is really=0A=
> helpful for us, thanks!=0A=
>=0A=
> qemumips is one of our slowest platforms for automated testing so this=0A=
> performance improvement helps a lot.=0A=
=0A=
Could you try Richard's suggestion? Using '-cpu P5600' instead?=0A=
It is available in Linux since v5.8.=0A=
=0A=
victor2> I've tried exact image that works on 34Kf and 34Kf-64tlb models=0A=
victor2> image with '-cpu P5600'. it does not boot: it dies in init (system=
d).=0A=
victor2> I can look under gdb with qemu -s -S options, what is going on the=
re=0A=
victor2> but it will take time.=0A=
victor2> If someone have some clues what might cause it please let=0A=
victor2> me know. Here is high level information about setup:=0A=
victor2>    - qemu version is 5.1.0=0A=
victor2>    - kernel base version is 5.8.9=0A=
victor2>    - systemd version is 1_246.6=0A=
victor2>    - user land CPU related build options "-meb -meb -mabi=3D32 -mh=
ard-float -march=3Dmips32r2 -mllsc -mips32r2"=0A=
=0A=
Thanks,=0A=
Victor=0A=
=0A=
>=0A=
> Cheers,=0A=
>=0A=
> Richard=0A=
>=0A=
>=0A=

