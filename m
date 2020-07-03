Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1C7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BF82073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Cwvea67U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BF82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOWw-0002dD-V1
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrOCc-0007n1-Na; Fri, 03 Jul 2020 12:06:15 -0400
Received: from mail-db8eur05on2126.outbound.protection.outlook.com
 ([40.107.20.126]:58457 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrOCY-0001Gh-AT; Fri, 03 Jul 2020 12:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ+lbVG08L5D8SNPPZSxmXukK6sJPWiQcu8HbQSz4s7t1X+0f4Udeb6PMaVTtd+b0REzHSSvjcEuGR72lTqOqeyJUr5cHFYxhKqHdOGSxIo+Avgw+YnP1nkNOoGNd1o65OrcJVy+KaYfwQWubN9oxRTUqmYcinhMpDxHf5xoAAQUrJCWaBC9oNAccrWbUXhlA28rBGWOzifanhPpFOlCWplJWSpBwbyIH4ivXSOSLUjVhoNwm6Fr6wenVOHJt1PJ3EpipQhwqEh0DZOuUjB70ZjIb3ZLBxsMCA8gZNHEHX9arpzBmSG2tM3bBKFHo9j2GtgxdPwKiVgMmtsrFF5k7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxTz9TBA7HJgj2AgpgwKqtaSPcnkztL2Z657MBkdBVE=;
 b=DaAUtxP3HCZdmi7Rb+8nQqVmoyaPRyA1s9mnjOlJaSq/gITjSbpIIpn8hxL1iCZgogZydU/HknrqatzXOQZQwBOrvXuuShbTVtvhlVLOLQa9nlizRWl9w0VxCqSNe8klOe+EEubsWo8b8lJbr6iptalwcQoGOTogXtfrctCyBAXG+EYarYPjHvQVQ6ggUOyHWoR1O4Rt0bCW+rmR3Pg9PsiGRCvoHJtrNNCD9kyN/9wUjqUc+S26bqg4Drz7BR1WE1ZNx+qIfj8CAprC9OntNCaRovWsmVwCebVHvj/9nFkSrh6jDgSELOoRgc1xiGCxa1MbOrY4+yRsb/uGYrKYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxTz9TBA7HJgj2AgpgwKqtaSPcnkztL2Z657MBkdBVE=;
 b=Cwvea67Ub5h7HMsKui+cOmI0q/Pl2C8KFiOBGo8PZFCxl+lUAnAwNPTLWqI4aFPnQzXSlaYU5yeaybfflwjN0Of0gA7Z3GQ1eJaSqHD+CclCeJfZs/lX2mrFnrI4RCDh84AyQzehBQGAxnGwo6zDerZ8bpAgMLKK345EbJrlFYw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3623.eurprd08.prod.outlook.com (2603:10a6:20b:48::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 16:06:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 16:06:06 +0000
Subject: Re: [PATCH v2 25/44] qom: Use return values to check for error where
 that's simpler
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-26-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3468bdbe-2e7d-3a51-4c2e-5f188ca092fd@virtuozzo.com>
Date: Fri, 3 Jul 2020 19:06:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200702155000.3455325-26-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0002.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM4PR0902CA0002.eurprd09.prod.outlook.com (2603:10a6:200:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Fri, 3 Jul 2020 16:06:05 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37284fc9-f69d-4c87-cbec-08d81f6afdfd
X-MS-TrafficTypeDiagnostic: AM6PR08MB3623:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3623F2160F0CB3DF878C8E29C16A0@AM6PR08MB3623.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: huU69RTQNEPIP3fhY2GmTZQcNrXLuYxCkwedJJH0wiNdp07LQYP1+zAEuKrzOraDRYct92T1ko2NEyXyNSgUWB3tERqCepXIkxTKYt3F7+smRKhf2kX8qdl2Pfz8Cwf/3kSSbR7dR0tQw59Fj1PSDtfjliUIQwyKiXAl8Hj8xU1eWF/FUr/Fhpp4L+P4/RCxzaS3I6mPAvy7YYY3azTgKCZIKC+a3UyRoUTnTO7PwW0JdRGIU26eJZaD7L9CJ5JoeHnOJJJ3cmZcVehEyF0oRVDesxfrpvM7SJ3NvCvlTJD+OO/F/C8jEeZTc2QIcmkObwvdBb6Y7w1gr9oBJWS3ylbSdJdbdg+x8l3ihPyhMy16YQoNe8iSFD1bW0rMwQjE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(396003)(136003)(366004)(346002)(5660300002)(8936002)(4326008)(2616005)(956004)(316002)(52116002)(31686004)(8676002)(16576012)(16526019)(186003)(26005)(6486002)(478600001)(86362001)(31696002)(83380400001)(66946007)(66556008)(66476007)(2906002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Air7BP2B/Gx9p9aeZx0d/yO9eeIrMJSW2vyy6cMV0mOvtFIM6wh5dlFOqbSjfZKfQZ8gE5YJwVM1sXy8en6l70G8E3B+e54XFxNMFlYm+cAQA0iIsA4qAcSm+KWX8DTOO7gp5nvVgNCJvS06JxWe0dm422Pa6hTym88+7f/ULhBuAvAMSfYHqf0Vah3WO0QsgcGSOpIqXn25WY4CQf451vK7Fz+Ab3wNG3cZJI5DkPnRQ07RotWGeRmoIZu+M2nGySG+Q6d1OgbeIbuucGkFVFzpAH110nGkvJOH9EbsUCdmOJZu7rwiF47nl/JG1rGfiuCs8MMHPjX54RIIDOMkKGrWVN7ZzbyNCfLWx8okWAg3TT++GHJiN3jtnNjMpyQDeVPElTNikOVvj7RWInNVL4hf9G33jv0fg8SHhubMnwfSp4ub79EyaHM1spS9dIvwFN+jEJYSYsKgnqP214+sx9bi6FTI4kCUxKFDm7OIowc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37284fc9-f69d-4c87-cbec-08d81f6afdfd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 16:06:06.3756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1fhiKb4NJl4b2I0IZsJgQH1IffUYw+qCr9Xiogu7N3nCDztx/1Ke9kCC6gaveM4ZlgahDJBLKhGscYKl9/MrFU2TyBlm8O3X2R3rtC4DK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3623
Received-SPF: pass client-ip=40.107.20.126;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:06:08
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
> When using the Error object to check for error, we need to receive it
> into a local variable, then propagate() it to @errp.
> 
> Using the return value permits allows receiving it straight to @errp.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   qom/object.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 0808da2767..56d858b6a5 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -549,8 +549,7 @@ void object_initialize_child_with_propsv(Object *parentobj,
>       object_initialize(childobj, size, type);
>       obj = OBJECT(childobj);
>   
> -    object_set_propv(obj, &local_err, vargs);
> -    if (local_err) {
> +    if (object_set_propv(obj, errp, vargs) < 0) {
>           goto out;
>       }
>   
> @@ -743,7 +742,7 @@ Object *object_new_with_propv(const char *typename,
>       }
>       obj = object_new_with_type(klass->type);
>   
> -    if (object_set_propv(obj, &local_err, vargs) < 0) {
> +    if (object_set_propv(obj, errp, vargs) < 0) {
>           goto error;
>       }
>   
> @@ -1767,14 +1766,17 @@ static void object_set_link_property(Object *obj, Visitor *v,
>       char *path = NULL;
>   
>       visit_type_str(v, name, &path, &local_err);

why not use return value of visit_type_str ?

> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>   
> -    if (!local_err && strcmp(path, "") != 0) {
> -        new_target = object_resolve_link(obj, name, path, &local_err);
> +    if (strcmp(path, "") != 0) {
> +        new_target = object_resolve_link(obj, name, path, errp);
>       }

Hmmm. You actually change the logic when visit_type_str succeeded but path equal to "":

prepatch, we continue processing with new_target == NULL, after the patch we just do nothing and report success (errp == NULL).

I don't know whether pre-patch or after-patch behavior is correct, but if it is a logic change, let's note it in the commit message, if path equal to "" actually impossible, let's assert it. Or just keep old logic as is, by moving return (together with duplicated g_free(path) of course) into "if (strcmp(path, "") != 0) {".

>   
>       g_free(path);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    if (!new_target) {
>           return;
>       }
>   
> 


-- 
Best regards,
Vladimir

