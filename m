Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0614C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AAE2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eyKZTVbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AAE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTHW-0003zE-Nv
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZTGs-0002xD-N1; Fri, 15 May 2020 01:52:34 -0400
Received: from mail-eopbgr40128.outbound.protection.outlook.com
 ([40.107.4.128]:3310 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZTGq-0001Lf-DJ; Fri, 15 May 2020 01:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4TWtPcnxm8264NviuO2Vu5k8MNtTqGbv+IU6TvszEuQMrBmwrtQIom3a9Z7V4WliS/9BVQMY9o0hsdEgeypANxXssMWgKxnAoGSRPs6oXaFDtgv+52pDGAlb6G7lbvbm4ifGiKJpG6QJHvYVnaj+lJX79EdTzlufU1BaPXfatdfDwCjQ54mLI/TTJY885f+xpdHWVGaigCfScvHKlvwXbiDI4js3iL9+g+i0cdrA5IyptZmqkwL05ev1tNmoLn5asphYF1apspepFISeW+YYcL5Dcw5mNrGT1Z436W/W+8dPVgMBZHWy2Y5c6UYishuLbrVDCd8hSOdAaBjRQkd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlyZDRdZ+8hQQRr6otN6pA0V8yhRE8HhiQ6xUo0cAP0=;
 b=dfyaBY3byeSaH0ZBpUZcSOXm6vXpb7xJ+A4gTyUf9wOlr/mzcLM7LfuzYhZzt1GxGCHZlKd0Ert4KPcYWGd9xwDwX+fbKNjURIcNtgSsGSrMD5VxSTIsvh0A/HtHIjneP+m/EHA00fzKGkVKen41m2YMFrOchvx1hLJ9ASAlOcEYhtJxa1aEN0clFjagaIklo7483OirOZ1ISrRSoL9FeYtEqxRQFPWb7AQzSCBbNrKitK7o4UOoSKuqilyw7KMhT/LVHpc+LL3V5MzseiGqjHTtWr7rrLvH7kVD0krAd+QE8JnyKOq3eDRL79HFBvSPaU+bwqgqIqhrkuyrwkiX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlyZDRdZ+8hQQRr6otN6pA0V8yhRE8HhiQ6xUo0cAP0=;
 b=eyKZTVbSeW9/apsSbjeBhSBBDPcRdlXuOEvZrauI0VY3kz6nGvOmfgmMCzDX5VvuqeIVjuw/uC+d++wn3jBCvyB5VrTBUdMg5ZsL2yszE72l/jTrkFJJQ6+JpdXAjgPtsNEnNSE4GsoMZsW0W/FUjH1LShRWLeUJe+0mKFxL7Ek=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Fri, 15 May
 2020 05:52:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 05:52:29 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: Eric Blake <eblake@redhat.com>, Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <c25fb60b-9072-294f-847b-9b650292171b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <738cbfd7-9ec8-7043-923a-0510929e73e2@virtuozzo.com>
Date: Fri, 15 May 2020 08:52:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <c25fb60b-9072-294f-847b-9b650292171b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM0P190CA0013.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24 via Frontend Transport; Fri, 15 May 2020 05:52:28 +0000
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35c7575c-8028-481c-3fa7-08d7f8942750
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53973D3DCFF55042E6F7332DC1BD0@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRCxil4+CZkc0/IvVOK4Q8eBJRAqnLkhembn+2mMDFe6jA6c5O8Xxqm/ofMfXkvnD4D+s2+1XoKXRGxes3h5mJwDfOQr1JcodjnT7BXn3L+cFc2sGKeq2UJb16+5GL6exa8uNh93WByWjT5usOWIuOB/ySXYokPOedxgcWweoZAoRGAcz8b6jYY3kvvwjeMqxURAyNtxfEClQM1q1U92TDlyphOxojUaqjBIJRGBZVtoUgyiOqm06sdS32caSnjhmLL++FdK3MBwRDeNEi8qUMeBankSX/wHlqa011X5q8P13N6hk/BldwW7AQtbN/66pNU50/+Gd7I5T2vZ6eg8s36m6Ht+tVOHPW8vvQTjeS57QfaAecyuJPcMRTVaD9f3oSOignZVQEXGUuTXvbyLa4p+Wmb5tvJEJz2e18NPR+aA7DrBALCuLTA2eSA1V6S9oU0XMaFyvqsCZzXEoomgAojYWIz9soo+qx3ktuBoDahH3WJ3E8UP78+FuMbQSm2cuxrk5/NlGQ2cfJKPxGMEk2PFTUJl6gCgdM462kEfhzRCC8pS4Fte4B25qNGipSuETh/i0abRd3kz0yhRvkAGcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(66556008)(4326008)(16526019)(2616005)(186003)(53546011)(2906002)(26005)(36756003)(956004)(16576012)(5660300002)(7416002)(966005)(66946007)(8676002)(6486002)(31696002)(66476007)(316002)(31686004)(478600001)(8936002)(86362001)(110136005)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 32ng9A5/CPqUcFjNQKznWDnByxli0BxeQvnR85O9pPqdUh7LPnpeahG5+tIZ0qk0t03y+9qR86mjKWuBoFyGdpO0blv8bKmsrkwtrVX02LcdczmUzg3Oyvk6PgO1J+H8Jk/Qk2nTKAKTvNIBB/Hx2UDZiyj2IkdJ0fOc0PHQeAQ2zJ93FButtCNLw09pMkjkMSkDHVWypBmsHmqtF6pGnkkOuplo1K86Bxth6iUsSHxSEZx/v+rumSJ503y7JgjqRrDm0rH62C5CsR3NZHiLlXqRuxPscAM9iQ9FgY09HWXgZCmbOwVLoRtabG635ZlPgUhCUnwLdhNgZWEx11B/AltUPsqbqGL9sM0Dk7V9tX3yauSxVxLmbJvFWs0IZ6qHaB2dhIzeLzi8ya8ZVG6ESxqLQpVAiuNgf2z2iPLNspljVIvAReSkFiZ4+4fre8ovMMzI/UIQOoxjKFyNz3doxwuABS33+t0tjIEP+GwmGZOVDZdY7i94fbvzdDttlNG3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c7575c-8028-481c-3fa7-08d7f8942750
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 05:52:29.6096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6JmGPGne0ZM874jbjHdb3z8Gd8U2YvuM11Js+y9hCInwSILptEEQBQXNBeCfWlV+W31QN7arYOMEwqKeOCXlNV4PlAuu0N6wvCBhVOWROg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.4.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 01:52:30
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

14.05.2020 21:29, Eric Blake wrote:
> reviving this thread...
> 
> On 4/3/20 6:23 AM, Peter Krempa wrote:
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
> 
> Max is trying to tackle the node-name issue:
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03358.html
> 
> And trying to apply that patch after staging this series hits a conflict in mnigration/block-dirty-bitmap.c.  Which one should go in first?
> 

My patches are needed to fix migration for the pre-blockdev configuration with mirror-top filter.

We ofcrouse need them in Virtuozzo, but it's not hard to keep the in downstream-only.. And it will be not simple to use new command from Max in pre-blockdev libvirt configuration, with auto-generated node-names.

How much we care about pre-blockdev libvirt now in upstream Qemu?

If we don't care, than these series are only for downstreams, and we don't need to apply them upstream..

On the other hand, Max have to resend anyway, to handle old code, which uses device name instead of node-name. And if we don't want to drop now the code which can use device name (needed for old libvirt), why not to apply the series, which just make old code better?

====

In other words: do we still support pre-blockdev libvirt (and any other pre-blockdev users)?

If we support, than, as I said somewhere, I need to resend these series as I have updated version in our downstream. And I think, I can rebase Max's patch by myself and send together with this all, if no objections.

-- 
Best regards,
Vladimir

