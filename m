Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B51F206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RH29RmJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B51F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKgP-000192-Rg
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKfg-0000cB-UJ; Thu, 11 Jun 2020 06:42:56 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:6169 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKfd-0005XX-K5; Thu, 11 Jun 2020 06:42:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs/lHV0KcMWelJnel+xDyt1mUqYv/AYpQ6Whixl+KtiidwV4gtAPhGeR0zjgI7/aPKF6OHwUx6pVkv9nUyNUdZ5ez3ovDND0lLE0aBy/U+aRam9wme6v98tyeGTQRT4EoQnrCu3JQRSLDePDVBz3iqCTZNriksZJgsHK/bvcWo68+TMIa0s6bLuNlf5qlAxa2fSSLknx0aaiUF1BfvZlsSGsj6mCjebTkDmseo56RQJT5W78ZUwGJ0IQpiwMvwxYjR5GtR9dzKkR4WpKdQF/UKGLNJfvZvVGYm1W0gOHuLCyO5Ld4YXdZYgBkH3esVgiiY6FlkuBimfcKAx5/1kcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOxt0eUp9el0m378VzykSCAC3LbQr+ITe4WaW+MRtQ0=;
 b=jSewYkrca0rLYy96KZ3hS2tOaNnV/NZDrVYRy49GltpbmasGHavIfVlly7mhOABK1wedVr4SqJsEks5+9DA3SWmPooItHn1/aln4K+1ei8eM8Oh6YAU8CCPnQNELFs+Qggo3Ov18NIgRcePxta1jjxOYDykFfaKAfCJ+rRFUVtXaDVSHA9TWd985vD5xbSm4hkiX9sVbvFwH9k/hXG9whpoVUxCzdL+P46kJMYNITU47Yy8yQ16McUSLRrRtSs19jDzyvRtHel+yZ4LoSODAxnPSBFxk/IXTtnsAWTCcWp1Q9Vh/Sq2vgzgrgLTMHrHsLYMRwey+i5G2ENelAEKw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOxt0eUp9el0m378VzykSCAC3LbQr+ITe4WaW+MRtQ0=;
 b=RH29RmJqbMD+9m9jbpKfUFPS8kh2OeY+yoK9v/DlDdIbmpQ4/5LLuTsYdyB+qqSe7w+Fa7cyOgU24gZI0/kW411zkPgfFiOXLe7tYMjAsYqSdHZYP6zBdoM7VR2dRbH42PHqF3xy/VG1Pl0l3bdNujwX8pAeV+YIo2MYjqLk/sI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 11 Jun
 2020 10:42:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 10:42:50 +0000
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
 <20200611121354.0a4d2939@bahia.lan>
 <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
