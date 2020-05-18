Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D3F207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QOm5Ctfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D3F207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalXg-0003th-Bc
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jalWM-0002NZ-6a; Mon, 18 May 2020 15:33:54 -0400
Received: from mail-eopbgr70091.outbound.protection.outlook.com
 ([40.107.7.91]:2695 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jalWH-0001DM-5Q; Mon, 18 May 2020 15:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0bvMtYSOmfACyNpoNjcUYxENFXCxLH6CN+iMokgKwkFEcALcMWaSvh5EC5vCx5ZhZvjnhQpL9KqZbGYkmpiKnZwvDRJ9clkHPLmtYcNh0gr+dhp/uN6VEPRPk/6SvKaeIeBI2HU592I/wOUUlYRGzpwiTpvuthqfdqECGm9E3ReHgXLz2SV318k9lzbh+HKtPzC51Ab+vqyVgdZU42znBnDfbI2MBxnYJkoGacneoydokuQ3OkSMjWI/oQaybq2rnm7lCiU9U/ivX+/HM6TtaZsD37D4tDCjzBnd6ntTqHl3A0o36Yi78bggBVqcQyL6QL0iIvJ5iHSFrI+U56FMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St1CRk5bPVQDRwyTO0E8AachbgVVZMLf0ar5SUE8xNM=;
 b=IeZQlId1Nkf/XlnbMy1dniVoUZ0Z+oxOGPOIupzGrwvKImrPSVew521+uoSCtF+Lkj1n7LsB8pvSjhBFwYS2XEFnooTf1QCcrDqUF1u+L1SEVLfO4yeERHmyCe6qglNhU1VE84ZaWCSYV0X0zNN2NUBDzrfYTZMzITjC44iL33BNoNXqrESgPTxLt4J/6bCjShArjR/4NQ3pA0v5NACf6cMk+miNIn9ggFniwgk4OywJoalFOh5hywJe6i2vaX5LwL+q2D1lDfBs4uVRr8PHPRy1APzact7l9jMvqip+pOzQlhP1kiA5vFmNQEH3fOhZVn6FXrjcTn7qywKrr7HE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St1CRk5bPVQDRwyTO0E8AachbgVVZMLf0ar5SUE8xNM=;
 b=QOm5CtfsJocXS+1E2HFVW+fanwCpsFkwnADJpI+Zs26uYV5Eb/bVneUAFHjiawIxJ4Ru3bOTMfScWK3SPKANpgXgAD63bKmazaB3eiNZtoRLavSkB9Z1hMhtVE4/C8huJyM+zuuY893pu0WBFvFU0RkiMMj26zYNj8gCsFryybM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 19:33:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 19:33:45 +0000
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
 <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
 <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <07ff57d4-8348-4409-ca8a-ff4c5278b973@virtuozzo.com>
Date: Mon, 18 May 2020 22:33:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0123.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.187) by
 AM0PR10CA0123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Mon, 18 May 2020 19:33:44 +0000
