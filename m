Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70016C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5672065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vvYxP353"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5672065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkljM-00035j-Gk
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklhz-0001rz-Id; Mon, 15 Jun 2020 05:47:15 -0400
Received: from mail-eopbgr60127.outbound.protection.outlook.com
 ([40.107.6.127]:50754 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jklhx-0007EF-VT; Mon, 15 Jun 2020 05:47:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUrZD1U/LtvZo7cLY63YHppaTxr/NHn/t1iMsW9wEZya/T2FizxR0yx5dIsxHND1/BiZKs1+5yPvXhpvX8FfLLeWxIB74nn1YzQMZOTwj/jhSYSC2ICH9I5fIpFwQg7pQ+R+LK3QMWz/qUjnOcS7Lz8lJW7P2SA5q+p/vV0VtZb8+NUocn28NKrPDqf3pPAwpa3B+k9vcdyj8fg35vI38JjIIW8BQMqdmNMPR1u5iUw3FD4RZqxYAxDM/GLaTficlbGyTpGpkWXWIsf/pgWjwhAvXTKK/jGxtaS/xg1ABJeS3nmrcNEgbAztAki914u21rPq+iCrbhpLBIMlhYmIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyqOzCmv2w6NneYc7jdWkb/9lQsUnXSL4Kan7YfPkXs=;
 b=UEmBRXEjh2/kf17k31pm4dC3YP0vITR7icQMPTQzcUVvorczX1vvI/Rhmq+BMvn3Dgr3Kqkg5v6lBWpAb+VVU4imkvI3xKnpWHQzBeX5QY75AapjfkNr2pDuPG5sPVjl6pn/a6uI3vqao9XE5DKmjUKg3Fv29RLstt+viCgq6IzvjuUHv01js9SjeDQYESIs18Da/eJOaoNVNUz57tsH1fAR8p0m/XJ6lRtiplGbyyGwPGn8bcYLn655jq4Sjez1608VvrUKuhWjfJu3TCvKIyLOHd/dNQQ6zRlzUtOq/dASS2u/zZ2PVAmBBVu7Q4EkHsgGlW88q2pFCb0OUY9HKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyqOzCmv2w6NneYc7jdWkb/9lQsUnXSL4Kan7YfPkXs=;
 b=vvYxP353tLpqOUQeHsU2V3j5GGsobmugSso2J4TdJUE/rcEQ+PxMhVVK1Bo+jDfIjqMrRZ9q7KQbDjF4vRpad0bcsAkpmOrdqiMuQC9p67wGeinvr3m8WKKfL9Q1U4VzBGcIzdoeDUIEVpk87TIlbXxaIZhFcbaCQaLLZ4jL7sg=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 09:47:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 09:47:11 +0000
Subject: Re: [PATCH v7 3/9] qcow2_format.py: make printable data an extension
 class member
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591920302-1002219-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4e340353-2a5b-3a96-8ffa-ece2e024b2e3@virtuozzo.com>
Date: Mon, 15 Jun 2020 12:47:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591920302-1002219-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 AM0PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:208:ac::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.10 via Frontend Transport; Mon, 15 Jun 2020 09:47:10 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec398d20-5608-421f-12fd-08d811111385
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5415A9AF76F2922CFADA6C1AC19C0@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3gOaKdG/BovZJyOSy8M6dag+VIBbeBXmAEcKJXusTeZl6CetY4uDiAPMZMXRt9WRzfYCYJmq86nKp1PL0MFvAggnmOObespcK4PiXq/xgDxFhaKZdypDRDEaRpHy7mcJJC1TudR13KJjcY5aNHUbbPqclCLz1vag1IKbCf1AABLWr9MueeiNBG82UNV+u1PO98HZU87GTdLfC1ZIpFKL8XdvYY09lry5hRAwk0ZzJW51gM2BAGTO7+GWn5XFl8icndPOy8BboTTmMmvHEYc+xX0X8QVrvrWvlZEaEYpwht19lPLV9TlFCGvv/jedqeTQD+AFYVu7AOLDlSyX9ULWHdT9tnW1wTOYjRpoWd25wWoWLRX8QFkLeutscbn2K0W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39840400004)(346002)(366004)(376002)(2906002)(83380400001)(4326008)(36756003)(107886003)(5660300002)(956004)(31686004)(2616005)(66556008)(52116002)(26005)(8936002)(186003)(316002)(66946007)(66476007)(6486002)(478600001)(31696002)(86362001)(16576012)(16526019)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SIZ0hlVd/vVyNM+iRzKIsZ+qAMr/9HMypE/zL7sdU7tYI/HhH8cH4xgTx20DWUdiyOzcP36kma3nHfPVjW3NGz72r53VtgID8Av4aDVd5jFvsvm9Zgoiw/9xfaNO2IUOAsylhlkJFSLV0tLTM1vX0OEryXnwmip7mQAnUU7VRTxDOim90/wC1iZpJ545X+g/5f90Gx2a2rfH+OoV9JgjFaVTNnZMS9RBY6X5M9sRAlBpETUbFRMQwBbBfuEeVw5u4fv9RDd3OtUf/5DQey4M1wdn2C2s8qbzw8XK5oDqShyzz0K/JVluUUkYkQxmXoaNVcxYDxVyLNG1sS5MBnuChWw3jIB1eKV9+WfrPTxy18Stei3urWqmqt/jw/tVfgkKNxvoPs7iZVLOcWqMsZYcsWCwymlpElAEw1c3bzxQ/N45LJ1wko7j1s3oBQESM63rz0OAdZfmYfjWw1lSNiWryyzAL7OH/xnATvWzMe4AYqDgUrIJJO8lX2ZjgoxOqTil
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec398d20-5608-421f-12fd-08d811111385
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:47:11.3943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhGcxKIST9VWTnYLBvxuERos5D9wr5AJtcN6gbiaL7wBybCC8HAQuK2lCPwQgaQWTROF206mNq4V9se+mKXAwQC5sc8WHJ5rL/L1+4rwYak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.6.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:47:12
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
> Let us differ binary data type from string one for the extension data
> variable and keep the string as the QcowHeaderExtension class member.

Keep my r-b, but I just want to note, that I missed, what is the actual aim of this change..

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 0f65fd1..d4f0000 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -164,6 +164,13 @@ class QcowHeaderExtension(Qcow2Struct):
>               self.data = fd.read(padded)
>               assert self.data is not None
>   
> +        data_str = self.data[:self.length]
> +        if all(c in string.printable.encode('ascii') for c in data_str):
> +            data_str = f"'{ data_str.decode('ascii') }'"
> +        else:
> +            data_str = '<binary>'
> +        self.data_str = data_str
> +
>           if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
>               self.obj = Qcow2BitmapExt(data=self.data)
>           else:
> @@ -173,12 +180,7 @@ class QcowHeaderExtension(Qcow2Struct):
>           super().dump()
>   
>           if self.obj is None:
> -            data = self.data[:self.length]
> -            if all(c in string.printable.encode('ascii') for c in data):
> -                data = f"'{ data.decode('ascii') }'"
> -            else:
> -                data = '<binary>'
> -            print(f'{"data":<25} {data}')
> +            print(f'{"data":<25} {self.data_str}')
>           else:
>               self.obj.dump()
>   
> 


-- 
Best regards,
Vladimir

