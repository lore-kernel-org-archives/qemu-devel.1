Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DB6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6432065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P5qpoLq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6432065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkli3-0001gE-6t
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklfH-0007pw-18; Mon, 15 Jun 2020 05:44:27 -0400
Received: from mail-db8eur05on2114.outbound.protection.outlook.com
 ([40.107.20.114]:50272 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklfF-0006Lq-D8; Mon, 15 Jun 2020 05:44:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIZUX4hZr/M0CUkBvuxv8EkJn92+U8fhoAKgdbUfRJTcjBuFDFso5Q8+EpWozP9iNLBLwDSa+sqnbchDgJq+iKZZUJ8ShTy5KhCyxxJHKBukMeCQLfowHKvjjCb5CbeKjMtgmjW0Rpf+0BMZijB4LBjmfpaV85ik5F52r+5AGz/MUnwqiKMbUHvf4BxC4BMqe7w9eI6FCj/boFr7qPTDJ8E2QA7xW826IH4Jkk8quHJHAwkqlLM53UjBKttGsXR1eD8sZvfZS9I3mXyyFD+i9QXy7TuduFjym8i0mMAzXV3dNcUPJP4hvT0BiGnEb6QPjboncFCjz466XmMXSG5YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovFVMR9BiACTdWaCDAcuNsVk0qjBuMBpkab6QgsgboE=;
 b=CzSauLYxLFERaj3UW3epJhKL/G89L91R8DCuwgnmWsL+AE7LJCqdRF1eRhsjHgln/5TeIAPZn8/aep2Ua3lzj5cc6UUf1JrjZ5SzhOgAyi0QbS7VxvbmtV1JV1cvNXyFX48tG7AtGVu3KxF7n9sQXHEUvHRYlWDHXoyD5IuRMCLtMLk+CPg+RqCmyRr5pvESAdmBwa0i1ssK8zr/xckwhjW0G4c9ny51MavHdKheUJ3haJ0p4Owdl/1otsks3vo+BqPo4bC3/S5Z99MUZN7KZ4UOip1qhRHArNloA1feorScMDeVnhzt2rZ3Y3Fke3Vgj+I8eJd4QuUdChHgGjmmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovFVMR9BiACTdWaCDAcuNsVk0qjBuMBpkab6QgsgboE=;
 b=P5qpoLq2Zde8eiW3iCYuw5cVpui3isbq9xMIms0Mcb0JsFbADxvNaLDmjK2kFOVsPfEr+hR1p9xnL5IpFMlb9FfrjKGBIx1Fg7DIh5+lf/8ezDKD+CXxtFq78bFTO6KtMkUBw+RA8tBrr0xtuirr2pizrtAhjWcQfmpMJ+t/G7w=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 09:44:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 09:44:23 +0000
Subject: Re: [PATCH v7 2/9] qcow2: Fix capitalization of header extension
 constant.
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591920302-1002219-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0848cc66-d909-8537-5277-320ecef35925@virtuozzo.com>
Date: Mon, 15 Jun 2020 12:44:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591920302-1002219-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23 via Frontend Transport; Mon, 15 Jun 2020 09:44:21 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45500061-3f39-4f43-6a2a-08d81110aec9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544866BB7204248F08CE7B5EC19C0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kypJroPoc858cfXxd9P47ZGVt0fonSFStHWFBoiGBR0p7F9B9ggoieWusmpXX+C/PuEgcmgYmqVIpKzb11f+e13oBTrVgL962dXj9KWvTikQas0pIrp/o5Lgl1n8rnNB8Pu0UOBJL7peJV6kfIvTC2g9yS/W78Dw8JNt84lYqxG2s3qDhDrR6dwT/ZRFmImkxBZPbHhKJPhNsdO2Y0sbz7e2htE/bhP5K7lMmyB8ks9cMAYjF6Kef2VZ3uxL2I+dZhVjvi7xbY5tO/y6n9EdLN6MXxK82fKUuR8bpADIl4y6xELFgpA2h8ZfGYCsouVJh65aETYelAojZvR/4lrdUJ2F3uqBzMTDjZsGMZraP+85ReKsnGlIPiLYXg66L9+C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39840400004)(376002)(66946007)(2616005)(66476007)(66556008)(478600001)(316002)(956004)(2906002)(8936002)(186003)(36756003)(52116002)(6486002)(31686004)(16576012)(26005)(4744005)(86362001)(8676002)(16526019)(5660300002)(107886003)(31696002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eMKUo01t6lgXvZGcCmULx28Mofl3h7MBLWv2NT8Db+OVvCWbyzvLWNHnc2NXLiaYTwMUcj2DLp+/tgUhdx0Embs4NJYgvVvZPbc+AA83qd2kw3TfSFo1n3XRg8HF8/ueHaSSLyK43aNT1OfZAukq7IyNtZG3UdHzh5n/w73JyE3urrLlzA3O++E6WtBewr8KZ0qSYDoupk1cuk24JDpWqbgvOdfoA6L/Oox9mqhulQbjASPNLtKcMR05JnUfpB0zL4IUq29oT8keytXuxJzP4EzLUsU957AgWCenmFdww6tll3dkU9qNtmsUKX+2dn99Jneg1hRo5R5TBFzf+IDJVyGhmfM2q41mPx1nv0WztW1dok6R5iTt1oEcXP4rU4X4PtYA+VLBHnqV9Rh0kaOYNY7cDMOFpamYlP9suKwNqI1v9Sx/SkxJ2tkoknHsdD89Re1wyo6oivsigK5j1Yle8cPSqEj9/kz/ybWJMrUQFWtzoRpFKWjINI1pcFf6wm/b
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45500061-3f39-4f43-6a2a-08d81110aec9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:44:22.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1lOLZXfj+2Zhx6ebA6koTozKoYYTgsC1kzJKIEL1YTOMTx8n0QIi9fXjiJE5rXTnBNOeD18iIsfoFWvNk7kNZLvLO+P2lCo/QyWiA29ZJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.20.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:44:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.06.2020 03:04, Andrey Shinkevich wrote:
> Make the capitalization of the hexadecimal numbers consistent for the
> QCOW2 header extension constants in docs/interop/qcow2.txt.
> 
> Suggested-by: Eric Blake<eblake@redhat.com>
> Signed-off-by: Andrey Shinkevich<andrey.shinkevich@virtuozzo.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

