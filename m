Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC2C47420
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7F7221ED
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 13:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t3p1ecj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7F7221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM9oB-0004Iq-0x
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 09:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kM9mw-0003Zi-SF; Sat, 26 Sep 2020 08:58:54 -0400
Received: from mail-db8eur05on2102.outbound.protection.outlook.com
 ([40.107.20.102]:56032 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kM9ms-0006aK-DB; Sat, 26 Sep 2020 08:58:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEEsLOd3jrdmN2I92eoES2R+E0rn3tl01lw46B4OiqKEEPHK6JKy6uoluKdAkC3J+pChoDyZXPwP8nw6nnoXgcDnFZd2QlA/cHMQSf+181Ly6kE5qQt9rDnpQTEs5tDRjREdM3831Q5LufTBmTQ6CP5jsRrz5Lf1GuUUWFTaf7DhcymGyf4thBFmrKsbbkDkBTxsUTRwsBkpsESUuAFoGgWSL0/6Sqy5ABh32PJk6Y77aKls+2jyoPInVaiIXzfNjQtQy8dSS0Q0bxrDxcyTLFcYvrHDMhWRiZPlErcm4LL9FVdZoMoRl+vFjTsLROj/gGwWcUbYLipH/1Lo/PIpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4HqXuYUDVRhzpqN09v1CIr9CVrXWTXRxvoSkb0JSE8=;
 b=E0kHRZFfquH/ZHjPDXm1swPl0ab/uazlLR47Bda9Y9g/es1gGVJWb8sbXt5b7eFowLlT64Jc8owv75AL7oa/DwtrmZBAPzwhywEgQoGwgWewxGSy0mx8xH0PzqzOQwIc4zIWPYiFq1EARuRJYW2ZVCbvHJtDv7WJUREQnX4bToJJ8lHDqvot+pG+kzFVd15dVt/l87noFwOM1bMfxASF+6QggLcoOQJy9g4dzXU7M76LLOhMGlJ5MT7do9DXgBg8cHnUS0fdvT2cqrtXlUlrAvAmOxHKxBt5+v9R17fFEnZeuDpt9rNbfSeA+gfZZypvFn9Ormff9LynnYAq96lMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4HqXuYUDVRhzpqN09v1CIr9CVrXWTXRxvoSkb0JSE8=;
 b=t3p1ecj4Mcz6AmEl+vdUI9i2KuifTGWw1Od9NQkSe+SHD04nEPQCG9Zsyma+fd6SHmOEBzZTXF9PAVW4UUgXxqR7JWRvQZCp6x2O5feBkEpkAoMJGcM+net9JIbZW+4HJvUtmy/+7LUaK5U9CNiFXSiN45TUoLukZPSlGrV4g0o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VE1PR08MB5054.eurprd08.prod.outlook.com (2603:10a6:803:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Sat, 26 Sep
 2020 12:58:43 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%8]) with mapi id 15.20.3412.025; Sat, 26 Sep 2020
 12:58:43 +0000
