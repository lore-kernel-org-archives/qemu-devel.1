Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E84C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B3521D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="E828fQlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B3521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLVr-0006BA-0t
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL8f-0008HH-7w; Fri, 18 Sep 2020 14:29:44 -0400
Received: from mail-eopbgr00111.outbound.protection.outlook.com
 ([40.107.0.111]:63104 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJL8d-0005yX-2B; Fri, 18 Sep 2020 14:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKOD1xDYJS2ZuATrxcbElarzdRHsNIplC1XV7XKajNPs4gX1ByyUx1s6ehlnsEmS3fqFKpC7mr2C5xOte9ZvZZ+wRIeDLsP+n3HMGibh0DhdnLccdqsB8Q8q1r1RtH8gS/CAPKbCJrfPRgrxKhP2JZXigqaHhNocWSPLp+azDAKbH6xFzgfEZXkBnaELzj8+yuAKNDZDSWutergr/0JSXGPc1OZLrvlSB+SgWwScnO2/8AVwRXDGhja8DUuLTqBJkkXz27/2pQfMVPUuPQ0LYurqpnhWSG6fpr0hKqnqpClicSk+tt1mvORUlsTDpQiYYJF2O+Ttc4dVIip/xUc/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXE7bTGfEMjOKVmbwqDazpOk/w921320Vjfw7wdw+Uk=;
 b=KNaHd3I2dkCMGICe7ErlrULP/0eWtlg7piYQpqcNIJi5wNkGik5yPN5eezm0pv+ZnLVop0I0joDyBTUHfinN58LQ/IgJ/zO/j3Cim4lWZlcqqMI0ee6le/VjsHrHAsn41TJWUoPnAJD7OUydKIlbMFvDUcIrtMcnxPBchqHHwevbLAYRaizlCOS0sq/MbzpTp5o2uR2DsYgBh7KzFu1aGEPcWjpSa9YhwLjqqqtyArZSR33/YyJsswk1iBhofcsMLX/yA0ffAxJBKQtpMY6AtzbYKWAj2oUfdCwA7Y0di5csobHRkP83CXBiNKQpsj9HPp1nWfggG0UCCfIM103RYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXE7bTGfEMjOKVmbwqDazpOk/w921320Vjfw7wdw+Uk=;
 b=E828fQlvwNcTZ++ubSfSiGaQLQLbs7/2dgk2LYxFC2FiUiqe7UDhyLMA6KaTnIgsNRrE3jBpE17e34jSOkcYWJsf7KLx191KxPm8Oh4jhsHIGau2uDt7O3IUHuR6lY+BThgPZBTJ6yW6fs8ypZpXUChwDN68yd6z0cJux4LBjvo=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1649.eurprd08.prod.outlook.com (2603:10a6:203:38::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:29:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:29:36 +0000
Subject: Re: [PATCH 0/4] nbd reconnect new fixes
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <20200903190301.367620-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f134d134-4fa6-0307-9261-29096cc4fa44@virtuozzo.com>
Date: Fri, 18 Sep 2020 21:29:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200903190301.367620-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.106) by
 AM4P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 18:29:35 +0000
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aca26907-b73b-457a-6381-08d85c00cb9a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1649:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1649E847BF66320A62F1881DC13F0@AM5PR0801MB1649.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4imnSKOnw7f5LfVWi4MRUiFkMdH4SgNFg1hCIsrBq3+hO2+5aBKFrJerRMfxQkwY9dJMdimSxjTAYW8FzJyYoJcmnnhuhUua8giXO/3rnkol9yh3DnmC43aOutQRs3cnyFZVY5BV72vX+GY+P2ebG+tpQhu8+mg6KSCr7I536FqUwpsLlVBbBx6XHO5lKF81x7P5A2dX0nIBM369847bMXikr/6X8n5oeEyt4bIg2CdT/DdIs6yuCAkzfI2Ml2oDdmPgWXhWDa1Bz4OQ+azZLLnyJUsSSoBZaM2Dx3ATpmspvTaXHwcLpg28DcO3oKdZ50nk5v8HXX6RCBb4QJVuTDNgI2XzgX0i4qoOYaNM+OfmR5z97JWj7EOqZlq01VO1d6hWEGjBNL73TIc1iB0jQ2lQ+w8UckXgDc5zTRsRt8AsSLL9kwL/FypXCiODE2x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(316002)(16576012)(8936002)(26005)(6916009)(478600001)(186003)(16526019)(66946007)(5660300002)(66556008)(66476007)(2906002)(107886003)(2616005)(956004)(4744005)(4326008)(36756003)(6486002)(83380400001)(31696002)(31686004)(8676002)(52116002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UjorK83wHz38XaykMX66mAV5OyEEJjvbwUe5sOCfLlji0hRDkoIva8eymN6BRJ+oNZJoL3fLmKG86qK5+qxlWC2QwJAKpIHqjl7dlGmSr1YisaAAZaEGDIsIBHy5SEPf0UwkfFGc/eR6GA8Twj+F5Kq8uV5fWTTm7HLQ4UL6S3a8Pypt/7wdJhfYHBn0e5iAyQzOvFxHUIofuneEbE6JOAu4I5+S9x5sJNdP+wOT3XUOg33R9gTGeJXXZclmP1fXj/GqUp9vg1iO9jyQCkv5Fp/0uFftQBqrPYK3LENuF4Cg6uLSh0QMXuY2woN09IwRA8I57AiHOQecd6f/IsqO/uiIvWu0Nrgk739/kaudbJZedmKa/++Pfo6o0asvADrryEOYnoXdWPoyYQpp/N6grohwaKYQtgiMCZlhZTgDd8JAB6BpqikIDpcAhSYb0W4Nk3c1tlUmPg/FO9WFVfMCdicFPTWxkaI9ho8ftlAl0UpRppw3bVI/bRhSofrIVX5F/IDpyIjhPLFoxphOIJtv9sbx8CO1pOOSTjnKczfOtMwxxtk2hPKWvDR/UvH7qmKpAnUSowE0CGM7F8vqA5MkFTvcNRrgH83jeaCVp0AxD2A3XHzMIcHCGeyMlAXXiYTuKae/pRh2iw0/C8upuBRmpA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca26907-b73b-457a-6381-08d85c00cb9a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:29:36.0524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps75I7mNMv+uxaNToCQg1qmJeR83WPOFiUDC+WDPcDK+hlncYGiH+cwZI6CMhuT2YdJdyORSD2B6FhsTyGjqoMhZQ//8p7PiygQ7ctPmf10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1649
Received-SPF: pass client-ip=40.107.0.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:29:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_LOW=-0.7,
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

ping

03.09.2020 22:02, Vladimir Sementsov-Ogievskiy wrote:
> Hi! Let's continue fixing nbd reconnect feature.
> 
> These series is based on "[PULL 0/6] NBD patches for 2020-09-02"
> Based-on: <20200902215400.2673028-1-eblake@redhat.com>
> 
> Vladimir Sementsov-Ogievskiy (4):
>    block/nbd: fix drain dead-lock because of nbd reconnect-delay
>    block/nbd: correctly use qio_channel_detach_aio_context when needed
>    block/nbd: fix reconnect-delay
>    block/nbd: nbd_co_reconnect_loop(): don't connect if drained
> 
>   block/nbd.c | 71 ++++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 60 insertions(+), 11 deletions(-)
> 


-- 
Best regards,
Vladimir

