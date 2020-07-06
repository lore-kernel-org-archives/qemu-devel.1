Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D1B20720
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FpMAT4WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D1B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUnb-0000Wq-Lp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsUM8-0008Sh-96; Mon, 06 Jul 2020 12:52:36 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com
 ([40.107.6.105]:30386 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jsUM5-0004xg-2o; Mon, 06 Jul 2020 12:52:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7G524t7JUGuOMOj7Wc4u7kSj6I68RLOduqu2YRU+OEFnuEtKtbBTCKUVC4P9bpmlQGgdCY/iXVMPJLxAUoYZSTytnfGxNhNpkbOIX8cfL47DFpHN3QuSlPcjpX5XrLl5YjsPFX/M1d0Fyn7LOJzeJii2r1t7+yk67qyc3SOEH4VfpIqo9FX700B2XUqAklJM5CSl0F6lvi6fOYCv1L2UDlwX0bt6IxgDdx74BmGjeCjkWx6Kyr85afg/pJDuhS8PWNrNVnvabIlAi/6nXxnJa2qZ6773YlS8aANCaiXniTRyp7FfnfaiQErL/Vc48AMXYfEZOlPvbras0I3Oilolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoD7m5BTdXprAE7SDi3XGmcVkC7iW5qOdsa115L43RM=;
 b=LNJ5pw54umLMi+fymmYo95jUUB56nBCnKvO0I5nArstftrhQ2lAmeXHmZIiaKdHCnlXyQBYJWQcHGeMLAuSSCc8snzSnFjbWsyRGMAczesMEqAsnxGuUpV7dpok3iDwskTwcDxwQ6pNp9aoNckN4Qy96gFWhQ0EkQHbkIylRhmQFI+83vmZ7Vi1SZDHhDw/bgM6kT7iCH/rQcuzuAwfAzZbwSdXyFRZxZpFg3ueBm6jyjmvOqYCKjhXSRbwhKw+CfRR4tbjfLEmukxSs0/INq9MiXObJ7X6e+3TXRuPLaIgChTJFwLqapmPVFgWwr1DLLWHoDjbEJglRUzHgrKzfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoD7m5BTdXprAE7SDi3XGmcVkC7iW5qOdsa115L43RM=;
 b=FpMAT4WUA4A8F9WY4Bb0cyOYiBFxnUXvH+ITSkfSa988QhDU+kkjlX565OmTfTqvjNfpu+LMCApXMPZDhAsXVLAj0nfGw4DVvxhAj6Sg33kcnqSqH6m4cuiTY7fPaChZXwFAeIAARExUOzU1U0wl8opAFxB2vALEkx5Y2PxMuns=
Authentication-Results: kaod.org; dkim=none (message not signed)
 header.d=none;kaod.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 16:52:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:52:30 +0000
Subject: Re: [PATCH v3 29/44] qom: Make functions taking Error ** return bool, 
 not 0/-1
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-30-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <26905451-4a8f-87af-4414-560ea0f3c735@virtuozzo.com>
Date: Mon, 6 Jul 2020 19:52:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200706080950.403087-30-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:208:be::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.12] (185.215.60.58) by
 AM0PR04CA0106.eurprd04.prod.outlook.com (2603:10a6:208:be::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 16:52:29 +0000
X-Originating-IP: [185.215.60.58]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd2cb6d-434d-4eed-27a8-08d821ccf8ac
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:
X-Microsoft-Antispam-PRVS: <AM6PR08MB42157620FE74113B17C6C0F2C1690@AM6PR08MB4215.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBLfmXsDNgF5SwVQ8nNV2JAKIxBO/Idtij3IDFcYMys0T9pmT+PwlIyXJTXnzG4222UzxlckoXj3074pNU9SDNXqhBxD+T99XK7/wPHwqWZ1PBKZ3SBezJkaJo0ZeOMELMxMdi22MvqcFfPvcyf/SujPPiSNK+7bRYC5ipBszTcfwgs2YtsrQFvTkw31/GpSXMriC38kIPbE4K9mF5R5IzxVd3g1OeQzoQhujX7dvc28jjRyjo9UYL3x6GiQnNhUfOy6shsoCMWnSUZZKgyWh5LJb52pX+V8x9jEy0caazwRJ9UUf8RZpZ6XyKMqisvy1U6vqpv9Sn5yEPg7ERtQtrCGsyolXSnNCaqAtKtG55EazRyAJkRg21YRBd5lwCyT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39840400004)(136003)(26005)(31696002)(6486002)(86362001)(956004)(2616005)(83380400001)(478600001)(5660300002)(31686004)(36756003)(8936002)(8676002)(16576012)(316002)(16526019)(2906002)(53546011)(186003)(66476007)(4326008)(66556008)(52116002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: My+fwqgx7gHIgv+NdRCvXHI3WHqsIwu55OemegULvV7Lz2qqMqDAet1/yDPPZ1I07zr5ZWVB3xbV8uq1P74GqcxzMBa0UqchYvI8mpRkGAMb/wyLJhXIdpQAE1+sBVs/LGn2r1ys+e0RyYv4UyxeVWPwcROFpCvXBTBuSPUMCzbMH4KSFvAEdlr9FEKdowvr0v6ZgWqKo1WxGLKGXloZK9EFMNkBI7FmVfNLE97X1uoLbjzJBsgL7qaXKZrCzWVMPw/ORO6WrZ5CGvAZ4kegGwmEk11ixVZ7GLJZsN7BXFw8kP7XdXSsyubof2deYX84PeLuJ2d+kN/6hW+zrIr7PLdZ2YC/V59hs9R5KRjSpCg4/Eo3rfZHEiBd+7JT4kdL+cQDA922YG6jmWnRj/oVQlr1f9j2M7IxVf+6QNZsdmYhNfhiqclU8ORo83ZE6wQnHE9w97vZ27suPf+J8J6/ucY9iLRi7l0gT2wQazoKzTE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2cb6d-434d-4eed-27a8-08d821ccf8ac
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:52:30.3834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib+1ZJ5WKWqF5FiETzWUVI6gcxzV9xg7NSoe0ZKaLQBifo6xCP8eN9TogdDVWS5O/Um8VspCkHpmBzmkvIwbihStBBXzL52mCk4i5uXfFKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4215
Received-SPF: pass client-ip=40.107.6.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:52:31
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, groug@kaod.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 06.07.2020 11:09, Markus Armbruster wrote:
> Just for consistency.  Also fix the example in object_set_props()'s
> documentation.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Note, that object_set_props is unused and may be dropped.

> ---
>   include/qom/object.h | 28 +++++++++++-----------------
>   qom/object.c         | 14 +++++++-------
>   2 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 189f8ecbf6..04271ea5de 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -729,15 +729,13 @@ void object_apply_compat_props(Object *obj);
>    *   Error *err = NULL;
>    *   Object *obj = ...get / create object...;
>    *
> - *   obj = object_set_props(obj,
> - *                          &err,
> - *                          "share", "yes",
> - *                          "mem-path", "/dev/shm/somefile",
> - *                          "prealloc", "yes",
> - *                          "size", "1048576",
> - *                          NULL);
> - *
> - *   if (!obj) {
> + *   if (!object_set_props(obj,
> + *                         &err,
> + *                         "share", "yes",
> + *                         "mem-path", "/dev/shm/somefile",
> + *                         "prealloc", "yes",
> + *                         "size", "1048576",
> + *                         NULL)) {
>    *     error_reportf_err(err, "Cannot set properties: ");
>    *   }
>    *   </programlisting>
> @@ -746,11 +744,9 @@ void object_apply_compat_props(Object *obj);
>    * The returned object will have one stable reference maintained
>    * for as long as it is present in the object hierarchy.
>    *
> - * Returns: -1 on error, 0 on success
> + * Returns: %true on success, %false on error.
>    */
> -int object_set_props(Object *obj,
> -                     Error **errp,
> -                     ...) QEMU_SENTINEL;
> +bool object_set_props(Object *obj, Error **errp, ...) QEMU_SENTINEL;
>   
>   /**
>    * object_set_propv:
> @@ -760,11 +756,9 @@ int object_set_props(Object *obj,
>    *
>    * See object_set_props() for documentation.
>    *
> - * Returns: -1 on error, 0 on success
> + * Returns: %true on success, %false on error.
>    */
> -int object_set_propv(Object *obj,
> -                     Error **errp,
> -                     va_list vargs);
> +bool object_set_propv(Object *obj, Error **errp, va_list vargs);
>   
>   /**
>    * object_initialize:
> diff --git a/qom/object.c b/qom/object.c
> index 25c5ddb78f..97c4e0af07 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -557,7 +557,7 @@ bool object_initialize_child_with_propsv(Object *parentobj,
>       object_initialize(childobj, size, type);
>       obj = OBJECT(childobj);
>   
> -    if (object_set_propv(obj, errp, vargs) < 0) {
> +    if (!object_set_propv(obj, errp, vargs)) {
>           goto out;
>       }
>   
> @@ -752,7 +752,7 @@ Object *object_new_with_propv(const char *typename,
>       }
>       obj = object_new_with_type(klass->type);
>   
> -    if (object_set_propv(obj, errp, vargs) < 0) {
> +    if (!object_set_propv(obj, errp, vargs)) {
>           goto error;
>       }
>   
> @@ -780,12 +780,12 @@ Object *object_new_with_propv(const char *typename,
>   }
>   
>   
> -int object_set_props(Object *obj,
> +bool object_set_props(Object *obj,
>                        Error **errp,
>                        ...)
>   {
>       va_list vargs;
> -    int ret;
> +    bool ret;
>   
>       va_start(vargs, errp);
>       ret = object_set_propv(obj, errp, vargs);
> @@ -795,7 +795,7 @@ int object_set_props(Object *obj,
>   }
>   
>   
> -int object_set_propv(Object *obj,
> +bool object_set_propv(Object *obj,
>                        Error **errp,
>                        va_list vargs)
>   {
> @@ -809,12 +809,12 @@ int object_set_propv(Object *obj,
>           g_assert(value != NULL);
>           if (!object_property_parse(obj, propname, value, &local_err)) {
>               error_propagate(errp, local_err);
> -            return -1;
> +            return false;
>           }
>           propname = va_arg(vargs, char *);
>       }
>   
> -    return 0;
> +    return true;
>   }
>   
>   
> 

