Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE145C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC87208E4
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="B+qa5jWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC87208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWGE3-0007Jd-GR
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 05:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWGBS-0006Gr-Dc; Sat, 24 Oct 2020 05:49:58 -0400
Received: from mail-eopbgr150125.outbound.protection.outlook.com
 ([40.107.15.125]:28549 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kWGBP-0006Hj-K9; Sat, 24 Oct 2020 05:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDxzzt8l13LjnbcZkklLg7zGEWLIR54zZ9VzlEErFM3Wi46ptEwYCi5uSSTPZJrIZzJ5gr/d2N1qb+fnWSUqCtTBIpBWN9QlRvUeHT+LTLNa8/OPxUp3KvOwtoBU61xlWG5ChGuYDD+7UrqGLKd7PNZQaSmgyB8MLFGPj46ODdC2xAomh5+zkkHZ/D2iiZcDJLHkIl7Gl9CtmxBSXFCBGWwCHd1if0pita2E4PJ46ajr05V+qoEjgtIwd3Qrv8ldmcfj59KKmi/4g9TjyMSlHydU6ssGkv5fA9KbUjgKPHYXSJmtsO1/sbZASf8LkG9We8mjNgYb6z4GewB1yE6JaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1A41P6xE2uuHZuKHGOxv7rpNVK8f3hr76HrCd/wyh8=;
 b=fyCowsJeZVW/HBxoydGsbJjhVchvng7eb/SC389ECRKsUnlaIj0dh4qQMORY/7pYyQZI66FzaSj579OQKHjCSZEiNKthQG7LHsgOWI8TR0xXt9MF/9iPrFJWcHsUjIKa/LXlMZq2C48KlKmtTQS6a7BcO+ymJvkNCfkm2OmLaXdszXBrbZTfGy2uQNWI14R8JcLUHZX0xc6dbLtVjniA8RnI1K3z8KHl8T0zYG4lQt/lTJFvqxKqsTDH7r7tZu2XhWAUBzw5OfVVDHJcLgMjS1Dyo1Ct/lqm7qtAXZTxpZqkKXSK4m3GUnsVWdAmN2w9kWLmrcYXApZikUOVskQpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1A41P6xE2uuHZuKHGOxv7rpNVK8f3hr76HrCd/wyh8=;
 b=B+qa5jWGslD8YiFd4sg28Avgilq3dDxkjZqx4A/B3WIl5KBE6XUVNBXiCZ3qX5pVM5TR3+vfUug2+mBjpJmg1TvkZ3reLxAImFOXbwrLCHGFoW8cIK/A3Np6npjPTkJjGWlH9S37iq2X3AlYQ2zZ+hT9IxdGFJHdj/MCAzRqq+E=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3958.eurprd08.prod.outlook.com (2603:10a6:20b:a6::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Sat, 24 Oct
 2020 09:49:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Sat, 24 Oct 2020
 09:49:50 +0000
Subject: Re: [PATCH v5 10/12] block: Return depth level during
 bdrv_is_allocated_above
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com,
 rjones@redhat.com, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-11-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <caeff8a0-a4b6-0835-27c9-726cc8f94304@virtuozzo.com>
Date: Sat, 24 Oct 2020 12:49:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201023183652.478921-11-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.99) by
 AM0PR10CA0085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23 via Frontend Transport; Sat, 24 Oct 2020 09:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dbc844-f6ae-4ce5-3af0-08d8780226a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3958:
X-Microsoft-Antispam-PRVS: <AM6PR08MB395808B91D9A0B5DA9D5179FC11B0@AM6PR08MB3958.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFETYoSGCn0j3U1naGEMAxbDFOgmWo2mf0N1J96JqNhG2dSHc5UYryoWcZ8asZQS/vLyd2bGYsxvjcnK7r0NMDtx4LCyfR6aE6R64zYZAyI6Tah7ykMTqjQ6BZSFCC/rwEY5XKLKO1nd0/1Vc9PmeMCmcEGoHmwtTUGJfUbuhRXeEw2E/TlvuirX41ICUBlXNgXYvGml8WevihX3gbYNq7kYLudR5ZV7vmXR9fSrXy6cA+yzotbvmwoCPMLCef6ksLaGI9bfvXcFswCqQ6Sp0GMgqVljrPrhFwGeYAKJkMYZ/Q6m+/SDDzZ2SbJB/keUA9Vp2aYFjLjJaOWU4W1mVqv7+ZsdwI3wNGgntiXY2Z8viC2ufMbPpPxJtSYlwSg6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(66556008)(83380400001)(36756003)(8936002)(66476007)(66946007)(31696002)(2616005)(956004)(54906003)(31686004)(5660300002)(52116002)(8676002)(4326008)(2906002)(16576012)(478600001)(26005)(186003)(86362001)(16526019)(316002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /iCbk9PZP8akEA/wTpMZuevBCalm7FVIoM7OL9iETLNE/ST1noo1pU8TkQloBDO0Pe/y1rEIKXMHPrBFC+grULoq/N2RBDIswbxuolsyajqZJgVyJpg6pzGKggNgxNM7Z1EbC/4/4626s9bB0WNQpyf41/tSWVGa8T+NaVqDWUFaAKR0iHhGsdrgk8UbFr6ccN5v9H/XjInPpDUzb3fHPtyK04uTMM5/+q4N1VSH4Gh80f934ZROoIwwKEJrVnxmwZHaqqeoupGmz76jtTHaqNCUOR6UdBQFBBIq8OsILZOkOE9wn/zpClQ7K/pRI/b4AvxrMK6VRD1yvYNEvdh0403/pnFVjmC/kyph9QNEdwe6ppt6MminiKJtBZkOqssF6wlMsnL0y438UUomUa1rlW8a6ob+CdJz4JGkXqVnY8JeiPRcp7gYsfR+VckBBkB63gcVcRQRq8oq1Ny4xkyarwZIPp2qcp1IQPKI0/ZdMGPXyZVEuyFYOe3leEB1fPtObSENQvI/D7Gvu9Cwvur9zQ0ipoQ88jxOpKcj3xHEKy2L3TRQQtkg6rm9wBSvDfxllzBGnj3+5gTC51NfAiyHXynsASw8UlyntAQbfJGs2OI8jh+cLyr85/BRsoLS3e1x5P0FvHZBqYPDYJtp2zIV3A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dbc844-f6ae-4ce5-3af0-08d8780226a8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2020 09:49:50.7837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EVFZzlzGXmzo+zISa9RN0KoY/ArwtPrF6gXNOr9gpixj8H7HYKoRc8CBSb+41rRb5AsmL+Wf7zKHPd/sPoiC48lkslgxhzO9EPNjedhB2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3958
Received-SPF: pass client-ip=40.107.15.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 05:49:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_LOW=-0.7,
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

23.10.2020 21:36, Eric Blake wrote:
> When checking for allocation across a chain, it's already easy to
> count the depth within the chain at which the allocation is found.
> Instead of throwing that information away, return it to the caller.
> Existing callers only cared about allocated/non-allocated, but having
> a depth available will be used by NBD in the next patch.
> 
> Note that the previous code (since commit 188a7bbf94 in 2012) was
> lazy: for each layer deeper in the backing chain, it was issuing a
> bdrv_is_allocated request on the original 'bytes' amount, rather than
> on any smaller amount 'n' learned from an upper layer.  These
> semantics happened to work, since if you have:
> 
> Base <- Active
> XX--    -XX-
> 
> the consecutive results are offset 0: '11' with *pnum 2, followed by
> offset 2: '1' with *pnum 1, followed by offset 3: '0' with *pnum 1;
> the resulting sequence 1110 matches reality (the first three clusters
> are indeed allocated somewhere in the given range).  But post-patch,
> we correctly give the results offset 0: '2' with *pnum 1, followed by
> offset 1: '11' with *pnum 2, followed by offset 3: '0' with *pnum 1
> (2110), without over-reporting the length of contributions from the
> backing layers.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

This conflicts with block-status/is-allocated fix/merge patches in Stefan's "[PULL v3 00/28] Block patches"

-- 
Best regards,
Vladimir

