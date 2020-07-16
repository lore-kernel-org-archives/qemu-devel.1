Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FECC433E6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4972064B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KLkM2AkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4972064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6Cf-0005aP-So
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw6Bi-000540-6n; Thu, 16 Jul 2020 11:52:46 -0400
Received: from mail-eopbgr40115.outbound.protection.outlook.com
 ([40.107.4.115]:7431 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw6Be-00021I-FD; Thu, 16 Jul 2020 11:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwIdQUvbZMYrOKWxH9We/JqFwu9gCljs7+mkoEQ45s5dWA6N4fHKAJSCn2xC/sEK5Jo8C9Z1gGTpIP6At8DFwmBsLWP5E4sIWdJIg3eYXzMMMag2i+K5w8RInzBmN91hyrRDs7ZuGAKOjR2QHRq2fEcLbRDO7oGi4yiZbkxGFDB53f10HP2T+NBcuLwodVVjP7ulhBi+Fs4yEdWzKufTiCyM7WZhBGRkDzkMHbcDaZ4dwMJKu2lsP40sDWsX+mjjVJ8Zl2NpzxU267kc2WPi0sfftX1HKoBU4bjBhwHpn2eXSYzlmXj5KT3U0bNVP4dUUV7B9RqrLvELPc9k+s/k3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIHZKydONpDmkro9D8DdtZ6NVMQNPWnLdXcy3QpdW1w=;
 b=Q8/rxKFjDOCrNS7nifLX1JL+R0XZDTQ1VoAzH1lxpmNLkm5+9qhH8wmyx426S64TNWfiMa1sCPHuLtyR1ZkDfBVkOWP4y9aEP8wtvJQ/G7O0APHXzHEf/54ogv6/jHFBg+BnLLikpQIgxGmBAtFh4ZV+FIuayemv7mdTMIuxy6JrB/n9RZGk/X7evizVviYP/2GWGPILcgXNiFMgQcIQyp9krHw56YqvjS1RTe/n8VOhFBpaazAd4UsHDqvDxNVlTZd+65aq+7rLG/mtIPydqCYUWHkzm2L6CFe5+oH5u5DShet0qSpePZX3tBmMV0AQawFxed8nBPF5WlpP7JPpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIHZKydONpDmkro9D8DdtZ6NVMQNPWnLdXcy3QpdW1w=;
 b=KLkM2AkNZLWGyOnHrlUbBB79uPDHYC4ac7rlIu3bZYk6nLN4WQtz46Bmf32kwiuw7uVuGKpobxJNFsXa9XZuNqhTlCiJtyJlD7CCJo22uOVcvRlxmb7W4MjhySPKrCzGVaz81yE3rxGKL/NHxuPkl4u5E6fXq5xshZR6Ctlyg0o=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 15:52:34 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 15:52:34 +0000
Subject: Re: [PATCH v10 09/10] qcow2_format.py: collect fields to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7397fb42-13a3-b86b-83fd-3df62114f4f6@virtuozzo.com>
 <3e22fb08-2fd1-c0bc-8b83-2ded1a090720@virtuozzo.com>
 <77d809ff-d42d-55ee-b65d-c5fa69dcc394@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <225afe71-36a5-803a-97f9-4f2eb3f355b9@virtuozzo.com>
Date: Thu, 16 Jul 2020 18:52:31 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <77d809ff-d42d-55ee-b65d-c5fa69dcc394@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12)
 To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:207::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 15:52:33 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50510b64-9ecc-4235-913b-08d829a041a2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850552F2D1804DF7193CC24F47F0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oYoYFV+8f5w5Tmum2tF8Tvbdrx5dR4kwSYxvWnxv5/RRGDknEzF9jNkU45dt20o6dqxYg/zQ28PfQXHU3SdixO0ggjV52EE294B1ap9apMrkIStB7AQjK4sT2CX/9qBBaONqVQ2N9P3Q6t8zmL+pY4bPijKCreOSPIGtqbj3QLuTvW3SlyKg2WCPqFVP9mXii2xk31UDDuiLbaThouFyeZKjbFfMEzufCEyTyWapIr6Bcx/86UT+S520EfxvmKi/O89/8rLk/KhJqGigZVfiOBq0SGqPtBHho1JSHqGZDA7j4VmBrLLsQAgK+VyQ+SOSC5ZTC3TbzmusWvWUIqQQQO02AU2cQF5nCN24IoRGAEsX0NUKcSdjjsqDE5zHRh5I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39840400004)(366004)(53546011)(6506007)(5660300002)(31686004)(52116002)(26005)(186003)(86362001)(16526019)(956004)(2616005)(31696002)(66476007)(66556008)(66946007)(44832011)(8936002)(4326008)(107886003)(8676002)(2906002)(478600001)(36756003)(83380400001)(6512007)(316002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6tOlrk6YdZn7F7xdIyKAdecEP6k/wGGiAPt1DYSOZEDWSoRKivZwucAxM5Y9Sd7kBdP7S1d21VhYG2AZU96z5XxDt9TBoKUX3yv6IFOLW1BSoL/rTVfF0k7MYlRfBvPpXjQvgWK0q9GneDkQai2SOmEFi3n9oWbpOkk3sIyvzXCwXy697qQGknO81V53bBTac01YdbADiQhHVRxEoObf9bw5IY1ZVegoA7qIa/6zyKMtJMgxQ3Vc5CC8kB7Z/mutYiGJv62kCFTQGTHKFe8Du63kFHJMwGlvwz5P4Vfq40k5FKdkrGzySrPLrilyQAQ13vaR2ucM9f+t4U5yLBEwcj8CIXGAzn9xIJrvfzf4s1PrKWUsAjGQEqYNge60DMFFoTp/6Np+TvYfetMFJjKfJ3XocYw2r8LP72Z7UkEsj9BSUOuFO80+qMTgddy4BeVN/jw9P/ls6ERR4suBMfqGzR9VytftwFUicwozltSbtp3MQHPsWRoELflL28tSKpNH
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50510b64-9ecc-4235-913b-08d829a041a2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:52:34.7243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4ygSAUDnpVf7iKzzf2rfmGSfGGhnUpOADrTADFAfOLFxaNtnqbHhPYgSwNEM7QtIFc39WCG0S4sJcXuqxHMdCUyDQEGf+FJBB6jYytMmIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.4.115;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 11:52:35
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16.07.2020 18:40, Vladimir Sementsov-Ogievskiy wrote:
> 16.07.2020 18:34, Andrey Shinkevich wrote:
>> On 16.07.2020 13:24, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.07.2020 00:36, Andrey Shinkevich wrote:
>>>> As __dict__ is being extended with class members we do not want to
>>>> print, make a light copy of the initial __dict__ and extend the copy
>>>> by adding lists we have to print in the JSON output.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   tests/qemu-iotests/qcow2_format.py | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>>>> b/tests/qemu-iotests/qcow2_format.py
>>>> index e0e14b5..83c3482 100644
>>>> --- a/tests/qemu-iotests/qcow2_format.py
>>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>>> @@ -109,6 +109,8 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>>>           self.__dict__ = dict((field[2], values[i])
>>>>                                for i, field in enumerate(self.fields))
>>>>   +        self.fields_dict = self.__dict__.copy()
>>>
>>> No, I don't like that. Keeping two copies of all the data is bad 
>>> idea. If you want to select some fields, add a method (dump_json() 
>>> ?) Which will collect the fields you want in a dict and return that 
>>> new dict. But don't store object attributes twice.


That is what I did in the versions before but it looks clumsy to me. 
Every single class lists almost all the items of the __dict__ again in 
the additional method.

Andrey


>>>
>>
>> Not really. It makes a light copy that stores only references to the 
>> desired fields.
>>
>
> I'm not about memory consumption, I'm about the design. Keeping two 
> representations of same thing is always painful to maintain.
>
>>
>>>> +
>>>>       def dump(self, dump_json=None):
>>>>           for f in self.fields:
>>>>               value = self.__dict__[f[2]]
>>>> @@ -144,6 +146,7 @@ class Qcow2BitmapExt(Qcow2Struct):
>>>>           self.bitmap_directory = \
>>>>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>>>>                for _ in range(self.nb_bitmaps)]
>>>> + self.fields_dict.update(bitmap_directory=self.bitmap_directory)
>>>>         def dump(self, dump_json=None):
>>>>           super().dump(dump_json)
>>>> @@ -189,6 +192,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>>>           table = [e[0] for e in struct.iter_unpack('>Q', 
>>>> fd.read(table_size))]
>>>>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>>>> cluster_size=self.cluster_size)
>>>> + self.fields_dict.update(bitmap_table=self.bitmap_table)
>>>>         def dump(self, dump_json=None):
>>>>           print(f'{"Bitmap name":<25} {self.name}')
>>>>
>>>
>>>
>
>

