Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB88C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3325F20735
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="lMn/o803"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9CiT-0003R7-HL
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9Chv-0002zm-5Z
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:28:11 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com
 ([40.107.22.139]:60161 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k9Cht-00086B-7i
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZc7X4hwBHoxdjXKXYNiqnAGAb40pBfm13/h34txvqbiniXaFD7dWJFRh80CRwy6gPEaFkfmNecpM4gbai5Q2ECaOLvsE4SU7dDqQNheALxpq5YFEMJUUt20V8wSw9COBdpfY/R5K6QfLtFyP61VO+xc3gofGiX5zSLv/c+uNmf5oaoFDflaqW5iSl7q8kSCwIs/Y2jlMAF6Ta7SUdYpfLTkBSeROcqeCVTF5itrTD7XgM04rj4yjTgsTOKUZF18+GfgkAUIOkliZehf+VaftFZqTtzrNpN+JJnuznibup+bFCU3UIFKKMTEi8ySNdbqCE3UFDWRkOlo5ncJ0ZJmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J2LyZSQsHmtxyLcYqyyaHF0mIslwsqtFiTOT8Pg6jU=;
 b=ecj4NPj0bgxTDngy4BgdBDZlkLd/LuZEtFF+4t//uifA7m0Ylujfr49TVr1SWQY2yeAsHObzhUYv7myPt052Xxu57RdwiOtyK3zizPT5tGAaE823w//rh3uPtPW45py8+UB7g82ydC9tlHF8FrRu9sTf5C3UlJTuNqvnj211z2eYacMjFewiFIxRhkcwHjZ/N1nPissg/rf+W8485FHY/CtDMTqDybjrBH5f5j/5OLsIrm4WON5aPnvD9/BsEr2WmU3dram9dslGC13nP98p37pg/RkWR5HaSxXVxioNwEgmKq1tyepK8EaWhb28NXWHydmI+09ph6f2jpS61a59zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J2LyZSQsHmtxyLcYqyyaHF0mIslwsqtFiTOT8Pg6jU=;
 b=lMn/o803+68kwXFRz7kCIrzF1outLZolMptA0DXPx3CikhDBQ1a3aUkPlh2gExgKmpmAfbYoImt+MAlmHt2BmenLvEG9WssY1/a3uJBrbVDyXRkk5l8zS/c5qA7vbPCyuc4qdmc0u4rXe3YsafFyh//tGquGyUx+StII321+Gxw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB2926.eurprd03.prod.outlook.com (2603:10a6:802:35::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 21 Aug
 2020 19:12:58 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Fri, 21 Aug 2020
 19:12:58 +0000
Subject: Re: [PULL 00/14] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
 <CAFEAcA9NUR6jzCypJv4pC-ghvzjk2ErfFJ65j6A=r1LUbzp6cw@mail.gmail.com>
 <e7074486-fa9f-48e5-5cd1-61cb499d17f1@vivier.eu>
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-ID: <8109be97-dba0-6cbf-235e-505c63bff9e3@syrmia.com>
Date: Fri, 21 Aug 2020 21:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <e7074486-fa9f-48e5-5cd1-61cb499d17f1@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::26) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (147.91.217.236) by
 ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 19:12:57 +0000
