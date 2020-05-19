Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4A920709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NzfJ4nIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4A920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazuB-0007i4-2k
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaztH-00078Y-OH; Tue, 19 May 2020 06:54:31 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:41206 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jaztF-0000Gn-Uq; Tue, 19 May 2020 06:54:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmH03fMIFnkSJJjpGxnrzXM6r89NVO9c+Y7voqbnDRnRSiCuGLcKymcs/to5P3wKogg9VSoqWHuf/RULuW8JkKRuzyRAcHOyhqTPMk56Wkol9mpMYcA2tjI45Q0lKbHHQV74x2vustQFaituZOB4C0r/FIBXhQpObd2XTDuN/2SVmDPuGU8Uuu0H41YlH0Ny0dg+hW6gLbZriF2OYGFUiPNS7lcOSzv+1CbW19XWTU/hPbl6kT8xEsUbrXQ6BUiQeWRfWtXWNEMgq3RsV/objX1mvnAPnYhEos9QvKKW5qxVIpop3ViF/nS4CKT1/W6vLcgaQoQeMZ4AU3ONfbHnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS7dAWn0448ggTXSOBYo5Mwd80Df76S+1W9w4B02kVk=;
 b=Nk21sypehMHSBUIX8djTyGhRYQVrP7tSJnZN0az8PoO0Pg5Uo5TpQmzzvM+eRQQTKipOQijFZiH3p6qHwQpJ6FVVa9bZUKmrdRamnhjPr84yF6cSgjaRVC5wZXRF1XBX4xaCSVXtm53vufwq96gYAIhq/29w6HgPhm8FC5H+fZOlMxk3rADGOHXue8SFFRwoHAIJ07rKPfJUGaxw5BMFH3yB/onrgs6JcQQGKWl7RpA3YyHFe4Or+YY3BYtNc+XGlAkn2e7PasBTGyLLhmIPQvnkitjNb4WJbQ2s7mJZCh3skGEWoh1y7725dxWL4kPDTSQSlH2DHbJcPV0c2wPvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS7dAWn0448ggTXSOBYo5Mwd80Df76S+1W9w4B02kVk=;
 b=NzfJ4nIJxoo082AlWV4iDFuzkqIYsga+TaqjQcmcBoXzykBG4wIN7VQ93L+HLvfwW7No/zOLFjkzDQNdC8TLj2+Tupz/GhD9wfheh5zeLw334/cs52XCvifooE3kFOA5Y5ZersDYf2Px3Jc3vRe/+8NxehDIt4/Va3svqTuGP0o=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 10:54:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 10:54:26 +0000
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
 <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
 <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
 <07ff57d4-8348-4409-ca8a-ff4c5278b973@virtuozzo.com>
 <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e78d3f7a-162a-b08e-ff8a-63b1889b81d7@virtuozzo.com>
Date: Tue, 19 May 2020 13:54:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26 via Frontend Transport; Tue, 19 May 2020 10:54:25 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91402d73-c99a-46af-8d4b-08d7fbe2ff94
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54293A6918421E516508686CC1B90@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyi/QY0It4ket1OFwEU/jFVQLWdxJxLDeH3t3wa86bnDITvcQdlnTNZuIkWNxlcgLGkZ3vDHJo2BJEMtJJ4Z2Vi4e0QH/h/4PEWTYmAG1ZU3/QoN/QIxT+DfRkVfiAKpAM7jTxNKMbYw45BcHPJn8g738lnPNpitOk7kLBonQvHGIojxmXKfnX+c5lUQoRe+LiD7BWj1B/H9f+EBbuHmLKtEWaKs8/B15xlc2yWrSfr3MR8BL/jzVmEBx1opGJyvyDAeYdPepPf1dMInSKR0mMSdX4seUnrAPivM2NbZcHGoGWEnuJ7gWPPPlMN5XAVt4V7dIGw4RkAeD/zMYp09dZdIV5iyEZ1otSmA5jc+X/Vk4kHVn9XcAY9EwIUwPvEakNbqn7fvohyrI7TglVcN5TrMtSHK/mIDBQz6Fl7Bv24S8sNFO2p9raB3+CjZbOYoR7F36ZC61sjYDapHzcrjBOymJ1CV6pmW1UN9uyT++D/Z3Xo1e46nRbnlrtqSo1y/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39840400004)(346002)(366004)(136003)(54906003)(66946007)(31696002)(956004)(478600001)(7416002)(31686004)(8676002)(2616005)(4326008)(53546011)(8936002)(16576012)(6486002)(5660300002)(316002)(36756003)(26005)(52116002)(2906002)(66476007)(66556008)(86362001)(16526019)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YfGq8hVZmtfy6BIg2gbc648Xu0rUVfz4zf/HTvMa7VvC5LunWYCypan/aHhWPmbRfgbLQXoKlBsDLfHwjbsLpaaBD54jgolKIiYA7X5XXQ7ooUnz76ztEmDNlHMZZDabEosrQD7LjcyZIKxyQTNCJRhNZR3YOTNsuQbxXomg8TF8AcaHJnJA229YguvL4/N40Szm7PA9XBp8fiKODHRtOgA+r22QJLZG4G9othmIrY1Mz9n2yi51/IeSCSN6cxuY/edVsYlZtKOJ65L70Ixd8Zb0Wh8ik9G0V+Q/5SyQitmGc6r51j0TNR3lPzyATw3+BD9p3K6OSEruv7PVD+ZvXQCLkZL6nHaw0g0RuX5Sxc6197DUTTt2xqQopZ9oLuK0gRjw4RFS3Mhf8dXiwodwBL/LyMBaRtPzgBjtEL3RL0V0ykqSaA0QkTON2jPFvaCYuZkl0e4YpHjNgiAu7kHDmFQJAIc+KSK8rbTudZNslYwHzREU0AjT0JAw/qEuSgN+
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91402d73-c99a-46af-8d4b-08d7fbe2ff94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:54:26.6177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awWgcCqyTyyeIfDtpE5fAQvVMhiQwZ+9gMYWRjKxsivP8u6fHB/KseiTjYiPc0toTtvGINqx5pspMqNXtp1Eev2pIZBlgnbIRQxELgLHrtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
Received-SPF: pass client-ip=40.107.14.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 06:54:27
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

