Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF3EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8FF2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gxuCNhIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8FF2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8lYw-0004SB-H3
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j8lYE-0003bk-1Q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j8lYC-0002ZG-L2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:56:05 -0500
Received: from mail-eopbgr10111.outbound.protection.outlook.com
 ([40.107.1.111]:24704 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j8lYB-0002Ys-OL; Mon, 02 Mar 2020 08:56:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAYFbbKWB3zEWr7X7+vCO9bSYqzE5KoKhGb6CDsySH8WEskhVx2nuE8MiZ1BlbcLsiUGWE+nMyjFPvh99x2e2NIb3lUffqUFsI5AMTMTdLTk3Z71AjUKS5slkT7/8vHa84DRpf03v6kzfa7fQQjEznk8zjtB1xW6EVzS6ieYe+tgC9PGHgpwtg4WhouXx411JctSPFTA++SuA8ueHo2aBezv1UGcYnRL2g5Gjk0Vs/K7JoQwXgfKpio5oKY7lXUc98jDHvKFtVEAr2i2TTsz1enlGVTPnamdoYoyOCyQ9bAyhFUUQG/tjknEv7iekrXascFpnd/tUxKNCj9xEzIKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qyyxu0c632Ay6NdsMxXIWIj/leIXBu8bguDI8PtB3U=;
 b=NcOjbj0DOvHIjnhniJsu7x7OIqYkHrvDonwTLHtFXqCRz8HlHmWVwfnR2hrusMdvdH9r1OYtjdNlYNf5QOiGvf1+lmIy71pq+lLaai0EBYKpk3j6eBloaQ5JJFbnBZv9egH00cId1Evy9zVGRbOddcBd7i+0kioPUDSkve2ALixONSRkSr7dI6SzTN1V65fiXxAFpqpT1Y26NbiEjY8MKyMPfzBL/tvo8GMp6ndWnGSdPzP8cpC/X6EmbZamj9MlMXEN1tQYCyOs2qRWHBOKUD24Jl0FRiScbFSHONSKn/E+uuFG6inEvZm1y375qv6EHIBSuLT7bNUyOxcehGTDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qyyxu0c632Ay6NdsMxXIWIj/leIXBu8bguDI8PtB3U=;
 b=gxuCNhIzegP6lfkACrhavvrggpyv/9+35ttYsEh31N+qoy9F+mrk0oVk7bnToDyRUcKW2GxNESTbwtasqEN0dYIJGwvzOcYiyG202YLptKx2xiRokr8CNGxcHlGJELTSLj2CRqpHwkd4bFGgKme5L2Syp4zOYk6+1eOMW9fYCp8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5026.eurprd08.prod.outlook.com (10.255.28.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 13:56:00 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 13:56:00 +0000
Subject: Re: [PATCH v0 0/2] allow to set 'drive' property on a realized block
 device
To: Kevin Wolf <kwolf@redhat.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20200302133837.GC4965@linux.fritz.box>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20b9cc1f-8fbe-99fc-bbdb-5605b1c186a9@virtuozzo.com>
Date: Mon, 2 Mar 2020 16:55:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200302133837.GC4965@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0359.eurprd05.prod.outlook.com
 (2603:10a6:7:94::18) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.179) by
 HE1PR05CA0359.eurprd05.prod.outlook.com (2603:10a6:7:94::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 13:55:59 +0000
X-Originating-IP: [178.34.150.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f2c40bc-3428-46c4-0083-08d7beb17072
X-MS-TrafficTypeDiagnostic: AM0PR08MB5026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5026669DA644A87C40AD44A2CFE70@AM0PR08MB5026.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(136003)(39850400004)(396003)(346002)(189003)(199004)(66556008)(2906002)(66476007)(478600001)(66946007)(31686004)(81156014)(8676002)(81166006)(31696002)(16576012)(53546011)(956004)(2616005)(4326008)(966005)(107886003)(316002)(26005)(36756003)(6916009)(5660300002)(16526019)(6486002)(52116002)(186003)(6666004)(86362001)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5026;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WceIVviYeMGzWwCg2rv9l3ov9bXOH4Qvim+uju/JY4RiiZUQybgNExjdJzF94hDIpLH4+ityaG5GrmMTNsxHJNlKrIWGGNC5R+tdd9hGTPTpDra1i0LITQazc1lXmSivgdvn7LqnsnRdZJDlAMt8LrnoKQB2bw6MMsePTRiy+gpZcBsLHcsrqqu3w4cv3iaQ71p+j/6HF8piETxuEjsHHPZT1YpUHCr83Vu7QDSQOBnKz5zfTUwkVGVkMA+l5/Ur0ARJsQiOnXXQcXozdkE5Z6Uo+oOgu/1JjyZE6D6ZoEwWnHCrc/zfwbto40NwshpPlB/VsFsOzbcgvg+LlkirugzrcW1IjESlgrWLxhVsRwFFt1Iut04z+R+rK97SNrry5JNGjCNirqAvJKKP/NUYHBuK+UrFGNSlZXA0l7expSuytsp8uLpIJ1jSj6nN0V2f93e14E6tYn6sMQgBMZsaremqicSWdQLokA1Yq4pvdQyS4X3Rb2TqLs9n5sY2v4bE5k5Ya4Sgv1I+DqBgDZKRrA==
X-MS-Exchange-AntiSpam-MessageData: cRb5M6ZqLmllLYr02y1i8KMHLPmoAYaadw2K/6Qqv9/Bae7tCn2CqxbUbxsJHjNsXxbwyLta3J7inUPaXGOaLCWO7CD+bDSNPc/Ohta+eVMemfWahuDVpa3UE0FhUm4xUdYhKEXTmTfv8W3QMr6HXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2c40bc-3428-46c4-0083-08d7beb17072
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 13:56:00.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcYoRmeSFFo6UGYRU7qFGAZDKFBaqDvL8cmZ/8OcQtQxXqcXZpWm//gOPEytd5qaORGedPBQdOQVgZU9Selzjf28ZtuRwih5DnD4+XRvmWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5026
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.111
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02.03.2020 16:38, Kevin Wolf wrote:
> Am 10.11.2019 um 20:03 hat Denis Plotnikov geschrieben:
>> This allows to replace the file on a block device and is useful
>> to workaround the cases (migration) when the VM image is placed on
>> some shared storage with exclusive file opening model but the image
>> should be open form more than one app.
>>
>> The previous version of approaching the workaround was based on the
>> "blockdev-change-medium" command modification but had some flaws:
>>    * semantics: blockdev-change-medium is aimed to be used with removable devices
>>      only
>>    * interface: it can't accept all possible combination of parameters for
>>      the "drive" replacement (creation).
>>
>> More details here: http://patchwork.ozlabs.org/patch/1179329/
>>
>> The current series suggests another approach:
>> 1. blockdev-add
>> 2. qom-set disk.drive = the blockdev added (this is what the series adds)
> Are you still planning to send another version?
>
> Kevin
Not in the near future :) There is an unresolved problem with 
bitmap-migration is case of block dev replacement.
Still don't know how to do it in the proper way.

Denis
>


