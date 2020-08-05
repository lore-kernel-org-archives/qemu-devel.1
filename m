Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91930C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5926C23433
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hGGxrJBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5926C23433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3M2s-0001S2-JV
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3M27-0000nD-LX; Wed, 05 Aug 2020 12:12:52 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:24710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3M24-0008T9-Ke; Wed, 05 Aug 2020 12:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD2XxZaa86yNeYhYTrmFjmZ8y8qrszTjQii+hSvl3PbE3qchjcYytq2BNTBxVDz1PUPRYVZocUJpEoWIhs9y92NFetFFK3L/yUMUNct990pU6UdCdW6JNamZXBcBQM0wD2Tk6VgAIuTJkEWuu6EA0pzvYK0NWK1E0XVQvaW8hhB9/eBkCLhVuwT1RpW7uoLBFn5caD5BLaBXOGp7cec40Q1jhL6p22pdYjHLhS8xaaR+VJkbGMn8vDffi8EDPG2SLkay9x5sJcu4P6r7TSfqYm5qDLkhd4cdSmdimnRU7YryTMxFN7EcLANKfzv6wQciXe11EO+h8HE1ol9okvYgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjM6KBkWTwejrEfRW7XRnZLRcQnCICoh9kyCuD6JrOM=;
 b=MhwhYIVAE2ht+l8xBBNtEd+ylBlRlfC2H1QNHYBbBm9CrSY2jAALezTg91jKdNCSEk64OPkR1+dNEqRV+QOxQ+LzuKHpWJQnrZdgM8Wwt6XtHltom4BS/6umEFexG6FI48EnGI6xfoeE1RPUz2EwRcsxyl5XTKmZLd4683b0gOK528w2xkAq0UZiXRJWod67WaT6lid5flZaWjaY2RX7jQZNt0R96JGf3kpBipn9wjbRcO3BYSBjnPdR+CHpcj/i9qR7/1Jfm0t47shEXTcRDZ1/0vYKUJ3cIyooJ04uXvEPBGUnTJWVMqRfayMocegklylPbaqg4fEUpJ3s+HKo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjM6KBkWTwejrEfRW7XRnZLRcQnCICoh9kyCuD6JrOM=;
 b=hGGxrJBf16eM01dPpUBStrBDRQY4VmtQrR/n7bvh6OU+NJJkOsj20mxfdjgDQDHrNiwcfmmEiiC29wOXF1kq1YZI7bDSlfVE+No2CHpkX5gI9ELmp2u5rXwP/wcQWqK1aOx57uVXmzzj+cVIYtUTya4uOtn2FNTFudwawelx/yc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4914.eurprd08.prod.outlook.com (2603:10a6:20b:cf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 16:12:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 16:12:44 +0000
Subject: Re: [PATCH v12 08/11] qcow2.py: Introduce '-j' key to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-9-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <df6d9d26-48b6-985f-849f-6df0753efa0b@virtuozzo.com>
Date: Wed, 5 Aug 2020 19:12:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596118512-424960-9-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0042.eurprd03.prod.outlook.com (2603:10a6:208::19)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM0PR03CA0042.eurprd03.prod.outlook.com (2603:10a6:208::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Wed, 5 Aug 2020 16:12:43 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92d3bd71-8863-4e40-bc82-08d8395a62a6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4914:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB491479220D2029C88F45BE2AC14B0@AM6PR08MB4914.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sSvJI+LdtiAtgtQOU7s1CVf7J8jmh6iSav76ogtKx1RxESHTs+EhCWNbeZbn7aB6adgvOESlCGtNF7ZzCboTpk4ZdjqcRQIzBZuJ9HyWJTtPistgm9en55Gt+Yk4IrF68gWF3M8CdIpRVghULbPDBgnOkoCTjfluajHS6Q/Tk7HEutTMaRG4j+SFA5NuwLxuCAB11SoDH5BScl+qg/qAZrc9vMIJMjxM7j6VIWjZ4Vmnx8oCK1GKYD9Z0HVjOe3ZoFgaL4l3cQotJqzG3/zLquMR5u5mFmyQduVeoUpcw6lDz/9iLvgC100ER/bW23a0DtG7IAMtUsZOFGfPD3qvAkSmq1PJZ405sdYVvkrxQJt4APjMYK1k8GOQ1pGhUt/a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(186003)(2616005)(26005)(52116002)(4744005)(508600001)(86362001)(5660300002)(16526019)(31696002)(956004)(107886003)(4326008)(2906002)(66556008)(66476007)(66946007)(16576012)(36756003)(8676002)(31686004)(8936002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9mwTr1DeBrW8QxFo2IutMRQqc2Bc298ipCWURGHlc9CiyLN50mgptzwZLJmJHMkApUALPPSu5dlGU2WrX2Pan5bB+gWyVKLgTBByiNDwvDM/cS2AE/fGIMNJvU5To0X8pWm6iFT2VWtChElY6THT26LMSLwJw3iE98CgomszjbSd1Rsrtk9mKeztCxUM2JXX33f63zCD6lR4UbgaCZMYj5iYoOlyJBh5rcrbAijmWzqAhwc2kstTXDfLzhz/QiS1Xb/zL68JwiW08L43k59IGUYV8+ezWP6XgFmez/EqWlP4ZDAqpUK5a0gBddApi+1cP0WJ0En40LrmBaEeY0UTo3fayskjOKkovDbABLLtwBUVsHLrzM+XJH8CRUUzmbUVDTRrBtyMCbBVqO5pco1wITFEXVGSbyihFKl4JJK/yNV/4M/ok9be4/Vgvnp5YoOdETtvbTv+jzKk8WZqQ3pV0os0J03pWmPLmR2lYvksQbQJhRAcDSx/5KlkaPukW7GT4UrHN7c/IezC4DYzYtNlpEpIsDCY98afS4aTCk0otRiSnoJ0ZCOYfb88hVaUUpykowtSY3mmETjysaYMvInHTNBTbjwzvYrS5YviaSmjwYItxsQkvQbWLOj6VADnyNpRtlVh8ktKaYFJhsG2Kw6YyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d3bd71-8863-4e40-bc82-08d8395a62a6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 16:12:43.9084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIPWqHirb5iyUrmcf8K2aKmUr/vpmyDnLueFAWW5lpSLul27MAQjyc6zlxuz032Xt92+MQJbQ7z7eETBGu3D8nZiHiLSIsd3Ob+W0ylSLR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4914
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 12:12:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.07.2020 17:15, Andrey Shinkevich wrote:
> Add the command key to the qcow2.py arguments list to dump QCOW2
> metadata in JSON format. Here is the suggested way to do that. The
> implementation of the dump in JSON format is in the patch that follows.
> 
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

