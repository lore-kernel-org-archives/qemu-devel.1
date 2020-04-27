Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFB8205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eYmoNZZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFB8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1v9-00034C-L5
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT1u4-0002DX-Tt
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT1u3-0005Es-2X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:26:23 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com
 ([40.107.8.99]:53121 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT1u2-0004z3-8y; Mon, 27 Apr 2020 07:26:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHn4vamdqBrdkjWkLLKTNm5UX6jpRH2YVJADfCkR5An0x528y65U7JOceLo/puKpV+4zlsA5TWFB8rgwPcGljDLhNNm6NUtBlDQpb+qWU5LtPsc6T20JIi4fxsKgYtmV3nqgi3BLI0irdphRMc4NIpgXLIKFkkL+sdmKNhrI7iPsEqGIEq3dEHv2fO9XzfcPBQCQuSEzY5JvrI2Nnw0ujvreF+4Fg62pIBsygWFG11NLP+Q1to838eNDNvzNiX2EuSEselZG6dw+nNkP36gy5XKLMFZIYJCN6yGuPd1AxRa5sRA5AhURLXlJOBeaFzNJBGcxw2qbpkNWOnseQBs7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3LPIZAXdOMxT5zsQP7u/EPAubrLEIUsq4YuoPOlcWc=;
 b=W0uXtKeYZ/NveWJagPsu0U4hjUdpxOQWzNkaic3Cy8ZWlC+2DdN0YSBNwvYM4zM9lrIQSHF8d843h4YqMvncb2Nzuom1gpm/vnbxZVoZWQNSjXvFDvaNDdNNazne4rsPVKAvUHkfnbhHT6AtKP2xJPu6QKtRbjXLFC4xHfY1ffEY7lryHuMeZz8Uzh5J8Z0zKh0YDtmYlFmQrxyxQb4e1DEsTZ3DDxoY/WrybhBtq+a1Ud1p4kfoXSShM5s9pvTvB5/zOPeWE1uKUsi0HOMVpAGfOJXH7mtOjexJILTJGxA7XyTDkLna2ETplp8P6fhhYyNDjBNX/uRkbhXDV1J/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3LPIZAXdOMxT5zsQP7u/EPAubrLEIUsq4YuoPOlcWc=;
 b=eYmoNZZSiSnMe+XZVYTbiBz001NyVwmJb+DEldUis8yLJEFQYEg7FtLM38JIYKHT8GTDuXOeX/s4ofN2g7e1lv3pC4jZ7IfN4kXrl/cF2wRNmOQF+OteZzugEnrYpvX5NIBrwbUwwpqA3EgZVxBGTAt0yfSM9HfmST62vDydN6Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 11:26:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 11:26:17 +0000
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
 <ab987de2-812b-7d31-ed3a-aafc7d44399b@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427142614959
Message-ID: <d8d3666d-427d-ec76-f58e-2e82525459d8@virtuozzo.com>
Date: Mon, 27 Apr 2020 14:26:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ab987de2-812b-7d31-ed3a-aafc7d44399b@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 11:26:15 +0000
X-Tagtoolbar-Keys: D20200427142614959
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adf5b505-8bb7-4096-c691-08d7ea9dcd39
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53504C6C71775E677AE81B0FC1AF0@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39840400004)(186003)(16576012)(6486002)(86362001)(16526019)(31696002)(26005)(2906002)(36756003)(66476007)(4326008)(7416002)(81156014)(53546011)(31686004)(66556008)(316002)(66946007)(8936002)(5660300002)(52116002)(8676002)(478600001)(956004)(2616005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ss7EtYDgFS+hHFyB5cR9/WvT4Xhfbu+44bt5a7N6pCxE9kK79DdZ1xRweRYIl3CXV+ujpBKr0YoDOjNBzqxL9NthTiRkWotatC+mFI8wjBp5emivAjZO77TOgVKelGMpc8KsPLhLdktvvTOuGl5zdM6E940BsMdBDWelx/a5SPDeWPqcN7ifhM+g9FRvsgGbkptdLab4Wx2ZoZwnZDiwYhybosM1JOpCh0UeZ106iofTID1BA3UH72gnUxtwHqLWmPXHjdOx/QzxVjumvCw9D6C1vhd/OjAZpj/YyklQUk/HPpY0K4XlkbuAwBz4MI60RxYSErUlof91t0HZGDD+/I9I+y/p/N+gge+DekxInf4hSYs1yXwutb7S4oVOHq724rp2yAVsA7WJMNHeaidEiqnwdq5WpENb07ZUqZgGua9cV9gfw58MgfkQA29y4RCD
X-MS-Exchange-AntiSpam-MessageData: IXS7XTMhdA+cgo20haffmFW7gHKHmUO3CQZ0so16GbpH6ioSA4aMhovRI1yO6OQlkjPMgHgbBUXz5GTWi5KOIOWrPVnOlDtj34VYwwhD6LNQNMM7ytQWI/ygLTsk7b43Ei9qCGpQ5E9nntqirk3fWbDQzu8yRbc7jPH/5yW25QSsgpCdseoi7juRMguCyaCcp+1aAUbARbAI50mgm/LuGNBaSYLK4XPvkFLuvfFEuJNK/JUUVmbzhGPawjBrt0BkvKKfzoQFf3zA7lOc6m7RYvGqqeaEulbF1Wo07gQrvTSoaVncTjmJgiRjk/9ntSi726UN6XVGqyAyCO2wLRBuwjc7TGLpgV8/8GC8V6o2IsxNGeZzOrP8zjZ+mUuxnQaYDbwwuXKcN/zx3vHVucw+7wJnbAoLcBwBFxud/W9nidkTKwyHHMxJ3D4Q2PMYLk2S8G3DwAJWI6rbeBdcOHnEIliad1qVYmQjr7SAdkYPDc811wiGCyjlUIMa2+uSTF3ojYXQfFonAX6UaMPcUqz4NkBRwxbvKXr7TXJCaZdMmPyNWZhmHpuGu7FpTlRnjkJB+CwkphUCgII51PYiY17nut4gHYSfjYeK1nb4Q0zmuM7FQ/0cd1nuNcc7NteifJp9JXVrSqF2qN/Hyg6/FALrkjDJpR+lvlFAvzF0wlvQGSuBkGT7m77Y0IsvNdtwHLv5Tk1V8gJxDvGZ05sT9w1xfJwZ2WvBXl5RLW0TvPqAIM18i9Oz3dAWBh/vlwFkZrXGtSJ1te095eOl//S3jJlVFCOPwW8WNuBch+MCcv6k8bM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf5b505-8bb7-4096-c691-08d7ea9dcd39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 11:26:17.2693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTukyl47wZ8GS3nfQ6pR6Zq9VOh71QN0tTJAHikTiV5ArxkrJP6GE5/vNtqKsBCXyFIs2bEff8aqXfyr1fh1cifbMH1bN7phYe4u7gOD+7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.8.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 07:26:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.99
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 ronniesahlberg@gmail.com, sw@weilnetz.de, stefanha@redhat.com, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com,
 sheepdog@lists.wpkg.org, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 namei.unix@gmail.com, den@openvz.org, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.04.2020 13:11, Philippe Mathieu-Daudé wrote:
> On 4/27/20 10:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We are generally moving to int64_t for both offset and bytes parameters
>> on all io paths. Convert tracked requests now.
> 
> This doesn't seem a strong justification... If I understand correctly this patch, it is safer to use positive signed type rather than unsigned type. OK it might make sense to better catch overflow, but it should be explained in the function prototypes, else commit message, else the series cover IMHO.

First time I decided to follow the tendency not to copy the whole cover-letter from previous series, but just give a link to it :) It's chosen not for safety..

My reason is the fact that some functions may return int64_t offset/bytes, and negative values are used to indicate an error. It seems good to use same type always, making it simple to reuse local variables for storing return value and as arguments (if it is appropriate in the context).

Eric also added (in v1 thread), that off_t is signed too.

So the aim of the series is not signed type, the aim is 64bit. And for consistency, we should use same type for all io functions. And my proposal is int64_t, for these two reasons above. May be good to add them to the first commit message.

-- 
Best regards,
Vladimir

