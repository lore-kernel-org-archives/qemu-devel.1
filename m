Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE59E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VeMc+r3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE59E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKim-0003Pn-4O
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKhE-0002GY-FY; Thu, 11 Jun 2020 06:44:32 -0400
Received: from mail-eopbgr20101.outbound.protection.outlook.com
 ([40.107.2.101]:58207 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKhD-0005gg-D8; Thu, 11 Jun 2020 06:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJAIVjvhwOOqxEZ1n6UewOwy6VXnY35ZNRdQmbK+4adaQj7XhdYidHkjo+GFpZC7vGsx4fipiyL0GXDDgh7Ja8BfrwFX/4e9r2BVyL8aAqvQUxivxMZkRgkB1yNCSOUoR89u4nVps4glGsNIFasfp5GaMdCcK+ofDqa2rVRz+sj7GbLvkdTIMfpApCQJfsNaVoUY2i7ULGV4ImBOdRxeZsZT4SrGF7AMODWaO5/rX+XG25/wwmEegdktJsOYMG3hvgk50ElSjTcHCROFjb3GLHSzLGilGG/2iQlIGicdPNjkawQ7QHrTJ6+5Q4LunA8miT6kNmdYFJieSQacHjRYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXBOLaSeITu7K6RbG7YnAGfdifNHT3zi7iIeOxMd/Is=;
 b=iNsw6c3UWr/VX1a1/hRg3rxzgFmnMHMt5uY1ty7GDEV6HHdOzP4tJnjSSY428Si8YQLePdQih8OC68mqLjOlXSO1vpcV8vvX/ncJXNNvq01Fj/fd8I+VrNlAx6np1EBnI+/izy57GHvyWNzd7c5KG1q0k7AvsVd7X9Wz9jui/0WCGXWnRtb2CL/YB/uUly8AtJjDGbIOmb9bkhCJmsZy0leUCb24BMjawFw1vYCuoMhdo4POhBWKw67kTTZT7T3VUgOCE/WNEu/IaVZx8aCEoJL4mUFihoipmMWCfrtBYnxY2P059fInkEjPrmGhr1weQDXispQ4VO45Kx/Twb2T5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXBOLaSeITu7K6RbG7YnAGfdifNHT3zi7iIeOxMd/Is=;
 b=VeMc+r3dZh1kY/H3hwkwDcg+RRFDzYeRb+WYxjLm2OsUh1zOAG0aZayT0RBK+VqgQhku6B/mdUNnEYYZ0dbrhHCRRYLxfZ6TS985bgqQ4fkMhDW/yiXNsneKGJxXxSpdN5I0gPYLfYpCjso2Xfc8/hEymO0Hs8DHkzWjQ8OpTWQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 10:44:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 10:44:27 +0000
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
To: Greg Kurz <groug@kaod.org>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
 <20200611121354.0a4d2939@bahia.lan>
 <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
 <20200611123952.15f465dd@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d28a8fdf-842b-dfca-d6d9-8b8535273920@virtuozzo.com>
Date: Thu, 11 Jun 2020 13:44:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200611123952.15f465dd@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0091.eurprd02.prod.outlook.com
 (2603:10a6:208:154::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR02CA0091.eurprd02.prod.outlook.com (2603:10a6:208:154::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Thu, 11 Jun 2020 10:44:26 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10745336-3f11-4896-186d-08d80df469ee
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5496E19B5F6DF2899C4F95CDC1800@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dldjmu/+M7cz3pLlaDvuWkVvL7ZA48Fqb4XUaPsYaYz68j/PL5eXKyfbEAvUXJOUmVslACw2MOtV2Z0fs6MkgAYcOxx3lYzpXPw0IgmencJtfTYCirFmhkMqu4xWXs/R4cPN6A2TgmKwSfNEoh+l9nDp+qaJg0TkCOqd2b7IBLePZT3F5mbIjzSl3XNHJCHjfOxbBguTjQ225wAxdpqi+vsz1F1XityZIwrORv2NJP2IjCsfn2x7/XDW0R3wlAX14Uw92d9yWqSpEWAffZTLA0DvG+qfeS84GJD3h2d3hL+vESxTRwtnOAz8joqWxJeUPGCtoBl4WjRPpUi1V/WTjQcWd+cJPQfWa/ric/6oNJwosyJK926MnsClggXLjwmL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(478600001)(83380400001)(31696002)(86362001)(956004)(66946007)(2616005)(66556008)(66476007)(36756003)(53546011)(26005)(16526019)(52116002)(186003)(2906002)(5660300002)(8676002)(316002)(8936002)(16576012)(4326008)(6486002)(54906003)(6916009)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8i+PU6CgsiM6ouKk+XU1YzxoHy1yHnt+0+4J3C/9SqocP3fxS1e+pDwpJg2vVhI6iTu5Gpkw/pxy6RzS0HYPGrRR7gp8GdQ+vuHxfVCHXcEZyfIQTm+Bt8q6LCHNKgnsHE46L+6zMs0J9s/xvk+I/kKCmcZB4FxIYz0g3/McjKudS7+oZBZksaOncUZ3mwjTws8QYE59p5F1tN2mluhELoNIpkg3maWaaIM1NVF7xzQTrsoUmcAiFg8nZEUiCtCFSU2mto2t3b5MpydcaM+kQLQwvBL6BrKXO9RJHEEvY2hoKbJPSLD1oRDd10v6d2th9WaeYYP0IQrMaTzdA0Wj+CKBjvQb576MqReEn4oR1NgjoA1o4pgRYqHpipAeJakOAGYa5tn3rUEFIhrSY/qpWE2yNpOv2r0VKDH/owMEdYD13LFewWLi2pCobi90BM3ZbqkaJn8kqCjH4tODigd/Dv7AObek4oG6m0noUM5idTtR5DGy23aMDKZEGsuIN9sB
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10745336-3f11-4896-186d-08d80df469ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 10:44:27.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch4zm/OLNGcSXMwuedLugD5SijjrVRopJZC/logid0xZITJpcAwB3rrFcQBAQlknE0GiVHVpU1T+mShorxemXIlnmjl/SCFIAnYhFDDbZZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.2.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:44:28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 13:39, Greg Kurz wrote:
> On Thu, 11 Jun 2020 13:21:51 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> 
>> 11.06.2020 13:13, Greg Kurz wrote:
>>> On Thu, 11 Jun 2020 11:50:57 +0200
>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>
>>>> On 11/06/2020 11:10, Greg Kurz wrote:
>>>>> We have a dedicated error API for hints. Use it instead of embedding
>>>>> the hint in the error message, as recommanded in the "qapi/error.h"
>>>>> header file.
>>>>>
>>>>> Since spapr_caps_apply() passes &error_fatal, all functions must
>>>>> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
>>>>> to be functional.
>>>>>
>>>>> While here, add some missing braces around one line statements that
>>>>> are part of the patch context. Also have cap_fwnmi_apply(), which
>>>>> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
>>>>> well.
>>>>>
>>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>>> ---
>>>>>    hw/ppc/spapr_caps.c |   95 +++++++++++++++++++++++++++++----------------------
>>>>>    1 file changed, 54 insertions(+), 41 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>>>> index efdc0dbbcfc0..2cb7ba8f005a 100644
>>>>> --- a/hw/ppc/spapr_caps.c
>>>>> +++ b/hw/ppc/spapr_caps.c
>>>> ...
>>>>> @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
>>>>>    static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>>>>>                                     Error **errp)
>>>>>    {
>>>>> +    ERRP_AUTO_PROPAGATE();
>>>>>        Error *local_err = NULL;
>>>>
>>>> I think you should rename it, something like "local_warn" to not be
>>>> confused with the _auto_errp_prop.local_err...
>>>>
>>>> or don't use ERRP_AUTO_PROPAGE(), use the local_err instead and move the
>>>> warning inside the braces of the if.
>>>>
>>>> Same comment for cap_safe_bounds_check_apply() and
>>>> cap_safe_indirect_branch_apply()
>>>>
>>>
>>> Hmm... local_err isn't useful actually. It looks like we just want
>>> to call warn_report() directly instead of error_setg(&local_err)
>>> and warn_report_err(local_err). I'll post a v3.
>>
>> something like this I think:
>>
> 
> Not even that... we have one path (KVM) that directly
> uses errp and the other path (TCG) that does:
> 
> Error *local_err = NULL;
> 
> error_setg(&local_err, ...);
> 
> if (local_err) {
>      warn_report_err(local_err);
> }
> 
> It really looks like we just want to call warn_report().

yes, I also came this)

> 
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -250,24 +250,23 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>>                                     Error **errp)
>>    {
>>        ERRP_AUTO_PROPAGATE();
>> -    Error *local_err = NULL;
>>        uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
>>    
>>        if (tcg_enabled() && val) {
>>            /* TCG only supports broken, allow other values and print a warning */
>> -        error_setg(&local_err,
>> +        error_setg(errp,
>>                       "TCG doesn't support requested feature, cap-cfpc=%s",
>>                       cap_cfpc_possible.vals[val]);
>> +        if (*errp) {
>> +            warn_report_err(*errp);
>> +            *errp = NULL;
>> +        }
>>        } else if (kvm_enabled() && (val > kvm_val)) {
>>            error_setg(errp,
>>                       "Requested safe cache capability level not supported by KVM");
>>            error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
>>                              cap_cfpc_possible.vals[kvm_val]);
>>        }
>> -
>> -    if (local_err != NULL) {
>> -        warn_report_err(local_err);
>> -    }
>>    }
>>
>>
>> Or, we need to implement warn_report_errp() function, as I proposed in earlier version of auto-propagation series.
>>
>> =====
>>
>> side idea: what if we make Error to be some kind of enum of pointer-to-pointer and pointer-to-function?
>>
>> Than, instead of passing pointers to error_abort and error_fatal as special casing, we'll pass pointers to functions,
>> which do appropriate handling of error. And we'll be able to pass warn_report function. Not about this patch set,
>> but seems interesting, isn't it?
>>
> 


-- 
Best regards,
Vladimir

