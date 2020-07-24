Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E41BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027D32074A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uWc6L7Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027D32074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrHN-0001cn-8Q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyrG5-00012D-0Z; Fri, 24 Jul 2020 02:32:41 -0400
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com
 ([40.107.21.101]:39201 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyrG1-0007Tp-9U; Fri, 24 Jul 2020 02:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB5iUrkNNPgUxXRGa9ng9yhwlqDeYy4wnb/MFNtsPKlVg10rvqsD03QenkL5qN+1BHn6H/ezWulWvnvCyn4/7yu53wyK6fMpfA0edlqbIsKdTdXqpMF/vWInoOwy5adCCqc0h0Fe//O69D3YfUDlqN+wvMiIQAiDMKf5hODbw6gXGLnL3ZIEmwaQscMjViUyncfz5IS6D34BsTegIC3i4hvmUw53ifvy6i2UxrlwRKvpOPKAT4KSHZLpbJDFIlFiVsJWD9Am99xnzs15df8JR0mOZJpTSFPoetWoVxbCV5/7XynRDP4/STvd318PHfovE/L1EvUX8g6t1xdmEGP0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIrHDAST5QxxzKTQBqxakAJ8x8Qjc+YCbtXFq7byv+k=;
 b=aFaI1lwj6Lf2nUm3rW/te8g2lu1hfcHI8ZBY/qO5vzamUL3rUzANykvS8jWXd5j8la9THkn555lINOTxI+6HBz+NKG6rsufDfuMJRJf+IJINQ5BMvgbqP7nhPQO03ej3QEP0Fgcz+KZ3wbEwsXmQKxY0FUvKoLTEj+F8bNX4cLsQWqBuCjlhrAT/Jdzcv8s1MGqEgK3bbwQ7I7/Ozn0AU9I1f/b301udpzGrDxpZvmgJ7by9fQbtJ5fL3bOSMuElSeZH/ztOLuTeqra2UjdCY83SK1TNrnHQGbdvLzBVyxsny0WHDdvFIyce42AePLVXtTCVA4Tl3kIjLvthcCvGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIrHDAST5QxxzKTQBqxakAJ8x8Qjc+YCbtXFq7byv+k=;
 b=uWc6L7QaHVxmZis3sv8/m+aNkDnLccb7iTpK0/HERjRO0ckTeSxT9lsC3QEMicdNMnzpnmQvA0bmRHXSiwZJQU4PzXC83SSToD8CvVwTr2PQVbqQenx9jQ/3085kaH3u4dKG65bNZN0EOK5NWhi4Ig+jbQj7NufDffX1vp0tQ2Y=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 06:32:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 06:32:28 +0000
Subject: Re: [PATCH v2 12/22] qemu-iotests/199: fix style
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-13-vsementsov@virtuozzo.com>
 <c50989d3-462e-003d-24b3-29b6fe4d46ac@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f1191fff-23ea-2e41-195e-ca1874ad7d75@virtuozzo.com>
Date: Fri, 24 Jul 2020 09:32:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c50989d3-462e-003d-24b3-29b6fe4d46ac@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:208:1::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR04CA0054.eurprd04.prod.outlook.com (2603:10a6:208:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 06:32:27 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec98ae44-1aa7-45ab-8ad2-08d82f9b55da
X-MS-TrafficTypeDiagnostic: AM6PR08MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5080AAE8384A5EF88626A7B7C1770@AM6PR08MB5080.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Smbe9/T5h4D4zp5/fif38Ph4BR+1pKLh77S8RNt7nO3o9pyVjgRCYMrGL/YMD4k+gog7HAHQ6BM6Xd+69aYZJ3mi10mztooDQvm+ws/KW38F2qzWopbyjJ9x5LVkEZpS3Fr3bGE8qvEluxav5mzKMgscKX4xys2gdKravICHsYSSYMwt7Ff20URUGkTpH81k2dWd1sPkuUweb8s46EAZ7t5+8BAcrXA0AdEkJ2+lv5BT27vpNFXqNkLvlKuNJITZxpN3oL0TIl0CKcmxd1GtJrjDSKphqS32z3SSnWIueFhV5Xs/G5dSgw9UrOf1PiNvejEu7Ho2djQqPT7V9ZE8Q4XZ5hp8nCWGJnH6V+WKJiYtC0llHKXLKr2uF2cB46iA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(396003)(346002)(376002)(366004)(31686004)(2906002)(26005)(36756003)(53546011)(107886003)(52116002)(5660300002)(86362001)(6486002)(66946007)(8676002)(478600001)(83380400001)(316002)(8936002)(956004)(16576012)(186003)(66556008)(66476007)(4326008)(54906003)(16526019)(2616005)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fL2yljuGifSberwseaNUKpX6RwEr/d1uiWUOTaMgXQBSspgSLXYWDUjj+KVZgpQZ+Mrtfx8Kw8gG65M/Yy1L93wXINNkYOaVkJlyZmI0PQrRHr7Xu8cexBmEnOzjJgZSLRdepRhN8UDYM+H3fQLMESY4+HGqbLZYpxhXyPl7xh73qAElm8aVfn6RcWhNatlwyuX938xJDfgt7j3nQ1l/byOUh7hdmMO+jaKKITmf+4W+vRYgap7MoA+jKGeWFIwl1Pz1aj+XSx+DhcpNWqaNNvWo9RJPpR8DbyIfRApKUBJeMkKl42XUQ+lkD4srAWlTgwExuQnkF8FKis9hF9bqF4TSdHDssgHvCAovDMHE9weL9BgeUfc80Y9Hx0yFp6PcxFIkvQ9wqJWkRrCg4vjrCig+HJO9Thz1UQFoUjEp1M7YL9EKPiOLlKYGdM3FuifrnUfyg4//ico71McKBebx2YEPe7JlYmgGm806L2Yqyfg4b7VIuY2GjwuzugGH3Lq+
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec98ae44-1aa7-45ab-8ad2-08d82f9b55da
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 06:32:28.1380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFvfH53XMiU5N8PLVYlO4JyNaqwv+E6yERa3pikcu//DOHKdGp8qF82tn1NdWDoB7PUPTJ4cnTRDtXhtrWqug/SRYk29rFSFHmxFt0GfZFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Received-SPF: pass client-ip=40.107.21.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 02:32:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Max Reitz <mreitz@redhat.com>,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.07.2020 01:03, Eric Blake wrote:
> On 2/17/20 9:02 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Mostly, satisfy pep8 complains.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/199 | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> With none of your series applied, I get:
> 
> $ ./check -qcow2 199
> ...
> 199      not run    [16:52:34] [16:52:34]                    not suitable for this cache mode: writeback
> Not run: 199
> Passed all 0 iotests
> 199      fail       [16:53:37] [16:53:37]                    output mismatch (see 199.out.bad)
> --- /home/eblake/qemu/tests/qemu-iotests/199.out    2020-07-23 16:48:56.275529368 -0500
> +++ /home/eblake/qemu/build/tests/qemu-iotests/199.out.bad    2020-07-23 16:53:37.728416207 -0500
> @@ -1,5 +1,13 @@
> -.
> +E
> +======================================================================
> +ERROR: test_postcopy (__main__.TestDirtyBitmapPostcopyMigration)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "199", line 41, in setUp
> +    os.mkfifo(fifo)
> +FileExistsError: [Errno 17] File exists
> +
>   ----------------------------------------------------------------------
>   Ran 1 tests
> 
> -OK
> +FAILED (errors=1)
> Failures: 199
> Failed 1 of 1 iotests
> 
> Ah, 'scratch/mig_fifo' was left over from some other aborted run of the test. I removed that file (which implies it might be nice if the test handled that automatically, instead of making me do it), and tried again; now I got the desired:
> 
> 199      pass       [17:00:34] [17:01:48]  74s
> Passed all 1 iotests
> 
> 
> After trying to rebase your series, I once again got failures, but that could mean I botched the rebase (since quite a few of the code patches earlier in the series were non-trivially changed).> If you send a v3 (which would be really nice!), I'd hoist this and 13/22 first in the series, to get to a point where testing 199 works, to then make it easier to demonstrate what the rest of the 199 enhancements do in relation to the non-iotest patches.  But I like that you separated the 199 improvements from the code - testing-wise, it's easy to apply the iotests patches first, make sure it fails, then apply the code patches, and make sure it passes, to prove that the enhanced test now covers what the code fixes did.
> 

A bit off-topic:

Yes, that's our usual scheme: test goes after bug-fix, so careful reviewers always have to apply patches in different order to check is there a real bug-fix.. And the only benefit of such scheme - not to break git bisect. Still, I think we can do better:

  - apply test first, just put it into "bug" group
  - check script should ignore "bug" group (unless it explicitly specified, or direct test run)
  - bug-fix patch removes test from "bug" group

So bisect is not broken and we achieve native ordering: problem exists (test fails) -> fixing -> no problem (test pass).

I think, I'll add "bug" group as a follow up to my "[PATCH v4 0/9] Rework iotests/check", which I really hope will land one day.

PS: I've successfully rebased the series, and test pass. I'll now fix all review notes and resend soon.

-- 
Best regards,
Vladimir

