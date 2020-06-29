Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A485C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108C12371F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Mi4b4aG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108C12371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqk2-0001Mf-BV
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqj1-000871-Mc; Mon, 29 Jun 2020 06:09:19 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com
 ([40.107.6.102]:61543 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqiy-0005hy-1l; Mon, 29 Jun 2020 06:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1tF5mS9VrwdCo0i8LbOiNgGkhFKCC+yv3dAxDJAcn/N98D02gmo5YDZZn4NU+NrXGkJUzyftvGYUTzv0+4SBnj6p07uk/nZHYdvp6xpECtLQXqADjyHKne8xjQzN0EK1Z4OCl34oRd5cxolbS9kd0MIYt0G6AXzwK0fh2AJkMfvdd9ZjewyMY/BA6eNWERFG6ADDEazVVy0MXE2c83ReQEZ45tgqCe+RzVlGXVQJKqx8Y6uGcBLwWjPZYQn9xrmu4luM1W9LThO25OXxeXZWI0Yi8gQwt5AVBfB2MZYfXDoMDXqBdO3xS5n71ppNpct53z80v6jHWe0O/Zyxi6CqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMB0ZDPnklsuXYSypdhWDqhTr0bOgQuwdWnFWbP0d+M=;
 b=MkAPDFgDpPkEbvDbkeEgJydHcx28BSAMnSkwa56A/7Ecm6NPNfYM3Zkzb+9FSDsoLMFLluKsLYq26JZChCn8DbNJmD8mkOC1fuBqOSeQ5eh13VLwDdVbwJ7gRgIkZ54SnyGKttf4zPXaUVeYMK8GLMTY/eGob/cBztNdersyI1Z2vxUYUGy8Sb19GXZn6iinARgOTKO0WDP2zLcq78y14Lb5Rz98wMdhSOuyHTA8scMV2xA26Zx6cRFiayazJwPFSnwzsrX/tjeIezRYgKKGSmJIFEmrUwTltb8HiSuBhVeULlH49O97SLYPdQaFCoiJQ4rotBW7WEl8Ow3b9+yyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMB0ZDPnklsuXYSypdhWDqhTr0bOgQuwdWnFWbP0d+M=;
 b=Mi4b4aG/EMd1IEhYwzt7qdVuLAdvuhSbpLDYm0fs0XJrKYgAWUtolnsmYl9T+svEfZe7StdSaHhk4l5/+ir3mVGmy5w4ekss8RRUWcLiqn2GinB0L7L/nzyV1Pn+AJ9d7c4/XeoYySrBh/IB52pDGk8rIurAsS8oJvDmycP+xVg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4536.eurprd08.prod.outlook.com (2603:10a6:20b:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 10:09:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 10:09:13 +0000
Subject: Re: [PATCH 14/46] qemu-option: Factor out helper opt_create()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-15-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <eb4e324e-7028-8e86-5e5c-1063080017c6@virtuozzo.com>
Date: Mon, 29 Jun 2020 13:09:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:200:89::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM4PR0202CA0008.eurprd02.prod.outlook.com (2603:10a6:200:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 10:09:12 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0d0697f-2892-4789-0fe5-08d81c147904
X-MS-TrafficTypeDiagnostic: AM6PR08MB4536:
X-Microsoft-Antispam-PRVS: <AM6PR08MB453656C44282608112AFC9DBC16E0@AM6PR08MB4536.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWW1LS16c8ASWv5QBy2PMnBh6E72k4riVo5scEm5u8EkWeSYM5o7W+EHNNBDFby7VedFkwy5Hoi91/YwHNQO5fet12EBRyiPJdUFrNKOMsVPNXecKb/B60q+LifXj7vF4HuprAReRlSzPp7HwVdx5JgxILwwV7rY+7XQEsmfBR33/+QOnabJTmIkkoykGIVu+DoYJ/xhic3EUOFFTknkF8w2Cub6/GwyJvuoPFNg5e73J+uwvbsV2swbctkCJ/B0MTS4jxQrFtNw/wt2esIYA3dbVP5ycfd3+aKqjiscgJXUDUfhNssoc7LIlScvjQeO1uzfroQ1jyKpPBY76kcHY0NPFaT1vGsonA2qY+MKiTwYWkxm8gxjLjzDeqw9cm47
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39840400004)(136003)(36756003)(5660300002)(31696002)(83380400001)(8936002)(31686004)(16576012)(316002)(86362001)(478600001)(8676002)(66556008)(66476007)(6486002)(4326008)(2906002)(52116002)(956004)(16526019)(66946007)(2616005)(26005)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dEKRE6w1WCE3GVrgFVjTqDVsCQ5YvyfCB1ACICdcs0puwnDpN4frPxstggCoASOeS564Iqk+CPtowQGJF9RfQH3LCfqBy7HqacZulFZfP9zQQSb6j/gaIQXbEJ35tD354nXaORDCpEz6L9J8MmLIXxucuIv55LJrJGMHMzRpU3lqH2OqATeraWINT/n3QGPSe8WFUTvzr0BnkeGCFf1jMtFrCGWcsREisy2S163EuEEtodFED6M/yClkKa+CbHv7tciJpPLyDfTMIwsQLXi0vxuV6fw83wXjBAX/h4/0zUo6KGemRH9eoqeT9NiAhJ8JbinjP+YKkm+zIogLsvKFD51IX4aDMSDiBE45V0qbTfFgfwc2OoJ3wa5T9dJugog+C+QiYLVHU4ZXOObHPt3Cr2TUsjiZiO+UasiPMOL/v99fmTYVx2Wv8ttV87ujTdyfpiCAYLYJ8WmdQgAdq4LCxqDin0rnHLVdWp1yQe26Erk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d0697f-2892-4789-0fe5-08d81c147904
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 10:09:12.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTJMAFYvesLTl7m+AUbnp4bsP74xKaiY0eIspq4GTZLOUfzrAlfh4kmaqewyMEe9CT9TVEDe0fi8e05N6G+eyaA76lnMDsu+c+/o8LAn19A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4536
Received-SPF: pass client-ip=40.107.6.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 06:09:14
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> There is just one use so far.  The next commit will add more.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/qemu-option.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index d9293814b4..3cdf0c0800 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -502,6 +502,23 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
>       }
>   }
>   
> +static QemuOpt *opt_create(QemuOpts *opts, const char *name, char *value,
> +                           bool prepend)
> +{
> +    QemuOpt *opt = g_malloc0(sizeof(*opt));

I'd prefer g_new0(QemuOpt, 1)

anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +
> +    opt->name = g_strdup(name);
> +    opt->str = value;
> +    opt->opts = opts;
> +    if (prepend) {
> +        QTAILQ_INSERT_HEAD(&opts->head, opt, next);
> +    } else {
> +        QTAILQ_INSERT_TAIL(&opts->head, opt, next);
> +    }
> +
> +    return opt;
> +}
> +
>   static void opt_set(QemuOpts *opts, const char *name, char *value,
>                       bool prepend, bool *help_wanted, Error **errp)
>   {
> @@ -519,16 +536,8 @@ static void opt_set(QemuOpts *opts, const char *name, char *value,
>           return;
>       }
>   
> -    opt = g_malloc0(sizeof(*opt));
> -    opt->name = g_strdup(name);
> -    opt->opts = opts;
> -    if (prepend) {
> -        QTAILQ_INSERT_HEAD(&opts->head, opt, next);
> -    } else {
> -        QTAILQ_INSERT_TAIL(&opts->head, opt, next);
> -    }
> +    opt = opt_create(opts, name, value, prepend);
>       opt->desc = desc;
> -    opt->str = value;
>       qemu_opt_parse(opt, &local_err);
>       if (local_err) {
>           error_propagate(errp, local_err);
> 


-- 
Best regards,
Vladimir

