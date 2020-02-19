Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB12C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889E624654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nlBf13ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 889E624654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PNQ-0005gl-Os
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4PMW-00053m-1T
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4PMV-0003T7-1B
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:25:59 -0500
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:28641 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4PMQ-0003PI-06; Wed, 19 Feb 2020 08:25:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMjdNJVKmNFuS6eOcCxI5GKa5Gz66xg+Vx4AyEZw5LJTZVcBE6/IbmjMD/L0xC0UgK2r2vlwGjNh/Q8MLBjmgG9xEG/tERhlx15dE9M4Us31eTQxvN14qPoWUri7aKTR8pztQSgPN+UDkl5pX9qejCeUj4l8fuKqE9rT66YXZkR7ZHDU9LOFuD8VhLI2VNPvINOsiGulakJvBin5O2z8wpChg8XvVmwXyQpkulQYw1zz0eQ8Njo2+ZUN8p748MK9BTPMmJKbdiYOT7LxsDdAZHa4JJ5MGEmrZ/ugSZ0tNQ0/whJYhK589lfoBs5KX2B7bKpWtqedJG7rU+sbhyGLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5wb2soI0sqaTRygbqg/Sh4FfzaztRSPrXkZM5iciAk=;
 b=lwYUiFDsb6U4rct8S+KAf1glWXPTH2zpfTqIqp4bOGBw6lvb7zdfu4a4EpzXnNpxAOuo1ryHeI1jksCUwXZkQtGnlSKSGHDgK/6cizGxmnzOPQLwIS0D11Twd6cMT8ehhmKooX843FKsWj0EafH4JUI3K+Cz7ad3IGS7KQ71zVm5kaqmIyYhtYACkY/5CbCyad6CQPOomslpn19V5x2m0snZUwiGfLck1WIgQuuOT0a8w0GPgAmiqSFPf51GtYpeTalsZoq4cFIppiRsJZLYAwDNlyveznMfiDbKpP/jwlPZDerNYShI9zhzVs5Ir/PvjRMs5E2dAj7aonIU6mmmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5wb2soI0sqaTRygbqg/Sh4FfzaztRSPrXkZM5iciAk=;
 b=nlBf13otf7Pjg3FVriub0lLgEVBc61W44ZtLjONzB/eOIq/TlfDtGDMWoNEf7BEMFiMCWEe3xwyfwg0ymXFOP5AcxYdJDvQVRWFTSTUJjTEUxFXLtKVDn7hLOPQPF4ZnMp5mEc/jl/HZqtJUz4g2Tk+KMH5jvcEgVWKZWZXl7EQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3141.eurprd08.prod.outlook.com (52.135.166.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 13:25:51 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:25:51 +0000
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <33fa0ba7-714f-c78d-8ca5-1e15dcef5ac4@virtuozzo.com>
 <f44bfdb9-0ddc-3b1a-0279-7e9ebd9f399f@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <b0e67ac9-987b-811e-f0ac-7a9c92a2771a@virtuozzo.com>
Date: Wed, 19 Feb 2020 16:25:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <f44bfdb9-0ddc-3b1a-0279-7e9ebd9f399f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::16)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 13:25:50 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ffe2870-36ed-43e2-fc7b-08d7b53f3d3b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB314131494F99528FC29B6F3FF4100@AM6PR08MB3141.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39850400004)(189003)(199004)(66476007)(66946007)(8676002)(66556008)(2906002)(31696002)(5660300002)(478600001)(86362001)(7416002)(8936002)(81156014)(81166006)(4744005)(4326008)(31686004)(26005)(36756003)(110136005)(6486002)(316002)(54906003)(44832011)(186003)(36916002)(16526019)(956004)(2616005)(16576012)(53546011)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3141;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJzHnKM2ARR0NKfjfyaN6KJ8vARGXDRj0eMTtP2aok8H6Bhkgq3chAoGY2pc/bO0jFA8uJ5KLXX6w5XZIiHVI1Hk2AabAlnjwJclGVLDERU5Q+JqW4FcXzLC6glKeFGWLAr3C79YSc3ElR0Ew+J1KpZNbE8xgH90iULTBO+14mo64Fo/3AuTSNIvul+0Vtnv6RMmUkDf5LMUa4DCIHajP3OdYDY4NgeVIezkEmUHzFHpFD+EAlqBWxgCV97Nm1Q4GHRD8eeJUB/5vYOsfKD6cnLvNMfj+/pQewcBZaAUPzURre67xsbIr0aEsG7dV11EmkQRmYP+yo989/ANIsHoIOaL+WZ11E54eynmFIaD88RReEZ/+1u8PNS7Yk4dBHKn6+b46XZejlm5rwSdtzmMGnioTcrcWczIjqTyZJyD+6gomBvtvXil2H6ZBLL119XF
X-MS-Exchange-AntiSpam-MessageData: tPBgSe9U0e14SD3tWVPu3QkD0Z0HyVpMTFB3V51Nn+Xf0PuUZQoDBmScdJ4m1fs2Oskg/Iyk+pb+ojIoPAb7BpDph6wkZmePYllpfx73CEJpTC6SDqVG1y50ZIEd/Us+eFIeE877mctPGIaF7U6h8g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffe2870-36ed-43e2-fc7b-08d7b53f3d3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 13:25:51.2982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AhdWu33Wzn1rqkdlWu5JdRBWZYpznk3IpUG8M0oJdIngv7/ULdrsVlBPBJU9Y4rfff6y58xiibN0PUYQjl/fUUxh9PxZXAKND098GDg6vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3141
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.107
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 18/02/2020 23:57, Eric Blake wrote:
> On 2/18/20 2:02 PM, Andrey Shinkevich wrote:
>> qemu-iotests:$ ./check -qcow2
>> PASSED
>> (except always failed 261 and 272)
> 
> Have you reported those failures on the threads that introduced those 
> tests?
> 

Not yet unfortunately. I have not investigated the case.
"$ ./check -qcow2 261" dumps

+od: unrecognized option '--endian=big'
+Try 'od --help' for more information.
+od: invalid -N argument '--endian=big'
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': IMGFMT header exceeds 
cluster size

and "$ ./check -qcow2 272" dumps

+od: unrecognized option '--endian=big'
+Try 'od --help' for more information.
+od: invalid -N argument '--endian=big'
+qemu-io: can't open device .../qemu/tests/qemu-iotests/scratch/t.qcow2: 
Image is not in qcow2 format

-- 
With the best regards,
Andrey Shinkevich

