Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E603C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E43206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jhVRKh/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E43206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwAd-0000Gm-Cl
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jIw9S-0007Zw-QI
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jIw9R-0004Pn-L1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:16:34 -0400
Received: from mail-he1eur04on0730.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::730]:17734
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jIw9N-00044N-S5; Mon, 30 Mar 2020 11:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwZmu4eYliWM4BxVpTTe6RNJ0pyJHGpl+YWzORGu4lX3iTc1ow+/e2v1LX7vVI7oOqfWOMafPfxyMR+P0qHoPu2bAZHY6VGQtsZqMslWW0BDOnw78vl98ZTKiXonUZwVR8D0BalKGQtdpKfiilWnMgbaLaHxCWw0RtuU0TLjs6CI0WxOBkjgazZNubNHhiMjJyET9BbQ3PdXJ2NtE0VdYfT72Nrik2EetSuNmUivOAUVbeTAS2QiIfOdIXxp48ZdPWax78Cefc0/FBT6ygJn8yGmmqIhvImUfmbWvPbEtvhbUNKs0jOonm4J5vk8P5dUJQDQJYwZJD35qixfxF5kWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejynnf2NburSelS1uoh3gb2JEcWfJ0E/hv1KmYwN44U=;
 b=ex+A6lSeTCDwa/m5uA76kVLjxRut2LJD0VJ0921S65KHq/ifPhfKw+r+xRIppRG1d+JyUcljPZQuV18qoEn30xbEu7V99KQV51wWr04C4nhqol84Z3QZ1R34lMmitoYoQQ1Pr1318TFEhQwF14gCGIvuQV4AYEAksZVaWSvKrW2G1eFJsgr7D+1fUBqBqQ6UKq/OuxX6PLduAvAoDnLKLQ0uEUzUZ9NJUgdfGmt4fhWhiWAnYOf/MX407hdi7+S8VC1TAys9f420DgCb+5FYrdNu59r4iVH92AhTrLE6muGK1LRCO0whouPA/kfcOrvylcZ72yim5cVGQgH7qiAx2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejynnf2NburSelS1uoh3gb2JEcWfJ0E/hv1KmYwN44U=;
 b=jhVRKh/MAJGEQO/wa7Ggj/kLd3yaWKKRpbl8f1ZMmWn3Ka2a2ONPHPnA1gU6RATOHTJITUeHFUAbi7iUWCMONK22dh8Ah8Zw17TB7TqmCIcRiiIqENS59cFTstHiwPxFP7fbjJi9KY9GuP7P58MjhwSHeNQ9ijso+f0rqlM3fMA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4546.eurprd08.prod.outlook.com (20.179.36.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Mon, 30 Mar 2020 15:16:25 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:16:25 +0000
Subject: Re: [PATCH v9 1/4] qcow2: introduce compression type feature
To: Markus Armbruster <armbru@redhat.com>
References: <20200323142558.15473-1-dplotnikov@virtuozzo.com>
 <20200323142558.15473-2-dplotnikov@virtuozzo.com>
 <87imilubk9.fsf@dusky.pond.sub.org>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <23a345ef-49a8-3bfa-d75b-3a256684b245@virtuozzo.com>
Date: Mon, 30 Mar 2020 18:16:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <87imilubk9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0026.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::39) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 AM0PR06CA0026.eurprd06.prod.outlook.com (2603:10a6:208:ab::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 15:16:24 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e155cb49-9ca3-433d-98e8-08d7d4bd5025
X-MS-TrafficTypeDiagnostic: AM0PR08MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45467478853DB287A6741569CFCB0@AM0PR08MB4546.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(478600001)(6486002)(36756003)(31686004)(316002)(16576012)(2616005)(2906002)(52116002)(53546011)(6666004)(6916009)(107886003)(8936002)(5660300002)(4326008)(66476007)(186003)(66556008)(86362001)(81156014)(81166006)(66946007)(26005)(16526019)(956004)(8676002)(31696002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgfefIm8YEj5Y3vzGX0kROTMFcEStGeBbDGHstH0rYnncKUABXdDYY28HRgqiVqykafKa1awJ8JNICKNyC6m0De4tH6kc1XRBpBs+qM6TrQhCXBh02OeneTxxkqzKhYTxiShoSzUFM64/b7tTTKjkBMcuP1VkJ+4xQES3L6pJPEYoEmcCWaRMjJFOh4u5KTq0rQ2xWqEAvgxeeE7AQJP8uwCJwukaejH03Kgn8rrjEP/7RmxmTlyGm6Kxm39EUchKtfmJ5l1tqaloFZsU/y597szQHZZI5ydPJFzziI7sZNSeL3zwB4BwYi7QtA0FzSX8XO510lkooM7ilBmr8VY855V8V68xmi1U9dHx8DSY+lY9S4wLO3XvUy7tGnX+zTL1mBhNFXIFZyT4RN7TqOGrU4IVqlVwbFsP/gBkvChgIkGbwg5i93p4qz2cZ5LdGjk
X-MS-Exchange-AntiSpam-MessageData: +7E/25seIJDeJjwWxJeZwv1kB02jXv/a22hprZglaYu5f/FaxWEQXUS/raGyzpeFcu6EMtrlzSTaInhucrtA2WeVZajURWTwp2ie6kb0aMKteAutmM1LVBlRAi3k6W7c890mNa5MS18PgVBBoVZw5A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e155cb49-9ca3-433d-98e8-08d7d4bd5025
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:16:25.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+hRKzsuyLUR/4+91BNqEzSfBbZ8HgQLAmjYOOXTPeOsep1/UgxJF1MD60Z/P1p715Zbc4eyjF/uFzL9Bb992Y1Ghgs4yCiKj6YzsSWvjgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4546
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::730
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 30.03.2020 18:06, Markus Armbruster wrote:
> Denis Plotnikov <dplotnikov@virtuozzo.com> writes:
>
>> The patch adds some preparation parts for incompatible compression type
>> feature to qcow2 allowing the use different compression methods for
>> image clusters (de)compressing.
>>
>> It is implied that the compression type is set on the image creation and
>> can be changed only later by image conversion, thus compression type
>> defines the only compression algorithm used for the image, and thus,
>> for all image clusters.
>>
>> The goal of the feature is to add support of other compression methods
>> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
>>
>> The default compression is ZLIB. Images created with ZLIB compression type
>> are backward compatible with older qemu versions.
>>
>> Adding of the compression type breaks a number of tests because now the
>> compression type is reported on image creation and there are some changes
>> in the qcow2 header in size and offsets.
>>
>> The tests are fixed in the following ways:
>>      * filter out compression_type for many tests
>>      * fix header size, feature table size and backing file offset
>>        affected tests: 031, 036, 061, 080
>>        header_size +=8: 1 byte compression type
>>                         7 bytes padding
>>        feature_table += 48: incompatible feature compression type
>>        backing_file_offset += 56 (8 + 48 -> header_change + feature_table_change)
>>      * add "compression type" for test output matching when it isn't filtered
>>        affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Hmm, haven't I've seen this before?  ...  Yes, I provided my QAPI part:
> Acked-by for v5, and the QAPI part hasn't changed since.  You can save
> me a bit of labor by carrying my Acked-by forward.
For sure, next time. Thanks!
>
> Once again, QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
>


