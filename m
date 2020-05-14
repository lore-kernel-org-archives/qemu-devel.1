Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDF8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03538206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pFXntO7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03538206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ66o-0003hU-0q
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ64d-00008C-HI; Thu, 14 May 2020 01:06:23 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:3136 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ64c-0007oX-5o; Thu, 14 May 2020 01:06:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avMCFv7VMWQI6g6Zu4cv1AfRqCfmWqWj9I+ZV0GHLoxt29cHLfJ2CjLsJnTcE660DmL2iGJhzZCcnydSMm+uJ7+OxR0W49dSuNbnwlEIbAKU2T00+cAV2R5RY3bn4RhwZkwRV0KnTR4I26QIS/yqqTio/v6MyEeI2yp/r3vJoyLqk2ilY1JDxFJyUeTZfHLFUmQ8vEulWODWcBto6PUaNz7jXaBDF6ErtPcENyAC4BVMnjX46xVc8LfN3vXDt4AfE/eHmYy0GVPn9XOvz/5CdHdyz504qXmicfzZqOc1IfKNdC1JSxVnhToj1s00PKnxOkmps71jC1fgGXY/G5phZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJxbB7E5JjCcDQXP9lq/rtFkUsxgWXVXgx2WT3Y6Q3U=;
 b=fDbm6uwb1A7wU+LhXT4cYUTi6hJ6b3fo2wlyHhCZmJeKcS0178G0wEh+OY+xWX1S1xwnY00BNFNSeqjDsp+8i3DrfkeA7HvH7t6ifpKJu4vczQC7+ParlukauQ/TPtFznRuZ+u/jBf4Ko9svV6raFtflr7XN0zre+XNaSAJbLkzfdFOYuI9fTvMygxG6Xx+butGi5Tu2zbYz5LiIMKPUbJJ2u/lxyS7j/uEXvYvxOMsjjua92ESLEoLOJNIGm2i1DH0TrTfFr8eJb/AWCsoWqv3J19eTIuQHXLgdwXdFEpd/R407JsfwBkjjFmBnkrIDfFMtXRYFwwc9wj46MY63IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJxbB7E5JjCcDQXP9lq/rtFkUsxgWXVXgx2WT3Y6Q3U=;
 b=pFXntO7JtWtc9f9IQ7EHbwew8DqaRzhcmIFAJQwABDvPf50N00QNWEKB3ovlbW0U18pTFQsviKGbpEU+5MKEZImA8wf2iH6m3UClsGKAkzTHj7qBw/4b4w00UZAgR2CNJoHuOwM1Wbv30cdlkMq/DN2gwmxRluwFvyF02IhWnhY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 05:06:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 05:06:18 +0000
Subject: Re: [PATCH v4 2/9] qemu-img: Fix stale comments on doc location
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6fafa9ae-b9de-3446-2fee-9b2bbd5809aa@virtuozzo.com>
Date: Thu, 14 May 2020 08:06:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 05:06:17 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9269dbf1-fb53-4829-05bf-08d7f7c4892c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5368FE40DB71A23F849A9505C1BC0@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6JbrTpLRjlRSZ0e5YvZ5bmhFSVQa57a1fLXB30oC9KcEoaAHMk4++BrtHMQokDWFLWwUHRRQGoqUEoZq3fICeiaI94mxnAHz4PGoNXC59l6BsiWTM1uzAFMvpvIZhyM7eVfyQqXGLHX/YTV+ytHzGlSwBG19zMob/tkSUiA2ZEtjRHKVZHVPdWsBVAe6FQQxUm/nTTryX12lA507kbi1SQDXGZK1pZoJwKIkgQ002ebOKQzWvA4MbJAKKC8Nnx8keFGUrIj6aqVXrQenKSxrPMXT7SE/hDfOgVk/cUD0YX/JHgADFjTT8k5I+ahsaGvtl5IoivLEpWHXK9Bw2K4NCiqs+aDtk3gWulNlSyV9v7W5zhKtUFZiXekpc5EQuE8FWHNXK1UhhiP8/772EAJMncPqcmw3YHW85P02QtPW7Ecy3Iqoh5VF8iMmNR01WZg8Bye9S9aUk5vu3IK/VhpQtnlS1Oc2usSfraWMiooUbnN25c4ndK+wXj8YiNbc+yt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(366004)(346002)(396003)(136003)(558084003)(31686004)(5660300002)(31696002)(86362001)(8936002)(8676002)(36756003)(956004)(2616005)(4326008)(26005)(2906002)(316002)(52116002)(16526019)(478600001)(66946007)(16576012)(66476007)(66556008)(6486002)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9lZ1RGH2zZiEz0E6ubP4TfTlMZUtKchATJMjfEbEfWGZB02WzeaQU2ggAjGoTSagKCEK59nKv8uf+Cs+zYKT1+GhxCrCS70HVY3hrI/nxy+M9nrREoaoEuKk0Kyv5eXudjihcvjAZ98DPQf1QWf/pxRnkkF7ZBm1RHvvfr1dcT7HMmAL6g/3HOz/lO2Rk4lb/w297YMdUapNyAETFgHpAo3uDS9P9bDhZUaZ82zDj3EZqMibjsgB1CYd/JCt/vlaozCjA141OyPoAF+k2wlnLOzJlMujohlYQK9HB1xXXRULkKec0Y5oxS8iaeYzcxBTAP3AfV4Fll3o0+SJTch5KCVdhcABLlmXlBV1D870IrvmP3zRm01KUZ2tRBKuMaybwPJ0k8HuQUEVvOAY3tPlu4gHk0bgQidK3ahG5EXs+SGc7OOFQ65ZyKOCA5IukZvBkdQDBvCC1aHXggl0e1299CXGN0bJA4CT/yAKCBUN3hejA+J/jSk1jsmWpZnrgckW
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9269dbf1-fb53-4829-05bf-08d7f7c4892c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 05:06:18.7121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V92748gWSup09rSQ1as3Pn1tX7FO4b6UzagO8swVEr5jjgOEP5Gh5NYks2JSOcbIU+M74+zJHGlSF7/MWAc+09m5n1Z7laEnjgnsjUczAhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.7.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 01:06:19
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

13.05.2020 04:16, Eric Blake wrote:
> Missed in commit e13c59fa.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

