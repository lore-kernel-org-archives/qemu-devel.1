Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A696C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE122076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vGR60ar7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE122076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6NN-0005hH-0X
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6LX-0004hs-4C; Wed, 07 Oct 2020 06:06:55 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com
 ([40.107.5.111]:21056 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6LR-0004Mn-CN; Wed, 07 Oct 2020 06:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHy0WLGUlTJ5syF0GV5tnnakeQH6tZMcoXr6ANwIQXQoxxwfsKBENTAy53g98FbJzF3qjsg22wJdimHqKX7/Q4puoe/S0uUzX1HcFVOjALtwww8kGD1F8tMsYDzFYRK0oZqJ8fHHe4FtrV+MEMe4bc7z+lo2EqrGuH+VJrt+tVmVKBMqi1YtM1ACMHl7SC2nfiE6NiPzGRX+wizQ+m/U9DFDRoxPKisPx8bfHKqSCkPSEq2aPSYYhJooT4UI0Xj2fUqQJ1A8jIKZNUKKUMVSP99h5gwxmH1aflnud0DQWYQKBN1LTOM2LnsXAk7EUuW/6+ebi5TXYgB9pcsYuPMCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTAizQSMP09rj3E0BgE7iWipMsAJ2vbfqHBX5HAz1/w=;
 b=WPnBubf9gN3ERiSpVgS/lJvJjoAAXy/f2CgBIc6yq0wlYcqS47nW1pMrcBWDNEoIR81yYT+0phwvuPv5KFobzsRrfghrnvMPk9pVmN7gp8DspOojoFD/xn5jbYpiTAgkSBL9FLTNs07Ak78k0rDNqWCWKbQuDluN1NfS5SSbrAJ9OCIh0KYrHU0zMpbKjRjD6ukbs9amCqTuep7olJDaPVfgBlW6VkrU7XEO+tBCPkKvPzBGWyYC2ag+jsnv0d82HgfD33hdnTE/ZythQm19PzWbsNI+JriJkYeoKjjS0bPdQ4pTma3fPJaPAoJ7o+jf9a5MKmMxx9g44WftIongCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTAizQSMP09rj3E0BgE7iWipMsAJ2vbfqHBX5HAz1/w=;
 b=vGR60ar7zt+0g3foEbNWzsHQ3WJA58ZkNAne7xRGA3s+tSsLFg1QTdYft5m31NBTWLfG8eWEkGRsUs8WTw/JeBCSRaan1+hZAT+xf93Lkj+5G0lH5tFYqt9z1E19J9eXF2+3uS1BW8bYrecTC5ZiJd9APfMQOvBiCYrEjq3NZcc=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3575.eurprd08.prod.outlook.com (2603:10a6:20b:48::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 10:06:29 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 10:06:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v10 6/9] copy-on-read: skip non-guest reads if no copy
 needed
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Message-ID: <531a938b-4b76-c506-59be-eafc1ea85159@virtuozzo.com>
Date: Wed, 7 Oct 2020 13:06:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <1601383109-110988-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM4PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:205::29)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM4PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:205::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Wed, 7 Oct 2020 10:06:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab32808-43e4-4e86-47bf-08d86aa8a8e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB35758E279727ED83BBC93192C10A0@AM6PR08MB3575.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ActyUBsz3MFI7aro1jx82J/jDOAPV1oVLlhrgY5SGqkXBO8vYSGD6bkyuq1zroLxFbwqrrm/yxr9SlziwrRie7bQm05HkmvLISFkrysxZ3vnxoJh+hbrvFAJPAtQV9d5/cdMhROtv11oIMUnm9tiLkfseIV0Ak8/0zyfJmBvUl7/hi2GJrqPOfRI6yBRuJrysn3w2+XiMJ2DWIBMGkEaV+qrBJfJkMNoUa/+pkChzaPbgxCb4bIJlZw2egxTTa/oNPNQbUU156u7TE59JHs48aRDZquiEtxyUa9mrjv2599boW4Hi6qwHrIOSbXOFiIE6W0odpELEILCQQpq0NfDhHOm/UuqudjpZVIxv15XOz30E9GgSy0BJDQ5Jt3YwDo5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(2906002)(6486002)(316002)(26005)(16526019)(66946007)(86362001)(66556008)(66476007)(52116002)(31696002)(16576012)(186003)(5660300002)(4326008)(478600001)(36756003)(83380400001)(2616005)(8676002)(956004)(107886003)(31686004)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zIeNxopjbzLeyN66nwmDlI0hA/Nr+0/Z9QZTC0PqwSiR6Rm1O8cTMto0g+RBYV1Yp1076/23pJshcppqY3nVV1eOZaCtRvYoceFOYz+UHka6yJQ2BTu4lrr83V9Ph1AYOoPSMD64YoS0RkUr/mzeDHxJSS0FtC9AM+qdcIDX2vDC2vFsS4KkRsbg31BxDeS4yNakGzdR0lArJ0g4ngdVvGanTI8pOIDKyFtorNvrUx+ZcCV9E8z5MgmKItS03UPz32QgNxG5yncsShy2DCtkAQ0oCoK7HCrDZLbR9VybG3ZrKk4dpbz+lIr9TmV59AMEKXj9YCsRGgExo1DEj7qLX0dqFICCgzYfC1hDu6P1Qd3SPgWliznNogxW4qQpNqs6IC1ZgwIUqtRm0sc/5Z+ADlApp1MqcbHJheBPO0Bo93CA/m78lGE+tNJGQ2H3P/MR6IIVpGYlneGtg8FER5lJqXbDR4aus0BHa1ybv8Gy83E+Et24Hr7WvbUAZbWfDOcKCsxIdBabcmfMzjmPLsD18jISbQ3qaHzfMYXT/94vQ5zmBYosGhCKb1//um7tr2tJkIw+ulK4vC5ByMrzDkFEzY8OEO6cczvemu4S3++f2S+EOms2MK3p+GMi+zb29wVhfiKkSwaBxXJS4lCsOeV3/A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab32808-43e4-4e86-47bf-08d86aa8a8e9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 10:06:29.5070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqR4O6nMEIJCsoOj2Vja3pKmlwYkeLzMor2wBA+uUsqffu1b8mP69BqLXYkrlKHboHjYMLi+hOfqKc9CuZIRg36S/mdMljgBQnLeojtPDVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3575
Received-SPF: pass client-ip=40.107.5.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 06:06:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.09.2020 15:38, Andrey Shinkevich wrote:
> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
> COR-driver to skip unneeded reading. It can be taken into account for
> the COR-algorithms optimization. That check is being made during the
> block stream job by the moment.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 14 ++++++++++----
>   block/io.c           |  2 +-
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index f53f7e0..5389dca 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -145,10 +145,16 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>               }
>           }
>   
> -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
> -                                  local_flags);
> -        if (ret < 0) {
> -            return ret;
> +        if ((flags & BDRV_REQ_PREFETCH) &

BDRV_REQ_PREFETCH is documented to be only used with BDRV_REQ_COPY_ON_READ. But here
BDRV_REQ_COPY_ON_READ appears intermediately. We should change documentation in block.h
in a separate patch (and probably code in bdrv_aligned_preadv())

> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
> +            /* Skip non-guest reads if no copy needed */
> +        } else {
> +

extra new-line ?

> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
> +                                      local_flags);
> +            if (ret < 0) {
> +                return ret;
> +            }
>           }
>   
>           offset += n;
> diff --git a/block/io.c b/block/io.c
> index 11df188..62b75a5 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1388,7 +1388,7 @@ static int coroutine_fn jk(BdrvChild *child,
>               qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
>   
>               ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
> -                                     &local_qiov, 0, 0);
> +                                     &local_qiov, 0, flags & BDRV_REQ_PREFETCH);

Why? In this place we want to read. We'll write back the data a few lines below. What will we write,
if underlying driver decide to do nothing because of BDRV_REQ_PREFETCH?

>               if (ret < 0) {
>                   goto err;
>               }
> 


-- 
Best regards,
Vladimir

