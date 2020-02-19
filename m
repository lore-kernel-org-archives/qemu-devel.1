Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825EEC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5088320801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FCl6iAHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5088320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4T4Y-0006ox-GA
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4T3p-000688-H6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4T3o-0000Ao-F6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:22:57 -0500
Received: from mail-eopbgr140133.outbound.protection.outlook.com
 ([40.107.14.133]:16130 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4T3j-00007B-Ja; Wed, 19 Feb 2020 12:22:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfVyLi4JKp3TLRKZ4NRKWqMV8+yJdeNpLDtNLzRwNphUk6vFzXH+RwAbTKv4fU7cYznOcLtiha6o7Il48SplFEqdlexOpGZLvp/Z42vco7ulxwGhM2PrD0Tf5pDWgPEG6LNUWvHbh9m/2YgRNQHUeqqwqv+nshUNZpiZA5ef5N1cK/DgmLz3/gYjPK9hUh839baT/vmfFLeZMOxrF1JXtE7juWAaGqtvlkMDg5JIo1gnj1rJzjv1FfLWUOoihzNxjxg5h5XTQ69mjzLB4Txp8ge92Yfys6hhDoG+QbNF25s1EN9a1ydM8mzygpNP1yQPMI2P2ECH/YybECWMUC7iiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoQxArQfo5wbCkJEca/WloW50oUdijQS3s0r3V9yN9o=;
 b=LqroLHLD1+dWeP1H4hDJnF9IFcOB3hBWQQG2M5eerZtNrgL4rVdZoBGkiJX+B8GPQX2eDHaRwcyfPvjeOR1whPvPTZQJWHLZ3h5wnAernANmDCIaJEqvy+RtnajGP7xFnb3zLVrjjkfW8Yr+XoB6ZJsscHcYtv84VBcQhNMyvWoidAtrpTR0wicwmJmqsUJfu0zO1SORlu3PNXZV83k6+zFhYFUFs9ayjPEDTCkwvnV2yDVbPX8uygAdvTsXlpz96dI/3Eui94NaB5UfyMo8WdELu8Q+vN/6J57Lp+K+Jf4jLIfkFr9ok2e/PvSZv3ImPMOgsfkAKxh7BgCTlCXFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoQxArQfo5wbCkJEca/WloW50oUdijQS3s0r3V9yN9o=;
 b=FCl6iAHH8WNHzx1E/o3H6GYMnUvMCca7ry0XJkoAXnUz6IDkadYud+1dkDcSOIH9hbNP9viDOSjYNU2kmDjd4lTRBlZ20GfRykNXXMmKsix2lft/PJoTF7+KKlmWvD/PvWwR2oABHyQqeuOtXe7AX0Rk33GCGPi+Uq0/PYRDTU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5285.eurprd08.prod.outlook.com (20.179.0.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 17:22:49 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 17:22:48 +0000
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <33fa0ba7-714f-c78d-8ca5-1e15dcef5ac4@virtuozzo.com>
 <f44bfdb9-0ddc-3b1a-0279-7e9ebd9f399f@redhat.com>
 <b0e67ac9-987b-811e-f0ac-7a9c92a2771a@virtuozzo.com>
 <633ea62c-dad6-9cd6-1490-7a827f036417@redhat.com>
 <ac78111c-853c-50c1-0cc9-cdab2d9a3432@virtuozzo.com>
 <5e9782d0-2f8b-bcf8-a84c-0a04bbe5545d@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <ed6f4a7c-c957-2c09-85d6-686414910605@virtuozzo.com>
Date: Wed, 19 Feb 2020 20:22:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <5e9782d0-2f8b-bcf8-a84c-0a04bbe5545d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::23) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0502CA0013.eurprd05.prod.outlook.com (2603:10a6:3:e3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 17:22:47 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5c58d4-165f-42a0-bc15-08d7b560578f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5285609E8993E5462D28945EF4100@AM6PR08MB5285.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(39850400004)(346002)(199004)(189003)(8936002)(54906003)(110136005)(36756003)(16576012)(66476007)(4744005)(316002)(81166006)(81156014)(8676002)(66946007)(5660300002)(31686004)(478600001)(6486002)(44832011)(53546011)(86362001)(66556008)(7416002)(956004)(52116002)(2616005)(966005)(31696002)(2906002)(186003)(36916002)(16526019)(26005)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5285;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PO2BkrlsGnf6WINPREKymqMs016ZGZPhKovrLQH5ihA/OGfNnPQtVALPupcxMmT7b6mskcNi1RdWq1WndiqXezXnyndB3TBnSXd+WxCoSpdd73/d1YZXPYDDLQFuHAVCdG9ojeu3fX5R+prNc3vLc8PI/AAB8NH8A6Pdhro4Fl0PSBQRos6eDkqxjMLHMHUJcT1RYAevVALxp+dujkppObOTe2eDO5PK4j4XSmQp8xz8r1kkdIvRZ/T5oYk2JpVIrJOOyrEgniwGCt1Gg+qfF7zHsM9J7F4aUg6HFfKagIM9t7R6P5ZdIh9WfDSrdA6ZvzVAmpWYHoj1lIxqwPEwUgtkcalipdY116FcwmIbzh3MaamDlIVXKWF3PfDPBaNF0EzGxzCBU4fe9ZBdmMuKUj+gOWlxzO8+AiHuirUUl+3xrxjvU8lNHFyksgG7JonYBv6bEc/uf33QgnFJ/cOom5YWbJ48R1/9SoQwJXZJLRUIsIAfm6X6mvtAufTt6rfCs4EBNCEf1Ce1UmQ59CtT5g==
X-MS-Exchange-AntiSpam-MessageData: BO+JYhYAAUkEVJ5W2sULEayzpRJPHC3R62MbpRBrNpENJYiS3QD7IMPtrnH08GXE775Ws719oFO3W4KSSLg2Ko/GiakgIi5WROofEmd80IL9PjJaZVO5Md22eVaM+9OZDNMBZtN8QocAofMaCSnqmw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5c58d4-165f-42a0-bc15-08d7b560578f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 17:22:48.8279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3nfA0FuptiKFPvuzTD4VjL4o7bkn1JCHHXD+JWtnU80xDgCtbVaOpd29eV1l0JccrItpCJtCXij+sYEBo/0qFjV2WsDKm59IHQMbNmVq6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5285
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.133
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19/02/2020 17:58, Eric Blake wrote:
> On 2/19/20 7:52 AM, Andrey Shinkevich wrote:
>=20
>>>> +od: unrecognized option '--endian=3Dbig'
>>>> +Try 'od --help' for more information.
>>>> +od: invalid -N argument '--endian=3Dbig'
>>>
>>> Yay, same problem for both tests.=C2=A0 Fix common.rc once, and both te=
sts=20
>>> should start working for you.
>>
>> Thank you Eric! I want to sort it out later...
>=20
> Patch proposed:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05188.html
>=20
>=20

Thank you Eric, I appreciate.
--=20
With the best regards,
Andrey Shinkevich


