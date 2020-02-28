Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCBAC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066E3246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SXKPOuul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066E3246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7anA-0003oN-5R
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 03:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7amJ-0003Lo-Od
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7amG-0004KY-4w
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:13:47 -0500
Received: from mail-eopbgr150098.outbound.protection.outlook.com
 ([40.107.15.98]:50901 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7am7-0004Di-O7; Fri, 28 Feb 2020 03:13:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCTTuyh682fDSfPyLu6oojQGeVeHHVE5nD8b6ky+AJENOOmlXxCe7mIOAaQdwlCLc6LjE1fviK8sFl+dzs3AwpLiWXiyeb7KWBaxC5ObQuDiF5uHRxesUx4aU1BXJehP/QkCjpraJfMkrE2wXo1JSMDBwK931wi49g27gIbHhtZt4UxiQQ3JqtkPCCzmiKK0RrBtKBHxnFzy+Hm8gMn0YH19FSAopKuVEpyFZOAYL62HoE5mnPZPi2XrqlmGJIZFgtCXYua2K9tY4F2PqZ9P6AVZxXp8FLE3vR/R4iAh8MvxvOhctpcXCfXdmnPYB7ktaaF1Zf6rj8mUndWDixEikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFrjEZNzxTvoq0gLid5pGRezLRRDXpeTU4Dc7E7wAJA=;
 b=lgwNZ1gCwYi8GysXKPrXyruMwf9DrX3t/ce3FA4es8bqi9LmCIv2Lg69vJtxraf2N0yOqMyAl8uuAJ57xyN61HCDuu7c7nvBhqRbafZ3ZWU/43koVgfp2wSjVDzDBllof5pDF084XRfYoZaXnSbTNbkrxEM25Cq6jacshwQb0kOm+/WPnbqAgBY6o71r16JHXBZPGYYa3aUtdZlZFJxm1qAH9FoKhpM6LmJc6CZUSm6idf9WkxiTY8zIaDpwZci7MvakD2f4ptmh/bw+jkx30udJg8xijfWiUhs//scRAoIYQx8swLO+MftutK7ar4/Ci6Oj5tmRPK89ZaEUqNN24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFrjEZNzxTvoq0gLid5pGRezLRRDXpeTU4Dc7E7wAJA=;
 b=SXKPOuulrBHY9PIjFzkX7YV0/oZLWyQZTqajwfIM2YxgQKi9fbutuEvFflwmt96JnBlhVGTylszFCDVAv9WTmWlq8OdODeSIliQRE0fLnDm1ZsRMpX5avcqO3xTpt/mEob0znuZt3+gPm7ELb+DXCInBTJ/b2S3wD8S8gn7wpbg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4418.eurprd08.prod.outlook.com (20.179.35.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 28 Feb 2020 08:13:31 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 08:13:31 +0000
Subject: Re: [PATCH v1 6/8] iotests: add "compression type" for test output
 matching
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-7-dplotnikov@virtuozzo.com>
 <8003b87c-0d0d-6b00-0065-0b227ec97221@virtuozzo.com>
 <2e55b711-4af0-b1a0-8736-6391d81db8ab@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <9b04ca7c-46ba-5865-e093-84c001661617@virtuozzo.com>
Date: Fri, 28 Feb 2020 11:13:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <2e55b711-4af0-b1a0-8736-6391d81db8ab@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR09CA0071.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::15) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.162.229) by
 HE1PR09CA0071.eurprd09.prod.outlook.com (2603:10a6:7:3d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Fri, 28 Feb 2020 08:13:30 +0000
X-Originating-IP: [178.34.162.229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a266ca82-295f-4985-242b-08d7bc2618e9
X-MS-TrafficTypeDiagnostic: AM0PR08MB4418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4418A6926CF87CE777FDE32ACFE80@AM0PR08MB4418.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(39850400004)(366004)(189003)(199004)(2616005)(66946007)(4326008)(956004)(6666004)(2906002)(6486002)(30864003)(81166006)(81156014)(26005)(186003)(316002)(66476007)(8676002)(31696002)(16576012)(16526019)(31686004)(66556008)(5660300002)(8936002)(53546011)(86362001)(478600001)(52116002)(36756003)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4418;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjTI3sQzWlERTC+TolFLcNoIipRbljJ8WulJTcyGYVMpn9SRA+aycFWOzxv96JvvW+T7ir1UOFYlpVARkJu6XpqLD0k+Xiy0xMobfQgoU1qJ/mx5oH1YkjRUXLE+ZeasUhyn/9ypBB0cqjEBtoTH8D4Jrj5mrBjNNKpovcKtAn9hYB0+0Z2RPTTPnaB7MswbgSNAZkwCQryG0iYR2Up0saqI9mFNbWYc8EPTahbfAJn03TYyikDLSm1F3cCEVpGtjmTIKcgt4lJ/LRCEk5aSpUl2mcAuSLDXHzJ2VhftieMBvoZzgc6pCSG6Do5n4ajb45lYdRLxDte25xM/PRCP5S2KX3CZphRSR/3/B8prJMgP5Qyi8WryOymgn4S5yvV4poqa6Xch+V9j47JSlG/VIhGTBL5Yf1le5WJ8aF8OmEMkREoq4+EBO8xUtKtno+YJATHfsxtXrSRl8KmGrjyce3kLGM3r01YdimgvMohc7nmMBTM5W5l/qvKIpuolhxvi
X-MS-Exchange-AntiSpam-MessageData: 0G5YkdnN4HJfSD56v4LT5cDeGzZNgxBuW4T1WHOAkNAb5VXpYiJmNEAiBo214opf/0Q2UT+PNbvDzZL9VAZD2D4frFGVggSn3oSLz7/l/iILPrloTvF3jkufBHALYkWqtcbMdVUI2gv7qIZx9OAi9w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a266ca82-295f-4985-242b-08d7bc2618e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 08:13:31.1214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYMgtMw4u2Xbdh9vhz+ltwTrBCo0ev+to99qBsgL11HevgqfTKOLqDRHH97plJXPr5V0QmhT5kWGHRMj+mlIWev3m9WCIqTRBwYGxd0l6DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4418
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.98
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.02.2020 13:09, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2020 13:04, Vladimir Sementsov-Ogievskiy wrote:
>> 27.02.2020 10:29, Denis Plotnikov wrote:
>>> Affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>>>
>>> After adding the compression type feature for qcow2, the compression=20
>>> type
>>> is reported on image quering.
>>>
>>> Add the corresponding values of the "compression type" for the=20
>>> tests' output
>>> matching.
>>
>> And this and the following patch.
>>
>> Ideally, patch should not break any iotests. This means that all=20
>> iotest updates
>> should be merged to the patch which changes their output. Probably,=20
>> you can split
>> behavior-changing patch, to reduce iotest-updates per patch, but=20
>> anyway, big patch
>> with a lot of iotests updates is better than patch which breaks iotests.
>
> Or we can try to reduce behavior changes in case of zlib:
>
> - keep header small in case of zlib, not adding zero field
> - don't add feature table entry, if compress type is zlib
> - don't report compression type on quering, if it is zlib
>
> - then, all iotests output will be saved. And, then, if we need, we=20
> can change
> these theree points one-by-one, updating iotests outputs. But I doubt=20
> that we
> really need it, compatible behavior seems good enough.
I think I would put some efforts in arranging the iotest patches
so they don't break any tests after applying
with the cost of creating a gigantic patch with the compression type=20
implementation
and iotest fixes

Denis

>
>>
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>> =C2=A0 tests/qemu-iotests/049.out | 102=20
>>> ++++++++++++++++++-------------------
>>> =C2=A0 tests/qemu-iotests/060.out |=C2=A0=C2=A0 1 +
>>> =C2=A0 tests/qemu-iotests/061.out |=C2=A0=C2=A0 6 +++
>>> =C2=A0 tests/qemu-iotests/065=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 20 +++++-=
--
>>> =C2=A0 tests/qemu-iotests/144.out |=C2=A0=C2=A0 4 +-
>>> =C2=A0 tests/qemu-iotests/182.out |=C2=A0=C2=A0 2 +-
>>> =C2=A0 tests/qemu-iotests/242.out |=C2=A0=C2=A0 5 ++
>>> =C2=A0 tests/qemu-iotests/255.out |=C2=A0=C2=A0 8 +--
>>> =C2=A0 8 files changed, 82 insertions(+), 66 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
>>> index affa55b341..a5cfba1756 100644
>>> --- a/tests/qemu-iotests/049.out
>>> +++ b/tests/qemu-iotests/049.out
>>> @@ -4,90 +4,90 @@ QA output created by 049
>>> =C2=A0 =3D=3D 1. Traditional size parameter =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 =3D=3D 2. Specifying size via -o =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024 TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024b TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1k TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1K TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1M TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1048576=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1G TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1073741824=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1T TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1099511627776=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024.0 TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1024.0b TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1024=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5k TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5K TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1536=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5M TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1572864=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5G TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1610612736=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o size=3D1.5T TEST_DIR/t.qcow2
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D1649267441664=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 =3D=3D 3. Invalid sizes =3D=3D
>>> @@ -129,84 +129,84 @@ qemu-img: TEST_DIR/t.qcow2: The image size=20
>>> must be specified only once
>>> =C2=A0 =3D=3D Check correct interpretation of suffixes for cluster size=
 =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024 TEST_DIR/t.qcow2=
 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024b TEST_DIR/t.qcow=
2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1k TEST_DIR/t.qcow2 6=
4M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1K TEST_DIR/t.qcow2 6=
4M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1M TEST_DIR/t.qcow2 6=
4M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1048576 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1048576 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024.0 TEST_DIR/t.qco=
w2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D1024.0b TEST_DIR/t.qc=
ow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D1024 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D0.5k TEST_DIR/t.qcow2=
 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D512 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D512 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D0.5K TEST_DIR/t.qcow2=
 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D512 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D512 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o cluster_size=3D0.5M TEST_DIR/t.qcow2=
 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D524288 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D524288 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 =3D=3D Check compat level option =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.10 TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
10=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
10=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D1.1 TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.=
1=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.=
1=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.42 TEST_DIR/t.qcow2 64M
>>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
42=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
42=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3Dfoobar TEST_DIR/t.qcow2 64M
>>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> compat=3Dfoobar cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> compat=3Dfoobar cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 =3D=3D Check preallocation option =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 -o preallocation=3Doff TEST_DIR/t.qcow2=
 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D65536 preallocation=3Doff lazy_refcounts=3Doff=20
>>> refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D65536 preallocation=3Doff lazy_refcounts=3Doff=20
>>> refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o preallocation=3Dmetadata=20
>>> TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff=20
>>> refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff=20
>>> refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o preallocation=3D1234 TEST_DIR/t.qcow=
2 64M
>>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D65536 preallocation=3D1234 lazy_refcounts=3Doff=20
>>> refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> cluster_size=3D65536 preallocation=3D1234 lazy_refcounts=3Doff=20
>>> refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 =3D=3D Check encryption option =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 -o encryption=3Doff TEST_DIR/t.qcow2 64=
M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> encryption=3Doff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> encryption=3Doff cluster_size=3D65536 lazy_refcounts=3Doff=20
>>> refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 --object secret,id=3Dsec0,data=3D123456=
 -o=20
>>> encryption=3Don,encrypt.key-secret=3Dsec0 TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> encryption=3Don encrypt.key-secret=3Dsec0 cluster_size=3D65536=20
>>> lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864=20
>>> encryption=3Don encrypt.key-secret=3Dsec0 cluster_size=3D65536=20
>>> lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 =3D=3D Check lazy_refcounts option (only with v3) =3D=3D
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D1.1,lazy_refcounts=3Doff=20
>>> TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.=
1=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.=
1=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D1.1,lazy_refcounts=3Don=20
>>> TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.=
1=20
>>> cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D1.=
1=20
>>> cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Doff=20
>>> TEST_DIR/t.qcow2 64M
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
10=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
10=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 qemu-img create -f qcow2 -o compat=3D0.10,lazy_refcounts=3Don=20
>>> TEST_DIR/t.qcow2 64M
>>> =C2=A0 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with=20
>>> compatibility level 1.1 and above (use version=3Dv3 or greater)
>>> -Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
10=20
>>> cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 compat=3D0.=
10=20
>>> cluster_size=3D65536 lazy_refcounts=3Don refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 *** done
>>> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
>>> index d27692a33c..3e47f537e8 100644
>>> --- a/tests/qemu-iotests/060.out
>>> +++ b/tests/qemu-iotests/060.out
>>> @@ -17,6 +17,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corrupt: true
>>> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
>>> index cea7fedfdc..c913f02ad6 100644
>>> --- a/tests/qemu-iotests/061.out
>>> +++ b/tests/qemu-iotests/061.out
>>> @@ -491,6 +491,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>>> @@ -511,6 +512,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: foo
>>> @@ -524,6 +526,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file raw: false
>>> @@ -538,6 +541,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>>> @@ -550,6 +554,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>>> @@ -563,6 +568,7 @@ virtual size: 64 MiB (67108864 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data file: TEST_DIR/t.IMGFMT.data
>>> diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
>>> index 6426474271..106303b5a5 100755
>>> --- a/tests/qemu-iotests/065
>>> +++ b/tests/qemu-iotests/065
>>> @@ -88,23 +88,25 @@ class TestQMP(TestImageInfoSpecific):
>>> =C2=A0 class TestQCow2(TestQemuImgInfo):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 2 image'''
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D0.10'
>>> -=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '0.10', 'refcount-bits=
': 16 }
>>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 0.10', 'refcount bits:=
 16' ]
>>> +=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '0.10', 'refcount-bits=
': 16,=20
>>> 'compression-type': 'zlib' }
>>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 0.10', 'compression ty=
pe: zlib',=20
>>> 'refcount bits: 16' ]
>>> =C2=A0 class TestQCow3NotLazy(TestQemuImgInfo):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 3 image with =
lazy refcounts=20
>>> disabled'''
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refco=
unts=3Doff'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '1.1', 'laz=
y-refcounts': False,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False }
>>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'lazy refcounts:=
 false',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zl=
ib' }
>>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'compression typ=
e: zlib',=20
>>> 'lazy refcounts: false',
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refc=
ount bits: 16', 'corrupt: false' ]
>>> =C2=A0 class TestQCow3Lazy(TestQemuImgInfo):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '''Testing a qcow2 version 3 image with =
lazy refcounts enabled'''
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refco=
unts=3Don'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 json_compare =3D { 'compat': '1.1', 'laz=
y-refcounts': True,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False }
>>> -=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'lazy refcounts:=
 true',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'c=
orrupt': False,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zl=
ib' }
>>> +=C2=A0=C2=A0=C2=A0 human_compare =3D [ 'compat: 1.1', 'compression typ=
e: zlib',=20
>>> 'lazy refcounts: true',
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'refc=
ount bits: 16', 'corrupt: false' ]
>>> =C2=A0 class TestQCow3NotLazyQMP(TestQMP):
>>> @@ -113,7 +115,8 @@ class TestQCow3NotLazyQMP(TestQMP):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refco=
unts=3Doff'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_options =3D 'lazy-refcounts=3Don'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compare =3D { 'compat': '1.1', 'lazy-ref=
counts': False,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zlib' }
>>> =C2=A0 class TestQCow3LazyQMP(TestQMP):
>>> @@ -122,7 +125,8 @@ class TestQCow3LazyQMP(TestQMP):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 img_options =3D 'compat=3D1.1,lazy_refco=
unts=3Don'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_options =3D 'lazy-refcounts=3Doff'
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compare =3D { 'compat': '1.1', 'lazy-ref=
counts': True,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'refcount-bits': 16, 'corrupt': False,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'compression-type': 'zlib' }
>>> =C2=A0 TestImageInfoSpecific =3D None
>>> =C2=A0 TestQemuImgInfo =3D None
>>> diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
>>> index c7aa2e4820..885a8874a5 100644
>>> --- a/tests/qemu-iotests/144.out
>>> +++ b/tests/qemu-iotests/144.out
>>> @@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT=20
>>> size=3D536870912
>>> =C2=A0 { 'execute': 'qmp_capabilities' }
>>> =C2=A0 {"return": {}}
>>> =C2=A0 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device':=
=20
>>> 'virtio0', 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT'=20
>>> } }
>>> -Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D536870912=20
>>> backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D6553=
6=20
>>> lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D536870912=20
>>> backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D6553=
6=20
>>> lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 {"return": {}}
>>> =C2=A0 =3D=3D=3D Performing block-commit on active layer =3D=3D=3D
>>> @@ -31,6 +31,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2=20
>>> size=3D536870912 backing_file=3DTEST_DIR/
>>> =C2=A0 =3D=3D=3D Performing Live Snapshot 2 =3D=3D=3D
>>> =C2=A0 { 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device':=
=20
>>> 'virtio0', 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format':=20
>>> 'IMGFMT' } }
>>> -Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 size=3D536870912=20
>>> backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D6553=
6=20
>>> lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 size=3D536870912=20
>>> backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D6553=
6=20
>>> lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 {"return": {}}
>>> =C2=A0 *** done
>>> diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
>>> index a8eea166c3..ae43654d32 100644
>>> --- a/tests/qemu-iotests/182.out
>>> +++ b/tests/qemu-iotests/182.out
>>> @@ -13,7 +13,7 @@ Is another process using the image=20
>>> [TEST_DIR/t.qcow2]?
>>> =C2=A0 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0',=
=20
>>> 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
>>> =C2=A0 {"return": {}}
>>> =C2=A0 {'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name'=
:=20
>>> 'node0', 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay',=20
>>> 'snapshot-node-name': 'node1' } }
>>> -Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120=20
>>> backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536=
=20
>>> lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120=20
>>> backing_file=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536=
=20
>>> lazy_refcounts=3Doff refcount_bits=3D16 compression_type=3Dzlib
>>> =C2=A0 {"return": {}}
>>> =C2=A0 {'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1',=
=20
>>> 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
>>> =C2=A0 {"return": {}}
>>> diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
>>> index 7ac8404d11..091b9126ce 100644
>>> --- a/tests/qemu-iotests/242.out
>>> +++ b/tests/qemu-iotests/242.out
>>> @@ -12,6 +12,7 @@ virtual size: 1 MiB (1048576 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refcount bits: 16
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 corrupt: false
>>> @@ -32,6 +33,7 @@ virtual size: 1 MiB (1048576 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>>> @@ -64,6 +66,7 @@ virtual size: 1 MiB (1048576 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>>> @@ -104,6 +107,7 @@ virtual size: 1 MiB (1048576 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>>> @@ -153,6 +157,7 @@ virtual size: 1 MiB (1048576 bytes)
>>> =C2=A0 cluster_size: 65536
>>> =C2=A0 Format specific information:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compat: 1.1
>>> +=C2=A0=C2=A0=C2=A0 compression type: zlib
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lazy refcounts: false
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmaps:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
>>> diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
>>> index 348909fdef..a3c99fd62e 100644
>>> --- a/tests/qemu-iotests/255.out
>>> +++ b/tests/qemu-iotests/255.out
>>> @@ -3,9 +3,9 @@ Finishing a commit job with background reads
>>> =C2=A0 =3D=3D=3D Create backing chain and start VM =3D=3D=3D
>>> -Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> -Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 =3D=3D=3D Start background read requests =3D=3D=3D
>>> @@ -23,9 +23,9 @@ Closing the VM while a job is being cancelled
>>> =C2=A0 =3D=3D=3D Create images and start VM =3D=3D=3D
>>> -Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> -Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 size=3D134217728=20
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
>>> compression_type=3Dzlib
>>> =C2=A0 wrote 1048576/1048576 bytes at offset 0
>>> =C2=A0 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>
>>
>>
>
>


