Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A6220720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LCwjISlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A6220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuyN-0001pn-IB
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtuxX-0001IR-2Q; Fri, 10 Jul 2020 11:29:07 -0400
Received: from mail-eopbgr140138.outbound.protection.outlook.com
 ([40.107.14.138]:39054 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtuxJ-0005PD-Vc; Fri, 10 Jul 2020 11:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHL5EEhWc0JEtNhy23K3e05u5pWDpDhPkFhi9y22yubdutvBMbyvV3ZgiYZkCaEOQvM7KGrsJD7zD3M7h1GapibpNoSjBHKecw09KeteRMiAl8CacLONgVMLTJqFJ86bLZLl2LXfNEbfVKcfc8Iced7+TCTWdVYuq84tu1kWs7mF1SkS0RCE9XG9sQMRmWwCme+aEm3FEx0vP16A2tfVCg9Q6u8DRae5JFDBp4Snqvb0sJDjTaeui6LsJgRaFNL01Pa3Fc4McWvvyV9WZv+SWyiwjJMxK3k1TKOVDFtgcJh384zPZpVXpRgmYkOCYoLvx+ABJGD6oN8kHNN8g45uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joZ3zhj7ihFG7gX5vRd1dZOZXYXFi9vHRS5V6ZZbidY=;
 b=iiQvpSPswPHCF8WAN7G32vBkfbMSMl6jOBMSh5onqaEPBvScZ1K9aet/dObLfjSlgHjuIiB4hG2efNKHmec1h+KAKs/ch0PkYu8rN2qF0Rgkud5m/lqVe96gou3xKhCXRjATuqIIBJNCkxqB6I46E6lxBmnlCOXe18M4tRwW+Yk1yGz2Epni2AcvW2rtdD8FAKds0mcTItVX07o71GGKmqrUX8PyuSt7nRdj0uzaTac+u/RdPWnlGIbaP94nokF8Zzu/0skNomuhJVJdb2Ia2F/BdHpGmchI2aT+a4/8IZ4s5dz1t4py3IAGGujV1sdQsGnt6bAh5kg6Wu9tu4rwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joZ3zhj7ihFG7gX5vRd1dZOZXYXFi9vHRS5V6ZZbidY=;
 b=LCwjISlwtSRD6gUHWAVbh2CczUVcn1+FFleq2AkqmLT7pWz/dhEX790vJ5z3Yct3yuwPM1T6RxhqHT09AkXZhrmzEyRMA1rwZbiPMS8Nu/SGJqxWZXWfmyNdRAprV9F7qfp70jk1CnybikE1x0QBfeel/gr7Vrh5gs8MD612tWg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3864.eurprd08.prod.outlook.com (2603:10a6:20b:8e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 15:28:47 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 15:28:47 +0000
Subject: Re: [PATCH v7 15/47] block: Use CAFs when working with backing chains
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-16-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <3a86ed3d-c249-9692-939d-bc232c7490d7@virtuozzo.com>
Date: Fri, 10 Jul 2020 18:28:43 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-16-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0132.eurprd05.prod.outlook.com
 (2603:10a6:207:2::34) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR05CA0132.eurprd05.prod.outlook.com (2603:10a6:207:2::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 15:28:46 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad193ec7-4fb5-470d-9397-08d824e5f07e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB38649B7007DB4D25E252C119F4650@AM6PR08MB3864.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+UH8zAFzXw1APiicgTMNlFrSvTXZ1/mMnFYq49XYAhc7iiK23jGBfra137ywSMtub22SWbNe6aq5gPAwXsHOlZuhd0G4kdhKO/3T/V1CtM0VpeVcpLBhNhVm5Y+kUDCaV5EaQIjmEJJA0mj4ZcozNAwstDDEWeWU2RsuL8RKHHEAURunT1r3S+NB/WeZ7uEfpJuQfkxDlaSE/wfEka96aC27dflmrZywBmoka85Hd+F6NZbGN8QqP8Tsz8TUEJhy7a066bMJDbmPa70mf5xpxLBt1dtMarMdEYdo/pNSfZedxdfJsovVuiv4i9I8jkOiDqGsdFELiOH00GWhhXWn3t41DvfOlhfsQPjzIkKIdTF+3s/jSbNGJbn3DUo0HBI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(2906002)(6506007)(6512007)(53546011)(86362001)(478600001)(8936002)(16526019)(186003)(26005)(31686004)(83380400001)(4326008)(2616005)(956004)(54906003)(66476007)(316002)(5660300002)(52116002)(66946007)(66556008)(6486002)(44832011)(31696002)(6666004)(36756003)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1I2yE9oUGenArO33ag0SoMoXY6BQReI04xzg7CW1Td22Qa5OnF0huqcl+EZKHBvba3zNER4I8txpRklghtnnzttEHth0JLQL0dc1MFBATrqXX2Y64mzIKPOmhkbw3q42Y8nomC18RbRawMhU/vjpPLkARiHfsk6ydusip7zxciGteRpYfpabatKmpr02P2mo+3EpbzcL1T6fCOyTAiMMVqk3gtRoai9IpNmku0+CQWF9NX0leEC8LQW8+q63XhVkfZFvVlSelb4hk6t/4/PUPbYd7OpnScfdvHMjG6sNIIrAaCHTr5px+EsY+X2vWue3AeN2KX5aQe0gmYNlIQuD/SySnRRXXahJ5pqLtNVN3BwTa3+iaw3qMv7/1aY6EhIidD1CjJL/J4VFZtDIDYGij3nW4oJXTBSOTAL++qmIqaRKAcDKJcqQCAJmAZY5nVNcRovBoLyKMYHoXQCE1HdnlGB9wBpDLG48g39Lj3dwMqPQ13UavqcVv2tR6miFkq7I
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad193ec7-4fb5-470d-9397-08d824e5f07e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 15:28:47.8370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZZUfVEa/VobmxkUzxK2J8vVBbOagDX/ZQHYisgDtD+DETtqeN+oYVf21ax4kZwnO/D8Rbetyu03uxaxO946kbnjyuY/Vgv14qv/+znQWp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3864
Received-SPF: pass client-ip=40.107.14.138;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 11:28:48
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:21, Max Reitz wrote:
> Use child access functions when iterating through backing chains so
> filters do not break the chain.
>
> In addition, bdrv_find_overlay() will now always return the actual
> overlay; that is, it will never return a filter node but only one with a
> COW backing file (there may be filter nodes between that node and @bs).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 41 +++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/block.c b/block.c
> index a44af9c3c1..712230ef5c 100644
> --- a/block.c
> +++ b/block.c
> @@ -4724,7 +4724,8 @@ int bdrv_change_backing_file(BlockDriverState *bs,
>   }
>   
>   /*
> - * Finds the image layer in the chain that has 'bs' as its backing file.
> + * Finds the image layer in the chain that has 'bs' (or a filter on
> + * top of it) as its backing file.
One can optionally say "Finds the first non-filter parent of bs in the 
chain".
>    

...

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


