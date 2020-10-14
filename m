Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 03:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3130620776
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 03:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="GFU35dIb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="ZTcs+9TA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3130620776
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSXNd-00073I-8n
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 23:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kSXLv-0006az-Ss
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 23:21:24 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:20884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kSXLp-0001mG-Pz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 23:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=3716; q=dns/txt; s=iport;
 t=1602645677; x=1603855277;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=db19gz7oqr5Uv4fd7Waqxa6cFR5iFsB9JiiRDOaPUjE=;
 b=GFU35dIbyVbvKxY6nJsUAf4/ykQRw5tajzwQIgR2Pn2FRKnsnX5YI2Od
 5v/N1KTI2/gCEAUWe+mlhEpHqjAIisGLw8NujmuaY0sGewAOK1xYX8d5f
 iHGksK8vSg11B4gsQgFmos8yDXUKpqW40owuh3dx459Az7tVsYE3GbC62 g=;
IronPort-PHdr: =?us-ascii?q?9a23=3AoO/CmBM0knBifnU73Sgl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEvKwz3lvIW4zB7LRDkeWF+6zjWGlV55GHvThCdZFXTB?=
 =?us-ascii?q?YKhI0QmBBoG8+KD0D3bZuIJyw3FchPThlpqne8N0UGHMf4bkfV5Hqo4m1aFh?=
 =?us-ascii?q?D2LwEgIOPzF8bbhNi20Obn/ZrVbk1IiTOxbKk0Ig+xqFDat9Idhs1pLaNixw?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CNCQAoboZf/4sNJK1ggQmBT4FSUQd?=
 =?us-ascii?q?wWS8siAMDjVGBApd5glMDVQsBAQENAQEYCwoCBAEBhEoCggICJTcGDgIDAQE?=
 =?us-ascii?q?LAQEFAQEBAgEGBG2FXAyFcgEBAQMBAREuAQEsCwEECwIBCBEEAQEBHREoCh0?=
 =?us-ascii?q?IAgQBDQUIEweDBYJLAw4gAQ6dOQKBOYhhdIE0gwEBAQWBMwEDAgYBg1sYghA?=
 =?us-ascii?q?DBoE4gnKKRBuCAIERQ4IYBy4+glwBAgKBXAIwgxiCLZMQAYdogRmaTIEKCoJ?=
 =?us-ascii?q?piQKLEIZ7gxWKCJQhkyaBe4h2lTcCBAIEBQIOAQEFgWokgVdwFYMkUBcCDZI?=
 =?us-ascii?q?QhRSFQnQCNQIGAQkBAQMJfI1MAQE?=
X-IronPort-AV: E=Sophos;i="5.77,373,1596499200"; d="scan'208";a="561893144"
Received: from alln-core-6.cisco.com ([173.36.13.139])
 by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 14 Oct 2020 03:21:15 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
 by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 09E3LFbM014054
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
 Wed, 14 Oct 2020 03:21:15 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 13 Oct 2020 22:21:14 -0500
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 13 Oct 2020 22:21:14 -0500
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-002.cisco.com (64.101.210.229) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 13 Oct 2020 23:21:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxKTIZ/0U10EEtcwNWJRt4jzj9UY4bDmkpftiGxsrH6YlZs3r1Ngx+0xb0F6xfJMWmCPlB/Gd/bIIE4823ndpQ1xTMywPfABMvaprB82fmSZD3W8RF9ANIhUxsnMsCEWYUzfXiKjaZTk8gc2SVZM5EqStuDrFrWOZhsfatxWhA2ZJxI9QPypECQppTSyIukCqD5B117rbKe8rkGWcUINDSrqCEkR0aHkPKeKzuAibSqd3WNG1xjQFXfMO/7x7y+HXPCF8SnzcIU0qpikHOg2vG8UMcBLD7OlgCowtuh9v5eU3fEh9nrNNfLBBCJgHVuXRqXHRN8ibxPJGJBJbPt9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O+AlbEmsJvwIhZk6RTrk7IyZMsITygZThdhTZTl4rE=;
 b=IpYkAhaxkpnsnqpjTuh+VIgl0LIq68qNqujA6pBm58HdrkaPWbK28briCcsf9+kplwUEf0M7WdnxedLArqKat1LMM3kKXl/DOUKO1i0x803MHuI4C67W3xNbDVCg9yXkEWt8iyJYBsAP4gfFLbo+J6IhQXPNwYW6r7Q76rfjSwlA+Tz4V+zkMzzCVfHts2oTx2uf63YrizjDNM6QgKVBTFpadxSt/+lVg1G6AgdUAGbB2be64eGIYlCfNvwdD3wmnATuyTA+FYv45ZdP4Tl6yIzZHmPKNWU9mnzChERJq1b5SopU953dnDQ7ggZuvShdrhoQlENHkL8tFvXsEhjfnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com; 
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O+AlbEmsJvwIhZk6RTrk7IyZMsITygZThdhTZTl4rE=;
 b=ZTcs+9TA8PXAlUOFNs6nYMBBBPyegmybgeXRJwWNq1H3MIyUt+rE9K4Q6kOmrufN826FEQ7cLtqE8zHXEJFMege0U+GAp2QWr1knUzPwYE8crWGj8tCf9/MJqgLoE1Eu4JCr01Wp5lMWSGsM0eSrwYzU97Q0MlkdC273Tv8WXzI=
