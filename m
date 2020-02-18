Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9090C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886B321D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QiVpFtmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886B321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48rJ-0006Zn-PL
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j48nY-0003Ld-J7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j48nW-0005Fk-UA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:44:48 -0500
Received: from mail-eopbgr70139.outbound.protection.outlook.com
 ([40.107.7.139]:57238 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j48nW-0005A3-2O
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:44:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuoM3ouRTpVUxugKEpZhnYqPrfM4/SwQjPHSXI9PlityMcNeVFHcAMp5S6G3OUwECBLPBeqBpzUzm/4rqjpDpIe/vtokBm2qiyOG1rTtJp0YWB8cYeZCfVBaciZXUo0VOibkTAN9oIb3XbKBNXvMGyHGGQ5h9gWpM9wfXUuBmPAxgqpnfOrFCHfwJG2CjIAVr4mvMRbCuVwHElLf1AURu6XYEnaCiQqRZ4ZVrFyvV9Udb3u9ELWqRJF8zqsOUYKHFs38bqO07jmdtTuDsW10ZXB7wS+o+4FyyGqGzPAUWZ0vbNumURKS3R1OWmCOLOM0e6fmaBOAXyFEfIBNzEgcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ6PTErX11dS05hPAJenwl3X9Nr1VdsRcsEYh3CQJ1M=;
 b=Vg+fnsmsjO5/MGXk8x2OJ8kwJkHWnPnCSZBP3JdfvzsRUFPlXMwyp5kGuEVo4oVO+x69ihrepKNqJZ9Ez/C/faX3zjo/jTyBS4PPLzRuyiMiCkgrSbi9Ny0lz1K3H17Nch13OtNqEQyearbXjpH0lWDuhOWOGpADcju2OoPLVOvBnDeFqSO71+fJrHhEjx69anqMD3Hz99ArZR7nd+jiTVZKKB5wOpx/o7J2INQxf+03A9MlTxBPlzV4VH5WPC0JVYp80LnXTq5uOr5t4ILv8vsg04qnW7Jg2E5dC7hX7G8GexyjQyqa2KyMkvoKFtDQgv7XAN7TrVj0YxEwIfhRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ6PTErX11dS05hPAJenwl3X9Nr1VdsRcsEYh3CQJ1M=;
 b=QiVpFtmM3sh64l/6bCjDMMyMrq23/2IHzBYBvgvXVWlocfSy8OT5Li/QELH2kA/t7A2UINyt/LPNCg6QApxwy4sHognd+AmZIxCxZuOvqQ4/7pd18k+W/Ap6VoLUWKKzf+JtWE82mePyUVJphXytcvbShgH+8GSCoeuNoIlRRoA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5207.eurprd08.prod.outlook.com (10.255.122.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 19:44:43 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 19:44:43 +0000
Subject: Re: [PATCH v2 11/22] migration/savevm: don't worry if bitmap
 migration postcopy failed
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-12-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <ec181633-d2cb-35bb-e07c-78edffdc6dbc@virtuozzo.com>
Date: Tue, 18 Feb 2020 22:44:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 19:44:42 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e46c8ad-82e6-4074-3851-08d7b4ab0029
X-MS-TrafficTypeDiagnostic: AM6PR08MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5207D5099F4F614FEA64F7DAF4110@AM6PR08MB5207.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(396003)(136003)(346002)(366004)(189003)(199004)(316002)(16576012)(956004)(86362001)(36916002)(31696002)(26005)(2616005)(36756003)(66556008)(52116002)(6486002)(66476007)(4326008)(81166006)(2906002)(44832011)(5660300002)(53546011)(31686004)(8676002)(81156014)(478600001)(186003)(16526019)(66946007)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5207;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRVm5+dFn5/avhzLQ5/DOCVsdKNbkvngiOy3a9S1yDLOwlffLGcgRTiXEQi1kk+TkvJY5RatM3wXptegjNDeKhOh6PJEa214Ijs0BdvRzPg5/BKbOvwSo03ysTIOK3m4IpuMnNSt30mFGEtymq1bJDdZnO5iw5NvWLDxdPCVeieB1zK6tSsnt03y6CSVQnOJmv9bVM6PODXVbEA18i17tTubHdayTbu5VDWqvVKOLY0nxVfYEBvMZFY+ntHQm2+3Rd5QtDThBHvvKMKgzDyJky6NE+BLoGjhAJ0OFxd04maxxeSNtoEYHds0r5M3a/T2LZmpkqF7EtRVjRpvnXyBk1rj4JvS0XdbnpnwDPJtAIAaOXAEeW9kJYNWgFPSTKl69b761LfituxvKf7TMtKt42wvrAD0EpHz7Xeh9yYPrWfpVm/OmoVxvZsW808dtvaB
X-MS-Exchange-AntiSpam-MessageData: M1LdhfcQ7yMOuBS0W17g946PRiQ++9i5QbW1yPq+FmJ1CeUXlKBtfvbpqt3jE4PWBvI3+x8wevgR/f2DnrAwQzkm0b08HhKXMXm2ubnz04XmFiW9o7vpHT6NTVcZ+OlTk57tWr0NAVgyRkA001dLYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e46c8ad-82e6-4074-3851-08d7b4ab0029
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 19:44:43.2382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgcT70uXDCNT098+Ts+/vSzwFnElJvhxm5+nJwDYXs6SbzOMxFoKlYM4OqpkBHY+9N+R9mvdBTUB1SjQXHQ3MTmKqRfspT++n7NviHh5IKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5207
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.139
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> First, if only bitmaps postcopy enabled (not ram postcopy)
> postcopy_pause_incoming crashes on assertion assert(mis->to_src_file).
> 
> And anyway, bitmaps postcopy is not prepared to be somehow recovered.
> The original idea instead is that if bitmaps postcopy failed, we just
> loss some bitmaps, which is not critical. So, on failure we just need
> to remove unfinished bitmaps and guest should continue execution on
> destination.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/savevm.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1d4220ece8..7e9dd58ccb 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1812,6 +1812,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       MigrationIncomingState *mis = migration_incoming_get_current();
>       QEMUFile *f = mis->from_src_file;
>       int load_res;
> +    MigrationState *migr = migrate_get_current();
> +
> +    object_ref(OBJECT(migr));
>   
>       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> @@ -1838,11 +1841,24 @@ static void *postcopy_ram_listen_thread(void *opaque)
>   
>       trace_postcopy_ram_listen_thread_exit();
>       if (load_res < 0) {
> -        error_report("%s: loadvm failed: %d", __func__, load_res);
>           qemu_file_set_error(f, load_res);
> -        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                                       MIGRATION_STATUS_FAILED);
> -    } else {
> +        dirty_bitmap_mig_cancel_incoming();
> +        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> +            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
> +        {
> +            error_report("%s: loadvm failed during postcopy: %d. All state is "
> +                         "migrated except for dirty bitmaps. Some dirty "

"All states migrated except dirty bitmaps"

> +                         "bitmaps may be lost, and present migrated dirty "
> +                         "bitmaps are correctly migrated and valid.",
> +                         __func__, load_res);
> +            load_res = 0; /* prevent further exit() */
> +        } else {
> +            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                                           MIGRATION_STATUS_FAILED);
> +        }
> +    }
> +    if (load_res >= 0) {
>           /*
>            * This looks good, but it's possible that the device loading in the
>            * main thread hasn't finished yet, and so we might not be in 'RUN'
> @@ -1878,6 +1894,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       mis->have_listen_thread = false;
>       postcopy_state_set(POSTCOPY_INCOMING_END);
>   
> +    object_unref(OBJECT(migr));
> +
>       return NULL;
>   }
>   
> @@ -2429,6 +2447,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>   {
>       trace_postcopy_pause_incoming();
>   
> +    assert(migrate_postcopy_ram());
> +
>       /* Clear the triggered bit to allow one recovery */
>       mis->postcopy_recover_triggered = false;
>   
> @@ -2513,15 +2533,22 @@ out:
>       if (ret < 0) {
>           qemu_file_set_error(f, ret);
>   
> +        /* Cancel bitmaps incoming regardless of recovery */
> +        dirty_bitmap_mig_cancel_incoming();
> +
>           /*
>            * If we are during an active postcopy, then we pause instead
>            * of bail out to at least keep the VM's dirty data.  Note
>            * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
>            * during which we're still receiving device states and we
>            * still haven't yet started the VM on destination.
> +         *
> +         * Only RAM postcopy supports recovery. Still, if RAM postcopy is
> +         * enabled, canceled bitmaps postcopy will not affect RAM postcopy
> +         * recovering.
>            */
>           if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> -            postcopy_pause_incoming(mis)) {
> +            migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
>               /* Reset f to point to the newly created channel */
>               f = mis->from_src_file;
>               goto retry;
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

