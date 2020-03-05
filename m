Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1679C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7812721739
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mEFPZ/6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7812721739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nGX-00007N-Md
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9nFK-00076h-Gw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j9nFJ-00066j-Di
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:56:50 -0500
Received: from mail-db8eur05on20723.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::723]:25632
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j9nFF-000629-QW; Thu, 05 Mar 2020 04:56:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlxWprR5XOQNPsVBt8IXhkEM4T7s6oiMPfv3yIhz1hmo3LKenf33CCqeQoZptcZYA+KwPfRU8IrdchwaVe3Vv1msbHloMIWDO+TGVnoryVkcLZXR5N/+Jdd3qygPW4MTSCuIoJnNf8wm0mDBEwd5VnZN8RhEzeph/MbAIy2Q+uvug6dKE7qjuTx0kWMGwD1wvGA7Boq+Jebaaqb0rGz+2r08MhKpqG+IDsIoUJUT0AlGXpUkBgbpODfUCiFqWhjw+fTD7kg+o2h+yyCBqSFUNH//jGOeM6aK+/QzUcSAE+gGFx/VNeI2QqPjuitlgGcYBb6W3N1HtC5UnVGIWiCQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EGTzL0rN74otzgwGNuTNda8YfAldnhraY3VZIOfeZA=;
 b=gktqBZWzYVo6qUmEqm6HbYZ2al84Iq/SklRDwOPBNeh+pnuMcxyWqrwp9nbI6PuA13XGEddTNRigFkM95jl5igJXjcEBrFvVVusGm2bco4lAJ2SsdKW2HJCnWnEUNsJfsFCC0WgxL12f6lcnxYbRgjl0myBV/sAj6TPPuLrPxCL2GjYFJuCHiJVr/7+Fdj6fpOZakveZ0Z3IeR9bAQeTobmPY1ZV5QczLtZgnjA0f4Bz8WZcg0tW0moV3NDyEK85d1bTSrrJYctJNHXnyVYqA3KrlsFhRDIxAK5ZZZ3yDxLrZOc3TrZG8VjS6iePXuMxmpGuo2I3YLdmdYDPv4ulew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EGTzL0rN74otzgwGNuTNda8YfAldnhraY3VZIOfeZA=;
 b=mEFPZ/6tY909dRZtukj6ALfMkrPCM4FQFAHDWB9D/xlq5/g+yQK5yCvIGFP0ffxFpHbhgP+bCJoh2gL2z0Dood8lXTTDWsvtU6CwwFp81DsbINlKMKpbfehsSHoniyQYQQfThKtDt+kQPrmpI7y4df6si7Acvc+K2DBevICFmjU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3031.eurprd08.prod.outlook.com (52.135.163.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 5 Mar 2020 09:56:43 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Thu, 5 Mar 2020
 09:56:43 +0000
Subject: Re: [PATCH v5 4/5] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <20200304133538.9159-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200305125640748
Message-ID: <e95bf0d3-7caf-91a1-b8cd-615d6d1a9d9d@virtuozzo.com>
Date: Thu, 5 Mar 2020 12:56:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200304133538.9159-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0003.eurprd03.prod.outlook.com
 (2603:10a6:3:76::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0003.eurprd03.prod.outlook.com (2603:10a6:3:76::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Thu, 5 Mar 2020 09:56:42 +0000
X-Tagtoolbar-Keys: D20200305125640748
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020d8a9a-c9ca-4f2a-a9fe-08d7c0eb8202
X-MS-TrafficTypeDiagnostic: AM6PR08MB3031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3031F25417DB6F066512DBBFC1E20@AM6PR08MB3031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(366004)(39850400004)(396003)(376002)(199004)(189003)(26005)(16576012)(16526019)(36756003)(186003)(2906002)(31686004)(31696002)(316002)(478600001)(52116002)(86362001)(2616005)(8676002)(66946007)(66476007)(6486002)(8936002)(66556008)(956004)(4326008)(5660300002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3031;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIIr62Whs1zgUTpmnd1Kz8y7WmeVfmoaa3NAj3neIg+6YOGrGQOwgyM1/Q28Q+6+RH6gYth3WDxrK637iYCzgWnWsK9oPaqC2ikEmy3RCO3/duQ48oFN+XXyInVyDpV6k3O+O+oXpOhl7hfQ3DVMo75NIXXCGZGMoXeqTyctu0nZWQTQn2Mor2TYuZLWYxFtDJkY0w9DXPOdLcHnH9wPWkHpp1/1ZGFx4r+FvkFxqyaKGvIvz3bO2cDDgPmnaQlMV60LigVT+WX2JhucuzyUlhd80UNfaLAZjhLlZXDRwf3rIF/Y+I8ieaZ4joAE6RO6bYXa7hQ1NH3qtQ62pySIgtiPWzLQfNd97Pbuzsjd8+gVZjYoudbQM6+IFrlN8f21q4XPgRKUQQwKgDa7wbfjMKK7qcl91YQFsAocdx9WoHEfTaTJy5e45J0mb9RZRBtr
X-MS-Exchange-AntiSpam-MessageData: c3gK4EDTt6C4tRRvAWV4GRcquwXT0F4udc43iNJMQcMoXBC0FFa/zcsC29VS2j8TXbnuR/84v0Yw1B2Sx0VnSSHQQ38NiARGXAFdykELr3L8hviwNTYKS9R1L5CnFpiisVwFEse8/SAoc/0Bea3YqQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020d8a9a-c9ca-4f2a-a9fe-08d7c0eb8202
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 09:56:42.9053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1onOjTIyn0zMOxAwja798AU9dPL+cCEPwDNTtxigpxJ5a6UEEEz5bgM9jkJEr1xpNurp1tbxPGMV6fIYnUdpYgYL9KVzw8dz982kfX7TdPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3031
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1a::723
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.03.2020 16:35, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
> 
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
> 
> compress cmd:
>    time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>                    src.img [zlib|zstd]_compressed.img
> decompress cmd
>    time ./qemu-img convert -O qcow2
>                    [zlib|zstd]_compressed.img uncompressed.img
> 
>             compression               decompression
>           zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
> 
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Looks a bit like I've reviewed only QAPI part, when actually my r-b is for full patch...

May be

Acked-by: Markus Armbruster <armbru@redhat.com>
           [QAPI part]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

