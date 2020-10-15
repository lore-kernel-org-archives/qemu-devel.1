Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C251E2222E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YFta6Qhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C251E2222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSzFL-0004op-GG
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 05:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSz8w-0002OE-Rv; Thu, 15 Oct 2020 05:01:52 -0400
Received: from mail-am6eur05on2094.outbound.protection.outlook.com
 ([40.107.22.94]:5760 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSz8m-0003Xm-OQ; Thu, 15 Oct 2020 05:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0+GZZS2HUXoFYLsa/NUDK7uJ3iw1sySp+wqYvEA5Ldiq+W9L8mMe/Mx1XxqpJkU61Qq98MQwvUWG9ShLG0l/GnZj4cmy/nIdKU0FBiYL+OMjH8L6/5zFWmLWrUu782KyLda+ZJDlJOBGL1T91oPCtvB2zacFLzDDwMyfNWxO8fFUZ+bBOV1hA7TU2mowBgTk94wUw88NboOMaOHOlqCMeoD0qSM9BRhUMr3r55Wy1pm/lNfTJS+AA7buM8KrunIQXOW4DkLg1lalhl3XR08GLfPqMFzzrLjl66IUwDzLS7CWk5lv0Hs3Ka0ZXe4NFrbyKOAixwKLxzXpEJl8dvpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsWFo2zoZdabAWbYIYxBP82lUER2+BEoKR120hOeFCk=;
 b=kA5lrgnrkIY83VjbE+zo/DIuZtPh0UXXfGQzPnikdpjPh5ESJUgDV6bNrIIEQeWREX0sVkjnrhw56FuRjNxRC1sw+PyqbdtdqoeW/LRrYyktTiKIYPeM10+mC3CHpAu1Nr2/BKCDNC3oRh0J7lv/kCehVvFy2TygwilvHSNZm1XtncIB4zRqlyLHJ2WCPkQiSKRxb311u8OivC27oENRV8KvdJRvKTKngY++8GhzO9JKAIU74zCnhxegwOike4OWNVOgrUGroU7E/ksAj0BevjT6oX8xZsNB/KLtNXw0I41hm9TOahZLTz33BngppcCEoSH0tLtSKcm2RgtDVgWf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsWFo2zoZdabAWbYIYxBP82lUER2+BEoKR120hOeFCk=;
 b=YFta6QhphclusWb8Xe4TOUbl5LiRcFlzDzb0gBRYm02a+R+P8OSZFtbiQhfzb0tr8LAKHpBDHCDTRj1uHzeTxnwvPMMhNiU+vAGBJBtrnXg7/JPKeRyLcaynWuUDMIPlrN1YPmetQHot1Td3/o08ByvNc8EvhN6lfhHIhX33t2U=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1642.eurprd08.prod.outlook.com (2603:10a6:3:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 15 Oct
 2020 09:01:36 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 09:01:35 +0000
Subject: Re: [PATCH v11 11/13] stream: mark backing-file argument as deprecated
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-12-git-send-email-andrey.shinkevich@virtuozzo.com>
 <c309607e-d6a0-7a7f-05e6-9e1beb388419@redhat.com>
 <f8d6f6e3-f6eb-4ffa-1a2f-624c06462bbb@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <f8d16eaf-3106-dff7-faf6-cd54452e14a2@virtuozzo.com>
Date: Thu, 15 Oct 2020 12:01:32 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <f8d6f6e3-f6eb-4ffa-1a2f-624c06462bbb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR01CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::46) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR01CA0105.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Thu, 15 Oct 2020 09:01:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf40e471-e09f-4f01-4300-08d870e8eb0f
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB16426FA7B3768EDA4FD39413F4020@HE1PR0801MB1642.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EP12vhBpd7SDvnx0QgHpTO9T2NkmAi8q+srhlOSHEn9sAACx03Tst+kQJ2+K6JY/jXMQO350QhpLBO/BwTBsAzUSqaKiEvPYcNqmGDJm/+4qjKgxgKXIupvWfMztac5jxiW54Wa1NlYHi/Yzifl8pZZbm9g5qWxtypHZbQfnnX/mw6yfaG/qXhaeiBW+cfVWqZP4ZOdYl+fV7KD4EZGpEoh8mhcoe+eBN5rCiwtJAaPa/zSFH62qu7gva/abPjXrYxishypKXQaT0y+6gW58UdMxrgHJ9xSn9GDiSnnIdASWf7NBu3KdXPpP3vh1tt13E2WHwHdo2VaveSeioLzBQvUPMxmUIF6oHk8nzOdjvMvc3Ma/uW8QnEszl3A5ZzslSMbvKENBrWs920oOIN9WLqQH3M14W9y32SeHvpliciI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39840400004)(31696002)(956004)(83380400001)(6506007)(478600001)(7416002)(52116002)(31686004)(44832011)(53546011)(36756003)(316002)(8676002)(26005)(6486002)(8936002)(4326008)(2616005)(186003)(16526019)(110136005)(6512007)(66556008)(86362001)(107886003)(66476007)(66946007)(2906002)(34490700002)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UJ6aHOC/Ze00lyFM2XXH2L/6+lf2j9ifJmp1wxv8HT49Wle/3ZUm4GXCClmBXeGmu25wAR5rfIu/BouIjn09rDjTRBPU2oTxi/rxKkb4Uw//G/GUEX83nRTAW1liHskMtHThENGIzuvcLzVGBf026pTDNIpiZ1FiAneVl2u9Brgl3wUrs5lQKjciitRlYm1k3WXXBhNelOEZp0MkHxq61KUsYzJxxsyi/uIho4nFbKq5WW8Rr9FjhmFstGRUw1Wk2fgbtfdTPqI50VtqaxoWfpXLmtCprOBianGKWg38yzvGx7BlziE7csTA8iH1i8GfxxzKHcsdH9SrfJ1VXrXPZIFxlhosTRdjIVo3YOagOqMGsdv4kbx0SIXVGtgPznyTO3bmohLnM1fs+1bJ0MAWRKsYatCA9VnVaa81fsiVXxvdhEq/0t4qJWvOSTbLgi0TqcZwRTfZwh5LTu1wEel4tkAjS6mY25C9hbbNVDhfaIY/U0Ky30u0ZMpsRI02OSYpLo0tq6ZpFsiZhVKLz9CX5dtNqTx3IQ5zFC38+D3cSh96Vt5IyR3Nu0gSFW1Akuyftejdda1zcYyA2fwK/zqr9fzhWdd7pEnHfrn2EHtwZ9c4jw9tXprrYhp0wr7Y0zgQ9+Siyv5k9nYbaDzzOaSOpA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf40e471-e09f-4f01-4300-08d870e8eb0f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 09:01:35.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RpuZm/a00tI1908dYGIqMlT9wHsV7T2bmgsh8YNCjweYTMfHCxPtojjBed4YV9kb5/AsZ4SNJQGK1bQdf84MXeWWcj1MANODOicx8OV4Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1642
Received-SPF: pass client-ip=40.107.22.94;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 05:01:38
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

On 14.10.2020 18:43, Vladimir Sementsov-Ogievskiy wrote:
> 14.10.2020 18:03, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> Whereas the block-stream job starts using a backing file name of the
>>> base node overlay after the block-stream job completes, mark the QMP
>>> 'backing-file' argument as deprecated.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   docs/system/deprecated.rst | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
>>> index 8b3ab5b..7491fcf 100644
>>> --- a/docs/system/deprecated.rst
>>> +++ b/docs/system/deprecated.rst
>>> @@ -285,6 +285,12 @@ details.
>>>   The ``query-events`` command has been superseded by the more powerful
>>>   and accurate ``query-qmp-schema`` command.
>>> +``block-stream`` argument ``backing-file`` (since 5.2)
>>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>> +
>>> +The argument ``backing-file`` is deprecated. QEMU uses a backing file
>>> +name of the base node overlay after the block-stream job completes.
>>> +
>>
>> Hm, why?  I don’t see the problem with it.
>>
> 
> My wrong idea, sorry. I believed that the argument is unused when I were 
> reviewing v10. But it actually become unused during the series and it is 
> wrong.
> 

I missed searching for calls to the qmp_block_stream() in the QEMU 
dinamically generated code. Will roll back.

Andrey

