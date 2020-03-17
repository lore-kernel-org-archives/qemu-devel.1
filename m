Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB7C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B615320757
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QpphJtSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B615320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBPj-0008Je-Tp
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBOr-0007iA-0N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBOo-00062U-Ca
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:32:47 -0400
Received: from mail-vi1eur05on2071e.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::71e]:45248
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEBOj-0005Sn-R3; Tue, 17 Mar 2020 08:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLvX4mRChgHfqhcEJkiKTJCkPkk8EKgoM2l3nNmOZVfR0NVBPgZj96rnzu72OXyWDXOnH8gt5yODvCy2akF/nmNwKW/BOwgnLcv7W67Qh2lOJ2iCeTO1nQAQ/li+fhIt6WMehvcXK0nwwU4Q212c9B3uAtCZJWxIqVayIGNzszdjuhvI05ywqLVPNg7kDzOQB5t14ukliAd9e6/W+AYX5Ip6RXQQBZwkFMbvlHyGjV5y6zSi80nFatR2P8PZyvLCc4avfOzdnPuuxkJzEsx2BgcLxrFDbP9Ibf1TC9tOZQFQcF0SURZ9XbtZpqkRH7iKOTcL69DjqLito4jZvJKJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3vTXC8xMiEBn2buP7Ihg0MvGRNUVQLF1XsJIShv8fs=;
 b=k+/0ZZu10iyGnIr3gIy65LF+f/LIUzAIIQuhoNF+qL9kChv6LAYWJj+VkyreBNEj0J0PlPDzOJiqIbj0n0iit17juCtyTREmaHLsEtzjO9XFAKFEOhFAlGF62vqcNOS8iarHe/hcks1F7XNUogZxwgerhnDTycUgCEdaLxf1ALda42waHpmjQFfl6zqdx6YYRb/mKLPn7FXzOpazj7m+gvPLIOnkbw2P7OtadSsN0FZ0J6+gxYbp+hIEI03vqQ5GpAlauo1lzlyHo6Pk2h06zOnPRktdO3OHqQ9d7FpgXpCFGlu4K/6Qy5xzaTCfRWull/lgCdKtqvan/yRopKRXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3vTXC8xMiEBn2buP7Ihg0MvGRNUVQLF1XsJIShv8fs=;
 b=QpphJtSfuk6o4XWffpQ2g/cXpCo3gOirUtePc0UqNG4nEy1dCXpkCc//+yPGagTbt10QYi8Iex7Cbh59qSjR8r05mj3+uwvhbXM0/tmRfel09FOPAmm/scvMKMMABjSROD109rbEiphWUsyKcu5sGW24vpjO/HPr37CE1PbOnxg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2441.eurprd08.prod.outlook.com (10.175.34.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 12:32:38 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 12:32:38 +0000
Subject: Re: [PATCH 3/3] xen-block: Use one Error * variable instead of two
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-4-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317153236121
Message-ID: <d6497746-2ed5-02e0-1934-065db818c1c6@virtuozzo.com>
Date: Tue, 17 Mar 2020 15:32:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200313170517.22480-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0073.eurprd05.prod.outlook.com
 (2603:10a6:208:136::13) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 AM0PR05CA0073.eurprd05.prod.outlook.com (2603:10a6:208:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Tue, 17 Mar 2020 12:32:37 +0000
X-Tagtoolbar-Keys: D20200317153236121
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41cbc76a-bb82-48ee-432f-08d7ca6f4715
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2441:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB244108D7D25ED2D55C4E7DACC1F60@HE1PR0802MB2441.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(199004)(81166006)(5660300002)(81156014)(36756003)(16576012)(86362001)(6486002)(316002)(8936002)(66476007)(66556008)(478600001)(66946007)(4326008)(31696002)(8676002)(31686004)(52116002)(2616005)(2906002)(956004)(26005)(16526019)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2441;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/+cNqze4SLTfjgkfx9Nzzrym+gbPT8+7Izg2ppJ2Sax7NySMpFWjWTxdtegyAn14r65tusdjb/ggTUl2yGokyjb5NmKHjtBqyf+DpqUfIwyIGwRud59TItdm2WnDBvDtJjNDr2Iw4bw2GybnrJ6xTVw6D1ebiZYzEVhXEhL87Y9Q8TgjDHQBRUGlR+zkKndth0Ir3rm1UNiN2feIcY5k158IEz/voyGBfLCyLJagAsd0B+ZDRoXm3J/mgz1JeYN5yAs1IztImyL7Q7s7y8NeZz/lYgohT3eKmOh63pkZdcZrPBJ+E8SyRUSGb2rlfakB4Z11Ah422K/D3T/BiazXFqpY1K1sX8wB7BclO8LwTda4ZI8DwM8RtQ+AM0NsvdwpjKUYEzxsRssSPeDKufxLVIePTRoiyEo+rI82GqR6Q6EQfmR2jESSeuchSCFsdpQ
X-MS-Exchange-AntiSpam-MessageData: Eoyhz45RKfrnqGcsBIWmuD8gvRbeVw0sb2VzLH6eR0OxavBBBkXFyH0YSaMrjs6VsywfwmVs6+n8VYY4loIRonS4Cb8OZ8bTSGk9tgj20M3zx1EzuMfpuH6mdSrq21mBS6PIzALO+CYji8/aHa9pkA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cbc76a-bb82-48ee-432f-08d7ca6f4715
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:32:38.2149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1khEr5F3tq/WPxKTn+qvQTPqwKB7n9214G6DXVLKv7NDKAMG+RYFg7KitOUch85j/Hiy/F13qswTVWuj6/JPp0+HN4GVTcI+b4O1fDK7Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2441
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7d00::71e
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
Cc: alxndr@bu.edu, paul.durrant@citrix.com, ashijeetacharya@gmail.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.03.2020 20:05, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/block/xen-block.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 3885464513..7b3b6dee97 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -998,14 +998,13 @@ static void xen_block_device_destroy(XenBackendInstance *backend,
>       XenBlockVdev *vdev = &blockdev->props.vdev;
>       XenBlockDrive *drive = blockdev->drive;
>       XenBlockIOThread *iothread = blockdev->iothread;
> +    Error *local_err = NULL;
>   
>       trace_xen_block_device_destroy(vdev->number);
>   
>       object_unparent(OBJECT(xendev));
>   
>       if (iothread) {
> -        Error *local_err = NULL;
> -
>           xen_block_iothread_destroy(iothread, &local_err);
>           if (local_err) {
>               error_propagate_prepend(errp, local_err,
> @@ -1015,8 +1014,6 @@ static void xen_block_device_destroy(XenBackendInstance *backend,
>       }
>   
>       if (drive) {
> -        Error *local_err = NULL;
> -
>           xen_block_drive_destroy(drive, &local_err);
>           if (local_err) {
>               error_propagate_prepend(errp, local_err,

Hmm, no "return;" statement after this propagation. It's OK, as there no more code in the function after this "if", but I'd add it to be consistent and to avoid forgetting to add a return here when add more code to the function.

(and if you do this, you may also fix indentation of string paramter of error_propagate_prepend...)



Anyway,
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

