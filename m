Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD0220727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fZBfHBv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD0220727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgTn-0002PB-HQ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBgIQ-0000Y2-Sc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBgIP-0004WT-PQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:50 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com
 ([40.107.8.104]:35022 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jBgIP-0004RN-HF; Tue, 10 Mar 2020 10:55:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePsrFSiGe0HPsQTByFbfpLbJ2ykh3B6i66k9NB8mxs73SB+q0A2QHqxwQQfuFWZmWP9xEdAx9/V6CecehOyUBfk6VIPimFJaV4r+G9m9jsrM1xl+VGX++WrgxFi0S6vT2DDFhDbGi2/zTdw7BgNeKRMeFxQecw3iGVMuvepPWIhM8QPgxmjYrdQ7J/Ol042sM+1yYOrtPlCIpZfv6Z4gsN4cWZ+x+bxPXrVmRPIxe/J4tfM8+hd+Cz/rY0JMIPhQwsH4BnWg5kfckR7ghTSKI6o+7NEfWLuPKBUSnv7dz9enbe+5GUWvqD3vexCGyt5cJsOWS1d1UCEIQhdhQIgCZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEKf6sQmYSYy/ZD+ghkY2jm6avDREmPMv26pgiyq/hw=;
 b=Uew7WTxTZOD7/V1uajBLZ1jBpLgNYFuYEUDj/dg8ZivI/9vEjExBhGBVHB20nUYUUfd2a7MaKtBMWHOWkJGw7MhsVpAsZQ7NIpu6SGf75jiGzqS2Bv8YvSIMZtXkBaUQdtWo9GDAN12/7sDwv6KoVo/67bhQJGVZKY8N+9tudOmk+ZBkRqpFKV5Ux5AKrq51OYplBNweIilLRwIJ8F6nvu4UItNY82pw9+HYDsGI9jiLjUZQgYoPF528HOzrl+zV6NFg5bfX5dwvrxFYmgPAmNMTLniDct3UJ2VBJArN5R6lDL044afAd7cq3xkrJkr8vNtvTKmNpbN2X9RJDNLW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEKf6sQmYSYy/ZD+ghkY2jm6avDREmPMv26pgiyq/hw=;
 b=fZBfHBv/YcqHtNWvdGtHG3zW1nhra/69IYE9YbSfybicI7R7w5l2oaRiczHIOhko8S/sQwVK70i0a8uHymez+XjBhUf9z3M3UDm6unhVzzlKSB/M2jzfOMWBPv1L4JZ1MLyJk6pvfWMkzIfiveNaTAqWj5eM+ph7HR8cwPYhCI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3989.eurprd08.prod.outlook.com (20.179.3.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 14:55:47 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:55:47 +0000
Subject: Re: [PATCH v3 9/9] block/block-copy: hide structure definitions
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-10-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <c7af156f-a9b6-2b9e-ae9b-10e9d13f2fd2@virtuozzo.com>
Date: Tue, 10 Mar 2020 17:55:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200306073831.7737-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::16) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0902CA0006.eurprd09.prod.outlook.com (2603:10a6:3:e5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Tue, 10 Mar 2020 14:55:46 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac81f340-eb67-47a3-e18b-08d7c5031de8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3989:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3989150152E4C96D591C4E0AF4FF0@AM6PR08MB3989.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39850400004)(136003)(346002)(396003)(199004)(189003)(478600001)(4326008)(36756003)(66476007)(8676002)(956004)(2616005)(53546011)(2906002)(36916002)(66946007)(86362001)(52116002)(44832011)(31686004)(66556008)(31696002)(4744005)(186003)(16526019)(26005)(6486002)(16576012)(81166006)(5660300002)(81156014)(316002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3989;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAKxATjasV9pbrgqhlAeEFAmn5kBuENVDfJ5YjdIsfbPB23FKbKqGfTlWB7fEm1zlxlqFOIsp7C6ELvBcs8IDX7RSlVxa2Wbr18e+UlJ4pibPR7HeClRNDzPsDGHKlm6qhZplC/8M19HchNl9mk6eybN60HJvEsOciKYbepj70zuZRmzj6vh/17pOsq1ip6iAaufs9VlTDSGqNvrd/Cfloc3NtHnPdNpvkUE6XRXinjkG2AdehK1qObsnD+aGbmH/dQHq2k0WKamI6SpL1S01NUvLMcT+nqmsuVvdyCYY2i68h8HwRNUozxyq8Zs4OGrzT0D9DDOAcjN0PA14wFkN/SzC8uEAVqUwQxyXzPksulDq/1bthZO35AvVmBRL4s7yXQ38/EAKu1ddgAlvjV+IFG3/oCq9mdRAmWFW2uR26gEtr+FUTZux+EJvXD7Yx3M
X-MS-Exchange-AntiSpam-MessageData: h5YY0lNHO0ZfLZANewlb5qNdQLztAjV/AuoqSUCMIi4Nf2WTJj2MSiTSRtsvuPOcmd0vSw6aesOgdOKRZgkq6OxC4nql671+z7uRtlxtrvRF7wId4OLPRkLpeCiQwViVF6GpVmBbp+uoZzl1DkEaNQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac81f340-eb67-47a3-e18b-08d7c5031de8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 14:55:47.4539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu6mzwUH1c5DKonG7NKW96vl7vbNxuQ+f/2phVrd3dByqvJpSqbl/K9JL9rbcPnOqISHDhAvYtyqXeY0dElF7W5EoKclLkn6xCXqXPcOPjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3989
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.104
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06/03/2020 10:38, Vladimir Sementsov-Ogievskiy wrote:
> Hide structure definitions and add explicit API instead, to keep an
> eye on the scope of the shared fields.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>
> ---
>   include/block/block-copy.h | 52 +++----------------------------
>   block/backup-top.c         |  6 ++--
>   block/backup.c             | 25 +++++++--------
>   block/block-copy.c         | 63 ++++++++++++++++++++++++++++++++++++--
>   4 files changed, 82 insertions(+), 64 deletions(-)
> 
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index c46b382cc6..9718c241c9 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