Subject: Re: [PATCH 1/3] nbd: Simplify meta-context parsing
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, rjones@redhat.com
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <403131e3-1712-ce00-63ff-6276cdfa83d7@virtuozzo.com>
Date: Sat, 26 Sep 2020 15:58:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925203249.155705-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::48) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM0PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:208:ac::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.18 via Frontend Transport; Sat, 26 Sep 2020 12:58:42 +0000
X-Originating-IP: [185.215.60.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840c1004-4c1c-42ff-38d7-08d8621be5c6
X-MS-TrafficTypeDiagnostic: VE1PR08MB5054:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5054804459A10A1A71408742C1370@VE1PR08MB5054.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIcFFFqPLDSlh5fMvxyAEJusLBFHwK1B007CE0BZDw/fwEh5gmVFEoJf4urTdtWEenfZqEJTVW7j6AklXRpZI3U/Rn734U1EpZGJ0gTj/OYylrCm4aHdgPMDjGpNWMjjiLIT6zHX6wYCLoYSEtn5yczo+8mzzShOm/BTBwe2UNUd1mnYfzY9f2KjYIBKQ6pLpmA66TNPxM/nBaQ7tJtKbibspoS0TOydAHK79N2xtIq5+u+onFgpmb8BVbtBJ6U17/Z044e2BFJnyV+oQDJiLCGrvSLu6HCLoSHRGZ3dF37D315fs9qXz5zkjGWWcxZrqHw6vUaNfltBBLDnrD5hch7kwRCIyQhiQMIlz0V4REs+Wd7DIMsIud8+SkZI4+X1AGXv3K4i93tOQiBQUNaqmprjUYz1gncfgLuyQiGiDjU/HLnHtN27yMjUbAhv+9m5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(66946007)(8676002)(2616005)(956004)(8936002)(186003)(5660300002)(30864003)(478600001)(26005)(83380400001)(16526019)(86362001)(2906002)(6486002)(66556008)(316002)(66476007)(16576012)(4326008)(52116002)(31686004)(31696002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: F51ipsrcJoUeZGWSbaMVag0PwHeFuKD1DfYBtMV1Dln6N/uXoa923JZTOycMtJeHfrxcyxVvT6Jnng4Et1lBntQlEFrMUNUwWM1MZyIRkCIzojxIUZiG+IKJcx32nh10UL8RFdgGMbhg2zK0S0+G+/1FZnNvEkPI54mXJOzPxHmB2YsMBu34Nl1HD4bfrnuO2wj9mBIWFKLrArsSuwcgCKzjzOuhhLPc4eDTD+RBBhHSPZmSWd/guKYydGwLtqrhZhMbna3600Y8WAPBhh2B1vW8pMgUbUslxqTwLFgOvVQTf7LM5bi/nYmTtFYsjladL/07r7VqvjP55Bbq8zXpfBVfVMBC0NhsM7Zj5EMlP8zLFjcqTvh1w8xT4GE68vfWxSPkyhs9EXgGffepG3AmSdacztin3L7ttonfDCQVQ8VyBV4ysHlMb2Lx4rydZAezGqTMShNrUCnxvvHLsSfVo3m3jubmKfZqANmNgRj4fTMBwmXq6tP3iCVtUqhSsulA6HDgGbTKBZ2bmwzxCk2KAZBClFCXpHDQfGgTYsBqnxAluFcCw6aDyzyn/u0Vr27t/7kC+eG9y58HFtio8bsoEVFIi9fNpRdvh60CjPxV2sHvFLu2yehzlUwsy+U4vETUcL7wRlPIBNKolHbCUuor1g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840c1004-4c1c-42ff-38d7-08d8621be5c6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2020 12:58:43.3757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obuYtlxJAKXkcvRBp1PxY4qn/48E/Zi+CzDPQwI9gGwLIhW0thdigPnPI5wKIt30TwcHudWU61nfz6BUMnoXNE2aWe7vq2vGAecUqp4pw2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5054
Received-SPF: pass client-ip=40.107.20.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 08:58:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.213, RCVD_IN_DNSWL_NONE=-0.0001,
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

25.09.2020 23:32, Eric Blake wrote:
> We had a premature optimization of trying to read as little from the
> wire as possible while handling NBD_OPT_SET_META_CONTEXT in phases.
> But in reality, we HAVE to read the entire string from the client
> before we can get to the next command, and it is easier to just read
> it all at once than it is to read it in pieces.  And once we do that,
> several functions end up no longer performing I/O, and no longer need
> to return a value.
> 
> While simplifying this, take advantage of g_str_has_prefix for less
> repetition of boilerplate string length computation.
> 
> Our iotests still pass; I also checked that libnbd's testsuite (which
> covers more corner cases of odd meta context requests) still passes.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   nbd/server.c | 172 ++++++++++++++-------------------------------------
>   1 file changed, 47 insertions(+), 125 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 982de67816a7..0d2d7e52058f 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright (C) 2016-2018 Red Hat, Inc.
> + *  Copyright (C) 2016-2020 Red Hat, Inc.
>    *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
>    *
>    *  Network Block Device Server Side
> @@ -792,135 +792,64 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
>       return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
>   }
> 
> -/* Read strlen(@pattern) bytes, and set @match to true if they match @pattern.
> - * @match is never set to false.
> - *
> - * Return -errno on I/O error, 0 if option was completely handled by
> - * sending a reply about inconsistent lengths, or 1 on success.
> - *
> - * Note: return code = 1 doesn't mean that we've read exactly @pattern.
> - * It only means that there are no errors.
> +
> +/*
> + * Check @ns with @len bytes, and set @match to true if it matches @pattern,
> + * or if @len is 0 and the client is performing _LIST_. @match is never set
> + * to false.
>    */
> -static int nbd_meta_pattern(NBDClient *client, const char *pattern, bool *match,
> -                            Error **errp)
> +static void nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
> +                                      const char *ns, uint32_t len,

ns changed its meaning, it's not just a namespace, but the whole query. I think, better to rename it.

Also, it's unusual to pass length together with nul-terminated string, it seems redundant.
And, it's used only to compare with zero, strlen(ns) == 0 or ns[0] == 0 is not slower.

Also, errp is unused argument. And it violate Error API recommendation to not create void functions with errp.

Also we can use bool return instead of return through pointer.

> +                                      bool *match, Error **errp)
>   {
> -    int ret;
> -    char *query;
> -    size_t len = strlen(pattern);
> -
> -    assert(len);
> -
> -    query = g_malloc(len);
> -    ret = nbd_opt_read(client, query, len, errp);
> -    if (ret <= 0) {
> -        g_free(query);
> -        return ret;
> -    }
> -
> -    if (strncmp(query, pattern, len) == 0) {
> +    if (len == 0) {
> +        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> +            *match = true;
> +        }
> +        trace_nbd_negotiate_meta_query_parse("empty");
> +    } else if (strcmp(pattern, ns) == 0) {
>           trace_nbd_negotiate_meta_query_parse(pattern);
>           *match = true;
>       } else {
>           trace_nbd_negotiate_meta_query_skip("pattern not matched");
>       }
> -    g_free(query);
> -
> -    return 1;
> -}
> -
> -/*
> - * Read @len bytes, and set @match to true if they match @pattern, or if @len
> - * is 0 and the client is performing _LIST_. @match is never set to false.
> - *
> - * Return -errno on I/O error, 0 if option was completely handled by
> - * sending a reply about inconsistent lengths, or 1 on success.
> - *
> - * Note: return code = 1 doesn't mean that we've read exactly @pattern.
> - * It only means that there are no errors.
> - */
> -static int nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
> -                                     uint32_t len, bool *match, Error **errp)
> -{
> -    if (len == 0) {
> -        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> -            *match = true;
> -        }
> -        trace_nbd_negotiate_meta_query_parse("empty");
> -        return 1;
> -    }
> -
> -    if (len != strlen(pattern)) {
> -        trace_nbd_negotiate_meta_query_skip("different lengths");
> -        return nbd_opt_skip(client, len, errp);
> -    }
> -
> -    return nbd_meta_pattern(client, pattern, match, errp);
>   }
> 
>   /* nbd_meta_base_query
>    *
>    * Handle queries to 'base' namespace. For now, only the base:allocation
> - * context is available.  'len' is the amount of text remaining to be read from
> - * the current name, after the 'base:' portion has been stripped.
> - *
> - * Return -errno on I/O error, 0 if option was completely handled by
> - * sending a reply about inconsistent lengths, or 1 on success.
> + * context is available.  @len is the length of @ns, including the 'base:'
> + * prefix.
>    */
> -static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
> -                               uint32_t len, Error **errp)
> +static void nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
> +                                const char *ns, uint32_t len, Error **errp)
>   {
> -    return nbd_meta_empty_or_pattern(client, "allocation", len,
> -                                     &meta->base_allocation, errp);
> +    nbd_meta_empty_or_pattern(client, "allocation", ns + 5, len - 5,

This one is correct, but would be simpler, if only subquery (after colon) passed here.
(Really, no reason to pass 'base:' to _base_ func)

Hmm, I see that it gives a possibility to use meta->exp->export_bitmap_context directly.

> +                              &meta->base_allocation, errp);
>   }
> 
>   /* nbd_meta_bitmap_query
>    *
>    * Handle query to 'qemu:' namespace.
> - * @len is the amount of text remaining to be read from the current name, after
> - * the 'qemu:' portion has been stripped.
> - *
> - * Return -errno on I/O error, 0 if option was completely handled by
> - * sending a reply about inconsistent lengths, or 1 on success. */
> -static int nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> -                               uint32_t len, Error **errp)
> + * @len is the length of @ns, including the `qemu:' prefix.
> + */
> +static void nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> +                                const char *ns, uint32_t len, Error **errp)
>   {
> -    bool dirty_bitmap = false;
> -    size_t dirty_bitmap_len = strlen("dirty-bitmap:");
> -    int ret;
> -
>       if (!meta->exp->export_bitmap) {
>           trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
> -        return nbd_opt_skip(client, len, errp);
> -    }
> -
> -    if (len == 0) {
> +    } else if (len == 0) {

s/0/5/ ?

>           if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
>               meta->bitmap = true;
>           }
>           trace_nbd_negotiate_meta_query_parse("empty");
> -        return 1;
> -    }
> -
> -    if (len < dirty_bitmap_len) {
> -        trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
> -        return nbd_opt_skip(client, len, errp);
> -    }
> -
> -    len -= dirty_bitmap_len;
> -    ret = nbd_meta_pattern(client, "dirty-bitmap:", &dirty_bitmap, errp);
> -    if (ret <= 0) {
> -        return ret;
> -    }
> -    if (!dirty_bitmap) {
> +    } else if (!g_str_has_prefix(ns + 5, "dirty-bitmap:")) {
>           trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
> -        return nbd_opt_skip(client, len, errp);
> +    } else {
> +        trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
> +        nbd_meta_empty_or_pattern(client, meta->exp->export_bitmap_context,
> +                                  ns, len, &meta->bitmap, errp);

hmm. _empty_ is impossible here, as ns includes "qemu:dirty-bitmap"..

>       }
> -
> -    trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
> -
> -    return nbd_meta_empty_or_pattern(
> -            client, meta->exp->export_bitmap_context +
> -            strlen("qemu:dirty_bitmap:"), len, &meta->bitmap, errp);
>   }
> 
>   /* nbd_negotiate_meta_query
> @@ -930,22 +859,13 @@ static int nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
>    *
>    * The only supported namespaces are 'base' and 'qemu'.
>    *
> - * The function aims not wasting time and memory to read long unknown namespace
> - * names.
> - *
>    * Return -errno on I/O error, 0 if option was completely handled by
>    * sending a reply about inconsistent lengths, or 1 on success. */
>   static int nbd_negotiate_meta_query(NBDClient *client,
>                                       NBDExportMetaContexts *meta, Error **errp)
>   {
> -    /*
> -     * Both 'qemu' and 'base' namespaces have length = 5 including a
> -     * colon. If another length namespace is later introduced, this
> -     * should certainly be refactored.
> -     */
>       int ret;
> -    size_t ns_len = 5;
> -    char ns[5];
> +    g_autofree char *ns = NULL;
>       uint32_t len;
> 
>       ret = nbd_opt_read(client, &len, sizeof(len), errp);
> @@ -958,27 +878,29 @@ static int nbd_negotiate_meta_query(NBDClient *client,
>           trace_nbd_negotiate_meta_query_skip("length too long");
>           return nbd_opt_skip(client, len, errp);
>       }
> -    if (len < ns_len) {
> -        trace_nbd_negotiate_meta_query_skip("length too short");
> -        return nbd_opt_skip(client, len, errp);
> -    }
> 
> -    len -= ns_len;
> -    ret = nbd_opt_read(client, ns, ns_len, errp);
> +    ns = g_malloc(len + 1);
> +    ret = nbd_opt_read(client, ns, len, errp);

Now ns is not a namespace but the whole query. I'd rename a variable.

>       if (ret <= 0) {
>           return ret;
>       }
> +    ns[len] = '\0';
> +    if (strlen(ns) != len) {
> +        return nbd_opt_invalid(client, errp,
> +                               "Embedded NUL in query for option %s",
> +                               nbd_opt_lookup(client->opt));
> +    }

Hmm, that's a new good check. Intersting, is it specified in NBD protocol, that
NUL shouldn't be in a string.. Probably it can be a separate patch, with
new nbd_opt_string_read, which will check this thing. But I'm OK with it as is
in this patch.

> 
> -    if (!strncmp(ns, "base:", ns_len)) {
> +    if (g_str_has_prefix(ns, "base:")) {
>           trace_nbd_negotiate_meta_query_parse("base:");
> -        return nbd_meta_base_query(client, meta, len, errp);
> -    } else if (!strncmp(ns, "qemu:", ns_len)) {
> +        nbd_meta_base_query(client, meta, ns, len, errp);
> +    } else if (g_str_has_prefix(ns, "qemu:")) {
>           trace_nbd_negotiate_meta_query_parse("qemu:");
> -        return nbd_meta_qemu_query(client, meta, len, errp);
> +        nbd_meta_qemu_query(client, meta, ns, len, errp);

passing length of string together with string seems redundant (and error prone).

> +    } else {
> +        trace_nbd_negotiate_meta_query_skip("unknown namespace");
>       }
> -

Seems you don't like my new-line before final return statement.

> -    trace_nbd_negotiate_meta_query_skip("unknown namespace");
> -    return nbd_opt_skip(client, len, errp);
> +    return 1;
>   }
> 
>   /* nbd_negotiate_meta_queries
> 


To avoid all this pointer arithmetic, what about something like this (I didn't check, just an idea):

/*
  * Return true if @query matches @pattern of if @query is empty and the client
  * is performing _LIST_. Otherwise return false.
  */
static bool nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
                                       const char *query)
{
     if (!strcmp(query, "")) {
         trace_nbd_negotiate_meta_query_parse("empty");
         return client->opt == NBD_OPT_LIST_META_CONTEXT;
     } else if (!strcmp(query, pattern)) {
         trace_nbd_negotiate_meta_query_parse(pattern);
         return true;
     } else {
         trace_nbd_negotiate_meta_query_skip("pattern not matched");
         return false;
     }
}

bool strshift(const char **str, const char *prefix)
{
     if (g_str_has_prefix(*str, prefix)) {
         *str += strlen(prefix);
         return true;
     }

     return false;
}

/*
  * nbd_meta_base_query
  *
  * If it's 'base' namespace parse the query and return true. If not return
  * false.
  */
static bool nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
                                 const char *query)
{
     if (!strshift(&query, "base:")) {
         return false;
     }
     trace_nbd_negotiate_meta_query_parse("base:");

     meta->base_allocation =
             nbd_meta_empty_or_pattern(client, "allocation", query);

     return true;
}

/*
  * nbd_meta_bitmap_query
  *
  * If it's 'qemu' namespace parse the query and return true. If not return
  * false.
  */
static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
                                 const char *query)
{
     if (!strshift(&query, "qemu:")) {
         return false;
     }
     trace_nbd_negotiate_meta_query_parse("qemu:");

     if (!meta->exp->export_bitmap) {
         trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
         return true;
     }

     if (!query[0]) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
             meta->bitmap = true;
         }
         trace_nbd_negotiate_meta_query_parse("empty");
         return true;
     }

     if (!strshift(&query, "dirty-bitmap:")) {
         trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
         return true;
     }

     trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
     meta->bitmap = nbd_meta_empty_or_pattern(
             client, meta->exp->export_bitmap_context +
             strlen("qemu:dirty-bitmap:"), query);

     return true;
}

/*
  * nbd_negotiate_meta_query
  *
  * Parse namespace name and call corresponding function to parse body of the
  * query.
  *
  * The only supported namespaces are 'base' and 'qemu'.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success.
  */
static int nbd_negotiate_meta_query(NBDClient *client,
                                     NBDExportMetaContexts *meta, Error **errp)
{
     int ret;
     g_autofree char *query = NULL;
     uint32_t len;

     ret = nbd_opt_read(client, &len, sizeof(len), errp);
     if (ret <= 0) {
         return ret;
     }
     len = cpu_to_be32(len);

     if (len > NBD_MAX_STRING_SIZE) {
         trace_nbd_negotiate_meta_query_skip("length too long");
         return nbd_opt_skip(client, len, errp);
     }

     query = g_malloc(len + 1);
     ret = nbd_opt_read(client, query, len, errp);
     if (ret <= 0) {
         return ret;
     }
     query[len] = '\0';
     if (strlen(query) != len) {
         return nbd_opt_invalid(client, errp,
                                "Embedded NUL in query for option %s",
                                nbd_opt_lookup(client->opt));
     }

     if (nbd_meta_base_query(client, meta, query)) {
         return 1;

     if (nbd_meta_qemu_query(client, meta, query)) {
         return 1;
     }

     trace_nbd_negotiate_meta_query_skip("unknown namespace");
     return 1;
}



-- 
Best regards,
Vladimir

