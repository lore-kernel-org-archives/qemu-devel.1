Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FBDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B8420760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uSuLIZ4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B8420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKUf-0002j4-Rh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKTX-00023F-4O; Thu, 11 Jun 2020 06:30:23 -0400
Received: from mail-am6eur05on2100.outbound.protection.outlook.com
 ([40.107.22.100]:39137 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjKTW-0002fI-1Y; Thu, 11 Jun 2020 06:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu3PSG0y5BL450HiyWal0baNs5huNEbyM/79QicRGmtCuqTy9qtA8H9fdfSotpgcLtY9u0f/kOPKCEUpSnMFflxRS0vQdoFCsFkI7GoSaAi+dzdsd/zHnOSlZ/9ha9xoxYQcYtu7lUVVSvMbzbf2O+VmsVehXpp3MFhnf/85nkUJQ9iEP6XxRzxbTk5BfkwUhIfOR+aAPPkw9XYUz6Z8RrbcQVLBV6bZs4tU/1AjW10nAEiNH3Ik8jqCD9mAycmgGVVqjdWh/HrqRxRnD88Odw5nsm9UB6kX795JtRvyKly8BRNgxYHi7mgYPZWzwMb0ytlJmwfXOo+1RD+KJC7B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i24YIShQLEMhqKb6mBJSAiXwGMZsNjJoqboRDgJelXc=;
 b=DNgtkVuoOl15qzLmnOkDIPIQawcuUVUCFAYFozt0asshn5WHTmqZeX0DlEWAXQghQHrettxH/WCVne3oaAsher1/oggnjVQR6Q08wbm1eCJEIurgaqMe+T1HDldbYaCH9hBsJ+n5L1/GHuxQudieBeF8Ykp+enh1ym+WhYPjb2t/uZxZWXztMjtbHue7QXAnYsGuO60DzA+p6sK6r4B17htC0xksKhA2BWPCXg7RCvv/jmhQkHEIgzx074HTkpKsivOWPRIeZYaJQs9bz7u7jvl5JiRmv6hgwVk22khu473GsgAOwpwQKuw0YoNSaNZlzyhHZZo2069xQb7D6zUoAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i24YIShQLEMhqKb6mBJSAiXwGMZsNjJoqboRDgJelXc=;
 b=uSuLIZ4Hkupd2M3v5K768ZuFCtTLp4lHKTX9O5XKABBsmuoQ+46PQA279G8Q//mne2mjK+5PXDYkAHCpEzCdHQ867A2XtA9uUPgBKpPUabFbfNBWTkBeRIBYKhErP5Hs0Gfn+0rDM6a3dxLNcPTnGXkZx8x6CvovsCbaOoGY24s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5414.eurprd08.prod.outlook.com (2603:10a6:20b:105::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Thu, 11 Jun
 2020 10:30:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 10:30:18 +0000
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
 <20200611121354.0a4d2939@bahia.lan>
 <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
Message-ID: <b044e712-4786-6d75-133d-7104e978dc4f@virtuozzo.com>
Date: Thu, 11 Jun 2020 13:30:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0102.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.159) by
 AM0PR01CA0102.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Thu, 11 Jun 2020 10:30:17 +0000
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30229fe5-af64-4dc8-e606-08d80df26fb8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5414:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5414EB4176A175380673CE7BC1800@AM7PR08MB5414.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+zr8kn6CJ0yUfccQTlLeGlrg9hkmDIzvpyLf4CDYQ4tSfWj7eNisWu0dQhRWaF6HGEBfZPHSsGUoOdqGc3jebmgBDCq+3dbM608v0KR9PHQAQ0BBLcy3MNvpJLCHsOTC37jGapUAWgTrJqN0iXAc2tY5khAgTBIsQBNyXLny8lopb2iY4cJmPbqg2mD1bQ4y5PfwriL5VZhuSWYc+lwdgemgl1pWY+418NhgAMY1/UFSa6yyo8xd/VLd5hZ6lBHvdhXgWqbgoh64eNoDvTtHjpiyjW0HpCoqXINMUxUQhtNyxvzSGnm0Aid2ey4KMV+nJuh2AbpM4tDp8xHLyu8bmSvbMkUewBPw3fx8kUMEa/SzZclnPwJaLG8fhs85ErS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39840400004)(376002)(478600001)(66556008)(66946007)(66476007)(53546011)(36756003)(31686004)(16576012)(316002)(8936002)(8676002)(6486002)(956004)(110136005)(2616005)(52116002)(54906003)(26005)(4326008)(186003)(5660300002)(86362001)(2906002)(31696002)(83380400001)(16526019)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8tnHJr4ESxWCnxmVX5L+YTYxVrDSWzJzeZQb3R1Eru0PVMx2UM4CpH9atSOgq0NwfDNXpn3+Q6ahByCsyNOWbx2EO6KKgw5HU8RuXDbuJftGOruD/e1sUk1VmYKdgqZtsCtA/yvz5zJxP+glkuebKvDpgtX4VMGVr1HTKI+D+Az3e9JcvZAAIvLicqjhIjzi9e51s6c5QjLm0IM5aBQop+4ShRPHrB2drHD9i0I+rJp9Q5iwmgaKh1nphtaWuHIfxSwLp46pYjVzIctGtFMUI4fg32QLG2ozeRelMJSu/XgJFdgxoeGU6zQVi/rV2Mgv4lgSm0k7w4Ma2VjernCFO1vRc7mfmJSWh4MTTd3JYJq5v44zrUSwL2mm2jVEe59HwQtxjPvbM6osrppK45mWQLC07jyQ7fJkCOYV8mFuwmOUt50qZqbVHrEqbq5ZTPnNgD3pN4WNq/2XmXAiVDyp7YdXhYha+ZVoNSkyImu/30QNJUINW+iI3bBFBMHaYNto
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30229fe5-af64-4dc8-e606-08d80df26fb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 10:30:18.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brUJg4UG52LxRbAQBoW5y8BLuglPoXBJaTolWmzf0HRRNsLfamTJvAT8BeCxzqyR4BqHiuPUnDNRkcZkWyUng0b5BeRpzU1+YXYYZgiiTNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5414
Received-SPF: pass client-ip=40.107.22.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:30:19
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

union I mean of course

> 
> Than, instead of passing pointers to error_abort and error_fatal as special casing, we'll pass pointers to functions,
> which do appropriate handling of error. And we'll be able to pass warn_report function. Not about this patch set,
> but seems interesting, isn't it?
> 


-- 
Best regards,
Vladimir

