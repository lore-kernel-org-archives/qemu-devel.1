Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A6C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25442078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G1Z3ix3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25442078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKsf-0007uj-VW
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKKrp-0006kp-GM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKKrn-0002av-O6
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:08 -0400
Received: from mail-eopbgr150113.outbound.protection.outlook.com
 ([40.107.15.113]:61954 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jKKrn-0002YY-4r; Fri, 03 Apr 2020 07:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoOn3vZ/imI3TTm7vOFI/CxX3WbwcttLaAZW39fhhKqX+GdzehVKQuarc7UjNSqEFpyOJ8wDyMBF9WsQDAK8tvGBW/SKibqPI7SzCFWoB8YIJpeXrogQNYgeEC7a1EB0eALs8lvAd8Gj/eOA8OYBoe1F4H2mcdgUN0Anb2jgIC/RBxEGlonjn6pVASe/d07gMjlRQS6HVQ6okCM/p6IdXB7fT8NZzPrqZXVOj4lIfbIFkVSC3OoKSi60jub3tvvmqBK6IYkobo/30N1FCMzJJWVY2pQsXeCE0ShIAwH7w1bFmDm41z3mUibGtlIYMFhmM68KydVWnlE+KgvjZavn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWb+JqMKFxWR/5q7RfAeblTI2wYAZLwTVKRtMb/nvPg=;
 b=IrNvMKiaZQW0D1DEb0k5zRGfr3CyPszPFFNIdkTkuaI3DBNWyWuJWuOXCZ7kF3ghBc63KGEXdHcipgromR91M22XYGTcCb3nwm3Qk7xvTHC0VbRedkTO6sLvMLuiuGBU8h/4amIABYss5nk3wY9iYCbZMGJuXrzFPcD1TQs2V9IMOFWXmsCyzRImo0Wluj3/Fxpdt47QAmKlNxIrj+gNm6JWb3h8KOh25+7od79IujpoxB61VdJoLRsxIs37CbuyNBoF89Mf62bA7jrBXEOctc2kJrXzb9kS7a4PglTjhWCJI7V6XGCVcrOuzGp6+vsxEqXlQ862tLVSjLmr4O/WpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWb+JqMKFxWR/5q7RfAeblTI2wYAZLwTVKRtMb/nvPg=;
 b=G1Z3ix3x+vSLb4jrZ+5e7dXr1M1LSHe240U/2rsFbzP+2YzUJlcPq9prw5kRYekfREmBEbVj5YH02kY48CpoeCvYqurD9IDeqx3RJujT14ZrG4IjyGC/YcilBBTVFghwqcTrOqBemfJAY/J+YWO+RGUAnNfR2lrZBaT1CpwMFeU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5383.eurprd08.prod.outlook.com (10.141.171.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 11:52:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 11:52:04 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <bfd71b93-41a4-33fb-b6ff-5f7602af14fa@virtuozzo.com>
X-Tagtoolbar-Keys: D20200403145201682
Message-ID: <f53ec85f-e8c8-5717-2246-9ce8d6dd8e0a@virtuozzo.com>
Date: Fri, 3 Apr 2020 14:52:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <bfd71b93-41a4-33fb-b6ff-5f7602af14fa@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.62) by
 AM0PR02CA0035.eurprd02.prod.outlook.com (2603:10a6:208:3e::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17 via Frontend Transport; Fri, 3 Apr 2020 11:52:02 +0000
X-Tagtoolbar-Keys: D20200403145201682
X-Originating-IP: [185.215.60.62]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3cf8c39-cc64-4265-8f91-08d7d7c56d15
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538368700FF8B828294B4862C1C70@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(39840400004)(396003)(366004)(376002)(346002)(66476007)(86362001)(16576012)(81156014)(53546011)(52116002)(8676002)(4326008)(81166006)(6486002)(2906002)(8936002)(31696002)(6916009)(16526019)(956004)(66556008)(966005)(26005)(36756003)(186003)(478600001)(5660300002)(2616005)(66946007)(31686004)(316002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBdz4N13xIqqTa8ZlpUOrnvuhFkAaMX8ZHlq9DbOjwMqCPquzstL3uf7mi+wKib6t+dAsbZC5U+ivIfaOdhLI561ZB2r1LD69bUzcrQMcxe8yxLYn/ok1sd16L5suEBCx0jbw3BVu9EJiTaTXrhWk3eIC9DuiIRO7jdb4g8tpS91RrGm+RPJAJoUE5ONIrlkyxl3CtjNEZU8Fr3lyg7uEhpFXmH91KAHTdPikBeDyZkSZXR5dcFsSC/X3o67m/gk0nTHay9Yw6ACB5pBzEY5ESVffRfNVM2SaSqf9fJAOLHa8I/WAlq+AS6D0Cu0X8sfEbiyloGF1VcvMVW2QxFvrmkhj2iOMd+YjfiqKlGstDMYVPlqJKuc8amjIYh8mTvIMpfHgGvvFYESss0l1dpi5UwFwBwiCbwZpBagvsyo2gC8QhUNaVJ4Z50N6845kfgzIRODDeR8f5XsD6Ge0YWwDlEJjW0UWdoF/ecf9wTLTa/ixmYNFP90jHQFGIBIIliQwiO3gO75+BnREE0aODsEhg==
X-MS-Exchange-AntiSpam-MessageData: GW50TfHqlJYOAOeiMhYvprIiEAIHPwEtc89MM8+wMNJ5fkDdHA7TWgzlstsDhZMNes6Cv3ZXwKW3u8gXnWF+bmpuSwm3YV6Tp2xtsG+xyj8H3APiA7RIF6CJ1e0y1t825ZgbhT6w9sZMfUYNOP7DmQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cf8c39-cc64-4265-8f91-08d7d7c56d15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 11:52:04.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrJNF+0Lk5kYCqZFbnuxmYa/Zjal2bBiQA7Z3pYRR+jyVgQLMi4xBh/FeqADVbHNeFWK4rji6/9hBkJhQ3oXgAgh6u21nXPVYJQA8S4E3tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.113
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
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.04.2020 14:29, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2020 14:23, Peter Krempa wrote:
>> On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> 19.12.2019 13:36, Peter Krempa wrote:
>>>> On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all!
>>>>>
>>>>> It's a continuation for
>>>>> "bitmap migration bug with -drive while block mirror runs"
>>>>> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>>>>>
>>>>> The problem is that bitmaps migrated to node with same node-name or
>>>>> blk-parent name. And currently only the latter actually work in libvirt.
>>>>> And with mirror-top filter it doesn't work, because
>>>>> bdrv_get_device_or_node_name don't go through filters.
>>>>
>>>> I want to point out that since libvirt-5.10 we use -blockdev to
>>>> configure the backend of storage devices with qemu-4.2 and later. This
>>>> means unfortunately that the BlockBackend of the drive does not have a
>>>> name any more and thus the above will not work even if you make the
>>>> lookup code to see through filters.
>>>
>>> Not that this series doesn't make things worse, as it loops through named
>>> block backends when trying to use their name for migration. So with these
>>> patches applied, qemu will just work in more possible scenarios.
>>
>> Okay, if that's so it's fair enough in this case.
>>
>> I'm just very firmly against baking in the assumption that
>> node names mean the same thing accross migration, because that will
>> create a precedent situation and more stuff may be baked in on top of
>> this in the future. It seems that it has already happened though and
>> it's wrong. And the worst part is that it's never mentioned that this
>> might occur. But again, don't do that and preferrably remove the
>> matching of node names for bitmaps altogether until we can control it
>> arbitrarily.
>>
>> We've also seen this already before with the backend name of memory
>> devices being baked in to the migration stream which creates an unwanted
>> dependancy.
>>
> 
> Hmm. Actually, matching by node-name never worked. May be just drop it now, and allow only matching by blk-name?
> 
> And then (in 5.1) implement special qmp commands for precise mapping.
> 

Hmm, it may break someones setup... Bad idea. Probably we can forbid auto-generated node-names.

-- 
Best regards,
Vladimir

