Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE0C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 04:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657FB206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 04:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J6TbJdHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657FB206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKwnH-0002c0-Fi
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 00:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKwm8-0001kh-MX; Wed, 23 Sep 2020 00:53:06 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:53197 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kKwm4-0004BF-Bp; Wed, 23 Sep 2020 00:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDLUl7mc0hRutnrVTNcV4f5kNCwo4vmVTM6j6GJ2g7jsWVZy8IfIXmzmXAnqhjs9q3s8Ck81v9TspeCXNBMP+/4O5ea9o1Zx/HX0RsqeyKuuoB/zwyG1t4hWhCLHOrXIOU+6W5hF8jrc+mWGXipQyC6/y5948YCFgTx/jK51LjRHIB5gIX0bGLVSVliKhJKRS9tEEj/Yib+0D4H2NZG4Gz1NKJFz8cykg7xRqeZy2INxISM1w3sd1yOGCaeBTEk4GbvGO4rD1mMU2F9dthKw0Ofwdab/qkcYNhJAqQG3NFEHmDIvbF3XchjG3q83vovVVFc4ZBIljGzNGTeV9QxehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4Wg3QaMj/5SktzwjXCFMYKnI5tz5TIQ3h+0Io+47mI=;
 b=P+YI3Os7wr2GIDo9EZHOXRxQ9SSayoxxE2yPPY0H3/BEWXCPXDA0lsUgII5qdOHCPPhVwSzNnVlifH4RMAbfa/OpZpPjvMH2S+DsKEe6O6+U3NZNg/1BqAtmDulaY3X9fj3gaW4Uf6xapmRuc/MTf8dg1vdpZy2R8W4xgWkpY1NjQfaKiD7Uz1JN09FTU9GqShCxgUYoZHKa5ltmO3r0vDFhJsTw4meB1J1t+GiGVENWH39JULLZilEWdiBkVSDSlnle6Jumcgiq/jZqOfD7kagMBQqC1mWyF6jk8QWHpBuFnSTwZe7w6PukIn57K+RoXUiGM9T+HC7DUhHprjastw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4Wg3QaMj/5SktzwjXCFMYKnI5tz5TIQ3h+0Io+47mI=;
 b=J6TbJdHREmRRI8YcfZddtgwz2i88GO5fT+m0I3B+7sbXvcnVBqnGlWoVe0YaG+b0if71Jz/Ma73dCuLGfbnSOWY+uIFBI1MKn5nz9UOe0YSzmqXHIjZmfdF0WcvEWHrHpb8Y3CUQyqtkBF0OA4fN3++qTa54Nr7+SERly+cOy3g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Wed, 23 Sep
 2020 04:52:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 04:52:56 +0000
Subject: Re: [PATCH v2 0/2] block: deprecate the sheepdog driver
To: Neal Gompa <ngompa13@gmail.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 libvir-list <libvir-list@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
References: <20200922161611.2049616-1-berrange@redhat.com>
 <CAEg-Je-td5R-pqbzUgpNYo856QnyfVafSh7QNNaWv8qvcRaJ9A@mail.gmail.com>
 <20200922174252.GU1989025@redhat.com>
 <CAEg-Je_psR2xZ41dUNRzUP0J8herCBeBChyFXa5vn8+rsqbtrA@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <55d4dd6a-3229-389f-f618-558ee556a20d@virtuozzo.com>