19.05.2020 03:27, John Snow wrote:
> 
> 
> On 5/18/20 3:33 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 18.05.2020 21:23, John Snow wrote:
>>>
>>>
>>> On 5/18/20 2:14 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> 14.05.2020 08:53, John Snow wrote:
>>>>> move python/qemu/*.py to python/qemu/lib/*.py.
>>>>>
>>>>> To create a namespace package, the 'qemu' directory itself shouldn't
>>>>> have module files in it. Thus, these files will go under a 'lib'
>>>>> package
>>>>> directory instead.
>>>>
>>>> Hmm..
>>>>
>>>> On the first glance, it looks better to have
>>>>
>>>>     from qemu import QEMUMachine
>>>>
>>>> than
>>>>       from qemu.lib import QEMUMachine
>>>>
>>>> why do we need this extra ".lib" part?
>>>>
>>>> Is it needed only for internal use?
>>>>
>>>> Assume we have installed qemu package. Can we write
>>>>
>>>>     from qemu import QEMUMachine
>>>>
>>>> ? Or we still need qemu.lib ?
>>>>
>>>> I don't remember any python package, which made me to write "import from
>>>> package_name.lib ..."
>>>>
>>>>
>>>
>>> It's a strategy to create "qemu" as a PEP420 namespace package; i.e.
>>> "qemu" forms a namespace, but you need a name for the actual package
>>> underneath it.
>>>
>>> "qemu.lib" is one package, with qmp, qtest, and machine modules. "qemu"
>>> isn't really a package in this system, it's just a namespace.
>>>
>>> The idea is that this allows us to create a more modular rollout of
>>> various python scripts and services as desired instead of monolithically
>>> bundling them all inside of a "qemu" package.
>>>
>>> It also allows us to fork or split out the sub-packages to separate
>>> repos, if we wish. i.e., let's say we create a "qemu.sdk" subpackage, we
>>> can eventually fork it off into its own repo with its own installer and
>>> so forth. These subpackages can be installed and managed separately.
>>>
>>
>> Okay, I understand.. No real objections than.
>>
>> Still, maybe, everything should not go into lib, maybe something like
>>
>> qemu/vm/  - qmp, QEMUMachine, etc
>> qemu/qtest/  - qtest
>>
>> would be more user friendly? But I'm not sure. I just thought that "lib"
>> is too generic.
>>
> 
> lib is a very generic name, I agree.
> 
> Splitting accel, qmp and QEMUMachine in one package and keeping qtest in
> another is fine too. I'm not sure if I like "vm" for the name of that
> core package, though.
> 
> I want to avoid using "qemu/sdk" because I have some plans for trying to
> generate and package a "real" SDK using that namespace.
> 
> "devkit"? "testkit"? "core"? Naming things is always the worst part.
> 

I think, "core" sounds good.



-- 
Best regards,
Vladimir

