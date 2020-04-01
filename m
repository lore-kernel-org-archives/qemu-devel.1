Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFEEC10F26
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278A4206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="r42zthdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278A4206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcD3-00018L-BR
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcCD-0008Gu-FC
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJcCB-00085b-38
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:10:12 -0400
Received: from mail-vi1eur05on2093.outbound.protection.outlook.com
 ([40.107.21.93]:35937 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJcCA-00083U-9x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:10:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxbyD1XgGoLIrH3na4nP3hkdPPhu9H3IU5yVLkl49Ye/ScPqG55Qncdua8DoFRKPdju2edeZkNqEFchNwZBruqLmsKJLS2cbPQO7bzBCEzHoxOF17sOKffdD98eh+i6tQYChRDSLV8xS6c3kp6KuHWf2jdmXZBsfvRztPzocReBVnm6fCSfqF74yb1EJ83O36TEtiI18O9ynDNFJWzkk4jbeZ3WnxW8LpvB7mFsWrD3Pbe2hB28KvoqLxeLx/7pGRz5MGTNd6maIqVk/8v5Cm3SovoDVjdzht/oxBCS7fxObsb/ifUYUAxOhyYkKFyHPEQstmSvT3hplPV2Crc/MoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq63JKGAiXBfQtkwUhL7EsVPyReT6+D2gDPPB9pb/ew=;
 b=BJaMdxfOvT/QjVjGL0eDneZx1oMiGfiGIdLO4OsplHgPCRHebJmkfZ/OKBNhnMkb7imsbEICaDUZuxawjppGzJO6GmJVhgqlSaJ9Ka6Wbji1UabFQjY2KUgtCskf3MXHS6NwTyX0jb1cTN9sNHOBKvomdrt//n2VJAtJV09OAEwEHrw9Cja8EYWKFw8VFEs6kYvxHQERxhBbYS+dDO0YV3kz7m2TDX1NlilBO1/V3RqP/hJ6JhRm1Ae7wUlP5HzsBVeNKGXlXvT5UFOT+97AMvU2CjwyJqzJA4YxyPUI3DAacF+pHUvnf1qF02saV/jvPcOei4ug19/SNp28ivodKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq63JKGAiXBfQtkwUhL7EsVPyReT6+D2gDPPB9pb/ew=;
 b=r42zthdrm085XoZv/KUxv0AECy10HzfYhhqLMtnh3q1MUqkZFznZuxwT8X8g6OHAYSoI4jjk00XuN4a/A2iNdPzvNhvGlsqJtcqkNeIKZ0O8AmqNSUuPa1rAOtNd0wHlm4X72Tp2xYR5Uv4Pw+pIOfbFVKi2JKeLzBotYyEaNlQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5478.eurprd08.prod.outlook.com (10.141.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Wed, 1 Apr 2020 12:10:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 12:10:07 +0000
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87o8sblgto.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401151005436
Message-ID: <e980477d-3951-2a2b-fa38-dee8e1895019@virtuozzo.com>
Date: Wed, 1 Apr 2020 15:10:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87o8sblgto.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::47) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 AM0PR01CA0034.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Wed, 1 Apr 2020 12:10:06 +0000
X-Tagtoolbar-Keys: D20200401151005436
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99685caa-3ff9-4656-2dcd-08d7d6359df0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-Microsoft-Antispam-PRVS: <AM7PR08MB547892D509990B38E40A3ACFC1C90@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(316002)(478600001)(66946007)(2906002)(186003)(66556008)(36756003)(6486002)(31686004)(16526019)(52116002)(81166006)(81156014)(5660300002)(26005)(66476007)(16576012)(8676002)(86362001)(8936002)(31696002)(4326008)(2616005)(956004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csM8hpa0N8srAp094K8KuZS/pvB4iHP/PC/YIGClo1GRaGIvS1D/wg3WQEqhveQQo6dsysSrx9JXJ9Im6fDPSFfORjhvekVWIrSeX2pwlYU7q/4XzHlqE2is1GB6RYSKXiaqZC1HooEQlQpaPQN/Zdwk1O4lL3bOS+pkTAJPHGDWi0xJzSMhlgAUbl57Dh8NSzGxj0nXNSuM4sJL/mDebno2iRrR9jC70XUbVfbm4FvbMtFZMKfzkiyfX1BcDk5TN+YD3QXAPLVAsb7S5jF83oEWx5Gy9WUGC3r6wCQiAtYnGe6q2dejSQjD9+VDzcO5AFfVJLFpZkStmzCOxxAixGmNsVC2WieBoy99KXlUqD4WxvubelgCS/Qwv7Dfgct1i5d0VFmWJ0kRxC0u289yAxAQtxnojbGg27l1XchJQYPQIybktdl8ifvGzskemAbN
X-MS-Exchange-AntiSpam-MessageData: t/UX0J5lhNSFkRKuhRPN41ZX6/QsjEyYR0M3SMGTZz/51EucmOqMwNPq8CSOsFyaN+KjOSQgWhQF/GfMCD+ehKuWk9zD6A3wwoD/My2UKKOD8ocgH9Gtd+HB7L7vCZ8MzPgxWiJ1GE4f/oJLmz4Zqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99685caa-3ff9-4656-2dcd-08d7d6359df0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:10:06.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnzFNGx/NtBUP+z97zaMr7RoO99Ksu+RUQVUYiOR474PTBETihrbkUd9PrwSPgpOxanv13sHmxvUqvbh9nvezBNcAOGNISwrR65vXXXtPew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.93
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.04.2020 12:02, Markus Armbruster wrote:
> QEMU's Error was patterned after GLib's GError.  Differences include:
> 
> * &error_fatal, &error_abort for convenience
> 
> * Error can optionally store hints
> 
> * Pointlessly different names: error_prepend() vs. g_error_prefix() and
>    so forth *shrug*
> 
> * Propagating errors
> 
>    Thanks to Vladimir, we'll soon have "auto propagation", which is less
>    verbose and less error-prone.
> 
> * Accumulating errors
> 
>    error_propagate() permits it, g_propagate_error() does not[*].
> 
>    I believe this feature is used rarely.  Perhaps we'd be better off
>    without it.  The problem is identifying its uses.  If I remember
>    correctly, Vladimir struggled with that for his "auto propagation"
>    work.
> 
>    Perhaps "auto propagation" will reduce the number of manual
>    error_propagate() to the point where we can identify accumulations.
>    Removing the feature would become feasible then.
> 
> * Distinguishing different errors
> 
>    Where Error has ErrorClass, GError has Gquark domain, gint code.  Use
>    of ErrorClass other than ERROR_CLASS_GENERIC_ERROR is strongly
>    discouraged.  When we need callers to distinguish errors, we return
>    suitable error codes separately.
> 
> * Return value conventions
> 
>    Common: non-void functions return a distinct error value on failure
>    when such a value can be defined.  Patterns:
> 
>    - Functions returning non-null pointers on success return null pointer
>      on failure.
> 
>    - Functions returning non-negative integers on success return a
>      negative error code on failure.
> 
>    Different: GLib discourages void functions, because these lead to
>    awkward error checking code.  We have tons of them, and tons of
>    awkward error checking code:
> 
>      Error *err = NULL;
>      frobnicate(arg, &err);
>      if (err) {
>          ... recover ...
>          error_propagate(errp, err);
>      }
> 
>    instead of
> 
>      if (!frobnicate(arg, errp))
>          ... recover ...
>      }
> 
>    Can also lead to pointless creation of Error objects.
> 
>    I consider this a design mistake.  Can we still fix it?  We have more
>    than 2000 void functions taking an Error ** parameter...
> 
>    Transforming code that receives and checks for errors with Coccinelle
>    shouldn't be hard.  Transforming code that returns errors seems more
>    difficult.  We need to transform explicit and implicit return to
>    either return true or return false, depending on what we did to the
>    @errp parameter on the way to the return.  Hmm.
> 
> 
> [*] According to documentation; the code merely calls g_warning() then,
> in typical GLib fashion.
> 


Side question:

Can we somehow implement a possibility to reliably identify file and line number
where error is set by error message?

It's where debug of error-bugs always starts: try to imagine which parts of the error
message are "%s", and how to grep for it in the code, keeping in mind also,
that error massage may be split into several lines..

Put file:line into each error? Seems too noisy for users.. A lot of errors are not
bugs: use do something wrong and see the error, and understands what he is doing
wrong.. It's not usual practice to print file:line into each message for user.


But what if we do some kind of mapping file:line <-> error code, so user will see
something like:


    Error 12345: Device drive-scsi0-0-0-0 is not found

....

Hmm, maybe, just add one more argument to error_setg:

error_setg(errp, 12345, "Device %s is not found", device_name);

- it's enough grep-able.


-- 
Best regards,
Vladimir