X-Originating-IP: [185.215.60.187]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fca2d83-bc23-4e5a-7edd-08d7fb626114
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-Microsoft-Antispam-PRVS: <AM7PR08MB55269171D5DFA482985986A7C1B80@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppaIXsyyCsMMUYnLviXAbfJWEgsXTCr/ifGjNNDpXYZriHr1o1PMi6bqPsdKHMYfjHr6VxrdOV+HShpbYsm9CaKGx3teEtNOJvba9VpjS8XaYTgnpYEzqeGeRynQx1rQ8bo/d5BuaBblp+oNFZFQexrWzI8y6G7vZ1ilQ7q9v9Q3+3wvh5FyUtdJwCiQHPGL3szWhGK4a6y+MLtDSfnqGT5B0ck4C1qp8NS62hYSFaXmvll7yF8TBDBOGfYiZ7PJNYC2DkIZaOWImILhhyDJaPJExCwvRt68P9BJ3CyETXISANV7vf/ya1qbi3HJzNRv2GCYMHVXQsvGqPG98fzGY4USYZTzfNsb6bAVIAcMcILvP3pplAnxStXetfhQR/aX7JIYQ97Banv1+N6sCOO2CPlEqoQAbZIMM4UARdOQo1Oz9pqotQrUqLRMCoI9hMYQ30OEZ5Qo/bt3WTr5UtDacLysdY6iD+rhplWbRzmxZ+mMk4G+dco3zf+peoFlpDTO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(366004)(39840400004)(376002)(4326008)(66556008)(7416002)(31696002)(66476007)(6486002)(2906002)(36756003)(52116002)(8676002)(86362001)(8936002)(53546011)(956004)(2616005)(54906003)(16526019)(316002)(66946007)(5660300002)(186003)(16576012)(31686004)(26005)(478600001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zam6nMkD30L7PbB1+S0YUG9g2LcbokRfzsUnARs4T3M7ixPT2ATXd+nPSf1WUPAuzqheiJMRMKIhuuchyjhMQHDN58z46NEzXKW/l2eQySyKDkv53qfQ7mgivPq8WYLrGaNkfXAa9/lxK6DAj4gMfvJZvPAEdCzllu9nNoakbdxrKszKgONri8dMVHmHSD4fJO0HkA24TUU5+sZBGEKUp5/XTREmOdHxn7Pg4AP1RImZiKyGtRcjIEd5Y9xY0KXorVx8GY0vUUjBFeFRNvLpmhmhMjrcg14X7Mqe/GhWyS9fyNBzfi6Ukkvaqhyk303bt2Dw0tKedDYHCOeDlq8ysPMYUXBCQy+VwRJqb2HSLytpKroxaU2JRYj3HiFf+EC5TLVe3JcEPtfzXNEhg1XB8WsTQVy0+1FApMLlYz190sVc/hsYzwL/CcTy2OTmYEfoAkJY6FD/k0VqI9yXsp0Z7rzlN2f7yUr4aJxql6RiqtCZpaTZ84oVsrPAMDqx8xvb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fca2d83-bc23-4e5a-7edd-08d7fb626114
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 19:33:45.2614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1NPTuOkyweQ+NYGT+0lCu8bkQcG2jScFi8ps6UBLG7fyudhsKuKDfeggQMKR2W6SsiNvTiPlpUSL6odvkPoU1hUWqDcbvu8A3AVEpojTco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.7.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 15:33:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.05.2020 21:23, John Snow wrote:
> 
> 
> On 5/18/20 2:14 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 14.05.2020 08:53, John Snow wrote:
>>> move python/qemu/*.py to python/qemu/lib/*.py.
>>>
>>> To create a namespace package, the 'qemu' directory itself shouldn't
>>> have module files in it. Thus, these files will go under a 'lib' package
>>> directory instead.
>>
>> Hmm..
>>
>> On the first glance, it looks better to have
>>
>>    from qemu import QEMUMachine
>>
>> than
>>   
>>    from qemu.lib import QEMUMachine
>>
>> why do we need this extra ".lib" part?
>>
>> Is it needed only for internal use?
>>
>> Assume we have installed qemu package. Can we write
>>
>>    from qemu import QEMUMachine
>>
>> ? Or we still need qemu.lib ?
>>
>> I don't remember any python package, which made me to write "import from
>> package_name.lib ..."
>>
>>
> 
> It's a strategy to create "qemu" as a PEP420 namespace package; i.e.
> "qemu" forms a namespace, but you need a name for the actual package
> underneath it.
> 
> "qemu.lib" is one package, with qmp, qtest, and machine modules. "qemu"
> isn't really a package in this system, it's just a namespace.
> 
> The idea is that this allows us to create a more modular rollout of
> various python scripts and services as desired instead of monolithically
> bundling them all inside of a "qemu" package.
> 
> It also allows us to fork or split out the sub-packages to separate
> repos, if we wish. i.e., let's say we create a "qemu.sdk" subpackage, we
> can eventually fork it off into its own repo with its own installer and
> so forth. These subpackages can be installed and managed separately.
> 

Okay, I understand.. No real objections than.

Still, maybe, everything should not go into lib, maybe something like

qemu/vm/  - qmp, QEMUMachine, etc
qemu/qtest/  - qtest

would be more user friendly? But I'm not sure. I just thought that "lib" is too generic.

-- 
Best regards,
Vladimir

