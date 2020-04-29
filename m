Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAFC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703432074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fu3gGVPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703432074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTk9i-0007lo-Jh
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTk8k-0006fP-Rz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTk8k-00035W-88
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:40:30 -0400
Received: from mail-eopbgr150094.outbound.protection.outlook.com
 ([40.107.15.94]:9229 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTk8h-00031k-Mi; Wed, 29 Apr 2020 06:40:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjS9nCKCMLRkZnScKcDmoEZnOJY5FVbOxXEbzJqBK3PhThkXmytNc7xQraaIE3EM106+2iIiyAmN4kDHYOQT/E6MSuFSHTSiussyriHIxRP6ecOD94+CUTe4Snl1DIKxHAPWsJ6dJCzknQbn2oM/6sN/MRyVylMFIzo6bfGJykKcesHZvTGsfw2K9y8svd26Bgj++rF1PtYoDTNC7UAG+PXAv56VG3P3ckryGdHqc5namRemdGVKbvvfxt4Db9vHLP93EHBPMKwIR90ZH6kCU61rRnC5NK67nqHrEotGV0NBdlMQQWRZ2JhusYwZ5Ik8jZhQD/IfW28SyhIJHkuNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG5XIdMmrNGJH9oyF5IhfCDd2R+we0i8Qf8nrVITXbU=;
 b=M7Erlzo5FzcAcXcM1hDwHai2zDTpeRD9X2T5zGp13prDLigqCgeZqgPq0xJEppJE0ZBEWO9d7GD1yx9rCbmTcKGJkQ1g9CqAu08b5E89CMJGUlg248x8Nkp21XLCYjB3smsvRTyaPH0JdA73R4j3sA55ML41cbxk9WQ0ZdalRpszV1n83tvUqlijHIqsnejzLRBVHkGuYjoN+znxWlbD5/n6ct+bUVMR2HqLUxpiSKQq0ABL3queiuOxvgffR25BcoGRBvXIywn9exopl3578/GggntCC00mJCyb2GDV/SRmiKOJAkrQuJm9kwOVx+Zytso15sfXKV1tF1RIomrqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG5XIdMmrNGJH9oyF5IhfCDd2R+we0i8Qf8nrVITXbU=;
 b=Fu3gGVPRSV3ltwHAhaljrCH3xfz0dHNdgBkkDrkF2g/XKjdItL7ByULconVzSA9FqmblZE/pmP6syp1Zy1RLiBQ1DzPNAWsXMg4nWloKzFYA5MpGi+xj6VOs7j37/xBTsB7ihLXnHTm7WKXSeDgdF6v/MrsD6gJovgnp27xev1A=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3010.eurprd08.prod.outlook.com (2603:10a6:208:56::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 10:40:24 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 10:40:24 +0000
Subject: Re: [PATCH v22 4/4] iotests: 287: add qcow2 compression type test
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-5-dplotnikov@virtuozzo.com>
 <9920c9a7-7442-d6de-a976-55be9f3896f9@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <8dd784a8-6a70-89f7-a20e-7c7e0f5a1111@virtuozzo.com>
Date: Wed, 29 Apr 2020 13:40:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <9920c9a7-7442-d6de-a976-55be9f3896f9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 10:40:23 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68784e5d-ce5d-4cf4-6f77-08d7ec29b945
X-MS-TrafficTypeDiagnostic: AM0PR08MB3010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3010E088EA4522D467887308CFAD0@AM0PR08MB3010.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39830400003)(366004)(136003)(186003)(16526019)(316002)(16576012)(53546011)(956004)(2616005)(8936002)(6486002)(66556008)(4326008)(66476007)(36756003)(31686004)(2906002)(31696002)(478600001)(86362001)(8676002)(66946007)(26005)(5660300002)(52116002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xd/cdsoE2NVIaNuZIjvR2yZ5Qsv/MV/gW0VIK6xN9ItjGIHkzLC4LP2ehzSKZIBqH1rGsCB9ArKCvlQKNs8ve/2e0sE3sAIrSGXJiv+knHMbtnXt5eeh14lYyYVwaIcEyVifDlYkrz775RBf7g1/KgGZD4Lev1cMNMDJlLS6DooOvVJw82d1lvyRr3TfLchg+yHBEwJ5mSHeDiSgIOC8RwGoUiBbwviO58fMEMQYlM5ajkgNUvXBrG1Hocs4rqKmRoTjlmAkKnTrF3ogRXPzTs+o1t4BkJuFQ8BAlDSBiG5ozs2+O3JSiqLXKoIdfpqxxeM0Lwhyktdqbbs3Tr5FrgFvJo5GMry9jnrFTRwoLLLlWpcIMGrUAijnb0rEpZD/be8AtZiG6yGwQdicTFnIPfHyHO7fyP3GzS34Hk4ZNq7c80mSFgu8Prmi4e0mrvKDr5nHQHAzoL28l74bvgC4iyYWrA8wWh2wVVbeky4lbDr+e9QhqLsOjndQRAL6EN7xYQa+e4hQL4FmgZeRcbI6CwSTyecvolzEmR32u7Dw5pBlhnQe1e+JPLbItMxCkAv
X-MS-Exchange-AntiSpam-MessageData: YnKOGXJ3TDtcdcJg2jcVQqMxYX/ffSbFtyWWmL10omAc53+Nr1IJisL2kQAX3QFHf6AVJY+NyIhtlQbq/lG+8HFNeMp8JrEm7j5989OI6bWReG97baILsC8xsup6lPr6K/r7j6pjbbZqhVBqpOhnMOptJphwv3rjOhfu/P/Tq5Y0kQ2hjJtwToN44InutGfAIIILxmZ/hSkgjlgsKbYonC9gpZOMKmOXer4IDkAz/6c/HY+SEtoRZgDA/vK/EwLLQUXTp6PY1o9TOUVqaMzWh/zKzDsXNsgrXz+FOz0lESbU9kh9ur78vEGbPdJSoW74/lZSxd5/PCuzmXNi72TNvrRrB8CV/YGY81bLFdj0lca69kHZeZbA/LsUDdHNmbIJbSCEvoCc92p6FgE0iFd5/IFSV67mT6E3LpetkENRoJwIn7upejILXUvJX+Uk37vpX+mWIjXES68pPaRjW6f9SAowNUj6WNuVJOz0TKNVQej87iiXJyxIq3PdLsc/uM5LRW+w9pkSi7a4lVHAR/ppta5dYRQeiGcO9QaMKPc9wIpOWEFHHShg47k2NG0Yj+U7yUJtOYxYARIG0XiyXYgt/sjnbeHKbfKzB9TJrz20K5BeQFy9bnWS05z6pxPfmY4CKM0g4Vi22nb/aTypu48puUMExo+KZ0FYJ24+UNAGzrfFTPKUyf1akkslRN+THVW0ajUKkUiyEN+uHFYJijEk4SzMRTZaNfJOmRrfy4XuCssItT7QaZWSxmkvSK6YM96mokf8IN0CulVk+2xvYN34+zZWxeOzWux6jB0M6R2CLGw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68784e5d-ce5d-4cf4-6f77-08d7ec29b945
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 10:40:24.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KooNVphqrN0qY6su0Ta5RMb46NqhTTOkKpd8YYiFxe5NSp7EmDbXUiGguH3Z/yhD8IbZWJmMurLm0AIec++i7xREcoBjSdIYHfc0QooQL8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3010
Received-SPF: pass client-ip=40.107.15.94;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 06:40:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.15.94
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



On 29.04.2020 13:26, Max Reitz wrote:
> On 28.04.20 22:00, Denis Plotnikov wrote:
>> The test checks fulfilling qcow2 requirements for the compression
>> type feature and zstd compression type operability.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/287     | 152 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/287.out |  67 ++++++++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 220 insertions(+)
>>   create mode 100755 tests/qemu-iotests/287
>>   create mode 100644 tests/qemu-iotests/287.out
>>
>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>> new file mode 100755
>> index 0000000000..21fe1f19f5
>> --- /dev/null
>> +++ b/tests/qemu-iotests/287
>> @@ -0,0 +1,152 @@
>> +#!/usr/bin/env bash
>> +#
>> +# Test case for an image using zstd compression
>> +#
>> +# Copyright (c) 2020 Virtuozzo International GmbH
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +# creator
>> +owner=dplotnikov@virtuozzo.com
>> +
>> +seq="$(basename $0)"
>> +echo "QA output created by $seq"
>> +
>> +status=1	# failure is the default!
>> +
>> +# standard environment
>> +. ./common.rc
>> +. ./common.filter
>> +
>> +# This tests qocw2-specific low-level functionality
>> +_supported_fmt qcow2
>> +_supported_proto file
>> +_supported_os Linux
>> +_unsupported_imgopts 'compat=0.10' data_file
>> +
>> +COMPR_IMG="$TEST_IMG.compressed"
>> +RAND_FILE="$TEST_DIR/rand_data"
>> +
>> +_cleanup()
>> +{
>> +	_rm_test_img
> _rm_test_img needs an argument (it basically replaces “rm”).  What I
> thus meant was to keep the _cleanup_test_img here (that was completely
> correct), but...
>
>> +	rm -f "$COMPR_IMG"
> ...to use “_rm_test_img "$COMPR_IMG"” here instead of rm.
>
> Max
ok, I got it.

Denis

