Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B97C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5EC20707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M5aqL8bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5EC20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWRC-0002Nq-Sr
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixWPh-00011O-Mf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ixWPg-000342-4I
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:32:49 -0500
Received: from mail-am6eur05on2132.outbound.protection.outlook.com
 ([40.107.22.132]:19937 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ixWPa-0002xu-O9; Fri, 31 Jan 2020 08:32:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5frjGlOlds2l0X9u8xgvya1N8GBG92mdkHYTT13mQLNEH7Fs04uu7W2sEYKrE/dqeWa0hZf4tgiXHCh7qsjVU0nh1B9L0pV1C5I6M0QPut/QvwIOGFgxQ3lGnNJNi2hpOkWVWz0kw73SafPvFCf6v7mrOzVF12Igl6Q42fkWdvc9bmVILW85633qSCt7gQT3s83puKpBGna+HwSWnrFdt2Zftfav4SHekula3PDt12RSZGCYl2qe3k/H9Jzb+B3sXcUVZ2H8eLI8KD7dDC1XUA9L7KnU7fliNh+BEcFYVpE7ULVz2l/O87QF9L3QJ6XwYtolkqd64w8nfaPHOE/uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFYAep/tS6mwUtZH26H3avQEM2YOp38cuQd9r662xUg=;
 b=lr/613s1S2vejZnKAh4WkKmqQe30VSpQK24VL2j3bQjjjqDMSHA4qR5e7wERun5k19XFifZu1GWOT88CzvLxmFuVWsW/SFoNNkxCyK5SkVxlxv8QM/dhXGH351Y2oQkysIl8U3WwSTvzQ3YLownFlcVS/qndICyJoEM8bsCRoO4a3Nr9CUd5T7ItAo3AF+2BL44DP1Jqera9Aw7htvfPfbhrBa+hM3fjL+syZWyidcYEyaSadsmABRkccpIs6TZIPx6mNMyCHbjWJlfM2oQOewRFx0b9/LEFrLE3OCLK/5Zh7sTV6tm4VnILaZhRtlQl6eTgJI+zGUNeGRobtsNo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFYAep/tS6mwUtZH26H3avQEM2YOp38cuQd9r662xUg=;
 b=M5aqL8bmgdV4BmNChy3XMr2BB1k1UtzeUWK+mEFOtAhVyblMeiKhDf6WGI5aQoaHyeB754RMl22dawX+rIII4V9HYmwn9VUTXcRq0yJOC0BVzdJXLCZjhYuief8cc+wBbzS5NuOvmgzn0WR9OdiwVlj2vCr+5g+xjJlcxU6bGQI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3701.eurprd08.prod.outlook.com (20.178.90.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 13:32:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 13:32:40 +0000
Subject: Re: [Xen-devel] [PATCH v7 00/11] error: auto propagated local_err
 part I
To: qemu-devel@nongnu.org
References: <158047636035.17955.5913248840185467774@a1bbccc8075a>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200131163237327
Message-ID: <26ba57f0-8a7f-c73b-ccab-b2811af24d3d@virtuozzo.com>
Date: Fri, 31 Jan 2020 16:32:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <158047636035.17955.5913248840185467774@a1bbccc8075a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0362.eurprd05.prod.outlook.com
 (2603:10a6:7:94::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0362.eurprd05.prod.outlook.com (2603:10a6:7:94::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Fri, 31 Jan 2020 13:32:38 +0000
X-Tagtoolbar-Keys: D20200131163237327
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a7f96a-7fb3-4ceb-016a-08d7a6520b05
X-MS-TrafficTypeDiagnostic: AM6PR08MB3701:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3701FA92430A0A3F12BE549CC1070@AM6PR08MB3701.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10001)(10019020)(39850400004)(396003)(366004)(136003)(346002)(376002)(189003)(199004)(2906002)(31686004)(8676002)(52116002)(81156014)(8936002)(81166006)(7416002)(316002)(16576012)(4326008)(6486002)(16526019)(26005)(86362001)(66946007)(66556008)(186003)(66476007)(966005)(5660300002)(478600001)(6916009)(31696002)(2616005)(956004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3701;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwgG338uH+J2XkH5g0MTCLrhZcoQzcaaTp/U40TdkzOaTbgVBjfwFuwmeyn5/ivm/ReiLev226n7IoaRx2aKJvCyaucqPnFFnXzBcZHe8kFvM3kZnvxrC/F/z+9FKlkUAYvo5vJplrzXOEVLrGOmGx86r30YmN6NYR5KWArkBewHDWMwxXWrznjzwo7RzVpICwbjTIpjS0Bza5MPdQOSroybQeer3u+9nUJdXrdNH+ec6gf7HViJzaXO+gck1WmqsyD7Ej3knuuCPX4PU2DYXtBf54HxE9uAERl7pmGe7VF3k9zE47i+WKYxqltbrqMFfD1cBf1kGKE/gB4/SXikm//ZGXAhjIVsmnX5GYoMgEe4nhbZdt50h1XWOImH1mkg7T/0At9c9ha80gWzThxpq4y6NmooS1IigACpcpbKhIdcNkqEIEZQpE0/iWfcTRLEZ2pZm+FohjlKl7Ungtdcr5b0BrK73lDqHpZm1WZ8yjVBmRbvPmEC84rLZi/3pn9imRTSbZi8r53WdhZfMfh0LXU4ny3xMLSeWqf+6S+muFxnt4M/QTJ8oc05csyJ4e5GIRt30dqmesYANuImP5Wbsg==
X-MS-Exchange-AntiSpam-MessageData: X4QUHuGp+/GaFbC2LY5a/bunhzK3NFfE14fe6LyVt+l8xBWirGqFldHtLOJJuKfcW1wgx6xyZ7dps3ue6E0RgI1LeI6H5OJfCUN9p3La1cHFAHh1dUreLt7J4GkgmCggkRGAlEvXNXC3OYyF9zvDIQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a7f96a-7fb3-4ceb-016a-08d7a6520b05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 13:32:40.0869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf/vCjL5pqouBXMuHa6kYKz7D2pHHi07mPFHUZQcHRumxo92q9ITDMhmswu+QqJwxXKVIaU6UYl/joeiANjzpWh+pbBtPGy94jRIkGxLv+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3701
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.132
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
Cc: kwolf@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, paul@xen.org, lersek@redhat.com, groug@kaod.org,
 armbru@redhat.com, kraxel@redhat.com, stefanha@redhat.com,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, mreitz@redhat.com,
 philmd@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 16:12, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200131130118.1716-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Xen-devel] [PATCH v7 00/11] error: auto propagated local_err part I
> Message-id: 20200131130118.1716-1-vsementsov@virtuozzo.com
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
>  From https://github.com/patchew-project/qemu
>     9281736..adcd6e9  master     -> master
>  From https://github.com/patchew-project/qemu
>   * [new tag]         patchew/20200131130118.1716-1-vsementsov@virtuozzo.com -> patchew/20200131130118.1716-1-vsementsov@virtuozzo.com
> Switched to a new branch 'test'
> b0f4834 xen: introduce ERRP_AUTO_PROPAGATE
> c704561 nbd: introduce ERRP_AUTO_PROPAGATE
> 238b4d2 TPM: introduce ERRP_AUTO_PROPAGATE
> 56af634 virtio-9p: introduce ERRP_AUTO_PROPAGATE
> 8dd497a fw_cfg: introduce ERRP_AUTO_PROPAGATE
> cd54750 pflash: introduce ERRP_AUTO_PROPAGATE
> 031d7ed SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
> 7dc91c5 hw/sd/ssi-sd: fix error handling in ssi_sd_realize
> 57435c4 scripts: add coccinelle script to use auto propagated errp
> 0883f29 error: auto propagated local_err
> df0db83 qapi/error: add (Error **errp) cleaning APIs
> 
> === OUTPUT BEGIN ===
> 1/11 Checking commit df0db83cd18a (qapi/error: add (Error **errp) cleaning APIs)
> 2/11 Checking commit 0883f296ed8f (error: auto propagated local_err)
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #139: FILE: include/qapi/error.h:427:
> +#define ERRP_AUTO_PROPAGATE()                                  \
> +    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};  \
> +    errp = ((errp == NULL || *errp == error_fatal)             \
> +            ? &_auto_errp_prop.local_err : errp)


It worth it.

> 
> total: 1 errors, 0 warnings, 101 lines checked
> 
> Patch 2/11 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 3/11 Checking commit 57435c473bf1 (scripts: add coccinelle script to use auto propagated errp)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #34:
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 167 lines checked
> 
> Patch 3/11 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/11 Checking commit 7dc91c560263 (hw/sd/ssi-sd: fix error handling in ssi_sd_realize)
> 5/11 Checking commit 031d7eda4bbb (SD (Secure Card): introduce ERRP_AUTO_PROPAGATE)
> 6/11 Checking commit cd54750748f4 (pflash: introduce ERRP_AUTO_PROPAGATE)
> 7/11 Checking commit 8dd497a506bc (fw_cfg: introduce ERRP_AUTO_PROPAGATE)
> 8/11 Checking commit 56af634941d2 (virtio-9p: introduce ERRP_AUTO_PROPAGATE)
> 9/11 Checking commit 238b4d2c886f (TPM: introduce ERRP_AUTO_PROPAGATE)
> 10/11 Checking commit c7045610d28d (nbd: introduce ERRP_AUTO_PROPAGATE)
> 11/11 Checking commit b0f483460534 (xen: introduce ERRP_AUTO_PROPAGATE)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200131130118.1716-1-vsementsov@virtuozzo.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