X-Originating-IP: [147.91.217.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff29abaa-9d0c-4569-9130-08d84606372d
X-MS-TrafficTypeDiagnostic: VI1PR03MB2926:
X-Microsoft-Antispam-PRVS: <VI1PR03MB292625513691BF673CC5C14AEB5B0@VI1PR03MB2926.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moPkWKINF0vjj1Mn7sihMkF4Cb7AXBb97aQDh3BJpbW9TSN0hwfuF3WreeiCf7OqRhxpAVBsMmycSenfYhJfmr99Wea/Kj4WIQhd1GIQNUO7Qx972lUlaIv9DLVbgjLAUQzSQbMG/Uhb7xy7I2zi4oMrjW14ETSI8xSmZx6QLZfXkqYEU0keI6uDhWiPmFCSWRIn2uZt3NRmDglts4BopqlLSG2Ie3g0G9E6kBlnd+jdrCAUW4IC7Ah47b3R9OhIF7UTk6cAnRJYCbHXCqys5rKln+PCyxxuiEHOiU8N4l4Z3BbRizMoZPiGDE3MrNEq7sH3FWZctbN3EvelvhiLKTPBn9citfNQWjMHXyX/MFP7bX4B7Rp7P/Woj2lVTjH0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(366004)(396003)(346002)(136003)(39830400003)(26005)(8936002)(6916009)(4326008)(31686004)(2906002)(186003)(478600001)(6486002)(16526019)(52116002)(36756003)(66574015)(2616005)(5660300002)(66476007)(66556008)(8676002)(31696002)(16576012)(86362001)(316002)(83380400001)(54906003)(956004)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GKUynfhhxRN7iZSQ3gZ8tHEGvj0D65v6kFshxKNeuXOtNh7lLq1W6rG0QOH6T1RAPYWpcFtl6SqEoiYnrBfg199s//eWz8qXAL3hPndRdK/kEWUzsmNbsdwxFSGKBLjCNoro898FFWpoiE46DOZ+qxAlXAkvr2E1/5EB1opj1SstjHi6Ei0NvDg5LjauVFeMHfzZAQRQrfswAFvtPh7p+JnCh9V5XbqCTx1uHzn/I/2Vgo1YEFSEjQ+9YANvQPlW8r8knSGgxNPpsM40534hdRLBJ5sjkHtewK6ABKLikb5/GPFbqS83De9zfwNruUqdTCS+dbzHAZFWgs/GMi/jC8RxaytWdMCZckXz2RV8Cbr91s12y8hZb2SuW+5v67cGIRBhfjymn4A8qhbOB1SlvyJXXH9t//7xuoJr5DxnNk+KCjJ7euca6tpaaDfuL28kewV2utnAD5EOAe+MNgBytMQ9QLmDyn45WLrm8wsfsIz7BVoAFGOC9QH9jvTQeqYgVrSDdaB2FK5eT9DmS3uxIlRP4WzMtzeSDdNzWQ18L46TiaEwYvS+mglCylxNYfxSs7PU3sv33S5/GQJsMqVibisBYpqgUtLdFHj3tvtuiLGmhYp2S1Hy0YfNg81Sd75t9huC+c4mQB6adCVCdU5H5Q==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff29abaa-9d0c-4569-9130-08d84606372d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 19:12:58.3695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuFG9n0FC/cbJzAybtxzwSMfpph2mBibV52aEg3Omvcev53jrqZfRq5DQpiZeF6zgYnfi52i3qwbup+is9isDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB2926
Received-SPF: pass client-ip=40.107.22.139;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 15:28:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 21.8.20. 20:45, Laurent Vivier wrote:
> Filip,
>
> could you have a look to see what's going wrong?
>
> Thanks,
> LAurent
>
> Le 21/08/2020 à 18:23, Peter Maydell a écrit :
>> On Thu, 13 Aug 2020 at 07:51, Laurent Vivier <laurent@vivier.eu> wrote:
>>> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>>>
>>>    Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>>>
>>> for you to fetch changes up to 04275cad60c8f99e0dd7f56aecda68ceac926da8:
>>>
>>>    linux-user: Fix 'utimensat()' implementation (2020-08-12 10:09:58 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Add btrfs ioctls
>>> Add clock_getres_time64, timer_gettime64, timer_settime64,
>>>      timerfd_gettime64, timerfd_settime64
>>> Some fixes (page protection, print_fdset, timerspec, itimerspec)
>>>
>>> ----------------------------------------------------------------
>> Fails to compile:
>>
>> ../../linux-user/syscall_types.h:407:28: error:
>> ‘BTRFS_INO_LOOKUP_USER_PATH_MAX’ undeclared here (not in a function);
>> did you mean ‘BTRFS_INO_LOOKUP_PATH_MAX’?
>>          MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
>>                              ^
>>
>> ../../linux-user/syscall_types.h:451:17: error:
>> ‘BTRFS_MAX_ROOTREF_BUFFER_NUM’ undeclared here (not in a function)
>>                   BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
>>                   ^
>>
>> On PPC, even more errors, relating to not having
>> BTRFS_PATH_NAME_MAX, PTRFS_VOL_NAME_MAX, etc.
>>
>> Not sure if this was a semantic conflict with the meson
>> conversion, or just an assumption of a newer btrfs.h
>> than some systems have.

Yes, this is because of asumption that a newer btrfs.h file is present 
than some systems have. There have been significant changes in btrfs.h 
from kernel version 3.9 (since it was introduced). For example, 
BTRFS_INO_LOOKPU_USER_PATH_MAX is used by BTRRS_IOC_INO_LOOKUP_USER 
which was introduced a little later which is why this error ocurres. I 
am guessing that this should be fixed by putting an #ifdef around thunk 
structure definitions in 'syscall_types.h' to check whether the values 
that are used by these structures are present (or if ioctls that use 
this structures are defined). I am sorry that I didn't notice this at 
first. I will try to send a fix as soon as possible.

Best regards,

Filip

>>
>> thanks
>> -- PMM
>>

