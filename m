Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C24C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE29F206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 11:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vxPWipuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE29F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg4uP-0007zR-6n
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 07:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg4tf-0007VM-7S; Tue, 02 Jun 2020 07:15:55 -0400
Received: from mail-vi1eur05on2091.outbound.protection.outlook.com
 ([40.107.21.91]:62433 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg4tc-0001Bk-SI; Tue, 02 Jun 2020 07:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJaTWhCpZSqfB5/rvSHnI9HYVx6wr+lq0/dtF4ZjzXqEIAQ8y741Ief6ETmyWmoWy8zUekHBt6lTTO/2m+ix3ZnkwJ1lLVb0U4JWQrZ/UrGlWCdYqDRXrkrfXsz/uzYaBTtgAkl8rbvoTplkEDlBr61j6+tptdz/6i0H+kgygsYn+Dh0JzTzilximNIasJusyOWdMws0xbbbEetAATdcCfQUC3EF4ePQnv0DgzAyZrDr0r+/FKvaCqr3XZHaYn1TFDX82qQunZ3W/+1hxa65Hvv7CMPOHYQUtbaoqBacmyynYXATmRjtP0q4Zhn2JHdOz5eRcxsNcJ7wzTIKyTpU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcDqe3ssG34J/1SBG62Bb1fPbHH3LrhUqC1mw6Mgh/4=;
 b=eLWxT0QL6FlzVTjbzPg/dAlX0f2Yc3Abfb/SpqzliyaGRwlifpgQfaXkEkaocH7RI0Ku+KT4YbSDJwkR0VF31QkJSxMB/uvQh3Rhd/Idk4FDTMqAWHnXed6U6PU1Wp3fLByr8qoKAKeV2pXxKP74N/OfKF9CdC3acx9G/VCMk7aSEa6I196wlX8txsI4rlcE98roIFxs3PRgJqgGeRLAv0LhSuZyXxnhCCM0lg0UDo9dRn1l8O+kIpMQuxRu8tBhjYUM+jbTs/jL4fLdGz9vxVAKpz60c1W+a+mqPEaMJ8wJnzlEd/oS2eBzawYF1P/i+YINp6McTOxc2WbkuXAflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcDqe3ssG34J/1SBG62Bb1fPbHH3LrhUqC1mw6Mgh/4=;
 b=vxPWipuQSvVmSmcUiMmJ1u+bSyh/CPxuZIU6ineqM2g4HOjBrWxFrNlPSEDHbwfZrPcd8/ayk+/r1RjwQ9cxiGeXEdAs5b8JgjbOdRWMXM8Yj5ijsoQXt2x9e+W8Pn3j0oLqZ/E1YCnTq0ty2zKP+T/fcoWZxOOusc0YnjVSf1w=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 2 Jun
 2020 11:15:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 11:15:49 +0000
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
 <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
 <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
 <07ff57d4-8348-4409-ca8a-ff4c5278b973@virtuozzo.com>
 <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
 <e78d3f7a-162a-b08e-ff8a-63b1889b81d7@virtuozzo.com>
 <64f37a83-4df3-d106-3162-35f696bcb5f7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e0a61a84-12aa-b38a-064d-68310ff911bd@virtuozzo.com>
Date: Tue, 2 Jun 2020 14:15:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <64f37a83-4df3-d106-3162-35f696bcb5f7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM0PR07CA0003.eurprd07.prod.outlook.com (2603:10a6:208:ac::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Tue, 2 Jun 2020 11:15:48 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba3d9d9b-6348-4edd-570a-08d806e64ddf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5464B7391728304356EAC56AC18B0@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0K4vG7BOWrSJDEFPJ6n+S9chJ12UxUiiAsI8N7coVyYcsEefDuiVOyVAGL4t/kiUzSbBaHg5DAyORG0OtJ/2Kq70DMyZgbIOzYGCpboXTjdpGrUnl6KhViMxGSW0C2+C+pBi2thOdef1bi5VgtXCw2ejqjKqsLTcXcnYeN2v1tTNVnn2Q9gcrD6hPucfg+SL4rzwdPZDsDxcruyf7UpRxH5/GL8/e4Cxc2Q5iszBlvC2bqI82TNchDc6YVENul9ZaE7mcGEai3yg6T9e7ERsvmkZbVDSH2Q2viOTJ0LjtqBfPTGG5xv7Wt6cBx7b4NhXVMHzNf3CmgxGO4ea4/kq0uIKn/j7ICOl5Gfn9bOQ1ZHYixxJfftCrHzSMgOq1vZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(478600001)(54906003)(16576012)(31696002)(66476007)(316002)(110136005)(66556008)(66946007)(86362001)(52116002)(5660300002)(53546011)(6486002)(2616005)(83380400001)(26005)(8936002)(36756003)(16526019)(186003)(8676002)(956004)(2906002)(4326008)(6666004)(31686004)(7416002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rNcu2ONWWgxFhKXI6eqz/aymJ/WFcth5yQBvTPcVPrx7gkDmKGemXfS3Qjzyoi4jxNqcSu/r90PwXGRxzRK9tzavO0e6yZUpTQMYEt2QcoQyx02a89d72dVt2qkdBOdF42hJwa7g6cIg+XQABG7Go4t/c5ftFV/yJGYTEYNpep6bY4dt4g0nC2EBIClY/E76lWF3c9BmYY23rHK6foEAtM4Qz7qXnSXR5qQmhHJfUl0EZY1UbFlDLI0w6FCDjr1tQRbbi6N9khrKrl3D/4gNcIq91KMfiRS5qrdCuSFJq2qbJt/SzeR/IMY/qltT6Pr9E0KF31S7Hod8/DX+ev9uOLBkDKka7rAsKhyReHgJfZ3ekrzalmAOgNA1Z+cCWMcfOM7kFq2FOuY4Ldch5lS9QCzkbL2Lu6A7e4tF5cNZLeybAKivOR87Ac6ObTbNcAAvDHG2Vy+Do+wYgcQe8jTr59FHjV0DIASd/egt/JBPwF0StPzAb+a51P9l9ZdaKfUS
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3d9d9b-6348-4edd-570a-08d806e64ddf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 11:15:49.3404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVL45Ky/0axUyKnwN5VpfbbeNfHrTZAXPSZ/7phpVvjXRhYZVJ46xVm1wjVgzHCkdx7I/oWrkUpfYA3s2pbxlLzB9HEQ1yALEtWRmPCeF7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.21.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 07:15:50
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
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

26.05.2020 18:07, Philippe Mathieu-Daudé wrote:
> On 5/19/20 12:54 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 19.05.2020 03:27, John Snow wrote:
>>>
>>>
>>> On 5/18/20 3:33 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> 18.05.2020 21:23, John Snow wrote:
>>>>>
>>>>>
>>>>> On 5/18/20 2:14 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> 14.05.2020 08:53, John Snow wrote:
>>>>>>> move python/qemu/*.py to python/qemu/lib/*.py.
>>>>>>>
>>>>>>> To create a namespace package, the 'qemu' directory itself shouldn't
>>>>>>> have module files in it. Thus, these files will go under a 'lib'
>>>>>>> package
>>>>>>> directory instead.
>>>>>>
>>>>>> Hmm..
>>>>>>
>>>>>> On the first glance, it looks better to have
>>>>>>
>>>>>>      from qemu import QEMUMachine
>>>>>>
>>>>>> than
>>>>>>        from qemu.lib import QEMUMachine
>>>>>>
>>>>>> why do we need this extra ".lib" part?
>>>>>>
>>>>>> Is it needed only for internal use?
>>>>>>
>>>>>> Assume we have installed qemu package. Can we write
>>>>>>
>>>>>>      from qemu import QEMUMachine
>>>>>>
>>>>>> ? Or we still need qemu.lib ?
>>>>>>
>>>>>> I don't remember any python package, which made me to write "import
>>>>>> from
>>>>>> package_name.lib ..."
>>>>>>
>>>>>>
>>>>>
>>>>> It's a strategy to create "qemu" as a PEP420 namespace package; i.e.
>>>>> "qemu" forms a namespace, but you need a name for the actual package
>>>>> underneath it.
>>>>>
>>>>> "qemu.lib" is one package, with qmp, qtest, and machine modules. "qemu"
>>>>> isn't really a package in this system, it's just a namespace.
>>>>>
>>>>> The idea is that this allows us to create a more modular rollout of
>>>>> various python scripts and services as desired instead of
>>>>> monolithically
>>>>> bundling them all inside of a "qemu" package.
>>>>>
>>>>> It also allows us to fork or split out the sub-packages to separate
>>>>> repos, if we wish. i.e., let's say we create a "qemu.sdk"
>>>>> subpackage, we
>>>>> can eventually fork it off into its own repo with its own installer and
>>>>> so forth. These subpackages can be installed and managed separately.
>>>>>
>>>>
>>>> Okay, I understand.. No real objections than.
>>>>
>>>> Still, maybe, everything should not go into lib, maybe something like
>>>>
>>>> qemu/vm/  - qmp, QEMUMachine, etc
>>>> qemu/qtest/  - qtest
> 
> I'm not sure this part is relevant now, as we have not good projection
> of what/who/how this package will be consumed.
> 
> I suppose by VM you mean VirtualMachine. I find it confusing. Maybe
> simply "machine"? We also have 'tools' and 'user-space processes'.
> 
> QMP is protocol, common to all. "qemu.core.qmp"?
> 
> We also have the gdb(stub) protocol, common to machine(system) & user.
> 
> The block layer has its classes, "qemu.block"?

Sounds good. But I see now that we shouldn't care too much about this, as we
just don't know how it all will be used..

> 
>>>>
>>>> would be more user friendly? But I'm not sure. I just thought that "lib"
>>>> is too generic.
>>>>
>>>
>>> lib is a very generic name, I agree.
>>>
>>> Splitting accel, qmp and QEMUMachine in one package and keeping qtest in
>>> another is fine too. I'm not sure if I like "vm" for the name of that
>>> core package, though.
>>>
>>> I want to avoid using "qemu/sdk" because I have some plans for trying to
>>> generate and package a "real" SDK using that namespace.
>>>
>>> "devkit"? "testkit"? "core"? Naming things is always the worst part.
>>>
>>
>> I think, "core" sounds good.
> 
> Agreed.
> 


-- 
Best regards,
Vladimir