Received: from BYAPR11MB3047.namprd11.prod.outlook.com (2603:10b6:a03:8b::32)
 by BYAPR11MB3783.namprd11.prod.outlook.com (2603:10b6:a03:f5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 03:21:12 +0000
Received: from BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca]) by BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca%3]) with mapi id 15.20.3455.029; Wed, 14 Oct 2020
 03:21:12 +0000
To: Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Khem Raj
 <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>, Aurelien Jarno
 <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
Thread-Topic: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a
 CPU property
Thread-Index: AQHWoWRm6e3gfSLGnk2rivp8VwQya6mWKbQAgAA1SYCAAAaiuA==
Date: Wed, 14 Oct 2020 03:21:12 +0000
Message-ID: <BYAPR11MB3047857A45C625F44F4CF21ACD050@BYAPR11MB3047.namprd11.prod.outlook.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <7b059e2f-b868-82b3-3d96-bd4e93d36368@linaro.org>,
 <b4818cf4-4598-b7ac-a640-145eaab57f7f@linaro.org>
In-Reply-To: <b4818cf4-4598-b7ac-a640-145eaab57f7f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1003::a4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c505542b-0f37-4447-af9a-08d86ff033a7
x-ms-traffictypediagnostic: BYAPR11MB3783:
x-microsoft-antispam-prvs: <BYAPR11MB3783C3AC17B8C41E18161AA4CD050@BYAPR11MB3783.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nj8cXq76vP5KsImUH3ze0uI3Xaa5hDAgmvy5mi6Qd4UF/80oKX3oiEIMvqD5NRQplZ6OcmuUCVGuIUL34QdSlEpi8b9qxKS65JCaAX9/XpyeSvZK5Zcqz9uclzYYQQ1nRsuiUlM/8FE0bt2pVhtoCrc6IHl7ntYPbnBatZ389iYWBkp1fn81LqR4ocoTYTrK5kqkzPCVsJbt/GubF1hRy0sRtSHJzv7JapdHYlIDfPo69c3korQVTCCru+IszSnxpvQXyEi0HUAUbD+5LMmdKdcRcnm7ipZXagWHQbtCUBGn9xDlwcWirs4yqpIFBnZ8uqOFOUmgmy6cyFdFncNboTMKVj3WM0c1RcHQvTZwyjt89cxXLW7XvmnF0PtQLzowun49keDbhOXRd4r54XuE3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3047.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(39860400002)(346002)(136003)(366004)(55016002)(966005)(4326008)(7696005)(478600001)(83080400001)(8676002)(83380400001)(33656002)(6506007)(5660300002)(76116006)(9686003)(53546011)(186003)(71200400001)(52536014)(2906002)(8936002)(86362001)(110136005)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /a7Orjcw7gAy4dQGv8QPrYeufxqxtfH+Q8IyHmaV357D7f6VoMCpJiXEO1DdVlEbqUOJRpEfcggbtk+sz3+f4tPH5LIMh+gPE6xOPIIymN5D3v3uZ9Kdi+almxVlbPjjFWlk/2Bwmn5CZB6TZXBNHThxXlzZsIdCV1Pb/AHAdfm/pUCjEqfPebVDq0Fygrcsw76aApy9aCmFFHADWpIndX5F3M/PnFm+75GrW5zp9KUuJWGSlCSEhUjoSNuCVli0ZNqB92LEsilaefHyr6OyuTHMRjmn5T9Fj74vJemechHMxBQGHZSj6j4C0JIyb2aamQFKbqsxByA5VZXYX9E6s71Hd82Kw4ounsWPkYv2gSCqyJ/IGGRZdc5yqPOjIMvgYTYUeFD7dX2lE3PgJvUtd/MbV1BsHiXCasHnZzjopwpmmxYB8Uu4ySPIdTAh1dCxORYGmKTh6IPkaZG9NHZseDlETIWHa9s5sFlyK3lyTQYsP+oxEvc/ttwsHYcaeVUlgKOVJYNhlQPmdvGXrGGElmkwaz1Wa9gCsArW5T/1zgkQPVT0UNQQ8Iv51Qvg8gK0wYURiDcEN/b2wCrnQQ8dymIYiQlQYNutGmouAEYpro7CG7rJZIjv/nwPYsly3z9r3kGW7ukrKahm+gmO1QZtZhrS/oZyPOO3VmZVaeEmAvg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c505542b-0f37-4447-af9a-08d86ff033a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 03:21:12.0647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4BPPbbW8lnDFJplawLJ9moe1cXa91oyl/ydP2mCEX6Z2y0IVFF5g8KNRGjhrJzIucBxs96+rAjU27open89ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3783
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Received-SPF: pass client-ip=173.37.142.94; envelope-from=kamensky@cisco.com;
 helo=alln-iport-7.cisco.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 23:21:15
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

