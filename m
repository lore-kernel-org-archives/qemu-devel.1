Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F9C433E3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0725A20672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FZuSUPWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0725A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSG5-0004fZ-4A
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtSFD-0004E5-W6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:49:28 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com
 ([40.107.7.90]:49574 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jtSF8-0002ZN-Pp
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsJV4EuZ4EpCvnTsraM3vt5HAJ5mPNAR+Xg0O9bi/fi8mIsahwaZW/kdKSTtUAk60vsCnMUfx0XMtbeJLetGj3owE2aCbXy+ZhsUG/dmP7dnZH5MXRybLcOZrOvadvJ5Z409WNrbNxejIYVZpL+kw5lPbvwnT7Lql3RigbHHtLJYd+1VSmKNT8J3AuVWTmW0iWhWEE7/VS7UoWpxGmD3NkcyizRggtq9XchUFhrJNuxDC5SZMbov3J2C/vkc5IUfaXRH+lWKh4egArqepcLu1pEMY8BpFKI0u5Qa6uuxbLRoUXNIG29xiCSeEcyyOITu3q+FBV2DPs5hde36xi7sJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B90SG+UA2wcOUsmJmg/GJRfp3HjGB/iEVmNeVANXlY=;
 b=dAYdUV1WRxNwIMRUDdfpNLEGBygE4eT86vjFyeEXmaNMsSLrllbKhaKTwKjSKk0zsBPoLtNaHCitxl6qOBlekLJIDb1m43FsFZYYoFpCplSxCzIbhnG4g9IpyeXNwBy+QcvmgdXGZZzgbUbt0YnBW5noCyLKBFQI7Y/4umcnr7s2GnrqBDVqWHR0XpEiJlvBM3A9QVyuT2Jp4qrWU0dsKHNzB8TwS3LMnFO8RGdIQTouhrpH2Tn2xsd8Z0Yd6vcpH9HIJOQvIMwwGYJCh6oqfGBeXqy3hBIFthZpQhrwVhspGszbReEzG6sISxr6wUz3h0hboOFstiyWseyUWGD4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B90SG+UA2wcOUsmJmg/GJRfp3HjGB/iEVmNeVANXlY=;
 b=FZuSUPWwMEj8aXA5wL+II3Z7abihspLT9i9gFE33nGVAXkbPrwUnbNtcj1K30nWCOrsVcV+X3NjJQUhEeMGHHl9YCVS+jJPM0IduQaxvsu9kiJXHAtibRItyT8qx+HU/pz5WHtnknHBNr89knqpxer/TSbMq9UhNyKwW7TKriL0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4597.eurprd08.prod.outlook.com (2603:10a6:20b:90::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 08:49:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 08:49:19 +0000
Subject: Re: [PATCH 2/2] util/qemu-sockets: make keep-alive enabled by default
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200708191540.28455-1-vsementsov@virtuozzo.com>
 <20200708191540.28455-3-vsementsov@virtuozzo.com>
 <20200709082954.GD3753300@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <62e64c31-1f6b-f27e-82ca-dfb3085a9869@virtuozzo.com>
Date: Thu, 9 Jul 2020 11:49:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200709082954.GD3753300@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0112.eurprd04.prod.outlook.com
 (2603:10a6:208:55::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.13) by
 AM0PR04CA0112.eurprd04.prod.outlook.com (2603:10a6:208:55::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Thu, 9 Jul 2020 08:49:18 +0000
X-Originating-IP: [185.215.60.13]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c785ee-53d5-4059-6b91-08d823e4f792
X-MS-TrafficTypeDiagnostic: AM6PR08MB4597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4597803ADE91C9AEDBCD0191C1640@AM6PR08MB4597.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LDYJ6PeMepOijyenH8nIA76Y9klALx1SaJ6vN+MWCyKLK28DXN1T7J2reb2ytXMnenUixVOsmokXsjPRfYqTXHj2z/6Yy4KqEhnEjDQtvYWuQ0amk2JyYUuGmEYImMHI5ltNLDZIO2btd+GPNARx/5Hp+S7R7S4RvwNSXO3gVlJccOo24nkCtFEEnpo4zBY5sFQqaMEP6F4HjHO3+S7uVfNyfGtkPseg1QgLXwyDNGfSkfm9bQlBSQBlj4eH6dGXdJlVh/FgumHubuN/STonDcqoNgwU3fiiHILhBWJfN86hVAEhVakToFxn2lNKp6oqVOjy2rSOdql4M7iOix0m+oB5EJnhJfYkhPm1kokklAyeoKLrwex8L4IagkDpoKm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39850400004)(366004)(31686004)(6486002)(6916009)(26005)(2616005)(956004)(4326008)(83380400001)(16576012)(66476007)(8936002)(52116002)(36756003)(107886003)(86362001)(66556008)(186003)(31696002)(316002)(16526019)(5660300002)(2906002)(478600001)(66946007)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: opl7tGauy43LuSKScVbzSHjn5AApVIqbvVBQklMpMa6eB8la4rAiY43IFqUKYcX0EjciJW8Kl4qwAO2/TL1aHfY2UMwvopWI/6xW7fff/sDLBvZZsQ7FLcRHpy1Yahm32p17HD/YMx6Z87jL45msphs5w8AEpLsViTrJnpky6f/Fgb+5TjxxXplnNseL2EBGJdDCqJHmdnHiUvugt2iVJTI+iAURrIrxeOZ6FPOf7yoMIkjIKVlyCZpEGk36pGduYmrEyF/JqPgP+kNSfdoehpvjc6VH6vr36a52L6SeYZ6IP0A+bNMVr554HvPKQ1PvMFUx3hgumBqk30jfi8DAwxw+jCTl2uE7zU5dczIRPpYpcFp5NXD6I2yO2T3IeJdr0tI4njphKqT5LEInb1Hi0It7yozmcfSyw9pKio8BGCv0mwUgD9Hib1dG9NovencEzDESTe3Fiy6IPYNn9rZBPq51PYHPlKBcqpOjA85jvpA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c785ee-53d5-4059-6b91-08d823e4f792
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 08:49:18.8966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHz5T0c4iM50sVmWOya0L2q3gy8atI7oecCwYciM6P8AQgQiFMP0L5DWisRFq4sgxYoZJl/y2QZVgDDY/J2oDFkvrFAEtIGJnvGtUDs+n24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4597
Received-SPF: pass client-ip=40.107.7.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 02:51:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: den@openvz.org, kraxel@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.07.2020 11:29, Daniel P. Berrangé wrote:
> On Wed, Jul 08, 2020 at 10:15:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Keep-alive won't hurt, let's try to enable it even if not requested by
>> user.
> 
> Keep-alive intentionally breaks TCP connections earlier than normal
> in face of transient networking problems.
> 
> The question is more about which type of pain is more desirable. A
> stall in the network connection (for a potentially very long time),
> or an intentionally broken socket.
> 
> I'm not at all convinced it is a good idea to intentionally break
> /all/ QEMU sockets in the face of transient problems, even if the
> problems last for 2 hours or more.
> 
> I could see keep-alives being ok on some QEMU socket. For example
> VNC/SPICE clients, as there is no downside to proactively culling
> them as they can trivially reconnect. Migration too is quite
> reasonable to use keep alives, as you generally want migration to
> run to completion in a short amount of time, and aborting migration
> needs to be safe no matter what.
> 
> Breaking chardevs or block devices or network devices that use
> QEMU sockets though will be disruptive. The only solution once
> those backends have a dead socket is going to be to kill QEMU
> and cold-boot the VM again.
> 

Reasonable, thanks for explanation.

We are mostly interested in keep-alive for migration and NBD connections.
(NBD driver has ability to reconnect). What do you think about setting
keep-alive (with some KEEPIDLE smaller than 2 hours) by default for
migration and NBD (at least when NBD reconnect is enabled), would it be
valid?

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   util/qemu-sockets.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
>> index b961963472..f6851376f5 100644
>> --- a/util/qemu-sockets.c
>> +++ b/util/qemu-sockets.c
>> @@ -438,7 +438,8 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
>>    *
>>    * Handle keep_alive settings. If user specified settings explicitly, fail if
>>    * can't set the settings. If user just enabled keep-alive, not specifying the
>> - * settings, try to set defaults but ignore failures.
>> + * settings, try to set defaults but ignore failures. If keep-alive option is
>> + * not specified, try to set it but ignore failures.
>>    */
>>   static int inet_set_keepalive(int sock, bool has_keep_alive,
>>                                 KeepAliveField *keep_alive, Error **errp)
>> @@ -447,8 +448,8 @@ static int inet_set_keepalive(int sock, bool has_keep_alive,
>>       int val;
>>       bool has_settings = has_keep_alive &&  keep_alive->type == QTYPE_QDICT;
>>   
>> -    if (!has_keep_alive || (keep_alive->type == QTYPE_QBOOL &&
>> -                            !keep_alive->u.enabled))
>> +    if (has_keep_alive &&
>> +        keep_alive->type == QTYPE_QBOOL && !keep_alive->u.enabled)
>>       {
>>           return 0;
>>       }
>> @@ -456,8 +457,12 @@ static int inet_set_keepalive(int sock, bool has_keep_alive,
>>       val = 1;
>>       ret = qemu_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE, &val, sizeof(val));
>>       if (ret < 0) {
>> -        error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
>> -        return -1;
>> +        if (has_keep_alive) {
>> +            error_setg_errno(errp, errno, "Unable to set KEEPALIVE");
>> +            return -1;
>> +        } else {
>> +            return 0;
>> +        }
>>       }
>>   
>>       val = has_settings ? keep_alive->u.settings.idle : 30;
>> -- 
>> 2.21.0
>>
> 
> Regards,
> Daniel
> 


-- 
Best regards,
Vladimir

