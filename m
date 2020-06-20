Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF39DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641BB23CD5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bGn840dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641BB23CD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmfaa-0003Q9-Kc
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 11:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmfZi-0002dK-S6; Sat, 20 Jun 2020 11:38:34 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com
 ([40.107.15.128]:15170 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmfZf-0005yn-3y; Sat, 20 Jun 2020 11:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8/J9exGnplDaUXnYUQhlIhvrhQx41Dlm+vo7rVPvQk2CdodX1c6FPvVThG8vScbF0sUQsHyDmWElX1RvbKwC1oNmm6evgRSo8UZjohh4TkXekszh1mgDuhoSKzNh+Syx9PclTnEI88/Py4DsqxeV6crBrkQjJk3xYFI9CevK+vlslhW2Tj1lDLw6k5sJDSr+gEA12cWNCGBa5ebVD2z+R64sqFVjcDQwRZjyTRh6XlxXGirzbOCbdzbIWJoSFmJyR+g9zwlUaI4+2Ppwh+wkNyXL208nJJ2fVH6qsCbBu2HqPn2tm7K1TfhKwDYTkKHdxg2dDe+0jwoGx0nXi76wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ne5rvtdni3UxISsp9O1nGoNq8ZPMeqdxIKt7KiO/aU=;
 b=HZ7bFY6YKquYTwRKil/cVgeNnaTgC9O9kU9b5QGoTosjmAZfZPvBFDQQIjONeNqeU6IDZJ2STNb24UQN6he+eqVf9E43ZlLLASc+X8b8otiXx10Dj2uMKz7WQFEoAOngb0RRSm+NN2qbIi4DvmkPcXiKv6+aZr2+RhfCwIGUoWcZPqVWxDRNxaLwKxDT102NFcsMkOuq0mXSA64ng+vpUWCmcynRIT7MA0LRPxU9GzvX3oncYGEacZKpmsAvzrPn/OU+rNs6TsLHkZh9cSgMkfn1oZGn+Cf6mLjNatwD677sOIibyVHwCOHKKorT1quuP1xmA9jlyOIkCmhgZe91tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ne5rvtdni3UxISsp9O1nGoNq8ZPMeqdxIKt7KiO/aU=;
 b=bGn840dw26qY0rpdyz3kNq0Z1Ugj5NMsoopSqEApiBX2GAY5Yda3jlllQ4BMLglfIX/UPcCxSbZijdI3GnJTPCazb+JNvwBlqiIjU6zXF+koUViBzWf81Cj4xAz/NeJMwXmCWuOSrg5sQ1J0HWaoSXzfvbJCfqXoNlcA7pGl8/E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 15:38:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 15:38:27 +0000
Subject: Re: [PATCH v4 0/9] Rework iotests/check
To: qemu-block@nongnu.org
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ac47239e-a94b-6203-2d82-a2b9d8efab77@virtuozzo.com>
Date: Sat, 20 Jun 2020 18:38:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.122) by
 AM0P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23 via Frontend Transport; Sat, 20 Jun 2020 15:38:26 +0000
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8d9719-1f4b-41e9-d18e-08d8152ff9d2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB547816CD9181EAA32A247780C1990@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qldHOPEv7OV82YHDM9cw1PuxkB1NBBcX1CtneyTPcpjk4LbZb7MLrRsthR2RBNmVopvjTQZAnMe8kklWyxbfTYdG0AgD6sUfue86UWxcj87A0/i9RUj1EtsffEkez9rah6DBeOv7x+XJXJK6tALmIpisMDqClvklHBATLpySUuEgziz6qdI7gEfsIGXXxVltLidHV+16UgX9MWA6WDveqlnU9c2qkVe2t8mbFI5iqfaULqr0ezcGUmDeVDauUZa/J8VgG1j3ZoDj9dGAowPWvXJm/HGVNKtEowt4C9n2t52ZW6diyQ62A3ue8ru/ZjPryeEHxIVjK7PBCMwwmhX6hi8SMsT7vynIDwUErF54XrWz5wAzgfY1tvRht4hYiPTx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39840400004)(396003)(8676002)(6486002)(30864003)(5660300002)(36756003)(2906002)(478600001)(6916009)(8936002)(4326008)(83380400001)(316002)(956004)(2616005)(16576012)(66946007)(66476007)(66556008)(26005)(52116002)(186003)(16526019)(31686004)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OIyFovol8sHwOkekJjBF1VZLPo9hclpKuTR81IxK+Q33nOoRUX1bGrlbb8cLo3ZNquujngqMJGHoISUPI4IEdbJfye+K4Y25TKMezbgoRJ+TCizicCoTs/hlHSZFDvA5xB82uxG/WyqMH3+bOJbA862dPBca+Fix8AelOfcC/NsigqghxkS2qCgnYoey3eNHzuKg6+ySQn/J77UtfxVJeJ/lFvPp9odrHYSQEvTVLr/i42ABPW9peG1SjwbCfuIPtc547vOzWtxi5ZIgNHIx7zFdpwVMoLPWos2vCFlEgqntITMyD7Lqflvd5WJLE7KqwrBa0cZgmydVXCbTyXCrSc7lZMpCOX88ecgam7wmvX+V+GkJqytUnIJ+e+Wt9QhOkCOQ85BL9kYe9ifrEz9b57cn0bGncMNfDFiQn9LasCRxqISRJQcPhBZgYFtfPtZyrbt7Pmi8NZvzsGgRd2dU5SiK92yjghGQB4RtHO4XoFxrlrYEXeIdS/JyvtcJogOt
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8d9719-1f4b-41e9-d18e-08d8152ff9d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 15:38:27.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bAPqk5X4ilUMnKsey0hVWPWI5aAWgsfs1EksZNDV9XpjsKkaYYL4nR/k//DoeRB5fTpkCrlUXIilhRS7oCunvJNL+UIAAAijrgFAkAL5ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.15.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 11:38:28
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping :)

