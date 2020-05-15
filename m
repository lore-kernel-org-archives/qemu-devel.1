Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2709C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD06204EF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GPGhl67A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD06204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYKd-0006R6-NU
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZYJQ-0005RY-HL; Fri, 15 May 2020 07:15:32 -0400
Received: from mail-eopbgr60114.outbound.protection.outlook.com
 ([40.107.6.114]:22498 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZYJN-0000OM-HA; Fri, 15 May 2020 07:15:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEB/KGvFwTQAYr0HHZDX/SooRwiwoMFbUgNrXAegUOnaXXFiUx/C1YFQRqq3sEbEEyhSFfCF/tdHoJtGhgnccrp5EmOCVspRrqjE93mdvVzDgB//tWASZlKWjlzVnSMiIfCEEH2FDt+Yjz32/mWt1MvLJOvBBz43Tv73gqy5fk5UQLoJyha4GS0zf87aJ8ePMFmXxLjGFVJ5LypdkSmuab0XZNZWeABpAHpFaMnISFdG/ilAMqeahhn0GmITNFGKXXGThROmJ31pxjiguZgTT5SrkLFf9n3npl5O5RaVSqEzNr2ojnIn+aOSY1R8ggzZCHiw2xpHsr0i9KPKZ5nMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmYbSHmZKZPTSj+L3lPjYdHvVSsY7+2rHYJrA31A5mM=;
 b=D2ic8kw2Ibnmi6mL6H+15H0UUzKyWr51reo9DqOPWy4nZ+odr334Y4HN6xuzvo9ShdQTkvAFa5vDaw0k8TRTW7UobXMdPJWGQWriQxuyf/s9afqbz8MHqAO2Rrj+Wiq5gMhkc12oQX9nWUy0OgQSp7H4urN4QsvHDSe9J7c+/+2qBf8P9YsYOh2YDsJ06kTPjKXEqT58D6peBeDDgxnp6LG65XX9/PuIKqHwnOraXyNRQ0mCmkYFh0Ht9pp1vS9CwpKzrUqpn0if8Vb+D9xxqdAHgPfZoda84O5fYs/1aCPWs4CFmxLEvn8/hcqtjcVPLyVAf8QNncEtKqINLeTyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmYbSHmZKZPTSj+L3lPjYdHvVSsY7+2rHYJrA31A5mM=;
 b=GPGhl67At2v/aJ0kLvmHbnIlUFeWTVX5R753ReIV916wn2H1xWDuvKxRLHamv9EZeIo7AqKZVlT4H/zv+GjlE9k8TJzDFpLtsEtOgrAAvUZL2peStQac9P6SDutdrR1xaag9WN7EikIYf8ocVhh+5wzn2vwq3B1EPZHK2019wGE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5479.eurprd08.prod.outlook.com (2603:10a6:20b:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 11:15:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 11:15:25 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <c25fb60b-9072-294f-847b-9b650292171b@redhat.com>
 <738cbfd7-9ec8-7043-923a-0510929e73e2@virtuozzo.com>
Message-ID: <acecd801-9486-6dea-d06c-19b7ce6d77b3@virtuozzo.com>
Date: Fri, 15 May 2020 14:15:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <738cbfd7-9ec8-7043-923a-0510929e73e2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 11:15:24 +0000
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e8ee05-efda-468e-b70a-08d7f8c14457
X-MS-TrafficTypeDiagnostic: AM7PR08MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5479A749E3945519C1BE4000C1BD0@AM7PR08MB5479.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySACiKd81PRrd9qAXjMYE613nrNoKs8G9VpogJyjP/2IH7XV5jXCjBh9UuLzxGrojWpvkjktWp3GxqOe+urDqLiQgbQZXOlsg9jjy9dDjbKDWq7DEnp6RrPdp+qnWbs5leUw2UzjZLoeDvJABR3YOg/tmn1xpRUohRkWcnJkK9H7j2dDW86UVg2Htr+TqXyleLxudOzp9xhu9o7JSpoZhJgarJUvIfJpOZUVOwGh+HY76MFSlzpxC4/9/KI2X8u0t6txct7yQYNAj8aMhUdkz76qoCJ3GgXPYmYYqGdgexfdc15y02oUvoRoF4Nq0KIVoscjNmLezfN/76i93gigoj1vTlE84fN4ebM6fNEZJrZrNok5emFzuZf0FfrGSnaTWfK/PVSTazZWF5H5PSpYj5pytMLLHbU0jJusXrvGWk3UDJ289WiqcL+WUInMv0AkSvdkF+LQxy98kQMYHtUDl+XRIrQ5eLQBHnFWoxsFH0NDCFSUYgYHbxG43ozvCbi5Yc5IrnmpNwhfANiK4GD6xzNnTXz3WVVrU4rldU0+7Et7Zr7iFDdBT+aPFiyh+oC3N8q4e2BPFJ/UgXCI2kHUVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39840400004)(136003)(53546011)(8936002)(86362001)(8676002)(6486002)(110136005)(966005)(26005)(31686004)(316002)(5660300002)(31696002)(478600001)(2906002)(36756003)(4326008)(7416002)(66556008)(52116002)(16526019)(2616005)(66476007)(16576012)(956004)(186003)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 062zOw4lM49Oa8jWbBVr2Hf+CJGNZRvgDwXbx1WZ58JAjOKi3FwxId5vdWd/mn8rbl7xNVhz/ebLZQqs0F8Sio5oqpBLI8ho92OqAlrnPEETHS5PFpE58ybQlXRDDm+PtivnhB0CrAehwMtrQ/HLs+lVRnjARsVBAKkn9jKC5HHTAWIfwXvZwhMVlFOhHJXRcFlKnE7DQSmjTqSh4N3c/jmoyOfBE1EeswGEboVpxDOqKTfa7CfrvAMqOWx/vZ9L1HJwhEFp/U/bWiPOjlicppOjMukLMbrJyq2PVpz6cUctcDX4NFXyu2w/CvHlmGGQEohnK5uIs+/6ZYv9GbAFSN+TI3vsCPokv2VGyVq+zjQHaH8rKv3nNW7na3CSR5lNbRqEiacUmqJ/+330v5a56DmQWLigdmZ7tIEG/bXTr2Sd4duvC6AoFZsiJLXBOZzlrlo4i186N019Hgoi3vPdEImBZzGueEk44du1drT5qA+Jidrzjo1XfHrsBUcOif9J
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e8ee05-efda-468e-b70a-08d7f8c14457
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 11:15:25.7012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYzg8TTGmvieA7HB55AUaC7DFytT9PbAJ2+8TcGkKZ0HMCeir942TT45m/MZsdDkJo/aD24RxFbvHXJewR7wYwpeGrRSobOwEIz6Vlfqoag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5479
Received-SPF: pass client-ip=40.107.6.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:15:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.05.2020 08:52, Vladimir Sementsov-Ogievskiy wrote:
> 14.05.2020 21:29, Eric Blake wrote:
>> reviving this thread...
>>
>> On 4/3/20 6:23 AM, Peter Krempa wrote:
>>> On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> 19.12.2019 13:36, Peter Krempa wrote:
>>>>> On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Hi all!
>>>>>>
>>>>>> It's a continuation for
>>>>>> "bitmap migration bug with -drive while block mirror runs"
>>>>>> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>>>>>>
>>>>>> The problem is that bitmaps migrated to node with same node-name or
>>>>>> blk-parent name. And currently only the latter actually work in libvirt.
>>>>>> And with mirror-top filter it doesn't work, because
>>>>>> bdrv_get_device_or_node_name don't go through filters.
>>>>>
>>>>> I want to point out that since libvirt-5.10 we use -blockdev to
>>>>> configure the backend of storage devices with qemu-4.2 and later. This
>>>>> means unfortunately that the BlockBackend of the drive does not have a
>>>>> name any more and thus the above will not work even if you make the
>>>>> lookup code to see through filters.
>>>>
>>>> Not that this series doesn't make things worse, as it loops through named
>>>> block backends when trying to use their name for migration. So with these
>>>> patches applied, qemu will just work in more possible scenarios.
>>>
>>> Okay, if that's so it's fair enough in this case.
>>>
>>> I'm just very firmly against baking in the assumption that
>>> node names mean the same thing accross migration, because that will
>>> create a precedent situation and more stuff may be baked in on top of
>>> this in the future. It seems that it has already happened though and
>>> it's wrong. And the worst part is that it's never mentioned that this
>>> might occur. But again, don't do that and preferrably remove the
>>> matching of node names for bitmaps altogether until we can control it
>>> arbitrarily.
>>>
>>> We've also seen this already before with the backend name of memory
>>> devices being baked in to the migration stream which creates an unwanted
>>> dependancy.
>>
>> Max is trying to tackle the node-name issue:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03358.html
>>
>> And trying to apply that patch after staging this series hits a conflict in mnigration/block-dirty-bitmap.c.  Which one should go in first?
>>
> 
> My patches are needed to fix migration for the pre-blockdev configuration with mirror-top filter.
> 
> We ofcrouse need them in Virtuozzo, but it's not hard to keep the in downstream-only.. And it will be not simple to use new command from Max in pre-blockdev libvirt configuration, with auto-generated node-names.
> 
> How much we care about pre-blockdev libvirt now in upstream Qemu?
> 
> If we don't care, than these series are only for downstreams, and we don't need to apply them upstream..
> 
> On the other hand, Max have to resend anyway, to handle old code, which uses device name instead of node-name. And if we don't want to drop now the code which can use device name (needed for old libvirt), why not to apply the series, which just make old code better?
> 
> ====
> 
> In other words: do we still support pre-blockdev libvirt (and any other pre-blockdev users)?
> 
> If we support, than, as I said somewhere, I need to resend these series as I have updated version in our downstream. And I think, I can rebase Max's patch by myself and send together with this all, if no objections.
> 

I'm going to resend the series today, let's look at it.

-- 
Best regards,
Vladimir

