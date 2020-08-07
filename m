Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8301EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5120A2177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="njWF3Pbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5120A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ymg-00013M-GQ
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3ykT-0007Mn-TT; Fri, 07 Aug 2020 05:33:14 -0400
Received: from mail-eopbgr150094.outbound.protection.outlook.com
 ([40.107.15.94]:43563 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3ykR-000386-A0; Fri, 07 Aug 2020 05:33:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoroIOofG1tn62oUYwuAtbnhvV12mJLmB1xOQ1hPd4/Kut7RmFcVheVNpgnzpl2Oh5Mbgjtc+WRsrZ8VbtkxlDsJ6F5tP+eSIVDlYZXq3kzyMwds44AuCpdXdj09f/3xnFy/LABnNZkjfI18X7WOJhcMneQijo9djlQ71f9oxu2vbx1DA3jTkZfFzCw8u+zR4d0VeLqRiGs1FXpcC0TE/6hxc6i7qfFyuIVjH4UA++eZbbYOCdj3aWF4jZLZMJkHlocPtanuVxCZM5moDzwmTPf3bM6U3WWRJFpUdl+DwE511dPiANWpCGXRwQEJ4gnI5Cpz3KFzf+swr1KWkzNqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqgUX23Xcm/PCttrLghr4rNkOVNNMQKXjAyLeD7rhLU=;
 b=Ini7CTm7wEtIul8zSRE5j26SqgVLtxdB3rWYZA+pDXm8fMRD1B9D209iR5+UvtwBJ4h0KyFxjbmqBdF4iT19AOxLho//58zKAy5TuUIlZVpTcWPLyjSnncqFYFD6LMTtSN/9L1lQ283W83JNBX/RH8tI1a5FztDJtkYUZDeBHQDglC5R/5QTf8EC3DAandNzIW4+AT4Zrr3xVAmI6UUtNbt/CrnvY5NJ1x72mV3LCp3hIgdfkG5eiwfBXuUAQFbqlNhECaI3pylG+b1GR2BdOig1T9GhfVjw7W4tY5FTb7OB9q391Ld8PwvyEegb/LP595a2pFWiFARIV2Qsmyd0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqgUX23Xcm/PCttrLghr4rNkOVNNMQKXjAyLeD7rhLU=;
 b=njWF3PbuZ2l5mtvu12vaLpvWkNE3Fm0Ckmq6rzqCLLxk6jfS5/xQitqsOktte7PfCyUHPMkZjQNYCpNs8wkPzVHZkvHXRA7ys4gduzvfmKehxHoNMLT8HEwC/aboPb5zr8FtpuQet3nBA+tVKItNoSllaYPX3XSSWlws7N4t368=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4469.eurprd08.prod.outlook.com (2603:10a6:20b:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Fri, 7 Aug
 2020 09:33:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 09:33:04 +0000
Subject: Re: [PATCH v7 01/47] block: Add child access functions
To: Christophe de Dinechin <dinechin@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-2-mreitz@redhat.com>
 <12e568be-f931-fc16-0ca2-a7ec54e538ea@virtuozzo.com>
 <ly1rkvhb8s.fsf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b80e99b3-5e8d-4ac8-479e-664ae6e7d091@virtuozzo.com>
Date: Fri, 7 Aug 2020 12:33:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <ly1rkvhb8s.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM0PR08CA0020.eurprd08.prod.outlook.com (2603:10a6:208:d2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Fri, 7 Aug 2020 09:33:04 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd891b9-c6c2-474d-49a3-08d83ab4e2da
X-MS-TrafficTypeDiagnostic: AM6PR08MB4469:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4469FA82DB44FE99061AA5BDC1490@AM6PR08MB4469.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfLLSPH1kUIWUA/oixNtkiXL80paRy44deaCX7NrNHCz5k0XMN9Jc8NgxNk71aUh56L6MPc+ngh6gTHO/Hr1xPPDLThFOPsyQQNrECfxEKOZalvnq69YZ02pbEmPtWB2pWWMHXI6hZgE4bmcbo8WVtSSgGcqr6hhAqVZ3aQ5Xk8k6Z3GKeQikf52Cd/SYOFRY0OQghMJJ5XJ7ztKYPaf4XP/zVayc/eiLkMz/KLlpYxqw4fmJ2AOnIdiOmEqnBXg8F0mwG9iRepswBaN2GeX5587CdOqx1WaOpqhrGpFFpsrd4+Z0Eaz15yoBb7WMjiab6Kxe/Cs6sadZEK5YN8MEzpQ3WeeQUS25iX2wH2aL3ecyeQBLLXh0LkyA9h1g8tE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(186003)(16526019)(316002)(54906003)(478600001)(26005)(86362001)(2906002)(36756003)(2616005)(956004)(8676002)(6916009)(66556008)(66946007)(66476007)(31696002)(6486002)(8936002)(16576012)(52116002)(5660300002)(31686004)(4326008)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DDea9VF0p0DGSSl7oy7VvadTksus5zYZ/S/07QEJxsH8uXPXEniFJPr+CeraQi8r9sjLlqBJsR29jjxDT2t84vtEudZb0fWpO+YsMKPU6ZWnjiaP3uH2gJH8mhK4vawsyA3oO13iJARfwW9DSK1osWDZIoq6VrH4oFbXUmg+OuGmyGbAGF2TaufTqJ1YLzCULRM1nefoPALi6DLXzij0ReAcAvqL/pW4IwSA1pswwAcwJOW1RskKVVxaL7Cr3bM33SU1RV010nc3ZQfx8xdMiibvmUzf7b2as6s80RxKdSbefzTMd+XjiNxIm0gqTF+zqoXEbGEa9qA18vnSoyvvHvpCJAM8+P3nibCIGLD1i0s9r7Etc0Vfl4wgR+FjOhxjIxd6k8hsK8dRgCAapJoOCXrnRgZFMIbsD4x+HhUvALEWeTBeeG3IFg8PmxXv0DShq6HqFPmMFVX2n0HOThVdOrnviF0E79sPMs0ulWbvhj5E2F7GZaa+CuzHp8OIEAOCErwi8xdbZPoxbm5yYHpaSynldpn5Pf1WiRlT3vZzDH0ZfkOVa4tom/vtjhFh13snihoFd1NG/q3yDE825N2sQu+8j+mDCcWDa0Obfjxv1aZIbkMDcDpEVHqv+PTjWJvrtWplr1R4io+yvQZV8wkEBQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd891b9-c6c2-474d-49a3-08d83ab4e2da
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 09:33:04.9008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9DPCf32syp7cbRkQHgC1ls1nPlXf1kiQ6ihcDpgAd1j1Old0CW6avVw4/EzHqbeTtElKVdx+J3aGcF1gm/ION6xj0vcXPqinjIp3dlLNd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4469
Received-SPF: pass client-ip=40.107.15.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:33:05
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 19:09, Christophe de Dinechin wrote:
> 
> On 2020-07-13 at 11:06 CEST, Vladimir Sementsov-Ogievskiy wrote...
>> 25.06.2020 18:21, Max Reitz wrote:
>>> There are BDS children that the general block layer code can access,
>>> namely bs->file and bs->backing.  Since the introduction of filters and
>>> external data files, their meaning is not quite clear.  bs->backing can
>>> be a COW source, or it can be a filtered child; bs->file can be a
>>> filtered child, it can be data and metadata storage, or it can be just
>>> metadata storage.
>>>
>>> This overloading really is not helpful.  This patch adds functions that
>>> retrieve the correct child for each exact purpose.  Later patches in
>>> this series will make use of them.  Doing so will allow us to handle
>>> filter nodes in a meaningful way.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>
>> [..]
>>
>>> +/*
>>> + * Return the primary child of this node: For filters, that is the
>>> + * filtered child.  For other nodes, that is usually the child storing
>>> + * metadata.
>>> + * (A generally more helpful description is that this is (usually) the
>>> + * child that has the same filename as @bs.)
>>> + *
>>> + * Drivers do not necessarily have a primary child; for example quorum
>>> + * does not.
>>> + */
>>> +BdrvChild *bdrv_primary_child(BlockDriverState *bs)
>>> +{
>>> +    BdrvChild *c;
>>> +
>>> +    QLIST_FOREACH(c, &bs->children, next) {
>>> +        if (c->role & BDRV_CHILD_PRIMARY) {
>>> +            return c;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>>
>>
>> Suggest squash-in to also assert that not more than one primary child:
>> --- a/block.c
>> +++ b/block.c
>> @@ -6998,13 +6998,14 @@ BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs)
>>     */
>>    BdrvChild *bdrv_primary_child(BlockDriverState *bs)
>>    {
>> -    BdrvChild *c;
>> +    BdrvChild *c, *found = NULL;
>>
>>        QLIST_FOREACH(c, &bs->children, next) {
>>            if (c->role & BDRV_CHILD_PRIMARY) {
>> -            return c;
>> +            assert(!found);
>> +            found = c;
>>            }
>>        }
>>
>> -    return NULL;
>> +    return c;
> 
> Shouldn't that be "return found"?

Oops, you are right of course!

>>    }
>>
>>
>> with or without:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> 
> --
> Cheers,
> Christophe de Dinechin (IRC c3d)
> 


-- 
Best regards,
Vladimir