Message-ID: <f0fe6afd-91a8-ae78-79f4-17740431af50@virtuozzo.com>
Date: Thu, 11 Jun 2020 13:42:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0100.eurprd02.prod.outlook.com
 (2603:10a6:208:154::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR02CA0100.eurprd02.prod.outlook.com (2603:10a6:208:154::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Thu, 11 Jun 2020 10:42:49 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4e5608f-1cb6-4127-cea0-08d80df43009
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5496709705B00193F301E676C1800@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IABKGJe0zMDX5EJwt0gMNm0vgAisS0q9NaxIOtqr8z+8ZjcxcyO6ez9+ynyoSEQGdn0P7fr+o51TdL0jAcfI82KNFcBvEL59/5FTtme0WlUxGFp9qwnlj+JUuLyMU+QekD/4wiysvij84D9tVlikmaN/tbfI3yKPqbrB0QCU8qmzcvggHkyohLm9b9L4F+qVZVULBCJoZOwGpF0/4/L0JRs/HoXNUAsYJUa//ss90yB86smHySjKy5umkUMvTPders4pZ7Zr5owR2l4aGkb3pFwgwGmHy/RRySJIpVHuZbD26dUXT3IabOVaJsvkaOmeHNKFEMkLTZX0WM2h4+KN9IDCqotK+bt7sBVq2CGcWNuN3hP7fQOq6EREaFfpdVkP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(478600001)(83380400001)(31696002)(86362001)(956004)(66946007)(2616005)(66556008)(66476007)(36756003)(53546011)(26005)(16526019)(52116002)(186003)(2906002)(5660300002)(8676002)(316002)(8936002)(16576012)(4326008)(6486002)(110136005)(54906003)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: I2CZsoWZiI/SPJSu0d8DP/wtaOwDuDeG1Wm4RhN2Gtjb2oB2nVoKmFctjdK0GGH2J7j0CD6IpDn9Z7NA1A9WWZWei5IudIDgz5RqT4h2TuO+U/oYyUCuC8YEFAF0p0F0iXpQH0FoawGd8U6Y9+fA7aLYJZPhB/sBfeiBBQ9SQVIBN/TVLuv2LkqlywyRGqcDjhuCJVnXBW/8c60Xiz/W1FjdfWM1LjCIufzqeBgJhuudQjNyNpq7TJyC4LlGO4tbdXAqoE/s1UmAUOJU59gR+7mMD7LLnbo97CcAtYDvXz13zx9g2MiNWRJLYRhYSO1H8JBDaBoudSSnLGyhzxJNBzJlwh8g2k0kxbqoybHGN7TVQSMRPDFkEVuZu1EC4pxuqIUrxSdhRPQpqyB9voWryWUsiykePUaVavBDn0/bzgoVI3GV446gF+mbnemnvok0eIEZSqqzTzePwJ4NRHSCStdHbKI0HT3MDQ3/K0bIMyOSTKUqlIKJva/8L6Vhi60m
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5608f-1cb6-4127-cea0-08d80df43009
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 10:42:50.2747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjwbBuRNZF9o/NCzjY4JvLhDjAY3oqJ/Q6F82gz1iMMRceElALnC7+BLoJXZxnU/hGqpd9DGMpgA+z8JOHZI9gUSKhOSYeZ/4BBnPT5KD/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.7.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:42:51
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.06.2020 13:21, Vladimir Sementsov-Ogievskiy wrote:
> 11.06.2020 13:13, Greg Kurz wrote:
>> On Thu, 11 Jun 2020 11:50:57 +0200
>> Laurent Vivier <lvivier@redhat.com> wrote:
>>
>>> On 11/06/2020 11:10, Greg Kurz wrote:
>>>> We have a dedicated error API for hints. Use it instead of embedding
>>>> the hint in the error message, as recommanded in the "qapi/error.h"
>>>> header file.
>>>>
>>>> Since spapr_caps_apply() passes &error_fatal, all functions must
>>>> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
>>>> to be functional.
>>>>
>>>> While here, add some missing braces around one line statements that
>>>> are part of the patch context. Also have cap_fwnmi_apply(), which
>>>> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
>>>> well.
>>>>
>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>>> ---
>>>>   hw/ppc/spapr_caps.c |   95 +++++++++++++++++++++++++++++----------------------
>>>>   1 file changed, 54 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>>> index efdc0dbbcfc0..2cb7ba8f005a 100644
>>>> --- a/hw/ppc/spapr_caps.c
>>>> +++ b/hw/ppc/spapr_caps.c
>>> ...
>>>> @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
>>>>   static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>>>>                                    Error **errp)
>>>>   {
>>>> +    ERRP_AUTO_PROPAGATE();
>>>>       Error *local_err = NULL;
>>>
>>> I think you should rename it, something like "local_warn" to not be
>>> confused with the _auto_errp_prop.local_err...
>>>
>>> or don't use ERRP_AUTO_PROPAGE(), use the local_err instead and move the
>>> warning inside the braces of the if.
>>>
>>> Same comment for cap_safe_bounds_check_apply() and
>>> cap_safe_indirect_branch_apply()
>>>
>>
>> Hmm... local_err isn't useful actually. It looks like we just want
>> to call warn_report() directly instead of error_setg(&local_err)
>> and warn_report_err(local_err). I'll post a v3.
> 
> something like this I think:
> 
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -250,24 +250,23 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>                                    Error **errp)
>   {
>       ERRP_AUTO_PROPAGATE();
> -    Error *local_err = NULL;
>       uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
> 
>       if (tcg_enabled() && val) {
>           /* TCG only supports broken, allow other values and print a warning */
> -        error_setg(&local_err,
> +        error_setg(errp,
>                      "TCG doesn't support requested feature, cap-cfpc=%s",
>                      cap_cfpc_possible.vals[val]);
> +        if (*errp) {
> +            warn_report_err(*errp);
> +            *errp = NULL;
> +        }

what a stupid code :) at least, if condition is always true.

this all should be substitute by just

	warn_report("TCG doesn't support requested feature, cap-cfpc=%s", cap_cfpc_possible.vals[val]);


>       } else if (kvm_enabled() && (val > kvm_val)) {
>           error_setg(errp,
>                      "Requested safe cache capability level not supported by KVM");
>           error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
>                             cap_cfpc_possible.vals[kvm_val]);
>       }
> -
> -    if (local_err != NULL) {
> -        warn_report_err(local_err);
> -    }
>   }
> 
> 
> Or, we need to implement warn_report_errp() function, as I proposed in earlier version of auto-propagation series.
> 
> =====
> 
> side idea: what if we make Error to be some kind of enum of pointer-to-pointer and pointer-to-function?
> 
> Than, instead of passing pointers to error_abort and error_fatal as special casing, we'll pass pointers to functions,
> which do appropriate handling of error. And we'll be able to pass warn_report function. Not about this patch set,
> but seems interesting, isn't it?
> 


-- 
Best regards,
Vladimir