Hi Richard,=0A=
=0A=
Please forgive my cumbersome mailing agent at work.=0A=
Please look inline for 'victor>' =0A=
=0A=
________________________________________=0A=
From: Richard Henderson <richard.henderson@linaro.org>=0A=
Sent: Tuesday, October 13, 2020 7:22 PM=0A=
To: Philippe Mathieu-Daud=E9; qemu-devel@nongnu.org; Victor Kamensky (kamen=
sky)=0A=
Cc: Aleksandar Rikalo; Khem Raj; Aleksandar Markovic; Richard Purdie; Aurel=
ien Jarno; Richard Henderson=0A=
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a =
CPU property=0A=
=0A=
On 10/13/20 4:11 PM, Richard Henderson wrote:=0A=
> On 10/13/20 6:25 AM, Philippe Mathieu-Daud=E9 wrote:=0A=
>> Yocto developers have expressed interest in running MIPS32=0A=
>> CPU with custom number of TLB:=0A=
>> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html=0A=
>>=0A=
>> Help them by making the number of TLB entries a CPU property,=0A=
>> keeping our set of CPU definitions in sync with real hardware.=0A=
>=0A=
> You mean keeping the 34kf model within qemu in sync, rather than creating=
 a=0A=
> nonsense model that doesn't exist.=0A=
=0A=
victor> Question: do current MIPS "generic" qemu cpu models exist for real=
=0A=
victor> out there? I agree my choice was not ideal, but it is not that outl=
andish=0A=
victor> and IMO somewhat inline with existence of MIPS generic cpu models.=
=0A=
=0A=
> Question: is this cpu parameter useful for anything else?=0A=
=0A=
victor> If you are interested here are my testing numbers of how #TLBs impa=
ct=0A=
victor> user land execution time:=0A=
victor> https://lists.openembedded.org/g/openembedded-core/message/143115=
=0A=
=0A=
> Because the ideal solution for a CI loop is to use one of the mips cpu mo=
dels=0A=
> that has the hw page table walker (CP0C3_PW).  Having qemu being able to =
refill=0A=
> the tlb itself is massively faster.=0A=
>=0A=
> We do not currently implement a mips cpu that has the PW.  When I downloa=
ded=0A=
=0A=
Bah, "mips32 cpu".=0A=
=0A=
We do have the P5600 that does has it, though the code is wrapped up in=0A=
TARGET_MIPS64.  I'll also note that the code could be better placed [*]=0A=
=0A=
> (1) anyone know if the PW incompatible with mips32?=0A=
=0A=
I've since found a copy of the mips32-pra in the wayback machine and have=
=0A=
answered this as "no" -- PW is documented for mips32.=0A=
=0A=
> (2) if not, was there any mips32 hw built with PW=0A=
>     that we could model?=0A=
=0A=
But I still don't know about this.=0A=
=0A=
A further question for the Yocto folks: could you make use of a 64-bit kern=
el=0A=
in testing a 32-bit userspace?=0A=
=0A=
victor> Such test does exist and it is part of CI already, it is dubbed as =
MIPS multi-lib=0A=
victor> tests where on top mips64 kernel tests are run for n64, n32, and o3=
2 MIPS ABIs=0A=
victor> user-land.=0A=
victor> Note mips32 CI in question does cover kernel functionality for exam=
ple=0A=
victor> KLM build and check, SystemTap test, ltp and other kernel operation=
s are tested.=0A=
victor> I.e it does test 32 bit MIPS kernel as well, but user-land is invol=
ved in such=0A=
victor> tests, and as it was described, it is slow compared to other qemu c=
ases.=0A=
=0A=
Thanks,=0A=
Victor=0A=
=0A=
And I guess maybe we should update our recommendations in the docs.  Though=
ts=0A=
on this, Phil?=0A=
=0A=
=0A=
r~=0A=
=0A=
=0A=
[*] Where it is now, it can't be used for gdb (mips_cpu_get_phys_page_debug=
).=0A=
When used there, we should not modify cpu state, i.e. actually insert the P=
TE=0A=
into the MIPS TLB, but we could still make use of the information available=
.=0A=

