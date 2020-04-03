Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C36720721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="No8G8MwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C36720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKOLo-0004P3-6P
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 11:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKOKr-0003tH-Su
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKOKp-00051U-GM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 11:34:20 -0400
Received: from mail-ve1eur01on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::703]:45280
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jKOKo-0004nr-AX; Fri, 03 Apr 2020 11:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSwIXaJ1jI8lJkuGpsUfyrWV58E0qQ+PmV9AMI24dZphCFmdxIZbZPX2P8YTHgMEdfL+iebTK3yJXLJo0PVce5tZykRE94MkWCmQ7ZrvJeGTHIypub2sME5nMKqxJiYG869B5LnIxA8X2GgzWCZNhAq2YsRDhegOi0mP7AX6dSo1yvGy4g0W7++oyZpTnW4YmBQGZaRHvoGF7qnQMnNKyimVOMZ8nd+YsHovEABxdkZsjLO4OibPQqjkoo0QHOTO9XR7uCZCOkyAJMk8L+HHNB8fC9pc1fDmvJj/eNfrsdIEl0h4TOnSABaCavNUw/h7oSTSHICi3ZgpULG2V//mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE6SeOj+ibHGiHRmchytCkcneJ7ZR3NrHsXerJw90iY=;
 b=Z2Nc2GZpjrkork1CyWRf8FHVaczlnt+xyoMQcdJIRJlnf55Ajji3PTsHJZ1TyM0oL7bGS+fUr+wdoF2kmIZYGDRK7xfIYfVwY7sN4ekLRll4WYLiEBmsL5+4K/0i6/A7PSjLzPRXm+JHeIhbI6fqtCfaLnZplFQ/FtccjcHHW+xP7YxEu0osF8dyAyu+iMhj8ZccsKuO7y3V4y/2JoahQKY6tIUTUa4pZOtfrYyIGmJsSBgBjXjaqjKntriREBE+FThWhW+Ao1FjzGdt7fANtlsr8xhQWR9wonIgHi3JnkF6VO68m9Fyuqay5MXkHf07CxvezjLNE8N8V/PZKd7IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE6SeOj+ibHGiHRmchytCkcneJ7ZR3NrHsXerJw90iY=;
 b=No8G8MwZwKOjuoaRXPdoAy8Us52ZlfcyFByWcIGQnPIagQs4lfDuggaS71E1gai1Z0KS80LhhPy12e7OCsGXKeMUqWfm7evNifF2yhuE+sPn8IYQ964fPKjoKjRB306os2urkbh9c9Bv0ysyqQDRPE3VQc/kBQDUN81Jzs103+M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5413.eurprd08.prod.outlook.com (10.141.173.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Fri, 3 Apr 2020 15:34:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 15:34:15 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <bfd71b93-41a4-33fb-b6ff-5f7602af14fa@virtuozzo.com>
 <f53ec85f-e8c8-5717-2246-9ce8d6dd8e0a@virtuozzo.com>
 <20200403150536.GE3335@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200403183413010
Message-ID: <da92bc66-1b6d-43c1-ab01-5eb0665b8717@virtuozzo.com>
Date: Fri, 3 Apr 2020 18:34:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200403150536.GE3335@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0061.eurprd05.prod.outlook.com
 (2603:10a6:208:be::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.62) by
 AM0PR05CA0061.eurprd05.prod.outlook.com (2603:10a6:208:be::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Fri, 3 Apr 2020 15:34:14 +0000
X-Tagtoolbar-Keys: D20200403183413010
X-Originating-IP: [185.215.60.62]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a361af91-6ea0-4273-0e44-08d7d7e47727
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5413D57E92D13227C4CB1FABC1C70@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(4326008)(8936002)(6486002)(66556008)(2906002)(66476007)(52116002)(66946007)(966005)(31696002)(36756003)(86362001)(6916009)(478600001)(5660300002)(81156014)(81166006)(8676002)(316002)(16576012)(186003)(31686004)(16526019)(956004)(2616005)(53546011)(26005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRrZMhGTh5ygyODFDton82bCg36XQJtBK4WEH8YuOdwu8IxU8+rzHpC1RHqZvaEhMEw/9FnFRSbGqDFVigVcd5gbJMhZKrvgsTbJealdv6wB9X6i4kxFfGq2Pd8aGnRlcu6gUCT2sAeerY6sVs/lQASFAPcjB+ItYysza1HXKB/vo6XsS2cFky1c3KEqHXXpRpk6U4KERgUndHf2qHfYXR3QHIDjWlqUE++sAhJTZQtLpw3VOU4f6X/bwwZX+DMi8eXqgiyMxfdjgWw6dSF2bVCldWB2+z0nesb7At9gOdiJDVPZ3ksQJuvcbTeYZ1SKN25J24aal+rqelVzRpdZeN72gLGmVbVkXl9RZipl5pKj0zpTuVcbpZttJSMJXhcYoj/m86Nf74LiAcGE2Iz24Mhh6pnBLolJ4Knh/Ckm3WEJGVcKl+5rRqsEeZPcNrqZdslvVmrMk46TxxuCUJEBADp4dzymERTIkw94Lx3ef81rFKvX3X1/ZoxhzJOIf12mrOtnI51v1rcoO+119zFe7A==
X-MS-Exchange-AntiSpam-MessageData: StS7o70/S8uj+QYZt91pOonlnI5g3weUXFRW+LmrLw7wjIJQJL2o7PH0w/sFC7DeMQj8QwvQEMyTPV+8x8cz2gptzrULW56ZIzvbjpifa8owWobT2tCOQd+k1rnu+sxc6d/sA5Z3MdoBmT9cvcPoEQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a361af91-6ea0-4273-0e44-08d7d7e47727
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 15:34:14.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3qQvidLbIc/bAUesMgzLy5tp9WTpSAtjHuiJFUhm6tBe2L0UtqsX8urNJlfQm2LrviiY1kCvhDr7sA50XeTork4BD8J8PHlZXjUkC0GpZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::703
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
Cc: fam@euphon.net, kwolf@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.04.2020 18:05, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> 03.04.2020 14:29, Vladimir Sementsov-Ogievskiy wrote:
>>> 03.04.2020 14:23, Peter Krempa wrote:
>>>> On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 19.12.2019 13:36, Peter Krempa wrote:
>>>>>> On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Hi all!
>>>>>>>
>>>>>>> It's a continuation for
>>>>>>> "bitmap migration bug with -drive while block mirror runs"
>>>>>>> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
>>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>>>>>>>
>>>>>>> The problem is that bitmaps migrated to node with same node-name or
>>>>>>> blk-parent name. And currently only the latter actually work in libvirt.
>>>>>>> And with mirror-top filter it doesn't work, because
>>>>>>> bdrv_get_device_or_node_name don't go through filters.
>>>>>>
>>>>>> I want to point out that since libvirt-5.10 we use -blockdev to
>>>>>> configure the backend of storage devices with qemu-4.2 and later. This
>>>>>> means unfortunately that the BlockBackend of the drive does not have a
>>>>>> name any more and thus the above will not work even if you make the
>>>>>> lookup code to see through filters.
>>>>>
>>>>> Not that this series doesn't make things worse, as it loops through named
>>>>> block backends when trying to use their name for migration. So with these
>>>>> patches applied, qemu will just work in more possible scenarios.
>>>>
>>>> Okay, if that's so it's fair enough in this case.
>>>>
>>>> I'm just very firmly against baking in the assumption that
>>>> node names mean the same thing accross migration, because that will
>>>> create a precedent situation and more stuff may be baked in on top of
>>>> this in the future. It seems that it has already happened though and
>>>> it's wrong. And the worst part is that it's never mentioned that this
>>>> might occur. But again, don't do that and preferrably remove the
>>>> matching of node names for bitmaps altogether until we can control it
>>>> arbitrarily.
>>>>
>>>> We've also seen this already before with the backend name of memory
>>>> devices being baked in to the migration stream which creates an unwanted
>>>> dependancy.
>>>>
>>>
>>> Hmm. Actually, matching by node-name never worked. May be just drop it now, and allow only matching by blk-name?
>>>
>>> And then (in 5.1) implement special qmp commands for precise mapping.
>>>
>>
>> Hmm, it may break someones setup... Bad idea. Probably we can forbid auto-generated node-names.
> 
> If we want to remove it I guess we have to go through a proper
> deprecation; but that's OK.
> 
> The thing to keep in mind is that when people say 'the commandline
> should match' on source/destination - that's just not true;
> so we have to define what actually needs to stay the same for bitmap
> migration to work.

Hmm. Let's add two qmp commands

1. migrate-set-outgoing-bitmap-mapping, which can set mapping (node-name, bitmap-name) -> (migration-node-name, migration-bitmap-name)
2. migrate-set-incoming-bitmap-mapping, which can set mapping (migration-node-name, migration-bitmap-name) -> (node-name, bitmap-name)

So, if we want to migrate bitmap B1 from node N1 on source to node M1 on target, we'll have three possibilities:

1. call on source migrate-set-outgoing-bitmap-mapping, to set mapping (N1, B1) -> (M1, B1) (and target will use 'M1' from migration stream to search the node)

2. call on destination migrate-set-incoming-bitmap-mapping, to set mapping (N1, B1) -> (M1, B1) (source will just put 'N1' to migration stream, and target will made transformation)

or even
3. Set mapping both on source and target, to make migration stream abstract, for example, (N1, B1) -> ('_abstract_bitmap_migration_node_', <bitmap-id>) -> (M1, B1)

Using 1 and 2, it is possible to make any migration to/from older Qemu version..

And what should be deprecated is dirty-bitmaps migration capability, which is associated with old behavior. So, newer libvirt will call set-mapping commands both on source and target, instead of enabling capability.


-- 
Best regards,
Vladimir

