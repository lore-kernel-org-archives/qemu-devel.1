Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80253C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F4920738
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 09:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gWvJfeYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F4920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Kig-0001qM-Dh
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 05:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Kht-0000y0-Vl; Wed, 19 Aug 2020 05:48:33 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:47342 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Khr-0003hS-CY; Wed, 19 Aug 2020 05:48:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5JJPF3/d8flGh/piDKD7sjPg7L4xhhEOz3pgdvh8ZgtGM7fp8Be57UBCz9vVj+qhCn86qVsGIES/TOl/8nw1tJkliSBXDFrepcHTtu6D6HokPL8R4PTsZwDWX7AmuLbDHE+sfWP7ZsEjfyvz+vINi5o6WnlpVOYxf767qRNRiNno2f5doQvyZFd1LiZHGkpU9Nw/+I6OiiTKdNnhyOlUFUkjYxR3SC0myv4C8nvcMXks4oAXJOuACJuCKKXNYlS6ufUvsvdRu9kqtxFUAiVKfmQE9F3ThFEprFYBrSjP7dompl7SA4Uw7VjC20mgzGNRiH/hyiNxGA29D1WSWmutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vzkA0RJBsJ3Gfuy3w0yifRaf9dz3KK3YWtfJG3TwHU=;
 b=h/M7KrNv+nKj/1wGDixL8eTp/zCOcVpRHhygEhh07NjSTXg4M94r01amfDAtMArfCRYz9FlucKcaqTamKVt/95B01dCbL2cuksRbMLn01bmqjNe3/6Ww4D+myzY6SocZCbnO+nP5jukubNP6758/KtLmIlkqrreb5Bt839mVV5pECh/++xCXVwi/sY6EdKzmymy7mtoGO6FEilirWTnSnfjMOf24D08qujjoiB+GcTVOPIOTs9DOhdDWZYMukWtRKPL18TJM/0mrQirLPmtUxmQfOeqnXziXnDqL56Va7scZSrxtgrIcLsBV0cp2Ke2Il8t5wQ1Vb3DqwyUDABXzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vzkA0RJBsJ3Gfuy3w0yifRaf9dz3KK3YWtfJG3TwHU=;
 b=gWvJfeYfJlZU9G3WEWrt36fUfoIuL60SY/BcZ4GrZ4wus5RRbqkswH+1ciz3pDtSTed0rzhykAfWq2itPsjvAkrDx1zDwFpajud0j/XfdvupBUTuC/uq7e9Y/RGyXBfX7FHk75eRn0UK6JoTs8lAwrnewbZYAJ7MYBS+3ahb7do=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 09:48:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 09:48:28 +0000
Subject: Re: [PATCH v5 1/5] block/io: fix bdrv_co_block_status_above
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
 <20200610120426.12826-2-vsementsov@virtuozzo.com>
 <w51lficjb0d.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <57758b78-227a-c753-db9e-fe503b163927@virtuozzo.com>
Date: Wed, 19 Aug 2020 12:48:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <w51lficjb0d.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0701CA0011.eurprd07.prod.outlook.com
 (2603:10a6:200:42::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM4PR0701CA0011.eurprd07.prod.outlook.com (2603:10a6:200:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend
 Transport; Wed, 19 Aug 2020 09:48:27 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e119408-395f-4dd0-489b-08d844250601
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841FDDF74FFD4494D9CAF83C15D0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg0kTscfhWW/kISkI/ZKYJEO69zaNwU+9Ce9s5VRjn7BkSZyEvyn+djZ90PZePOcr5UIPMMErOoVRlQrhubc/d6nUpAoQlqn7l0GbTRCzu4BzBF+OHx4uNLXwOr83fOufFyeR4rfiuNfypXUVUeh56/H47gZ4b7EH2Eq74gHNtUtEspYKP086fFN/BMwuXKkb91J5SDCZlQFBAT3zrRN+0kmdFwRwfKWo2Re6g4Uaum8bxKsBlOkf2VzDf/jLLN9Mg+WPv1dwzfbg82EcP3jxzXsuzs7YGlIpitSjWwRM/Zs6ZNTBuUe/BDZfDGIJqUiYBSa33APjZoJa9bRMQ467qOBV4/RizWg7XFoLe4XDagjgvLIvoaw+S/CCm0UQhDd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39840400004)(396003)(366004)(136003)(6486002)(186003)(2616005)(36756003)(26005)(16526019)(8936002)(956004)(31686004)(2906002)(52116002)(8676002)(16576012)(83380400001)(66946007)(31696002)(66556008)(4326008)(66476007)(5660300002)(316002)(478600001)(86362001)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SNbL+w9yYHxV0uY61ICQMh3QqiGL8wrSL0ydzNZkDSUgxoEDUVRSruWgMZR6GjJ7qz6UT0bkjLjkcSqwqQ16+R/cPck8oPzoyR2jSdVt140s3XwT4Joe1EE/P6xtwYUUhL8wgu7hV8ioQpD85RTEkjgMv+/jue9mQ6dL4aG5UivGV109qe0Sgy1+PqJjrHLDkbhjc/IK5SVmjmO/2pw/pV7OfoawI7h+usWJYLtqDGBRpsg066Zz2uwOpC2tefOynSZHxibz5Ow6BmkbDtXNRft07Oohfl680uiPQZjNdXAZ7ggKiOmri01+wvnvPledKGpYwa9HVMZ4GkZ/F/OXC7oR7/HBFyN+sZlzFo0Xn/LoFlrqa5ob9ncWwI5s6RhNZkZ5OG/x+4h9LUYWXInKeqph0gZqOrnY2+oryCtl+NC8dhBUAUaKpfnhBxU6wfURQ7ksOd6WLf5prQa3HyP9nx475Z++NBkCNYMEFprKUMAvX7xag+1tbm9HsNkAMym3ShVIpSzvmA8F6YrV1ni9DaLjNbz8qxLTMtygD9ou2r+5W1owOcB96wAsazlu1pDVQVwSxCI5GrVvPYB0ocUWU1++0B7l1j/qomY6ZTYPTspODxyR+AJ+sr2y2h+/BKUOEJh0246/wKdZo238dex85Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e119408-395f-4dd0-489b-08d844250601
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:48:27.9624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jvcn4UjbArIuwG1+ZzEOTUx0Eo3SNfcnqVmFXjwgq9lRYrlmA8gMelh3F3Ogy3brgMnlBwRnGf0/+Pe/mor+DEo3tsNyR5G2qQYak5clk/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 05:48:29
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks a lot for reviewing!

18.08.2020 17:15, Alberto Garcia wrote:
> On Wed 10 Jun 2020 02:04:22 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>> +             * The top layer deferred to this layer, and because this layer is
>> +             * short, any zeroes that we synthesize beyond EOF behave as if they
>> +             * were allocated at this layer
>>                */
>> +            assert(ret & BDRV_BLOCK_EOF);
>>               *pnum = bytes;
>> +            if (file) {
>> +                *file = p;
>> +            }
>> +            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
> 
> You don't add BDRV_BLOCK_EOF to the return code here ?

No we shouldn't, as this is the end of backing file when the top layer is larger.

> 
>> +        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
>> +        offset += nr;
>> +        bytes -= nr;
>> +    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
> 
> About this last "... && nr && bytes", I think 'nr' already implies
> 'bytes', maybe you want to use an assertion instead?

No, on the last iteration, bytes would be 0 and nr is a last chunk. So, if we check
only nr, we'll do one extra call of bdrv_block_status_above with bytes=0, I don't
want do it.

> 
> Berto
> 


-- 
Best regards,
Vladimir

