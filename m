Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328ACC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F199F2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q+BcRLBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F199F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRtX-0003dV-2X
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jwRrH-0002Gz-58; Fri, 17 Jul 2020 11:01:07 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com
 ([40.107.3.91]:30380 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jwRrA-0000i5-P8; Fri, 17 Jul 2020 11:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtQ/2OioqBIynolR+lqTSfGSVW9dbqA4dPaU6RxkqqTLH6oqlyCqNB7dEb1GzeKMhSHQxVo57fNVxEYZR64GIFF4pwACqDyFKBTVVcwIzUOxA9G5btktnC5vbbKI+CATg3z5kKH+wgUpbFfVBL3IjLKDNmTgQ3/Asu3bXAYxFWiO4dRtE9dus6fsmbHbhqmVoI4AAtPPWFCSU/iThRy82Skf3HS6o1kUTPjNEXmEQ5k1dN6iunGSnaBxbpa8nSrnbeRH7KhT2RssSoit6KlvDOqIM25UbonFPgjBoj8IpGVQCREkyW0pM1H66/sXg7gQkeuvE5c8ZUhdBZEsIcWKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8qoplOCrbgtxqu6rR3sHJ7TzU1uQMdiyIuTdkTVbv4=;
 b=l1ha+bPSZJYMaFiBKysMvJfS5gThJ4fjipZGAneexiTZ/w/usRyT38uksN53k4gmEPyKsBYlAVyC2vA3qRzMI53+UdVSKlAocbtjWmOWskR1QqjpSafDmzGB6xMvT+mmEvFI+Zc0picN6gjdWKP2B1zZp2JHbsQyVCDTsnD1XjSGEbBKdpeABd2szT1F3P5MtRyAUx4zhl0kN2cRB8X+cjqFJvJVA5lOTfciMK1wDICxtAKzgGSkwNkXmsK6vTrcDvK8/h8QUEbHm1ma4wff8NRDnhRrcZXS4hy3lN9svmAJzneGwjSjQmHMnUdlMacpxRdQFg9KvPNkKckEFZrapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8qoplOCrbgtxqu6rR3sHJ7TzU1uQMdiyIuTdkTVbv4=;
 b=q+BcRLBaoo5QAg9EySbNViA7/uxlu1ipRb/kUSmQsEX02eEg1bX5R5DZdOZK/RjFbm0H6+9C335L3drlfmPmIHVlK+Fq0kNRNnCkEUf4lcRNdL2EgqjyqYGsRb5zgzxRmGEGEpEp8afSq4PwnT2n9rfX5fZJXF3ZB2aPv6+VidQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 17 Jul
 2020 15:00:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 15:00:53 +0000
Subject: Re: [PATCH v3 for-5.1 0/2] Fix crash due to NBD export leak
To: Kevin Wolf <kwolf@redhat.com>
References: <20200714162234.13113-1-vsementsov@virtuozzo.com>
 <20200717120119.GC4550@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fb53ce2e-74a4-65c2-4347-878a88270591@virtuozzo.com>
Date: Fri, 17 Jul 2020 18:00:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200717120119.GC4550@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0003.eurprd07.prod.outlook.com
 (2603:10a6:200:42::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM4PR0701CA0003.eurprd07.prod.outlook.com (2603:10a6:200:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.11 via Frontend
 Transport; Fri, 17 Jul 2020 15:00:52 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c4e9f7-be31-4397-bb3f-08d82a62336b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4916FF018DE6FE9767E80CC1C17C0@AM6PR08MB4916.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAwE/DKEhduu6OV5loYeZHjCpkDr48F4IQNAxfD42UBJjSNMr8BrvoEku2jk/A/shXdbagYmZ+8E2kineQbY0sX8cwXDHC4gtqrazm1wRap8chTksLu9xIkKy/rnMrCOyyorNSxJunEE6zRpj3e5l/0YpW6nSXYbEnlA2yiIT4UFTsPkjg/ghNB+x9IDAODWQSQqf+b+TQ2ksiGXS9dD7yp5rR25m8UCu5JBJV3HSVu5vGdBnVk074lwIYwYldhlJy2iAWJdPdeAYA4+iB11+edEk613xp/DHJfamcV+2OcMryD/WBushqWXT4QgbyGr+iIqbQJNvMZ0ohfWcNSFL7MOwByJ3Uj66NDVIrGaP2SsE376kiA8elfM1ZsHNbBL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39840400004)(16576012)(107886003)(8676002)(8936002)(6486002)(16526019)(31696002)(186003)(31686004)(36756003)(316002)(4326008)(86362001)(52116002)(6916009)(5660300002)(66946007)(26005)(66556008)(66476007)(478600001)(956004)(2616005)(2906002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zgl6vLMXjaKGHp7IbGONEe9c8IjREZlZuv9i4AyIEqkcL7NSosr0OJWyH1aL0oxZnm/tl0GuyiB3JBoY/PIBxqeCd6Yl/cJofadbHzCk4BBakanwexe0SkL79SEXhQKhsC8IOuTA0XDFMugQLfBoZzWC6MhPnnpGlgbHcMb13JJnOC3dTZMIqhTIrv0gcpa3Zvl+iXzQQ8+qei3WZzHBG3Lqv1+REeSGzIYn+q9TCJFzU7vxxknjqkwQtS4pJhDXXxCKgS+3b+XpSF94HK9lHiLBP64ghuPN20/JNBLBw4SSrFQyLByFI38U6hA5s8Zns3o9uki27pUWu7IUIs11ZydstPL00UKNEpRv30g1UzZL5unYnXmBmxRf6xHsG3XHjHNU+xIsd3qG+dy9Oorf0QrdMYS7FNQUqDQ1bqD7/Cfk/42WV28x53pocpxlCRM1GUoZo9kdGoiV3AWcWYIQ+JrCnlROxRZARsFfxKZKBEs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c4e9f7-be31-4397-bb3f-08d82a62336b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 15:00:53.2328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QdIG3Q8OC1hHJZzo3e/CCdwcSfNqSBJ9P/jcM+07HQXyQYjaTlTYC8kYV2WDPGV+3gQUveFalPev75q+YRtM6/utIXYbsUYikGxoDUU1jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Received-SPF: pass client-ip=40.107.3.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 11:00:54
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.07.2020 15:01, Kevin Wolf wrote:
> Am 14.07.2020 um 18:22 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Hi all!
>>
>> We've faced crash bug, which is reproducing on master branch as well.
>> The case is described in 01, where fix is suggested.
>> New iotest in 02 crashes without that fix.
>>
>> v3: resend for convenience, as all preparatory patches are merged.
>> 01-02: add Eric's r-b and t-b marks
>>
>> ====
>>
>> This is a crash-fix, so it would be good to fix in 5.1. Still neither
>> Eric nor I are sure in patch 01: is AIO_WAIT_WHILE used correctly?
> 
> Anything specific you had doubts about?
> 
> At first sight it looks good to me. It's always called in the main loop
> and we don't hold any AioContext locks, so using NULL as the context is
> fine. You also made sure to use aio_wait_kick() so that we won't hang
> even though the condition has become false.
> 
> I'm applying this to my block branch now. If your doubts were about
> something more subtle that I missed, we can unstage/revert the patch.
> 
> Kevin
> 

Nothing specific, thanks!


-- 
Best regards,
Vladimir

