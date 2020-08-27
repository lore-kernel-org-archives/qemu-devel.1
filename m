Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49AAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7976A2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GxDFQ3kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7976A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBP8u-0006Vf-N8
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kBP8I-00063z-FA; Thu, 27 Aug 2020 17:08:30 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:18402 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kBP8F-0005Hm-HS; Thu, 27 Aug 2020 17:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHsD3gZFFiD2Tt9slptUa+iwis4jLUMtjXmBUODG4RtYwKVofw+hB4JpSs2dP+VEgOPPF7+v4l095JrL46mhIog7e4vX8kR0LeWVLOzURwiA0BAp5UXMtCVOOPJMnuEtKwm0dIppYg2yP/txj32O794uE/9IXQR1OH+PKejG1q+gRBIjYX0qSvmsnHP8UTRG0aAHT/nxH8cTBjUoicibSiNh9Gk6RMF62TaP4dD1XF8ZNMnnRC96l3SlKlslPtzB8QuAbJoCNCQ3aGCim98Sqp/TYHujCMgcg5TzwiHs2KLQb4zVCX2OaCtsvY84b3mLCGoH1oVVYNTq39n//J38Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d2y2uvk3ylTZoROvvxDUlsUjbpDrqsmfcjefymgZGI=;
 b=jWeID/r//2JUUNOqCa0F+X69MeOHOtBj3qtigVAVv5h94AtpG9r53VoYwTWytZffAxweASqOgu4xsAitnK9ZaeCydR1I05X7yL3wQu5HElkgiJStKbv0Xvxw8j5qzisopvWZTZ6pkMUUlrw8U6cPu4r8J4mS0w8rUUyCBF2YFXaUQP+Shc1FsNHiTKmyd9Ipe/gySrrMPJEmwXTa7fLM+rKo2JDYMb0rz52qT+GdkQ8uT3zsLCHKw0NZg4iZy8bheP9KMZrvgOtK5NpaYfOa95aXujasZ2Xz8jYhBa2hXLP3yd57rhVo+bWpvtYLQwKgRDNBO0rbceKStWWxQ7ZJ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d2y2uvk3ylTZoROvvxDUlsUjbpDrqsmfcjefymgZGI=;
 b=GxDFQ3kl06krWRhPe5yvJPw6zJyW5ineMqTBfqOv2cb6HmDnF8d7Rf49eav4+Q6QNWhVPAXPXLO2LZdUmAXYNZ06OzJVMLX3ER7cPq+Z410jtq75bZqYztmIAdHW+uK0/XX10J56zRJOt2BpWPokcqIfmePOQVwvC0bxfE5Hw4k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5029.eurprd08.prod.outlook.com (2603:10a6:20b:e7::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 21:08:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 21:08:22 +0000
Subject: Re: [PATCH v5 00/10] preallocate filter
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, nsoffer@redhat.com
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3a810fb7-eedc-bd54-4319-f1862b5382c0@virtuozzo.com>
Date: Fri, 28 Aug 2020 00:08:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 21:08:21 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2476d546-1d01-4654-df90-08d84acd54c2
X-MS-TrafficTypeDiagnostic: AM6PR08MB5029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5029858757F7C4B5F7F0D920C1550@AM6PR08MB5029.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GVbnvxj4vr9AozKQ/38n+8p4n05DZzFBjh50zu2wBuXuLxPftje+ZEoEdky1V/03lgCtrauDo2F2x42I7NdNFnVPR9mvOR5snIgkygLKLXTOXjT7XLlP8XBQMn9qCYa9dS8+CcDPjqgHNptwlYnpczukIdvfvbN9/J1djiRB/Rn5uDSJ9xc2EaCQnK2EzcWjwYmG6XFR4H3debNgBNt4JPiAH8UdsDLQbC2tyYumD6Fjxax7vossS/zzHgXrVTd3L+qDzpPG/vejQ/tNvfOZbEZLtNUqd7FUaHF8q85dEF8nGfISK9vLNtkDbaJc+u4X9/uwJKTu51+eooTzrU6lz1HAa/C8MCAVts8WRIQa78i5ft+uLLMvAo0B+jrT4Ju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39840400004)(376002)(136003)(5660300002)(478600001)(316002)(16576012)(2906002)(4326008)(66476007)(66556008)(66946007)(6916009)(8676002)(26005)(31686004)(16526019)(8936002)(2616005)(186003)(31696002)(6486002)(956004)(36756003)(52116002)(86362001)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XVupEv0qMsncSg4h9pLXT3uM9k199EBtp+9ePPo/7UIzEcrCDg+44T441jUtmOKNUk4+jGtTnAyPLMey0AvMOgSVj5oS0t5H8q6rB83g6WdfqWtTgh6CqV8tKnI7b8gBYACfHngb9jF2OfCvYAOFaS8K1OFxN4Sqa+liVYxBOyOZwiq5vHd/mgsL8Cro0zewE/Los4AhKrQqApCWU0fujHAW+RHO4ObqrE9RoTbJW0aOAeVeagKVc5CjOoKD4sU2nm+uJw7cz4O2WcfYz4w+GEQOcQdNX3PpuWuBL2VfdRcQsfausItHhb3KS8Ebf4Ujwq0p1R573KC0oBHDG9GLFI1190ubJejMp+cfZROwKuLi1HxonpqV8iwFW+Dt1AwomqQdtQgg9D4y+AeOwtB0zppnNOA+NPBrmLVz+CB3RV0G+8DAVmPVLU9w3If/tmJ7pR2XeK7F8jIEkAAUErXwM/7vnzSjR0E8UJzcBCnS5EZLd00WZINC8AGe8dhlHkBhhAFo7dE+H4SeIGYO3OGot3YvCk4lvPGw0Ghbo+h/6f9xa6qlxvGpDQNDhQ+38BOoAIxrg5On4sS0w9EgyV6Bv7TvBh00ZxTYeIoUXkwvx4S+MzhURdSfU26Luth5gSrTFd8tYYQvYiB7tQF/K/HVpA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2476d546-1d01-4654-df90-08d84acd54c2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 21:08:22.5565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKVbVCLcm5iltCkP5zgMMMo2zeTvGWnHLYrrXUqImq0PExxE+58ZI7l+1jHweYwSBtuq0v8YlUjScokE/G/W7EOC9jrg/4gdAj5EMwi+zjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5029
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 17:08:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_LOW=-0.7,
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

