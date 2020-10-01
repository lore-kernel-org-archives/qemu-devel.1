Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85641C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54EC2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ioZC/Zf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54EC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0cI-0004Pl-TB
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kO0WF-0006fH-4a; Thu, 01 Oct 2020 11:29:19 -0400
Received: from mail-eopbgr20125.outbound.protection.outlook.com
 ([40.107.2.125]:27278 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kO0WB-0001lW-5h; Thu, 01 Oct 2020 11:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV7n/Ne/nFssBWDeIlKq+pXcSC2fPBEkKbcy0bMxzlXhQYBpD5o1dIrEubdeEO8U7HWLV9XKO/vNvpo/Jbjhx+RGbnvcQeEH4mD7bKe6BLM878vYWFOxNcUqUKWpy2ZEVy6WmnKKWRx4MfPctWefgx1/IX+i7EHHxen21GCZWx8DRdV7O5uqxkwE1eam99iu4MIS6PqzqxGtC5GTA055Fnj2GVP06+n0tzkZLmM6E3EN09KjUvw8wP1fW/NGknXS5rnYy+XtRq+7+lrmGguGpHHoI11DhYWYv5uKwyKh6BMWD1gdWriJInWHaNjDXQXU+dxwSowQIkm5I5r32jsBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKVIWJLX2WZvol41JzIY74hhiP6ymw07WrBXr0Z09Qw=;
 b=j3/sOGy3C5Vy+OMJYPB+ibv/scyIIpMVzVBNH0M9SEEs3GtDuAHzqsNX9D1oGB+O2rYAUa4wyWD5PNkpB/g3vjfexTFKwHqM5cHjuv3IVRyKJQfFz2DSaU/SeZtAfOi8AmkSReiSbw2K5VSZtZIUp2Q3iOh6YOSKQpxYrxJtwkl0UwFTJFnIRWjdI5l/7EQJmjjQXJf1YtUWQbyTzi1A5EsXmvkBflwgs6Wf5rVl25fhxFAECrmOwMSf/Po4lNvwVO5jFA3B5JUKO6gmrkoV7vtV1y5ISZ/tWC5iVYNEmCJ0toMGOowoPctlwrMJ1YT1HQ6dKiZ0sazgUN2iUT/bgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKVIWJLX2WZvol41JzIY74hhiP6ymw07WrBXr0Z09Qw=;
 b=ioZC/Zf9DHP/KzfjLGO+HZF9CE686N25lmk/ti55o7Z+tnjq9Yxfy2jz0jKnVCGAxIJWlPOhFn1xRS8ZTpSQHsoEpQ3A8ppI8UgytQuK8zI1ceah5ek03Ye8rB/L5k8NefWlk9nI/ncvU6mAgLoxcW8dJETD4FiyJ9FQiaQcTW8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4344.eurprd08.prod.outlook.com (2603:10a6:20b:74::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 15:29:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 15:29:10 +0000
Subject: Re: [PULL 00/17] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
 <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
 <20201001150248.GB559957@stefanha-x1.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bae6c793-96aa-92fa-0d35-f6c1144626e0@virtuozzo.com>
Date: Thu, 1 Oct 2020 18:29:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201001150248.GB559957@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM3PR04CA0132.eurprd04.prod.outlook.com (2603:10a6:207::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.37 via Frontend Transport; Thu, 1 Oct 2020 15:29:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf3722e-d8f4-4850-9571-08d8661ebe48
X-MS-TrafficTypeDiagnostic: AM6PR08MB4344:
X-Microsoft-Antispam-PRVS: <AM6PR08MB43441039AB755C79750C3AB6C1300@AM6PR08MB4344.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3w6vSkYaAnHmoomb2zTFEuuWPhS6Q3XF4Is9d0/JScF9b0PeAAT884yDM66vbhuz3G18naVUIhKqKhxhV0dmtsT7l3i7ZHbm6VheddOqNoVbbWs25hflBpwRp1MdFYqQ/opa+WT7I3bnAwIPPQjm8LVDynkwn+KyLsOL/YKjkW+HDdvGWJlbOSXMoKiAsI/nMHhzAOnVXqSauyrAJ1YGCxJcOUxLKoMR1MaEiOUIWzDBXsJlsjKOVW7eU6bQILK3c6Hyqkb6TKmmKQ/8obScWPUua7/sfMOLDRYHdVuRKM+RJdft+zVePNplMTAShzv+qgtQOl21PvsJsZY5yWF5zLWwE1JjGhNZINDhkbLyivBlY3GBI9NSbwqiPNUBygRkKiiXH7xZIMuKqRBhiViq/NqSNr7phawikofgtPIeudbWvzpYQM16Y8KQ9G4Ln9uzZ08+pAgCxlmCjfi1JB36Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(346002)(366004)(376002)(396003)(16526019)(186003)(2616005)(52116002)(956004)(8676002)(86362001)(4326008)(8936002)(83080400001)(316002)(31696002)(6486002)(5660300002)(16576012)(31686004)(110136005)(66556008)(2906002)(66476007)(478600001)(26005)(54906003)(66946007)(36756003)(83380400001)(966005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vciKFhuMohOjMjxvJOqpdBrR3FSOLNE+47zz6Bx3gz+7CkUAoxmGPCGEQKJ1PcssVqEoAVQ1oy69x4GOkO4Adgr806YqGkk2rgJN0kT7Vhs5hnMa0YSMcViNaO8YxLG7ojtsjqjsojMLs+XFZb9xTqilD9h/+anGTqgxO3/7tjVbAykHMxH731Hw1D/P4bleoDUyUiCMHlgc7tJvMSFq6QC6I1tJ2LX/MN3n3w6NopPbaz/Ds24vkE3NOt2qzbohbDGZi2FpStcW9QUOo2L1SEB5b5GvuSeykfjBOJrz4hKsnBuruffhtlND/CyAUbY86QfincyzJm5o8uTrdtl0hiCZV76BmTaWzzpP2Wau3DAptQJg7/7bT95EKeVKeMASYxsGtmSSq2Cf3G9obwB+FyKFrNlqObmktlSLjG5DHpytdBSxCZ4ZWhnbdrYI1HS8n63cK3HE0+Z2SxpsLluXfyPqmmSGXgJqwvMVUOhyORd3aMZaLJnyMV0/CTH7Xv7o/BCWNhG0mzGfOQ5CRu7WCI14C18ZVVAV/mWnt494gnJxiqdmeVbi42D+T0/XTHj/UDvcEU1yVIblDOoHbhe+C0YH3sV2emzmd/a8kTrFEWxN4TUkCpUwd3XDMgTPuBWbTT/MaAizWnwi/WEWTuWA/Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf3722e-d8f4-4850-9571-08d8661ebe48
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 15:29:10.1719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5aEx8G7yM4Zsq9Or2gx9dcTw7DFmjVGuysv7dClVdotdltYpg6UZbiJtu8K3Q+E0ZX2t8iin8o/cvtpSqLuLWkHmsi3FW5+Dia8aYGE4iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4344
Received-SPF: pass client-ip=40.107.2.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:29:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001,
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

01.10.2020 18:02, Stefan Hajnoczi wrote:
> On Thu, Oct 01, 2020 at 12:23:00PM +0100, Peter Maydell wrote:
>> On Wed, 30 Sep 2020 at 11:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>> The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbdbcc9:
>>>
>>>    Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 13:18:54 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>>>
>>> for you to fetch changes up to bc47831ff28d6f5830c9c8d74220131dc54c5253:
>>>
>>>    util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved regions (2020-09-30 10:23:05 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Pull request
>>>
>>> Note I have switched from GitHub to GitLab.
>>>
>>> ----------------------------------------------------------------
>>
>> This produces this error message on ppc64be Linux:
>>
>> make: Entering directory `/home/pm215/qemu/build/all'
>> make[1]: Entering directory `/home/pm215/qemu/slirp'
>> make[1]: Nothing to be done for `all'.
>> make[1]: Leaving directory `/home/pm215/qemu/slirp'
>> Generating qemu-version.h with a meson_exe.py custom command
>> Generating qemu-options.def with a meson_exe.py custom command
>> Generating block-gen.c with a custom command
>> YAML:1:83: error: unknown enumerated scalar
>> {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
>> "BreakBeforeBraces": "Custom", "SortIncludes": false,
>> "MaxEmptyLinesToKeep": 2}
>>
>>             ^~~~~~~~
>> Error parsing -style: Invalid argument, using LLVM style
>> YAML:1:83: error: unknown enumerated scalar
>> {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
>> "BreakBeforeBraces": "Custom", "SortIncludes": false,
>> "MaxEmptyLinesToKeep": 2}
>>
>>             ^~~~~~~~
>> Error parsing -style: Invalid argument, using LLVM style
>> Compiling C object libqemuutil.a.p/util_qemu-error.c.o
>> Compiling C object libqemuutil.a.p/util_qemu-sockets.c.o
>> Compiling C object libqemuutil.a.p/util_aio-posix.c.o
>> Compiling C object libqemuutil.a.p/util_osdep.c.o
>>
>> The error does not cause the build to fail, which seems
>> like it's also a bug...
>>
>> (My guess is this is due to some script implicitly wanting
>> a newer version of something or other than the PPC box
>> happens to have installed, rather than being an endianness
>> issue.)
> 
> Please rerun with make -j1 V=1 so the full command is printed. I'm not
> sure what is emitting these errors.
> 

For sure it's block-coroutine-wrapper.py. I've send a letter with some investigation and solution, did you get it?


-- 
Best regards,
Vladimir

