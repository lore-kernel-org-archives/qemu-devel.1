Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F595C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534A6207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X7ERQzxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534A6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6sQ-0004g2-8W
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6rX-00043G-6A; Wed, 07 Oct 2020 06:39:59 -0400
Received: from mail-he1eur01on0716.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::716]:51741
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQ6rU-00005R-10; Wed, 07 Oct 2020 06:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJRVWs2QFE7J1tqe2+g8VkFxoZjW0xJ27XbwupMlENYWOdMHyAkzdixlQ9+Ter1MQfXPAAeCX7Faz8qHGRBDj5GwfA/Zl8o7lydUfuP7i3Z3bXTXNRThE5rGbtnUi5IUn1R7yspBU6CQJvib/MN2HiLn/5nzLQby97XoWDKhJhMx/HcaUzJQ37xw0AvCB+oG5/ysY5RvuifacAuInrFMhXY3d1voJ81rwSRZENmbKHyJ7Wr6GzXqoQGNVzphi/Zfccyy4X9UGsT6weiQ++sM0F9eztxDlXrDjFEVw8LAig8uwJnknwZdKMW7ImLo5fU/qt6gTgk4wGFZuTxdjNby1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMaNRBu+0YEjsQtDCygXF/td39cyoU80qBwSsDvY0Ck=;
 b=E1Pkhsi+yWVY57Qkxz1p8sDW/OZQZfBhPwwlY5jn44XuxOKxFdpKwsxOE4GHbXWrsdInihSkJws0hlewOlGH8TPmq/Hi9CIBp6ysgNyCUTp5iFaOHss9SBmVSYgKpOHk+jsv2/6WdfAdQwTqjlxlv9e9aDR35S7osIftQlVmC9EjlOj2vL5aPzlQO0+gpWXipCxmOgQFy9ASD9/TbGMW7jPErIED6OGw3QbI9VpVRQlXjP9CSiohsTRYFNp2mPobt1MGf1N1BrtKNSILbcqdTeHQv5sYgGkVLhVRz2YuyEd9xQh3e9pXODFLSfuDzx8sweZrLoIWwMHDN522y/XdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMaNRBu+0YEjsQtDCygXF/td39cyoU80qBwSsDvY0Ck=;
 b=X7ERQzxuWmsBXIcBxz6v3UW5Rt5bduIZetWGuU+0IAS024xfWorCosfnRahQdXJcEz6EUzQwZqz7c7l5UgmE4O78ykFqFAbf+ropMlnJDMFSPnmZehklLng0c4swx2L9B/w0atETZ1kCQyagsr9L8AF84C3FqPO92/kzskeoKuA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3768.eurprd08.prod.outlook.com (2603:10a6:20b:90::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 10:39:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 10:39:52 +0000
Subject: Re: [PATCH v2 2/5] nbd/server: Reject embedded NUL in NBD strings
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <18cef345-fd1f-6161-cdb9-c73834eac135@virtuozzo.com>
Date: Wed, 7 Oct 2020 13:39:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20200930121105.667049-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: AM0PR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 AM0PR01CA0129.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend
 Transport; Wed, 7 Oct 2020 10:39:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc7fd66-9589-495f-d5d7-08d86aad52d8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3768:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3768E7B130EA269BAA0E2982C10A0@AM6PR08MB3768.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avkornlZw7CNToQx+/ymfxFHOOQpptVG9XD2RwBNY7zyKGe5oJMD5Z8NXzCg+1czH6RI3ipQQJZNQXDa5mANuJq0giH6JI0YOH+HCSWW6nq3wE4oObPO8Lte2dt46J1LIlvJv4tiS6BJqah7Z9Zc5cZf+vd/MkT3Dy6aknRxTL4H4ZwCZZ+CD1LYI16PRFVaneRQg0YeZDArCAPtoWK8i6P1qAChndTLfbDtJOmjeYcBGhE8CaM4gpPAINKNdIIDGpCmbBd53kxmBRxMYVzWNfeupn6BQzcCm9JVWVLm1Jg56o6P0marXiD19g2sz+bXsXs/cCRDe58ZPRIx+uT1UMRvRYitRuttvkMwMZv3QdPyt7zP+M6I5HeoB4Jldsu+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39840400004)(396003)(366004)(186003)(31696002)(16526019)(86362001)(8936002)(83380400001)(6486002)(52116002)(26005)(2906002)(8676002)(4744005)(16576012)(316002)(2616005)(5660300002)(66556008)(956004)(66476007)(66946007)(31686004)(4326008)(478600001)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1broeBPrdPlns8u0es27d4EGV/2EmG5foCfUh8aTXGNfJxo4UupLm6CXBOvuwLo3C+EhNpJ5namnU42huM2ZmbfR8D+9J+WojbPy2uAx2MbJ97DG9iITA7NWU7TEjhQLZmFd35TLfjOFgZCO4WBSWhNhqd6+sw940oYEYmJlHgnKtFLlw8n9pF4UVG1fGGSVkCKx4cA4ZxKJ7If0/X8R+NIKBRSQvdsFSbbkKa8gNsEck5WmHhtDWyRVqalDsv6jg2zlH5MSDWIhUPSJUOYwty4los71PXSjWKniEZKclodc/gEzZAPHJiBcE9YgdKEVTFvTK46sjgXTi6ePQwcvRReWx01UGHH3y7x0MbPyJ7Q+cL0W5eTZ8DXWHg1Fb2DfgKo88jd3qv+JHQwZtZoK3IHygC8OG79Tl9+crSeatYbucrNVBjSCkt0qsLquQTZ7vnHIlBNSe1NusDTwA/Fjre5zsmumaJkUOosItadayeGSdiFluIyNBU9Ccug1tynovrmHGysl2m985xdukPEpwcIrhDQLsH2LRdGJ8yAJyWDJKLf8Uih1N+FL/B/M9M+wIFW7r2Pt2D5SzJVlkPt3OTCuJPAELsl7R26Sa8el4R8xkkZiK7N2vCIBQWcBQCCpxqzSnNa/9iNz0rOwWpyOUQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc7fd66-9589-495f-d5d7-08d86aad52d8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 10:39:52.6297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubz/XLKX90gPyzL36RDJ/S3Cja4RFfL9xspZ1oF+ghvnOQKfDRO1yT0GMzl6HnbhLR7qDExH09wY9LoJ41iedrqp862isBD4hArVPS8FNv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3768
Received-SPF: pass client-ip=2a01:111:f400:fe1e::716;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, SPF_HELO_PASS=-0.001,
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

30.09.2020 15:11, Eric Blake wrote:
> The NBD spec is clear that any string sent from the client must not
> contain embedded NUL characters.  If the client passes "a\0", we
> should reject that option request rather than act on "a".
> 
> Testing this is not possible with a compliant client, but I was able
> to use gdb to coerce libnbd into temporarily behaving as such a
> client.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

