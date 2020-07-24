Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E69C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3872A20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fz0iA2fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3872A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuM2-0003eo-H9
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 05:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyuKu-0002ba-Cv; Fri, 24 Jul 2020 05:49:52 -0400
Received: from mail-eopbgr80114.outbound.protection.outlook.com
 ([40.107.8.114]:15677 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyuKp-0002Pc-RF; Fri, 24 Jul 2020 05:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGJIsdmq3efcCPAFj4HPoq+jbnT07Xp5dDnmwaKUo4nAbPIBNry7wRzxQnTy+22gfdQU3hQ4y2xzzlLSn3LNuFLI2FDvt+CUboTqBdjDN5JrSzlmn5yWp5WLYY0Ld1hlMc6+qCYKRJPdDICqhIhN/FpWpliljvhvDTsElRI7WCkZoct58w1pKZliwXBjlyeD22rQ7YHRGP3Ufk/sGbxgNLL5XjNuWUiil/Cb2npWXCgj30Ny5sq9Ii85gyvorGk5ST2hnIVeWDqmy7ZlE/+JyUf1SAbkvMf5PlwfExV6xUzvbrwQm5v8cVcwcJcw6YgTch3/hfyUtvLHV9b56J3x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlIx278EKa/Z1rCkkTluUDucbPO/f4lMllxLTrlEBiI=;
 b=klR4RdLogMDGcSt/oj/FthuDFQdBVP8rt9P2PDdRDEuWaPXdA2/oKgDZu+Vwv/lsj/qDfGP6AM+HxZjm34UkbmpbMcV3vyIWOKmhPE8Ujfx87xMKSU95lJ7GnNHjlsNwPeC+0CAEzCDH/q1t12Jj2Jv7ZstrIhn59M8Tt7ds/pkZO7n/M6+xyRzTsOXm77h3wwmLNxouvnAPEl906/clRDSKp8NtVCbIOIaAoQbgHDCfaXI6qY9q+veu8XsdeeG2JtJW+XKYIrbUQK3SHc4lV37FHB+NBTCSK6SkN90YQcAB3MUK1x2rQSNMolXlgAsmsUQcUhpMmJH34lJdkAmthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlIx278EKa/Z1rCkkTluUDucbPO/f4lMllxLTrlEBiI=;
 b=Fz0iA2fTV8sDqFqmikxPHqYNVQ7aD1SGrVB1mh/32BGJ0NhrgmgemqHUz5tv89JLCyHIHNfHdJrMCfAqnAEDMLsu/7KwQROsWSkHr9P926xgeZS4yPcVtLte2q7gXUmAeLtVEKXF+/atc9vwocA5qfJH+121tYGd4iHIIfAxT08=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4786.eurprd08.prod.outlook.com (2603:10a6:20b:cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 09:49:39 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 09:49:39 +0000
Subject: Re: [PATCH v7 28/47] block/null: Implement
 bdrv_get_allocated_file_size
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-29-mreitz@redhat.com>
 <93f4b62e-78d9-af84-ab1c-95eea55bbc0f@virtuozzo.com>
 <b0c02e56-538e-88e9-33d6-4bb276aa3ed1@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <fa3b2624-b155-450b-5cff-2d41b41463bc@virtuozzo.com>
Date: Fri, 24 Jul 2020 12:49:36 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <b0c02e56-538e-88e9-33d6-4bb276aa3ed1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM4PR0302CA0023.eurprd03.prod.outlook.com (2603:10a6:205:2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Fri, 24 Jul 2020 09:49:37 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96acbdc2-6ec2-40c1-82b0-08d82fb6e1a1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47861F4DDC3D29C332182B94F4770@AM6PR08MB4786.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBrhVH4fXZyNeeUK2egoqU10pbRu2IyrK3WX7+xlLfz4XNRjnbm/IxgZJ4iLCr0NvHnzUhyJ9XK6Ev2l2VkCrJf2HSI4dX9eVHV9UcDVjYz4M4C4RDehpsCRO3LK8UHtX5WrEc/LoxhrL52KUp2/pCGgkMAnUlRzJ9pcB2DFMbKAnHh3+MjyDgwz2xLzbrxr1RpjS89gMUBDkZi7WbKZj5lDhGLx6yoxreIff+FWnNjBfUvZKS3mRgRwlVXcGx1Zc7oLQLH7+BFGBXo+EVS7U59DPb9bCNQssPAb8ul9cTT39JOB5x/nkDL/DVD2nfP0CkqUg3gaSsl9Dms/uzdVE/2jTmOXzpZ/9CF01bGK2LO4TthzZygTPNYZ2X6l+z7c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(8936002)(2906002)(66556008)(52116002)(8676002)(478600001)(53546011)(66476007)(6506007)(66946007)(6512007)(31686004)(4326008)(16526019)(26005)(6486002)(44832011)(5660300002)(186003)(54906003)(956004)(2616005)(31696002)(83380400001)(36756003)(316002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LLWdfWcyLubDr68zD0/Ln3jxEz0JmUNh9jl2GBrfWXBoiYrMGo/uGpjqQ2G7i2uiv2uvq1UzQ76b5yMlJbY4pHIhnmXXsZFfewFN31ewfjAzZyI7u484Q4Z74fFa21jPBJjrfhVzeZcNRVz8tUmrTxY+JNcKGvitZ3BRWDVHEfRNQGUHT96P8M+svO5aXCuuuPnx//N0SCVmYZv5Shmnby27L2SLP5BDyJKtqCPSm6Vo/K8ie0k3yh7i1QfZcyjs5vIUjZopiHKnqrndxXGQQi+S6UAXXosduOL1WRfhFLg8KbIhsBs9VxSdZoST8eEwi0vKoRo3eqIElVLGSImKhhWFsbavyF9PfomZxLpC1QLyK1Vk1lQmQUpla0FLtEpYFNR2W+ySCsRQ+gP+L6+mwQX9lsJgffa5zC4TIgwrh/Zwf+iLTHWv78xPs7Nfg2Ay0xxRnNKb6xjwcenIC/PqZmOrYla8aC1EwH5eAgjcVMK93xxYBdApwgdn10wgBrIi
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96acbdc2-6ec2-40c1-82b0-08d82fb6e1a1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 09:49:39.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OAMbhQ1Fdialql2dQ7pV33Udecr+5fDISJ4FLGaCy8MqtOZyiVV4WP8oe7RL+MLlMzhEp/4TSMR5+lpY8Aj1Mzg3KTWZ2tISFkEJxs2Qy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4786
Received-SPF: pass client-ip=40.107.8.114;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 05:49:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.07.2020 11:58, Max Reitz wrote:
> On 20.07.20 17:10, Andrey Shinkevich wrote:
>> On 25.06.2020 18:21, Max Reitz wrote:
>>> It is trivial, so we might as well do it.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block/null.c               | 7 +++++++
>>>    tests/qemu-iotests/153.out | 2 +-
>>>    tests/qemu-iotests/184.out | 6 ++++--
>>>    3 files changed, 12 insertions(+), 3 deletions(-)
...
>>> diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
>>> index 3deb3cfb94..28b104da89 100644
>>> --- a/tests/qemu-iotests/184.out
>>> +++ b/tests/qemu-iotests/184.out
>>> @@ -29,7 +29,8 @@ Testing:
>>>                "image": {
>>>                    "virtual-size": 1073741824,
>>>                    "filename": "json:{\"throttle-group\": \"group0\",
>>> \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
>>> -                "format": "throttle"
>>> +                "format": "throttle",
>>> +                "actual-size": SIZE
>>
>> If we remove the _filter_generated_node_ids() in the current
>> implementation of the test #184, we will get '"actual-size": 0'. It
>> might be more informative when analyzing the output in 184.out.
> You mean _filter_actual_image_size?  Yeah, why not, it doesn’t seem
> necessary here.
>
> Max
>

Yes Max, you are right, I ment the _filter_actual_image_size. It was my 
copy/paste mistake.

Andrey


