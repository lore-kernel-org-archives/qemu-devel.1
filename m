Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2206FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3CC20658
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 19:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qFvHTExG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3CC20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtG27-0000wK-2m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 15:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtG1S-0000FA-K4; Wed, 08 Jul 2020 15:46:26 -0400
Received: from mail-eopbgr150123.outbound.protection.outlook.com
 ([40.107.15.123]:13907 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtG1N-0005Ev-7q; Wed, 08 Jul 2020 15:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imoITlEFQd+b1ZMsYTokBnAPl1eo+z4qS3i9ttSiO56aWiFKTpbQPmgOgt8ewiIXwYzbLN6jP+FYWzQabEYDsbbuiqmpA54jTAqy5vkpvqy2MUj8h0vHnD11dqIQgX9q+6q3cGcxxJKjFb2Zs4B//KULc+E7G+8j+9mdFCNrpCozRmBkJT70MQLNYGIE0MHUqoiNztPBXWwejGRxr11nzuCIoFi+0uLFJkB1hs+R5EAJ1ikoDLiDUjsvvE4ia6+aCRXZ2G9ezeRVwLP2gXtFmrovox04RbTNwwF6A21E8L3I4bTkPqVZleYiE+5erm/jaMmmbOVau/hOqcf0ffbpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dsPyQ6QsQ+5e1xTT0tyS6ycAf+JgXzgNAS1KsmN/78=;
 b=J3fPIDXcmkeatG2rMP18coQWTFrohNKsQBu72m522Mdx6TNWt3MZcCTYEEE6MKmanLTIIWb+hjzM/3egi2X6q+kWflerflvQo2rjRisCLuGFCk9vAPaxZWM0O3bAcSXbu1Ist+5N+x/57Cb3xU5oUnFk+jqGR/QbHth9B4SEZVhVkMxneDCOVbaoLdM2B5gqqFIeYSkR7ootLPIRNcJZ+tca2z1tC2nw+ctXJIVQQBNvOpYYCe5cwg+IhDIxMyIH/JeQvXHOGw7hFBb0mSF1f6NauVPejUjMGQwTIV60bI+ZHaWFH4vEQkCfJ5MKlgcCh/2MmiNSG4G3z6HyvjzaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dsPyQ6QsQ+5e1xTT0tyS6ycAf+JgXzgNAS1KsmN/78=;
 b=qFvHTExGdu19nB6c6JM3vTckbg84BotsJzlkEFY7x2N6CRwF1vty98Oo8B+1lodAsJO2LVfk/DQ0b2QoVzrc9+8zvjwcPPeRvIQreHdYqiQwu9Fk+woLUd+4BzR1GC3lc4o70KwculJ4Ud4S31V49gRVLNbudj4dX+yEIoN2UzI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 19:46:18 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 19:46:18 +0000
Subject: Re: [PATCH v7 00/47] block: Deal with filters
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <4d7fa326-ef87-5753-cc2a-bb26fc555864@virtuozzo.com>
 <e51d9c26-bd94-bf8e-cfed-82db15243188@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <54c4b18b-b6ee-b506-b153-b44eb3879da2@virtuozzo.com>
Date: Wed, 8 Jul 2020 22:46:14 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <e51d9c26-bd94-bf8e-cfed-82db15243188@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::48) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR02CA0035.eurprd02.prod.outlook.com (2603:10a6:208:3e::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 19:46:16 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f95fab17-ebf9-41f3-1fff-08d8237794d0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381DD6ECC7A89793385E936F4670@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZ5h2aa3BspVNV9tpyiqA4+dQ7XMba52Mnhkxvky04kBBNgeflwUojPMzZlD81hdBZCfPvoe04yNteS31qK6PAvuQryXAh/jH4Y7GJwgZLYCQr7QSglT3/SZMrKsJkDSGdXaVLocn7nR6tv/h5ghJrwIzIDdbbMG+R7B8pg3oCJkP+hdh+XD8fcomf1X9GKFz+u3KAVZUtyHr4qehWcAOQG5hAS9JY0pqOvKYXdPPCxZ3/kFEHNYBY9zG6Sj2cIMX0tX6nBun8yZktYI4oNRx7r5oeELWKdoUPcAX6uRxYAi1XPxVjPikIds2tA6mi6GNVTTj2OfQTtTMMa90rUumxE0n6SAr7TfWD55rfYDyxiIqZPXzVygfovrcAe7Kq9sVx62lvOgYv4hREw6h2Yhsczf3RiX7i3V2vQN9xRp0eJg4pSSoFL5qCrSulWhZv26jkq/j+d0sDUomBydc1RmlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(956004)(2616005)(4326008)(110136005)(36756003)(8676002)(6506007)(316002)(53546011)(26005)(6512007)(66476007)(66556008)(52116002)(2906002)(16526019)(31686004)(6486002)(966005)(5660300002)(31696002)(66946007)(478600001)(83380400001)(86362001)(44832011)(54906003)(186003)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ssp5aEHPyvBDLAlnxR6tzCwlg9EGWYOlDe6d69UdxphtjyMwnWLECeHmLRNSoG1FCP2hOi0Hx8MUa83h+HlOQ40NnocPRA3j19PHH5Eg+Qy8OSHXHqWDE01PKi5YO+MsDZrF9+sYgcbg826cWq1qqC7Qf9yDHmRWh17uUXIKsJSCIJ0flb6fJkFrgBRhrboX9NeI1AY1unugWqtCH5RQm871yz0fJJY3BTgATmUfHZ4y+b9WQfKnOn43P0hBa8RgfueJuMaXenFtRF2XGNkg71O1lmeO4DguLvEXGFuRJUSP45DGzSlGJEbj4RrFXjQztijQc+gRZX3Ti6nLbLySfWCbydw+17PBNr6qe4E75AtAKIVRSkBsGDxWdUXY+svajRUGyCknoJORgKD3Q+mOMLJbCDWBNTBtLNgtadecBcGZP/zRcTSTR1i6tx27O1dKpTag9pCIvMq1uS8deTL+Uy7zGJBstUaw3z6PErMZU86dH8ClOHEYAESoM573i1hL
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95fab17-ebf9-41f3-1fff-08d8237794d0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 19:46:17.9442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5WE3gx9ntZrcry2ZmPt2VtG8t41fyuPk9tPtEqCX5UHkO03Wt8vcT1rMgBkBTo98gEcgUQXG0qUYZ1Tqt5RrETy7Z1bBQ7Nepj5eI1Y2jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.123;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 15:46:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 08.07.2020 20:32, Eric Blake wrote:
> On 7/8/20 12:20 PM, Andrey Shinkevich wrote:
>> On 25.06.2020 18:21, Max Reitz wrote:
>>> v6: 
>>> https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html
>>>
>>> Branch: https://github.com/XanClic/qemu.git child-access-functions-v7
>>> Branch: https://git.xanclic.moe/XanClic/qemu.git 
>>> child-access-functions-v7
>>>
>>>
>> I cloned the branch from the github and built successfully.
>>
>> Running the iotests reports multiple errors of such a kind:
>>
>> 128: readarray -td '' formatting_line < <(sed -e 's/, fmt=/\x0/')
>>
>> "./common.filter: line 128: readarray: -d: invalid option"
>>
>
> Arrgh. If I'm reading bash's changelog correctly, readarray -d was 
> introduced in bash 4.4, so I'm guessing you're still on 4.3 or 
> earlier? What bash version and platform are you using?
>
My bash version is 4.2.46.

It is the latest in the virtuozzolinux-base repository. I should install 
the 4.4 package manually.

Thank you Eric for your hint!


Andrey

>> introduced with the commit
>>
>> a7399eb iotests: Make _filter_img_create more active
>>
>>
>> Andrey
>>
>>
>

