Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB58C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856872074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HT1bLc0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856872074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0AR-0005Jf-QP
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw09q-0004s2-3y; Thu, 16 Jul 2020 05:26:26 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com
 ([40.107.21.107]:23246 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw09m-0000cY-TS; Thu, 16 Jul 2020 05:26:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VypsiUy6ChviJnRJR6Bl0Qbla3VGMI0svm1x8J+DMXwkJJsKkE3tnLKNWrENqLMWiaV7vVs0b4HdAZZn/C4z9HA6H8TiJVxnFtGh19F36eZX+5iUMsRlpVBinV1vSkVJlHh8I6ELDBMI5ge1K0epI0q/zgEdEVoeZYNm00TUIw/CJzOoPku+AZDcK4DjBNTGj5EwGU2f/b2XuJaBaHSqe7Dkkp7C8wHp0OMDjNqVW5euk8WXEIMqdM+yLSY4BTEaxFJQuC4HciTTBIS+h+QRPY8VFaukVYDjPADT0RyzAW/9KebMRzPqGYDY8zewNcHNpoEscHGEdH3Z60vOprZpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIsIHMDFgiC20N557il0KT8V+eF8IctSDIwuGRFYbS8=;
 b=i1tldA3N4i934BvSiSTI9eqifDPrYLf1KNGqFSFcrj4/QPaPzTHgK3j62dIJwvz79D0pCoBV4F2TMw7i1iowLxs0sdex7FisEqMtS40WciVoRclfpnH8EYbK7+URNdVl8mIWT5WwEMQLz0nSU5XujAzeEHx3qyr+uelAq1b2oY2+U/X7XGqZML0m1UGVnDdvV+Od3WqN8hJjw/zypsdy14r73+bHJJrW6QaIymR9+T06rYEMo+nAEMMWtXuWhGde+MFQWON/B+KPqYgm7HhVRviOEeGgyqLg9HmwWpgGAtNdphBv9Xt0SNdlJ0PapJ3m0sj8lNoaEg/5+zFNOeUSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIsIHMDFgiC20N557il0KT8V+eF8IctSDIwuGRFYbS8=;
 b=HT1bLc0HE/AJImYamGF4XBdNOASRRmOwCtfnFn0H1LbxYVYzRHrYXjyuZSvHoDiO31dgOsVVNfC2KvHU2DvG36utvIMRXcwTIgFcAcMfu0gZ3QN54v3YRe6FNc7mD63pcpJ3c0BkY5l6RxJI2531XBoJalavxhSC3lrCzDDrrdw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4952.eurprd08.prod.outlook.com (2603:10a6:20b:e1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 16 Jul
 2020 09:26:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 09:26:19 +0000
Subject: Re: [PATCH v10 06/10] qcow2_format.py: pass cluster size to
 substructures
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-7-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <409ffb85-7282-6f83-8a30-a1fb1fc3d455@virtuozzo.com>
Date: Thu, 16 Jul 2020 12:26:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594676203-436999-7-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR01CA0140.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 09:26:19 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19a52582-e099-4bbb-958d-08d8296a4c49
X-MS-TrafficTypeDiagnostic: AM6PR08MB4952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4952F273DBF9AC044F27A1F7C17F0@AM6PR08MB4952.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEpSqC2uP17Hq99L749IeVidFMRCjdENd2eswGB+mMLY9BF9+oF9Djd6JYkgCPTDa5IOeNUpHl6jITBK3RxmCaord03+/HR8tYi/58klrtTURiiSmnXzarz0OsVWP5iMt2fkQtH+n4Fn54RvB8TsPs4hQ3sTJXpJmFXNbiqzcrrWQxBm7OHW1V/bOMqrDneYhqcks9vg9W3/blGG0cwdHin3UEXiSOga3jzmedX5FJ8jZ0bT4op5Mnvd0lEnvqGnZQl6S6xZgsNcXVkLOAYsoqB5fq64u6mjs4xZbMps7b5GNa3nbk+W5xY3gfbVxVZG0zer5wBwk36ylGUgpTrl6XQGBufStlePPWXOGVAjgM2sEfIJgaaYCPCm7gDnjBHE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39840400004)(8936002)(16576012)(31686004)(66476007)(6486002)(83380400001)(316002)(66556008)(478600001)(86362001)(36756003)(956004)(16526019)(8676002)(26005)(52116002)(4326008)(107886003)(2616005)(5660300002)(186003)(31696002)(2906002)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: MzYkCspvcbswKALobtabml8T+3+mmp/KQFPiYNSu7XnDQzIEk+oJ4OORYOMF69adCcnlGQpeU+yM16vVBJ7ub7mwoJQoqEaBmUhAkIwKlE8oRKEAr4PcaMwFmGQLAInjTIf/tnqTJZ09jJMc+bEpjaiX5vg/+qko89euMFbeem7EreaiYmh01NN+bYtn6t73Hj/y7cK31OVv1MdVN77Kjd04opX5VHswhh+pfNaJWqa62NYcW/BSgn0Xiy4876yhIAFMAh+lLuZC0xwX9zz/Y69HhgvqpBUl1gqoTRHs5nK2nWOzRYGsuf5FMneYFqaZ3dMpoTB8VAM5FAgZO4q9YxskmVEw6E6rG0YSxO285GZNY8nY/Byr+udFOgx+UcwuZ20oicvAJfK2Gjn12OAzgifyITEPmiged6auCaVaKzliCN/pSyraVSS90dZJm62RC6vZ5zVD9POA6LaPJu8c3botpOU5D+ng4G6IqFQMh7iCtWI/cR9VDbIvAoeA7+ZD
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a52582-e099-4bbb-958d-08d8296a4c49
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 09:26:19.7432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwfCdFVzz7XdL6kQx+Dkwim1cSQxtOB9oUWo+cvgUwmx3a+AZGwp9EnRCvgs5DcuzxmspLnIaCYHdH4Ds+X2AR6DjS+NEYQykbDAy4P8u1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4952
Received-SPF: pass client-ip=40.107.21.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:26:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

14.07.2020 00:36, Andrey Shinkevich wrote:
> The cluster size of an image is the QcowHeader class member and may be
> obtained by dependent extension structures such as Qcow2BitmapExt for
> further bitmap table details print.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index f0db9f4..d9c8513 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -129,19 +129,21 @@ class Qcow2BitmapExt(Qcow2Struct):
>           ('u64', '{:#x}', 'bitmap_directory_offset')
>       )
>   
> -    def __init__(self, fd):
> +    def __init__(self, fd, cluster_size):
>           super().__init__(fd=fd)
>           pad = (struct.calcsize(self.fmt) + 7) & ~7
>           if pad:
>               fd.seek(pad, 1)
>           position = fd.tell()
> +        self.cluster_size = cluster_size
>           self.read_bitmap_directory(fd)
>           fd.seek(position)
>   
>       def read_bitmap_directory(self, fd):
>           fd.seek(self.bitmap_directory_offset)
>           self.bitmap_directory = \
> -            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
> +            [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
> +             for _ in range(self.nb_bitmaps)]

