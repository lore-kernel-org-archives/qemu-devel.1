Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA70C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D266206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HJn3SVWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D266206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMcb-0007cS-9H
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGMbp-00070t-5V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jGMbo-0005wu-6d
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:55:13 -0400
Received: from mail-eopbgr00123.outbound.protection.outlook.com
 ([40.107.0.123]:51155 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jGMbl-0005iq-0J; Mon, 23 Mar 2020 08:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEtU2cIL46ufnk9KMYoS2C18Vy3/e3P2E0qXkqK4wtRlsNEgkCYkJAEd75BttCZqfRiAxYKRaWmr7vomgVEeGEoT7/IE6oi4s56Sg1vmaWDUgFwTqpmnFyvA7/vMXfcI7C38sbUpzsTyC8Q/7k084IrNvSIj6IgBmjEgzHVGQSP1vGj8MY8p6e0orNtctGXvJzg50juonrMkAi7YS5iBdLFdMe1mWpoViWgxDZ45Yn9Ztr8dfp+iSSF1zqMKCSPqa4NXkcRcd6hKZ7Y8owOoeuoHtLBHkkzMov9rLxm/ue4RDOjq6d+iNOvmRJNk+h1/A5PlKURZXoX7WGMiAfu5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QgftWDH+pOamCz++0Y0d/249LA6xA217SZs0WfqwzY=;
 b=AiwBEkVeMEJNn5cD6lhr9vlNsY+4OJDXzQdrw/8DWAp3VJHmN0cp9LpVcSDoE9FyDG8lXzFr7QlNpuFm3HObcbctYiNQFLqTA7YYDBgqjnz6L3gd+xoDn9XHThl47m4+y3RnhSHwVOJUKhrP1YuesAsidRtfJL+AOoymqgASmc3tGE1Sor/c4A3zZGfdrvCMv5CYzVVYOZ0eehMOEX7MlmbWLAVZeztxxUGaOKYsU773+YBCA1w5uxHy1lqT6ePUmvQbha60XSrSMwyz/XCnmxCMQ2V9PGivR7xAO0Saq3jm216HMy7Eu/KpUnp66+v4ksZy6OtRbaf+xmJhah7Ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QgftWDH+pOamCz++0Y0d/249LA6xA217SZs0WfqwzY=;
 b=HJn3SVWePP6naI91v3xWlc0LYUcO/26QMhE/+5POq8V1mP6ERv2IrjV/6YGAAbtWH42bLrW/QqxBrdtGlVSLXB+dOhwC0Fos+ExlGqVs5S1j07ujqLdTf09FLzOqddEQMF1rzSFFfrrbWdc3iU5fDUnpt61RAvLsq+8YFJLadSg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.80.91) by
 VI1PR08MB3214.eurprd08.prod.outlook.com (52.133.15.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 12:55:06 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 12:55:06 +0000
Subject: Re: [PATCH v8 3/4] qcow2: add zstd cluster compression
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200321143431.19629-1-dplotnikov@virtuozzo.com>
 <20200321143431.19629-4-dplotnikov@virtuozzo.com>
 <a1830b65-bd38-c458-d382-1f3981355d2e@virtuozzo.com>
 <2914bee8-50b9-2759-7dda-8f5fd39e5fa5@virtuozzo.com>
 <w51369z8cg7.fsf@maestria.local.igalia.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <55f6d94f-100c-fd7f-dbb8-d0b3014017a7@virtuozzo.com>
Date: Mon, 23 Mar 2020 15:55:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <w51369z8cg7.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0363.eurprd05.prod.outlook.com
 (2603:10a6:7:94::22) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:c1::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.255.82.30) by
 HE1PR05CA0363.eurprd05.prod.outlook.com (2603:10a6:7:94::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.21 via Frontend Transport; Mon, 23 Mar 2020 12:55:05 +0000
X-Originating-IP: [94.255.82.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a99fe36-2e28-4a19-1e3f-08d7cf296943
X-MS-TrafficTypeDiagnostic: VI1PR08MB3214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3214CBDB2EB7E443EBE4FDF6CFF00@VI1PR08MB3214.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39850400004)(136003)(396003)(366004)(346002)(199004)(6666004)(52116002)(6486002)(81156014)(86362001)(81166006)(4744005)(8676002)(8936002)(66476007)(66946007)(186003)(66556008)(16526019)(31686004)(26005)(5660300002)(53546011)(956004)(2906002)(110136005)(16576012)(31696002)(2616005)(316002)(36756003)(4326008)(478600001)(107886003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3214;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tybNCCPwTr/NoeY/Bo+IPN8tBtyt0vXxHoQFmU9aSjhxF2NpId1iQtYDjy4qHr4Mor45a15TdIPoFbkgZnpoB/qnULoMSNL59mawuwj68ZkFN1XCUBHa5YnkNvtb6YGQpzKrfjig4fn9LB0py3rW/Mi9rJkg3cpsTMEGhl4G59TrooDUH0m4fJ04LYA/Osa4MO+mgcGwfH+P6fAHn5L+URV/XM9DrgKGXlnHPigJbphiNS8bag3PFW+cDWxOKYZ95qFnuvfjFglmVl29u+jsGWQR2E3j5u0SYdeQU21cnFg8eqeDmuvJWLOjkP6/A+rf2c4Cf++8zTaMbLe5kys3Bn8n8UczMPL+iaBW2RMs6Y4KntNFds+C/r0i0CWorh/xBn/lshavnVoe+1pbD9W9em3TcFrPd3e4Ii7AUNE4SG/IzdRyinrwTWMbWvLm0S6G
X-MS-Exchange-AntiSpam-MessageData: k9bqjWRJxoMA2F1rqPXgD39kLG71+RQIJ0zx1vcIpEsFakWq0i5jFEym/SBseNI1LOlYx22xgpHMvRdFtZX3rtaDxfooH0L9TGSVo3DJpAukbt6tGwVwBouxjsGZbSX2V1J7d8JnANX7e3OsJBdg1Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a99fe36-2e28-4a19-1e3f-08d7cf296943
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 12:55:06.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMSCgMtWSLkds9hYacev6fvzOTCFbLpDzzvuBZ48r2fGS13yKXh0XPaZ7YIE2CMQsp900gpl8g84c/78Wc9IC4XHFxLU7AshZJz16RrP3YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3214
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.123
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
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 23.03.2020 15:47, Alberto Garcia wrote:
> On Mon 23 Mar 2020 11:20:42 AM CET, Denis Plotnikov wrote:
>>> But consider corrupted image: it may contain any data. And we should
>>> not crash because of it. So, we should return error here.
>> If the image is corrupted we can't continue anyway. If we return -EIO
>> on this condition, we need to do some work investigating what has
>> happened.
> Cannot you just mark the image as corrupted and return -EIO ? I also
> don't think that we should crash QEMU because of malformed input data.
>
> Berto
ok, will return -EIO


