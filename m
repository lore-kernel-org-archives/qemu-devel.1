Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532E8C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9797620874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uZUnglo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9797620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyZk-000710-44
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVyXn-0005TD-H7; Fri, 23 Oct 2020 10:59:51 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com
 ([40.107.13.92]:47076 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVyXh-0005tp-5t; Fri, 23 Oct 2020 10:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE+Bcd51GUl1xApfj29B7i/8F3vVqlJFsCwKg9SZerP/C0lgJZPUtLWFDPPuUdcx7j7CruipuR3nxndZ/zSh/7HqOQii7P/N7rfkSQ9GIO+RUZTsnQh3Fv2rXqAzoy1mkMOcbP5Efa9YvcAFVs8Sp9lhBfTpYvzbWrWYUgEeHbNCZVRcrzQ0Zo/fFjkjQcRL54/PyDh/aUL8j3n0uHyTf1Nxm5MQ6a4PYik8+ypGmR3dkkeuJmP1oIPY4kmsUQB15nApIMZZhnQnnc7DFw7kCVkCMOZz1eFyLvqV3eBGjO+aB11KG+mwOMBRtz4Csjgxy/md7CvPOHGn3g15q1Omgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJn55h9ZMOUrQ17oebq4MQG3jtm7UxmtliyT68WXYNE=;
 b=ieC1Uy/uUWISFInjCLZWLzaW0wCgz6dWqcNvy04Wq2qf4RDRvsxyp0ucEVRZ53Vs5PFqFTsDODIs3kMBhyMwtiGPU+X1FRC+BHrH0ihq9x+2oxq1QYOO6P/+VGD5+7iXznPqJ59EqD3RJtdhPL1EB+3KIz05xFhXYk+WRAmET67SrZ7cxXV8/yDBmfA00avvY+9dF+/9ft2t9RD7O0KeHX5sre/MB8pyX/lc2NPRKbR3R0tvuFEPZne18k+BUj3shEJN2MX12YmbX0x4h1Eqi2GfUxf6EVxsIfyVdOAGH7+azdaS2al/DWSnqZmh3HCn3FroWuManXhaZ5cD9p09Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJn55h9ZMOUrQ17oebq4MQG3jtm7UxmtliyT68WXYNE=;
 b=uZUnglo5+aYq71U2tvSe1+NoVPOW5uiX2zapgP4kwd0EpztVCInzfzE7uJ9r7EaqDGZkovEfk/pltFtaA/P9geRroXl0NCx7/aR/sKSTDxC9giWJfK8My6izvytGrhNRI0/2toUxaM0TW5ymhlrGofdcZS+wMv5lYn7FtLlCAmU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5255.eurprd08.prod.outlook.com (2603:10a6:20b:ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Fri, 23 Oct
 2020 14:59:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 14:59:38 +0000
Subject: Re: [PATCH v12 07/14] copy-on-read: limit COR operations to bottom
 node
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e846885e-3711-217f-29a2-75123f14b53d@virtuozzo.com>
Date: Fri, 23 Oct 2020 17:59:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1603390423-980205-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM3PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:207::13)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM3PR04CA0129.eurprd04.prod.outlook.com (2603:10a6:207::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Fri, 23 Oct 2020 14:59:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 831f6428-39db-4582-1a64-08d877644393
X-MS-TrafficTypeDiagnostic: AM6PR08MB5255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52552C589CFEA67E470AD05EC11A0@AM6PR08MB5255.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpE/3NKObhqQ9jTuKPotx9G5KZKnMj+hfKB3DmpZ4iSKgFDQdJGa40oT5sqV78WlSfsPRfVWaEhgSKohFHI4eWNbpAaKxDhD9pz8uNMqbO1DYcN15kjXAIMBvcZVidNIa/eCupYsQigZCi3ITr9Mk+7D+VtL2R+2UoAHXU0wpwsblvf5MEYn8OgPyIZMsbhDIQYnZ5wLsijCWTWVt38lI7l3aD8ShjSmWSYe/suZ3ufPxCkfJ8ry/IdrRkgbk+yYrM+5fI/YXs+jjsuAmYe4aY042Yi3Z6ZYakPX9WXdf0cKRbVeSuovIGwWjw9gVSUeIvczraylUAk2oGqqNO+Rwg6Scxeu442t1L7BThKXt0SdOFW2rNNodxaQ/gPYDs5F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(346002)(136003)(396003)(376002)(5660300002)(83380400001)(4326008)(316002)(16576012)(66946007)(16526019)(66476007)(66556008)(186003)(956004)(2616005)(2906002)(36756003)(26005)(478600001)(31696002)(31686004)(8676002)(6486002)(8936002)(86362001)(107886003)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: scV/fMFsDbWyf8WrwSYeZiET5zWaIbKJ5w3eUvENYfoVVA3C/v77nrJzMzc1TCRXEMQ6/g011R57iRAJYaZYK/bJ5/aZSqY8kvTcTzgyILXXUnWPwxAojHTExIXs8muPCYMLKaujlia3nraPFQYxoQ/SnXB5yPJTkLHvXJ/+uS1lRjJ4LO1rCjI65JTl9t/iKvfS2DjPyPj7xnUcy5js/DkFm9oQqg6ylcjTZOwtIHSSGGbGyZhRalp+EF25K3bLvw2bY48E/HCv5H/a6ryDl7FcFVOyCpdhXD6q6rqU61APVhvpoeobbpjpdAArq8BTx1zBf8rUVbM0r0SpZFOg44IGfjUfIG9a1Yyji0ALNCJE3jAMtdKZR3E1Aqb3iJFbZGPTMdk9Nwn4dM500uNjV7DZlVGchyKnCbHRhtaWxEzCge+Oe2gK3JaH+d20JBCncXy3mrbupX2jnpUEmVe37S9wBtewX56fx8nSkvjZbOGDb8EGinfkBLT2s7tJNzTkVm9V2sBmFQl6kyUko6MNPMMQYP1PjSvfDIhJOi04uGZrCaTEZvhKgq5jx13r87EqNLWxrF9R7MdoDSb5DSWp11/NhXeiJCGML7FTXcmsWrXQV/2px9Za3fBviqHykUIzkaK8ReMuJg7ND8kiTMgkGw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831f6428-39db-4582-1a64-08d877644393
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 14:59:38.8318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb+wv8lT+8XqMcUWu9DHR21gvo8hjl7kpBYMiz84n4eyIp3xLBS6AmehETO0sTwzMJ0ylMiQxTpwcXTGbOTQBVFpOY7hC5O4t131A0IHVpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5255
Received-SPF: pass client-ip=40.107.13.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 10:59:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_LOW=-0.7,
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

22.10.2020 21:13, Andrey Shinkevich wrote:
> Limit COR operations to the bottom node (inclusively) in the backing
> chain when the bottom node name is given. It will be useful for a block
> stream job when the COR-filter is applied. The bottom node is passed as
> the base itself may change due to concurrent commit jobs on the same
> backing chain.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index 3d8e4db..8178a91 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -123,8 +123,46 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
>                                              size_t qiov_offset,
>                                              int flags)
>   {
> -    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
> -                               flags | BDRV_REQ_COPY_ON_READ);
> +    int64_t n = 0;

no need to initialize n actually.

> +    int local_flags;
> +    int ret;
> +    BDRVStateCOR *state = bs->opaque;
> +
> +    if (!state->bottom_bs) {
> +        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
> +                                   flags | BDRV_REQ_COPY_ON_READ);
> +    }
> +
> +    while (bytes) {
> +        local_flags = flags;
> +
> +        /* In case of failure, try to copy-on-read anyway */
> +        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
> +        if (!ret || ret < 0) {

simper: if (ret <= 0) {

> +            ret = bdrv_is_allocated_above(bdrv_backing_chain_next(bs->file->bs),
> +                                          state->bottom_bs, true, offset,
> +                                          n, &n);
> +            if (ret == 1 || ret < 0) {
> +                local_flags |= BDRV_REQ_COPY_ON_READ;
> +            }
> +            /* Finish earlier if the end of a backing file has been reached */
> +            if (ret == 0 && n == 0) {

"n == 0" should be enough

> +                break;
> +            }
> +        }
> +
> +        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
> +                                  local_flags);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        offset += n;
> +        qiov_offset += n;
> +        bytes -= n;
> +    }
> +
> +    return 0;
>   }
>   

My remarks are minor, so:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

And yes, I still think that this is good to be merged with two previous patches.


-- 
Best regards,
Vladimir

