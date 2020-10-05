Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5EAC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442572085B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h1Nb7Jcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442572085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRqV-0002dk-Ar
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kPRpM-000254-Hm; Mon, 05 Oct 2020 10:51:00 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com
 ([40.107.7.101]:4726 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kPRpI-0007VD-VN; Mon, 05 Oct 2020 10:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLo2rm2CiZqejpZ8us28q+HrcZJwDpu8HtXTg1PkytfJLgU1fJlYxOi58tZ3Ds1ZKUvjY0oQRYD6KUH70DWHbXBoChmAT78ZljrkTOqaH/trytrFiAaDRr9OTsP6d/ESAMePxJH3lH+z1uBNEJ2J5rPXdPVWTDKjXQ2E0oFj8iSm+Ch0YXzCGYS6WRKLWrp9zCFuJaAiT75LrQM3Jbr0RLaR/q3a46GZcu5grJW3DCijWO4tjmpDssaDYzdIg2rI0LGyADUe+3QKOScIXXpUTXzgczyzs0rjZA0nYumpAeXI/e/e0j7yZ9tU83FL/XLORekg0R7diurVCSd33cAGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaVYVgPmct/iKJ4SoWidnNowOZbrfK4uT8u6UZ/05SY=;
 b=Mop2dOAytTjYayNUqwtJ5W8wvJNaFUTgebSMLJu/hoAPJUMycikewfn4+k9/Ja3GUG5RamexFK06Oe9NbGK/RMHl1nwPOxU00/sYWvUfwzzIhMdwhFATqKWz4pu1JMQj5J3VHyZ0hmhB7rmUuteFbsuCvm+HD+FRT80V94zYxfukTb3UmHe8n7DpUjlQGdB5MBf6Egw221QSvdXUgVaRoKbPlXvIto6dYmiSOdAjKG/DMN75ZbXY5JoHFu84Tr9cAVlkprCE9L19fKXK7qlhg8F40zgD9nmVATKKmE5vA+LIJFhYUXi9nEwrdDe0FjADN/79yQ/pMTmG35WLgNCLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaVYVgPmct/iKJ4SoWidnNowOZbrfK4uT8u6UZ/05SY=;
 b=h1Nb7Jcx1rCc3VV/mD1RbwHcG04jeDbqtYctebx7dHgfdVDt8mtySziKm6eqA+8cJ8A37Sk8EwK9FYcSpQij+k6b4lDmPGsBKpQPNPfJeILksa1VXWG1Mb1w8aRUHqa5pr6duvG2KyeCON2MfSALJ1ONu5yRLCo6sHW1OTE5sIg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Mon, 5 Oct
 2020 14:50:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 14:50:50 +0000
Subject: Re: [PATCH v10 4/9] copy-on-read: pass base node name to COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1601383109-110988-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e59fb7ab-9454-e4f1-db8d-c6916e65a8a3@virtuozzo.com>
Date: Mon, 5 Oct 2020 17:50:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <1601383109-110988-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.116]
X-ClientProxiedBy: AM0PR06CA0113.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.116) by
 AM0PR06CA0113.eurprd06.prod.outlook.com (2603:10a6:208:ab::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 14:50:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4223c5f-3001-4c00-32cc-08d8693e0d13
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB29818EF313B79207E5416FDAC10C0@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIVpYS9r8Ye0YXNbAOwk/jXeeUik28s7pGz5TW6cebK332gtudb3UiLIqs6uBloPoOnYqJ8VKkMtkQVF5NefeLcQz+yIsAMakkkx4EVqPL6TTnY59KHumx8btyDxuq0gHka5rP0m85CUNHIVry8rWfleglMnK26EBuOkiI4f9BK/X7akNDeFkV/okioA8Oy9yl2KvMIcGRJMzjToTxAT/VhO/2VkMTLa4B/RxY+3SifhJzOGETUO00TVq4b3UxPvLsETWvvwG5av3d8gKisNrlySTaLCX5/AmUNrS9kmWKV6VtsPnXVjBJW8ungMGcWMRyFFGN25TgWE2OuCsZc8fNS8TFjsb7Awo2vUfFzsV8HRgjS95iHx7zRk5fE/1NRy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39840400004)(396003)(376002)(8676002)(2906002)(316002)(956004)(83380400001)(31686004)(2616005)(66946007)(478600001)(66476007)(66556008)(8936002)(31696002)(36756003)(86362001)(186003)(16576012)(107886003)(6486002)(26005)(4326008)(16526019)(5660300002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vnn8t4NQIepQLYfRLYuFnTmYVfZnYcPc4XQH8X1bkRAL0sg4KSpnfD5rNYsmfiw/AmFEs2umpDmGbYvyCJCklstwXFcgvJS5XeUFOMTuc2f9Oh0fls83fBukA18/Sksh8ajp5Rmm0r9OLq2iQiaKNQtFlZiTSpQTLwLQS1UrU8hq+kNfSU2b1prsHe6Twpd4qAAlqdJT+io3HbN5Y5rxVarnHjP6IMPGSMIIGikzjDXYrxf2VhM0qM8T7jKL6aloUZKFGJCCVWwD8mrYdeJxR1dR57C+veX1Ft3zQ/qJp+Qi39Pfde1v6ZYv2Er3S5hsGnAgmWc54SRhgMUWqzRY/kn8QVilNhqEGIAqmeOHOQiqiPgbVCoDPJXtWfGz1xHvAyNF3SZ3RpXdo1csKu3oin8qoNOleLamvX+/9+h4xL8Tvjersza7NhWmLie6gVs7oEv41Xnr3EwBlLY5bqagnwau6Fqrx4pcoWRUA9U6q/9bWLZdXGNnzaJK5zf5e0zDZgso1AmmHPHw1MrNGmlrvqKplgLxMobjYtpe1FxT2vwdp0KwvUFp2HM9DNrbzK8vDKL/rm0+2on3ya8foIf51+1dlwVKQyyaa+JFAKGX3E4+dPljw3Rjj4uQsbt8FTa4fi1etbdP+hX5TajrZC4ptw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4223c5f-3001-4c00-32cc-08d8693e0d13
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 14:50:50.2271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpAlgGSN0oZBY0VfBBpBS0UxDHjnlhqW3NDDmCVky1PjQ6dPJj1Vmh39tdNBbtEJcrt6eJF/Hx9goeC0SVEiwJ2epWTzAvhjgYllM2/0Xew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.7.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 10:50:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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
> To limit the guest's COR operations by the base node in the backing

Better to drop "guest's " word. We don't to limit the guest in any

> chain during stream job, pass the base node name to the copy-on-read
> driver. The rest of the functionality will be implemented in the patch
> that follows.
> 

Oops. Seems we want bottom-node, not base, in according with stream job

> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 3c8231f..e04092f 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -24,19 +24,23 @@
>   #include "block/block_int.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>   #include "qapi/qmp/qdict.h"
>   #include "block/copy-on-read.h"
>   
>   
>   typedef struct BDRVStateCOR {
>       bool active;
> +    BlockDriverState *base_bs;
>   } BDRVStateCOR;
>   
>   
>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>                       Error **errp)
>   {
> +    BlockDriverState *base_bs = NULL;
>       BDRVStateCOR *state = bs->opaque;
> +    const char *base_node = qdict_get_try_str(options, "base");
>   
>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>                                  BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
> @@ -52,7 +56,16 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
>   
> +    if (base_node) {
> +        qdict_del(options, "base");
> +        base_bs = bdrv_lookup_bs(NULL, base_node, errp);
> +        if (!base_bs) {
> +            error_setg(errp, QERR_BASE_NOT_FOUND, base_node);
> +            return -EINVAL;
> +        }
> +    }
>       state->active = true;
> +    state->base_bs = base_bs;
>   
>       /*
>        * We don't need to call bdrv_child_refresh_perms() now as the permissions
> 


-- 
Best regards,
Vladimir

