Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851DC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D3E206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hRsRinKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D3E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBKe-0004yO-OX
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBJY-0004Dr-KO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEBJX-0006tv-GU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:27:20 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com
 ([40.107.20.120]:27489 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEBJU-0006Lv-KO; Tue, 17 Mar 2020 08:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv9/IsF21qPzhIKyVR/VsUX3I2aJSsojWmYIEkafjvnhAXaI5SV51f80OyUEFZbmEz4Aj9qR4YHf1upPgcX/G9/lGKfgJAt1hucry7IUi65XJExcDyo+/CvB7yjqy90m6//hYHAoOKO94Mdh8AxFNzhWFG83wn1PiqDZJAcj/UoDAJJLndsazrXBnKgKMN31S5CaSJQjGTXqSBV8aX/L1AeRxOQawFFh/juR0YwrB39wr5goseaVaPREC5cH661SmmkKbxBmllT5lwGAkQ3B61eeYeOVFe+B7CzjOb8knCsTVoinv1alEX+Qce2LwxZIOK1dkACY0f56z/E5O4M4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfNpwvqJMKkK1fnRZoSh/ohgpsvAm5VnNtrUQW73jd4=;
 b=F4ylTj0ESjdcC3gTpZ00gERXc0Ao0MHWaCe1CYT0/TchR97n5nNoAbZzEuzlop5aAoyHF4FBQjUlY2i97+q+m15nx82kuyGUUYmmLXY1VJk20zFJbxnLtmKC7EcFyN4ezxiS+BO0FVM9BG/Us95vxhK9w7S/TKhS1gT2xeo6Fa3kjqsC4WkvzTqnRY1zb4z3jm4Dl/iSZobAnGb/XIJPZyPqdsIViAW52OnlA1co55jpV6+3yRh5H4TkmVRkCinq1u2zLRuFxD0jJigZzN9UW83X4LajcNsj8sP+P/lFk9sxkqWIIG8XNg5kDGzBymhIcccRn+qxR7vspAenoND1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfNpwvqJMKkK1fnRZoSh/ohgpsvAm5VnNtrUQW73jd4=;
 b=hRsRinKXugrQ4bo5eVguBg8Hs4wAYZGTKbE9ORzJq3NLK7qNgjoGZoDuEWIcbCuW/WAku1WhDVtgzEClnp8ZVzOzkVmMmHoZwxzso0GwHUIsnEWQHr0FhDsbxaoEo6WCvGnKEcRkUhK75jMlcULxS7idqr5b0b9KWwW4L5jy4PA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2441.eurprd08.prod.outlook.com (10.175.34.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 12:27:13 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 12:27:13 +0000
Subject: Re: [PATCH 2/3] hw/misc/ivshmem: Use one Error * variable instead of
 two
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-3-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317152710979
Message-ID: <d56f5218-dd68-f9a8-83cc-90452eed41bb@virtuozzo.com>
Date: Tue, 17 Mar 2020 15:27:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200313170517.22480-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0054.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::31) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 AM0PR02CA0054.eurprd02.prod.outlook.com (2603:10a6:208:d2::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.18 via Frontend Transport; Tue, 17 Mar 2020 12:27:12 +0000
X-Tagtoolbar-Keys: D20200317152710979
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83927067-f9ad-4e5b-f970-08d7ca6e8560
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2441:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB24413C45CD908202DC53750DC1F60@HE1PR0802MB2441.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(199004)(8676002)(31686004)(186003)(26005)(16526019)(52116002)(956004)(2906002)(2616005)(6486002)(316002)(86362001)(8936002)(5660300002)(81156014)(36756003)(81166006)(16576012)(4326008)(66946007)(31696002)(66556008)(66476007)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2441;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tuy5pQ4wwqJK+lJwI6ikpSY5CFRsm1xZdV/E+UD7mc+hlKVDSU/0qvu/fuCP4EH6lFKkvdVZyHyAj/imA+Ak3wBfBAzcYxuEWXAxPIweLAiyJCbrp8tkPF3PLBKFvKICKZEhK/TN+PXbX5jLs+LJ0APS8QWPqTUbGI28lvKb4Ze5XhmsFDaxc63XMwkJFJi92RuF+nZDCNs/2gKx6uUQCbzaf9/WN1Dg7Ft431TDEG1Y7iT8JmvjVZeNWcqec+q/3OvI8hhXqjFoqCzd5jevSp94h3TdCbYRUsAFqSk9Y4bdu6aepi2sAsWR61qxqA1pyU/93PJNwoozz6JRw9IS3qO5j/dtfDKlp+Uvmy7XaUk3gu7jrhIRn6k6iP+nMS9eeagNZYZtT+czx6G0daTEUY1ZnolkPjwW0CZRuNq3pCleNteO/UxghbFcB1GkPv62
X-MS-Exchange-AntiSpam-MessageData: VX2ihQjGW0jd2+L5NUTV29wCvjejZ5WH+veyJOkgmxKhKpwl0t4mpmUpIt11PZw5G2C5iDwQlCME4gAR247bnUaCkGdeih/j5QOPmtrdo8LvzGMsfN7I+rIPOZSmwB/0E4yTH5mnsBiWnsrAT+1T0w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83927067-f9ad-4e5b-f970-08d7ca6e8560
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 12:27:13.1411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFFMbOPIgOgnsLWzzkELhgr20RYujsUoTcS4OsR+Ladk78DK/2YbIpXE+lfmLXIy//owqYiWPs65Ahvgwlb7gmhbg39qmDBbd6NhIQ/hmtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2441
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.120
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
> Commit fe44dc9180 "migration: disallow migrate_add_blocker during
> migration" accidentally added a second Error * variable.  Use the
> first one instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/misc/ivshmem.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 1a0fad74e1..a8dc9b377d 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -832,7 +832,6 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>       IVShmemState *s = IVSHMEM_COMMON(dev);
>       Error *err = NULL;
>       uint8_t *pci_conf;
> -    Error *local_err = NULL;
>   
>       /* IRQFD requires MSI */
>       if (ivshmem_has_feature(s, IVSHMEM_IOEVENTFD) &&
> @@ -899,9 +898,9 @@ static void ivshmem_common_realize(PCIDevice *dev, Error **errp)
>       if (!ivshmem_is_master(s)) {
>           error_setg(&s->migration_blocker,
>                      "Migration is disabled when using feature 'peer mode' in device 'ivshmem'");

Hmm, if you want, you may fix this over-80 line while we are here.

> -        migrate_add_blocker(s->migration_blocker, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        migrate_add_blocker(s->migration_blocker, &err);
> +        if (err) {
> +            error_propagate(errp, err);
>               error_free(s->migration_blocker);
>               return;
>           }
> 


migrate_add_blocker returns error code, so we can just do

if (migrate_add_blocker(s->migration_blocker, errp)) {
    error_free(s->migration_blocker;
    return;
}

With or without this:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir

