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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7E5C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BA020870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vk3E0q8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BA020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9nj-0007Ec-N3
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ9gQ-0001qJ-LQ; Wed, 07 Oct 2020 09:40:42 -0400
Received: from mail-eopbgr00119.outbound.protection.outlook.com
 ([40.107.0.119]:22278 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ9gL-0006Kn-Q1; Wed, 07 Oct 2020 09:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItifLiBv3qNOXLdjPUJ+mb5FfHL72YQFKpxIT3u8cUVqpDBJvUqJr2kR21hr7XGf2dF50sNj69/wnjHKhtkVkiMS15xxJryATBjMuZZaMBlF+ebPIcJbGQgnM5mytucARst+pezycypSUglMb5G4nqG2GeiSnek6Si+ML7Csk1jfcwzs5DlQr89uB6pnvqwuKNi4iFR1epRf1RWytSkeJQMjFV8azFX6o8DCqUcMuHRTwmWmIjQPleGhQ7rHopf5UgJcT9lFDjvjX75gnBDX6j7zgJDfVBmjRdclMSKKb6Z2CajIlP0a4iUQjUt6hdXhWz5o5MoBMeN6wf1c+xpA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax0xzekjnOxtDcY5yl6zkldSo18gIwMs+stM7sJVsJQ=;
 b=cZGmp9vWvaklXfHjegvSjIE9RB/oNbhqh+K17Nvn3lgHIBmhwPxrwdZtKSrNvgbuR9AIo8kr31JWEI9SeWqibJ+8PD2GMFsJVGm9cEAY7x27W/QSSx05Cnj54WRuY509IyFKrVbaDUOieoPboOjxd5tlZ9Lje7g1KlLUHk1eLqM9bH1y8LZyGH4n0iTZeXHNd8Mxz+G8jkiDhVw/hBYhKBBzqPmgrco4KWYGVhZPGhoeA6biVF0Ge3z/tLn/ol6t6cEbi9bWRHLmK7R65GqnrCHWRzqdBRxaeJt6RHqMeGl+US+0S9PIaM9wrZKq42udnA9HnIElFVxaUk0g5IJubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax0xzekjnOxtDcY5yl6zkldSo18gIwMs+stM7sJVsJQ=;
 b=Vk3E0q8iwp/gj8CRjdXUGZ3GoXeeqbVs/hEtlh4x0Ta9nhzvjQDfTY0NIq5ob0t6Uqg9WJhYzmHQW9F3mrxiC9JbVJVflRoWHZQ3jhlgh4oLw4rTKLOAnMP34qdGsB5RB0lgOHytTeRbvpEeqK/uabvCKvCmvuefRAQ9Hyuv6sg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4692.eurprd08.prod.outlook.com (2603:10a6:20b:d2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 7 Oct
 2020 13:40:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 13:40:34 +0000
Subject: Re: [PATCH v2 4/5] nbd: Add new qemu:allocation-depth metacontext
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1425ef36-614e-f6eb-ff41-90693d017fbb@virtuozzo.com>
Date: Wed, 7 Oct 2020 16:40:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20200930121105.667049-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:208:1::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR04CA0049.eurprd04.prod.outlook.com (2603:10a6:208:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 13:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b166e368-639f-4172-d4a9-08d86ac690d1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4692:
X-Microsoft-Antispam-PRVS: <AM6PR08MB469251675EEA4291D461F7C6C10A0@AM6PR08MB4692.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JQ0rlWL8T1V2GmJTriexc7uIOzmwbDxVlDgHslSkOGx4hOBUnZy9de6iw3Zd5h4AuiJ6akMFPSxf3y9+YPg2ZUIeVpFNDA90jCbeqCdTpVsge8GeTeX1t6rvpXBfHqFhd7lZONlgVMfTQYtg8ayYLt3S/pxOGdTPjtzkX+ekiAFMyJYOsOKyju9xKF4T8EDtnu1d5qwAJlD0XH0BlvmtgX+3R4GY1efYPouGzICOO6pUY5haOQRb+gGi7GFG9pRuh80uTWkowd4fiEso/RaG7RaB+Qv7PztmrfWi8KfYGRE4UgAFtvwpWG0HPMUKKC0DuQdM/Dhi9rBVzL7t4YWqe5kBwDRUUa7NrXerZqxwiRGjAOl2n00d2e5X20tjonNJP4oowxkBo7CSQQ+Y12yM3s+3eAM4jB+9YUJLJZcAlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39840400004)(346002)(66556008)(52116002)(26005)(36756003)(6486002)(31696002)(16526019)(86362001)(31686004)(186003)(2906002)(83380400001)(8676002)(8936002)(16576012)(30864003)(66476007)(66946007)(5660300002)(4326008)(956004)(2616005)(316002)(478600001)(43740500002)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SvBv22Ck5/GpYMV1i9x4St1Ctrdzi5onbRLV2EIj4sa4zxSF1Acx1IgtiYufnir4M7js2o8sMrCW2hTBwhhGnTXcA7T93B3tQSr7HGhbRi8ed/OZ3jl1ti4sAFf/ikHc21L1XL/ZJdFVO2Y3gkiHhRLZ3gREDBKR8hLIvJ4tpL9IYE9h19uvqZxCcof1UzdkEbCNwubFUbSDDOg374JtKwXQOE2JynwJGNCgvD2kpxTjs2S8/CvcaVSl8WWFKJwemnLrUde0KSsHaYVt2iosICfs2ERAU6+Sy5pynZgVCYKBfUzYr2yTqBek1wlTP48d1uBNozZb0IHhEntEmcISgfNfT+I+A6iZW12MX1AoUsi7O4nkAUgYTic/2V+dfXFmbvRzY9mWbd8mUQr3svQCMKUgINgaF0y6mr8ZHwBnlveDDw/M11HSMI4MvdmSgrjzJAQRT1OVXpHqOtcmaDoib9uR+KX8OTnkpMZ2nCgTOmK/nENwOdpBmL+N10AmPNWFERUkuWqNqZFxtkIgf6CRJvHnu0TFp7So9i3LL00eq98kbVoixJLwKNz02HEpO7vIYRXsZvJgZhVyqtwPw7v8vG6ljb+rNfeuLnM2xcduWp5dmwIX5vdVdkZOmU/Ch2zxspujlWFcXmH8oyC2SAyLNg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b166e368-639f-4172-d4a9-08d86ac690d1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 13:40:34.0655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rp9hINo3sQOuS6d3ymeulsDxDW8z47DqakeGcCbbQ8SqoHLr8hQfUPKaOh/ZKcnufWG53VEB18IHV839bknqo5oyx/BKIahJROZuvqGIggs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4692
Received-SPF: pass client-ip=40.107.0.119;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 09:40:35
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

30.09.2020 15:11, Eric Blake wrote:
> 'qemu-img map' provides a way to determine which extents of an image
> come from the top layer vs. inherited from a backing chain.  This is
> useful information worth exposing over NBD.  There is a proposal to
> add a QMP command block-dirty-bitmap-populate which can create a dirty
> bitmap that reflects allocation information, at which point
> qemu:dirty-bitmap:NAME can expose that information via the creation of
> a temporary bitmap, but we can shorten the effort by adding a new
> qemu:allocation-depth context that does the same thing without an
> intermediate bitmap (this patch does not eliminate the need for that
> proposal, as it will have other uses as well).
> 
> For this patch, I just encoded a tri-state value (unallocated, from
> this layer, from any of the backing layers); an obvious extension
> would be to provide the actual depth in bits 31-4 while keeping bits
> 1-0 as a tri-state (leaving bits 3-2 unused, for ease of reading depth
> from a hex number).  But this extension would require
> bdrv_is_allocated_above to return a depth number.
> 
> Note that this patch does not actually enable any way to request a
> server to enable this context; that will come in the next patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   docs/interop/nbd.txt |  22 +++++++--
>   include/block/nbd.h  |   8 +++-
>   nbd/server.c         | 105 ++++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 125 insertions(+), 10 deletions(-)
> 
> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
> index f3b3cacc9621..56efec7aee12 100644
> --- a/docs/interop/nbd.txt
> +++ b/docs/interop/nbd.txt
> @@ -17,9 +17,9 @@ namespace "qemu".
> 
>   == "qemu" namespace ==
> 
> -The "qemu" namespace currently contains only one type of context,
> -related to exposing the contents of a dirty bitmap alongside the
> -associated disk contents.  That context has the following form:
> +The "qemu" namespace currently contains two types of context.  The
> +first is related to exposing the contents of a dirty bitmap alongside
> +the associated disk contents.  That context has the following form:
> 
>       qemu:dirty-bitmap:<dirty-bitmap-export-name>
> 
> @@ -28,8 +28,21 @@ in reply for NBD_CMD_BLOCK_STATUS:
> 
>       bit 0: NBD_STATE_DIRTY, means that the extent is "dirty"
> 
> +The second is related to exposing the source of various extents within
> +the image, with a single context named:
> +
> +    qemu:allocation-depth
> +
> +In the allocation depth context, bits 0 and 1 form a tri-state value:
> +
> +    bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is unallocated
> +    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this image

Maybe, s/this/the top level/, as, what is "this" for NBD client?

> +    bit 1 set: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
> +               backing layer
> +
>   For NBD_OPT_LIST_META_CONTEXT the following queries are supported
> -in addition to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
> +in addition to the specific "qemu:allocation-depth" and
> +"qemu:dirty-bitmap:<dirty-bitmap-export-name>":
> 
>   * "qemu:" - returns list of all available metadata contexts in the
>               namespace.
> @@ -55,3 +68,4 @@ the operation of that feature.
>   NBD_CMD_BLOCK_STATUS for "qemu:dirty-bitmap:", NBD_CMD_CACHE
>   * 4.2: NBD_FLAG_CAN_MULTI_CONN for shareable read-only exports,
>   NBD_CMD_FLAG_FAST_ZERO
> +* 5.2: NBD_CMD_BLOCK_STATUS for "qemu:allocation-depth"
> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index 3dd9a04546ec..06208bc25027 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -1,5 +1,5 @@
>   /*
> - *  Copyright (C) 2016-2019 Red Hat, Inc.
> + *  Copyright (C) 2016-2020 Red Hat, Inc.
>    *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
>    *
>    *  Network Block Device
> @@ -259,6 +259,12 @@ enum {
>   /* Extent flags for qemu:dirty-bitmap in NBD_REPLY_TYPE_BLOCK_STATUS */
>   #define NBD_STATE_DIRTY (1 << 0)
> 
> +/* Extent flags for qemu:allocation-depth in NBD_REPLY_TYPE_BLOCK_STATUS */
> +#define NBD_STATE_DEPTH_UNALLOC (0 << 0)
> +#define NBD_STATE_DEPTH_LOCAL   (1 << 0)
> +#define NBD_STATE_DEPTH_BACKING (2 << 0)
> +#define NBD_STATE_DEPTH_MASK    (0x3)
> +
>   static inline bool nbd_reply_type_is_error(int type)
>   {
>       return type & (1 << 15);
> diff --git a/nbd/server.c b/nbd/server.c
> index 7271a09b5c2b..830b21000be3 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -27,7 +27,8 @@
>   #include "qemu/units.h"
> 
>   #define NBD_META_ID_BASE_ALLOCATION 0
> -#define NBD_META_ID_DIRTY_BITMAP 1
> +#define NBD_META_ID_ALLOCATION_DEPTH 1
> +#define NBD_META_ID_DIRTY_BITMAP 2
> 
>   /*
>    * NBD_MAX_BLOCK_STATUS_EXTENTS: 1 MiB of extents data. An empirical
> @@ -94,6 +95,7 @@ struct NBDExport {
>       BlockBackend *eject_notifier_blk;
>       Notifier eject_notifier;
> 
> +    bool alloc_context;
>       BdrvDirtyBitmap *export_bitmap;
>       char *export_bitmap_context;
>   };
> @@ -108,6 +110,7 @@ typedef struct NBDExportMetaContexts {
>       bool valid; /* means that negotiation of the option finished without
>                      errors */
>       bool base_allocation; /* export base:allocation context (block status) */
> +    bool allocation_depth; /* export qemu:allocation-depth */
>       bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
>   } NBDExportMetaContexts;
> 
> @@ -806,7 +809,7 @@ static bool nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
>   {
>       if (!*query) {
>           trace_nbd_negotiate_meta_query_parse("empty");
> -        return client->opt == NBD_OPT_LIST_META_CONTEXT;
> +        return !*pattern || client->opt == NBD_OPT_LIST_META_CONTEXT;
>       }
>       if (strcmp(query, pattern) == 0) {
>           trace_nbd_negotiate_meta_query_parse(pattern);
> @@ -864,12 +867,21 @@ static bool nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
> 
>       if (!*query) {
>           if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
> +            meta->allocation_depth = meta->exp->alloc_context;
>               meta->bitmap = !!meta->exp->export_bitmap;
>           }
>           trace_nbd_negotiate_meta_query_parse("empty");
>           return true;
>       }
> 
> +    if (nbd_strshift(&query, "allocation-depth")) {
> +        trace_nbd_negotiate_meta_query_parse("allocation-depth");
> +        if (nbd_meta_empty_or_pattern(client, "", query)) {

How much it differs from "if (!*query) {", I don't see...

> +            meta->allocation_depth = meta->exp->alloc_context;
> +        }
> +        return true;
> +    }

why not just

  if (!strcmp(query, "allocation-depth")) {
     meta->allocation_depth = meta->exp->alloc_context;
     return true;
  }

?

With your code you also parse something like "allocation-depth-extended".. Is it on purpose?

> +
>       if (nbd_strshift(&query, "dirty-bitmap:")) {
>           trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
>           if (!meta->exp->export_bitmap) {


Also, "trace_nbd_negotiate_meta_query_skip("not dirty-bitmap"); " at function end should
now be something like trace_nbd_negotiate_meta_query_skip("unknown context in qemu: namespace");

> @@ -984,6 +996,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>       if (client->opt == NBD_OPT_LIST_META_CONTEXT && !nb_queries) {
>           /* enable all known contexts */
>           meta->base_allocation = true;
> +        meta->allocation_depth = meta->exp->alloc_context;
>           meta->bitmap = !!meta->exp->export_bitmap;
>       } else {
>           for (i = 0; i < nb_queries; ++i) {
> @@ -1003,6 +1016,15 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
>           }
>       }
> 
> +    if (meta->allocation_depth) {
> +        ret = nbd_negotiate_send_meta_context(client, "qemu:allocation-depth",
> +                                              NBD_META_ID_ALLOCATION_DEPTH,
> +                                              errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
>       if (meta->bitmap) {
>           ret = nbd_negotiate_send_meta_context(client,
>                                                 meta->exp->export_bitmap_context,
> @@ -1961,6 +1983,40 @@ static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
>       return 0;
>   }
> 
> +static int blockalloc_to_extents(BlockDriverState *bs, uint64_t offset,
> +                                 uint64_t bytes, NBDExtentArray *ea)
> +{
> +    while (bytes) {
> +        uint32_t flags;
> +        int64_t num;
> +        int ret = bdrv_is_allocated(bs, offset, bytes, &num);
> +
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        if (ret == 1) {
> +            flags = NBD_STATE_DEPTH_LOCAL;
> +        } else {
> +            ret = bdrv_is_allocated_above(bs, NULL, false, offset, num,
> +                                          &num);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            flags = ret ? NBD_STATE_DEPTH_BACKING : NBD_STATE_DEPTH_UNALLOC;
> +        }
> +
> +        if (nbd_extent_array_add(ea, num, flags) < 0) {
> +            return 0;
> +        }
> +
> +        offset += num;
> +        bytes -= num;
> +    }
> +
> +    return 0;
> +}
> +
>   /*
>    * nbd_co_send_extents
>    *
> @@ -2009,6 +2065,26 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>       return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
>   }
> 
> +/* Get allocation depth from the exported device and send it to the client */
> +static int nbd_co_send_block_alloc(NBDClient *client, uint64_t handle,
> +                                   BlockDriverState *bs, uint64_t offset,
> +                                   uint32_t length, bool dont_fragment,
> +                                   bool last, uint32_t context_id,
> +                                   Error **errp)
> +{
> +    int ret;
> +    unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
> +    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
> +
> +    ret = blockalloc_to_extents(bs, offset, length, ea);
> +    if (ret < 0) {
> +        return nbd_co_send_structured_error(
> +                client, handle, -ret, "can't get block status", errp);
> +    }
> +
> +    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);
> +}


The function is a copy of nbd_co_send_block_status()..

Probably, we can reuse nbd_co_send_block_status(), and just call blockstatus_to_extents()
or blockalloc_to_extents() depending on context_id parameter.

Still, I'm OK with it as is.

> +
>   /* Populate @ea from a dirty bitmap. */
>   static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
>                                 uint64_t offset, uint64_t length,
> @@ -2335,16 +2411,20 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>           }
>           if (client->export_meta.valid &&
>               (client->export_meta.base_allocation ||
> +             client->export_meta.allocation_depth ||
>                client->export_meta.bitmap))
>           {
>               bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
> +            int contexts_remaining = client->export_meta.base_allocation +
> +                client->export_meta.allocation_depth +
> +                client->export_meta.bitmap;
> 
>               if (client->export_meta.base_allocation) {
>                   ret = nbd_co_send_block_status(client, request->handle,
>                                                  blk_bs(exp->common.blk),
>                                                  request->from,
>                                                  request->len, dont_fragment,
> -                                               !client->export_meta.bitmap,
> +                                               !--contexts_remaining,
>                                                  NBD_META_ID_BASE_ALLOCATION,
>                                                  errp);
>                   if (ret < 0) {
> @@ -2352,17 +2432,32 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                   }
>               }
> 
> +            if (client->export_meta.allocation_depth) {
> +                ret = nbd_co_send_block_alloc(client, request->handle,
> +                                              blk_bs(exp->common.blk),
> +                                              request->from, request->len,
> +                                              dont_fragment,
> +                                              !--contexts_remaining,
> +                                              NBD_META_ID_ALLOCATION_DEPTH,
> +                                              errp);
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +
>               if (client->export_meta.bitmap) {
>                   ret = nbd_co_send_bitmap(client, request->handle,
>                                            client->exp->export_bitmap,
>                                            request->from, request->len,
> -                                         dont_fragment,
> -                                         true, NBD_META_ID_DIRTY_BITMAP, errp);
> +                                         dont_fragment, !--contexts_remaining,
> +                                         NBD_META_ID_DIRTY_BITMAP, errp);
>                   if (ret < 0) {
>                       return ret;
>                   }
>               }
> 
> +            assert(!contexts_remaining);
> +
>               return 0;
>           } else {
>               return nbd_send_generic_reply(client, request->handle, -EINVAL,
> 


-- 
Best regards,
Vladimir

