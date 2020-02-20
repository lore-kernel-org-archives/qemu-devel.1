Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68579C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3118F207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I1kIRnzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3118F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4kg1-0001Qp-8V
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 07:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4kfO-0000rE-D8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4kfN-0003ln-6A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:10:54 -0500
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:37985 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4kfM-0003kI-Jf; Thu, 20 Feb 2020 07:10:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJwK9ZRgTY5Xfrn3/ebRihg3h+2Qc/YyGQy/l9rWVJFd0JDKHYOKzst9ocbeTfCXXPj79fZTJlJFxCsMJjWItmuvHMSw++HVK2+9HSsIRS+ijfVUwCyQJ4fJjwfZG8WGwu6zhHelC9R/E9m8XQcnGYjx9WZnZef9drdDiKs4x1tlqAXuqewTgWXaZ86HPOX+m0ooMX4YXQusCLgD/scgqwf6W+Wsx2MjO+TumXownySMfvde0IBcbIe8kSRQ/K5vINK0wAqQZPjvBBopm7OxpozrQkBeoxPV3fodvb1260JBM7FnsrM9XZB9mG3ErAePvm/gBXYF8qD1kuviYxyKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHcxBBIU3mHbQD8tJsBEPxGlMNPJkljJFZoJg/mFeoM=;
 b=CgpvjsIMv84SCRX2//H1wMjbr5fBZEKb11bXqs82jM2D0mn8X7G/q6+3Y3ck8KhAkzTbHvxUZb4cEonGYeZ/atEtxZJIxjnfuwx3fI1AmEYY9vc2zOj7RQzyt0Fn5Nvn/VC0CaWJ2c3Pg9PBkEJvZr8WWDZkWGrRtE3mlrI/l9QKBD/2aErKweMsrnSW0lV0Yz7SG0Y6UX763A6lYBNdq+ErnwBeWfzJDhtDHQyEjj0yqmCCDnYR6+wWooopH5Pbp/HtuoPFIL2QIT9RTRQ3n4Ip1SPuVqYbdoAkhp2JUZkYsuJf7LfWDlC19i0PEyUxKNBzszbTffqzqsGK9U1KhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHcxBBIU3mHbQD8tJsBEPxGlMNPJkljJFZoJg/mFeoM=;
 b=I1kIRnzIIUstmilLvWxiWeBmTEFVFB+y5HwiA7ueNeggJoAgM1kOPSsEFUaCxkux+fYXR7KNiO4Mt2sHb1W00RrKvlLt5/CjZpvZVt2iHzYqdKD8qWayMZx+zHko/MaLtKrSIhvvIPnSG1rmFUUP61Yk01KQeyrBee9mH5TSfrk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3653.eurprd08.prod.outlook.com (20.177.115.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Thu, 20 Feb 2020 12:10:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 12:10:49 +0000
Subject: Re: [PATCH v3 0/3] Dump QCOW2 metadata
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1578990137-308222-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <fb4eb1a7-25f7-86ce-4c27-06bca430e97a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200220151047430
Message-ID: <18dea012-49ff-fda5-7450-964c37a9ed1d@virtuozzo.com>
Date: Thu, 20 Feb 2020 15:10:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <fb4eb1a7-25f7-86ce-4c27-06bca430e97a@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR09CA0050.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0050.eurprd09.prod.outlook.com (2603:10a6:7:3c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 12:10:49 +0000
X-Tagtoolbar-Keys: D20200220151047430
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e908c8d-8b8a-4d2f-e19b-08d7b5fdec93
X-MS-TrafficTypeDiagnostic: AM6PR08MB3653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB36536DA229C42CE7F1E6854AC1130@AM6PR08MB3653.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39850400004)(199004)(189003)(26005)(186003)(6486002)(107886003)(4326008)(8676002)(8936002)(956004)(31686004)(5660300002)(2616005)(81166006)(81156014)(16526019)(52116002)(31696002)(16576012)(316002)(110136005)(66946007)(66476007)(36756003)(86362001)(2906002)(53546011)(478600001)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3653;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRPKtoopDRWvtKGFBoB+z4edv4CDVON4pGpSeuPvTEfPTFkeUEKRSCVlHqZG0R6DJuZY3+rsbRRUQPca6R43fWkiq/ktPCPJmYaACvl3XB60zjju7qwmQGmfmoM+ADqujqwnozJzVcorXlZTvEgmVpmHTGmwHt+n95YWT4PQwuDoySMCJv/TVoMaaXIoavwR6kiL+4HzqMAz1799HULfyLrmtwLCN/aThR0TrPMiYqpPFNvemB5H7YsaLk6LyTh6ef+xzjMNBvaXWyMZwW/bHt+RRTCIL6ZSS38OkJ4XWkghuhaEhnCfRSI8tZvb5Ixji9CaQ2gh4GLE5feRHnutxzobDXqOxhlylCtISW4+aRXR08Ms0CJvjsHxrGHMEipXn3ptB8aBGTKVuBlZ+mtDB/pT+Kfen5C8fujpOw/x3xtqYjDUnlgYRAYErHER33YF
X-MS-Exchange-AntiSpam-MessageData: AOkdHh1C7Z7mzu3nbdCHPG0JrjaPbGaMSFvpI+uXR8ibpPowpltGd9n2Ibt9Ix1n4ZF/uE9OOte1/6IteGARlcc4Nyj7reE1usYfYLxUr1nPfwGYSCH8eBVyfNv0qXhk0Owrw2XD6FSzKWGCoIKzQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e908c8d-8b8a-4d2f-e19b-08d7b5fdec93
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 12:10:49.7711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7Lbn9AZPTX3SBV5unK+/S+Y22+b178c/nZ7BlMR8bAEbPXtOB5QRhyfY6cGQs87xsGPTPzophvqdJk0yyIhO7kJg8dn3I6kMP1Pp/V/oqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3653
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.115
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.02.2020 14:58, Max Reitz wrote:
> On 14.01.20 09:22, Andrey Shinkevich wrote:
>> The information about QCOW2 metadata allocations in an image ELF-file is
>> helpful for finding issues with the image data integrity.
>=20
> Sorry that I=92m replying only so late =96 but I don=92t know why we need=
 this
> in qemu, and this cover letter doesn=92t provide a justification.  I mean=
,
> it isn=92t too complex (from the diffstat), but wouldn=92t it be better t=
o
> just have a script for this?
>=20
> I suppose one reason to put it in qemu/qemu-img is that a script
> wouldn=92t be packaged by distributions.  So if a user has a corrupted
> image, with this series we could tell them to run qemu-img check -M and
> put the output somewhere.  With a script, we=92d first have to tell them
> to download the script.  But then again, downloading a script (that
> should be part of the qemu repository) doesn=92t seem too much trouble to
> me either.
>=20
> So I=92m curious as to whether you had a specific reason in mind when you
> decided to implement this as part of qemu itself?
>=20
> (I suppose the additional complexity is fully limited to the check
> infrastructure, so it wouldn=92t interfere with the rest of the qcow2
> driver.  Hm.  Fair enough.)
>=20

Just not to parse qcow2 from scratch. Qemu already can read qcow2, and
it looks through all its structures during check, why not
to add an ability to represent these structures as a qobject?


--=20
Best regards,
Vladimir

