Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A01C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B87C20747
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c6oOhiY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B87C20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrRwx-0007gO-Fp
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jrRwF-0006mG-7P; Fri, 03 Jul 2020 16:05:35 -0400
Received: from mail-eopbgr150128.outbound.protection.outlook.com
 ([40.107.15.128]:16454 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jrRwC-0007H2-HX; Fri, 03 Jul 2020 16:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGZJOtqhGIwNaeFlrE6LyNVHM1r5yZEuTl7ItfcUwiN+6/W7ja3FPzZIBWRXYFWhANEy8zdBysTSxAgFIjPw3hAp5egqqo8hn5q2xqDG0xl35Wtsqb+huQyBh7cNKokYL/yAaVZabPcXfB+zSF2rx5ku5+anLcK/0DJIF+v+4y5YvjvCdE6joyEDnIFHk+lBN3AAeiRrGzuW7EKPBggaLX1PbU5DONydCYvMUq9XcLX3cOlPshlgr+WkOO6Pm8Xuwx6Q96KeufQplc8gba+aoM0mTo30eh0cHBUomKqxdhrRr/4w1MUbZKYkruoFV08y7cEFj22QyZ8Tk2OAKv+60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7na1F739zXYNa21FQEmzyPVGyAvDnSDHd0l/zF3Huc=;
 b=GQ/+r59IlAdvS2H7smM614LCwgD3TAZ+GB8VqMRH19h5ihdypfeyPRWCveUMTtbW86N1tnItLjWSoncP/MAiMcxpvl7SKjVtXkH1PHwcHTMiPoN4ZTBu3Ij/BJet3CQToQfHqnC9WgfRs30cEwDl+rg13Z/824//6j221m3kKU9BAfplkJCLw8UaYMmiKcahUVzBXtff2cYoc/QCXwDGobkcHzoKJj/U5/G4JfpmTVyYdyTCldK241sIZs/CAHhvj7vPO0xtcj0S2fPB8L1R+G6N99SKReGIjGGHPmINva7xS7QdQse/kY0qb8GJoUQ8lNCX7nZQMx3R+veajDD13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7na1F739zXYNa21FQEmzyPVGyAvDnSDHd0l/zF3Huc=;
 b=c6oOhiY/4ocTRbA+YtJDCYBP+vDxHjDgblmJs5Lg9ijGrUZv22xJz1f9aoKElXcCwwFDG+4hX5OtaMesPNawsaCOulfnItvMh6eNJsjFTQYIJO8z/Atd9IeQ715OIO75dqfr0BnJBGrFpcazQHAczpDiKVNu7KTPmuQOO0+gu5A=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4023.eurprd08.prod.outlook.com (2603:10a6:20b:a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 20:05:29 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 20:05:29 +0000
Subject: Re: [PATCH v8 07/10] qcow2_format.py: Dump bitmap table serialized
 entries
To: qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <cf36a53d-f6be-9a24-5402-e28c3cd1441a@virtuozzo.com>
Date: Fri, 3 Jul 2020 23:05:27 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1593782030-521984-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::34) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:208:d2::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 20:05:28 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1712559d-bba8-423f-8a92-08d81f8c6ef2
X-MS-TrafficTypeDiagnostic: AM6PR08MB4023:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4023F8A4A6A92C26855A5B24F46A0@AM6PR08MB4023.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J04vmfVNZfMrOnuRn7ExbU0vxvdKX5Ym5OxBlfbamKPtbWc+YmbIGBgE07pFmTzso/EHkALlp8jqeeMCACdFY+Vq7KkRo7hudlMeH8FwQ8cmJNAiZecL0rDhvVBl7mHKYHiuCcz8Dq+x6cBflj6d7QB1ZubIfSJH/0MFMQ7v932zHelQRNKQDmNE5gdPc8Odlu+qsMFejX6g6Q6OETITJJMYblh2S2WiuLR/GPu7tkZfinTsfQdr42M7vge3SAGTECq0gRowOCcXAZBdBhR04AfhhJGdWc2jdIgybQ9N8t94PgiPX3dmA90ITqF6jow2sakMPfV0OlO7yFqYeL9mzk4XR9AJE5x6ZcPm7fwGyZDacjq8GEp1M0sXz1vinnEG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39850400004)(366004)(186003)(53546011)(4326008)(16526019)(6486002)(6506007)(36756003)(31686004)(8936002)(316002)(478600001)(2616005)(52116002)(956004)(26005)(6916009)(66476007)(66556008)(107886003)(2906002)(44832011)(66946007)(6512007)(5660300002)(19627235002)(31696002)(8676002)(86362001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XvhSk/5NVvYI76dl1QoJtOMyTOVKi9KiyLD6XbR1ZVES+yEcpTxIzH7DV1NQEmt8HZ5KfTLdbhRQ1y1E6yrlVPNKgS9OGszO10HxH6zujbdLQ0pK1XOCh/GSXyckmyDcuiRq7ShrgvenLM+Tz+Wi2JscgnYQFcOMuOiJ9l/c36tYc/aeOmZWF+vRVE88uvlhpsi8v0eYjBh4U/nNDj8NEE/sq3TK6pc68CyYtJqXUkZnf7go8Wf7mCi/zmUS1a/i7IBKny0Sswww/S9p3BKmGo4Cz/u4ZHvjjmxgUfQjfeDAdUCF5Ix3hGcswVCHME0rPYyytXTZVoEh361Kw6Drtt9TVahf0mfDJi4CAX7KheUDTZfmk5SBn9qZfXp7OhoeslKt8hRfeoNf6fboCbJbMKIagZMMt8w2YFfxgn6SCNKr8jjNTKbQsKXz23xMbdQtahYYktRCyS8sQ68bLR6NmVtNTK69cnPhk6WcvE5jfm6rt2bvn56LZC+7MiVbKSiV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1712559d-bba8-423f-8a92-08d81f8c6ef2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 20:05:29.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmcbZJeaeHKnJ/b2D+JiqcRIrJdTDz0rinveaE1JCj/8ZjnhSUzMpKyAK3275t3bIuNzYaedJjZjwu6S7Vyn1MLAIjGlI7gLpuVecyu9hqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4023
Received-SPF: pass client-ip=40.107.15.128;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 16:05:30
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.07.2020 16:13, Andrey Shinkevich wrote:
> Add bitmap table information to the QCOW2 metadata dump.
...
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -171,14 +171,56 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           entry_raw_size = self.bitmap_dir_entry_raw_size()
>           padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
>           fd.seek(padding, 1)
> +        position = fd.tell()
> +        self.read_bitmap_table(fd)
> +        fd.seek(position)
>   
>       def bitmap_dir_entry_raw_size(self):
>           return struct.calcsize(self.fmt) + self.name_size + \
>               self.extra_data_size
>   
> +    def read_bitmap_table(self, fd):
> +        fd.seek(self.bitmap_table_offset)
> +        table_size = self.bitmap_table_size * 8 * 8
> +        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
> +        self.bitmap_table = Qcow2BitmapTable(raw_table=table,
> +                                             cluster_size=self.cluster_size)

As an option, one make the class Qcow2BitmapTableEntry derived from 
Qcow2Struct

with the member:

fields = (

('u64', '{:#x}', 'table_entry')

)

and read entry by entry bitmap_table_size times from the disk in a loop.


Andrey

> +
>       def dump(self):
>           print(f'{"Bitmap name":<25} {self.name}')
>           super(Qcow2BitmapDirEntry, self).dump()
> +        self.bitmap_table.dump()
> +
> +
> +class Qcow2BitmapTableEntry:
> +
> +    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
> +    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
> +
> +    def __init__(self, entry):
> +        self.offset = entry & self.BME_TABLE_ENTRY_OFFSET_MASK
> +        if self.offset:
> +            self.type = 'serialized'
> +        elif entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
> +            self.type = 'all-ones'
> +        else:
> +            self.type = 'all-zeroes'
> +
> +
> +class Qcow2BitmapTable:
> +
> +    def __init__(self, raw_table, cluster_size):
> +        self.entries = []
> +        self.cluster_size = cluster_size
> +        for entry in raw_table:
> +            self.entries.append(Qcow2BitmapTableEntry(entry))
> +
> +    def dump(self):
> +        size = self.cluster_size
> +        bitmap_table = enumerate(self.entries)
> +        print(f'{"Bitmap table":<14} {"type":<15} {"offset":<24} {"size"}')
> +        for i, entry in bitmap_table:
> +            print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {size}')
>   
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875

