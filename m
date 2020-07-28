Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C56C433F1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B564220786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TYmqM4RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B564220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MSY-0007lU-0P
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0MRW-0006Zt-Ty; Tue, 28 Jul 2020 06:02:43 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:20900 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0MRT-0005ti-Gy; Tue, 28 Jul 2020 06:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ4nnVyWI3OciFONBwVGQkbgf8ZaiPxLVV1jtKIGcb7ZomkvbniGrLncZLMiu7pdtHbLNJQ4uxRkXlQTSbXqHrP6ohjgkgTNyywhVtFBARp2p1Sz94bQVQDSHPeX1nnH8ZTblPK/tXVSLyB5S/tt4lRX929ptuKRwbuDVaT4hf0E8KcXAu6V85bPLn0FaPEQraDGoGJXlXeUy256pKcK94XjZGJTHs+plWUdzbT560LpWVZto85sOK01vOo5pB2FmKdoo6PrU9/mvJSTp3H+sFLG8RrntXskJ08cjOl3rYKXBnbkcMfNwDQpInYQEvHKmQOQkimliE6IK1o7AcDL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6FqBzN3099Pa1MsvBmR7+2FvInW6NN554HQxaaWPYc=;
 b=Ifud3f2gZViOFfKEhtw6NTe1XR/Qi4wfA/pTRCP6kC1+lsFO7XM/jwMeArmS/WKcreLyNboQrOFcd5SCV6pozPEIw16t5Ma65pq9yM8v9GhiCcHCexuDsT95lrzPZtpyBeEih4ciZ5qdscTBHYcm/9XdlcHXrFIv7P0xtzi9Xd46BWI2mAPkdiX7NlwoqNIpMZbn8XBd3odQIo2eg//BTpsVEaBzatV31mG5JJB3Eb4mB6cKJtPjwQOgHL9H08sUlULiURaKyTX2e+kGOHjAzD09cT1Upb25yGCske366sVaUh5x//MfQfikpjuNcdocmIydpKiDMN7DXWOdBL1fhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6FqBzN3099Pa1MsvBmR7+2FvInW6NN554HQxaaWPYc=;
 b=TYmqM4RMtqdfxXUn7F/+5A4iHiR5l/0/Nc59It0KGcu6r6xG6VFlHR/bhhGyjSzNQ4KBXjNfivo5OxEyGnbK+bYH9+W7RTja5xDeUW71wIl4qrBuvrO33NhE1Wb/3sfRhkalWKHfQnRdDZdXEiuR2HpfLGlAVsjB+Y7b0grmbUU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4407.eurprd08.prod.outlook.com (2603:10a6:20b:bd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:02:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:02:35 +0000
Subject: Re: [PATCH v11 07/11] qcow2_format.py: Dump bitmap table serialized
 entries
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-8-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6a7d6d08-af44-a804-5060-950a4494d324@virtuozzo.com>
Date: Tue, 28 Jul 2020 13:02:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594973699-781898-8-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0084.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR10CA0084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 10:02:35 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ace5800a-3fde-4e45-14a3-08d832dd5a3c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4407E0D4511B8CEF564C0576C1730@AM6PR08MB4407.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRq80cfIxu+bkmkcQp7iNmaQs4EtZJ0OT9VBlxlugm5lhV6B5Epmsx50cwjEveY0FrdzbgadlA9ttQSs9IRC4FX/rcInnr5X0pQLZ+NQ+m8XIhJrAVxS/nLAfionCIRDlMIYqs1DTC7bbPQ5awQ3yxyvGlF616pAiz31mvtz/KIkr/U8sK0MP76rDevRHdM0hg2q1zmi3r94GCgjgyfX4UW7k+a7QWeYbNNTGnFHDSTn2fa7MMa3c+rn7F3KJabrDNxHE9iWpNjHCukhIUEABZbQSusErPFqIM4w66RGybmapzGdrD/ab+T/WwNVvxLjSdPI9+tE/r3roAHXAHMo/rlHApHn6DbY8DVVugd5pX47mjaDplRYcIEOAOKKWAKT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(2906002)(8936002)(16526019)(66946007)(316002)(66556008)(66476007)(6486002)(16576012)(186003)(86362001)(4326008)(5660300002)(26005)(8676002)(83380400001)(956004)(36756003)(107886003)(31696002)(31686004)(478600001)(2616005)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: abR61MsrasoKtS3VHDqlwuBWZhMkbeCUQ4QS9mBMykw4FP5OJmQ89nZFaHv90kRu3zz21bhtFnbNYnkREEjUUCU8MXxafiWbxpy+EanmV6jSVkHJFVM9LWsuirKHN1jzWqUrU4EURXEONAkqTemCNH2HFH3dr+8uSpzV/GODvcou5lEM3azlHz9yviRD4e2cCJqf88abA5XgNrex+PL+P5nrOaBHdG7Y6mjEr+DusJn7+KMVCN/PuvpFHsWl6qFsbwhDvn0al96+NO+NZwF6z6mGRuQWnRiz0MavIzKW46cMz8bLTb5AB89FoH3YAgibfRVIH2mZjrWYChM8j7wo0a/Ay5MoLsbVKhUeJUIPYpnr3onmOksBWlji6D/86dJr87I0o8/eluQZfMCGjgrLiIrgY9LWUC/ZMQWLMUy6cpV4JWXzw96ydU8U3klQtSYTtwUvChzc4HGmSxOxpvYS0zFpmFrKv81s1dzQ6Iyf5dxpa+/qtn3f4RtLorYvZ0YV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace5800a-3fde-4e45-14a3-08d832dd5a3c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 10:02:35.6680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryBXqHuenJI+BXA+0YsYv9nxz3KklOkSD2GSkA6R40g7WL7wLvAOn0WsBitPSI/53ODoALYlFELnEDTv2j5xOZUzrA/2g2A1FfTkZoL9Wrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4407
Received-SPF: pass client-ip=40.107.7.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:36
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

17.07.2020 11:14, Andrey Shinkevich wrote:
> Add bitmap table information to the QCOW2 metadata dump.
> 
> Bitmap name               bitmap-1
> ...
> Bitmap table   type            offset                   size
> 0              serialized      4718592                  65536
> 1              serialized      4294967296               65536
> 2              serialized      5348033147437056         65536
> 3              serialized      13792273858822144        65536
> 4              serialized      4718592                  65536
> 5              serialized      4294967296               65536
> 6              serialized      4503608217305088         65536
> 7              serialized      14073748835532800        65536

big numbers seems unrelated. Did you updated commit-msg after fixing s/* 8 * 8/* 8/ bug of v10?

> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 41 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index ca0d350..ad1918c 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -175,6 +175,10 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           entry_raw_size = self.bitmap_dir_entry_raw_size()
>           padding = ((entry_raw_size + 7) & ~7) - entry_raw_size
>           fd.seek(padding, 1)
> +        self.bitmap_table = Qcow2BitmapTable(fd=fd,
> +                                             offset=self.bitmap_table_offset,
> +                                             size=self.bitmap_table_size,
> +                                             cluster_size=self.cluster_size)
>   
>       def bitmap_dir_entry_raw_size(self):
>           return struct.calcsize(self.fmt) + self.name_size + \
> @@ -183,6 +187,43 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>       def dump(self):
>           print(f'{"Bitmap name":<25} {self.name}')
>           super(Qcow2BitmapDirEntry, self).dump()
> +        self.bitmap_table.dump()
> +
> +
> +class Qcow2BitmapTableEntry:

Why not to derive it from Qcow2Struct? It will have only one field, but it will work, and we don't need to open-code loading in Qcow2BitmapTable

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

Would be good to note if reserved bits are set, as well as wrong combination of offset and all-ones bit.

> +
> +
> +class Qcow2BitmapTable:
> +
> +    def __init__(self, fd, offset, size, cluster_size):
> +        self.entries = []
> +        self.cluster_size = cluster_size
> +        table_size = size * 8

you may rename size to nb_entries, to make it obvious what "size" is (I know, that it's my idea to call it "size" in qcow2 spec. Probably bad one).

> +        position = fd.tell()
> +        fd.seek(offset)
> +        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]

this should be self.entries = [Qcow2BitmapTableEntry(fd) for _ in range(nb_entries)]

> +        fd.seek(position)
> +        for entry in table:
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
> 


-- 
Best regards,
Vladimir

