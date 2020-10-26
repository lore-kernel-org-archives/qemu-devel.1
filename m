Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAEBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD09223AB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K8jiDSgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD09223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1jd-0005JO-LZ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX1ac-0000KF-17; Mon, 26 Oct 2020 08:27:06 -0400
Received: from mail-eopbgr80120.outbound.protection.outlook.com
 ([40.107.8.120]:12502 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX1aY-0005Kq-3u; Mon, 26 Oct 2020 08:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEbwD4EojfPAD2z0tLlo4g1WSwrPmEW5/QttlD38TVIeKtj6dSv7K9W45EogxhJIsvk+1K1Qi0BgA9d9tjJa5mUOU5ZFmPEB1MNl9eYEInTlz0Qrq3ALamV6f1UKpEm98poROn6syXncMM3OSESKEhhYiMuFH1NpxviKQnaXQuJ8eG8orRN2aWzfS5VIr9Ai2l9mSJT5MeLEM078VvAS6+wGU9BBXIMRPLmUvxYviuwFvmvErqWMMXIGavNdD5IAJ8qj4CzagpcagzprX4Roh/euJfTLYlaapiBTpuTwlYV7bC92mvGDZZhRXpYr18NNP/yck/zm2hCrWbsYDw1Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVG5WrW+WV5QZUaVEimvfMnGGhnc6kpWmgquP66FXeA=;
 b=hspV0gZiJmalRQnpf4TiiFz7oQWgN/vv6p4Y1h0bD8rX8UIgr+wL41hrO+1f5Shu0v0zPgWJBI5u/WQKWtFm4fzCcAyv9oFDRd254IVOZKVvIJuosJcaml15vc8O/90XMuDAdR5TfHSYii7EUYR0lLJmJXg7uOWG0lwflD/lIKb6JeeJBuqZssEVVdsB5pA/k5lxhkcGuZo2ivx1kwWpIHNcveGrFoxQOuUjI8zpY6YOoGm+mn/2mxB7KCMpo7KuoKucH9xJMiqeu+5Xl952sHWiBDd2K/RVt0hAiXrr+2f9HSf2uGY2GK8uAczRD6iihBaU1u7Eh2nBf7jqoUawzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVG5WrW+WV5QZUaVEimvfMnGGhnc6kpWmgquP66FXeA=;
 b=K8jiDSgm5IGUySuWkL0i4zP1wMng9d0PTcnS6YKsy7wPOGlSpMiWNWDV0e8/8dNO0Y05Xr5rXljXDi1RrApx9TR6+LTgkAS0S9EGi7W80QM5p5b/BIZ43ncydRUk4rfkGSxG6KAPPTkRw1raWyrg5f1Hua5czCW2BQfyGdX9+dY=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1780.eurprd08.prod.outlook.com (2603:10a6:203:39::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 12:26:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 12:26:55 +0000
Subject: Re: [PATCH v5 10/12] block: Return depth level during
 bdrv_is_allocated_above
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 rjones@redhat.com, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-11-eblake@redhat.com>
 <caeff8a0-a4b6-0835-27c9-726cc8f94304@virtuozzo.com>
Message-ID: <6c71221a-6267-75cb-0788-434d4d169c66@virtuozzo.com>
Date: Mon, 26 Oct 2020 15:26:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <caeff8a0-a4b6-0835-27c9-726cc8f94304@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 12:26:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3547a69-3a56-4b85-af11-08d879aa6d42
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1780:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1780C7AA373A93E0D1C1A647C1190@AM5PR0801MB1780.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HmQERh05gW4g4i2UkKAK6ce2SOc2+omobeNeMhc4YgJ1PcbRgwYp7B8K4SVe3DjnXV0el7MBYMhymI2bSiqmNmzgldbOT+4epmXuafsGMu2XPfT4UUjOH8q5T2Pm+Pu1tC7aRDTESQ2Tx0cO78811Fl4AzrQkVd/uc/3j027bqCnh7Eag+DpHpQNuBAYzY0Zewm7BqjZ90MpXJiE2kix79wEOeC22EZN7C/2ZmLHi+97UMCQHdxuIzwMwQ2E/seA+px39MfrQss06QCqVKe2bVAfk+eJ8E5O2P8ZyQ5Nyr3DQKUgh3oM6TT/+Nbh1307ZlG+RsCfRkGXqaWT0uKZba042lygFXxvFhQtxX8GuMI2+jo0OZIdDWIkYdYtFjFE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39840400004)(396003)(366004)(26005)(16576012)(54906003)(83380400001)(316002)(8936002)(2906002)(86362001)(186003)(6486002)(16526019)(66556008)(66476007)(36756003)(478600001)(31686004)(5660300002)(31696002)(8676002)(4326008)(2616005)(956004)(66946007)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cuYY1Ohl7ghOYoVuY4QMfJogwVLAB5AyIls73unaAY+1IZaBHPpBQSwv4UlOXrrC0oumnN+5Yev8PCSqEqZnx+d9RTnx7L9lb5RkidVSv/5Aqt/nr2rjzXJEzFCwwXpYgQBSbTOiSsMwCBpw0yBZ3sFaq00DVN2tIHRIPLOMiT96Zqd7qVUaMgfuelloXNnJ9WKwRK+Tg2QpKODQV92JeantsskA59IyRpXEF61/p56j+4gutox4gnd3S0Hy3p03eVwYWB8XeqakisWLsrc2PuPrJjg0Q/S9d+BCpbqCcRz73WnUV0vkqE6OmQX7V4EFIHTJh4mTaH9LkkhDuc+9YEz6j+dOXDTn0z+erHhtbCCvjAgOfjaXdmVCD6ES6+tZfr85eeLXqdbPR9tgY5LbD+DrkxkppgNyI9womiRnv0YmSBRjuT+GJusDSvq6k0/gT7mF0IdvaDcOu88MgpKFFiv7Sx0ooMsr7AS0v+X61OpI1mEcssIqsORfDeqM/ZFXgXRFpkl1GheUu2INTE+H2eQBtS15QG1pxLMVen0fJRATX8tKw/FbX61jQ/2tL98wBqoduVFY7t7VZdxWWvMdLyIq6usC1HRfcejRZIdRdOmWBTkViTpQ7JKwFX4nxLTYcQfgRjMP/xNQBdD0ZN9GTA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3547a69-3a56-4b85-af11-08d879aa6d42
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 12:26:55.8826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXMfiIge5Jvo1JzK2MMsF5tH20z6u6+I4rinK0Vxs30XQ+CVR9fG8iH7qYnjvLjnm7qa44iNzbKSmHYtYNITH3Mpk+pYjC3k00BRKQaPlZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1780
Received-SPF: pass client-ip=40.107.8.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 08:26:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
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

24.10.2020 12:49, Vladimir Sementsov-Ogievskiy wrote:
> 23.10.2020 21:36, Eric Blake wrote:
>> When checking for allocation across a chain, it's already easy to
>> count the depth within the chain at which the allocation is found.
>> Instead of throwing that information away, return it to the caller.
>> Existing callers only cared about allocated/non-allocated, but having
>> a depth available will be used by NBD in the next patch.
>>
>> Note that the previous code (since commit 188a7bbf94 in 2012) was
>> lazy: for each layer deeper in the backing chain, it was issuing a
>> bdrv_is_allocated request on the original 'bytes' amount, rather than
>> on any smaller amount 'n' learned from an upper layer.  These
>> semantics happened to work, since if you have:
>>
>> Base <- Active
>> XX--    -XX-
>>
>> the consecutive results are offset 0: '11' with *pnum 2, followed by
>> offset 2: '1' with *pnum 1, followed by offset 3: '0' with *pnum 1;
>> the resulting sequence 1110 matches reality (the first three clusters
>> are indeed allocated somewhere in the given range).  But post-patch,
>> we correctly give the results offset 0: '2' with *pnum 1, followed by
>> offset 1: '11' with *pnum 2, followed by offset 3: '0' with *pnum 1
>> (2110), without over-reporting the length of contributions from the
>> backing layers.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> This conflicts with block-status/is-allocated fix/merge patches in Stefan's "[PULL v3 00/28] Block patches"
> 

the patches applied to master branch


-- 
Best regards,
Vladimir

