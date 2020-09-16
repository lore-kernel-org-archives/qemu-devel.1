Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C7AC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E839D2255F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 16:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ka2nRq9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E839D2255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIaCZ-0000JF-UH
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 12:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIaAo-0007gH-0O; Wed, 16 Sep 2020 12:20:46 -0400
Received: from mail-am6eur05on2098.outbound.protection.outlook.com
 ([40.107.22.98]:48441 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIaAj-0008MV-IZ; Wed, 16 Sep 2020 12:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyJJBXQvLpRoG/PMDkS1jjssHwYpzAHLhyaFNULguENMpm1V6U37rLLyggMpT55VmpCRM1NPvUZrFHK/6TQLg2wolvoxJRyc7GRU23x7P0btikUlrhR6wOk1HcLgTe5Uk+dSf73bbElMl+P8bkt6Th6tGNImpt8E8hSpDX5utvl4BlfcsenS5sd4l03N95dDTnEBav11BeWjUsfHk8ztqEnl6Jkel0BplTQ1j6LII1n440cH0ZM2FGQ1diLaG2qET7p65avF7tKnTGBGDpLdCh2kdam4UfvGSm2KdFgyG1kvdUlQRJPc+xUoruLIdVHwTp9sQnZCHbEMiigP2q0slA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoHy/i0ZfTfPriW9jTQ+gXH3l1i5kPX7d9dUYCVAm+E=;
 b=Pb4pV02zK8GTS9aHYtqdeYnAq1JWyuidGrDrqCdSTAp1YIOomVnFdyQ/JEyX3WLp2fCghw5tl9GqSGNizSCwcP0rgV9pQYLLCnOjMCb5K/HyedFLgNhqYsqMhhEYpPikhK3HtsN5ev17KF9OXLv9mAxSJCTk7fNjc55cXGT56Q4taQy1/GWZdDoZqRnTLbWiqAHh5gzou7SwcpXHRCGGl0PBbmwFfpvNgNX0CuCygEdTzLZ3wHYB0RGxsft+o4OoBL9k5DZTpgm9UsbeyWSqsDBS1aCv2I7Axz/zI+aSq4XKJG7R8ek2oVysuxTPbR1E08vcr36kuu+1m/L9EFTMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoHy/i0ZfTfPriW9jTQ+gXH3l1i5kPX7d9dUYCVAm+E=;
 b=Ka2nRq9kz2Io++1sPwdTqJQpHTpXUWvksFrYEqwaiCtH9WgB3gGnyr2MEQB5LT06DyMcd5B+nCC+TGSgao3Y1QuMWwBr6EWRQIBRsMjbqGxD/fKtRZkC3dguBAInMeR9EDxf/ZrPsfyHrKl6e9+8p0Nv4uvy/JiMWHNKtGp42+g=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 16:20:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 16:20:37 +0000
Subject: Re: [PATCH v2] qemu-img: Support bitmap --merge into backing image
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eshenitz@redhat.com,
 mreitz@redhat.com
References: <20200914191009.644842-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2214e23a-17b1-dda3-7f05-dd75c180fcba@virtuozzo.com>
Date: Wed, 16 Sep 2020 19:20:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200914191009.644842-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 16:20:36 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c637d232-78d5-40ce-93a6-08d85a5c7229
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905DC1FC7A708A445FD92AAC1210@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btQDB+/OGPZjAeFX4LI8OUBeFZ02JGN6MvEooEYdAM/80rM6Pg1H4nQETyX28l/F9sMlkX1MfVLr887zDgiFXfCtq1pqRRfeQHCxKCpDXZKRh9PcxjZWABGfeDVIXe7fIOZVETe5f6Dj/o8ynTWOAU5w4Jg8bNp0oRlE/vpxv5YmxCYFnuJ/3adcCvo3kiBxOdzlok61uwo5JE8O2XaLqeyRD7k9O/7f5TUBAJNR1cvHikITTBF39jSQXlt5juLThiijAAfHTE5QEzjvqI3TVMVnBSOmkrfA65+LoFZx6slaqvymMmBuowwwGy940iQerOVu8x8RINkqmZCgug3tJLNvVFzuUCp6Q9ITcvj3ohTsfFUtuhJjJ/UBrzk1ik7SsyCuMDmSi6DckrL+6B+sQk1N9g6qhK0EvIrAkYQDh3eYzDhmSzFXfOo2HeOG1prPKSIWz82bRbkUvJDLLvNVl/dJ5mXm6rGpy/4yDqioD5jNfyx8TLwgY+9B2P4KlmzFw03YzqOq5asXoUygwVyOSEhG7vHciHtTZfytnxndSsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39840400004)(366004)(136003)(346002)(66556008)(66476007)(66946007)(5660300002)(8936002)(2906002)(6486002)(2616005)(956004)(83380400001)(16576012)(186003)(8676002)(52116002)(4326008)(316002)(31696002)(478600001)(26005)(86362001)(31686004)(16526019)(966005)(36756003)(43740500002)(16193025007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UMEc9XmFj0KvqLo1J1udaNcCuWhfQKX26zqufzX/utdlO4xzaIK+anKUqNdOTZY86Uu0lzlJZ9xJHQyFIWEZpG5S5QKtuLN727vlTGIeQr5DucYUAQukuyM6zMkGdM4jC3y1/N7U5d0o0VKfX9v/vEir+yJPpL2Vklgf8SfvbjNVOcHr/fE/awGjT80K1WVRJ4BHZmuNo8IbTZ1mcof0vZno4bwsA3FkPYPpvFZD4AEesjSD03PCGHNDOpOyiEq4bhJscjtAokDPxlhRw8s0kH6Nl6bspJhBsWJwpo5ilJbGZGdIvTJEOpq3tBqgDwKyPn6NUcd6d0Z2ZWim4jSbpox3pQr8sFi2FfDvvaRDVKFYgMhoVdFDZ2G1SkIypb0odBwYUrj9h0uUrgytYJY7kxDxnk/gnWhrqRBKuUEObEotw/n5AoYZoF+g44X0qjMikBGDXEmOYIyAOkhyO2k0v7s6ZcY6xZeKmUZsdMDAwuR2UJxsAAiIHMy+G49BKi3pG+oQzLUZBMdHzgQePP3VIV1HMAV3B8840wZKeOAEPNHj1gwNA9B+jp2AXsr8an8YPI07UviXcl2SbrbmskT5rRkjU6e+8XAKeCD6QfPkQVVs8rQtGwtHaqPGlonbl1M6mVIVXLMAAW6FnPuVZ09DmQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c637d232-78d5-40ce-93a6-08d85a5c7229
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 16:20:37.3466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0zG3/t9OeCaAOiBkEd+nT5cxw+9LWGXPsvZUHVutoACKnZqXbnntjPEBeEYJ4kZhTIODxNQF/PvZR4xiHFwx5ts1avh5e6nzfcLLyGX/n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.22.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 12:20:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001,
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

14.09.2020 22:10, Eric Blake wrote:
> If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
> bitmap from top into base, qemu-img was failing with:
> 
> qemu-img: Could not open 'top.qcow2': Could not open backing file: Failed to get shared "write" lock
> Is another process using the image [base.qcow2]?
> 
> The easiest fix is to not open the entire backing chain of either
> image (source or destination); after all, the point of 'qemu-img
> bitmap' is solely to manipulate bitmaps directly within a single qcow2
> image, and this is made more precise if we don't pay attention to
> other images in the chain that may happen to have a bitmap by the same
> name.
> 
> However, note that during normal usage, it is a feature that qemu will
> allow a bitmap from a backing image to be exposed by an overlay BDS;
> doing so makes it easier to perform incremental backup, where we have:
> 
> Base <- Active <- temporrary
>            \--block job ->/
> 
> with temporary being fed by a block-copy 'sync' job; when exposing
> temporary over NBD, referring to a bitmap that lives only in Active is
> less effort than having to copy a bitmap into temporary [1].  So the
> testsuite additions in this patch check both where bitmaps get
> allocated (the qemu-img info output), and, when NOT using 'qemu-img
> bitmap', that bitmaps are indeed visible through a backing chain.
> 
> [1] Full disclosure: prior to the recent commit 374eedd1c4 and
> friends, we were NOT able to see bitmaps through filters, which meant
> that we actually did not have nice clean semantics for uniformly being
> able to pick up bitmaps from anywhere in the backing chain (seen as a
> change in behavior between qemu 4.1 and 4.2 at commit 00e30f05de, when
> block-copy swapped from a one-off to a filter).  Which means libvirt
> was already coded to copy bitmaps around for the sake of older qemu,
> even though modern qemu no longer needs it.  Oh well.
> 
> Fixes: http://bugzilla.redhat.com/1877209
> Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

Honestly I don't want to bother with carefully checking new test output, at least I see that it doesn't produce errors:)
Code change seems obvious.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

