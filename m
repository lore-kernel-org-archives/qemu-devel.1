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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE8C43468
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2E3207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sEQaBs3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2E3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyv5g-0005Ds-QA
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyv54-0004Vd-Co; Fri, 24 Jul 2020 06:37:34 -0400
Received: from mail-eopbgr70110.outbound.protection.outlook.com
 ([40.107.7.110]:15475 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jyv4y-000277-IL; Fri, 24 Jul 2020 06:37:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEZMCK3Fe7Ac+W5bq7qLaC1rHgM0M0fnYh3VnX9uCGgoooS7u2HQ9x2RhHqgEOD4BOc8uhCyDCjvodo6sqGeOXQ4izNk8x+GvJLQID69W9W6S/k0Vz+fZROQ8EteyVkiLdTKa1d1M/ABEs70zHLsZbTfgqRXyui64Lmb8N5jdkajGQUlpzrrEMv3Awj3WZNdqEctQ+/RX1SUL6ElutN0V7Tgdt7S+vEaMJfb8pz0Z++vvkBNUDXuvafCb7z5tVa+ba60LfukG4gjUXxpcY5LumHEQVyn/43/L6kDeTnir6F7RQlSV9QoDJp57a9vak8AFVmApQ/P3e+CMlpcGFnGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OAzt5S1FLGqXjh/bK9QppcQHkqJC7CwwyrYZaW0I14=;
 b=QP1FqySCums7vl9u7nSRI27Ou9NjwggdpvcLmQPX/yr/EMcHlWA9iRP07zCTKZiHMByDkT2MFN/yLeaFc3A10+8mX3E97sZA7GSL0v38hzjD2Nx06zvx+wuNtKbGvQW/wTUQcqoX9kawpxoql4ogAY1GGdsTyvearDQTRe+qbpaiLaYZ1M1rvfdI4Ml0QoP1d1ybestflZKwzf37YNVnW6DDpNhM3ieFv2pPHRvp4tyaf6GWT1hMtY9yEtpPQmNijzv27d+YPIglqJFr65v8y8dNU4jqoz0OE2FpHKafla3rKOqDOAaBeKWtFgHU1shnLLWyBwmCaLXAzJhAvf/q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OAzt5S1FLGqXjh/bK9QppcQHkqJC7CwwyrYZaW0I14=;
 b=sEQaBs3bKC0SmGe0Tc8UJSpeH0NZZtHp6zIYSdIPaG514YUdoehSEBtvID+/6sXeFAd3/f6nieRLSO/pGflvkoCEWjoI6wMKnj3E2IPgSM4tS1Joo9Ekgb8t6bf03z4qIqGsNs3UWCcn+GK+j7s3POCh6i4x1H8pmUHYTFeVtdc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3894.eurprd08.prod.outlook.com (2603:10a6:20b:90::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:37:25 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:37:25 +0000
Subject: Re: [PATCH v7 29/47] blockdev: Use CAF in external_snapshot_prepare()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-30-mreitz@redhat.com>
 <f89e95e4-10c8-f5ae-f085-2da4d936c043@virtuozzo.com>
 <3c127508-ca2e-a92d-9caf-da707bfb5d0b@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <6a17e3aa-cf8c-7c39-8edf-1de724016c4c@virtuozzo.com>
Date: Fri, 24 Jul 2020 13:37:22 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <3c127508-ca2e-a92d-9caf-da707bfb5d0b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.82) by
 AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Fri, 24 Jul 2020 10:37:23 +0000
X-Originating-IP: [109.252.114.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844b39b9-f04b-47aa-714f-08d82fbd8e22
X-MS-TrafficTypeDiagnostic: AM6PR08MB3894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3894D9F48C48077DB99B645FF4770@AM6PR08MB3894.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bXy5TQLRdYVNFnH6A3pCPHGcmqGsDcYge635uM4leuQWSUjoQmZyOz6VI3Pay9gX3KsrnwhnfqpmQ9VB7c4lh9CnAcTco/L5BwoE1NCGdD2AuT69OlRUM5li2ZPZIqctP8X+GRvFHct8rJCrHYeTLTLJOAoPo/iC/bxVU8jxnHCDsQFxjoRFmjMymXzh/F6GqcvaRKNv5gJ5UCR+RHt20iBrHSa8CMz0ADF0kn35vFhS/VeCLaXArWyJX8hUA5+D9t2MHIoDgi79v1bT6PFmeMcetOVOuN283xKK94lM2r/+YAY+OuwAXqeGL+k072Arnh+bq5a59WNcrzVYraQY5VFtLpTIU2eURuGu4AydooiqdTSWr8EDRSAgxT0W6qL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(366004)(26005)(6512007)(478600001)(6506007)(316002)(4326008)(53546011)(86362001)(16526019)(186003)(2616005)(83380400001)(31696002)(44832011)(6486002)(66946007)(31686004)(36756003)(8936002)(956004)(2906002)(54906003)(5660300002)(52116002)(8676002)(66556008)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YKVCIWvVsrAObjYRLHjScNwWm0WbeLI+2LeZvxtLMfJKYI4NxFaMbyABKE5OOUOsOEILy9JzxooU21oibvSHjKSGS/1SnjNxwT6qHTXOh0pmaKxDBQLNCDzO/UIbr62OalKi0XoTbgTOWQXxp0+SAR4Ear7eKnqx/39+EXyZiOkoC2Skxt0sCHkSIxP33fRpKrvoAzbKovY5HhT+8aXPTAhOXzrXS5cpLIhyXbLpq7++vI0I00GQxD73PVQViACr/slioEaNU/rsCBgKvWzKcXVcIi+sxUfBB2EtFYpK1ayhihSXZDB8ZIC6wch6xuF5dzEQah+VMln/radQ1ZIDu9ujlPX5Ft8XbKkaIwND+iM1RqIvMsHVKpqkuWLHBm3Xzio3OvnrEAsThIxRCYlo+HNjBelMj7YAtEAa4LYiVs3OJqDxErDQyk8oWF5J0h6tUm1tbgYcMohCvN3yEhNnRsBmnXzfJtxNuIVcleB8ogQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844b39b9-f04b-47aa-714f-08d82fbd8e22
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:37:25.4010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSh5EtlrLgzs465jyC0iPJra1SN3xWDRZQA+PXzX9U2NGiyQ/MKT4S6EEj6dWr+eIp3OXMSYG/YF5ULWkbepo8aXXZey+Rxg4wHH+Dmm7hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3894
Received-SPF: pass client-ip=40.107.7.110;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:37:26
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

On 24.07.2020 12:23, Max Reitz wrote:
> On 20.07.20 18:08, Andrey Shinkevich wrote:
>> On 25.06.2020 18:21, Max Reitz wrote:
>>> This allows us to differentiate between filters and nodes with COW
>>> backing files: Filters cannot be used as overlays at all (for this
>>> function).
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    blockdev.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 1eb0fcdea2..aabe51036d 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -1549,7 +1549,12 @@ static void
>>> external_snapshot_prepare(BlkActionState *common,
>>>            goto out;
>>>        }
>>>    -    if (state->new_bs->backing != NULL) {
>>> +    if (state->new_bs->drv->is_filter) {
>>
>> Is there a chance to get a filter here? If so, is that when a user
>> specifies the file name of such a kind “filter[filter-name]:foo.qcow2”
>> or somehow else?
> It would be with blockdev-snapshot and by specifying a filter for
> @overlay.  Technically that’s already caught by the check whether the
> overlay supports backing images (whether drv->supports_backing is true),
> but we might as well give a nicer error message.
>
> Example:
>
> {"execute":"qmp_capabilities"}
>
> {"execute":"blockdev-add","arguments":
>   {"node-name":"overlay","driver":"copy-on-read",
>    "file":{"driver":"null-co"}}}
>
> {"execute":"blockdev-add","arguments":
>   {"node-name":"base","driver":"null-co"}}
>
> {"execute":"blockdev-snapshot","arguments":
>   {"node":"base","overlay":"overlay"}}
>
> Max
>

Thank you for the example.

Andrey


