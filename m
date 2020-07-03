Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070D2206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GNBC+e40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070D2206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQ5C-0007a3-8Z
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrQ4N-0006yl-Im; Fri, 03 Jul 2020 14:05:51 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:2688 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrQ4K-0005f7-Mp; Fri, 03 Jul 2020 14:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDkidtHkXG7skGYOmbpGwSt3o41fBJIy6p/ebIDhL/i40Ef9gMM2YL23GOWsYKp6OLEUD9lzl3gndABUDltl98l8SkoahCZUUcmj/4KG6RL9yQNSsBToJRHI2+opayuXfkPuwlZ4H0cMeLwAjNYUdZdEeB8sYvWjNvTsIeboz+aZIrVfRG9b5qmzSh9atWgUXQYIfu3DJNgxJ/wbpKnSj2v8Uk4IoyFADpqiC1Clu7auqnSUYTE4igvXb/2JOw/RysB7YWlZlnNRN74mYaJkSD4DFFbNOgfFyo64rRk2ERW5vDddkyJb+l4VRFQlf+EvFVXAcY/54U7XGfxW5qNWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5TIHj1mf0Zx213b6eLgDu5/s6ZepTmStW/E1vQtu3I=;
 b=e88YfvYLyoImMyLST//N4E7dqk7/qmCrfKVhI3ItDoHeZYjxDdd99VX4gP5bwHgC1M8sGjsLR1TjBqkuqR8kBpFo4q8JzsaZ6IkgRg9js3hL7d+Qd61UitqeozP9HSnWaEfV3bZgQk6TgNEKTwLIvJh9CPZ0VqzCFznTZ/JZqQ5WapYGU4nNSAp1AuQZaz/M4E8kh7mI2HaUDqc7xgy5trqu+//hiMx2pqXAIUHxwpWtMlDJucPn6iGLtXYS7WMkJiWD+iZc6Qzje8xNwdFRWsuOv3WZ3AkEqUCUHes/qQfeywYmhCRuRhXSjMkShDCxTnXwXmbMXrpiRxdhwUy5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5TIHj1mf0Zx213b6eLgDu5/s6ZepTmStW/E1vQtu3I=;
 b=GNBC+e40nk+ShcuChGyzrbnsIftlBBD7bkWIruzmngCIh6RmwrTO5X3HIG/pnc803BHWo/WpsycQ4GLFZkW0dAPwWV6di4CHbfPljNExAM97NhjkHs1Jg5TaOT6gdIa3qiLv1TCbYSPett9pq15JRovDLqC96FCOMT/Z217Ve7o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 18:05:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 18:05:43 +0000
Subject: Re: [PATCH v2 26/44] qom: Put name parameter before value / visitor
 parameter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-27-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d0835559-57c1-d959-d048-df43cd0402af@virtuozzo.com>
Date: Fri, 3 Jul 2020 21:05:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-27-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM0PR01CA0092.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Fri, 3 Jul 2020 18:05:42 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65dfe70-a9d1-4d81-489c-08d81f7bb3df
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652830A5ABC6CB388B103A3C16A0@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cB2ZK8zufG+cdBJBSwBLpTivx9szwWp2ViSfrzggzFGayQ7S403DT9vJ9WOgUeuuCPe+iedafPAEQ5f21D1OQisxXBNfKYFvT61TXdkJ/B37N1mjT01LTEyURN5k2ZrcF/lTFKPCkhW7h3Jpan2AnT8POaKTSQTABoZ7HtEwlTgIbnv2GjdNBvQXHGgUBV0H41b6tLF52JXqARMgDpdn5UkCH1R9aSIbeLY2sN3ntYdyPQx+mIXvB3oueBiUdzRlOfw5oGaQFXKcdad4QuHVZ4rRV4MR99By6n6TyZEsAz2rOJeUxVUS8MkdznL/yVQ1zSjsclDHXit6NN6rW/+IJOvCL3hRUbQ6BgPSg/5EwMUpbX1Qxfowi+2GppfI9ncP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39850400004)(376002)(366004)(186003)(26005)(4326008)(52116002)(16576012)(316002)(2616005)(956004)(6486002)(16526019)(31696002)(5660300002)(8676002)(2906002)(86362001)(31686004)(66946007)(83380400001)(66556008)(66476007)(36756003)(478600001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jCtuF43pNqS7QBQJDMmKyDyJk3u35yIUwxqOw3oDm4FjXiSTXpb9MtJpWVvYC/1lvRh5cUX5PYe6Mqb7JfsgcvBERJhRjlwZC80LohPm54Swb2dlOSgjVKqMuilrWgPVPf/XBXv8r9geSyrwNQyqMzJcMzZjCYG+3+6cTdixcRH8jknllZkeywdnQYprNzNMSVSgAwAGKY5u0EkYI95YjUlwCd4KoGnZRzHYqrNnpy/mn1Gjz5Brb10mHAxxu+2drPdfbed1mumuLt85cU5J1gt+Uj+z4uaN/agY/8m0P408w8csLjX1A5H/MoijASi/X0lkev/ktXX/Tg9O7eRn3rbPWIzySEz8j9+GZztzkB5ATOJoVaZ/tYx5Rq+WEObtEozhFXX7dtJp9S5U7e77AErPGx3RboPhrwiGG8trY1EaqKQ3IZ3czpu15OwBb8UJ11SLW/INztr31eJNYLKj6MR5d0MFQySBWRf2OYxxxlidrEd+SLr8dviU7T5vDdOK
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65dfe70-a9d1-4d81-489c-08d81f7bb3df
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 18:05:43.3253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph3AhsUJ1iF74qowRV5/Ua0of0NYtrDPuX1FSIADxObmC6UCy7IusRB0VFAI9e2u89+VmeX3k2BnBjbNSVMGNGw2MjTywzmXX0C3QGme2uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 14:05:45
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
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 18:49, Markus Armbruster wrote:
> The object_property_set_FOO() setters take property name and value in
> an unusual order:
> 
>      void object_property_set_FOO(Object *obj, FOO_TYPE value,
>                                   const char *name, Error **errp)
> 
> Having to pass value before name feels grating.  Swap them.
> 
> Same for object_property_set(), object_property_get(), and
> object_property_parse().
> 
> Convert callers with this Coccinelle script:
> 
>      @@
>      identifier fun = {object_property_get, object_property_parse, object_property_set_str, object_property_set_link, object_property_set_bool, object_property_set_int, object_property_set_uint, object_property_set, object_property_set_qobject};
>      expression obj, v, name, errp;
>      @@
>      -    fun(obj, v, name, errp)
>      +    fun(obj, name, v, errp)

I'd suggest

@@
identifier fun = {object_property_get, object_property_parse, object_property_set_str, object_property_set_link, object_property_set_bool, object_property_set_int, object_property_set_uint, object_property_set, object_property_set_qobject};
parameter obj, v, name, errp;
@@
-    fun(obj, v, name, errp)
+    fun(obj, name, v, errp)
      {...}


in addition, to not

> 
> Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
> message "no position information".  Convert that one manually.
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Fails to convert hw/rx/rx-gdbsim.c, because Coccinelle gets confused
> by RXCPU being used both as typedef and function-like macro there.
> Convert manually.  The other files using RXCPU that way don't need
> conversion.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

The change should be safe, as compiler will complain if something is not updated correspondingly. The only exclusion are object_property_parse and object_property_set_str, where both key and value are strings. Check them presizely looking at

  vimdiff <(git grep object_property_parse HEAD^ | sed 's/HEAD\^://') <(git grep object_property_parse)

and

  vimdiff <(git grep -A 1 object_property_set_str HEAD^ | sed 's/HEAD\^://') <(git grep -A 1 object_property_set_str)

seems everything is updated.

Also, looked through manual changes for hw/arm/musicpal.c, hw/arm/armsse.c and hw/rx/rx-gdbsim.c. Seems correct..


> ---
>   include/hw/audio/pcspk.h                 |   2 +-
>   include/qom/object.h                     |  45 ++++-----
>   include/qom/qom-qobject.h                |   7 +-
>   backends/cryptodev.c                     |   2 +-

[..]

>   
>   static void property_release_tm(Object *obj, const char *name,
> @@ -2384,10 +2375,8 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
>   {
>       uint8_t *field = opaque;
>       uint8_t value;
> -    Error *local_err = NULL;

This (and some more) chunks are obviously from some another patch..

>   
> -    if (!visit_type_uint8(v, name, &value, &local_err)) {
> -        error_propagate(errp, local_err);
> +    if (!visit_type_uint8(v, name, &value, errp)) {
>           return;
>       }
>   


To find problems like this, I'm trying to rerun your cocci-script, but I don't know how exactly do you run it.

I've tried --use-gitgrep, but it doesn't find some files.

I've tried
git grep -l 'object_property_get\|object_property_parse\|object_property_set_str\|object_property_set_link\|object_property_set_bool\|object_property_set_int\|object_property_set_uint\|object_property_set\|object_property_set_qobject' | xargs spatch script.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff

Still, have not updated target/arm/monitor.c, strange..

Another fact, which makes it hard to check the patch is a lot of manual wrapping/indenting updates.. Hmm, I need some tool or script to make it simple to compare commits ignoring wrapping and indentation differences.

-- 
Best regards,
Vladimir

