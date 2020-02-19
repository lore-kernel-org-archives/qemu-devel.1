Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC2DC34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0D32176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JCZmN7HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0D32176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QBP-0008PL-HC
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4QAI-00071P-FN
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4QAH-0005FI-A2
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:17:26 -0500
Received: from mail-eopbgr140098.outbound.protection.outlook.com
 ([40.107.14.98]:37188 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4QAD-000588-NP; Wed, 19 Feb 2020 09:17:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA+hNI1WcxRZ6mbrJrAevsol1vMBprCwC+lPa9zRJM/B/q2Nax6FF2xKGe/7/6P7k6O90D2Uw+g6VKVhYoQ+KSQodG4hC+ifE8b7SrXvct+2/I1JRk6dRWFGO5r0aLGT0aKSuRiObmPRO2llLQiRsIaql0dhXO4aIm++JJa0eMY5kx1+Wb02uyqdst01r+zRZsmGFDApRJB7DOj/EBhAoHcByhIron/QhEkw+sY3kxWqtxggSTbfe5ySqBEYFBlb8Gpr7ej1nLtOQk8fXPQ0aV2iD7QUvbZTElCSNKNFC7LQRZ1KTMO458emeAB4bMPU9drReMi0XRaMfGaLRi+Etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luub5suF3QvRCiH/havKBgJ9HgGJLa0lnwJj40SXWBE=;
 b=F/tU/AEWU2nl8GLozLJgEY6bhFWYCgqEZK6vSNYMRzFA2Ou3MlLxWHkW2st5LFml2hnqcWeIHh2b3E2MQn7bIQ2hkWaxdfvfVzn9uQ1lzOrvzGGuId8qGgD5qNzlMlHSmWzx9TP0pqsFTBagJrrKixeNHq7IsFTcIVb64e5ltqQQLXqNN0CHmNhYlp7nphrDmvSwK7L6mKBgeaIsvM5JaO502TDgt1lWpz28NxgYEVIyoDJOEFIcyJ8U0e8bPl7c61pL9jQbPy6ejusWMZH8ycQVzNAHaB9PTR2TWmDC0yfKBpVxdONbYaxPxq0fyFMWpYxq7X8srzN2U/O64XeVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luub5suF3QvRCiH/havKBgJ9HgGJLa0lnwJj40SXWBE=;
 b=JCZmN7HSMgd2Jrn5INrvgQ0/bZyZzbmhwhC2skGAu3ae54Bd8/dnhplxfbasbh+2khilFWNW5vwIChsUlvrD1VcLnwd/NaOX1128gXK1TdpJcunN67ZZPim6CYKy3BdS6j/rHNospGR0c94hB4SBs8ez7n+RhqSptBTTcNSSWSI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4615.eurprd08.prod.outlook.com (20.178.91.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Wed, 19 Feb 2020 14:17:18 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 14:17:18 +0000
Subject: Re: [PATCH v2 15/22] qemu-iotests/199: improve performance: set
 bitmap by discard
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-16-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <3885ce91-af10-1cc8-19ed-b8e44be4238f@virtuozzo.com>
Date: Wed, 19 Feb 2020 17:17:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::21)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 14:17:18 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71143baa-93d0-4176-58f0-08d7b5466d7a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4615:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4615FB9F5529FB3A5B06587DF4100@AM6PR08MB4615.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(376002)(136003)(396003)(366004)(189003)(199004)(2906002)(66476007)(8676002)(81166006)(66946007)(5660300002)(81156014)(8936002)(6486002)(44832011)(16576012)(54906003)(66556008)(186003)(31686004)(16526019)(36756003)(316002)(53546011)(478600001)(36916002)(26005)(31696002)(956004)(86362001)(2616005)(4326008)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4615;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZRPxMwTRuZjQcJsqH+GkeMGZoFhXF48s6se2fx5tpBcqeCq+mutZnIQ/8P5RfIDfptT219woIh3L63exid4yqQQQjjrAEqc78Gg4duAqhRnNFtCL9B6nzKmVCpOUVR+w1DMd+neww+seb2XjmCfo4JrL5Yvpr0AftA7QayxECyyATVNrscS+VD7aKLjgxyGfnwN6SzvjMfDM5FKwZtJMGj/fjkMY/2VRx7VPl5XKLNpYX1oIZLDNL4MuTxBth/eiziUtFv1vmXcUMohOMQ8d3xAXHKQ82woYbmfeb8CporIMG4MAzgRJ8fKLxN7Tgrp2to0xzJaScz21rW3r5SPTY9wARLkI9MXWB8+HAqMcrl66d6JNptWcMhouR5Rg+wEOudv37T+uQWnTx6K71zs/oSFVUiSiaTdNKqPJ/s6I5n0g86jYGFPTBeVf5aBBSDj
X-MS-Exchange-AntiSpam-MessageData: KP/Lmw+a2uwMgiKXIEJLUDw+oipjNhKiJCkdxPH01MnRyV4ZMWICvrTdJyKIL9ly72Zkq9w8ruFKYCJEY9uvWxAs/miCGvbeVsJQkhZF1VTqPIi31lgOE0WbB/9/WNOgViauSC2gm84+vd6zy6mjiQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71143baa-93d0-4176-58f0-08d7b5466d7a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:17:18.7196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3DxWtFIFTfxXTZ1+WvxzWNME5utsC2xMDFAOKErTsEQR56Ov/rGK39oK7E1fg+JE+N50L4/+uArSwfMoAI0+f20OyyXSywcgQIIrq+lhLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4615
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.98
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dgilbert@redhat.com, qemu-block@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Discard dirties dirty-bitmap as well as write, but works faster. Let's
> use it instead.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 6599fc6fb4..d78f81b71c 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -67,8 +67,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           os.mkfifo(fifo)
>           qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
>           qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
> -        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
> -        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
> +        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a,
> +                                                          'discard=unmap')
> +        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b,
> +                                                          'discard=unmap')
>           self.vm_b.add_incoming("exec: cat '" + fifo + "'")
>           self.vm_a.launch()
>           self.vm_b.launch()
> @@ -78,7 +80,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           self.vm_b_events = []
>   
>       def test_postcopy(self):
> -        write_size = 0x40000000
> +        discard_size = 0x40000000
>           granularity = 512
>           chunk = 4096
>   
> @@ -86,25 +88,32 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>                                  name='bitmap', granularity=granularity)
>           self.assert_qmp(result, 'return', {})
>   
> +        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
> +                               node='drive0', name='bitmap')
> +        empty_sha256 = result['return']['sha256']
> +
>           s = 0
> -        while s < write_size:
> -            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
> +        while s < discard_size:
> +            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
>               s += 0x10000
>           s = 0x8000
> -        while s < write_size:
> -            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
> +        while s < discard_size:
> +            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
>               s += 0x10000
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
>                                  node='drive0', name='bitmap')
>           sha256 = result['return']['sha256']
>   
> +        # Check, that updating the bitmap by discards works
> +        assert sha256 != empty_sha256
> +
>           result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
>                                  name='bitmap')
>           self.assert_qmp(result, 'return', {})
>           s = 0
> -        while s < write_size:
> -            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
> +        while s < discard_size:
> +            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
>               s += 0x10000
>   
>           caps = [{'capability': 'dirty-bitmaps', 'state': True},
> @@ -126,8 +135,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           self.vm_b_events.append(e_resume)
>   
>           s = 0x8000
> -        while s < write_size:
> -            self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
> +        while s < discard_size:
> +            self.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
>               s += 0x10000
>   
>           match = {'data': {'status': 'completed'}}
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

