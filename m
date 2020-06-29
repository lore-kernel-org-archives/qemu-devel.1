Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC88C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A5023750
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aVJ2PHUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A5023750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqdu-0001aT-F2
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqch-00008I-NT; Mon, 29 Jun 2020 06:02:47 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com
 ([40.107.5.110]:11302 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jpqcd-0004h0-M8; Mon, 29 Jun 2020 06:02:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4RCxuHrSEsDeaV0Nf+eUD/XX+YvhO0G3wRrD0IRnuIk1rj8pA4Ur511eTpPTIr2PL91uc35K9yzYaslVbYM1ztBxrPJ5f14krdfHa9mBGyPiVFoRoXSCA/MHreim8IPvrkvErHVGP9lFz2nDGS2maz6mWRospS8uzNWPg3M2YRMTBHvQcmHtFYH/3JBIc/BZDKaJO7ITc3OPigTumD3tyEyv1IFzkTDLfFb7VYzukFAw/O6GER88hbaEzTcuYTFhZzLvQmUzY8UC4KyoOY7viGCP7ZXRmzrqcT8IvdwXhP7wTX6wvKtOFibtUIDk50eIY02x/pN4XPcNK/vRLtH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUk6d1VBi+fjtJc7RYZAtd5Ri43xcSyWr0xFmRtIKH8=;
 b=kIGATKddkeoAmgULBCzNOsbho7mhXOQqcn6+Dwkaf0NMHYPi7UcBqdL8EGL6gLqLCC9Z7tVCa12UYORomMob+3trqT0K0uKGgW6kh5mNDhX/L3nu+OGhTSmLaZc0noD6FMG3xBPrJlczFlVWmDjQqiguxljSm7S8RGuOSAHrdDkBMVMh5okgeG/vwX5ro7L2Ds5VOP/WnZGFk54WkA7Oe9FPRzd/jkpNS24oyT2+DQYKNtIlmBZ42P3qi2RRK9uIG7lzxwnNnIV1IMuYckFOSbjP1IPRkU2b5UnvX/L5aiHiDq3Exw3jxEMNaRk+ozmKWVVtozVFkRDt4jKkPK/Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUk6d1VBi+fjtJc7RYZAtd5Ri43xcSyWr0xFmRtIKH8=;
 b=aVJ2PHUhE82+UvZn4llwsaPR5AjuHMB2pvMQIeKvBLwVVEs/PgN6usssraohY2Uo7zuktk4QFKLl9WTs6P/aBo6Onsc566aY09Nc6yd1a3WZjE+eXxVIOei8gGZUv5DUnXwk40yoOLB/M4mqsxjTAizGRmQpgLXDvJGn0OcCNXg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1907.eurprd08.prod.outlook.com (2603:10a6:203:4a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 10:02:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 10:02:39 +0000
Subject: Re: [PATCH 13/46] qemu-option: Simplify around find_default_by_name()
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-14-armbru@redhat.com>
 <13665429-b6ae-351b-0b96-7810da94f0db@redhat.com>
 <87k0zvz3v6.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b75208ce-e2dc-fce3-783f-47eab8e8bfca@virtuozzo.com>
Date: Mon, 29 Jun 2020 13:02:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <87k0zvz3v6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0099.eurprd07.prod.outlook.com
 (2603:10a6:207:6::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM3PR07CA0099.eurprd07.prod.outlook.com (2603:10a6:207:6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.10 via Frontend Transport; Mon, 29 Jun 2020 10:02:38 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b4b4dc-7daa-4ff3-8302-08d81c138e7a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1907:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1907287CA5EF8145011DDCFCC16E0@AM5PR0801MB1907.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrCy/B3uc4NjivfzSZ7Ukmg5PUIaqZhtpBsyCxy2v5DG+waE4yzWG0g2hPXTZdv405n2Ib9jM0BYlXyTKyPQ+DSwfYCikhRxo+xwIBigQdL66wzIt6cUd8O7nogj2k/41pOHSFu84JMewOhA7Xi+vuBfej14krUQTS8OFkJ0osE1GS+9uF4G5vdhkxIGYEselIHYJAmupspVdDc/nkYI685eEn8tNu7uWjaBNEKmq0yWGxY/OkVkHeEJWjBg4DSChVWcgBtKVm+ufK2H99CBfi0Uc3eITilOotHN20zjQI/dj5Q9R+TsMiHaHBrW3UCsdaUNoOqYQecmt5Cl0Zxq6yfyCCy5J5vNV6UkXMtMSEK6x/06svqbTMcaWv6hPcwl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39840400004)(366004)(376002)(346002)(4326008)(2906002)(8676002)(110136005)(31696002)(5660300002)(8936002)(16576012)(316002)(83380400001)(478600001)(31686004)(52116002)(86362001)(16526019)(2616005)(186003)(956004)(53546011)(26005)(36756003)(66556008)(66476007)(6486002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: l8SqANcGGosoEIgDeEwrEkqlEAO4O+GSPwwv52WFN3dXTWdW+EZ74wNlyYzRwLoO3FOnCUe2h1ofXTEMHzcYRqWPY63IsJ99WdS7jPWdqXNy/cobE7gjKUC4s23vH0QdOpg7/4Dl0M43AxXZ77zsRPnnBuBx67aYj41uREeAI7QSzSBvRyg3gWeRFXexcvEEgNkWf/WXNCoe4gfN3yZc2FUn7d6l8tE+y4xPbM3L/wNQNhBcfr6euNH3aWx69kZ1XjZyjhHkq+FV04xHaNSNbcdK8sQ7Oyb3SUDhWggfMWjk6V4Bwe5C3bvSYuWLXC0DiUNHURXVBvW0Phk7zH+S8WEBrKlO6UTsTCxzQgP6ssjMJd6fQbBOpCHPRcIroQFbsp8yZVv00E3PYXRu12w68/bisEWQkb4qDXf71fIiHhnpA31i3LaG2Z5TVITqJOlOVBOfTPdDKNLJv1UTzf1vkVK1yOwHC/41K/KovBeIS7A=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b4b4dc-7daa-4ff3-8302-08d81c138e7a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 10:02:39.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bn/wI5Y0nyuQFK9PmqJXzjAw7PlRuf3QQoevYtCzJoAjEzFea4s3YscGTfWqzrbu6ex+DR8JxySLCPFjH3IpAgrpn0V6kWsiifVxdCmgrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1907
Received-SPF: pass client-ip=40.107.5.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 06:02:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

25.06.2020 16:12, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 6/24/20 11:43 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    util/qemu-option.c | 13 ++++---------
>>>    1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/util/qemu-option.c b/util/qemu-option.c
>>> index ddcf3072c5..d9293814b4 100644
>>> --- a/util/qemu-option.c
>>> +++ b/util/qemu-option.c
>>> @@ -286,11 +286,9 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
>>>        opt = qemu_opt_find(opts, name);
>>>        if (!opt) {
>>>            def_val = find_default_by_name(opts, name);
>>> -        if (def_val) {
>>> -            return def_val;
>>> -        }
>>> +        return def_val;
>>>        }
>>> -    return opt ? opt->str : NULL;
>>> +    return opt->str;
>>>    }
>>
>> You could go with even fewer lines and variables by inverting the logic:
>>
>> if (opt) {
>>      return opt->str;
>> }
>> return find_default_by_name(opts, name);
> 
> Yes, that's better.
> 
>>>      void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts,
>>> const char *name)
>>> @@ -320,7 +318,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>>>    {
>>>        QemuOpt *opt;
>>>        const char *def_val;
>>> -    char *str = NULL;
>>> +    char *str;
>>>          if (opts == NULL) {
>>>            return NULL;
>>> @@ -329,10 +327,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>>>        opt = qemu_opt_find(opts, name);
>>>        if (!opt) {
>>>            def_val = find_default_by_name(opts, name);
>>> -        if (def_val) {
>>> -            str = g_strdup(def_val);
>>> -        }
>>> -        return str;
>>> +        return g_strdup(def_val);
>>
>> Similarly, you could drop def_val with:
>>   return g_strdup(find_default_by_name(opts, name));
> 
> Your contracted version is still readable; sold.
> 
>> Either way,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

with suggested improvements:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir

