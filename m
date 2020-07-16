Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE4EC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1F32067D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PG9eWNGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzbv-0002B7-0E
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzbJ-0001ez-P4; Thu, 16 Jul 2020 04:50:45 -0400
Received: from mail-eopbgr10136.outbound.protection.outlook.com
 ([40.107.1.136]:65014 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvzbH-0008KW-Di; Thu, 16 Jul 2020 04:50:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A11yDsUhjF+b8u9wzW7ZLvSgJno8AX1ePw4dunVCVlZgVu4IkfNM51dJT/WDA3aH5YR8U0nOWuX0JCmSMh0f86OgStGO30Wi/boJwrOj7uYQTU3/8TMNW0wszKAFLC5Zj07Haoccp6n1ES39+aBY4BYBnLIqGOR5wHLbourY5aNXxAv/MmgKpcxY6fjm/iWRkiuE5ycJjkHUNablqPmuPyGkxfzqobqm/pOJuHuuNrr2CvcJMFRds0GSbLLt4ywXE1cKfJBNCQ2fHJy/yMO1CWQNuzmrKlsp/2ZddW4M3tXfm9CHNQ5qXFGMKsItNkcfybDO9VrhYEpsEjPIZEjlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxx0uWzHJomwebp+MjOLTLfPEbIdmqQZJQaJXZ8FgAM=;
 b=ftx7eSthI7+zMYYHBHpWirWIeBrNdxvPBJ8HiN7K3kmMh491rqLBRYEuBe0472/SOX2tJkhU4cih8CDAoQ98xnWQRnfNjUREc6Rm8lNXqxXZl92bgAinIoE8lh3TYbO3F74CU5bhBiHUsNaq4FwI92oYnVyxyQn+0f/+Tp+UvadeH+5HR9GOzySjTEPqx6Yp5TikBwooGu6rcaLELWYqg9nl7I9czficWgK9fx/m8ndbtadcWVDH0+iDYVTzY+tq2KIt+eujnBjPpCH8h+hNU3iiIjx+SMIgXzezHYnCcsvoDIWegngg1bQ7Pl1bgLgiHXy8sd7VmxZ5UuVVBQzvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxx0uWzHJomwebp+MjOLTLfPEbIdmqQZJQaJXZ8FgAM=;
 b=PG9eWNGEMCB+5rvrgGuj7PaznOVNQTAUygMq3/aGOB6ZK7xMuD/M/an3E6Eh9fV3s05F0PvYgapLNvWeDPt5n+o//PlhmbijszXrHPJ+aWU5zmzUAB/DOh3Tf0AqyZxKs3sLUR9Xtrsq2RRIC4g3Y75sbuMHC/vt8dFtvoLBgcE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2449.eurprd08.prod.outlook.com (2603:10a6:203:9c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 08:50:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 08:50:40 +0000
Subject: Re: [PATCH v10 04/10] qcow2_format.py: dump bitmap flags in human
 readable way.
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fa0f27d9-d307-3ab9-0e11-a9f4e1f66422@virtuozzo.com>
Date: Thu, 16 Jul 2020 11:50:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR10CA0048.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 08:50:39 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b217dbfb-1673-4f15-73ac-08d829655115
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2449108FCD2D523076D105E8C17F0@AM5PR0802MB2449.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: geQ9MBAqF9amxTFaR2iiODuefv+davSx3Vac2gcWTcyZB7D/vgTXuPzG+SYQKLeL+wUba6aWMbpQ7zUu63sxTZ2pl/H4RCSDea0IwteVFbxzKf93FQGGQwla1rDSRG5FfYuc6S58cnrjh/V0SOv1gYo1VEODE2TlcpLiSzsM/aSM3i7vnmnir4Fh1qSQWyXYdTp2Gi4RKyIL72XRBvfOM00LPqeef3Uzr18Mv7/W4sZmmSguVqjdCAX9lqV4qY6Hb+z1+/QWEN+qyq6+OUeF1QNYKB/So/gSU4WSQagdZYSF8AC7EA41V5aOBwQEKY+zFRVGKTpw1EBtaXlkThkJW7/+FFkol4gCrjExg/UMGY3W2rJlOtVBi8305ituIu2N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(4326008)(2906002)(2616005)(16526019)(5660300002)(186003)(86362001)(31696002)(956004)(26005)(8676002)(31686004)(8936002)(4744005)(16576012)(36756003)(316002)(478600001)(66946007)(107886003)(66476007)(66556008)(52116002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SC2yiGKp2E+e7RwEpNYYSYz5lh8SN/Q2Tvy0Bpjiu7mbSoKer2ZR3LJxn9cWF+JioPjCMRUh3XJ4+WdKXbwdcfRxQbaauQ4j0Rv0pd9B/YsaThoaPNV1KF/Bh8t7GyXWGRHxZ8V370F27DUvN+kBruGvwXMsIthIqQ30HPCzmg1rCQJ9vdKbcJhgqaQcK+nfvWlkBJdp5PH7bX8yuYJfEkTrdsfg30efwCd0KTeJHiMd/WjaMMgMe/L1e47F1VZ/OcaqTfXTZe8Ltg6UUnfzT/ZL0BA8u16NJ5y02gC0IUl4YvwYQKsfYVFtf5TSte9vDz2wF8+pLVydpWEs4wNS/pV1ncC5v1t6peoUd7JrTYdn7UsRZF70pfYNJrEAdnS7leQg14cd8HoqTMfsqb5XxhzlOe15YPftevPrcNGqo09GdkhQTOKxvYAM6nv5DLqhPtt4GI6c2Rz314GGmf6achwc+gEg3IQrh0u0MES+othJig6mmrAQnxf4Vd+5khP5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b217dbfb-1673-4f15-73ac-08d829655115
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 08:50:40.2706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LvMYC3kxL7WY8mHwAF/mcrimZXl57XPTr4K0OUsaMUGKMgRMFcl3ZxvjQGRMmzS6k/I6V5tcCwX870+Z/BZCWDxNU4et9yjYWdF7TZ1J1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2449
Received-SPF: pass client-ip=40.107.1.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:50:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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

14.07.2020 00:36, Andrey Shinkevich wrote:
> Introduce the class BitmapFlags that parses a bitmap flags mask.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

