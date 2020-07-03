Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E51C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3802120836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OXV3cesa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3802120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHmc-0004Zq-EH
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHfW-0006RT-Nt
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:07:38 -0400
Received: from mail-eopbgr10127.outbound.protection.outlook.com
 ([40.107.1.127]:3861 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHfT-00051B-97
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQdxl0VIXqdp/KwZZJNltmHs8RwkCvntv89qz9Qr1Ch6zJ+24kT54cEgPWDjZHSCHnOmzkXgsZr7ULDAUs90l0a0k/LzoZEFJ5JvayOBzDLT2GYYKp9RgJAYqmJeW3iVPv8/qZlsvwy3NPX2ZA+yd3srr3fU7psjEBmiwF4XJczwHeT175K2c/4VDXzpvGM4Ala9NdREVliKYHiGJ0jHay1p79gf4IqlEnEAmin/5p2QiBaTmP5ly9LGJ1l5FdvfIdVbtzF3DqXB6iEtl8fSzoKDvGK8YtVtXFeyAaG7HWzY3ptVHpsABx6nCrzNfjrUDCewPvQ8adBdt9/IRbRXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klt1CeyhRjNZnkIESAe9QrKs+8nA+yTs0ukPYZ/VXvs=;
 b=PZ2QV6UkLuSxDzYi1R1Do90klp75IDd8n2LNPL2zrX38R3/URMGo1PB7ug1qktp8hp74tWCvIJ7RKkEgsqnB6trEObKSdI7dHLly2bvsNmiOB91Wx+hZwx77BQzBvMK6jrDCnmd09KLoirePLoGawVQEk90/oUGSWZ1SwWJKsyDtu8o6PzRj3RuTytoik/eQXeF/688E66eAeIYPdHOOy6Y9oOiP10qkyt4Z9hv+oISNQ+fVa6+8a2N5dorvB1AnZhKux5YellBvFlmfnL4HSg2x1moZWx2kRZF6aMPuaubfUGkt0LFZ3W1eBzZV/Bar45zrNPdhklirWnarzquB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klt1CeyhRjNZnkIESAe9QrKs+8nA+yTs0ukPYZ/VXvs=;
 b=OXV3cesaMGqhUvcZUXcggQ6/GEuf8W9d2P4vmqpIRwHpXb51Q+JAaX/EMX98vKTjdTEKKCbHbtlkHZP8TaOxSSnZgXW4LMW+BqUOcrhWSBvhpuG+ODrdYjouM1thGGpi4H1ZFQiC8Q5K2TyL5svcZwY3nuEUMMphs6o3X1/WLlE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 09:07:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 09:07:32 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <87blo7heag.fsf@dusky.pond.sub.org> <87blndey9c.fsf@dusky.pond.sub.org>
 <3b9d53fd-bdd0-c15b-292c-c4952fa24dfd@virtuozzo.com>
 <923ceeeb-1fc8-489e-a32d-4cebfa6eadae@virtuozzo.com>
 <87y2ptstxm.fsf@dusky.pond.sub.org> <87d05dqc97.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <177ccdc5-9fcb-f9f7-3eb2-7241bf76fdff@virtuozzo.com>
Date: Fri, 3 Jul 2020 12:07:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87d05dqc97.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0501CA0043.eurprd05.prod.outlook.com
 (2603:10a6:200:68::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 AM4PR0501CA0043.eurprd05.prod.outlook.com (2603:10a6:200:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 09:07:31 +0000
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6990c207-01a2-4bc6-19e9-08d81f3084bd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54489FA05D578F41DCD63A37C16A0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPHFMa4akWzUA+kdv43DHl/gDYmXVi+VewA0iOyZG2BlpfwBSlNd/U9zi2z/1byRk06Rhod3wjIOPH7MYAFp3Mrq+l+p4A2BskOyjrVQbR5YgikDI3NRkcZE63wlmeOSYqCGrY1MtzKMhFWKJKrtpaOs7wuW8PVU3zvRPm6OmlVeRQZDSMBwsoLSPUjqg/6zExei80QjotFV6Rg77G/OkdlTrgzbwI8MWiq6jHI/jxRNgvictWJEBt870AL1DV5s8IMwHOzE9+ghH0SOXA6B/RT+LS2iW8i84srRRrEkGQyAW4VyS7c8G73pGcxOOdS5gbN+BzMPTKq1nx0yIEg0oFHLGHipM0JWORTmSPs4WDtbbVChWzFyBdTaTQRmZkh7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(66946007)(66476007)(66556008)(2906002)(86362001)(31696002)(8676002)(83380400001)(5660300002)(8936002)(186003)(36756003)(31686004)(4326008)(16526019)(6486002)(6916009)(26005)(16576012)(478600001)(956004)(52116002)(316002)(54906003)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: w/D06fJ7H7dT1mMIoUOeIlxVnYwUnbDjG2+hi/xEMGYE1a43kdwrE1tVMTGj/RqnEm9eWzVmyeVuy7q6NuX3e628h92FDYJb49KVy56MtH3iRk7Rw2oQUaPxGtchUMNaxJ8w7B+nA042SeGjYClvq51URcOmxqPMVty6IWav3fhcMKMbRMN9UZyxIkGwK0hdVTtW+mRbwpyhMTDLWp5Z9DfIdKE4t6O/Q6HToEj0fsz6vMxwY/6EeFzZWxMYMQw929w1zI2wcgi0fcOf42lmB7YGaFrv5/uDNkCMptZbh3ecADuKswTWCnKNTfqi2LBXZIKUasAnoG4cTYEf4F3W/n8ULfMIb3L3ErcF+i79kwsYpiHpdSXZN4JEDILI3HaPfj5N+J7B0uJ/s8m5xM9crYCa3TcOmXt0084Fmj7Fi6VjnuWf2YtY3CXNdpZRzFijwK9xZCjgL3QnEEoaRG7Hix8OIpMbTIib3Vg+SAu3UtI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6990c207-01a2-4bc6-19e9-08d81f3084bd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:07:32.0922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grgyy7oXBz+UKYcFdUJ7RLJ8hA+BryR8jsSduCm2A/uUarwzbsuKoiFZD8VtEXvNbgktHZaH6shr1zOCHDg5tPTmcyKphm1fKCGnXdpZwsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.1.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:07:33
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.07.2020 10:38, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> 28.04.2020 08:20, Vladimir Sementsov-Ogievskiy wrote:
>>>> 27.04.2020 18:36, Markus Armbruster wrote:
>>>>> FYI, I'm working on converting QemuOpts, QAPI visitors and QOM.  I keep
>>>>> running into bugs.  So far:
> [...]
>>>>> I got another one coming for QOM and qdev before I can post the
>>>>> conversion.
>>>>>
>>>>> Vladimir, since the conversion will mess with error_propagate(), I'd
>>>>> like to get it in before your auto-propagation work.
>>>>>
>>>>
>>>> OK, just let me know when to regenerate the series, it's not hard.
>>>>
>>>
>>> Hi! Is all that merged? Should I resend now?
>>
>> I ran into many bugs and fell into a few rabbit holes.  I'm busy
>> finishing and flushing the patches.
> 
> All merged except for the final series "[PATCH v2 00/44] Less clumsy
> error checking".  v2 has a lot of change within the series, but in
> aggregate it's really close to v1.  This makes be optimistic it can
> serve as a base for your auto-propagation work.  To get it into 5.1, we
> need a respin, a re-review, and a pull request.  Time is awfully short.
> Sorry for taking so long!  If you want to try, I can give it priority on
> my side.
> 

Of course let's try)


-- 
Best regards,
Vladimir

