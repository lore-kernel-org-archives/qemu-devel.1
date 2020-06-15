Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6E42068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nonterra01.onmicrosoft.com header.i=@nonterra01.onmicrosoft.com header.b="wthxYZZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6E42068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nonterra.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjdF-0007lQ-19
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jkjcC-0006Iy-Fz
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:33:08 -0400
Received: from mail-db8eur05on2046.outbound.protection.outlook.com
 ([40.107.20.46]:3296 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobias.koch@nonterra.com>)
 id 1jkjc9-0005Zi-A4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEa227I6oX/egZNNXOHHZbKM5nZk7GZ/vt0MDweKrB9FxPeuBGkFbswYcma0Ar7fKxLJSMGhIjgZH4kGJI7m615LmpmfOyO+adkXmMBoRiAcjZH80ibU2pRIpoJNL8NZzC6U0ysPEpRM+mlXcmlp8BSeJHze5d+xfwp9jdioKD6SfuXig6YnPNY8sCUoUIe6fvH6/mBW3/Gpp8V3+UwRimoUGIsIldTkvxpFM7AayTX1d+fp+0NPo2KeMpZSwDg8ivSf5wsAFU6T0kHu3iQGgJUcUafrNw3lLKVIbssKwyMdklVUYaVFGY6XAx26LP9j9AGUtYsFd4uM+LX0azJzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=panQL4E8m4XVqvLWJHLRbRtr1lrzct1EXCUXWf4ordI=;
 b=jrB3egOyeB4Ba5dJ5PgntVvi/eCyPr4mMVhn1SwQLePh2ac1OAT3NgHsRLPQDRK2jnXFUSdX+RY/ehTuAVbD0c4U+6M/tjSA0N7XO4yvUYlb5SCX2pcCE7Dm3MzUtQTx+CaAlDiBiFkLaLEZ1fQ6pfqF5Hq5pUOD3ICsUXNXbOe7KVGmmF6v2SY5sVHP0w6GWfVM25HhShRw7ylhYVSQyMeoftPfM/7piLL7C9mEGgdpp4YOTqMSZOHbNx5/g51lHPAXxoaV261Ym8Jsjgc63vmT6QhlAxc8B9aZNp6FS2asAClePae2/2XWSGHB67bAuTfw1DDz3YlhvyH35gEHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nonterra.com; dmarc=pass action=none header.from=nonterra.com;
 dkim=pass header.d=nonterra.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nonterra01.onmicrosoft.com; s=selector2-nonterra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=panQL4E8m4XVqvLWJHLRbRtr1lrzct1EXCUXWf4ordI=;
 b=wthxYZZI7Uwz0JI2DQGj92zQYZdlMVlO2lgm9noD26GSADwZ4sCJ78utzhNoUGIpEoTQ+ldWMMOrpqz3AHokLz0IOXSPn745f7KNrb6RJfMRhCzc4jMii8oFp9pEPS8oWAamtF6lzSDjSyCmn+nIzWY0tXs9WEjtO7XFR2hdb9U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=nonterra.com;
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com (2603:10a6:209:41::10)
 by AM6PR08MB4708.eurprd08.prod.outlook.com (2603:10a6:20b:ce::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Mon, 15 Jun
 2020 07:17:59 +0000
Received: from AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055]) by AM6PR08MB3302.eurprd08.prod.outlook.com
 ([fe80::c484:b59d:1164:8055%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 07:17:59 +0000
Subject: Re: [PATCH] linux-user: mremap fails with EFAULT if address range
 overlaps with stack guard
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200305210534.28392-1-tobias.koch@nonterra.com>
 <d643f0d0-d5e7-d1f3-d3e2-7d62661774e8@vivier.eu>
From: Tobias Koch <tobias.koch@nonterra.com>
Message-ID: <3c9dffdf-b4be-d17c-730d-5a65665b3eac@nonterra.com>
Date: Mon, 15 Jun 2020 10:17:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <d643f0d0-d5e7-d1f3-d3e2-7d62661774e8@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: GV0P278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::28) To AM6PR08MB3302.eurprd08.prod.outlook.com
 (2603:10a6:209:41::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.181.119] (85.203.15.71) by
 GV0P278CA0018.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 07:17:58 +0000
X-Originating-IP: [85.203.15.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89932151-1bfd-4c01-dfa4-08d810fc3b76
X-MS-TrafficTypeDiagnostic: AM6PR08MB4708:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4708A64C8124FC6BF8C2AD28899C0@AM6PR08MB4708.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ryrG9GNVQ8Z+fyVLLwEcFo0pvR5+PMNlIOc4ualpBhDhMoJm1Gn7wj4TJ8Yw/tuC7HHYUIqBa9CBNU1c6V7zGJ4NAA1lh4X9ol6OtK6aNhxsp/9ypTq5LsIq5++VlH4xmBHGoVLt7JD2G0v2FCF061VvwsCHyHnsvlj/4TZg/RtnB3xZpepMnXc+5E9KUNhH9MbwbMe3DhsNtRwG132Uf6bZzDkPrJbcLRbucYqva49zeK+KZh16bxTki8aortoAg9lxj3FljhlCEQGLjL2nP63G85xMGwjaes/arVOdJ8Djyi48YE+yfLlkjKIhgJNd77za899+y8eYqvhmHtMXhLTw4Gkv72DXBL+37WlxSxuyTgDP1a2G0lyH/I+8sz8+IvMDfMFqTFQMZnPBwwczBS/sGiW4u/0lSNwO6xr4rYpUNqLZwsmPrNJzEHmSBxO2pg21g8937FPTeweihWlPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB3302.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(346002)(136003)(39830400003)(396003)(44832011)(2616005)(956004)(52116002)(16576012)(316002)(83380400001)(86362001)(508600001)(53546011)(36756003)(5660300002)(55236004)(966005)(8676002)(16526019)(186003)(66556008)(66574014)(31696002)(31686004)(2906002)(66476007)(26005)(8936002)(66946007)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lHHWoqymh5HFc5YNFPtggXqbBH0Um+gq2iCRSMcwAFcV9q3iPEE3HmtZTmzhffEQ3+xNSf8kLa3fFzXBPUlsCsYS4tl5SOo3s+bwcKsld/fl7IQsPZDu9o741Y5WGXAutNv8X/PCRpt4QNzFGtT1uwxj25eFIqTk2SSQHRxbrUWQ96PfS+4tYu3sLdYhevlwAMIob8cfZz4TtDviHpGWUSkHVwf1wjueTVJC8iFlcVpbTKZOOjhJ1zBd+By2KYMMHF2cBXwn0dfPN4af78FTC4391nkPYPDs1uZK0F/3GhxOPaJr5klKeq8k0HF+aAlKESTpyUU+yqoue/UJUj8Xr7w9QA1v1Z85U4IBGYIBy9TeUf98LpFYxMcd4VxtE8yuZ4ynFn0qWWsi2vZ8uZ5VedtxFgU00mrlxuL6dpRwsMrhJAhpxl5IzA58A0JENFzkaGzdotM3fRWLzqAJJ03PZ3cbmeRmxVEWcgn8IhGoGrs=
X-OriginatorOrg: nonterra.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89932151-1bfd-4c01-dfa4-08d810fc3b76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 07:17:59.0143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 76ec9478-ab84-4eac-917c-c1a3242376a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Re3RPlJHPHqORCT9ebNlyaJIUmXKs4+FLyoqgmsxJaV5/y41wZ2PWEr4HYSIIt1hKcacQie/iXS+wvbEkD5vU6lvMePi/X5p+s4bTnhQdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4708
Received-SPF: pass client-ip=40.107.20.46;
 envelope-from=tobias.koch@nonterra.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 03:33:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

the code in musl libc probing the stack is in

    https://git.musl-libc.org/cgit/musl/plain/src/thread/pthread_getattr_np.c

The setup in elfload.c does work, but only when reserved_va is not set. In that case, any stack guard violation is
handled by the host kernel and thus results in the expected EFAULT.

However, in case of e.g. a 32bit target being emulated on a 64bit host, reserved_va is set and the current code in
mmap.c will only produce a more generic ENOMEM, deviating from the kernel's behavior.


On 5/7/20 5:35 PM, Laurent Vivier wrote:
> Le 05/03/2020 à 22:05, Tobias Koch a écrit :
>> If the address range starting at old_address overlaps with the stack guard it
>> is invalid and mremap must fail with EFAULT. The musl c library relies on this
>> behavior to detect the stack size, which it does by doing consecutive mremaps
>> until it hits the stack guard. Without this patch, software (such as the Ruby
>> interpreter) that calls pthread_getattr_np under musl will crash on 32 bit
>> targets emulated on a 64 bit host.
> Could you share some pointers to the code that is doing this?
>
> We have already this kind of code in linux-user/elfload.c,
> setup_arg_pages(): could you check why it doesn't work?
>
> Thanks,
> Laurent

