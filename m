Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4397FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B39253F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 05:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pSIlUHH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B39253F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnElQ-0000uU-9n
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 01:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jnEkj-0000P0-Vq; Mon, 22 Jun 2020 01:12:17 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com
 ([40.107.21.115]:9057 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jnEkg-0005SD-PN; Mon, 22 Jun 2020 01:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqLKBw2RyAjnjQHvQxkkGFMBD79EOoQ5KOJ6Z8l0H4NfM3CGJWwYfW28WrvLIBd5jafpccgP4Ewgr/DBdwVVPNTWH76RVTnul0zzPi3ignO2BjoJMdTpbH8GMLNi96huQQStM600m0nFMUZKxHpKVzlvAu0DkmTaXAd13mmgLisx4CmwSa9GVj8k2ORFsL78A5axwx7nVZGAJHbbwPGiEARZBMzgLGopqgBcSpUl7Rawc8KM3JYdtzN5kIN2uv2zDcV+NjfzMn1LFsIye4Sf2PuZFzv6tW22jlq0UyMQuGFVFR9dGM0u73QAPGISo2TT00IYYaZwu8hWBUaem8+Ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iRHvAPdLJzaFUNpYIBnA9ZL+seaiG9eYgsmALK5VXs=;
 b=I3W49FgblGx7ozxAQyjC7UvA/rCVTdBp+13wfjiHlLmIZykJh5T3+I9NwvU04CpU7z+mWsRIV1JYrBlV+mD2sqLDHme60zBDPKzkR4SvS2YYtEMPPLsFrHlyq6Q0dUVIKZnA2XEv1ZIk2gvXHudhJ9MZFj+QAwSaOZKftgymlaD4XLQ1rFMa2YeepQ6GUI3YVC/hP7BSeAXq/wcFB72Gjdcp7xxchrICmnmzJJxI+1BnzN7zoftqNkU//mv9kG3Bd4IOSl+sYOFeuKArUBuJPNYoZ040hEY1+X6SzDFDSP3ppMk8jN/blFrMOFp3UCT1W8nd5DIYMPNoHSIu92Gzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iRHvAPdLJzaFUNpYIBnA9ZL+seaiG9eYgsmALK5VXs=;
 b=pSIlUHH4aqnKYekUXI6BlQRgDYE6NAf6OSb7B+/0XQBMWCxRgRQo8hlVNXd97yQQ/UJt8YWXI9stsnKNbxUEWCjyKu3KiiAL68oSbzrJ4fRJej+Ov76/aEb88alsSqcIhXdQ0d6xZhBNYzotPDZ6Q7DDLcvPbiIPN33sfPppqzY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5365.eurprd08.prod.outlook.com (2603:10a6:20b:109::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 05:12:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 05:12:09 +0000
Subject: Re: [PATCH v3 2/6] blockdev: combine DriveBackupState and
 BlockdevBackupState
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200619195621.58740-1-eblake@redhat.com>
 <20200619195621.58740-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a30c1068-300c-31df-cf98-c70d08725d3c@virtuozzo.com>
Date: Mon, 22 Jun 2020 08:12:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200619195621.58740-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:208:be::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.72) by
 AM0PR04CA0083.eurprd04.prod.outlook.com (2603:10a6:208:be::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 05:12:09 +0000
X-Originating-IP: [185.215.60.72]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 801a60f3-69c2-4558-499f-08d8166ad0a8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5365:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5365C76A9A6AA3C6F159010CC1970@AM7PR08MB5365.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGUwAXpz00D+7q5xuYoQ0NAOivM6fmuvayyHyl6y44oy7Vj1Mk9uFwBQfIT8rkqDlx9pcNaCSGV7gs6yPXbxnHYxjIgVNQH2K8hezS9UKtDdwh2BTc348gh8IBOkIT4IyPrFzgRt/THBoCErmUAudBfB7wbTrbn5WitGsLYGMJy3W7rw+iVzWvf0jYM8I5KuXEiG5crFfMS+OYh2oxldV3Ep/fU7feQso8085lYW9dR5MaRiLdvabrGLmTsR64eVtHLQEmtUuhWG06Cy6tydt4PEaO7LfVcDI7+vxlOrxhNjFILYBRzalNp4SuN8WFq5q6JJqnhLM65QC3M0aKXKhTPJ+RT1ojqe3Sm4He24m/13A5ZddpKkTVM/JxeMRBmV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39830400003)(396003)(136003)(52116002)(16576012)(316002)(5660300002)(8936002)(36756003)(478600001)(31686004)(8676002)(83380400001)(4326008)(66556008)(31696002)(26005)(66476007)(66946007)(2616005)(16526019)(2906002)(186003)(956004)(86362001)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MhMiP2eM2ehiXXIwcM6+IlH7Z0irODAPVpquMZlu43ZwD6rMAEEv+HjyPK+ooQ/L3mJZJ4h0ykD1SQFwBJ17dv40qLpIuK8sG6fvPMlubzC+dOijHS3I7P3nF6jDgyAizgBhfh/CZmv56IS6QICaGn7+Tfma1ajIdoyCb64F5xDj6DK3jXExroJcQT7Zlp/ObXyxKoRTYdNHSgdLGO8+MG/wgCHlEi36uUrpyq2n+R/VJ8hwElXskh5ccLWoC2W5xIa2wCOSKHIJcYKP2KujHTIU/EUpOVLz3NbPFAlmnMdtLn1/0Wezs+mFy+hLj2MyhnQ3Q/8gBNq13NSbWk2QvGmiPRd/SRxsJb47if7qDR4KE4i1Ct2e1/PJ7nNt8qbBXXeqpps9wX1ajjMNeOd52/TCR2oK7zQQhhvLqZc3eiC9sNrxexBR4/IsxNR+veAMqJ6umL8Vbb5eg5dsgj74yVihd9yfxY55eAoclrgBPX0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801a60f3-69c2-4558-499f-08d8166ad0a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 05:12:09.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twym5UZWk27yh2E51gzQZekHX5J8mm+h/ZiOtyduLl97c75/IXzaybsxhbRYnmUAhVgjq1HZvkAyg4sxjB72C1egkD/RycjZjtqhOoHQI1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
Received-SPF: pass client-ip=40.107.21.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:12:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.06.2020 22:56, Eric Blake wrote:
> From: John Snow <jsnow@redhat.com>
> 
> They have the same fields -- rename it BlockJobActionState.

commit/abort/clean functions are identical after it. I think better to combine them as well here

> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   blockdev.c | 30 ++++++++++++------------------
>   1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 72df193ca73b..6d80af903c55 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1655,11 +1655,11 @@ static void external_snapshot_clean(BlkActionState *common)
>       aio_context_release(aio_context);
>   }
> 
> -typedef struct DriveBackupState {
> +typedef struct BlockJobActionState {
>       BlkActionState common;
>       BlockDriverState *bs;
>       BlockJob *job;
> -} DriveBackupState;
> +} BlockJobActionState;
> 
>   static BlockJob *do_backup_common(BackupCommon *backup,
>                                     BlockDriverState *bs,
> @@ -1669,7 +1669,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
> 
>   static void drive_backup_prepare(BlkActionState *common, Error **errp)
>   {
> -    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
>       DriveBackup *backup;
>       BlockDriverState *bs;
>       BlockDriverState *target_bs;
> @@ -1806,7 +1806,7 @@ out:
> 
>   static void drive_backup_commit(BlkActionState *common)
>   {
> -    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
>       AioContext *aio_context;
> 
>       aio_context = bdrv_get_aio_context(state->bs);
> @@ -1820,7 +1820,7 @@ static void drive_backup_commit(BlkActionState *common)
> 
>   static void drive_backup_abort(BlkActionState *common)
>   {
> -    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
> 
>       if (state->job) {
>           AioContext *aio_context;
> @@ -1836,7 +1836,7 @@ static void drive_backup_abort(BlkActionState *common)
> 
>   static void drive_backup_clean(BlkActionState *common)
>   {
> -    DriveBackupState *state = DO_UPCAST(DriveBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
>       AioContext *aio_context;
> 
>       if (!state->bs) {
> @@ -1851,15 +1851,9 @@ static void drive_backup_clean(BlkActionState *common)
>       aio_context_release(aio_context);
>   }
> 
> -typedef struct BlockdevBackupState {
> -    BlkActionState common;
> -    BlockDriverState *bs;
> -    BlockJob *job;
> -} BlockdevBackupState;
> -
>   static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
>   {
> -    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
>       BlockdevBackup *backup;
>       BlockDriverState *bs;
>       BlockDriverState *target_bs;
> @@ -1907,7 +1901,7 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
> 
>   static void blockdev_backup_commit(BlkActionState *common)
>   {
> -    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
>       AioContext *aio_context;
> 
>       aio_context = bdrv_get_aio_context(state->bs);
> @@ -1921,7 +1915,7 @@ static void blockdev_backup_commit(BlkActionState *common)
> 
>   static void blockdev_backup_abort(BlkActionState *common)
>   {
> -    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
> 
>       if (state->job) {
>           AioContext *aio_context;
> @@ -1937,7 +1931,7 @@ static void blockdev_backup_abort(BlkActionState *common)
> 
>   static void blockdev_backup_clean(BlkActionState *common)
>   {
> -    BlockdevBackupState *state = DO_UPCAST(BlockdevBackupState, common, common);
> +    BlockJobActionState *state = DO_UPCAST(BlockJobActionState, common, common);
>       AioContext *aio_context;
> 
>       if (!state->bs) {
> @@ -2209,14 +2203,14 @@ static const BlkActionOps actions[] = {
>           .clean = external_snapshot_clean,
>       },
>       [TRANSACTION_ACTION_KIND_DRIVE_BACKUP] = {
> -        .instance_size = sizeof(DriveBackupState),
> +        .instance_size = sizeof(BlockJobActionState),
>           .prepare = drive_backup_prepare,
>           .commit = drive_backup_commit,
>           .abort = drive_backup_abort,
>           .clean = drive_backup_clean,
>       },
>       [TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP] = {
> -        .instance_size = sizeof(BlockdevBackupState),
> +        .instance_size = sizeof(BlockJobActionState),
>           .prepare = blockdev_backup_prepare,
>           .commit = blockdev_backup_commit,
>           .abort = blockdev_backup_abort,
> 


-- 
Best regards,
Vladimir

