Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D310BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9864A2076B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H9GZWFIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9864A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Pv-0001Nl-OV
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k59PD-0000Tg-AS; Mon, 10 Aug 2020 11:08:07 -0400
Received: from mail-eopbgr60127.outbound.protection.outlook.com
 ([40.107.6.127]:58176 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k59P9-0004Z7-Vu; Mon, 10 Aug 2020 11:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9tccX7G6gYclVD7mPCrsQoW593y0/YMTWZKDjII0p6BH4nlmRXbFBfAN8xUdS5xpQ+em2Mi9bgRJ3owIgxHstSemJ3O6EoE3vCgm/uWBZRip5g6QyDTIEID9oD0V3wkWG0jFz4EfwMdr9qeeo7eppRcohc/xqUTIUZT+QIDNWDxSjLhUhU2JHtgeNAfs9NUzgGDG/2PS0CgWN6wL3cQrvkUIpstZhbXJrOvxCXqpEtdBlvWPktekGM15AStnE2i+Tc0acrW+7FRl0newjgKTk+N2fr4IoYUW0PgBTZw0E8ZSLYBMczBJxeG0b//fl24k0YSrdJXhTGfqrKKJa654A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkRjROkfwD/MMFSzb2C4li2LP3mmB8BxcuVcp+mnm1s=;
 b=kjeB9GrOPRyXUEYYizy0zAPhWKrexYWqEfqOHjZJeiby+z2JwiVuVpG4q1NrmmMETYGxtN4qvNW3mTsyVvV9R1HDdZpWtSeVJAlL1qK3auBSJHN9jK77x/buGWVR/TWtrfa6LAPo6nUcKnaSE8szln3VHlZkt50IUbZrNug943Wx2K6oMJTu+0desauACGX9w2Y4JONeTsQK/1gs7zem5LLV8m0E3S6xJ6K+kr92q1BHZT3WzSKaooQ67RRjJYhp8qCxNBjkkOGDmcpVNvU0aGpgmXwgRusRNGWkaLndS2S7XhAwQakooGQHcpzA8ELTuhqtzDOb1Wch6Pq1YOYVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkRjROkfwD/MMFSzb2C4li2LP3mmB8BxcuVcp+mnm1s=;
 b=H9GZWFIFsWeJJ72QRemPh+MMZj3vveuwdeutPEzAT5hepLdBNoKet3VtMcDISUBOX7iRqJpqXRnLSaARlSa9w+u8za6SGHRAHBJ2ZAi3G2/+MxXtyCBscNlc2DvrrIuFOYnx6PAXI9tpoawBtbeDJFBV01Y/0y4svpWSauJr0MI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2419.eurprd08.prod.outlook.com (2603:10a6:203:a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 15:08:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 15:08:00 +0000
Subject: Re: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200810123555.30481-1-den@openvz.org>
 <d01f2684-e17e-c1b9-1e43-3b6ff57ddf10@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <433af02b-e577-05de-2824-16cc6f736783@virtuozzo.com>
Date: Mon, 10 Aug 2020 18:07:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <d01f2684-e17e-c1b9-1e43-3b6ff57ddf10@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0076.eurprd07.prod.outlook.com
 (2603:10a6:207:4::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.170) by
 AM3PR07CA0076.eurprd07.prod.outlook.com (2603:10a6:207:4::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Mon, 10 Aug 2020 15:07:59 +0000
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2a70e1-de06-4c54-9575-08d83d3f2bbf
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB24192C343A60293D2DCAD3A5C1440@AM5PR0802MB2419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxF8GAyYeqmU81qcgHS3q801wptocLAgu4aljexV8E9/Nc/InjwHndt3Y13VXKRxBhnbJ3SwuaSELgqgJhqdmG+FPlsBcrbGaFzL7EiJnMD4Day4YoHVNfmAiXAEOhK2mBAe3qiaMi5hSTkxM4pJaUYP2Q5FqqLdPiOYF1P+36S0dGC10xBftO5HKqOvf9mP0i+XyZlnqhPkjAuoWwp1GCF3q4MBpeHbmR98Fd/xm0FooUK6k6dSadhA9rQBwKIPjphwIO2h/ht6cf97u9SE6dw4Jtoagkw5rAvNZPQVgQadMc5MagFsgNVPwW+xhwxEjOyNvGy54pgSC9rwBlToz1Dkj1U4y9P3TNoHh8gtxj1hIDUKpr+wggaIPziKWP8v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39840400004)(136003)(366004)(107886003)(2906002)(8676002)(956004)(2616005)(31696002)(83380400001)(66476007)(53546011)(86362001)(31686004)(186003)(16526019)(5660300002)(66946007)(26005)(66556008)(110136005)(52116002)(8936002)(478600001)(316002)(36756003)(4326008)(6486002)(54906003)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 78MaxHyRD360IDltX+P0GhK4IgDo5hi/6k+iokjjwwF1WCLVB+J79RXYi2qji3TTTa7dBp385jlUcXjox6un3YnPU0BJynj8Hm8dKes9h46A6rnXtlc6bhocjAoUqxtbU1hQzuSA/LxPJN4fFBtZ8Mq+5jmpTQ1wt7jXDOsvpB8ym5JIkpRLn2C7XMROJaJF86+TbvBodw0H7W88VoTrUtvBk6JH0xqQE9uIRkYyJio9Ce8obKibIBb0G2SNJQUmWr2xPD1N9xuvLG2J1C5ZMLhS0fV/kyGZeVp9dSCmiaS+8kisEy9A0JvoYj668IpxcoP+Rr5xhHblroki5DfhPoCwXEMHtXzpaQLB/K0g7Q1oQAOZTXlJKnP0pVYzVdbd+d9CvuF72S2gZpYLFmXWu49gahRUO8pmo7L5vy4BGD53WlRYRSo3XozWR3nHaz1ICGfCLgBTrluWskMhxcxgMBuG8krVPvBdmaBoxO58QEAECBOQgCVnyZVDAUe6Qz6qYI9D3rXhY+qv/Hh9tFXUc4vVKmpu9XI2kLN2QrIDu3hI0Z9i/USjuiqA51yxk+KQicNBlYOpOWmioYU+sjijh3iJj6JAoDwzZ4NxcolBmCli0rScH9vvadK6WmRAUAy5zmhPo7jObnwBOkoUwa2+ZQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2a70e1-de06-4c54-9575-08d83d3f2bbf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 15:08:00.0389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0j0KO9eJ0wxDL1G+veDfPypK0qPu0kvJOt0wIhXxv/bJ9QYx4NUSx6YNrjwFq5d314HcjiaGyYtSKGr0wlfJtJVc0OsbkUxQEJefhrU6bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2419
Received-SPF: pass client-ip=40.107.6.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:08:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.08.2020 17:20, Eric Blake wrote:
> On 8/10/20 7:35 AM, Denis V. Lunev wrote:
>> The problem this patch is trying to address is libguestfs behavior on the
>> appliance startup. It starts supporting to use root=UUID definition in
>> the kernel command line of its root filesystem using
>>      file --  /usr/lib64/guestfs/appliance/root
>> This works fine with RAW image, but we are using QCOW2 as a storage to
>> save a bit of file space and in this case we get
>>      QEMU QCOW Image (v3), 1610612736 bytes
>> instead of UUID of the root filesystem.
>>
>> The solution is very simple - we should dump first 256k of the image file
>> like the follows
>>      qemu-io -c "read -V 0 256k" appliance | file -
>> which will provide correct result for all possible types of the appliance
>> storage.
> 
> Is 'appliance' a qcow2 file?  If so, another way to accomplish this could include:
> 
> nbdkit streaming --run 'qemu-img convert --image-opts driver=raw,size=256,file.driver=qcow2,file.file.driver=file,file.file.filename=appliance "$uri"' | file -

This adds a dependency on nbdkit streaming plugin, not installed by default in our RH-based distributive. Probably the simplest thing is just create a temporary file for qemu-img convert (or dd) target, and then call file command on it.

> 
> which says to use qemu-img to open a length-limited view of the file, and stream the entire thing to an NBD server, where nbdkit then provides a way to convert that to a pipeline to feed into file (since qemu's NBD server doesn't directly like writing into a pipe).
> 
> I'm also wondering if the 'nbdcopy' program (not yet released in a stable version, but available in libnbd.git) could be put to use on this front, with some way to quickly combine it with qemu-nbd serving appliance.qcow2.
> 
>>
>> Unfortunately, additional option for qemu-io is the only and the simplest
>> solution as '-v' creates very specific output, which requires to be
>> parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
>> much more intrusive.
> 
> 'qemu-img dd' _should_ be merely syntactic sugar for 'qemu-img convert', but it isn't yet.  Until we rectify that feature parity (there are things that dd can't do like better output control and skipping, and there are things that convert can't do like length limiting and offset selection), hacking up 'qemu-io' (which is for debugging use only) is a tolerable short-term solution; but qemu-io was NEVER intended for stable use cases.  If adding this makes debugging qemu easier, then go for it; but if the real problem is that qemu-img is missing functionality, we should instead be focusing on fixing qemu-img.
> 

Thanks for clarifying this!

If we are going to improve qemu-img at some point, I'm not sure that convert or dd is correct places to do it, as they want target to be a block node. But how to create a block-node on top of /dev/stdout? Detect it and behave another way in img_dd function? Or may be better create another command qemu-img dump, for dumping the contents to stdout?

-- 
Best regards,
Vladimir

