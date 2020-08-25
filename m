Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A525C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26032068E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 11:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Q9YAjPvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26032068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWgb-0001Qk-47
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 07:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kAWff-0000gn-U1; Tue, 25 Aug 2020 06:59:19 -0400
Received: from mail-eopbgr80133.outbound.protection.outlook.com
 ([40.107.8.133]:56961 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kAWfc-0002UJ-Ga; Tue, 25 Aug 2020 06:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXUou18TbAzGMn9ndB5pyLau1F7RWO8x+fjeSon7zAqMulbkjlntnmd01mC46O5M4RY5ucuFliK9MWB/zDyjhASk61M/hf2pZXmLgTcAdEkGUGebFvRWkkoIK6NiMbP7ez5Yq9T/MvtknYWi9rg66CwFpLn7zH8lnWXLO2ao9myjthUwfqfOByhze1x/S3eAAdPtyyyWFEJpb8GF//UTE5yRmPcFwJKTA7I7Ql4dL+5M6yxp1midOxhQ8A1FfXWiRS11Afm+04Ms3+zjH4LQLws/Ir7pnxBAcaf0HPpsbVXgO6lCca0iOx3zVvN2OGEAd943UBnOx69RiQFh+mKqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THG3imiPJkexuf4ixzQL3rbq0IIZsfb8nAseAM1xzFE=;
 b=b8FS+nSwcQxYg/M26AgMnjLl/2avI3u5UjjwYklc9dnqgcf2F4rf+vyt2q92GoMhn74GJMuI3likdgtSMExop5G/Zuu+kXkb8Tgzy6JXamowvC4OXcsReKOAjPvPxpzrArQhqAYqlqf9DwCtECuIT/o9qGOKXfnj+aSpFPN3H/YvwY4sV9Na2nYnCWKWlsuUTqq/E1PQ+ikkA59TRbwHQi2niIU3IdpsdEOt+6lF3d51o0szaljlsOtpayqqJFBXQRYsQAmjrSrkm4z4yIyYemUuE6MCgGOJVSnGbkS6tzjolLs0elLeT5YvhOp+xbJFWqDOmMEIPQHa4ZYqs1NTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THG3imiPJkexuf4ixzQL3rbq0IIZsfb8nAseAM1xzFE=;
 b=Q9YAjPvbffsSPHVs1BSINNzymXNF7yWtFQgN5VahSVqdzB1PROZSEqKjacV3PE+O2vsiDWeQ96x+vlIw+fvH3LvXK2FyDZlyiIAQQZlNksZZ6QkBVJMtoV1ZNg2AUbFSo2VmwfNCFDwzjWn+2lw+UepJaxrKYRqx5NYKYpZtO8g=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2316.eurprd08.prod.outlook.com (2603:10a6:3:cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 10:59:10 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 10:59:10 +0000
Subject: Re: [PATCH v7 3/4] qapi: add filter-node-name to block-stream
To: Markus Armbruster <armbru@redhat.com>
References: <1598257914-887267-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598257914-887267-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87364bi62t.fsf@dusky.pond.sub.org>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <c5252d1e-499d-780f-9eea-4272e28cfcc5@virtuozzo.com>
Date: Tue, 25 Aug 2020 13:59:07 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <87364bi62t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::48) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR10CA0095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 10:59:09 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea4668ac-24dc-4a8e-868c-08d848e5e4eb
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB23163C00A1375AF3CB9130D4F4570@HE1PR0802MB2316.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DdYft2bqjoMJoVuJbae3tyufp90aUVNv1bpapsNJqx2C5lM9E99j73ruJpkUhF5IGyupz86bieqUN3bxQa2KRtwFg3VDFlW5vDScaMfpfCM2AHUrknZXScCM96I59vCg04Cna3I7nB2L52VahLg0u5wvPxWwk8WVlSCNte2RuG+tfOiHlCDzeBS62lRR9sUv8ZSAh/lql7mM/bcJwjtgO2qNTDJ7YMdtRZEtqoVru5fBf0BzhlKIzpuCaKqgRISRzbf5rgJltenmpOkXQKZ5DPhe/n1vfJl2gyUvleQTpZkeA6rGc4L5Eq37hmMyNXkUQtcZxDNPHFUM90xw6s+1WW8PYOIzr3d2lKC4M0v+d/HY5/tQ33dOKvdnTsCJ515
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(478600001)(4326008)(66476007)(86362001)(83380400001)(31696002)(316002)(66556008)(36756003)(66946007)(8676002)(8936002)(6486002)(2906002)(6512007)(16526019)(44832011)(52116002)(186003)(956004)(53546011)(6506007)(26005)(5660300002)(6916009)(31686004)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bN/rYYD151DPf4AVdd/1CsMcg/qEP/aO97jaWN1nTlx8J1wrg2YmtygWp9C+r/lY5PtNxqglO46Pg7XQsGJAuM8qZLR53MY0tu619yaKShecnsul9mfcnZGlRrSLqCZejrlnVNv1J3WpOx6yZ/yCxFwDSBy1TkZTWRgeJyjK5HlUaxrzEF+PeBZki5ZmlFkiNHW9YxM+nwpjPwqQtiX9/L1I7F3yqJSAwxAR9Ss1gXVqSIXF8F8b2GZ5+Cy29b/nrZ+XOxIRztpUAoJszG3Wf4BbJKA5r03LOLQgT9WGrEDGhlThj8gUW0Hgz1JMxndqYWfCM2QTeJdZKspDs2Zo2E1de9CpVd1OzBFReiPLPYd8OJyGvqHvl3RlVU+hj5ZQqduIDV98FjxyGXvfMd0ErVJz6h/0SBThqx1Mo8cD0cAi+C7veMU86rQjyYXFc8qWLWb4CLgLNAijOQOVe8IvQ8XdoVFloOBpEr1htJaCdt8MgZkBjQs21Gkn+V8LifKxXJ0aNAV3njcNb8SPdwy4YQN9NWVKPpIGmMt3eXvG8JoB1uIWnSAq66Kl6QUHVKirqw75JKTqPXlohAzGzun8K1lTW3awut9GHtQ3UOqeTbqTq92AsGhXsDoFyvVBYFOtAF6+AgbbUlpOsRy8WXsVPw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4668ac-24dc-4a8e-868c-08d848e5e4eb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 10:59:10.1575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgwTuZXFl/arM9VRYo9ebKZo7m/yiRQjrMQAPZrFncDqFgOjsj96SBnlc1fr0wlcz2fhnKc4yT+pkL1VGksrp3Iq1ARjFUz+x2ictG38TV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2316
Received-SPF: pass client-ip=40.107.8.133;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:59:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.08.2020 09:37, Markus Armbruster wrote:
> Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:
>
>> Provide the possibility to pass the 'filter-node-name' parameter to the
>> block-stream job as it is done for the commit block job.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [...]
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0b8ccd3..1db6ce1 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2524,6 +2524,11 @@
>>   #            'stop' and 'enospc' can only be used if the block device
>>   #            supports io-status (see BlockInfo).  Since 1.3.
>>   #
>> +# @filter-node-name: the node name that should be assigned to the
>> +#                    filter driver that the stream job inserts into the graph
>> +#                    above @device. If this option is not given, a node name is
>> +#                    autogenerated. (Since: 5.1)
> It's (Since: 5.2) now.


Well noted, Markus, thank you.

Andrey


>
>> +#
>>   # @auto-finalize: When false, this job will wait in a PENDING state after it has
>>   #                 finished its work, waiting for @block-job-finalize before
>>   #                 making any block graph changes.
>> @@ -2554,6 +2559,7 @@
>>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>>               '*base-node': 'str', '*backing-file': 'str', '*speed': 'int',
>>               '*on-error': 'BlockdevOnError',
>> +            '*filter-node-name': 'str',
>>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>>   
>>   ##

