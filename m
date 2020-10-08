Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ADEC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEAD215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QC5CnFnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEAD215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRHn-0006No-Hd
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 04:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQRH5-0005qy-Dj; Thu, 08 Oct 2020 04:27:43 -0400
Received: from mail-eopbgr20107.outbound.protection.outlook.com
 ([40.107.2.107]:55470 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQRH0-0005oQ-Fp; Thu, 08 Oct 2020 04:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUZu6ab+Ryh19dguOBpPMElL+ndJs1kMXxQbECrCRcBJMrKlOp+f8uSO1huAOCdgTXMWRBhzliGiqltssEeeiWNfAHDPXb5VVlbsFdmWQUOTYlMvUu2M4eMm5D58JTxzmGE+vu9uXp01/pWeHnt9iX1kkd0+JyfvjGt8X7XFoAgxWd0Ajqo2CYaO+qrDjhoi9ntfYyOoirDx5QF2Cw/6+tkjt6Gh0xVtIqyde13GzQzDLTtJPTLOQ+dVuzZUCKBJH6Plb/F6DCnRhYQ5z3WPIkjuzb7bkjadLuT54LZiQtp0xBV97zKeeo9jh4JsbN/aYruScSgSBcoflKSsXBgPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTTAfLh9U4eIqO1c7eEOAq2WIFMORFNgaWsk6XPoPPQ=;
 b=CPiA26MGzRkfITASAhkuVVvUjTxrcOncOnXZRh96cCHDojLgeYNW/iL9t9Vpz2yT5OprFtxSnHn7ZUi28C1m7s9N2nzlv0+jhrC3L6DhR4I5ppL7Xu6fg+rnRQd0ffgDR+OuvAukWEFznkCrI+yZcTJAdxHQsvxFWrA2GhMjJHBxTb7nKClViqap/a9AE0t8J5CTo7IuZZUiL0lclWkDYkQwBxN5P6YVDDOAqn4BCGMstPkCEExyvhPIEtRRwE3s1KjkyShoRPpuNBSrOWv6cVbj0hsJ57eDbREPUgrfs0A7HG166qail3RKn1xlPdhnmMnKXsgV2cyELfNEXW2S4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTTAfLh9U4eIqO1c7eEOAq2WIFMORFNgaWsk6XPoPPQ=;
 b=QC5CnFnmKR63C79FbqSQYqcX2tZX9EqNUQnJwoZWXoWRyeYx0cTDd5CKfmJupdpqD54siC2MFdaEZQjF+uo4wM+H5S12zMU0pW8ON7JtMBNK9cmnIyxpF9ZRwyPlQvsnKZ5jpaoH55+YE74EWISz8Y/XVmlsF6OvBsAm9/hXr7U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4405.eurprd08.prod.outlook.com (2603:10a6:20b:b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 8 Oct
 2020 08:27:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 08:27:32 +0000
Subject: Re: [PATCH v2 1/5] qemu-nbd: Honor SIGINT and SIGHUP
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-2-eblake@redhat.com>
 <224e825c-a3f8-00a9-0add-88fd13cebab7@virtuozzo.com>
 <fbcffefe-b93c-788e-85e4-363807489411@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a8f7b57-094a-0f21-a3c1-0c5e185745c0@virtuozzo.com>
Date: Thu, 8 Oct 2020 11:27:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <fbcffefe-b93c-788e-85e4-363807489411@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:208:1::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR04CA0071.eurprd04.prod.outlook.com (2603:10a6:208:1::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 08:27:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4f5fe87-0c7a-461d-eb3f-08d86b640081
X-MS-TrafficTypeDiagnostic: AM6PR08MB4405:
X-Microsoft-Antispam-PRVS: <AM6PR08MB44055C78F3ADD62DCA48746DC10B0@AM6PR08MB4405.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TUAqksk5qSOfPfN6QufxGw0ug6y95r21WVY8OuByFDN8IPb4EXXh4A3KkwoIWWdFiNG4MH3T3Koag2yRm7Rm5UzWtLkk3P4ewbrkxGX2MfdSBRV+SjmvgfbXJNfOiAXSTwmVffRa0Z52mKHXyhUtNS0Xd9CA3MxbIcdfbHzD4B3wufZU/cIuFBdg89CcPPkoiOMzMR+FjLGjStS4YmccE0/LCwVlGGXVclZp+PU7Tw41ExOGN8Cqi+F+8NcZRQZDWFxjNB/PEie1OLUC55+kw6n1Q1MiBTjnThp+6j54NRG+xWNkSe3g36AADT6yLqUI+nzSjOilAL9MK50EDXNPO+SjyUlQv6tzaGbORIn0pZEQZ0qnlsFR14np81ie9d/g0q1/DrXktNWtgX7tSe7rzDXJckv08W7zBmD+n51bqL+qH01L9dScOacJfLQ/JJZSQNe8gw5l8IbJVfYGc3NNxvqIxmkNYR7YwbRh3zvKlp/2sO+iP5NMhnt62AhiD1C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(136003)(346002)(53546011)(16526019)(5660300002)(26005)(52116002)(186003)(2906002)(36756003)(8676002)(31686004)(4326008)(66476007)(66556008)(16576012)(966005)(8936002)(478600001)(316002)(31696002)(956004)(2616005)(83380400001)(6486002)(86362001)(83080400001)(66946007)(43740500002)(16193025007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S20BnhMvNfLy7qKgAlZqI1pMbp1pYbnS2i73gsp80BgHY8sZbZnDguGFNk7OnHXIVrz132wReaBTRuR/SjKnA2c4DHQknIQL4CJMZh99qAASywcptpizDKLMMCOLTDJOEVvcuDuEuqowkGk+6vsDSIn3+S4XRKChl3dCTISD4XdayrhtscZbX/nBsTgLuzaEpHQA2YiaK4AXGSjB93YFe5/UwEeGTSVKFk0MHhst2TMMjUvePcaT9YUF/9woIycXh9Mi8MMXVGrdYlPFkOv6T/MbZ0LNYClfj48C05JnUPSOmNz3I7jFQtOV0KNZnzsDPl77elJia3RKbHeD+KzORc9kc6DyRaG8RVKWIzijLTZ+xo4Wjj+K+o8lRFwR9JdROBxOunTKDDFtIrbApXCvh/Cqal2P/UE73sa+/XcakpWTmcNe7U1+XOA8RepEba6UvRT2gPlDnb5IoHQN5ugTsCFjIqG0ce14eq7wC7IsGeoHib4FKMVfB5K2C/T08hozueskGgfsZ4e2DfY6WFTRxQYiphTR3wb9/drlkQXf7W8p8dyM1PD/zkn9OeBubEPOqym6H9ChEWle6Y7vawjHeYpE7IcUoibPG5T/wfADHCbMkGXMd8IHens5zCZc/UmmYumQwpJaAMMTAfc9dG/Zrg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f5fe87-0c7a-461d-eb3f-08d86b640081
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 08:27:32.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9ylMxFLC0rkpJe9MEjUtJvgtIS7vc6AIPheAx9FbrWxU7941/DbjIixoR3u+AvJ4ocY2N48zeWVcrORxE8qxhbypbB6IT70iXociUwcQDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4405
Received-SPF: pass client-ip=40.107.2.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 04:27:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

08.10.2020 00:13, Eric Blake wrote:
> On 10/7/20 5:32 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 30.09.2020 15:11, Eric Blake wrote:
>>> Honoring just SIGTERM on Linux is too weak; we also want to handle
>>> other common signals, and do so even on BSD.  Why?  Because at least
>>> 'qemu-nbd -B bitmap' needs a chance to clean up the in-use bit on
>>> bitmaps when the server is shut down via a signal.
>>
>> Probably not bad to update a comment [*] if you have a good wording in
>> mind.
>>
>>>
>>> See also: http://bugzilla.redhat.com/1883608
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>>> ---
>>>    qemu-nbd.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>>> index bacb69b0898b..e7520261134f 100644
>>> --- a/qemu-nbd.c
>>> +++ b/qemu-nbd.c
>>> @@ -581,7 +581,7 @@ int main(int argc, char **argv)
>>>        const char *pid_file_name = NULL;
>>>        BlockExportOptions *export_opts;
>>>
>>> -#if HAVE_NBD_DEVICE
>>> +#ifdef CONFIG_POSIX
>>>        /* The client thread uses SIGTERM to interrupt the server.  A
>>> signal
>>>         * handler ensures that "qemu-nbd -v -c" exits with a nice
>>> status code.
>>
>> [*]
>>
> 
> Sure, I went with:
> 
> diff --git i/qemu-nbd.c w/qemu-nbd.c
> index e7520261134f..c731dda04ec0 100644
> --- i/qemu-nbd.c
> +++ w/qemu-nbd.c
> @@ -582,8 +582,9 @@ int main(int argc, char **argv)
>       BlockExportOptions *export_opts;
> 
>   #ifdef CONFIG_POSIX
> -    /* The client thread uses SIGTERM to interrupt the server.  A signal
> -     * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
> +    /*
> +     * Exit gracefully on various signals, which includes SIGTERM used
> +     * by 'qemu-nbd -v -c'.
>        */
>       struct sigaction sa_sigterm;
>       memset(&sa_sigterm, 0, sizeof(sa_sigterm));
> 

Thanks!

-- 
Best regards,
Vladimir

