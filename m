Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242D2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE52520661
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 13:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iAGMl8uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE52520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXp9-0005eT-7w
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 08:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipXnt-0004hj-C2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1ipXnr-0007iR-Ir
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:24:48 -0500
Received: from mail-db3eur04hn2072.outbound.protection.outlook.com
 ([52.101.138.72]:15335 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1ipXnq-0007db-V0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 08:24:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTWbJlUec+tLBCJpwzoqrZO5m1jOJUdmGe7299/Nvfkniw30Nhw2IXtDGlBXZ1EHYpJGyJMJxcIjTNQ/jliJiLMSmp6hGsZIKjO35rdw9h6DK3YBxdIQP8MbuHLIRAkr/NWF7Bhtq/LmDaMJEL1Z/fyGfDf9aaCMcUJDjPMw5Mmoude8P5k3Baua3wN80WbXK2PSQPbJ+sFO0lCD3tumY2nIKmRycus1K/PUtE8kiDCbBkOtG3Wx62Z5iox6Ia+XRHkEOodeMFtBDzSJ7NX0z8Fr+Sfx879GVeEzTfFwffWpsGh2TIAtSocUGp7zzvlkSFEc1r6FXr+hIFQoV+SdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uarWFmiXQi7aLXtlNyqS5GRS9xCij62DreumgefvS24=;
 b=MsjzVxUeCfaUkENivz4doQrnY1+ZqWhD7y8kcqerZ8biuK+VCjjOZKyv5JYOmS0GxiwnbhWcStNyanSThrJ+lUfVMsoSOeKgmjZRVj7lBBxsofT+hkpjrgVQdmOd6FEUpda964s8cIr4loDDZDLYhy3yhQx56LyHXBcIhCF2LL2d6EyZ8MBlKvP7oHyHeTaU7Qcb0Pscc0DjGVpiDBh3q0fxXGCpo/r3ON8N239T94srjiynvUMFSIogtfjsHZ+7YQjWeW+UcFhJthaAHXaN3acf5rzBvPuEe/0irs433/6qA2mFWmIT5fquAa7USos1L3dLH/+ygHj1p9sM8kp9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uarWFmiXQi7aLXtlNyqS5GRS9xCij62DreumgefvS24=;
 b=iAGMl8uHsqngJIpvE4xhK4wGJn0VcZ3idtdwHP4uGyoJWxWz+WchX93ui1AuxOkBGnyfJEuK8J2WcvEygyuXCtyHpbKR1DZgLBRkPaZB+Gk0gAx0EN45Hj4im2rylrY1IcHYSf2m4FkI+q2I0ldBDaFGEp1nHUPqqNHH0Kwo+3Q=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB5392.eurprd08.prod.outlook.com (52.133.245.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 13:24:36 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 13:24:36 +0000
Received: from rkaganb.sw.ru (185.231.240.5) by
 HE1P18901CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Thu, 9 Jan 2020 13:24:35 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Topic: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Thread-Index: AQHVxityEM59bZyv8EecProoJvSi/6fiOPyAgAAFpACAAALigIAAARuAgAAKcgCAAAbbAA==
Date: Thu, 9 Jan 2020 13:24:35 +0000
Message-ID: <20200109132432.GD3147@rkaganb.sw.ru>
References: <20200108135353.75471-1-dgilbert@redhat.com>
 <20200108135353.75471-3-dgilbert@redhat.com>
 <20200109064527-mutt-send-email-mst@kernel.org>
 <20200109120820.GB6795@work-vm>
 <20200109071454-mutt-send-email-mst@kernel.org>
 <20200109122237.GD6795@work-vm> <87r208rdin.fsf@vitty.brq.redhat.com>
In-Reply-To: <87r208rdin.fsf@vitty.brq.redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vitaly Kuznetsov
 <vkuznets@redhat.com>,	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com,	"Michael S. Tsirkin"
 <mst@redhat.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1P18901CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::29) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77a29129-c088-42fa-ef63-08d79507455f
x-ms-traffictypediagnostic: VI1PR08MB5392:|VI1PR08MB5392:|VI1PR08MB5392:
x-microsoft-antispam-prvs: <VI1PR08MB5392DAFAF3EDF453005BF5D4C9390@VI1PR08MB5392.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(366004)(396003)(39840400004)(346002)(136003)(376002)(189003)(199004)(6506007)(52116002)(7696005)(55016002)(26005)(4744005)(8936002)(4326008)(6916009)(16526019)(9686003)(71200400001)(5660300002)(186003)(316002)(66946007)(8676002)(64756008)(66556008)(33656002)(478600001)(36756003)(54906003)(66476007)(66446008)(1076003)(86362001)(2906002)(81166006)(956004)(81156014)(30126003);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB5392;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZTIVtjjz2T23JoJgmA/6s5ueDiE+Uw1p/ShnkNGsApWgqIRPmetxW9Tmn5Fc7mdN+ui4xwnw+ivvGVadz58sT78G+oxlfm9lamd9YrCNhlMjYE4cbcoQxiH8NjBpDWHPkQ+HbC9ZNlPk7Ou+D7S7QheEqtkbRZvurPqjF7aix8nFbSO4mkLmQ2j1IwG02/cbZ+0mDpVzx5ujMHhuzLsCCi5kSDZOQWuiIox/cVKPjlaSFoHDj4I9p0/NxZtQKJsV3RnCvUOH/x5IaOxc5y3uvm0dfarbTYLvvLGtckt5GPnDFGCDmrFUNFmbkk25d7C78mK7dHh9fOUBXlkebJ71xjz07fDMvBel1p1VGPl7d0mDXUuCQsnByrteDnl+7v3cgZLAndDV4Ek1haSYw2/hiiCJuua6sq7IyolZjpYFL7nVHEsqGb0s4idsCST15Q7GHbDhV9TP8y8Q1YaK8TgBNeeQ0Md7ftmTtHr0inphwdQ7zcr1eXDbPoL+eyRZ+dmwYVAqz02OXtdf6TnC6yl7iq4QFeAHEDoxR0VePURW01vC6fKdDh6nPv3u8kyxWFZtDEBGfHhNv3Qg6rJsYemvbzktQgClqv88PLyiEEHCCgQLEAgjQZIQvdSbSzUzc37bq9E6K4Ebej5fKjyWh/3+VETuzK72rGOMEurigVDBZkfNL+LiB/aggjsZD5Ljb9LOuZzy/auNgQgtwJm7fsb7ZDevqua0mAPD9j135aZpE4448B8mGB8tbRKSZ6w/OPkD/WZr+FMkXCeHbSyBhfKlyg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E660905FD227044087C24BA24DE5B5F2@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a29129-c088-42fa-ef63-08d79507455f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 13:24:35.8978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VGj70i98VXmxvFrme8jxBcL39xbIjA9kYfy4Qtlf5DCuf/nnaISUp4qSyXecqjSHWDf7h3N1atNYED/fnqaWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5392
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.138.72
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 02:00:00PM +0100, Vitaly Kuznetsov wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > And I think vhost-user will fail if you have too many sections - and
> > the 16 sections from synic I think will blow the slots available.
> >
> 
> SynIC is percpu, it will allocate two 4k pages for every vCPU the guest
> has so we're potentially looking at hundreds of such regions.

Indeed.

I think my original idea to implement overlay pages word-for-word to the
HyperV spec was a mistake, as it lead to fragmentation and memslot
waste.

I'll look into reworking it without actually mapping extra pages over
the existing RAM, but achieving overlay semantics by just shoving the
*content* of the "overlaid" memory somewhere.

That said, I haven't yet fully understood how the reported issue came
about, and thus whether the proposed approach would resolve it too.

Thanks,
Roman.

