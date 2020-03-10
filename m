Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8BC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C47F20675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QPpoZ/fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C47F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgS1-0008AN-9p
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBgIE-0008TL-TT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBgID-0003vM-7p
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:55:38 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:46318 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jBgIC-0003p7-HS; Tue, 10 Mar 2020 10:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKMvk6klje7gQLiZhEYXuhiVkN22h4g2iQW0WaQWZUMlupPyHF2QHugUQ+BQCe8w1V9GUfSuwJVbzv2QbFAO9XEki0sjLFMl3sIEvLCwZY1kaLSCainMZHXuT0lF7mDn+H7s32bU0YafwXbBohD5ZhDhdF6vwSjrRj0Ow0y5J4MZPgkX9BL7zr2laT41FBuNcwejcZCNJMZCOuuSJRuva0WVlZKs2s+bt81IEqtFEAmbJVyaN7LrSM/OUjXhQkQ2ya1AzsYwHCK9PkGFFLlGi2V4YPuAuv7s4nNI6xUEd11zaDQYLZtdrIBZS7eeBpvVtBUGw/8aa4dQ1fgpmmsSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v05jTBMkbGbgR99xFJN9Zq/PgC7NflE5Q663MmukdJY=;
 b=FLG2xi0IZhCsLYsZHCVzGtXle+J3GUs+YfEML6oE9o+CAv6qocpz/z8x/CCa95MTK+cd3vp6RCLi6sxNhpi5tLoAwEPreZf05MdzkscPfHVHADPx3PP+xWhjzo3ddZn7SSrSNwlQrYcfPjPyz0kEsHHUHWZet1S5Zvn2AMgWhiMWmu22IzQ/6bEicNVYE6wjwVnnkCDyttrB4t7CyV/E/OM1TkGKpKajX48cdQcTsXo+lLwmB96BF7/jx923rf2UiVUktUTb8Oacm08mhK0ZHCyqhd/Vd0PvZwry8QxXDdPgUaApdyH1NRx0kT0g17UPAoPCdLlQ1nmShI9R2822Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v05jTBMkbGbgR99xFJN9Zq/PgC7NflE5Q663MmukdJY=;
 b=QPpoZ/fAJQc8Ox7zGzSNb/nv6xvuX+fdK6MpiTKiSZrjgcwN4+V5ugy6HTBeBScP0YlpQbYiA3/9Rgd+UWOBIpJL2+I6UodRm5dLD2iHAFl+ABWOu7xM/33ZRW4+OFgL3TCLG64PR5WQdAWb/k4xj0BsJAVIpM7NeoSrOpMyiHM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3989.eurprd08.prod.outlook.com (20.179.3.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 14:55:33 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 14:55:33 +0000
Subject: Re: [PATCH v3 7/9] block/block-copy: rename start to offset in
 interfaces
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-8-vsementsov@virtuozzo.com>
 <826a06c1-49d0-24a0-4098-fc0ec8f9f5a0@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <5b30a84f-3b03-d894-f908-b0fae89615d5@virtuozzo.com>
Date: Tue, 10 Mar 2020 17:55:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <826a06c1-49d0-24a0-4098-fc0ec8f9f5a0@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0902CA0007.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::17) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR0902CA0007.eurprd09.prod.outlook.com (2603:10a6:3:e5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 14:55:32 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed00f732-f708-45e0-871e-08d7c503155a
X-MS-TrafficTypeDiagnostic: AM6PR08MB3989:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3989B35AA825E4F4712817C6F4FF0@AM6PR08MB3989.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39850400004)(136003)(346002)(396003)(199004)(189003)(478600001)(4326008)(36756003)(66476007)(8676002)(956004)(2616005)(53546011)(2906002)(36916002)(66946007)(86362001)(52116002)(44832011)(31686004)(66556008)(31696002)(186003)(16526019)(110136005)(26005)(6486002)(16576012)(81166006)(5660300002)(81156014)(316002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3989;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWMb+ig7+SAqpTcbVQ9YpawFMUUDkubqnfAsHSsZ/9CJo6BbNrod+/DpGzqZ1LIMnfeBMSxKduAgLmoTagZyvo9Y/6oM1LrEv+bWgadhTyk9UVi1pf+7no6KR6I3Hm/IBy8R2e86PGRx2NPOC3/83SPKBQcQ97UlNO+fbuhoVy+vDq72ERNJx81Iyo2pTUmkpVaSQG9CZC9yLE/Am27cReRakJbzsDmwNnNp2MRE/DZSUsovEXkLjvUxNTOAZlpwIdohfN7vv87+fpZHEQfIgQNmDmlCZxYroa3gm2JUuN16kLp1AA+igBonuOYU5RrT+FmyvZVngyM11XM13MCoksmXuXSSmcA3TQpSYUGl+byVsWJnzO/kKWRMpSN+X2R2Voz+eO4tow47KH7fMIR5xhoaGhFzSQ/BVlArIh5WObFmZHsiP6ujhA4PkOLAfUjr
X-MS-Exchange-AntiSpam-MessageData: PtYFo2wVOT9qR2jRMFRDWWJZFBqmG9vLwxOa+e7iLFF7b4XXF8UgYzbBMe9ArrEnT1VjFZsxrKWhWOul/70TDLtEA4O9vj/+043zG1eMCbFpSYOdhvarDmDHvZF/Vi+epVjdF1+pPBLyP2RLapVWwA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed00f732-f708-45e0-871e-08d7c503155a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 14:55:33.1231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf1WcOSX6NZOtRGDHa8XuItBxtrcw0QcIMTCgdcS9/z0bgwRDK1WsHTwdXXsToeCl2so5mwx0RC9qpT17rsvU1iBc5xjgdYyjTk7GETgEb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3989
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.94
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/03/2020 17:50, Max Reitz wrote:
> On 06.03.20 08:38, Vladimir Sementsov-Ogievskiy wrote:
>> offset/bytes pair is more usual naming in block layer, let's use it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block-copy.h |  4 +-
>>   block/block-copy.c         | 84 +++++++++++++++++++-------------------
>>   2 files changed, 44 insertions(+), 44 deletions(-)
>=20
> [...]
>=20
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 4c947e548b..2b29131653 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -25,13 +25,13 @@
>>   #define BLOCK_COPY_MAX_MEM (128 * MiB)
>>  =20
>>   static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopySt=
ate *s,
>> -                                                           int64_t star=
t,
>> -                                                           int64_t byte=
s)
>> +                                                          int64_t offse=
t,
>> +                                                          int64_t bytes=
)
>=20
> The alignment=92s off now.
>=20
> Max
>=20

After applying the patch, it looks aligned in my vim editor.
--=20
With the best regards,
Andrey Shinkevich


