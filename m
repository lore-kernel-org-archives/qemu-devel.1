Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F0DC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6727B2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e4FyjJl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6727B2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTk7g-0005eM-Hl
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTk6v-0004kw-Vi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTk6v-0002Zf-HY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:38:37 -0400
Received: from mail-eopbgr130111.outbound.protection.outlook.com
 ([40.107.13.111]:53793 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTk6t-0002Yc-Q9; Wed, 29 Apr 2020 06:38:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2yuiFs1+tA3ZsrtBxuq7xMPmiqhti13fIiBmS/Xj489+LVrQqVVcELlzgqy8vjkWNbD9kce508HUwrEggYrERZrDqrrqjmBV63hO+O39q9Um24rhQaIYIcI8Py4aBPffBUTJYvk38YZYj3jgUTIc93ZJE05rKxmMzkf+AAHQ+rTooFaroHI2azx8g4QCeAxXKrHBjIhoZe7FdjlpIEtU2lMsyJ4cQKQUoY5//KxgVON08AzqVURx8i2K+fCPfawx5EnBBqXZzmlPEJUy0MDgQv459DuI9VIlYs8jIWRXwiYn3zTJABzEbVTniG03B0pMsb+RbtlFFVhm0O+ImJQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfKZClHxdpr4FMkr2EmbP4DZlivuKR5FEcAFUANMjpI=;
 b=HGrUw+IKt9y+mwZpCSMoJ4HrXP/ohEH5dD29vDhKfv2MJr+kI+ral8tMJd119czBA58RLw0jaUZYqbh0AJLoC/iDj//+FavI0tnLYJUhgGE5tZehzOieu3xAo/jW1c4IEe4SPgWJJUh5hO4GLQKwys/BLt7NO7KTb91bBwEnDQcmJVyB/QkfwQgV97PHSravem381JYCFGBKEU11g/WfsPn2olPJBLElpXP9zy2SrAzAjO3oFFxG8mGdkexg9PuGGKK5pchfnYvu61RGc2Xt2/VeAUG6dcSWIIJsaFSFUWe0WzsUTRIU5pLi7ZwiQPFoyZTCfMN/QZ7HeNoxwwMu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfKZClHxdpr4FMkr2EmbP4DZlivuKR5FEcAFUANMjpI=;
 b=e4FyjJl864mJidMAJH0HlSO4MczFcHRjHRw05IjhIrBoRe8M5VA2+AgGBKPgclUTFjA0Rh4xadmc7/zpzCKtvcuhjDYElnVDp/gQogPWtupJ33mJ6KAOlefupCRnKbBsv53KUUO3Un8RE3jxH9OR0JAr642Lqf+WwrcW2WLoZVc=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3602.eurprd08.prod.outlook.com (2603:10a6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 10:38:33 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 10:38:32 +0000
Subject: Re: [PATCH v22 3/4] qcow2: add zstd cluster compression
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-4-dplotnikov@virtuozzo.com>
 <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <90ea0176-b01f-035a-7c9c-087a16009e38@virtuozzo.com>
Date: Wed, 29 Apr 2020 13:38:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <daf5a573-56a3-62b0-4387-1db73978463e@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::26) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 AM0PR10CA0016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 29 Apr 2020 10:38:31 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3681187-7e17-42e4-abf9-08d7ec2976ab
X-MS-TrafficTypeDiagnostic: AM0PR08MB3602:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB36025F2B9CCAE301B2CCEFCECFAD0@AM0PR08MB3602.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(346002)(376002)(136003)(366004)(16576012)(31696002)(316002)(36756003)(86362001)(52116002)(8936002)(186003)(2616005)(956004)(16526019)(478600001)(5660300002)(2906002)(26005)(53546011)(66476007)(66946007)(66556008)(31686004)(6486002)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuLWArsmNl+DyMm98zVs/1woiaVXgDEAxs170t4DxRkLOtYBMAJWE7g57ZYX4RUxOuLYWWs9gYwIsms8FaJRFS01jCM/H6fNPnbhLOXTI+d1q0m7EslHiVdNKRZWTl3Hg7Ntkbe0tZm4GqpqDqX1aavRXh7JKdVn8piGG2iHIEMp96fsgL4n6uwKya3GzLrX923rxo6IBYWUzZPRJVealw3xsWbLGx5PATD8mK5MMdzpbs4glHaPI36mii1aOemt/W10EKSwSEO8UvJHizVPEBRGdGZOtdAYIAE6jZZ5XSvbaw03cUlM50ESWzsIJaWjSUfkebwDmY57XTaO8xsiZQLkTzNfRNwxmE1zUIpHAuVBcF2dQAgwwpEriwHRrkEVWUv1LJBgh3NY22sPTjQCaaWom/CfQMeuqTSzjhGB5yGiFA7JqYDKiQOF7PCfPCQg
X-MS-Exchange-AntiSpam-MessageData: oEfgPaWHbSjS99IueCCPC7G/owQUtjdMsR9BHQkkg2RDCjIs+DZGmOaL0QBqXwBYoTxRgaDoO/+MVLBjfhxxUAGqyOX894EET+47USePHjBBvSOj6yVlu4N23bXVjbkmt4edVgtMXri9QM0dtDyaO9ua9TR6eTqs4TP/Bek17xXF0rzgDKwTp9CcD+sndbbTGpC+gXqRBXri6AJMTd3T934++Rd/e83jKgji0ZNCEfdpH0iDn21Awo6D9C1tkcv+jotj+Q4l37QrucMbuYCn4DxyhPdb9jjpomcNbQVJFEUcYd7p88Hii0vUS8oF5lUc1nLFJarnyu7dfOmeFHk2eqLjJbZ9ULFmc3b51EUZO4hLY5QeDfHg0cR1I4+9t4GvMltriszR6c+lg/oFBd84dMhpSCdpnv3ExZ/pAf/7IluZk7fNpxfYOzxtXPQ78qpVnAXpaIW+QXDh8BwaCSZ04BGyIPVGR2viVCvVMJZxKpkhOGrHPizjLnMcfS8GmesbzcqDJailqMYZ3CbV/liNdmUWAtb+1+HDCJ7J/CZa1Ngp1dJZuQRhkxqToZMF19eXcrJ/I04wmOViCwsz9FFKjby9d0v3qIpK2YGOuhiBrh1dk/4TIJNKstIuO2pODBZ0D/DyAkn/WqM4q7r+Og0vV4Pzck3N7AWaHw6VNsj0Xd1hqgAAOAlEdVYs4pDci2XujL0fVU/uy+KZ2cJqWdz7PCjnBkSlcw/XGJVsoWTFVWhjps20r7SAh3oXsoFoRE1Xwpl0lbKA9OgsDvGUFLI/o56FoVKb9ss+YDwtKVRLpcU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3681187-7e17-42e4-abf9-08d7ec2976ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 10:38:32.9458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnNB3rSSWRHu/Z8uyCGretK5GKfZ0QOy871qbasls/5c4QQ7GwVJspoB149Qsle1tANyJdjvnHp7Q3HwFDO5nhpOIwN0XPuJpBWHK75qtwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3602
Received-SPF: pass client-ip=40.107.13.111;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 06:38:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.13.111
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29.04.2020 13:24, Max Reitz wrote:
> On 28.04.20 22:00, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>>                    src.img [zlib|zstd]_compressed.img
>> decompress cmd
>>    time ./qemu-img convert -O qcow2
>>                    [zlib|zstd]_compressed.img uncompressed.img
>>
>>             compression               decompression
>>           zlib       zstd           zlib         zstd
>> ------------------------------------------------------------
>> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
>> user     65.0       15.8            5.3          2.5
>> sys       3.3        0.2            2.0          2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> QAPI part:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   docs/interop/qcow2.txt |   1 +
>>   configure              |   2 +-
>>   qapi/block-core.json   |   3 +-
>>   block/qcow2-threads.c  | 169 +++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c          |   7 ++
>>   slirp                  |   2 +-
>>   6 files changed, 181 insertions(+), 3 deletions(-)
> [...]
>
>> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
>> index 7dbaf53489..a0b12e1b15 100644
>> --- a/block/qcow2-threads.c
>> +++ b/block/qcow2-threads.c
> [...]
>
>> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
>> +                                     const void *src, size_t src_size)
>> +{
> [...]
>
>> +    /*
>> +     * The compressed stream from the input buffer may consist of more
>> +     * than one zstd frame.
> Can it?

Potentially, it can, if another implemention of qcow2 saves a couple of 
frames for some reason.

Denis
>
> Max
>


