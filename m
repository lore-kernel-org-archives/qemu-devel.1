Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D2FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46CF20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oDEKXXQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46CF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQM3-0007y7-2x
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joQL1-0007T3-5t; Thu, 25 Jun 2020 07:46:39 -0400
Received: from mail-eopbgr60100.outbound.protection.outlook.com
 ([40.107.6.100]:29922 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joQKy-0004NW-FX; Thu, 25 Jun 2020 07:46:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxA1RRywyZS22+OoOe1KxeNPDt9uHaVkouUCujKggVv/X0UYotwpRevYEQVQR5Pi0ictBKQKD3rXNJmCZTLEjkVeHkZXauou6l89Xd4HB8lPSZsehvoDgvaate8TZ0VAwijwgfQZJpgxvrWDS/xgc0NjNWytP9LmYMorJZ+9kSSz5AizP97l/4Vu5016rPaMlkFBOtamaDzxe9w+ejYDcGKGlQmJZqLm8xBbyE0zwFR5lCkx6SKkVJ9NKvidPrPSCxFF8l4EDx76DHx1YwX+FkgxWsne0TATYZZlmu99q6Cc3Z7DVVHwrK7d+8G7gKLdiZgsnfBKdADdAvxztxzyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZD2wlilGrctyH/6AZw+SGcIWtejAVATDouS4hjzSYQ=;
 b=lnuPne0+zL4BzOqpnbc362kRQDMWeJYRqJkLtf+KJBVZhsbYeREn1rHigZGEgSHfScBKSi6lHHtxn2NZhI66ijZstIdtEdw852r8X7lM5dJwJtOzghiuC6Jh3VQkg5IO395YPAd24UmzoNz8sL1xncpDem41i/moZFOimJwN+gA+saijbO7GegpIwwLNYrS5QYWr6ZLrHTz418OYQQ8zYF3MdHQDEnFnVyeDY8CjZVXC8WFP4Rn9HthcZqHLGrDxTm1g0EZNC1+sS0HWZg+YD6vDEyCQbO1Cmx4heqDxjBv6aDSUYt/uW6LobYXzeJNNgaAEEvPhB+Po1huUCX8L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZD2wlilGrctyH/6AZw+SGcIWtejAVATDouS4hjzSYQ=;
 b=oDEKXXQmwUnw6fxkkXrQLxUrl3W6hjIfnfGFGUccBatDI4WVb2NU3t8XpHIPL/sGwM9WPRHj86tQ3sLXKF+//btEZHhLUK9PVTH5ZTY9BLV06nQsPAR8UiqzBcgIeuhOe1v9FNv9e+5pOKxmnSnotmPvs6pyqPdVhJCTIU1eZe8=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4691.eurprd08.prod.outlook.com (2603:10a6:20b:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 25 Jun
 2020 11:46:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 11:46:33 +0000
Subject: Re: [PATCH 02/46] error: Document Error API usage rules
To: Markus Armbruster <armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-3-armbru@redhat.com>
 <db1af786-075d-b656-b280-d25ad34bbbe6@virtuozzo.com>
 <87v9jf2xuz.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <37dcb862-8c2e-5b98-23b2-302dc622c3ff@virtuozzo.com>
Date: Thu, 25 Jun 2020 14:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <87v9jf2xuz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:208:122::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.69) by
 AM0PR04CA0017.eurprd04.prod.outlook.com (2603:10a6:208:122::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 11:46:32 +0000
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6990589a-7de9-4225-5582-08d818fd6850
X-MS-TrafficTypeDiagnostic: AM6PR08MB4691:
X-Microsoft-Antispam-PRVS: <AM6PR08MB469156D0A0A9DDA020704830C1920@AM6PR08MB4691.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zdWrlJH4VngdN5C+COdySELUkQNCoLeGCSENfpsf9N36zDuk/EnQnWl8YM/Vx+idYnpcUrD05L88sC5Q37KUKBVk0KjTh5/CO0YEGqr5R92eOpRTkZCR288sdy/K7oo7T51uf5rgYz5c+HxBougWmV4OIeoKJwQZHEw/0upRd8hgNYDWgzEECLsTcSA7yRH/eX9qX6U73mJeOvJbaRr22tuPBtsybZeExmMiYFe071l+zntlKa/rAvYpkAv1mxQeRGr9SyqciONcJDmmq1U2pt2b9O9h2Yi718ajCF8+KE26DHTxfWbw7PJFI3iq+ZQaOce3fn0FSyewCVRIsSE18TXh9OrWG4mY+YyTgWW0lpePOkiKbFC74mxvyd5UK/c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39840400004)(136003)(316002)(26005)(186003)(478600001)(36756003)(31686004)(8676002)(2906002)(8936002)(956004)(66556008)(66946007)(83380400001)(6916009)(16576012)(2616005)(16526019)(66476007)(31696002)(52116002)(86362001)(6486002)(5660300002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KRHif+Lx31c/4qg5FC2eKV/ed2IwdOD6yI1U44ndnNBgSOttz7e5Cm2D2ytes/sADctzuJFkLB8rS/YA5nCASU6SYMpKiQuqft+FfQxmkuXoTD4Fpexw7TUXC+VYqJGw7Y7ptLLsOi8HMi5EM5j8MNa28qCuYtmMOabzSu02q2FX7ntEsk8Ln+0aoYDsJGKBJyOmM5ezZnEcMRTOAtjJJrc+llm11BSVbKCS5UcWX8j+isw0VoFtKYIVRM0AV2aYSJDe4BGoLRBPRmX1I54MXojpavfrXZcWr7RYMFsqhsUiU363CfZ3EWL0XaUMkvFQ1+e8bLfxgX//4BHudfK6wMJq+8m3XOq/8hz5B/aX2p3s3NXy0hr/GC4vCCYOv7+s+NuAYkmQibpEAjV8mwtlByOvH31JlfNbXzS0nHKfgzkCD/MGC1Z9SkSodNN+9aan2t1qhmIO/TUNxO4jp1bF3E8X12HVmUwmB8UDJYL5Blg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6990589a-7de9-4225-5582-08d818fd6850
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 11:46:33.0804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahjbsjyW7M6Q9EWdiXtaVfS+Oae+PzdKaaV25BXHM1TymrNMUFyalJ0+2cmfU60KFXJDYGnsiK54w9JaZ5FlsifmlwHeSycLnZ1P888FQHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
Received-SPF: pass client-ip=40.107.6.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 07:46:33
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.06.2020 14:23, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 24.06.2020 19:43, Markus Armbruster wrote:
>>> This merely codifies existing practice, with one exception: the rule
>>> advising against returning void, where existing practice is mixed.
>>>
>>> When the Error API was created, we adopted the (unwritten) rule to
>>> return void when the function returns no useful value on success,
>>> unlike GError, which recommends to return true on success and false on
>>> error then.
>>>
>>> When a function returns a distinct error value, say false, a checked
>>> call that passes the error up looks like
>>>
>>>       if (!frobnicate(..., errp)) {
>>>           handle the error...
>>>       }
>>>
>>> When it returns void, we need
>>>
>>>       Error *err = NULL;
>>>
>>>       frobnicate(..., &err);
>>>       if (err) {
>>>           handle the error...
>>>           error_propagate(errp, err);
>>>       }
>>>
>>> Not only is this more verbose, it also creates an Error object even
>>> when @errp is null, &error_abort or &error_fatal.
>>>
>>> People got tired of the additional boilerplate, and started to ignore
>>> the unwritten rule.  The result is confusion among developers about
>>> the preferred usage.
>>>
>>> The written rule will hopefully reduce the confusion.
>>>
>>> The remainder of this series will update a substantial amount of code
>>> to honor the rule.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    include/qapi/error.h | 26 ++++++++++++++++++++++++++
>>>    1 file changed, 26 insertions(+)
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index 1a5ea25e12..c3d84d610a 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -15,6 +15,32 @@
>>>    /*
>>>     * Error reporting system loosely patterned after Glib's GError.
>>>     *
>>> + * Rules:
>>> + *
>>> + * - Functions that use Error to report errors have an Error **errp
>>> + *   parameter.  It should be the last parameter, except for functions
>>> + *   taking variable arguments.
>>> + *
>>> + * - You may pass NULL to not receive the error, &error_abort to abort
>>> + *   on error, &error_fatal to exit(1) on error, or a pointer to a
>>> + *   variable containing NULL to receive the error.
>>> + *
>>> + * - The value of @errp should not affect control flow.
>>
>> What do you mean? Incoming state of errp, or *errp after some call of another
>> function? Should we then update this paragraph, when introduce
>> ERRP_AUTO_PROPAGATE?
> 
> The argument value passed for parameter @errp.
> 
> What I'm trying to express is that the function should remain oblivious
> of how the caller handles errors.  Do not check whether the argument is
> NULL, &error_abort, &error_fatal, or any other value.  It's best to
> treat @errp as write-only.
> 
> I'm trying to strike a balance between clarity and brevity, without
> overspecifying what the function may do.  I tend to err on the side of
> brevity in function contracts.  I always hope reviewers will flag my
> errors :)  In short, I'm open to better ideas.
> 
> GLib documentation, for comparison:
> 
>      If NULL is passed for the GError** argument, then errors should not
>      be returned to the caller, but your function should still abort and
>      return if an error occurs. That is, control flow should not be
>      affected by whether the caller wants to get a GError.
> 

Ah, OK. I'm about the fact that ERRP_AUTO_PROPAGATE exactly do some things based on
the value of errp. Still it's not about general function code-flow, but special
error-reporting related magic. (as well as error_setg will rely on errp value too,
but it's not related to actual function code-flow).

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>>
>>> + *
>>> + * - On success, the function should not use @errp.  On failure, it
>>> + *   should set a new error, e.g. with error_setg(errp, ...), or
>>> + *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>> + *
>>> + * - Whenever practical, also return a value that indicates success /
>>> + *   failure.  This can make the error checking more concise, and can
>>> + *   avoid useless error object creation and destruction.  Note that
>>> + *   we still have many functions returning void.  We recommend
>>> + *   • bool-valued functions return true on success / false on failure,
>>> + *   • pointer-valued functions return non-null / null pointer, and
>>> + *   • integer-valued functions return non-negative / negative.
>>> + *
>>> + * How to:
>>> + *
>>>     * Create an error:
>>>     *     error_setg(errp, "situation normal, all fouled up");
>>>     *
>>>
> 


-- 
Best regards,
Vladimir

