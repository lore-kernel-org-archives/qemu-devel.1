Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B5AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A1220823
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DR9rJ5rX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A1220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbsCT-00059E-8N
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbsBs-0003sN-PT; Thu, 21 May 2020 16:53:20 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:19648 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbsBp-0001yB-Qd; Thu, 21 May 2020 16:53:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1a44uf5bLxQmazz+foG/ixrLA2AtXXDskE8o1fCQe5f6TXPWBDt+fVxBSaqdG35sUloTzCjVs6A/xt3cUNimW+9tlY9Qi5sjQJOTwX0uMA9/2V/Mb3igjJcG2RpnrTn3Ka5PbJhe+zc/HU0GF4iq1bLohjHnZg+iUauV/n+cg3PkA5LeiEkLgMV+QRIQkyyCEg+p4dlEPFdLYQyBeBI1lSCNNGLM1FxZEgeVhBtqKSRNSSOM45nMErlYrKji9rWlA101BlgAfVojbw/y/Oz9nZmuMkGFk4nppZmdhevuV6LyLJfLAfmSxO0QGD2/AHwAi6RtB1AbQGN2DFJ2bgczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT4mWmusWBcKPkT0hhFd523SUxv7odZWPuDO52OKAvw=;
 b=fuKGsEZRE8rn8Yx5BUOTggp3ILyZRcqOcWQLIz3W2nwN1l8P9qDJkPINUb8qCNfcMfyoOd6VOoFbHv7pmhB1rdwoBJ8HiPYTKuSigVkjSbqcts3vCXJD6DHCMcHLpk6Y1oCN3aipB1OPYT/tJq97/GwvIEzLrfiF41lNVcVKAup5OZGGhJ1jp4JiNo2vMLkrsezVH+WzDJ2+Qm2ze1RiVpRkLy9W0Spz9bIr+YSqoVP2cWfSDp0M0BXPBD7X/lSM970R4dHZacO33ItoWWBQjyPrr9u2OKNWiNHs7sE0SBe8IVFlKI7krUkZoGf8rUpe0WSXissyEOtWG6Nn6FgEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hT4mWmusWBcKPkT0hhFd523SUxv7odZWPuDO52OKAvw=;
 b=DR9rJ5rXT9v3qlE+iF+YfEYeihdH8+/jMywJ0eQo/i1fMO0ZfE2TA/N/U3I2gUujKDT5CaEygn2ad9CxWCZlXFT/gQqkH/jMG5Ux50LZOL5KEVKgL1WvsI9qVqrSYmU9N+xyncDEhGuV/rOJI9OqJ7fGH727nqH8ZWgCM/g1aM8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Thu, 21 May
 2020 20:53:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 20:53:14 +0000
Subject: Re: cluster_size got from backup_calculate_cluster_size()
To: John Snow <jsnow@redhat.com>, Derek Su <dereksu@qnap.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <7b96191b-2c16-7257-9ae3-50457bf82e27@qnap.com>
 <3d66b51e-7112-d368-1d86-b63637413abd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <fc69468b-10d8-9869-88f5-b6798cfc0835@virtuozzo.com>
