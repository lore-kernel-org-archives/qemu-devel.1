Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC1CC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581F224699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OfkZbR+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581F224699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Grt-0006T8-JB
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Gqz-0005TO-Lg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Gqy-0007ql-Rt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:57:17 -0500
Received: from mail-eopbgr30139.outbound.protection.outlook.com
 ([40.107.3.139]:25506 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Gqw-0007p4-PK; Thu, 27 Feb 2020 05:57:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnuhllvrzKlvkAyWL6X+IMQA3ab+6nm05ilDxs3gcqFilRjzRIsp78+084iqf7RnCeb2I+od4NVJzTPZCk7RbkzuXEeZ2ZocpdYX8SR6FIvWmY/qWIFKBlPiUswnBVk3jJTP0eIwRoOaCi/xTamvT5b4l5SZ9hWLM3j4uJbbcXvvX4heFENbw9lv/hIf437qdlFH9I1sOyevy+FsHCyQC8yneH2ldQVD9XxdUwwdy7qxEpj4yeXR8qLfJVD3DuwCh9Iih64bekti8iNm18nqtqp01a5P9PBGpu2aBGsSnmjT2I1GLRmqQetlCHhiQ9NhyIlMoJO/oh+kjndg52Gu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIIbtIu/cZelmZzCjPvuqt2cnUXnIblOaU2T8otaZqo=;
 b=KeGWAUGrE3l0qcR1rTnd77xBXE5QwDsGMpodepttNh2MJMEor2iOR4PsVJxIHz5qLS8D99Y75JqSLId0hhNX/7qjitBqRH9Ev1GF5aSOTaoIRPqA1+6zPQoAMfch7PipErmx0pXWaSfyh+jRcjrMN3ANfpeQ5011ysuZH8zy4bdn7YUQx39hT0AkG36SaqqrtZX9B9SwCP/bWfp64uwj6FVI41ucUjnCyQwdTi2Rm74Pat8Xp7EoWdGJ1hQ6tDYzQq1H1bGf91ZajniT16NKbZxBDIEzCYc+9+LmLPhDORsXxUTrFYRXps6fl9mf99LuB2AtYli8jC0owZ5XDULTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIIbtIu/cZelmZzCjPvuqt2cnUXnIblOaU2T8otaZqo=;
 b=OfkZbR+I0KWQTnBBwjR0YVZfr/W3ifAYcshVVKoMl9fz6weQe6DgZliKYv276gEPfCQbWiSXzDMI4pKnXFLwNSlexqGpa+gdeLOruf3ZsR1AAk/HPsd+2wdjlwXvqLjXytPE9HQQsVPpvai2/trP0H/KJThLLUSsKpa2ZyyRNhM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2927.eurprd08.prod.outlook.com (10.175.243.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Thu, 27 Feb 2020 10:57:12 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 10:57:12 +0000
Subject: Re: [PATCH 4/6] iotests: add hmp helper with logging
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-5-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227135709381
Message-ID: <7690d808-6986-541e-01bb-f847e4925af4@virtuozzo.com>
Date: Thu, 27 Feb 2020 13:57:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200225005641.5478-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR06CA0153.eurprd06.prod.outlook.com
 (2603:10a6:7:16::40) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR06CA0153.eurprd06.prod.outlook.com (2603:10a6:7:16::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 10:57:11 +0000
X-Tagtoolbar-Keys: D20200227135709381
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 460076f3-d21d-49fa-e6d1-08d7bb73cc6c
X-MS-TrafficTypeDiagnostic: VI1PR08MB2927:
X-Microsoft-Antispam-PRVS: <VI1PR08MB292773CFA9DB5CE9598B3C52C1EB0@VI1PR08MB2927.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(39840400004)(346002)(366004)(199004)(189003)(7416002)(5660300002)(2906002)(52116002)(4326008)(8936002)(478600001)(16526019)(81156014)(86362001)(956004)(2616005)(8676002)(36756003)(6486002)(81166006)(66476007)(66556008)(26005)(54906003)(31696002)(66946007)(31686004)(316002)(558084003)(16576012)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2927;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMcoDCe0Uj7A5k7DGTr4U2MbKUsmJCDJcwUXOMgrMgLzG74DcWSmm3wJlroQNc1Cz53DqfudPwR46J88JxaBeuIYatYBbTGyD7oYcSe3Jh4EloyD0tcmy4DnWy9fagu/eg0vAKl6m25up3PNZLeImTSWGfNLoMdIMBvJA/kwbCla2+lkyII/MyJ0q114PfCw+YsTc8GAI3Q2VAQY8Opvn2hCOIn7KrsoclCw44SueTWgJ78GW/YRiUNsmM9WfH5f2Np7uDOms8/sOA43GFhij1dteWCFzRR+wVxIswGSsMMf/tEp+kOGFBb2HQqD3QmCG5a2Sbr+qpPv4fSP0nA7TUxCLWlwYVV/oEuRXolm4SVilTGDV81WKS89mbXOL16W6DnwW8X3XYpyxyFPaDZhXGrIfuM4uRobphbxluBPHOWCPOXC9N3o8+oY8iPryAMK
X-MS-Exchange-AntiSpam-MessageData: bfzWBb75Krv8wC7D50/zBTcnzjfiuKfUiuBXf0ktM7PpAk1oM2NFfqJfqmuEbz5WcCX+vfyrLZ+TEN0HAqLGbZCIhez9CFnhnOIYSubMCdkgsZ5waIc1xLdZ+7yvEwONdj9FCyxoGkrJhQYfhMSPnQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460076f3-d21d-49fa-e6d1-08d7bb73cc6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:57:12.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ0nleybQWSEU1a2875NOwhdwdmcd7auHKYj2uIBpoguEt6PlJLCWgQXOAIaRMWOM4HnK4xMxXRPpN9rzJ4fxLvV+Dr7vzqf1/rh32CRHwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2927
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.139
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 3:56, John Snow wrote:
> Just a mild cleanup while I was here.
> 
> Signed-off-by: John Snow<jsnow@redhat.com>

Great!

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

