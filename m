Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E4CC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C880C2072E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 05:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W8krcXEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C880C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJVut-0000EL-Tq
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 01:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJVtv-00085b-7D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJVtt-00006O-W9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 01:26:55 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com
 ([40.107.8.105]:9159 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJVtp-0008PH-Tf; Wed, 01 Apr 2020 01:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeOdco2nC4cjMOfYX0zORjo7TvXR8UbmGnPMj6eGBIsavd8s7uReoNG+/keypMRkZznVFPzozbF7tSh5qaTBA5NEJ/ixIvY31os029jbXDEF/7I8Z3KN4R2ooTwUKGD4MvMP/LCzd5ktShFPNizp8q32XA8qXIT9QW/Hex8nkwgSl4tBBJ6gFzkemgGC9s0BjuwIvKTQ/GGbTx2gxXT6RXDPZd3Wx2P8wVrRthRhd+q5PBXoBQvpsJUref93T881J1TLtew4rsA6YEVLGTQVf8yAfQqRTohM7f9HNqXiUjV4VRSF3/gZT3hpJplJ34CuEZs9AuRIpSFAuwXuqhbFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cfoJqSrFri16tk0nLamd+AbImiJZydbWTxmlaZ5mSc=;
 b=aQDx6JIKDW2qdhIQFC8QovmkzvtL4p2Z71YGwgtDaPqoi2A1evj3y2vJ20NrbvgnJRqfwSoDJFzQP7RldNMWfZLXXuH4svp8uQyxIEikJnIury4564Zw0zenO1MG2zDhXPjQy6XbHaa1Gl0ElNBF9wvV0yQJOIKiEDRM9H09zfTh2u21Cy08oaIRRh7bXxX0C5CZYCn9ejHxLUU+GBHTOyj2Yz4wER4eXA/jjVTL6/KQ5RUudSlkd1YPXyrKXQlgvXwOXV7sx5vhecKu8af6MGsTOPWU70mq3gN10/ig0yPVV1iCvViwy36OB+4XOyZ2sz1K7XGWyuj+xXwCNvEVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cfoJqSrFri16tk0nLamd+AbImiJZydbWTxmlaZ5mSc=;
 b=W8krcXEMvhs6iakt34rScOnK0i7o12c0W4WaVulhVLnV30q4/Bex4PJ1VPqVsRyt8FDAlqT+Vd9lVEgQp5ER7TENuX4bvoZzkSyTPA+iaMXLJBOtjsucqLYJMUJ2A6OlRypzLML7rpDO3/45D8IczvJSrOIDmIo7H1tFyPNvGEI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5301.eurprd08.prod.outlook.com (10.141.175.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 05:26:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 05:26:46 +0000
Subject: Re: [PATCH for-5.0?] qemu-img: Report convert errors by bytes, not
 sectors
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200331222442.273158-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401082642591
Message-ID: <7ab7ad47-b910-f837-cc69-6663d1671e2e@virtuozzo.com>
Date: Wed, 1 Apr 2020 08:26:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200331222442.273158-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR02CA0020.eurprd02.prod.outlook.com (2603:10a6:208:3e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 05:26:46 +0000
X-Tagtoolbar-Keys: D20200401082642591
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19945fd0-56a5-4d42-00ed-08d7d5fd4574
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-Microsoft-Antispam-PRVS: <AM7PR08MB530143DB59756FBE77F7A639C1C90@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(39840400004)(136003)(366004)(396003)(8936002)(16526019)(478600001)(86362001)(31696002)(52116002)(956004)(81156014)(36756003)(5660300002)(2906002)(81166006)(966005)(66946007)(4326008)(6666004)(31686004)(8676002)(316002)(6486002)(66556008)(54906003)(186003)(16576012)(2616005)(26005)(66476007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lY9mGDFKTzciTZC/yurNQEq+5Wx6TfWekz51JBYQeOR8rB+ZnGeXuMY+r5VVR6nveixk1xNJZFXlx+j1nWuvvPP83VDvDdwrfSJO70/g2nuyTQ0hwF5hO40rrZjeP+tevQQ40CF1JrAGESDSQSfn7GE1R05MH+oV9UIcLxNxTjcDkQCf1bM+7JkyrDtdTBzemlt5DZI96v90jFQ9KhJ1+DAWLRKivpBHXINTF+9GFM0SLydjKp9tQLlXHyeZQPoEXuE1EKuez7cj/qA2dOEeWfyhGiZcEWS0SJmRpTqEl4vC4gts5Kyqvw1WkGNOvRAjNNxGEk495Cd6Fhiseh7NkkRFtthLnxRXtSlSXWvgejIX+YBtkx30zTY7/CAZLa4qxTl8VFobx1cV71cI+NGr4zdr+s5PGMrgoNjjWsnEbR2H/j7yC6fumxq174MTdW4efKtaz6cFdYVtSPD3oY+uqKRWoPEnt3dzckKNQmf3F/4eervlKZn1TPeEJ/ZMHQszM3aIiN8izWBY7SQGa+n+xQ==
X-MS-Exchange-AntiSpam-MessageData: aZi6p1vD3YP3V8qpG9bdsnRn5q0WnZohL6a5ti/zRoa5gYYmsKX31RPySqf/WvArMRQYUVoMhV/edk5bOp2cekHbp9PpATZfAG/T5mm5no4OSU64yB67s35MO3HGq1RzueaWqjBlNDMSxhtsZmDb9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19945fd0-56a5-4d42-00ed-08d7d5fd4574
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 05:26:46.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htEDpgBxZgJUyALEGbBcjKoQKJCWF8KLEJVIfjGMa2zJ1JstNtSA5+L5nrhQ+E+/bp7If0LNKysVXDhy6licnW99k18Z8oiv+O/SaLxzVvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.105
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 1:24, Eric Blake wrote:
> Various qemu-img commands are inconsistent on whether they report
> status/errors in terms of bytes or sector offsets.  The latter is
> confusing (especially as more places move to 4k block sizes), so let's
> switch everything to just use bytes everywhere.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
> 
> Noticed while investigating https://bugzilla.redhat.com/1819240
> 
> By the way, I found it odd that even without --salvage, qemu-img
> convert will process up to 8 EIO failures (based on its default
> coroutine depth of 8) before finally exiting, rather than quitting
> immediately on the first EIO failure.
> 
>   qemu-img.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index b167376bd72e..77219e25b33b 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1924,8 +1924,9 @@ retry:
>           if (status == BLK_DATA && !copy_range) {
>               ret = convert_co_read(s, sector_num, n, buf);
>               if (ret < 0) {
> -                error_report("error while reading sector %" PRId64
> -                             ": %s", sector_num, strerror(-ret));
> +                error_report("error while reading at byte %" PRId64
> +                             ": %s", sector_num * BDRV_SECTOR_SIZE,
> +                             strerror(-ret));
>                   s->ret = ret;
>               }
>           } else if (!s->min_sparse && status == BLK_ZERO) {
> @@ -1953,8 +1954,9 @@ retry:
>                   ret = convert_co_write(s, sector_num, n, buf, status);
>               }
>               if (ret < 0) {
> -                error_report("error while writing sector %" PRId64
> -                             ": %s", sector_num, strerror(-ret));
> +                error_report("error while writing at byte %" PRId64
> +                             ": %s", sector_num * BDRV_SECTOR_SIZE,
> +                             strerror(-ret));
>                   s->ret = ret;
>               }
>           }
> 


-- 
Best regards,
Vladimir

