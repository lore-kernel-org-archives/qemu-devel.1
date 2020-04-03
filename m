Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12D6C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB382073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YFF+Mcr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB382073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKK7J-00080q-MR
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKK6C-0006iZ-RV
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKK6A-0006QM-TL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:02:56 -0400
Received: from mail-eopbgr150090.outbound.protection.outlook.com
 ([40.107.15.90]:14362 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jKK6A-0006JS-4n; Fri, 03 Apr 2020 07:02:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5u9zqY7GAbh3j3NePUSZ37vFrhbCHaKdt6xA+pDWd9nKgvB05jL2LZXm77of7njoyKBUbw+aw/PExikp1mO8rS4Ub+QFiqM91oQrnndR/dfYXDxGspR/yBMlPU9wi3lCnpsmGuR0w0//h0L3sofmoZWA/epG1LyXNC5LmDZhZAl7cL+nUkAESDNAsn9Qg+OG3r3cjEXR12bvQJI8+R0t0O3RYYKHRmbinpVIlk+v5zCnIJVyFgoza9+hZW2VU98dSUsUUgrzt4waLw4YXx0M/4CnbDMntg7c3+lASAHLzMKLaoZU5r5WfJL024wRYkka2JXtOqEuUiY2+Xc2w77wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/IPxvaof95mWY83uJ7xe0fRVeRPLCfr+sfh1hX6V8U=;
 b=adDXA0AaGg0/CroKGRKsgoVHkMFr9Bvecg5E5XAYP1H7mzcSIO3BF3XQedWpqEm0x+UvFd1AQKCWEUqwXvm7Ai9RPQMji87dtrcEBuSkLeAEzbbditmcKAdpKuUn8v7d6I3k4EtaMj4XlJu0Q93GXqM6jdtL+c/3YtCPDEEuxKlCtNMWwlX4HEAyeWlZbs4qY8FLlbO8ScO2xDDf6GFWiKuxO17vgrEFqaILgn4gMZKNNyXERRZ+hO8eN+QTsCNwy4+V8BDluF9WWVm2oIJdMpgPkXenTE7TJLbhEGE2/zwBj25EO6H7quBB4ey3dx6hEt7BIW3on6JsbRwoDlau6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/IPxvaof95mWY83uJ7xe0fRVeRPLCfr+sfh1hX6V8U=;
 b=YFF+Mcr6ZcLV1HXIRQPkuGUcmeMLt787fbDbrB8MQ3g4n5o2TxNcHWPprApY1eXZ84SEuwc2OrQS2p6AZfNG6YJXejpgmfaLYth7xnjzefolebmYRItHq7WGduGV7Q7KdFYh1wj3K5SP/aI9TuKhpUlt1IkphCoHnnLtdAg4s+I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5381.eurprd08.prod.outlook.com (10.141.172.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Fri, 3 Apr 2020 11:02:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 11:02:50 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200403140247591
Message-ID: <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
Date: Fri, 3 Apr 2020 14:02:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20191219103638.GJ4914@andariel.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.62) by
 AM4PR05CA0034.eurprd05.prod.outlook.com (2603:10a6:205::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Fri, 3 Apr 2020 11:02:49 +0000
X-Tagtoolbar-Keys: D20200403140247591
X-Originating-IP: [185.215.60.62]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ae723a3-2924-4388-b13e-08d7d7be8c87
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381F923A1C7FB9B96599118C1C70@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(39840400004)(346002)(396003)(136003)(376002)(478600001)(316002)(956004)(8936002)(36756003)(31686004)(52116002)(2616005)(16526019)(81156014)(8676002)(966005)(26005)(6486002)(81166006)(186003)(5660300002)(16576012)(53546011)(86362001)(4326008)(6916009)(31696002)(66556008)(66476007)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfyw1JdSfSxcHTNRsRQWoHYNPy8yKnLNYe4h/J8JhvKzYi7Hw0SqHKDCGAHd7xiD4yCOGTpWsPzfSEmwvFKG68IynQHcdL6mjYQMqgw856vlNdMLSsrNHpFRqRO5iExFl7BJJFDu1gZokhakbq4NUF0ioErMkFMQu9EvSeFqSXshzu+J6n/XAjrFmR8Mbdgt0hgCrjHX53XZMdWBkqVRbk8QFLTY8HmLORUwKI1iIJ8jR+A6+QQDb+7kUoCnUJsx4EXyNcxSl+hiTB1Jjr33IErUkieYQCfeMHOhr3Wi3lZenlTcYX59so949H/4gsK0QhKHOkPVicOROvxWnzJQZL4ZoK9BWYnKOL7JfsUBKcrz2eKwBY93JgczzgT30jQ9SdvrIiZioa0WsrKjCZuSXoBl8cD8SkQZwIeko2SU+2zanxTOJA/Vm1prLicnHa8VPrH1WP2AtptVSVS9MnerCOJTEgHeeRSn5TX8auTl5KoDff+k6Mvp5Fnm/Nu7ccPKxtbCRIktLXxnzXWpXVS6jQ==
X-MS-Exchange-AntiSpam-MessageData: vsVQcJ+kvKfQMczNl9RUBZL2VQPPYbbYUHIqUllL7L2l+j7z0FI202YJqffuwccY4BNHjOEtgT7E1ZbxEZIVUMKvTIIHJVMCEAXvhyRrL7xroaPBnWDSO+b460Xw9vkrqrBU97e6r0+xKB5+QDmRmA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae723a3-2924-4388-b13e-08d7d7be8c87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 11:02:50.1210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiJzp6oTz4pnDuFWx6hSgutceyle45dt6b/06V4OZ85kQ/cu4mo/5dNxrtXNeAuAYhvKWeaBQIbWkOe/7lPte7GyiZTZnd68/toLiTgLiQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.15.90
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.12.2019 13:36, Peter Krempa wrote:
> On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> It's a continuation for
>> "bitmap migration bug with -drive while block mirror runs"
>> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>>
>> The problem is that bitmaps migrated to node with same node-name or
>> blk-parent name. And currently only the latter actually work in libvirt.
>> And with mirror-top filter it doesn't work, because
>> bdrv_get_device_or_node_name don't go through filters.
> 
> I want to point out that since libvirt-5.10 we use -blockdev to
> configure the backend of storage devices with qemu-4.2 and later. This
> means unfortunately that the BlockBackend of the drive does not have a
> name any more and thus the above will not work even if you make the
> lookup code to see through filters.

Not that this series doesn't make things worse, as it loops through named
block backends when trying to use their name for migration. So with these
patches applied, qemu will just work in more possible scenarios.

> 
> As I've pointed out separately node-names are not good idea to use for
> matching either as they can be distinct on the destination of migration.
> 
> Having same node names for images during migration was not documented as
> a requiremend and even if it was the case when the mirror job is used
> the destination is a different image and thus having a different node
> name is expected.
> 
> Since it's not documented, expect the same situation as with
> autogenerated nodenames, the destination may have different node-names
> and the same node-name may refer to a different image. Implicit matching
> based on node-names is thus impossible.
> 


-- 
Best regards,
Vladimir

