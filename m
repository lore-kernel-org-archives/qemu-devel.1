Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0AEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931F9206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FKsHIrgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931F9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgERB-0006hl-S0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgEQS-0006D8-PF; Tue, 02 Jun 2020 17:26:25 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com
 ([40.107.3.125]:29099 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgEQP-0002nO-UQ; Tue, 02 Jun 2020 17:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqFi1eLuq6MgjLeRIGinkqk8CO7Fa1he3D4ofgyXnVPKmVn/DUzsc28TuQv9H5OXwGnxikEpThPM94QVf7/M5jgXU/iqwa6gbzFq7HDEOIDJFAfUUWpOCh/d09Cjiqqrp2MZyFm+tTtBddx2nJgU/yuzls41PMNtuhZZbggl/Sx+aygo1IDMTTIf72qn6C7TpXa4U7e5nqTxU8v4klxa9DIcPJFR5WGji7CFnFLtMgyhmCbGrPeUvAkbkewFzsuap2Zm5qSLOc+V5hYK/yItEwWygj7L4NHZm9R8TRWoK71wrm/N/9tx0rGGRoiFhgSdDwU1qTRJELqOiHQXD+kWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vjr+rfrh+ZrcsLpKbVt2P0cts6xs67dfej3zo2NwZM=;
 b=YDK1YKGem+FjouFRJ9rj9iV6ko2EnAo067Gj/nLsp74KLFzudj839hlfl5PicPJTL1TFnn0iaqoR/FULLr7L54/CDuX+7hXxXVi4l+u96fBdQuKHlSOyAwUy7f9vsfriQg6eDMDY4/kTm2EfzaREXYxM+h5uSveFrUiIrifEUUtG89PXc5D3+3fLUx3vyue38EsF7u4imXsYjRN1SEPbeYI6g/7pYHMIP7JJsqu6VRoaU0XUailNAzGx5UBctV/tFDs/r51QQUsCxs3dLqK2x4csJk08RXeFWpU2rkKJ4unRGyP0yRQo/a4K/BKGKyVW3Z9ggmAFU1sMghprfadx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vjr+rfrh+ZrcsLpKbVt2P0cts6xs67dfej3zo2NwZM=;
 b=FKsHIrgjUdSE3mB8rbwRhZsiv2PzIy2xlmXjEboQlzq+y0IGMTGm+763CGRNZSk84Fw2jkdCovDHubRt46SbdfrkNxYUNHq0zRjMQh2OxIZKvBNia8afWEss57lGOaFdGaYZxKq0BuguyQGpaYnOETPLCnR4xlRoI87Nf+GNGJs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Tue, 2 Jun
 2020 21:26:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 21:26:17 +0000
Subject: Re: [PATCH v3 5/6] iotests: Dump bitmap table entries serialized in
 QCOW2 image
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-6-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8d8475e2-ddcf-d486-d9bf-e79b1950b27a@virtuozzo.com>
Date: Wed, 3 Jun 2020 00:26:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591019293-211155-6-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:200:89::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM4PR0202CA0024.eurprd02.prod.outlook.com (2603:10a6:200:89::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Tue, 2 Jun 2020 21:26:16 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb99258-612f-4e8e-72a3-08d8073b95ea
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB547876186708C4F1D118F3CCC18B0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18c97ZuEarr+TwW7Eu7NrKHX/yW3b/gOMh/CH8KZtU8TykOH/B5FP2ULntd0RGDWPluMYEk10LPIZQGprVY04LIbB0d2qvjn7uaEl4drY+cNNhFuHJync0o6vBZkJgrkRT1+TlfHOyxPczwzUTudttt4dWJ9ILgDjzTqci3z3PP3q+7O9Dx/npI2wE9zJcYbVcP5uiWg2Evt1pRQ6rZ9zZXBG62XGIGE1ywP8bOB8dBc5I+ZvdXPPx9KM9DIa/6NrLHTQutsl7VpcwK9P1EqCrgtXEbliTJ3rAe/ItrXLk5s4GYIzbyFvNRMqXv+aWczc9IIfLp3f/L3OhP4XjeQDxPl2Pzpdz1jZZVWoddueCDRbVApk/N2MtmaWDJNeU+N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39850400004)(396003)(366004)(346002)(376002)(2616005)(86362001)(31686004)(8936002)(4326008)(36756003)(478600001)(31696002)(8676002)(52116002)(6486002)(2906002)(956004)(186003)(66556008)(66476007)(16526019)(66946007)(107886003)(26005)(316002)(5660300002)(16576012)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o6Lq2pb4PgmUjG+7F4Xf4sg3Uksa59lHNcCBeFbVVRJSKTAENQ5h10Y53VEmWZTZDjmlFfDuFl3aFSgr0pKsNwGWmXL4FSiA0lFkGm6hTjaAtXAgrr3JXdgjlmHfQny50Zqs5LJNPSUWOcuIfHfFSrx5g2u/uZqTBfDglTFmesSr1WG8/qPL1uhllwJyt7W7n0XXNnQaUR5zzABB1yjR0T5ytxJleVZr/B1QFtwqXnYTM1fRtInCm35/lwpq1oeJGlUYTcu9TgZdoPucdRBGpIkeQGPQzq7/QeBtBYlvjGo/K8Fv3P2Q2Knm6tj8+jLmGbTQxcIChHmhG2vtUV5QfN2THXh+qS7CS8Dss5bM7WggF64AClt6cUdTeILmdmN3eSIpuqA2LS9ewWqwBJ+SP9d8/72jjbCmJA0QzbUHIixO/+TVyB3984H+5G2wk43ElULHk8fZaQwfmQp4rAhZeGwltCnmxyULbRenKKKL1aPulRYdtvKLzHnOpg0zGYWa
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb99258-612f-4e8e-72a3-08d8073b95ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 21:26:17.3804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcNHEQoQlmd1sFyEgzCZQcR1bTbYc7fwOHq1xoUSJT/6pYwlSUnHR0RBhroafMmT87ygSpM/KFfCRs62qvlHt95n5idfT1EdOO6Ekcu+KBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.3.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 17:26:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

01.06.2020 16:48, Andrey Shinkevich wrote:
> Add bitmap table info to the QCOW2 metadata dump with qcow2.py.
> 
> Bitmap name               bitmap-1
> ...
> itmap table    type            offset          size
>          0       serialized      0xa0000         65536
>          1       all-zeroes      0x0             65536
>          2       all-zeroes      0x0             65536
>          3       all-zeroes      0x0             65536
>          4       all-zeroes      0x0             65536
>          5       all-zeroes      0x0             65536
>          6       all-zeroes      0x0             65536
>          7       all-zeroes      0x0             65536
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 48 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index e4453f6..76e0c69 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -5,6 +5,41 @@ import struct
>   import string
>   
>   
> +cluster_size = 0
> +
> +
> +class Qcow2BitmapTableEntry:
> +
> +    BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
> +    BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
> +    bmte_type = ['all-zeroes', 'all-ones', 'serialized']
> +
> +    def __init__(self, entry):
> +        self.cluster_size = cluster_size
> +        self.offset = entry & self.BME_TABLE_ENTRY_OFFSET_MASK
> +        if self.offset != 0:
> +            index = 2
> +        else:
> +            index = entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES
> +        self.type = self.bmte_type[index]

IMHO, it would be clearer without extra list layer:

if self.offset != 0:
   self.type = 'serialized'
elif entry & self.BME_TABLE_ENTRY_FLAG_ALL_ONES:
   self.type = 'all-ones'
else:
   self.type = 'all-zeroes'


> +
> +
> +class Qcow2BitmapTable:
> +
> +    def __init__(self, raw_table):
> +        self.entries = []
> +        for entry in raw_table:
> +            self.entries.append(Qcow2BitmapTableEntry(entry))
> +
> +    def print_bitmap_table(self):
> +        bitmap_table = enumerate(self.entries)
> +        print("Bitmap table\ttype\t\toffset\t\tsize")
> +        for i, entry in bitmap_table:
> +            print("\t%-4d\t%s\t%#x\t\t%d" % (i, entry.type, entry.offset,
> +                                             entry.cluster_size))
> +        print("")
> +
> +
>   class Qcow2BitmapDirEntry:
>   
>       name = ''
> @@ -48,6 +83,12 @@ class Qcow2BitmapDirEntry:
>           return struct.calcsize(self.fmt) + self.name_size + \
>               self.extra_data_size
>   
> +    def read_bitmap_table(self, fd):
> +        fd.seek(self.bitmap_table_offset)
> +        table_size = self.bitmap_table_size * struct.calcsize(self.uint64_t)
> +        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
> +        self.bitmap_table = Qcow2BitmapTable(table)
> +
>       def dump_bitmap_dir_entry(self):
>           print("%-25s" % 'Bitmap name', self.name)
>   
> @@ -59,6 +100,8 @@ class Qcow2BitmapDirEntry:
>               value_str = f[1] % value
>               print("%-25s" % f[2], value_str)
>   
> +        self.bitmap_table.print_bitmap_table()
> +
>   
>   class Qcow2BitmapDirectory:
>   
> @@ -83,6 +126,9 @@ class Qcow2BitmapDirectory:
>               shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
>               fd.seek(shift, 1)
>   
> +        for bm in self.bitmaps:
> +            bm.read_bitmap_table(fd)
> +
>       def get_bitmaps(self):
>           return self.bitmaps
>   
> @@ -223,6 +269,8 @@ class QcowHeader:
>   
>           self.set_defaults()
>           self.cluster_size = 1 << self.cluster_bits
> +        global cluster_size
> +        cluster_size = self.cluster_size

Oh.. We should avoid such thing. You set global variable here and use it in another class. It will definitely break, if we try load two qcow2 files with different cluster sizes in one context.

>   
>           fd.seek(self.header_length)
>           self.load_extensions(fd)
> 


-- 
Best regards,
Vladimir