Better to inline the bitmap directory loading code into __init__:

Benefits:
  1. Less code. read_bitmap_directory() is very small, used only in __init__ and just not needed as a separate method. __init__ is very small and simple too, so it's not a problem.
  2. no need of extra self.cluster_size variable (you can use cluster_size parameter directly)
  3. keep all fd.seek logic in one method

but it's not about this patch.

>   
>       def dump(self):
>           super().dump()
> @@ -162,8 +164,9 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           ('u32', '{}', 'extra_data_size')
>       )
>   
> -    def __init__(self, fd):
> +    def __init__(self, fd, cluster_size):
>           super().__init__(fd=fd)
> +        self.cluster_size = cluster_size
>           # Seek relative to the current position in the file
>           fd.seek(self.extra_data_size, 1)
>           bitmap_name = fd.read(self.name_size)
> @@ -203,11 +206,13 @@ class QcowHeaderExtension(Qcow2Struct):
>           # then padding to next multiply of 8
>       )
>   
> -    def __init__(self, magic=None, length=None, data=None, fd=None):
> +    def __init__(self, magic=None, length=None, data=None, fd=None,
> +                 cluster_size=None):
>           """
>           Support both loading from fd and creation from user data.
>           For fd-based creation current position in a file will be used to read
>           the data.
> +        The cluster_size value may be obtained by dependent structures.
>   
>           This should be somehow refactored and functionality should be moved to
>           superclass (to allow creation of any qcow2 struct), but then, fields
> @@ -230,7 +235,7 @@ class QcowHeaderExtension(Qcow2Struct):
>               assert all(v is None for v in (magic, length, data))
>               super().__init__(fd=fd)
>               if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
> -                self.obj = Qcow2BitmapExt(fd=fd)
> +                self.obj = Qcow2BitmapExt(fd=fd, cluster_size=cluster_size)
>               else:
>                   padded = (self.length + 7) & ~7
>                   self.data = fd.read(padded)
> @@ -244,7 +249,6 @@ class QcowHeaderExtension(Qcow2Struct):
>                       data_str = '<binary>'
>                   self.data_str = data_str
>   
> -

Unrelated style-fixing chunk, please don't do so.

with it dropped:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

>       def dump(self):
>           super().dump()
>   
> @@ -316,7 +320,7 @@ class QcowHeader(Qcow2Struct):
>               end = self.cluster_size
>   
>           while fd.tell() < end:
> -            ext = QcowHeaderExtension(fd=fd)
> +            ext = QcowHeaderExtension(fd=fd, cluster_size=self.cluster_size)
>               if ext.magic == 0:
>                   break
>               else:
> 


-- 
Best regards,
Vladimir