Date: Wed, 23 Sep 2020 07:52:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <CAEg-Je_psR2xZ41dUNRzUP0J8herCBeBChyFXa5vn8+rsqbtrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0090.eurprd07.prod.outlook.com
 (2603:10a6:207:6::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM3PR07CA0090.eurprd07.prod.outlook.com (2603:10a6:207:6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.9 via Frontend Transport; Wed, 23 Sep 2020 04:52:55 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60102a75-fd4e-443b-0c95-08d85f7c8963
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB165284597B8710D49E623011C1380@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVIoJaq0Ottg4sH7DOL+fI8SKfhoDkfSH+Y7xzq9Y5QnKaAJPdDgDILixSX8xF30/38JJFFQeusP95fwjUoHOiDZGYJzG4UxArdqbKrXVSTdLqP31Y82puArqhCR2XZO96+YJaEqaTUrwlVVKRWcBPsqEpYEfUIUVuPp2sl0AP1xDoCRnDlRxovRFm3CQzsqsQVddLDcY/BYhlv70lnSeKl2MZDVc0xtEO44g4VvBqepm0KUa4bMh3qcu6bTwMejpGPhPTf6Fbhw7fQEMoL07lruucLulPWfskoMzjwmkBlssSkag3PbwYKPcqJuda0o2ES98lEtsC8AMli9zLZ/WULcCM/oVPFFgiCNAM9hBsGkR9+XaGtnYLPrRcGww8QSwVYMLexqoK3HyytDx/QJdDe/flSDYehRgFSHjnOdt9pucDuIlJ+FApuKJz4kvibW+wQmIgnCttxXh7xVNNIseHe0DlAYs68dQXoX28/l0jOsuBvCqsZG8f8gZZoWyv9p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(346002)(376002)(396003)(136003)(86362001)(2906002)(31696002)(66556008)(478600001)(8936002)(66476007)(66946007)(966005)(8676002)(54906003)(956004)(31686004)(4326008)(6486002)(83380400001)(2616005)(316002)(16576012)(7416002)(186003)(16526019)(110136005)(5660300002)(26005)(52116002)(53546011)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6Pm7JfJxvCpUI76nQCGMyocD+gUDBzaRvw+q9KrhwU+Q3X/+fcKrm5wFfA3vVtueNVRFkvjkGYvIqjUjsqpd4GCJTc1a3EG4KqP7Pvw6ePAYNvh92IdBR0VHhtu9FiCG4bYUJQT/54QlHd1dPZZopFD4aR9DclG/BehAgoVzkIlvwfsS7gLyzBBQXOgDil1j9cEF2o7/9+Ry7+QsV3wC9oIKkEm7rPms1aF6gED+1sMAsV5aQKBCZTRmyYAq/3jlVHndYRwvkPFxoNlumigauym/vC9/RZSwRJeEJJQ2EUUzqqvZCdp7U9pgYBwAwrR220ZYqh0QfPS+oSNGuqxsd4b9fZJG13O0pzgEfqxpF41wkI4NfBDEUH2RZ2NKi+I6yQvvpKQEbq0dxSLF+R73RZYcrB1zWqKUU/xjgPh5CC8M1I7bk2AeSkVNV42UYhscC/oqgnAmzS9OIpIczqvkLoVAyU/fPyGINRE3bHDMBCaEGIIyuhK2SMHg/tkqUqo85jkOTdf4JTAz8+bUZU3C+onjE7ufgI2EX0M/ueqmXzGZ4gc/UgZHtqxOPubFfwY80j2DFAnrp8fQ3l+vNxdaWZ3OyAFY0jGTp9ioZcxlp+Qoaoq/5UG008aCVhWIvcHyvh415MUvIGsmUbNmC9bmaQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60102a75-fd4e-443b-0c95-08d85f7c8963
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 04:52:56.2241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdS0RH/TtuA4kSn4z+ID9A3C1aPWVHmW5h23bfIQbnNevsJ3obIEACTGk7d72oxKVDW0H9GvzEVEltf9G+cdijAH2gLgdPnQ8XOTKWBXBRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:52:57
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

22.09.2020 21:11, Neal Gompa wrote:
> On Tue, Sep 22, 2020 at 1:43 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Sep 22, 2020 at 01:09:06PM -0400, Neal Gompa wrote:
>>> On Tue, Sep 22, 2020 at 12:16 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> 2 years back I proposed dropping the sheepdog mailing list from the
>>>> MAINTAINERS file, but somehow the patch never got picked up:
>>>>
>>>>    https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html
>>>>
>>>> So here I am with the same patch again.
>>>>
>>>> This time I go further and deprecate the sheepdog driver entirely.
>>>> See the rationale in the second patch commit message.
>>>>
>>>> Daniel P. Berrangé (2):
>>>>    block: drop moderated sheepdog mailing list from MAINTAINERS file
>>>>    block: deprecate the sheepdog block driver
>>>>
>>>>   MAINTAINERS                |  1 -
>>>>   block/sheepdog.c           | 15 +++++++++++++++
>>>>   configure                  |  5 +++--
>>>>   docs/system/deprecated.rst |  9 +++++++++
>>>>   4 files changed, 27 insertions(+), 3 deletions(-)
>>>>
>>>> --
>>>> 2.26.2
>>>>
>>>>
>>>
>>> I don't know of anyone shipping this other than Fedora, and I
>>> certainly don't use it there.
>>>
>>> Upstream looks like it's unmaintained now, with no commits in over two
>>> years: https://github.com/sheepdog/sheepdog/commits/master
>>>
>>> Can we also get a corresponding change to eliminate this from libvirt?
>>
>> This is only deprecation in QEMU, the feature still exists and is
>> intended to be as fully functional as in previous releases.
>>
>> Assuming QEMU actually deletes the feature at end of the deprecation
>> cycle, then libvirt would look at removing its own support.
>>
> 
> Does that stop us from deprecating it in libvirt though?
> 

I think not. Libvirt is not intended to support all Qemu features and
I'm sure it doesn't. Amd it can safely deprecate features even if they
are not-deprecated in Qemu.

The only possible conflict is when Qemu wants to deprecate something
that Libvirt wants to continue support for (or even can't live without).

-- 
Best regards,
Vladimir