Date: Thu, 21 May 2020 23:53:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <3d66b51e-7112-d368-1d86-b63637413abd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM4PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:200:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend
 Transport; Thu, 21 May 2020 20:53:13 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bce332ba-053e-4e27-4db4-08d7fdc8faf9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-Microsoft-Antispam-PRVS: <AM7PR08MB533341752CB3BE65F6B9919CC1B70@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Mru7BzXyffo62OSerFfzKhY81m+HVtqlMAcFEYfu4yXaFg01mJEZ9n6xSIzb166Z3OyG5CRi/qntex/EWGBEGdYQ/0z3nV/EHvV3urajSobXKjhKZdlojTHLJYcS9yVBr3LIXHNX5oAYEaJK9ao1yIIB4pVIPy6nkNOiOHMXLQQ3mmqaiM4i3ziKhdgQwQk2IymHUuwMMei3eFT+zHafw8u4iqY7cdhtBNkv+ejTJ4bOnIHmopRDP8HpknaDFB/eh8/TNLKT/VMkKuwE0cH+iguURFYOdJ1v3UuZwY/W88lIebsEHCGzehVP7V2P5cxnwbos/Q1LWxF9IwF4WUi3nOiJR7DbhJht6+iK+HR0uxL9Yen37mqfp1s9dRp9tgY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39840400004)(31696002)(5660300002)(478600001)(36756003)(31686004)(6486002)(186003)(86362001)(8936002)(53546011)(4326008)(52116002)(8676002)(66476007)(54906003)(16576012)(956004)(66946007)(316002)(66556008)(16526019)(110136005)(26005)(2906002)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OSq/OkTVMXx4CQVuL2InEI7UzDJHOUT6bGB44g1Hmh6A1cZmOypCUYvvw8zkbc+knMgXHdO5SvnX80M7hBNgWKpIEdcQgcX0p4Vp76kQ9L2bM+LKntIutr1uq0ZrfeE57QmwTrgqN8XXp1naUeD3hd7vEM1f+IKmks+0mlMO4GVlwa9GTIRMDTS9tO7kbyL0Uz/BLvJNZijwNlqwhu4BBbe7VXb6pAYG8elLzcCx4WWF7Q6igXlUUWxgYkwdBDaQX9z+L/WalUaMr356AiQR9tKwhFPB6o//eblQV45UPySRqgdAGzJ0sllLAMmIrSgR2hR1RqwlDpIGM8lGVpQP5R0znmyBATxf+7Yq4h5fCDFqN+9NPwVOrCv57vN7FwLFZNSjV+wUuevAcPfp0MP2oeAX9G+MOpDPP7PDkOJ3ZuJghl2mvZvGLXEmhZ1FHux7E2llKd73LEy1IYowi/jJoOBFXf25cs+f4UcluUzPYI165LQ5e85dkLOwe5lXCTzk
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce332ba-053e-4e27-4db4-08d7fdc8faf9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 20:53:14.2979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plUQqN7Xq9S5cp2KpgXefd3360xYstKRe04vm0drpgac9AejzflJu74Plhvma+/0lwZSbJWm5vykWvCUPQQQnd9eE2MAKdWbVT2dOZrPY/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 16:53:15
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
Cc: Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 21:19, John Snow wrote:
> 
> 
> On 5/21/20 5:56 AM, Derek Su wrote:
>> Hi,
>>
>> The cluster_size got from backup_calculate_cluster_size(),
>> MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size), is 64K regardless
>> of the target image's cluster size.
> 
> Not regardless -- but it is using 64K as a minimum.
> 
>>
>>
>> For example:
>>
>> If the cluster size of source and target qcow2 images are both 16K, the
>> 64K from backup_calculate_cluster_size() results in unwanted copies of
>> clusters.
>>
>> The behavior slows down the backup (block-copy) process when the
>> source image receives lots of rand writes.
> 
> Are we talking about incremental, full, or top?
> 
>>
>>
>> Is the following calculation reasonable for the above issue?
>>
>>
>> ```
>> static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>>                                               Error **errp)
>> {
>>      ...
>>
>>      ret = bdrv_get_info(target, &bdi);
>>
>>      ...
>>
>>      return (bdi.cluster_size == 0 ?
>>                  BACKUP_CLUSTER_SIZE_DEFAULT : cluster_size);
>> }
>>
>> ```
>>
>> Thanks.
>> Regards,
>>
>> Derek
>>
> 
> 
> Might be reasonable. When I made this the "default", it actually used to
> just be "hardcoded." We could continue in this direction and go all the
> way and turn it into a tune-able.
> 
> I didn't think to make it lower than 64K because I was thinking about
> the linear, full backup case where cluster sizes that were too small
> might slow down the loop with too much metadata.

Yes, currently backup-loop is copying cluster-by-cluster, so if we allow clusters less than 64k, it may become slower (at least for full-backup). Still, my work about backup-performance is close to its end, and I hope, in 5.1 will be merged. One of effects is that backup copying loop may copy more than a cluster at once, so this problem will gone.

Keeping this in mind, I think we can allow smaller clusters now, as anyway, small clusters is a rare special case.

> 
> (And the default qcow2 is 64K, so it seemed like a good choice at the time.)
> 
> We could create a default-cluster-size tunable, perhaps. It's at 64K
> now, but perhaps you can override it down to 16 or lower. We could
> possibly treat a value of 0 as "no minimum; use the smallest common size."
> 
> This is a separate issue entirely, but we may also wish to begin
> offering a cluster-size override directly. In the case that we know this
> value is unsafe, we reject the command. In the case that it's ambiguous
> due to lack of info, we can defer to the user's judgment. This would
> allow us to force the backup to run in cases where we presently abort
> out of fear.
> 
> CCing Vladimir who has been working on the backup loop extensively.
> 
> --js
> 


-- 
Best regards,
Vladimir

