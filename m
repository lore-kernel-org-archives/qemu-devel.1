Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 05:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8566820774
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 05:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nAxV7mSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8566820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA4ab-0008NH-PN
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 01:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kA4Zo-0007wO-Au; Mon, 24 Aug 2020 00:59:24 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:44997 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kA4Zk-0005u2-Uf; Mon, 24 Aug 2020 00:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+IMSXR4TCNyiFr7tiZjR3+nxpWJDP7l7IcBoYgyOc2Va+1CIf5URlVnZqub7M16+MWYUKL9GEIXghPhXrQQxXgCrIUh1d26gy0KBXe6XJn8ji5+/LfLTkw4tApoVkqf+YUYZc37qpBKic/swZFkODyD1lOalGGl1tNpKP+Rs4BE4dJsXzTcwevOBDvrsh7w+E+2g5SuU/MA2wQ0upQWNBMgHojcoXAl4d0YrA4eHvix3CxeCzUHMizfAsfkLRj3vZiYgch+PIV9Zyhlo0d6KnChJPGV/0ALGjnwLefnRkyzoIG/szQWzRBzV773jO/pWI5A7FTEm3RK2F2qZ2c8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgy3rsSoajgcfpCTcJMYhU9XiCUoV7Wjy6kZoZ2qIEU=;
 b=LgpbMRJVasqHUY67dv3W0UZd1yKJ39n4jCDYaOaklSZazwYmqDq/BpNuWuLb39OT69nc6a4iemNlrkYiaHf/IqU0rfKhCR+VJhrkUulfdDTUuUc3Tz/I+9EBoUohWdzvpucJyfKGT0EFp+dNSVqR7U+dsjciCwG4o1dd8ucRsKcvn+ODa91sXqqmoOhp60BpHWaZ59ASLiQ1VmSEpGWPnM9Pg54GcoX+7ulkILo/F6BFWk47TkPHfntF8Ad0Ymm1EtE5xoYC7OsQLc6JbZi5DcPhCEkxCgUBUOdnNKKO54PLgs8D4fbjc2cniMkZN1/zhW41v+YyPbQa2SFQdupCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgy3rsSoajgcfpCTcJMYhU9XiCUoV7Wjy6kZoZ2qIEU=;
 b=nAxV7mSiY9EUUJ8rzwXExiKe+AjmIQCoNn3No79ov9o5nLMuraj1vXac9eiJuBJ7JexYH/qKFJXDRPHv4l3qRrSXofxytU9xudZ79lN6K8Ze2smVHVqnc83NyJNo+3sGH/uIZ/aXC9QOrhdmHXmy5CEjV/K72E2NRtYzGeRtcHU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1676.eurprd08.prod.outlook.com (2603:10a6:3:81::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 04:59:14 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 04:59:14 +0000
Subject: Re: [PATCH v6 2/4] copy-on-read: add filter append/drop functions
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3f450bc2-73a5-49f8-53ad-d1bfa1051407@virtuozzo.com>
 <70d35670-2c60-eedc-c78b-29e249e88ad2@virtuozzo.com>
Message-ID: <b89d5057-2cab-00e5-65af-b08c2447875c@virtuozzo.com>
Date: Mon, 24 Aug 2020 07:59:11 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <70d35670-2c60-eedc-c78b-29e249e88ad2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 04:59:13 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f0ca51c-67eb-43a2-77f4-08d847ea727f
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1676:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1676E617AABD7D412146CBF8F4560@HE1PR0801MB1676.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXSaN3soSGO7sbWHRawMRwwAYF/OSwfOjOihM0qj9CIOeOt6YN7OImlteDPYc5nhjybGcVxG8BpHez3O6Qu0+565K79fCJReeO9XdEq1bcWbVGFq6etQcJhS+OPqBteoIeJ0W03n/VgcL6n50+2db1N9uWT60VxntofImFinj8IPqWZiC8LOTX+0sqjB7LZzPvJ0O2STz0xkT3pMe8VIAQgks6eSEy8+B00IyRPj64t5VCRBnrnjvtF2p7JWAGQGLanzR1Z4R22HFsCzqMASx1Prkn6RYcFH5TVXnYaooU2b+qUdL0yK/c3hiMkGc/gRzsNU9dxRQlVn/0pgPtBAhOMUV+kJ/tbhn1FqmlVyChPrSDDpG4F3YZc77r56GrzI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39830400003)(44832011)(316002)(8676002)(6486002)(31696002)(4326008)(107886003)(83380400001)(31686004)(6512007)(956004)(2616005)(6506007)(66946007)(52116002)(66476007)(66556008)(2906002)(186003)(16526019)(8936002)(36756003)(26005)(86362001)(478600001)(53546011)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7GshHzvBss0t71NS2azl/eJxo89KWBWNEBljgR3uIxOwB4NGOeOvW/Sz1ySL8KV0iJT1lELywlN9nQSkA6xpPGvzZxrNaAtDBzbsey52H2Wnp8Ic4BI7oRAYR0wqae/wp2aIY972n34nh8YJViF64hR7WWnDnnVfOm35q4oCS2HBMvQdqkHeOZwCBLRA03fAIKd3+pflHCnuXRl3qbmeY8W/IHsmprJPCzpKAGLZ3MzpD6yO1aFwZ46YAps3A/s2GzOIs4hdfps6p2k1IJkVsI0TorEvSYYyr2S4cpwQouCrJR02zdNCx+oHt9KCUZFFIITqKIMkgdMGDAipEfryzOcgHyoyWQS07AMUyScnVp/vpj0zTF87IGR+yTAwUY8ALJvF/t0vlVEQjpFQj8W5EG8YvpccxKh5Za5sz1+hRa8P0JwkuJ4jXXBkIKKxzW6U0Eog2c7kP1RNTKGGMFCwq8RveS59PfvR2WvPpHHtupi4bWQ8FSNQ2BDW1f4LNvisgtmk5Z5cm1T0Sv/jQ/mfae3IyCbmkRPHb8WBEKfUgz3e+Z9AWjgOeD//uSuEnhbw8L3jvcdnG3o/ZdmF8clkD1aAWcTRf3z4mjzagV4k7c3BVz9xSBAEXRZtUYLvj5rUb9CMjgZBWjHt2fcbP/tUBA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0ca51c-67eb-43a2-77f4-08d847ea727f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 04:59:14.4659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmDn6RTH8U81Vvj9CjJ60cFA2bRs9CRHnjEEMOGhIVEaNMaU9VXFfba1HoNhozJ6auV7dK8frlmZYh0q4eki4NTV2i0LmnZFRaflRFcWurE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1676
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 00:59:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.381, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.08.2020 22:35, Andrey Shinkevich wrote:
> On 19.08.2020 13:21, Vladimir Sementsov-Ogievskiy wrote:
>> 19.08.2020 00:24, Andrey Shinkevich wrote:
>>> Provide API for the COR-filter insertion/removal.
>>> Also, drop the filter child permissions for an inactive state when the
>>> filter node is being removed.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 103 
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   block/copy-on-read.h |  36 ++++++++++++++++++
>>>   2 files changed, 139 insertions(+)
>>>   create mode 100644 block/copy-on-read.h
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index cb03e0f..150d9b7 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -23,11 +23,21 @@
...
>>> +BlockDriverState *bdrv_cor_filter_append(BlockDriverState *bs,
>>> +                                         const char *filter_node_name,
>>> +                                         Error **errp)
>>> +{
>>> +    BlockDriverState *cor_filter_bs;
>>> +    BDRVStateCOR *state;
>>> +    Error *local_err = NULL;
>>> +
>>> +    cor_filter_bs = create_filter_node(bs, filter_node_name, errp);
>>> +    if (cor_filter_bs == NULL) {
>>> +        error_prepend(errp, "Could not create filter node: ");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (!filter_node_name) {
>>> +        cor_filter_bs->implicit = true;
>>> +    }
>>> +
>>> +    bdrv_drained_begin(bs);
>>> +    bdrv_replace_node(bs, cor_filter_bs, &local_err);
>>> +    bdrv_drained_end(bs);
>>> +
>>> +    if (local_err) {
>>> +        bdrv_unref(cor_filter_bs);
>>> +        error_propagate(errp, local_err);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    state = cor_filter_bs->opaque;
>>> +    state->active = true;
>>
>> hmm stop. it's already active, after create_filter_node, so you don't 
>> need to set it again, isn't it?
>
>
> I will remove the extra assignment from the cor_open() for consistancy.
>
> Andrey
>
>

No, I won't. It is wrong to do that. COR-operations wouldn't work.

Andrey


>>
>>> +
>>> +    return cor_filter_bs;
>>> +}
>>> +
...

