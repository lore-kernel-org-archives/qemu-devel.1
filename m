Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DB4229EF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sL71n+Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DB4229EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvR1v-0004mN-Eo
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvR1I-00049Q-4p; Tue, 14 Jul 2020 15:55:16 -0400
Received: from mail-eopbgr30117.outbound.protection.outlook.com
 ([40.107.3.117]:59809 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jvR1F-0002KU-E4; Tue, 14 Jul 2020 15:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRN5OMyePog0UZqqfDaAl1tZQnx6WvH4G8jLEFBYU9mtOVn3e1PnUZbzmB1w9hP4AM5nHYkCaQSQdxtlCl0KnzZOF2fdZBPZEMRoMJcYHi+SF1b98F5T1t4WkSFAcvITJqq1m258F59yLE4sRUyvK3wlZZEL9u6jXLq3nf75DnYQPIFUuWwtpxd5I8NbHQhWyxOQU8oVxis7Wp4K7rhaEMlM8ZqMWvjDlECKu8Uvp2E9nk6fLqrB8vddVNtK03R4O8aWRvmK6XIjioS188Igq1eS+C23kekJX1nkTVU5+23LkAIqZ4yuarOy7XEwTHPJghVImH4K8uVrqbeRy2Fd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A/+H9iNnoV8wTGDfzwmSskqsBUMgPYamJYO5Ewqgrk=;
 b=VsNxvQiruKniG7WPXULQF60MEcw6K/fy02WRFhakhaVa9vyxFIrCOcSGJWw1UZ6t3qhzjkx6ycxXMpTE/N214PV9/+PSjJYy0sQTa0B45hpfLR/hBF6Pz1mMuL5wuxLgYoNBt3N8fDmDbDR/aaMmRH5Xwec/3Tn2BhUkUaSjIN12k9Wa+1cQnB0waJqPOY6VvH9AWODFbP+C1R+xuXbTdn2QsUxSQJ+6gisDU+eja5qgrEEOePQyEUS8N3mry/UyvTgoj3XSm8QrkSm5tDC1WT/BPDPqcL+DAV9hwRUImdOnU8hu067x05kWkc8pXYHw/PQiflrRxc6OElknFws98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A/+H9iNnoV8wTGDfzwmSskqsBUMgPYamJYO5Ewqgrk=;
 b=sL71n+VabbbKbNLxLybE246/F903B94lATZsl3yw5XEWe7jBEEjQEElKNMuK9XNBnElzOEr53d/at1GxsYYATZLO4iihtxtAvJwXNNb4RxDEBUf3pB9zJlVhlJrNe8N1u4qiG8XvKV49D9Xnh3EXPQH98PZ1Bh/V/F7yeCoPJv4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2420.eurprd08.prod.outlook.com (2603:10a6:203:9e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 19:55:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 19:55:09 +0000
Subject: Re: [PATCH v6] scripts/simplebench: compare write request performance
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1594741846-475697-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <895cc194-04fd-344a-1fb6-7f17be0f0a30@virtuozzo.com>
 <20200714193652.GD1274972@habkost.net>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <101d76dc-f968-5b56-7bc7-d5c3bd6aaced@virtuozzo.com>
Date: Tue, 14 Jul 2020 22:55:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200714193652.GD1274972@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Tue, 14 Jul 2020 19:55:09 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62daf506-404c-4907-33ab-08d8282fd060
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB24201E9F75ABAC2C2954556BC1610@AM5PR0802MB2420.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOUlex/uvcPmPGX8ftBH9A6bKfqgCeoKqNMpKBoJzRXUAkbFBsLvzS/ximzaqudUc3gI/vNK9zdQmZfghLCzNnVdegD5Bep9zlM+2Nv7gXOTiy5P+uiCEzuTr/aLuZSVHVL1ZpNZquogNTBlrcctrYUsHwjqvw3EttbJqfNGtLbbSosqKN6kERUv1/U4toWUybVke0tbkdlTfjY4UACsj4UBp2lM6RkP3ujeBPBnG6zclNIH6Nm3vR1NLLI9t6I3owASbeqN/vg5BCxIZsczFQuvMcvvgSDkEC7DFaPIzTIwKBIHUo9b++uppYVFUudYIjtx8Tv93MJJsP/T415rEsidgEUxF+l6r+BwVV9KUff5yJ4KAynD67GvzJeetCKz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(66946007)(66556008)(4326008)(558084003)(26005)(66476007)(478600001)(6486002)(107886003)(316002)(16576012)(5660300002)(36756003)(31686004)(2616005)(8936002)(31696002)(52116002)(8676002)(956004)(86362001)(6916009)(186003)(2906002)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ual/SHzmsu7BkcXpYTUFc8+ba4G3dCFekZ1zvJvKElJrpvwzngHh81cjikSup1SAl+ycW3eZTq372ImNGbTGIPBNMZ+ZwDPQU97kG2FWcRWKXfGUiypAAFg+Q36/jZMNDSDrqToEIpr4gMpLCmMti4UXIUOwxBF/y9CIEHOR4zoMa5wuet6ZfF46sqpwCZl5A35adKipg9bNdsi4EhPUzeB631rwkIOqoyw25sVulYyAE4YakkRqIkc8H9siHPBfK18qlJBF6O5uLSRzyjdxcdCWE13C8bkXjOAvEC8G9C8ao1WHMUynC9t3TwO/7XpxqFUMMkx2i9BmIrjCsKdIPGP8Lu3/gSDvHgwxbfb1ZkJ6CUMLhl3UKfubi59VTIwQlx7uzVJBDWaxUKtqRR2l+1hOWrbnmtZC2pDhOIGGKMZqrV3siDHkfj8efMzMhR736u7SjSYfRU+Og7zPy2+3OSzjvl1FdelaGHt19YEHKVajcwaZ3eB3G9ZEMVFzADx6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62daf506-404c-4907-33ab-08d8282fd060
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 19:55:09.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek7EvQv2qAvqxIsjR/zEyAaMyLS8URHzm/jirRXDCem/N3VmS3qVZjhH+56dE7eNIWfXU80PjfnrFdAB6urdCdS9+u5cCAkz6xFkszSOsv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2420
Received-SPF: pass client-ip=40.107.3.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 15:55:11
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.07.2020 22:36, Eduardo Habkost wrote:
> On Tue, Jul 14, 2020 at 07:05:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi Eduardo!
>>
>> Could you please stage this in your branch, to be pulled for 5.2 later?
> Queued, thanks!
> 

Thank you!

-- 
Best regards,
Vladimir

