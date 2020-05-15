Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D57EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B87B20727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uMsWEnd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B87B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZgMS-0004vd-8r
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZgLP-0003ww-Ir; Fri, 15 May 2020 15:50:07 -0400
Received: from mail-eopbgr140108.outbound.protection.outlook.com
 ([40.107.14.108]:8576 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZgLN-0006Fr-2L; Fri, 15 May 2020 15:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmRQoRnl8mFo301GP5yV+XR1/c9a2JAYhQHom48wXSPX1xH384t8oRzst6Qtzb9B/dL17z3tFn9fX26mPCgvqVUCUrmtb2GIRY4aLYTa7nSvX5YiuEu34L2JwMRrQlvy7h2Rj+GAKKBUd7/FzzB8XyeTupDmw+ZrYVCO3ki4IzFJ5av4i5LnYgUEhqW7tR/dg8UAIYRShWb1XfGzvItCSs74VX04U4jnDnAFkZzAMkfwmU9CuAHTxYOyQfMQUXLGErzil3IRt9D1wSrzOyf16cmS30uIRrMQlMRz0oe9nmFdLLkzOqsFTm4jTALI/L44jfwy39asVk/U8+aDUPIpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MT1Pimhg7veBif70ojbh25E91WI/MBQ/rThbfZs6vo=;
 b=ABLMXfwlo+j+YXvz3oO0xw159ejcFEprtPup8kiqZLdrFhAnaoNZc2/dFJZ41t679wNeuxjOttpwf2XtKzLg7QbroSUz6dTyso/rWQN7uv3t3vUUAw8Z+Cwfd++N4N/bYxjWZYqENxQkiSKXHdGekuhBsCwNS5oXFCyEc85wBy8xkq1ftnfD0eqHQ26VcSj2fgUZ5rhM3wHN61A/R3yC7lAW28nL9W/7vy4oB2e60WxN44flTrdj09mVlAJTXTiI3bJlPwdGZkECGZuyZX5RFnEPVsuAVGC5ckinqAG4zdfmmlmCOtnBdP6Aty3KKfHZhFzA6yfIl+D5ij8Op/CtiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MT1Pimhg7veBif70ojbh25E91WI/MBQ/rThbfZs6vo=;
 b=uMsWEnd2CPLyUamHfW4orQ6tihYIPFEZRIFafiEVeqlq8OogOFbsFpoLZii4Z2uen7OSvx09M9FDorS05Zpdxg1ucS41RppjX/5eDx0rjqyP77kcWxlSIjdq6QLcrF+GEXp66mEx7zfwTBDRkzbUnp+jduy/3wbkatNMr6hT6d0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5445.eurprd08.prod.outlook.com (2603:10a6:20b:10d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 19:49:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 19:49:59 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: Eric Blake <eblake@redhat.com>, Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
 <c25fb60b-9072-294f-847b-9b650292171b@redhat.com>
 <738cbfd7-9ec8-7043-923a-0510929e73e2@virtuozzo.com>
 <acecd801-9486-6dea-d06c-19b7ce6d77b3@virtuozzo.com>
 <5dfecf7a-0da8-d9da-dc7f-cd684710353b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2d212e49-5610-a5fb-257c-db779e3da5b8@virtuozzo.com>
Date: Fri, 15 May 2020 22:49:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <5dfecf7a-0da8-d9da-dc7f-cd684710353b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0701CA0017.eurprd07.prod.outlook.com
 (2603:10a6:200:42::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM4PR0701CA0017.eurprd07.prod.outlook.com (2603:10a6:200:42::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Fri, 15 May 2020 19:49:58 +0000
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48dc5126-a2d0-41b8-cb3d-08d7f909269b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5445773ACD5FD765F423D5CEC1BD0@AM7PR08MB5445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uir6yOIv/XlM0hkr5sSFRnhJeRKaMF14LEtn76oyROsF+UX4sLqftEJh+C/2lFta3A1zcAomh+AnYEcRibtkSp+XDZRv7L3oCqC4f8NwtHSsUEodRsN8TWgL/h8yvg6hNGbSpsydYRnWA8Wh8kx+HXbOIkTs3VquN1Dixli0SYr8HZ2/7yCCA7gfitHatz7ss5671Uobx64jsw0o6Tx1nx6tEHl4B0XlooOBA6qdx7UhxT08H2GnKuwHZ79lqjwRCtv9MjMjd1sP6bMZS3WCgGz/KZ0pwqliWV+L+Fvvxn+x6dSC9KWOgRSLX5RH3JTUKCFr9vdAw4kYh5r2UsF2RK3I+aTTc2gwSp6wOibWRpsw/d1K0iStEVl6dD31p9nkC6DPq4ttOfIwcsYeucWqW/qLIAErVTH2ViZQB1in+IzVk7cv5IMh7gTWuH3ejVGcN5j8E190avoUE4MRAYzPqrO8pf6WXNZtlRLmknUiFPk91gOPywjito1LJuatT3BgQf6UgZb5DrXs7TPptIqD4+9N38p6S9N5fkkj0glgpZYjaOCKOSyYvw5wHet0Nl9caZtapE7dFHiD5LeASnI6Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(186003)(66556008)(53546011)(316002)(5660300002)(26005)(16576012)(66476007)(2616005)(956004)(2906002)(66946007)(7416002)(8676002)(8936002)(52116002)(31686004)(16526019)(36756003)(6486002)(110136005)(86362001)(966005)(478600001)(31696002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hK3yM46uhz6jaEAxm2Jl8zieDFChHY6v2vLq+cFvHbdwM7fML4P7pT0tixCvK9fpcjFPzFUb9GYBs0P5d8M+v8yBaJ5zQASj53am4GLcv2KxK4LDysr7FMt/09u+P6LVl9tiWml7xx/LRNvKEGyzuBikmM4OMCnQdH3LnwchlzfxHyY4pC6nmEP/3Yk2ep6bJpE/x0mQft1InVcP28ecOkpdCAM+X7PuFa7JUfRkzcXjqTRnPaquwRKB0Aqsjw+dl/mN9PGGK7LJO4AMp3qu0xPAz0KnnYG+YqhAgwYbzB3CYHcWcxSbt8qxKN5ZKwOGqBZZ4bkRuT8I7UBRXS6Od3O31kJgAMXEYkJIyECtEQ2rDeVbwT//mbulafbNxYl/EX99D1mWEvtV07HjZ7nFyjtll3pKmKKIlEVuBADcWeid0Jgxd81mH+JqoZoxLkpsxAoDbPCZyHJvj5RIZSge4nGqJFAeDGfQhXFbpReqiL6tFV3Aq3hr+AEqcTL/2YKo
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dc5126-a2d0-41b8-cb3d-08d7f909269b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 19:49:59.5364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p27FAMca5h0I1WVB35sN2xylqEDOr9K4f6SmM7wtOm76mamMbfO/3UtbJRJs2qbfZjKu20S5Waecwse/LiTDBdn8wgp13vqeHZINSWVQAhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5445
Received-SPF: pass client-ip=40.107.14.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 15:50:01
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

15.05.2020 20:51, Eric Blake wrote:
> On 5/15/20 6:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> 
>>>> Max is trying to tackle the node-name issue:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03358.html
>>>>
>>>> And trying to apply that patch after staging this series hits a conflict in mnigration/block-dirty-bitmap.c.  Which one should go in first?
>>>>
>>>
>>> My patches are needed to fix migration for the pre-blockdev configuration with mirror-top filter.
>>>
>>> We ofcrouse need them in Virtuozzo, but it's not hard to keep the in downstream-only.. And it will be not simple to use new command from Max in pre-blockdev libvirt configuration, with auto-generated node-names.
> 
> Carrying a downstream fork forever is more work on you.  If the patch is easy enough to maintain, incorporating it upstream is best all around, even if libvirt has moved on to the point of no longer caring since it no longer uses pre-blockdev.

I hope not forever, when Rhel moves to node-names, we will do it too (hmm, I don't know, may be future already came, and Rhel8 libvirt is node-name oriented?) Still, yes it's always better to reduce the downstream overhead

> 
>>>
>>> How much we care about pre-blockdev libvirt now in upstream Qemu?
>>>
>>> If we don't care, than these series are only for downstreams, and we don't need to apply them upstream..
> 
> Eventually, we may want to deprecate pre-blockdev, but I don't think we are there yet, and even when it does happen, it will be two more releases with it being deprecated before it is gone, so we might as well make it work correctly in the meantime.

Agree. Better to fix old behavior first, and then do proper deprecation if needed.

> 
>>>
>>> On the other hand, Max have to resend anyway, to handle old code, which uses device name instead of node-name. And if we don't want to drop now the code which can use device name (needed for old libvirt), why not to apply the series, which just make old code better?
>>>
>>> ====
>>>
>>> In other words: do we still support pre-blockdev libvirt (and any other pre-blockdev users)?
>>>
>>> If we support, than, as I said somewhere, I need to resend these series as I have updated version in our downstream. And I think, I can rebase Max's patch by myself and send together with this all, if no objections.
>>>
>>
>> I'm going to resend the series today, let's look at it.
>>
> 
> Sounds reasonable.
> 

-- 
Best regards,
Vladimir

