Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90594CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57648206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 17:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hsfb2Xqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57648206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYXq-0002UA-Uy
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 13:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYYW9-00017Q-M0; Tue, 12 May 2020 13:16:33 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:5187 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jYYW8-0000wu-Uh; Tue, 12 May 2020 13:16:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEsifSNpdWKyCV31lPLGL2mm6K3eCAyNIHAdLOwQv6PQhW2eZi7pMjNesNWoyEE3wvcI4nw6ZJ23zYdxCXEdi54Y3YNoNly2ijPJODqtekbIhlWn8mWdcdrWf01HuwKHQhRsDg7RDnHZxPjjS6mzEA42BQ8Y86zoV6x10nWohURuYO/Jra5jio7IIdksdFvpxur+mIiqTAOGOEA3cfNCWdGdlg95KxgZhWJlL+KxhxCzSNFt3ByXBadF1dY9hgf81qFGWXV4fu7s+ruKC+PDBDIJIn4VpWWeDd47UCTATScCH2wEtMQ7gWXHPyQt2IEIOWUNzutA6mQqfQU8zHHzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+YqztN5gEkkB26MdFUmCOgHdKVWVMUHb4qS0WaPErU=;
 b=Pdt3GssaSw2RSEkC5hPQCQCZD+X7A3eLGvR+FeC51oIH4Opw7ArLz9i7jn+sZR9bJoZMH6JxsuuTCTHpi9YH8NzbyuRQoSUwyAMIOguU7042jCNQH5vFuyYi2jqFMYBQ2MUQ85Bg9vbQnysrkDIDF+COK54c5xl1S95zNbfEDsrdzM2qs9yUgOQym4QgvonvwmdE44Kw/qTnoMs5cM9ksUuWTI+ljGFDn7DeSvrI44OKALVsX8d0eJXB0MWKF+yHo6sik/L2wZQPfIacYQq/cRzkIbeuD209sUS2BZ15VZASFNI443ctLUlXYlzCZXrwx38+oG7IKaO8xEHFiDs3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+YqztN5gEkkB26MdFUmCOgHdKVWVMUHb4qS0WaPErU=;
 b=Hsfb2XqdBspXDSOXjpKIZZC6ag7KUlyJ+wpm2RbQXwLC6m7P2aZYRyY/ATq6654xOKxc8nBkJCRWjcmXyaKpFnEx8N6vbL8sZSUQU6JL7rljLG0CM3YwePirGKO22LWm/5yCvOs0QlrreLl6FOgMesTTIHdZ3oWo7mvio3y7WeA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5461.eurprd08.prod.outlook.com (2603:10a6:20b:10e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 17:16:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 17:16:27 +0000
Subject: Re: [PATCH v2 3/4] mirror: Make sure that source and target size match
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-4-kwolf@redhat.com>
 <cbeba850-5c46-e946-596a-c8f33140b898@virtuozzo.com>
Message-ID: <5c04211c-0baa-c474-69d0-80de19254d34@virtuozzo.com>
Date: Tue, 12 May 2020 20:16:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <cbeba850-5c46-e946-596a-c8f33140b898@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0080.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.163) by
 AM0PR06CA0080.eurprd06.prod.outlook.com (2603:10a6:208:fa::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 12 May 2020 17:16:26 +0000
X-Originating-IP: [185.215.60.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac42d17-b002-4138-87f5-08d7f6983424
X-MS-TrafficTypeDiagnostic: AM7PR08MB5461:
X-Microsoft-Antispam-PRVS: <AM7PR08MB546147A7E01DDB8005893582C1BE0@AM7PR08MB5461.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhHpDqVmfQjl/Oyj5tTtvbQybbv6TNAq+/Eiju5b67u86j4gEKjfYP2MjUihwg60MXH34H27cadx1QTWw6g4UYXHTQPlSYHAeOsU40EjGUGYsqA2uSBc694Tuh2jStIDLGO1+TyJgnFYmVM4z7mpaUVxKvoZlHZvwlVR7Y1mY0IYa+w2G8Nm154VRzpBwGaF4aORbFJ3ujCTUJ1xJcZ51eU370lZWi9QRJR2wvJBQIrAHucxUUHe5rYEz9jNLV5zUlK3b72nA7gmR+ABFu2S8CvRmDm+4v2YT+DVIEQz284P65u+TrtXbTX+kjAxfOfqVBXrOiUyre53JXZPp/uqDmC7gw2DDO+oGYB2IbYzF2erH8noTCqhSL/a/VYDbQFWmEz7Mzxlck0gbt3sVal7XSUBNa2WJbL4wxXnQR4pNjX5eUkeOISmRvDuhTommCY7Of7f16JYOpdZcMPxg4J5hMxqF34zHgXtXO7TYEOLmv3WaYJqd+Fu10gaf32VMpIhdQYVMKGdm9PHiyMDlg+dp/SxI+T7uiYDtPqE4a+fEHFpGRTRdKdo5uReytTEm5pZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(136003)(396003)(33430700001)(16526019)(86362001)(26005)(52116002)(16576012)(316002)(478600001)(33440700001)(6486002)(186003)(8936002)(8676002)(5660300002)(4744005)(31696002)(66946007)(66556008)(36756003)(956004)(2906002)(2616005)(4326008)(66476007)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Zot48vFdH8bgoU5nDUZOz+s3bHvaFml4W1w6g4uKbGwXoEtPk/KJL0xHCarSTgPvfBwCal4q2EttivhX4f/QdOREJojyFZnNW9U7otY3VuXIXEtk2v3wOXXcDLl/ZSk7O/4pBA6XrMxUPphZ2UDezrqiBSObW8A38F1Ifu/iSv/SKLy6W2lYaZeFIT4g3TGXFwwtWMa6Is7rBvTvoO6xaCgnExknjCuExovpXXhY8/GKxFhvx2qYUHTEc6FcSvUZ0nIkUcoEjr1ubMQ6saHkN96i/Gj6md0RjpbSdmmJeLktutNZfEIupWArjY8oeOyeCdhvjRTAea77E1LwOyog5wmjik7c6Dx1B7x1tIWZTlfyCAqZeqnqmx+VC9sGPJfLupTEkFxwUN9CaDIGK3thvf0xOHiN0dInk/HFMJ5MyLzWP9g+/ZX5YHpluSdLAcf2lXBTHptBSH9TUw35UiMMtrI71lR4Vo46eiLzQBiHd5+nzR9BPrtLdO3aY3fqJVS4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac42d17-b002-4138-87f5-08d7f6983424
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 17:16:26.8277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONeZNZwjZRa6tge3h6S+VyXLxkZyBEjdaIlHWiXu+dStJ71/R2+egdo3a5p9kzIk58PzBfRkcMDlT8hEpNmESEr+hzSTaF3ZJWtfLoE3g/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5461
Received-SPF: pass client-ip=40.107.6.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 13:16:27
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.05.2020 20:15, Vladimir Sementsov-Ogievskiy wrote:
>> +    } else if (s->bdev_length != target_length) {
>> +        error_setg(errp, "Source and target image have different sizes");
>> +        ret = -EINVAL;
> 
> Seems, the only case, when mirror_run() sets errp. And, therefore, the only correct one..

the only one failure case I mean, of course.

-- 
Best regards,
Vladimir