(of course, master is updated and 04 should cover more iotests now, but still,
  the core scripts of the series need some review)

16.05.2020 00:14, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> These series has 3 goals:
> 
>   - get rid of group file
>   - introduce human-readable names for tests
>   - rewrite check into python
> 
> v4:
>     - human readable tests in  ..qemu-iotests/tests subdirectory
>     - add --start-from argument for findtests
>     - add type hinting
> 
> Vladimir Sementsov-Ogievskiy (9):
>    iotests/277: use dot slash for nbd-fault-injector.py running
>    iotests: fix some whitespaces in test output files
>    iotests/283: make executable
>    iotests: define group in each iotest
>    iotests: add findtests.py
>    iotests: add testenv.py
>    iotests: add testrunner.py
>    iotests: rewrite check into python
>    iotests: rename and move 169 and 199 tests
> 
>   docs/devel/testing.rst                        |  50 +-
>   tests/qemu-iotests/001                        |   1 +
>   tests/qemu-iotests/002                        |   1 +
>   tests/qemu-iotests/003                        |   1 +
>   tests/qemu-iotests/004                        |   1 +
>   tests/qemu-iotests/005                        |   1 +
>   tests/qemu-iotests/007                        |   1 +
>   tests/qemu-iotests/008                        |   1 +
>   tests/qemu-iotests/009                        |   1 +
>   tests/qemu-iotests/010                        |   1 +
>   tests/qemu-iotests/011                        |   1 +
>   tests/qemu-iotests/012                        |   1 +
>   tests/qemu-iotests/013                        |   1 +
>   tests/qemu-iotests/014                        |   1 +
>   tests/qemu-iotests/015                        |   1 +
>   tests/qemu-iotests/017                        |   1 +
>   tests/qemu-iotests/018                        |   1 +
>   tests/qemu-iotests/019                        |   1 +
>   tests/qemu-iotests/020                        |   1 +
>   tests/qemu-iotests/021                        |   1 +
>   tests/qemu-iotests/022                        |   1 +
>   tests/qemu-iotests/023                        |   1 +
>   tests/qemu-iotests/024                        |   1 +
>   tests/qemu-iotests/025                        |   1 +
>   tests/qemu-iotests/026                        |   1 +
>   tests/qemu-iotests/027                        |   1 +
>   tests/qemu-iotests/028                        |   1 +
>   tests/qemu-iotests/029                        |   1 +
>   tests/qemu-iotests/030                        |   1 +
>   tests/qemu-iotests/031                        |   1 +
>   tests/qemu-iotests/032                        |   1 +
>   tests/qemu-iotests/033                        |   1 +
>   tests/qemu-iotests/034                        |   1 +
>   tests/qemu-iotests/035                        |   1 +
>   tests/qemu-iotests/036                        |   1 +
>   tests/qemu-iotests/037                        |   1 +
>   tests/qemu-iotests/038                        |   1 +
>   tests/qemu-iotests/039                        |   1 +
>   tests/qemu-iotests/040                        |   1 +
>   tests/qemu-iotests/041                        |   1 +
>   tests/qemu-iotests/042                        |   1 +
>   tests/qemu-iotests/043                        |   1 +
>   tests/qemu-iotests/044                        |   1 +
>   tests/qemu-iotests/045                        |   1 +
>   tests/qemu-iotests/046                        |   1 +
>   tests/qemu-iotests/047                        |   1 +
>   tests/qemu-iotests/048                        |   1 +
>   tests/qemu-iotests/049                        |   1 +
>   tests/qemu-iotests/050                        |   1 +
>   tests/qemu-iotests/051                        |   1 +
>   tests/qemu-iotests/052                        |   1 +
>   tests/qemu-iotests/053                        |   1 +
>   tests/qemu-iotests/054                        |   1 +
>   tests/qemu-iotests/055                        |   1 +
>   tests/qemu-iotests/056                        |   1 +
>   tests/qemu-iotests/057                        |   1 +
>   tests/qemu-iotests/058                        |   1 +
>   tests/qemu-iotests/059                        |   1 +
>   tests/qemu-iotests/060                        |   1 +
>   tests/qemu-iotests/061                        |   1 +
>   tests/qemu-iotests/062                        |   1 +
>   tests/qemu-iotests/063                        |   1 +
>   tests/qemu-iotests/064                        |   1 +
>   tests/qemu-iotests/065                        |   1 +
>   tests/qemu-iotests/066                        |   1 +
>   tests/qemu-iotests/067                        |   1 +
>   tests/qemu-iotests/068                        |   1 +
>   tests/qemu-iotests/069                        |   1 +
>   tests/qemu-iotests/070                        |   1 +
>   tests/qemu-iotests/071                        |   1 +
>   tests/qemu-iotests/072                        |   1 +
>   tests/qemu-iotests/073                        |   1 +
>   tests/qemu-iotests/074                        |   1 +
>   tests/qemu-iotests/075                        |   1 +
>   tests/qemu-iotests/076                        |   1 +
>   tests/qemu-iotests/077                        |   1 +
>   tests/qemu-iotests/078                        |   1 +
>   tests/qemu-iotests/079                        |   1 +
>   tests/qemu-iotests/080                        |   1 +
>   tests/qemu-iotests/081                        |   1 +
>   tests/qemu-iotests/082                        |   1 +
>   tests/qemu-iotests/083                        |   1 +
>   tests/qemu-iotests/084                        |   1 +
>   tests/qemu-iotests/085                        |   1 +
>   tests/qemu-iotests/086                        |   1 +
>   tests/qemu-iotests/087                        |   1 +
>   tests/qemu-iotests/088                        |   1 +
>   tests/qemu-iotests/089                        |   1 +
>   tests/qemu-iotests/090                        |   1 +
>   tests/qemu-iotests/091                        |   1 +
>   tests/qemu-iotests/092                        |   1 +
>   tests/qemu-iotests/093                        |   1 +
>   tests/qemu-iotests/094                        |   1 +
>   tests/qemu-iotests/095                        |   1 +
>   tests/qemu-iotests/096                        |   1 +
>   tests/qemu-iotests/097                        |   1 +
>   tests/qemu-iotests/098                        |   1 +
>   tests/qemu-iotests/099                        |   1 +
>   tests/qemu-iotests/101                        |   1 +
>   tests/qemu-iotests/102                        |   1 +
>   tests/qemu-iotests/103                        |   1 +
>   tests/qemu-iotests/104                        |   1 +
>   tests/qemu-iotests/105                        |   1 +
>   tests/qemu-iotests/106                        |   1 +
>   tests/qemu-iotests/107                        |   1 +
>   tests/qemu-iotests/108                        |   1 +
>   tests/qemu-iotests/109                        |   1 +
>   tests/qemu-iotests/110                        |   1 +
>   tests/qemu-iotests/111                        |   1 +
>   tests/qemu-iotests/112                        |   1 +
>   tests/qemu-iotests/113                        |   1 +
>   tests/qemu-iotests/114                        |   1 +
>   tests/qemu-iotests/115                        |   1 +
>   tests/qemu-iotests/116                        |   1 +
>   tests/qemu-iotests/117                        |   1 +
>   tests/qemu-iotests/118                        |   1 +
>   tests/qemu-iotests/119                        |   1 +
>   tests/qemu-iotests/120                        |   1 +
>   tests/qemu-iotests/121                        |   1 +
>   tests/qemu-iotests/122                        |   1 +
>   tests/qemu-iotests/123                        |   1 +
>   tests/qemu-iotests/124                        |   1 +
>   tests/qemu-iotests/125                        |   1 +
>   tests/qemu-iotests/126                        |   1 +
>   tests/qemu-iotests/127                        |   1 +
>   tests/qemu-iotests/128                        |   1 +
>   tests/qemu-iotests/129                        |   1 +
>   tests/qemu-iotests/130                        |   1 +
>   tests/qemu-iotests/131                        |   1 +
>   tests/qemu-iotests/132                        |   1 +
>   tests/qemu-iotests/133                        |   1 +
>   tests/qemu-iotests/134                        |   1 +
>   tests/qemu-iotests/135                        |   1 +
>   tests/qemu-iotests/136                        |   1 +
>   tests/qemu-iotests/137                        |   1 +
>   tests/qemu-iotests/138                        |   1 +
>   tests/qemu-iotests/139                        |   1 +
>   tests/qemu-iotests/140                        |   1 +
>   tests/qemu-iotests/141                        |   1 +
>   tests/qemu-iotests/143                        |   1 +
>   tests/qemu-iotests/144                        |   1 +
>   tests/qemu-iotests/145                        |   1 +
>   tests/qemu-iotests/146                        |   1 +
>   tests/qemu-iotests/147                        |   1 +
>   tests/qemu-iotests/148                        |   1 +
>   tests/qemu-iotests/149                        |   1 +
>   tests/qemu-iotests/150                        |   1 +
>   tests/qemu-iotests/151                        |   1 +
>   tests/qemu-iotests/152                        |   1 +
>   tests/qemu-iotests/153                        |   1 +
>   tests/qemu-iotests/154                        |   1 +
>   tests/qemu-iotests/155                        |   1 +
>   tests/qemu-iotests/156                        |   1 +
>   tests/qemu-iotests/157                        |   1 +
>   tests/qemu-iotests/158                        |   1 +
>   tests/qemu-iotests/159                        |   1 +
>   tests/qemu-iotests/160                        |   1 +
>   tests/qemu-iotests/161                        |   1 +
>   tests/qemu-iotests/162                        |   1 +
>   tests/qemu-iotests/163                        |   1 +
>   tests/qemu-iotests/165                        |   1 +
>   tests/qemu-iotests/170                        |   1 +
>   tests/qemu-iotests/171                        |   1 +
>   tests/qemu-iotests/172                        |   1 +
>   tests/qemu-iotests/173                        |   1 +
>   tests/qemu-iotests/174                        |   1 +
>   tests/qemu-iotests/175                        |   1 +
>   tests/qemu-iotests/175.out                    |   2 +-
>   tests/qemu-iotests/176                        |   1 +
>   tests/qemu-iotests/177                        |   1 +
>   tests/qemu-iotests/178                        |   1 +
>   tests/qemu-iotests/179                        |   1 +
>   tests/qemu-iotests/181                        |   1 +
>   tests/qemu-iotests/182                        |   1 +
>   tests/qemu-iotests/183                        |   1 +
>   tests/qemu-iotests/184                        |   1 +
>   tests/qemu-iotests/185                        |   1 +
>   tests/qemu-iotests/186                        |   1 +
>   tests/qemu-iotests/187                        |   1 +
>   tests/qemu-iotests/188                        |   1 +
>   tests/qemu-iotests/189                        |   1 +
>   tests/qemu-iotests/190                        |   1 +
>   tests/qemu-iotests/191                        |   1 +
>   tests/qemu-iotests/192                        |   1 +
>   tests/qemu-iotests/194                        |   1 +
>   tests/qemu-iotests/195                        |   1 +
>   tests/qemu-iotests/196                        |   1 +
>   tests/qemu-iotests/197                        |   1 +
>   tests/qemu-iotests/198                        |   1 +
>   tests/qemu-iotests/200                        |   1 +
>   tests/qemu-iotests/201                        |   1 +
>   tests/qemu-iotests/202                        |   1 +
>   tests/qemu-iotests/203                        |   1 +
>   tests/qemu-iotests/204                        |   1 +
>   tests/qemu-iotests/205                        |   1 +
>   tests/qemu-iotests/206                        |   1 +
>   tests/qemu-iotests/207                        |   1 +
>   tests/qemu-iotests/208                        |   1 +
>   tests/qemu-iotests/209                        |   1 +
>   tests/qemu-iotests/210                        |   1 +
>   tests/qemu-iotests/211                        |   1 +
>   tests/qemu-iotests/212                        |   1 +
>   tests/qemu-iotests/213                        |   1 +
>   tests/qemu-iotests/214                        |   1 +
>   tests/qemu-iotests/215                        |   1 +
>   tests/qemu-iotests/216                        |   1 +
>   tests/qemu-iotests/217                        |   1 +
>   tests/qemu-iotests/218                        |   1 +
>   tests/qemu-iotests/219                        |   1 +
>   tests/qemu-iotests/220                        |   1 +
>   tests/qemu-iotests/221                        |   1 +
>   tests/qemu-iotests/222                        |   1 +
>   tests/qemu-iotests/223                        |   1 +
>   tests/qemu-iotests/224                        |   1 +
>   tests/qemu-iotests/225                        |   1 +
>   tests/qemu-iotests/226                        |   1 +
>   tests/qemu-iotests/227                        |   1 +
>   tests/qemu-iotests/228                        |   1 +
>   tests/qemu-iotests/229                        |   1 +
>   tests/qemu-iotests/231                        |   1 +
>   tests/qemu-iotests/232                        |   1 +
>   tests/qemu-iotests/233                        |   1 +
>   tests/qemu-iotests/234                        |   1 +
>   tests/qemu-iotests/235                        |   1 +
>   tests/qemu-iotests/236                        |   1 +
>   tests/qemu-iotests/237                        |   1 +
>   tests/qemu-iotests/238                        |   1 +
>   tests/qemu-iotests/239                        |   1 +
>   tests/qemu-iotests/240                        |   1 +
>   tests/qemu-iotests/241                        |   1 +
>   tests/qemu-iotests/242                        |   1 +
>   tests/qemu-iotests/243                        |   1 +
>   tests/qemu-iotests/244                        |   1 +
>   tests/qemu-iotests/245                        |   1 +
>   tests/qemu-iotests/246                        |   1 +
>   tests/qemu-iotests/247                        |   1 +
>   tests/qemu-iotests/248                        |   1 +
>   tests/qemu-iotests/249                        |   1 +
>   tests/qemu-iotests/250                        |   1 +
>   tests/qemu-iotests/251                        |   1 +
>   tests/qemu-iotests/252                        |   1 +
>   tests/qemu-iotests/253                        |   1 +
>   tests/qemu-iotests/254                        |   1 +
>   tests/qemu-iotests/255                        |   1 +
>   tests/qemu-iotests/256                        |   1 +
>   tests/qemu-iotests/257                        |   1 +
>   tests/qemu-iotests/258                        |   1 +
>   tests/qemu-iotests/259                        |   1 +
>   tests/qemu-iotests/260                        |   1 +
>   tests/qemu-iotests/261                        |   1 +
>   tests/qemu-iotests/262                        |   1 +
>   tests/qemu-iotests/263                        |   1 +
>   tests/qemu-iotests/264                        |   1 +
>   tests/qemu-iotests/265                        |   1 +
>   tests/qemu-iotests/266                        |   1 +
>   tests/qemu-iotests/267                        |   1 +
>   tests/qemu-iotests/267.out                    |  48 +-
>   tests/qemu-iotests/268                        |   1 +
>   tests/qemu-iotests/270                        |   1 +
>   tests/qemu-iotests/272                        |   1 +
>   tests/qemu-iotests/273                        |   1 +
>   tests/qemu-iotests/274                        |   1 +
>   tests/qemu-iotests/277                        |   3 +-
>   tests/qemu-iotests/279                        |   1 +
>   tests/qemu-iotests/280                        |   1 +
>   tests/qemu-iotests/281                        |   1 +
>   tests/qemu-iotests/282                        |   1 +
>   tests/qemu-iotests/283                        |   1 +
>   tests/qemu-iotests/284                        |   1 +
>   tests/qemu-iotests/286                        |   1 +
>   tests/qemu-iotests/287                        |   1 +
>   tests/qemu-iotests/287.out                    |  10 +-
>   tests/qemu-iotests/288                        |   1 +
>   tests/qemu-iotests/289                        |   1 +
>   tests/qemu-iotests/290                        |   1 +
>   tests/qemu-iotests/292                        |   1 +
>   tests/qemu-iotests/check                      | 983 +-----------------
>   tests/qemu-iotests/findtests.py               | 229 ++++
>   tests/qemu-iotests/group                      | 302 ------
>   tests/qemu-iotests/testenv.py                 | 325 ++++++
>   tests/qemu-iotests/testrunner.py              | 351 +++++++
>   .../migrate-bitmaps-postcopy-test}            |   1 +
>   .../migrate-bitmaps-postcopy-test.out}        |   0
>   .../{169 => tests/migrate-bitmaps-test}       |   1 +
>   .../migrate-bitmaps-test.out}                 |   0
>   285 files changed, 1287 insertions(+), 1289 deletions(-)
>   mode change 100644 => 100755 tests/qemu-iotests/283
>   create mode 100755 tests/qemu-iotests/findtests.py
>   delete mode 100644 tests/qemu-iotests/group
>   create mode 100755 tests/qemu-iotests/testenv.py
>   create mode 100644 tests/qemu-iotests/testrunner.py
>   rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (99%)
>   rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
>   rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (99%)
>   rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)
> 


-- 
Best regards,
Vladimir

