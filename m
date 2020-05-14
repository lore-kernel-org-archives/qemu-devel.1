Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE53C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C4E205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hOdzvMav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C4E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7dX-00015t-JO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ7ci-0000Ka-TV; Thu, 14 May 2020 02:45:40 -0400
Received: from mail-eopbgr30101.outbound.protection.outlook.com
 ([40.107.3.101]:47940 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZ7cg-0004Rv-GC; Thu, 14 May 2020 02:45:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhlsU2nc500XKr4T/kQe47MQr1aE3WVUELiRdp2BCTV7gRI91Wcif6SSCERzpWRElFLXKeo9UKVqCxIYjNX9jXPNjky437CeIYI6euQcmt3A0VCzae223nkFi9cKFxBWt9lPwQN/8o605FE8ZhQJP6fts4PZAePeATDOHoctdd15A/etO1s2QHqAWH2ql67PhodxGnjKGZea8g+GMSjJ72Dgy5/XCrg0PFWomjD9qtWfRng0wxJ2uy1KPl+WUiGzUhbgkmPbhr5OnProYqdGwrLSYTJhhw9UqjE28dJUwjctSeCk68e6XcLGH91WwtiAp4DilDAWyd75NdpZ7ZNNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlVCG+Q2eMMuJ9A4FN+6UOkTV/wASmLxLLq7O13kuX8=;
 b=VOPINbD9/1ZfFayv7v12af6LssEGQeR1mPTDIxgOAcmevqSryzkGKVm5fU5+VFuq2vklLi9ILrjylRNQv6L7C3LULsZ8hynSmVI1AlTKpD0FCkxdmFZ6XdDSR5L70v7DwQvIGE6r+PmCpwxcyuvM1qGqscpSd8l4D/jpM6JcyQ5SVcBOcjq4LeuCROPE0tU+h3Up5ivwbTDU2Xxr0bVpgRoXp3zj0NwVPlpt6IBMfQr36OxuC8kv0cJvgdDRYFIP616ZE95Zexa32dCxc9VtIpnI6OTDzdv4XJYWEpJ2zVFSXmeMSB+k+z9FX9NoZmxKHCw0wgK9XTXyusSFkEP46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlVCG+Q2eMMuJ9A4FN+6UOkTV/wASmLxLLq7O13kuX8=;
 b=hOdzvMavbIUjXhVNo2XhHdkg88ShyxZDCLSOedtkwdHL2K+AtOuI9cl+C4z22qv0zavE58Pq0xXDTlSNDemAkjxoyV6JHgO4IYG4yKAGqbi1XyRQyvIrStczXZOYLiP5KtTk6lUdCWGhWm47d3Pffx5HNZ9ffvPtUzw9eSm8HXY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5320.eurprd08.prod.outlook.com (2603:10a6:20b:103::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 06:45:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Thu, 14 May 2020
 06:45:34 +0000
Subject: Re: [PATCH v4 6/9] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-7-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ef44c5c0-1032-76e3-a3ce-ad0cc43d297c@virtuozzo.com>
Date: Thu, 14 May 2020 09:45:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200513011648.166876-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM0PR01CA0141.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend
 Transport; Thu, 14 May 2020 06:45:33 +0000
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c10eac-5163-4870-9a1f-08d7f7d266ef
X-MS-TrafficTypeDiagnostic: AM7PR08MB5320:
X-Microsoft-Antispam-PRVS: <AM7PR08MB532098B42F0D626D281B5026C1BC0@AM7PR08MB5320.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1mX0AK5X7n0A2BlcgiPacqws6XdLJODWpZJ0uCoDQPlVbO6JGe6Q4cF4eTwR4Y2qp4h9Ema+BPImSI17ENEI6+6D1Aj0tFRMuMro6eQOKZT5ZMGXGDDLR0hCJ8Bzznro76heda+Q7AV7cjJOeeHTsWPN3knXxZ1mL2drPYDgdb9URxN1Ev5SZtE+Cs6fMtMD3B+0hN8twotJlpY8xCg8OjFXhBEi8e+nmtRq2ucVXq6PPtsrIdG9aiAilCccbmKzUiO8dM3S0BnpiYvshTSO/dforNbbAjvzGhtFBUMufZCC83qe0/Kbm5PB4DjOALiqNu2QaSOhv2VxPaFsWUTJ1TCb8kXx+V/aUBBJh1SlUIS2qySfw7ukq1+kqO4cBdhsVZe62ocbdIGJPPk2r7rpLC1CUFNWAZCL9ziT673RNItt4PxsyK8qJkr5HEt0lDoHgSgg6VaTtmz/suB/suwnYRnGcgUziczDGpXPGp369uEzpiiQ2SE7b/YEmV8jWxt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39840400004)(136003)(396003)(376002)(366004)(2616005)(8936002)(956004)(316002)(16576012)(6486002)(478600001)(86362001)(31696002)(4326008)(8676002)(66946007)(66556008)(31686004)(66476007)(36756003)(2906002)(5660300002)(186003)(16526019)(52116002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fi9rp2wHsAbrM/TkCB7mn+Ra1gG0N+KCXNTqrLLM4s58UW2ewjMHeFVz2Cj+w0EBVIO05LFYDOE3RrIe91MkW4pY25gc3/hiBXF6NcDlVLod6UvRB/DBj28GxYt9pH1ctYT6BrbIjIIME2CqevmjLsZ4ewYVv7VbLMF1H2aCpjma4DOcBdcZ21/F4TE+GcROISRCaYLSWkDvxd0H2prqNOFkx/eq7KrHDVc3peMMBp3ylaqHLMlu1kYsbdp/leFfuDzCinFO39LThatQKT2XiQ2/6upHNDoITP/VtKSTu81+5HzDQRLvhUJxf5J+8+cHMw5XSB1bPncXSnLoZxNCHIpnvECJm8qbAoD9vd1xKxtXY3EaS0M5QammIjYFmaUVXdG8vmoEH3yzRYQc5+U7nbvJk8/W589UPrLqyeD6LUOh9xTQXK+COmMutOJ0sFl3kohDc5kD05i2k9iOXhsk9L2gsdFvIiXB/lSuJWIoyGscKIgh+WkW5wnVwuJl5ro4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c10eac-5163-4870-9a1f-08d7f7d266ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 06:45:33.9978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUWGwlO/UP/PNNwQ28+qyxxF9w3r7WV6zCmeyySYqlm4w4VU8L+cJqhxQQOYcQ/9YYmjoyHPLxFdV4r067onxtt0DF4ekg1U0vm0oOTGWsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320
Received-SPF: pass client-ip=40.107.3.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:45:36
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
> Include actions for --add, --remove, --clear, --enable, --disable, and
> --merge (note that --clear is a bit of fluff, because the same can be
> accomplished by removing a bitmap and then adding a new one in its
> place, but it matches what QMP commands exist).  Listing is omitted,
> because it does not require a bitmap name and because it was already
> possible with 'qemu-img info'.  A single command line can play one or
> more bitmap commands in sequence on the same bitmap name (although all
> added bitmaps share the same granularity, and and all merged bitmaps
> come from the same source file).  Merge defaults to other bitmaps in
> the primary image, but can also be told to merge bitmaps from a
> distinct image.
> 
> While this supports --image-opts for the file being modified, I did
> not think it worth the extra complexity to support that for the source
> file in a cross-file merges.  Likewise, I chose to have --merge only
> take a single source rather than following the QMP support for
> multiple merges in one go (although you can still use more than one
> --merge in the command line); in part because qemu-img is offline and
> therefore atomicity is not an issue.
> 
> Upcoming patches will add iotest coverage of these commands while
> also testing other features.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

I'm sorry for asking it only now on v4.. But still. Why do we need it? We can instead run qemu binary (or even new qemu-storage-daemon) and just use existing qmp commands. Is there a real benefit in developing qemu-img, maintaining two interfaces for the same thing? Of-course, just run qmp commands from terminal is a lot less comfortable than just a qemu img command.. But may be we need some wrapper, which make it simple to run one qmp command on an image?

It's simple to make a python wrapper working like

qemu-qmp block-dirty-bitmap-add '{node: self, name: bitmap0, persistent: true}' /path/to/x.qcow2


-- 
Best regards,
Vladimir

