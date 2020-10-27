Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45244C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8AE22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="thcGL2K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8AE22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMG1-00019e-Ep
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMEt-0000Jw-3S; Tue, 27 Oct 2020 06:30:03 -0400
Received: from mail-vi1eur05on2099.outbound.protection.outlook.com
 ([40.107.21.99]:34560 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kXMEq-000332-0k; Tue, 27 Oct 2020 06:30:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt6YWWKqYZ5Tmf+D9FZ5TbBJrDuG6vSsuulxHqraoxSI1C/io98YlOFknupfvqAMijk9zqIq+TEgTY0GWEZ0nP+qFO3wVZ9+GIG9ot2MR3OxsW3Yhc+f6lDlN6gNtGt4O9Bg+T5Ds6OWZgwM6eYKXLr/MPNzN6vOftrYFd8PqFv1jJP9S1Pg/WmvYxHJ2kJaQVbiwDMH223ICoDvTd4nr08U54yyQWrJNBXmvIHRMS/aURFWOrxZTHrvbjCX03u1yP2XWcy707/IXXPVJKOWLdOQ7HAUE+5ezLNgEAQji1pG5KDxI8NiOBLlof0Cml2KBOp5sB5wuongUjzLt7I/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRzawMJrCnFcP+QdN53A37Fw6dC+Z6JHHDulFOqM1GY=;
 b=G6wsXtmz67hrJ19CeP0HkUpIvmSq8Fmvhhtdw2MVVSImNWIiTWJbw+SQvWfp4tlfwSszv5oqgQUuQ6lHekZ/wdizM4yCGLrp4/LF8tK3MM12YLR4CXoROanc3KqfsLXiyaZMWK19KGbOE8KampVQ0yKkY6JLzFwk6bFvlS1cJpFO6/H5WrDkUTVBjl11f8lj5iaJcGf8ZljsLZGpC7aerNsDY1JE1Wg/noV53grAiNGbu6pwqArRPj05+eVtIlVw2i1ppGXMcwdsUa5GtVKJG8J4zi8/xDC/t1hfjkiBD6lKzMZxeIKhgpr3MQwG93s6zl0+W3w7Hfl7KdpNi2yapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRzawMJrCnFcP+QdN53A37Fw6dC+Z6JHHDulFOqM1GY=;
 b=thcGL2K5GCannQE4SYepRrjJw1htS8jhhUjnEP92Zt+DdKWJcvKE+efi3V7THp6G5hXN6qWAK7Oy2aTd9bSmDC85GCKi2urP8GAy5K/ra9yn5bL3kZaCg3Kg9wFetC6I/nd1cxaWo1MLoExz012XyeB/9tXWxZjmr9rOew0eyko=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR0801MB2125.eurprd08.prod.outlook.com (2603:10a6:800:5b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 10:29:56 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::c1ba:32cf:cd37:712c%9]) with mapi id 15.20.3455.037; Tue, 27 Oct 2020
 10:29:56 +0000
Subject: Re: [PATCH v6 04/11] nbd: Update qapi to support exporting multiple
 bitmaps
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, armbru@redhat.com,
 rjones@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 "reviewer:Incompatible changes" <libvir-list@redhat.com>
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-5-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2304b1d8-675e-8a3a-a974-a96f9cb83c10@virtuozzo.com>
Date: Tue, 27 Oct 2020 13:29:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201027050556.269064-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.93]
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.93) by
 AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 10:29:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5435d801-bc24-48da-f7c8-08d87a633fa7
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2125:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2125B0FE2D0C34CC5E2E424FC1160@VI1PR0801MB2125.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh7qqWu4xxulcULLco/hOxI/1a1nOEfClcpn3YlyFV4pSYguu/cnT7jfC6xGRicUEzCpfCj4uVQUXJHwmX2nAfksGxCa5P77+ZBa0I0X9zUMtadHT5GHp35YRUuVgIli94g0Nm8J5vHA09E6lKyj4kP658rmDSOWPoLWwDif4QCS1uDYN5GddytjN+G/Eth9xue6oZ6lA09FoAE+wprY9lJQJa/5/ERn6YjV2jiPRqPzIWvlih4vnSTPzApKs6eS5CTuibt0GMwSRHUGH7f2lTk/B3xC5PeSRyQmxGN5BruvCsOUdvK4xlt27tfCEcw1SvjnUWiD3yfLa2RybvC+GZR4BAGsOh6hFRJ0YLnVwTcmwrEOIA5AvDRWeiSERkSO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39840400004)(396003)(346002)(6486002)(86362001)(6666004)(4326008)(8936002)(66946007)(66556008)(36756003)(7416002)(16576012)(316002)(54906003)(4744005)(478600001)(2906002)(8676002)(66476007)(5660300002)(83380400001)(26005)(186003)(31686004)(31696002)(52116002)(956004)(16526019)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bkml4lYeskeOGol9yak+RKubcuRHRJa9Y6v6DfY4HP9/IJonxKm1wdiJ0cSSbA1vMMnubgeapOS/ijCXwMuDoFJEylHA+b/JFm9Gd9rzKdBkj/03hQCS0R+4rXmyV6bv10jAgfcfGWpv8VGyWbP9E5Zt2mIPO6ICKj5GJrvnfeIv+sOKX4DLw8SOFnn2UgpLCvPHVZYS/yo9jSN4O3wvN4+bHn9Dj9BEMFGgi5W6YAgHowVUxuE6BC87V/fDq9XtUCTq1Oja9qlC9Iz+0LjTzquUZOw5Aox5DNQojVxL4e0Ab2j90btyMUArGwuNWK1z8DoHcOsEIS75IVECvsqxyNQ6VHU9Lef3WGHM5MW5ncqrPkUeSYDgZP+250+0dkMxhQFRki3mexlXrJcG8R0B7Tk6OJXvwzJAIxtTl8D2a2qW3guvgRlvR2lf8LyJsXVCqqpVqg2PIVb1rdxagmLiJVF/Fg9kkLN5Lwo7fmVUXMCRJIfxXFrtzID3uTKrh9DMcVDK/OGtu/nVTcPQxXzEyZAMDoUjsZRr+yNa33fzL6sqnb/WE4mwIOMVZg3q7KOiFVG9cJ70gnMGMMBOw+yTr3DXnMCxpC5Wy814HmE66IG6zph3TXVA3WdLYUtzuRklCsKGuy4ialBWsujFj1RkQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5435d801-bc24-48da-f7c8-08d87a633fa7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB5503.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 10:29:56.3429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH3ymU8LTIovqkGLxU5s3jxNfpzuh9Chton/TDTA0xyYpQHHEWs3kbf9TPCuueUSWQAHCYgNlbqG884AW8fbkZ8VxOXhmGy8OxZUAK0EDGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2125
Received-SPF: pass client-ip=40.107.21.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:29:57
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

27.10.2020 08:05, Eric Blake wrote:
> Since 'block-export-add' is new to 5.2, we can still tweak the
> interface; there, allowing 'bitmaps':['str'] is nicer than
> 'bitmap':'str'.  This wires up the qapi and qemu-nbd changes to permit
> passing multiple bitmaps as distinct metadata contexts that the NBD
> client may request, but the actual support for more than one will
> require a further patch to the server.
> 
> Note that there are no changes made to the existing deprecated
> 'nbd-server-add' command; this required splitting the QAPI type
> BlockExportOptionsNbd, which fortunately does not affect QMP
> introspection.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