21.08.2020 17:11, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a filter, which does preallocation on write.
> 
> In Virtuozzo we have to deal with some custom distributed storage
> solution, where allocation is relatively expensive operation. We have to
> workaround it in Qemu, so here is a new filter.

I have a problem now with this thing.

We need preallocation. But we don't want to explicitly specify it in all the management tools. So it should be inserted by default. It's OK for us to keep this default different from upstream... But there are problems with the implicitly inserted filter (actually iotests fail and I failed to fix them)

1. I have to set bs->inherits_from for filter and it's child by hand after bdrv_replace_node(), otherwise bdrv_check_perm doesn't work.

2. I have to set filter_bs->implicit and teach bdrv_refresh_filename() to ignore implicit filters when it checks for drv->bdrv_file_open, to avoid appearing of json in backing file names

3. And the real design problem, which seems impossible to fix: reopen is broken, just because user is not prepared to the fact that file child is a filter, not a file node and has another options, and don't support options of file-posix.

And seems all it (and mostly [3]) shows that implicitly inserting the filter is near to be impossible..

So, what are possible solutions?

In virtuozzo7 we have preallocation feature done inside qcow2 driver. This is very uncomfortable: we should to handle each possible over-EOF write to underlying node (to keep data_end in sync to be able to shrink preallocation on close()).. I don't like this way and don't want to port it..

Another option is implementing preallocation inside file-posix driver. Then, instead of BDRV_REQ_NO_WAIT flag I'll need to extend serialising requests API (bdrv_make_request_serialising() is already used in file-posix.c) to dupport no-wait behavior + expanding the serialising request bounds. This option seems feasible, so I'll try this way if no other ideas.

Filter is obviously the true way: we use generic block layer for native request serialising, don't need to catch every write in qcow2 driver, don't need to modify any other driver and get a universal thing. But how to insert it implicitly (or at least automatically in some cases) and avoid all the problems?

-- 
Best regards,
Vladimir

